//
//  PushNotificationUsingGoogleFirebaseApp.swift
//  PushNotificationUsingGoogleFirebase
//
//  Created by Shafiq  Ullah on 11/18/23.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging

// WORK FLOW (Becase I don't have a paid account, I can't complete all the steps)
// Create an app with Xcode
//Add push notification Capabilities (need paied apple account)
//create a project in Firebase with Bundle identifier
//copy info file to project root folder
//Create user authorization code for Aloow push notification(APNS)
//apple developer profile -> create key (with APNS enable /checked)-> Download the file
//firebase -> provide that APNS key file with Key id and team id

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
            success, error in
            
            guard success else{
                return
            }
            
            print("APNS granted")
            
            application.registerForRemoteNotifications()
            
        }
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token{ token, error in
            guard let token = token else {
                return
            }
            
            print("Token is \(token)")
        }
    }
}

@main
struct PushNotificationUsingGoogleFirebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
