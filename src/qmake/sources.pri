# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

SOURCES += \
        addons/addon.cpp \
        addons/addonapi.cpp \
        addons/addonguide.cpp \
        addons/addoni18n.cpp \
        addons/addonmessage.cpp \
        addons/addonproperty.cpp \
        addons/addonpropertylist.cpp \
        addons/addontutorial.cpp \
        addons/conditionwatchers/addonconditionwatcher.cpp \
        addons/conditionwatchers/addonconditionwatcherfeaturesenabled.cpp \
        addons/conditionwatchers/addonconditionwatchergroup.cpp \
        addons/conditionwatchers/addonconditionwatcherjavascript.cpp \
        addons/conditionwatchers/addonconditionwatcherlocales.cpp \
        addons/conditionwatchers/addonconditionwatchertime.cpp \
        addons/conditionwatchers/addonconditionwatchertriggertimesecs.cpp \
        addons/manager/addondirectory.cpp \
        addons/manager/addonindex.cpp \
        addons/manager/addonmanager.cpp \
        apppermission.cpp \
        authenticationlistener.cpp \
        authenticationinapp/authenticationinapp.cpp \
        authenticationinapp/authenticationinapplistener.cpp \
        authenticationinapp/authenticationinappsession.cpp \
        authenticationinapp/incrementaldecoder.cpp \
        captiveportal/captiveportal.cpp \
        captiveportal/captiveportaldetection.cpp \
        captiveportal/captiveportaldetectionimpl.cpp \
        captiveportal/captiveportalmonitor.cpp \
        captiveportal/captiveportalnotifier.cpp \
        captiveportal/captiveportalrequest.cpp \
        captiveportal/captiveportalrequesttask.cpp \
        collator.cpp \
        command.cpp \
        commandlineparser.cpp \
        commands/commandactivate.cpp \
        commands/commanddeactivate.cpp \
        commands/commanddevice.cpp \
        commands/commandlogin.cpp \
        commands/commandlogout.cpp \
        commands/commandselect.cpp \
        commands/commandservers.cpp \
        commands/commandstatus.cpp \
        commands/commandui.cpp \
        composer/composer.cpp \
        composer/composerblock.cpp \
        composer/composerblockbutton.cpp \
        composer/composerblocktext.cpp \
        composer/composerblocktitle.cpp \
        composer/composerblockorderedlist.cpp \
        composer/composerblockunorderedlist.cpp \
        connectionbenchmark/benchmarktask.cpp \
        connectionbenchmark/benchmarktaskping.cpp \
        connectionbenchmark/benchmarktasktransfer.cpp \
        connectionbenchmark/connectionbenchmark.cpp \
        connectionbenchmark/uploaddatagenerator.cpp \
        connectionhealth.cpp \
        constants.cpp \
        controller.cpp \
        cryptosettings.cpp \
        curve25519.cpp \
        dnshelper.cpp \
        dnspingsender.cpp \
        errorhandler.cpp \
        externalophandler.cpp \
        filterproxymodel.cpp \
        fontloader.cpp \
        frontend/navigator.cpp \
        frontend/navigatorreloader.cpp \
        glean/glean.cpp \
        glean/private/event.cpp \
        glean/private/ping.cpp \
        hacl-star/Hacl_Chacha20.c \
        hacl-star/Hacl_Chacha20Poly1305_32.c \
        hacl-star/Hacl_Curve25519_51.c \
        hacl-star/Hacl_Poly1305_32.c \
        hawkauth.cpp \
        keyregenerator.cpp \
        hkdf.cpp \
        imageproviderfactory.cpp \
        inspector/inspectorhandler.cpp \
        inspector/inspectoritempicker.cpp \
        inspector/inspectorutils.cpp \
        inspector/inspectorwebsocketconnection.cpp \
        inspector/inspectorwebsocketserver.cpp \
        ipaddress.cpp \
        ipaddresslookup.cpp \
        itempicker.cpp \
        leakdetector.cpp \
        localizer.cpp \
        logger.cpp \
        loghandler.cpp \
        logoutobserver.cpp \
        main.cpp \
        models/device.cpp \
        models/devicemodel.cpp \
        models/feature.cpp \
        models/featuremodel.cpp \
        models/feedbackcategorymodel.cpp \
        models/keys.cpp \
        models/licensemodel.cpp \
        models/recentconnections.cpp \
        models/server.cpp \
        models/servercity.cpp \
        models/servercountry.cpp \
        models/servercountrymodel.cpp \
        models/serverdata.cpp \
        models/subscriptiondata.cpp \
        models/supportcategorymodel.cpp \
        models/user.cpp \
        mozillavpn.cpp \
        networkmanager.cpp \
        networkrequest.cpp \
        networkwatcher.cpp \
        notificationhandler.cpp \
        pinghelper.cpp \
        pingsender.cpp \
        pingsenderfactory.cpp \
        platforms/dummy/dummyapplistprovider.cpp \
        platforms/dummy/dummynetworkwatcher.cpp \
        platforms/dummy/dummypingsender.cpp \
        productshandler.cpp \
        purchasehandler.cpp \
        purchaseiaphandler.cpp \
        purchasewebhandler.cpp \
        profileflow.cpp \
        qmlengineholder.cpp \
        releasemonitor.cpp \
        rfc/rfc1112.cpp \
        rfc/rfc1918.cpp \
        rfc/rfc4193.cpp \
        rfc/rfc4291.cpp \
        rfc/rfc5735.cpp \
        serveri18n.cpp \
        serverlatency.cpp \
        settingsholder.cpp \
        signature.cpp \
        simplenetworkmanager.cpp \
        statusicon.cpp \
        tasks/account/taskaccount.cpp \
        tasks/adddevice/taskadddevice.cpp \
        tasks/addon/taskaddon.cpp \
        tasks/addonindex/taskaddonindex.cpp \
        tasks/authenticate/taskauthenticate.cpp \
        tasks/captiveportallookup/taskcaptiveportallookup.cpp \
        tasks/deleteaccount/taskdeleteaccount.cpp \
        tasks/getfeaturelist/taskgetfeaturelist.cpp \
        tasks/getsubscriptiondetails/taskgetsubscriptiondetails.cpp \
        tasks/controlleraction/taskcontrolleraction.cpp \
        tasks/createsupportticket/taskcreatesupportticket.cpp \
        tasks/function/taskfunction.cpp \
        tasks/group/taskgroup.cpp \
        tasks/heartbeat/taskheartbeat.cpp \
        tasks/ipfinder/taskipfinder.cpp \
        tasks/products/taskproducts.cpp \
        tasks/release/taskrelease.cpp \
        tasks/removedevice/taskremovedevice.cpp \
        tasks/sendfeedback/tasksendfeedback.cpp \
        tasks/servers/taskservers.cpp \
        taskscheduler.cpp \
        telemetry.cpp \
        temporarydir.cpp \
        theme.cpp \
        tutorial/tutorial.cpp \
        tutorial/tutorialstep.cpp \
        tutorial/tutorialstepbefore.cpp \
        tutorial/tutorialstepnext.cpp \
        update/updater.cpp \
        update/versionapi.cpp \
        urlopener.cpp \
        update/webupdater.cpp \
        websocket/exponentialbackoffstrategy.cpp \
        websocket/pushmessage.cpp \
        websocket/websockethandler.cpp

