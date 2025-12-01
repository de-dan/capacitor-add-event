import Foundation
import Capacitor
import EventKit
import EventKitUI

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CalendarPlugin)
public class CalendarPlugin: CAPPlugin, CAPBridgedPlugin, EKEventEditViewDelegate {
    public let identifier = "CalendarPlugin"
    public let jsName = "Calendar"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "createEvent", returnType: CAPPluginReturnPromise),
    ]

    let store = EKEventStore()

    public func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        switch action {
        case .canceled:
            self.bridge?.triggerWindowJSEvent(eventName: "CalendarCreatedEvent", data: "{ 'action': 'canceled' }")
        case .deleted: self.bridge?.triggerWindowJSEvent(eventName: "CalendarCreatedEvent", data: "{ 'action': 'deleted' }")
        case .saved: self.bridge?.triggerWindowJSEvent(eventName: "CalendarCreatedEvent", data: "{ 'action': 'saved' }")
        default: self.bridge?.triggerWindowJSEvent(eventName: "CalendarCreatedEvent", data: "{ 'action': 'unknown' }")
        }
        controller.dismiss(animated: true)
    }

    @objc func createEvent(_ call: CAPPluginCall) {
        let title = call.getString("title", "")
        let notes = call.getString("notes", "")
        let startDate = call.getDate("startDate")
        let endDate = call.getDate("endDate")
        let isAllDay = call.getBool("isAllDay", false)
        let urlString = call.getString("url", "")
        let url = URL(string: urlString)
        let location = call.getString("location", "")

        var calendar = self.store.defaultCalendarForNewEvents
        if let identifier = call.getString("calendarId") {
            if let selectedCalendar = self.store.calendar(withIdentifier: identifier) {
                calendar = selectedCalendar
            }
        }

        DispatchQueue.main.async {
            let store = EKEventStore()
            let event = EKEvent(eventStore: store)
            event.calendar = calendar
            event.title = title
            event.notes = notes
            event.startDate = startDate
            event.endDate = endDate
            event.isAllDay = isAllDay
            event.url = url
            event.location = location
            let eventEditViewController = EKEventEditViewController()
            eventEditViewController.event = event
            eventEditViewController.eventStore = store
            eventEditViewController.editViewDelegate = self
            self.bridge?.viewController?.present(eventEditViewController, animated: true, completion: nil)
        }

        call.resolve(["success": true])
    }
}
