//
//  LocalNotificationHelper.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
            if let error = error { NSLog("Error requesting authorization status for local notifications: \(error)") }
            
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
    
    func scheduleDailyReminderNotification() {
        // set the properties that are passed into the follwing instance of UNNotificationRequest
        
        // set a unique identifier for our notification
        let identifier = UUID().uuidString
        
        // creates an instance of our notification and sets its content
        let content = UNMutableNotificationContent()
        content.title = "Remember to record your memory today!"
        content.body = "Record today's special or striking memory in the Memory app!"
        
        // set trigger components, including a DateComponents() time description
        var date = DateComponents()
        date.hour = 20
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        // sets up a notification (aka a "request") to receive the above arguments
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // actually displays the notification by passing in the "request" property above
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }
}
