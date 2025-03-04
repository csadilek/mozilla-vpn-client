/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.5
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

import Mozilla.Shared 1.0
import Mozilla.VPN 1.0
import components 0.1
import components.forms 0.1
import compat 0.1

import org.mozilla.Glean 0.30
import telemetry 0.30


MZViewBase {
    id: root
    objectName: "privacySettingsView"

    _menuTitle: MZI18n.SettingsPrivacySettings

    _viewContentData: ColumnLayout {
        spacing: MZTheme.theme.windowMargin * 1.5

        InformationCard {
            objectName: "privacySettingsViewInformationCard"
            Layout.preferredWidth: Math.min(window.width - MZTheme.theme.windowMargin * 2, MZTheme.theme.navBarMaxWidth)
            Layout.minimumHeight: textBlocks.height + MZTheme.theme.windowMargin * 2
            Layout.alignment: Qt.AlignHCenter

            _infoContent: ColumnLayout {
                id: textBlocks
                spacing: 0

                MZTextBlock {
                    Layout.fillWidth: true
                    width: undefined
                    text: MZI18n.SettingsDnsSettingsWarning
                    verticalAlignment: Text.AlignVCenter
                    Accessible.role: Accessible.StaticText
                    Accessible.name: text
                }
                Loader {
                    active: !VPNController.silentServerSwitchingSupported && VPNController.state !== VPNController.StateOff
                    Layout.fillWidth: true
                    visible: active
                    sourceComponent: MZTextBlock {
                        width: parent.width
                        text: MZI18n.SettingsDnsSettingsDisconnectWarning
                        verticalAlignment: Text.AlignVCenter
                        Accessible.role: Accessible.StaticText
                        Accessible.name: text
                    }
                }
            }
        }
        Repeater {
            id: repeater

            delegate: MZCheckBoxRow {
                objectName: modelData.objectName

                Layout.fillWidth: true
                Layout.rightMargin: MZTheme.theme.windowMargin
                labelText: modelData.settingTitle
                subLabelText: modelData.settingDescription
                isChecked: MZSettings.dnsProviderFlags & modelData.settingValue
                showDivider: false
                onClicked: {
                    let dnsProviderFlags = MZSettings.dnsProviderFlags;
                    dnsProviderFlags &= ~MZSettings.Custom;
                    dnsProviderFlags &= ~MZSettings.Gateway;

                    if (dnsProviderFlags & modelData.settingValue) {
                        dnsProviderFlags &= ~modelData.settingValue;
                    } else {
                        dnsProviderFlags |= modelData.settingValue;
                    }

                    // We are not changing anything interesting for the privacy/dns dialog.
                    if (MZSettings.dnsProviderFlags !== MZSettings.Custom) {
                        MZSettings.dnsProviderFlags = dnsProviderFlags;
                        return;
                    }

                    privacyOverwriteLoader.dnsProviderValue = dnsProviderFlags;
                    privacyOverwriteLoader.active = true;
                }
            }
        }

        Component.onCompleted: {
            repeater.model = [
                {
                    objectName: "blockAds",
                    settingValue: MZSettings.BlockAds,
                    settingTitle: MZI18n.SettingsPrivacyAdblockTitle,
                    settingDescription: MZI18n.SettingsPrivacyAdblockBody,
                }, {
                    objectName: "blockTrackers",
                    settingValue: MZSettings.BlockTrackers,
                    settingTitle: MZI18n.SettingsPrivacyTrackerTitle,
                    settingDescription: MZI18n.SettingsPrivacyTrackerBody,
                }, {
                    objectName: "blockMalware",
                    settingValue: MZSettings.BlockMalware,
                    settingTitle: MZI18n.SettingsPrivacyMalwareTitle,
                    settingDescription: MZI18n.SettingsPrivacyMalwareBody,
                }
            ];
        }
    }

    Loader {
        id: privacyOverwriteLoader

        // This is the value we are going to set if the user confirms.
        property var dnsProviderValue;

        objectName: "privacyOverwriteLoader"
        active: false
        sourceComponent: MZSimplePopup {
            id: privacyOverwritePopup

            anchors.centerIn: Overlay.overlay
            closeButtonObjectName: "privacyOverwritePopupPopupCloseButton"
            imageSrc: "qrc:/ui/resources/logo-dns-settings.svg"
            imageSize: Qt.size(80, 80)
            title: MZI18n.DnsOverwriteDialogTitleDNS
            description: MZI18n.DnsOverwriteDialogBodyDNS
            buttons: [
                MZButton {
                    objectName: "privacyOverwritePopupDiscoverNowButton"
                    text: MZI18n.DnsOverwriteDialogPrimaryButton
                    Layout.fillWidth: true
                    onClicked: {
                        MZSettings.dnsProviderFlags = privacyOverwriteLoader.dnsProviderValue;
                        privacyOverwritePopup.close()
                    }
                },
                MZLinkButton {
                    objectName: "privacyOverwritePopupGoBackButton"
                    labelText: MZI18n.DnsOverwriteDialogSecondaryButton
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: privacyOverwritePopup.close()
                }
            ]

            onClosed: {
                privacyOverwriteLoader.active = false
            }
        }

        onActiveChanged: if (active) { item.open() }
    }
}

