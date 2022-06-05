//
//  SetAlarmViewController.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/07/12.
//

import UIKit

class SetAlarmViewController: UIViewController {

        //インスタンスを生成
        let alarm = Alarm()
    
        @IBOutlet var sleepTimePicker: UIDatePicker!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //UIDatePickerを.timeモードにする
            sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
            //現在の時間をDatePickerに表示
            sleepTimePicker.setDate(Date(), animated: false)
        }
    
        @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
    
            //AlarmにあるselectedWakeUpTimeにユーザーの入力した日付を代入
                alarm.selectedWakeUpTime = sleepTimePicker.date
                //AlarmのrunTimerを呼ぶ
//                alarm.runTimer()
        }
    
        override func viewDidAppear(_ animated: Bool) {
                 //AlarmでsleepTimerがnilじゃない場合
                if alarm.sleepTimer != nil{
                    //再生されているタイマーを止める
                    alarm.stopTimer()
                }
            }
    

   
}
