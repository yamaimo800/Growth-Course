import Foundation
import AVFoundation
import UserNotifications


class Alarm{
    var selectedWakeUpTime:Date?
    var audioPlayer: AVAudioPlayer!
    var sleepTimer: Timer?
    var seconds = 0
    
    func runTimer(seconds: Int,subtitle: String){
        
        let content = UNMutableNotificationContent()
        
        content.title = "復習の時間です！！！"
        content.subtitle = subtitle
        content.body = subtitle + "を頑張りましょう"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "レベル1_鳩.mp3"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds),
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: "TIMER\(seconds)",
                                            content: content,
                                            trigger: trigger)
        print(seconds)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                
                print(error.localizedDescription)
            }
            
        }
        
        if sleepTimer == nil{
            
            sleepTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc private func updateTimer(){
        
        if seconds != 0{
            seconds -= 1
        }else{
            
            sleepTimer?.invalidate()
            sleepTimer = nil
        }
        
    }
    
    private func calculateInterval(userAwakeTime:Date)-> Int{
        
        var interval = Int(userAwakeTime.timeIntervalSinceNow)
        if interval < 0{
            
            interval = 86400 - (0 - interval)
        }
        
        let calendar =  Calendar.current
        let seconds = calendar.component(.second, from: userAwakeTime)
        return interval - seconds
    }
    
    func stopTimer(){
        
        if sleepTimer != nil {
            
            sleepTimer?.invalidate()
            sleepTimer = nil
        }else{
            
        }
        
    }
    
}
