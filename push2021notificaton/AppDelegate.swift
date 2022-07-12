//
//  AppDelegate.swift
//  push2021notificaton
//
//  Created by Kapture on 27/12/21.
//

import UIKit
import FirebaseMessaging
import FirebaseCore
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {
    var DeviceToken = String()
let gcmMessageIDKey = "gcm.Message_ID"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        
        UIApplication.shared.registerForRemoteNotifications()
      
        //                MARK:- NOTIFIACATION
        
        Messaging.messaging().delegate = self
        
        UIApplication.shared.applicationIconBadgeNumber = 0

        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in

            // If granted comes true you can enabled features based on authorization.
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
      
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
     
       // application.registerForRemoteNotifications()
       

        // Override point for customization after application launch.
        registerForPushNotifications()

        return true
    }
//    func application(_ application: UIApplication,
//                didRegisterForRemoteNotificationsWithDeviceToken
//                    deviceToken: Data) {
////       self.sendDeviceTokenToServer(data: deviceToken)
//        print("mahi",deviceToken)
//    }
 
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
       // print("Message ID: \(messageID)")
      }

      // Print full message.
     // print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let devicetokenstring = deviceToken.hexstring
//        print("devicetokenstring",devicetokenstring)
//        let  userDefaults0 = UserDefaults.standard
//    userDefaults0.setValue(devicetokenstring, forKey: "Clienttoken")
//    }


}
extension AppDelegate : MessagingDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       // print("APNs token retrieved: \(deviceToken)"); Messaging.messaging().apnsToken = deviceToken
//        let  userDefaults0 = UserDefaults.standard
//        userDefaults0.setValue(deviceToken, forKey: "Clienttoken")
       // print("maesh",deviceToken)
    //Code for sending to other sender ID
//    let senderid = "217539218211" // company
//    Messaging.messaging().retrieveFCMToken(forSenderID: senderid) {(deviceToken,Error) in // here i am generating the token for other sender id project
//        AppPreferences.share.commit(data: deviceToken, forkey: .mrnValue)
//
//    print("fmcm secrect Token",deviceToken!) }
        
//        let sender = "duencid"
//        Messaging.messaging().retrieveFCMToken(forSenderID: <#T##String#>, completion: <#T##(String?, Error?) -> Void#>)
//
        
        
        let senderid1 = "711453043154"  // personal
        Messaging.messaging().retrieveFCMToken(forSenderID: senderid1) {(deviceToken1,Error) in // here i am generating the token for other sender id project
            AppPreferences.share.commit(data: deviceToken1, forkey: .target)
            print("fmcm secrect Token",deviceToken1!) }
//        let senderid2 = "1081429165757"
//        Messaging.messaging().retrieveFCMToken(forSenderID: senderid2) {(deviceToken2,Error) in // here i am generating the token for other sender id project
//            AppPreferences.share.commit(data: deviceToken2, forkey: .age)
//            print("fmcm secrect Token",deviceToken2!) }
//        let senderid3 = "139303776495"
//        Messaging.messaging().retrieveFCMToken(forSenderID: senderid3) {(deviceToken3,Error) in // here i am generating the token for other sender id project
//            AppPreferences.share.commit(data: deviceToken3, forkey: .user)
//            print("fmcm secrect Token",deviceToken3!) }
    }
//    func application(_ application: UIApplication,
//                didRegisterForRemoteNotificationsWithDeviceToken
//                    deviceToken: Data) {
////       self.sendDeviceTokenToServer(data: deviceToken)
//        print("mahi",deviceToken)
//    }
//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//    print("DEVICE TOKEN = \(deviceToken)")
////    if let refreshedToken = InstanceID.instanceID().token() {
////    print("InstanceID token: \(refreshedToken)")
////    }
//    }
//
//    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//    print(error)
//    }
    
    func retrieveFCMToken(forSenderID senderID: String, completion: @escaping (String?, Error?) -> Void){
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    // print("Firebase registration token: \(String(describing: fcmToken))")
        self.DeviceToken = fcmToken ?? ""
          //  print("InstanceID token: \(self.DeviceToken)")
        AppPreferences.share.commit(data: fcmToken, forkey: .fcmToken)
        
        print("mahesh",self.DeviceToken)

//      let dataDict: [String: String] = ["token": fcmToken ?? ""]
//      NotificationCenter.default.post(
//        name: Notification.Name("FCMToken"),
//        object: nil,
//        userInfo: dataDict
//      )
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }


}
 
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      completionHandler()
    }
    
    func registerForPushNotifications() {
      //1
      UNUserNotificationCenter.current()
        //2
        UNUserNotificationCenter.current()
          .requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
          }

    }
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          guard settings.authorizationStatus == .authorized else { return }
          DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
          }
      }
    }

    

}
