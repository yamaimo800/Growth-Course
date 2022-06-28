import UIKit
import AVFoundation
import UserNotifications
import os


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let session = AVAudioSession.sharedInstance()
        do {
            
            try session.setCategory(.playback, mode: .default)
        } catch  {
            
            fatalError("Category設定失敗")
        }
        
        do {
            try session.setActive(true)
        } catch {
            
            fatalError("Session有効化失敗")
        }
        
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests();
        
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in if granted { print("通知許可")}
        }
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        
        completionHandler([ .badge, .sound, .alert ])
    }
    
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    return true
}

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
}










