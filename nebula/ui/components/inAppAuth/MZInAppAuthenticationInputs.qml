/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.5
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import compat 0.1

import Mozilla.Shared 1.0
import components 0.1
import components.forms 0.1

ColumnLayout {
    id: base
    property string _inputPlaceholderText: ""
    property string _inputErrorMessage: ""
    property alias _inputMethodHints: textInput.inputMethodHints
    property var _buttonOnClicked
    property alias _buttonEnabled: btn.enabled
    property alias _buttonText: btn.text
    property bool _isSignUpOrIn: MZAuthInApp.state === MZAuthInApp.StateSignIn || MZAuthInApp.state === MZAuthInApp.StateSigningIn || MZAuthInApp.state === MZAuthInApp.StateSignUp || MZAuthInApp.state === MZAuthInApp.StateSigningUp

    function activeInput() {
        return _isSignUpOrIn ? passwordInput : textInput
    }

    function disableActiveInput() {
        activeInput().enabled = false;
    }

    Component.onCompleted: if (typeof(authError) === "undefined" || !authError.visible) activeInput().forceActiveFocus();

    spacing: MZTheme.theme.vSpacing - MZTheme.theme.listSpacing

    ColumnLayout {
        function submitInfo(input) {
            if (!input.hasError && input.text.length > 0 && btn.enabled)
            {
                disableActiveInput();
                btn.clicked();
            }
        }

        id: col

        spacing: MZTheme.theme.listSpacing

        RowLayout {
            Layout.fillWidth: true
            spacing: MZTheme.theme.windowMargin / 2

            MZTextField {
                id: textInput
                objectName: base.objectName + "-textInput"
                Layout.fillWidth: true
                _placeholderText: _inputPlaceholderText
                Keys.onReturnPressed: col.submitInfo(textInput)
                onDisplayTextChanged: if (hasError) hasError = false
            }

            MZPasswordInput {
                id: passwordInput
                objectName: base.objectName + "-passwordInput"
                _placeholderText: _inputPlaceholderText
                Keys.onReturnPressed: col.submitInfo(passwordInput)
                Layout.fillWidth: true
                onTextChanged: if (hasError) hasError = false
            }

            MZPasteButton {
                id: inputPasteButton
                objectName: base.objectName + "-inputPasteButton"
                Layout.preferredWidth: MZTheme.theme.rowHeight
                Layout.preferredHeight: MZTheme.theme.rowHeight
                height: undefined
                width: undefined
                onClicked: {
                   activeInput().paste();
                   activeInput().forceActiveFocus();
                }
            }
        }


        ToolTip {
            property bool _isSignUp: MZAuthInApp.state === MZAuthInApp.StateSignUp
            id: toolTip
            visible: _isSignUp && passwordInput.text.length > 0 && passwordInput.activeFocus
            padding: MZTheme.theme.windowMargin
            x: MZTheme.theme.vSpacing
            y: passwordInput.y - height - 4
            width: passwordInput.width - MZTheme.theme.vSpacing
            height: passwordConditions.implicitHeight + padding * 2
            background: Rectangle { color: MZTheme.theme.transparent }

            Rectangle {
                id: bg
                anchors.fill: passwordConditions
                anchors.margins: MZTheme.theme.windowMargin * -1
                color: MZTheme.colors.white
                radius: MZTheme.theme.cornerRadius

                MZRectangularGlow {
                    anchors.fill: glowVector
                    glowRadius: 4
                    spread: .3
                    color: MZTheme.theme.divider
                    cornerRadius: glowVector.radius + glowRadius
                    z: -2
                }

                Rectangle {
                    id: glowVector
                    anchors.fill: parent
                    radius: bg.radius
                    color: bg.color
                }

                Rectangle {
                    radius: 1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -3
                    anchors.right: parent.right
                    anchors.rightMargin: MZTheme.theme.windowMargin
                    width: MZTheme.theme.windowMargin / 2
                    height: MZTheme.theme.windowMargin / 2
                    color: parent.color
                    rotation: 45
                }
            }

            ColumnLayout {
                id: passwordConditions
                spacing: MZTheme.theme.windowMargin / 2
                anchors.right: parent.right
                width: parent.width

                MZInAppAuthenticationPasswordCondition {
                    id: passwordLength
                    objectName: base.objectName + "-passwordConditionLength"
                    _iconVisible: true
                    _passwordConditionIsSatisfied: toolTip._isSignUp && MZAuthInApp.validatePasswordLength(passwordInput.text)
                    _passwordConditionDescription: MZI18n.InAppAuthPasswordHintCharacterLength
                }
                MZInAppAuthenticationPasswordCondition {
                    objectName: base.objectName + "-passwordConditionEmailAddress"
                    _iconVisible: passwordLength._passwordConditionIsSatisfied
                    _passwordConditionIsSatisfied: toolTip._isSignUp && passwordLength._passwordConditionIsSatisfied && MZAuthInApp.validatePasswordEmail(passwordInput.text)
                    _passwordConditionDescription: MZI18n.InAppAuthPasswordHintEmailAddressAsPassword
                    opacity: passwordLength._passwordConditionIsSatisfied ? 1 : .5
                }
                MZInAppAuthenticationPasswordCondition {
                    objectName: base.objectName + "-passwordConditionCommon"
                    _iconVisible:  passwordLength._passwordConditionIsSatisfied
                    _passwordConditionIsSatisfied: toolTip._isSignUp && passwordLength._passwordConditionIsSatisfied && MZAuthInApp.validatePasswordCommons(passwordInput.text)
                    _passwordConditionDescription: MZI18n.InAppAuthPasswordHintCommonPassword
                    opacity: _iconVisible ? 1 : .5
                }
            }
        }

        MZContextualAlerts {
            id: inputErrors
            anchors.left: undefined
            anchors.right: undefined
            anchors.topMargin: undefined
            Layout.minimumHeight: MZTheme.theme.vSpacing
            Layout.fillHeight: false

            messages: [
                {
                    type: "error",
                    message: base._inputErrorMessage,
                    visible: activeInput().hasError
                }
            ]
        }
    }

    states: [
        State {
            name: "auth-start"
            when: MZAuthInApp.state === MZAuthInApp.StateStart ||
                  MZAuthInApp.state === MZAuthInApp.StateCheckingAccount
            PropertyChanges {
                target: textInput
                visible: true
            }
            PropertyChanges {
                target: inputPasteButton
                visible: false
            }
            PropertyChanges {
                target: passwordInput
                visible: false
            }
        },
        State {
            when: MZAuthInApp.state === MZAuthInApp.StateUnblockCodeNeeded ||
                  MZAuthInApp.state === MZAuthInApp.StateVerifyingUnblockCode ||
                  MZAuthInApp.state === MZAuthInApp.StateVerificationSessionByEmailNeeded ||
                  MZAuthInApp.state === MZAuthInApp.StateVerifyingSessionEmailCode ||
                  MZAuthInApp.state === MZAuthInApp.StateVerificationSessionByTotpNeeded ||
                  MZAuthInApp.state === MZAuthInApp.StateVerifyingSessionTotpCode
            extend: "auth-start"
            PropertyChanges {
                target: inputPasteButton
                visible: true
            }
        },

        State {
            when: MZAuthInApp.state === MZAuthInApp.StateSignUp || MZAuthInApp.state === MZAuthInApp.StateSigningUp ||
                  MZAuthInApp.state === MZAuthInApp.StateSignIn || MZAuthInApp.state === MZAuthInApp.StateSigningIn
            PropertyChanges {
                target: textInput
                visible: false
            }
            PropertyChanges {
                target: passwordInput
                visible: true
            }
        }
    ]

    MZButton {
        id: btn
        objectName: base.objectName + "-button"
        Layout.fillWidth: true
        loaderVisible:  MZAuthInApp.state === MZAuthInApp.StateCheckingAccount ||
                        MZAuthInApp.state === MZAuthInApp.StateSigningIn ||
                        MZAuthInApp.state === MZAuthInApp.StateSigningUp ||
                        MZAuthInApp.state === MZAuthInApp.StateVerifyingSessionEmailCode ||
                        MZAuthInApp.state === MZAuthInApp.StateVerifyingSessionTotpCode
        onClicked: {
            disableActiveInput();
            _buttonOnClicked(activeInput().text);
        }
        width: undefined

    }


    Connections {
        target: MZAuthInApp
        function onErrorOccurred(e, retryAfter) {
            switch(e) {
            case MZAuthInApp.ErrorIncorrectPassword:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "IncorrectPassword" });
                Glean.sample.authenticationError.record({ reason: "IncorrectPassword" });

                base._inputErrorMessage =  MZI18n.InAppAuthInvalidPasswordErrorMessage;
                activeInput().forceActiveFocus();
                break;
            case MZAuthInApp.ErrorInvalidEmailAddress:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "InvalidEmail" });
                Glean.sample.authenticationError.record({ reason: "InvalidEmail" });

                base._inputErrorMessage =  MZI18n.InAppAuthInvalidEmailErrorMessage;
                activeInput().forceActiveFocus();
                break;
            case MZAuthInApp.ErrorInvalidOrExpiredVerificationCode:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "InvalidOrExpiredVerificationCode" });
                Glean.sample.authenticationError.record({ reason: "InvalidOrExpiredVerificationCode" });

                base._inputErrorMessage = MZI18n.InAppAuthInvalidCodeErrorMessage;
                activeInput().forceActiveFocus();
                break;

            case MZAuthInApp.ErrorInvalidTotpCode:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "InvalidTotpCode" });
                Glean.sample.authenticationError.record({ reason: "InvalidTotpCode" });

                base._inputErrorMessage = MZI18n.InAppAuthInvalidCodeErrorMessage;
                activeInput().forceActiveFocus();
                break;

            case MZAuthInApp.ErrorInvalidUnblockCode:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "InvalidUnblockCode" });
                Glean.sample.authenticationError.record({ reason: "InvalidUnblockCode" });

                base._inputErrorMessage = MZI18n.InAppAuthInvalidCodeErrorMessage;
                activeInput().forceActiveFocus();
                break;
            case MZAuthInApp.ErrorConnectionTimeout:
                MZGleanDeprecated.recordGleanEventWithExtraKeys("authenticationError", { "reason": "Timeout" });
                Glean.sample.authenticationError.record({ reason: "Timeout" });

                // In case of a timeout we want to exit here 
                // to skip setting hasError - so the user can retry instantly
                activeInput().enabled = true;
                return;
            }

            if (!authError.visible)
                activeInput().forceActiveFocus();
            activeInput().hasError = true;
            activeInput().enabled = true;
        }
    }
}
