

import UIKit
import FSCalendar
import RealmSwift
import CalculateCalendarLogic

class calenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var eventTableView: UITableView!
    
    
    
    @IBOutlet weak var calendar: FSCalendar!
    var passDate: String!
    
    var eventArray = [RealmModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.dataSource = self
        self.calendar.delegate = self
        eventTableView.delegate = self
        eventTableView.dataSource = self
        //カスタムセルの登録
        let nib = UINib(nibName: "EventTableViewCell", bundle: Bundle.main)
        eventTableView.register(nib, forCellReuseIdentifier: "cell")
        
        
    }
    
    func judgeHoliday(_ date : Date) -> Bool {
        
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        print( "\(year)/\(month)/\(day)")
        passDate =  "\(year)/\(month)/\(day)"
        let realm = try! Realm()
        let event = realm.objects(RealmModel.self).filter("date == %@",passDate as Any)
        print(passDate,"うううううう")
        print(event,"ああああああああああああ")
        eventArray = [RealmModel]()
        for i in event {
            eventArray.append(i)
        }
        eventTableView.reloadData()
        print(eventArray,"いいいいいい")
    }
    
    
    @IBAction func Buttun () {
        performSegue(withIdentifier: "toSecond", sender: nil)
        
        
        
        
        
    }
    
    @IBAction func push () {
        performSegue(withIdentifier: "toAlarm", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
        
        let object = eventArray[indexPath.row]
        print(object.title)
        print(object.memo)
        cell.textTitle.text = object.title
        cell.textMemo.text = object.memo
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "toTaskVar", sender:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecond" {
            
            let secondVc = segue.destination as! SecondViewController
            
            secondVc.passedDate = passDate
        }else if segue.identifier == "toTaskVar" {
            //
            let nextVC = segue.destination as! TaskVarViewController
            let _ = nextVC.view
            
            let selectedIndex = eventTableView.indexPathForSelectedRow!
            let sender = eventArray[selectedIndex.row].title
            print("-----")
            print(sender)
            print("-----")
            nextVC.titleName = sender
            
        }
    }
}
