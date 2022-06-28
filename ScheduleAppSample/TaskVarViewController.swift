import UIKit
import MBCircularProgressBar


class TaskVarViewController: UIViewController {
    @IBOutlet weak var taskVarView: MBCircularProgressBarView!
    
    let alarm = Alarm()
    var alarmTime = 5//345600
    var secondAlarmTime = 604800
    var thirdAlarmTime = 950400
    var forthAlarmTime = 1296000
    var titleName: String!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            
            self.titleLabel.text = self.titleName
            print("AAAAAA")
        }
        
    }
    @IBAction func percentSliderValueChanged(sender: UISlider) {
        
        taskVarView.value = CGFloat(sender.value)
    }
    
    @IBAction func backToTop() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func kanryo() {
        taskVarView.value = 100
        alarm.runTimer(seconds: alarmTime, subtitle: titleLabel.text!)
        alarm.runTimer(seconds: secondAlarmTime, subtitle: titleLabel.text!)
        alarm.runTimer(seconds: thirdAlarmTime, subtitle: titleLabel.text!)
        alarm.runTimer(seconds: forthAlarmTime, subtitle: titleLabel.text!)
    }
    
}
