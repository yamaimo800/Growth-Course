
import UIKit
import RealmSwift


class SecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var timer:Timer = Timer()
    
    var passedDate: String!
    @IBOutlet var Name: UITextField!
    @IBOutlet var Memo: UITextView!
    private let realm = try! Realm()
    
    let alarm = Alarm()
    var alarmTime = 86400
    var taskVarView = TaskVarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 30.0,
                                     target: self,
                                     selector: #selector(self.add),
                                     userInfo: nil,
                                     repeats: false)
        
        Name.delegate = self
        Memo.delegate = self
        
        Memo.layer.cornerRadius = 5
        Memo.layer.borderColor = UIColor.lightGray.cgColor
        Memo.layer.borderWidth  = 0.2
        Memo.layer.masksToBounds = true
        
    }
    
    @IBAction func add () {
        let realm = try! Realm()
        let data = RealmModel()
        data.title = Name.text!
        data.memo = Memo.text
        data.date = passedDate
        try! realm.write {
            realm.add(data)
            print(data)
        }
        
        alarm.runTimer(seconds: alarmTime, subtitle: Name.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func didTapAddButton() {
        guard (storyboard?.instantiateViewController(identifier: "enter")) != nil  else {
            return
        }
        
    }
    
}
