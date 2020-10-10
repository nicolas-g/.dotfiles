#!/bin/sh
#
# Disable non-critical macOS services

disable_plist() {
    launchctl unload -wF "$1"; \
        mv "$1" "${1}.bak"
#      echo "$1" ;
#    launchctl load -wF "$1";
#    launchctl bootstrap gui/501 "$1";
}

disable_agent() {
    disable_plist "/System/Library/LaunchAgents/${1}.plist"
}

disable_daemon() {
    disable_plist "/System/Library/LaunchDaemons/${1}.plist"
}

BLACKLIST_AGENTS=(com.apple.AddressBook.AssistantService \
    com.apple.AddressBook.ContactsAccountsService \
    com.apple.AddressBook.SourceSync \
    com.apple.AddressBook.abd \
    com.apple.CalendarAgent \
#    com.apple.iCloudUserNotifications \
#    com.apple.icloud.fmfd \
#    com.apple.cloudd \
#    com.apple.cloudpaird \
#    com.apple.cloudphotosd \
#    com.apple.imagent \
#    com.apple.IMLoggingAgent \
#    com.apple.notificationcenterui \
#    com.apple.spindump_agent \
    com.apple.safaridavclient \
    com.apple.Safari.SafeBrowsing.Service \
    com.apple.SafariBookmarksSyncAgent \
    com.apple.SafariCloudHistoryPushAgent \
    com.apple.SafariHistoryServiceAgent \
    com.apple.SafariLaunchAgent \
    com.apple.SafariNotificationAgent \
    com.apple.SafariPlugInUpdateNotifier \
#    com.apple.AirPlayUIAgent \
#    com.apple.AirPortBaseStationAgent \
#    com.apple.bird \
#    com.apple.findmymacmessenger \
#    com.apple.gamed \
#    com.apple.parentalcontrols.check \
#    com.apple.soagent \
#    com.apple.SocialPushAgent \
#    com.apple.DictationIM \
    com.apple.Maps.pushdaemon \
#    com.apple.locationmenu \
#    com.apple.ScreenReaderUIServer \
    com.apple.speech.speechdatainstallerd \
    com.apple.speech.speechsynthesisd \
    com.apple.speech.synthesisserver) # \ # <- remove ')' if not the last one
#    com.apple.photolibraryd \
#    com.apple.cloudphotosd \
#    com.apple.security.keychainsyncingoveridsproxy \
#    com.apple.personad \
#    com.apple.passd \
#    com.apple.screensharing.MessagesAgent \
#    com.apple.CommCenter-osx \
#    com.apple.photoanalysisd \
#    com.apple.telephonyutilities.callservicesd \
#    com.apple.familycircled \
#    com.apple.familycontrols.useragent \
#    com.apple.familynotificationd \
#    com.apple.icloud.findmydeviced.findmydevice-user-agent \
#    com.apple.assistant_service \
#    com.apple.CallHistorySyncHelper \
#    com.apple.CallHistoryPluginHelper \
#    com.apple.AOSPushRelay \
#    com.apple.syncdefaultsd \
#    com.apple.security.cloudkeychainproxy3 \
#    com.apple.security.keychain-circle-notification \
#    com.apple.sharingd \
#    com.apple.appleseed.seedusaged \
#    com.apple.assistantd \
#    com.apple.parsecd \
#    com.apple.identityservicesd \
#    com.apple.Siri.agent \
#    com.apple.siriknowledged \
#    com.apple.tccd \
#    com.apple.quicklook.32bit \
#    com.apple.quicklook.ThumbnailsAgent \
#    com.apple.quicklook \
#    com.apple.quicklook.ui.helper \
#    com.apple.touristd)

BLACKLIST_DAEMONS=(#com.apple.AirPlayXPCHelper \
#    com.apple.apsd \
#    com.apple.locationd \
#    com.apple.findmymac \
#    com.apple.findmymacmessenger \
#    com.apple.icloud.findmydeviced \
    com.apple.dvdplayback.setregion \
    com.apple.SubmitDiagInfo \
    com.apple.CrashReporterSupportHelper \
    com.apple.ReportCrash.Root \
    com.apple.ReportCrash.Root.Self \
    com.apple.GameController.gamecontrollerd) # \  # <- remove ')' if not the last one
#    com.apple.ftp-proxy \
#    com.apple.spindump \
#     org.cups.cupsd \
#     org.cups.cups-lpd \
#    com.apple.airport.wps \
#    com.apple.airportd \
#    com.apple.netbiosd \
#    com.apple.remotepairtool \
#    com.apple.rpmuxd \
#    com.apple.security.FDERecoveryAgent \
#    com.apple.familycontrols \
#    com.apple.screensharing \
#    com.apple.appleseed.fbahelperd \
#    com.apple.ManagedClient.cloudconfigurationd \
#    com.apple.ManagedClient.enroll \
#    com.apple.ManagedClient \
#    com.apple.ManagedClient.startup \
#    com.apple.awacsd \
#    com.apple.eapolcfg_auth \
#    com.apple.metadata.mds.index \
#    com.apple.metadata.mds \
#    com.apple.metadata.mds.scan \
#    com.apple.metadata.mds.spindump \
#    com.apple.mediaremoted)

for agent in "${BLACKLIST_AGENTS[@]}"; do
    disable_agent "$agent"
done

for daemon in "${BLACKLIST_DAEMONS[@]}"; do
    disable_daemon "$daemon"
done

exit 0 # Treat service disable failure errors as transient
