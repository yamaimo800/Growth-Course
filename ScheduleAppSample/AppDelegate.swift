//
//  AppDelegate.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/06/07.
//

import UIKit
//Admobのインタースティシャル広告が出るタイミングで音楽がストップしないようにするため
import AVFoundation
import UserNotifications
import os
//コメント

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// AVAudioSessionCategory設定
        let session = AVAudioSession.sharedInstance()
        do {
            // CategoryをPlaybackにする
            try session.setCategory(.playback, mode: .default)
        } catch  {
            // 予期しない場合
            fatalError("Category設定失敗")
        }

        // session有効化
        do {
            try session.setActive(true)
        } catch {
            // 予期しない場合
            fatalError("Session有効化失敗")
        }
        
        
        
        let center = UNUserNotificationCenter.current()
                // トリガーされている全ての通知をトリガー解除する
                center.removeAllPendingNotificationRequests();
        // 「通知を許可しますか？」ダイアログを出す
              center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in if granted { print("通知許可")}
              }
        return true
    }

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


}
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        // アプリ起動時も通知を行う
        completionHandler([ .badge, .sound, .alert ])
    }
}

//import NCMB
//import UserNotifications

//@main
//class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    var window: UIWindow?
//
//    func requestAuthorization(options: UNAuthorizationOptions = [],
//                              completionHandler: @escaping (Bool, Error?) -> Void) {
//
//    if #available(iOS 10.0, *) {
//        // iOS 10
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
//            if error != nil {
//                return
//            }
//
//            if granted {
//                print("通知許可")
//
//                let center = UNUserNotificationCenter.current()
//                center.delegate = self
//
//            } else {
//                print("通知拒否")
//            }
//        })
//
//    } else {
//        // iOS 9以下
//        let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
//        UIApplication.shared.registerUserNotificationSettings(settings)
//    }
//
//        // 設定に必要なクラスをインスタンス化
//        var notificationTime = DateComponents()
//        var trigger: UNNotificationTrigger
//
//        // 12時に通知する場合
//        notificationTime.hour = 12
//        notificationTime.minute = 0
//        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
//
//        /*その他の設定*/
//
//        // 設定したタイミングを起点として1分後に通知したい場合
//        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//
//        // UNMutableNotificationContentクラスをインスタンス化
//        let content = UNMutableNotificationContent()
//
//        // 通知のメッセージセット
//        content.title = ""
//        content.body = "食事の時間になりました！"
//        content.sound = UNNotificationSound.default
//
//        // 通知スタイルを指定
//        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
//
//        // 通知をセット
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//        func applicationDidEnterBackground(_ application: UIApplication) {
//
//            //　通知設定に必要なクラスをインスタンス化
//            let trigger: UNNotificationTrigger
//            let content = UNMutableNotificationContent()
//            var notificationTime = DateComponents()
//
//            // トリガー設定
//            notificationTime.hour = 12
//            notificationTime.minute = 0
//            trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
//
//            // 通知内容の設定
//            content.title = ""
//            content.body = "食事の時間になりました！"
//            content.sound = UNNotificationSound.default
//
//            // 通知スタイルを指定
//            let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
//            // 通知をセット
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
//        }

        @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        NCMB.initialize(applicationKey: "a0ee31eb03c0eb164418ebacb51be62135aa787533fc1597afd1b6e9b7d89a9e", clientKey: "d72063ed32d73d0e117465330df86c889978670b56c5f40cedb0b9820e3922aa")
//
//        let ud = UserDefaults.standard
//        let isLogin = ud.bool(forKey: "isLogin")
//        if isLogin == true {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController")
//            self.window?.rootViewController = rootViewController
//            self.window?.backgroundColor = UIColor.white
//            self.window?.makeKeyAndVisible()
//
//        } else {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
//            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootNavigationController")
//            self.window?.rootViewController = rootViewController
//            self.window?.backgroundColor = UIColor.white
//            self.window?.makeKeyAndVisible()
                    
//    }
return true
    }
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
    
    








