import UIKit


class SetAlarmViewController: UIViewController {
    
    let alarm = Alarm()
    
    @IBOutlet var sleepTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
        sleepTimePicker.setDate(Date(), animated: false)
    }
    
    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
        
        alarm.selectedWakeUpTime = sleepTimePicker.date
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if alarm.sleepTimer != nil{
            alarm.stopTimer()
        }
        
    }
    
}
