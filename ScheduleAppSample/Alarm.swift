//
//  Alarm.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/07/12.
//

//import Foundation
//import UIKit
//
//class AlarmViewController: UIViewController {
//
//    //インスタンスを生成
//    let alarm = Alarm()
//
//    @IBOutlet var sleepTimePicker: UIDatePicker!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //UIDatePickerを.timeモードにする
//        sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
//        //現在の時間をDatePickerに表示
//        sleepTimePicker.setDate(Date(), animated: false)
//    }
//
//    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
//
//        //AlarmにあるselectedWakeUpTimeにユーザーの入力した日付を代入
//            alarm.selectedWakeUpTime = sleepTimePicker.date
//            //AlarmのrunTimerを呼ぶ
//            alarm.runTimer()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//             //AlarmでsleepTimerがnilじゃない場合
//            if alarm.sleepTimer != nil{
//                //再生されているタイマーを止める
//                alarm.stopTimer()
//            }
//        }
//
//}

import Foundation
import AVFoundation
import UserNotifications

class Alarm{
    var selectedWakeUpTime:Date?
    var audioPlayer: AVAudioPlayer!
    var sleepTimer: Timer?
    var seconds = 0

    //アラーム/タイマーを開始
    func runTimer(seconds: Int,subtitle: String){
        
        
//ここで設定しているsecond秒後にアラームが鳴る↓↓↓
//-----------------------------------------------------------------------------------------------------------------
        //calculateIntervalにユーザーが入力した日付を渡す、返り値をsecondsに代入
//       seconds = calculateInterval(userAwakeTime: selectedWakeUpTime!)

        let content = UNMutableNotificationContent()
//ここで表示させる内容（文字）を変える↓↓↓
//-----------------------------------------------------------------------------------------------------------------
        content.title = "復習の時間です！！！"
           content.subtitle = subtitle
           content.body = subtitle + "を頑張りましょう"
//ここで音楽を変える↓↓↓
//-----------------------------------------------------------------------------------------------------------------
           content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "レベル1_鳩.mp3"))

        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds),
                                                        repeats: false)

        // request includes content & trigger
        let request = UNNotificationRequest(identifier: "TIMER\(seconds)",
                                            content: content,
                                            trigger: trigger)
        print(seconds)

        // schedule notification by adding request to notification center
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
        
        if sleepTimer == nil{
             //タイマーをセット、一秒ごとにupdateCurrentTimeを呼ぶ
            sleepTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }

    //一秒ごとにsleepTimerに呼ばれる
    @objc private func updateTimer(){
        if seconds != 0{
            //secondsから-1する
            seconds -= 1
        }else{
            //タイマーを止める
            sleepTimer?.invalidate()
            //タイマーにnil代入
            sleepTimer = nil

                   }
        }
    

    //起きる時間までの秒数を計算
    private func calculateInterval(userAwakeTime:Date)-> Int{
        //タイマーの時間を計算する
        var interval = Int(userAwakeTime.timeIntervalSinceNow)

        if interval < 0{
            //落とし穴 ②の解決策
            interval = 86400 - (0 - interval)
        }
        //落とし穴 ③の解決策
        let calendar =  Calendar.current
        let seconds = calendar.component(.second, from: userAwakeTime)
        return interval - seconds
    }
    
    func stopTimer(){
             //sleepTimerがnilじゃない場合
            if sleepTimer != nil {
               //タイマーを止める
                sleepTimer?.invalidate()
                //タイマーにnil代入
                sleepTimer = nil
            }else{
        
            }
        }
}
