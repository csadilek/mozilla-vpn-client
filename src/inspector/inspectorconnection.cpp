/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "inspectorconnection.h"
#include "leakdetector.h"
#include "logger.h"
#include "mozillavpn.h"
#include "qmlengineholder.h"

#include <QQuickItem>
#include <QQuickWindow>
#include <QWebSocket>
#include <QTest>

namespace {
Logger logger(LOG_INSPECTOR, "InspectorConnection");
QUrl s_lastUrl;
}  // namespace

InspectorConnection::InspectorConnection(QObject* parent,
                                         QWebSocket* connection)
    : QObject(parent), m_connection(connection) {
  MVPN_COUNT_CTOR(InspectorConnection);

  logger.log() << "New connection received";

  Q_ASSERT(m_connection);
  connect(m_connection, &QWebSocket::textMessageReceived, this,
          &InspectorConnection::textMessageReceived);
  connect(m_connection, &QWebSocket::binaryMessageReceived, this,
          &InspectorConnection::binaryMessageReceived);
}

InspectorConnection::~InspectorConnection() {
  MVPN_COUNT_DTOR(InspectorConnection);
  logger.log() << "Connection released";
}

void InspectorConnection::textMessageReceived(const QString& message) {
  logger.log() << "Text message received";
  parseCommand(message.toLocal8Bit());
}

void InspectorConnection::binaryMessageReceived(const QByteArray& message) {
  logger.log() << "Binary message received";
  parseCommand(message);
}

void InspectorConnection::parseCommand(const QByteArray& command) {
  logger.log() << "command received: " << command;

  if (command.isEmpty()) {
    return;
  }

  QList<QByteArray> parts = command.split(' ');
  Q_ASSERT(!parts.isEmpty());

  if (parts[0].trimmed() == "reset") {
    if (parts.length() != 1) {
      tooManyArguments(0);
      return;
    }

    m_connection->sendTextMessage("ok");
    MozillaVPN::instance()->reset();
    return;
  }

  if (parts[0].trimmed() == "quit") {
    if (parts.length() != 1) {
      tooManyArguments(0);
      return;
    }

    m_connection->sendTextMessage("ok");
    MozillaVPN::instance()->controller()->quit();
    return;
  }

  if (parts[0].trimmed() == "has") {
    if (parts.length() != 2) {
      tooManyArguments(1);
      return;
    }

    QQuickItem* obj = findObject(parts[1]);
    if (!obj) {
      m_connection->sendTextMessage("ko");
      return;
    }

    m_connection->sendTextMessage("ok");
    return;
  }

  if (parts[0].trimmed() == "property") {
    if (parts.length() != 3) {
      tooManyArguments(2);
      return;
    }

    QQuickItem* obj = findObject(parts[1]);
    if (!obj) {
      m_connection->sendTextMessage("ko");
      return;
    }

    QVariant property = obj->property(parts[2]);
    if (!property.isValid()) {
      m_connection->sendTextMessage("ko");
      return;
    }

    m_connection->sendTextMessage(
        QString("-%1-").arg(property.toString().toHtmlEscaped()).toLocal8Bit());
    return;
  }

  if (parts[0].trimmed() == "click") {
    if (parts.length() != 2) {
      tooManyArguments(1);
      return;
    }

    QQuickItem* obj = findObject(parts[1]);
    if (!obj) {
      m_connection->sendTextMessage("ko");
      return;
    }

    QPointF pointF = obj->mapToScene(QPoint(0, 0));
    QPoint point = pointF.toPoint();
    point.rx() += obj->width() / 2;
    point.ry() += obj->height() / 2;
    QTest::mouseClick(obj->window(), Qt::LeftButton, Qt::NoModifier, point);

    m_connection->sendTextMessage("ok");
    return;
  }

  if (parts[0].trimmed() == "lasturl") {
    if (parts.length() != 1) {
      tooManyArguments(0);
      return;
    }

    m_connection->sendTextMessage(
        QString("-%1-").arg(s_lastUrl.toString()).toLocal8Bit());
    return;
  }

  m_connection->sendTextMessage("invalid command");
}

void InspectorConnection::tooManyArguments(int arguments) {
  m_connection->sendTextMessage(
      QString("too many arguments (%1 expected)").arg(arguments).toLocal8Bit());
}

QQuickItem* InspectorConnection::findObject(const QString& name) {
  QStringList parts = name.split("/");
  Q_ASSERT(!parts.isEmpty());

  QQuickItem* parent = nullptr;
  QQmlApplicationEngine* engine = QmlEngineHolder::instance()->engine();
  for (QObject* rootObject : engine->rootObjects()) {
    if (!rootObject) {
      continue;
    }

    parent = rootObject->findChild<QQuickItem*>(parts[0]);
    if (parent) {
      break;
    }
  }

  if (!parent || parts.length() == 1) {
    return parent;
  }

  for (int i = 1; i < parts.length(); ++i) {
    QQuickItem* contentItem =
        parent->property("contentItem").value<QQuickItem*>();
    QList<QQuickItem*> contentItemChildren = contentItem->childItems();

    bool found = false;
    for (QQuickItem* item : contentItemChildren) {
      if (item->objectName() == parts[i]) {
        parent = item;
        found = true;
        break;
      }
    }

    if (!found) {
      return nullptr;
    }
  }

  return parent;
}

// static
void InspectorConnection::setLastUrl(const QUrl& url) { s_lastUrl = url; }