HEADERS += \
        addons/addon.h \
        addons/addonapi.h \
        addons/addonguide.h \
        addons/addoni18n.h \
        addons/addonmessage.h \
        addons/addonproperty.h \
        addons/addonpropertylist.h \
        addons/addontutorial.h \
        addons/conditionwatchers/addonconditionwatcher.h \
        addons/conditionwatchers/addonconditionwatcherfeaturesenabled.h \
        addons/conditionwatchers/addonconditionwatchergroup.h \
        addons/conditionwatchers/addonconditionwatcherjavascript.h \
        addons/conditionwatchers/addonconditionwatcherlocales.h \
        addons/conditionwatchers/addonconditionwatchertime.h \
        addons/conditionwatchers/addonconditionwatchertimeend.h \
        addons/conditionwatchers/addonconditionwatchertimestart.h \
        addons/conditionwatchers/addonconditionwatchertriggertimesecs.h \
        addons/manager/addondirectory.h \
        addons/manager/addonindex.h \
        addons/manager/addonmanager.h \
        appimageprovider.h \
        apppermission.h \
        applistprovider.h \
        authenticationlistener.h \
        authenticationinapp/authenticationinapp.h \
        authenticationinapp/authenticationinapplistener.h \
        authenticationinapp/authenticationinappsession.h \
        authenticationinapp/incrementaldecoder.h \
        captiveportal/captiveportal.h \
        captiveportal/captiveportaldetection.h \
        captiveportal/captiveportaldetectionimpl.h \
        captiveportal/captiveportalmonitor.h \
        captiveportal/captiveportalnotifier.h \
        captiveportal/captiveportalrequest.h \
        captiveportal/captiveportalrequesttask.h \
        collator.h \
        command.h \
        commandlineparser.h \
        commands/commandactivate.h \
        commands/commanddeactivate.h \
        commands/commanddevice.h \
        commands/commandlogin.h \
        commands/commandlogout.h \
        commands/commandselect.h \
        commands/commandservers.h \
        commands/commandstatus.h \
        commands/commandui.h \
        composer/composer.h \
        composer/composerblock.h \
        composer/composerblockbutton.h \
        composer/composerblocktext.h \
        composer/composerblocktitle.h \
        composer/composerblockorderedlist.h \
        composer/composerblockunorderedlist.h \
        connectionbenchmark/benchmarktask.h \
        connectionbenchmark/benchmarktaskping.h \
        connectionbenchmark/benchmarktasksentinel.h \
        connectionbenchmark/benchmarktasktransfer.h \
        connectionbenchmark/connectionbenchmark.h \
        connectionbenchmark/uploaddatagenerator.h \
        connectionhealth.h \
        constants.h \
        controller.h \
        controllerimpl.h \
        cryptosettings.h \
        curve25519.h \
        dnshelper.h \
        dnspingsender.h \
        env.h \
        errorhandler.h \
        externalophandler.h \
        filterproxymodel.h \
        fontloader.h \
        frontend/navigator.h \
        frontend/navigatorreloader.h \
        glean/glean.h \
        glean/private/event.h \
        glean/private/ping.h \
        glean/generated/metrics.h \
        glean/generated/pings.h \
        hawkauth.h \
        keyregenerator.h \
        hkdf.h \
        imageproviderfactory.h \
        inspector/inspectorhandler.h \
        inspector/inspectoritempicker.h \
        inspector/inspectorutils.h \
        inspector/inspectorwebsocketconnection.h \
        inspector/inspectorwebsocketserver.h \
        ipaddress.h \
        ipaddresslookup.h \
        itempicker.h \
        leakdetector.h \
        localizer.h \
        logger.h \
        loghandler.h \
        logoutobserver.h \
        models/device.h \
        models/devicemodel.h \
        models/feature.h \
        models/featuremodel.h \
        models/feedbackcategorymodel.h \
        models/keys.h \
        models/licensemodel.h \
        models/recentconnections.h \
        models/server.h \
        models/servercity.h \
        models/servercountry.h \
        models/servercountrymodel.h \
        models/serverdata.h \
        models/subscriptiondata.h \
        models/supportcategorymodel.h \
        models/user.h \
        mozillavpn.h \
        networkmanager.h \
        networkrequest.h \
        networkwatcher.h \
        networkwatcherimpl.h \
        notificationhandler.h \
        pinghelper.h \
        pingsender.h \
        pingsenderfactory.h \
        platforms/dummy/dummyapplistprovider.h \
        platforms/dummy/dummynetworkwatcher.h \
        platforms/dummy/dummypingsender.h \
        productshandler.h \
        profileflow.h \
        purchasehandler.h \
        purchaseiaphandler.h \
        purchasewebhandler.h \
        qmlengineholder.h \
        releasemonitor.h \
        rfc/rfc1112.h \
        rfc/rfc1918.h \
        rfc/rfc4193.h \
        rfc/rfc4291.h \
        rfc/rfc5735.h \
        serveri18n.h \
        serverlatency.h \
        settingsholder.h \
        signature.h \
        simplenetworkmanager.h \
        statusicon.h \
        task.h \
        tasks/account/taskaccount.h \
        tasks/adddevice/taskadddevice.h \
        tasks/addon/taskaddon.h \
        tasks/addonindex/taskaddonindex.h \
        tasks/authenticate/taskauthenticate.h \
        tasks/captiveportallookup/taskcaptiveportallookup.h \
        tasks/deleteaccount/taskdeleteaccount.h \
        tasks/getfeaturelist/taskgetfeaturelist.h \
        tasks/getsubscriptiondetails/taskgetsubscriptiondetails.h \
        tasks/controlleraction/taskcontrolleraction.h \
        tasks/createsupportticket/taskcreatesupportticket.h \
        tasks/function/taskfunction.h \
        tasks/group/taskgroup.h \
        tasks/heartbeat/taskheartbeat.h \
        tasks/ipfinder/taskipfinder.h \
        tasks/products/taskproducts.h \
        tasks/release/taskrelease.h \
        tasks/removedevice/taskremovedevice.h \
        tasks/sendfeedback/tasksendfeedback.h \
        tasks/servers/taskservers.h \
        taskscheduler.h \
        telemetry.h \
        temporarydir.h \
        theme.h \
        tutorial/tutorial.h \
        tutorial/tutorialstep.h \
        tutorial/tutorialstepbefore.h \
        tutorial/tutorialstepnext.h \
        update/updater.h \
        update/versionapi.h \
        update/webupdater.h \
        urlopener.h \
        websocket/exponentialbackoffstrategy.h \
        websocket/pushmessage.h \
        websocket/websockethandler.h

# Signal handling for unix platforms
unix {
    SOURCES += signalhandler.cpp
    HEADERS += signalhandler.h
}

RESOURCES += ui/resources.qrc
RESOURCES += ui/license.qrc
RESOURCES += ui/ui.qrc
RESOURCES += resources/certs/certs.qrc
RESOURCES += resources/public_keys/public_keys.qrc

CONFIG += qmltypes
QML_IMPORT_NAME = Mozilla.VPN.qmlcomponents
QML_IMPORT_MAJOR_VERSION = 1.0
