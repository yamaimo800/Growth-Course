//
//  calenderViewController.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/06/28.
//

import UIKit
import FSCalendar
import RealmSwift
import CalculateCalendarLogic

//class ToDoListItem: Object {
//    @objc dynamic var name: String = ""
//    @objc dynamic var memo: String = ""
//    @objc dynamic var date = "" //yyyy.MM.dd}
class calenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var eventTableView: UITableView!
//    @objc dynamic var name = ""
//       @objc dynamic var memo = ""
////       @objc dynamic var date = "" //yyyy.MM.dd
////       @objc dynamic var start_time = "" //00:00
//       @objc dynamic var end_time = "" //00:00

   
    
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
        
        // Do any additional setup after loading the view.
    }
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
        func judgeHoliday(_ date : Date) -> Bool {
            //祝日判定用のカレンダークラスのインスタンス
            let tmpCalendar = Calendar(identifier: .gregorian)

            // 祝日判定を行う日にちの年、月、日を取得
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)

            // CalculateCalendarLogic()：祝日判定のインスタンスの生成
            let holiday = CalculateCalendarLogic()

            return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        }
        // date型 -> 年月日をIntで取得
        func getDay(_ date:Date) -> (Int,Int,Int){
            let tmpCalendar = Calendar(identifier: .gregorian)
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            return (year,month,day)
        }

        //曜日判定(日曜日:1 〜 土曜日:7)
        func getWeekIdx(_ date: Date) -> Int{
            let tmpCalendar = Calendar(identifier: .gregorian)
            return tmpCalendar.component(.weekday, from: date)
        }

        // 土日や祝日の日の文字色を変える
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            //祝日判定をする（祝日は赤色で表示する）
            if self.judgeHoliday(date){
                return UIColor.red
            }

            //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
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
                //realmからデータ取得して、直した形で検索かける
                    let realm = try! Realm()
                      let event = realm.objects(RealmModel.self).filter("date == %@",passDate as Any)
                    print(passDate,"うううううう")
                print(event,"ああああああああああああ")
                    //初期化して、append
                    eventArray = [RealmModel]()
                    for i in event {
                      eventArray.append(i)
                    }
                    //データが変化したらテーブル全体を更新する
                    eventTableView.reloadData()
                    print(eventArray,"いいいいいい")
                }
   
   
    @IBAction func Buttun () {
        performSegue(withIdentifier: "toSecond", sender: nil)
        
        
        
        
   
            }
    
    @IBAction func push () {
        performSegue(withIdentifier: "toAlarm", sender: nil)
    }
    
//日付の値渡し
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSecond" {
//
//            let vc = segue.destination as! SecondViewController
//            vc.passedDate = passDate
           
            
            
    
//        }
       
    
    //セルの高さをきめるコード
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        
        }    //セルの個数を決めるコード
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count }
    //セルの内容を決めるコード
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // セルを取得する
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventTableViewCell
            // セルに表示する値を設定する
        let object = eventArray[indexPath.row]
        print(object.title)
        print(object.memo)
        cell.textTitle.text = object.title
        cell.textMemo.text = object.memo
        
        
        return cell
        
        
    }
//    / セル選択時（UITableViewDataSource optional）
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           // 次の画面へ移動
           performSegue(withIdentifier: "toTaskVar", sender:nil)
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecond" { //SecondViewControllerに遷移する場合
                // SecondViewControllerをインスタンス化
                let secondVc = segue.destination as! SecondViewController
                // 値を渡す
                secondVc.passedDate = passDate
            }else if segue.identifier == "toTaskVar" { //ThirdViewControllerに遷移する場合
//                // ThirdViewControllerをインスタンス化
//                let thirdVc = segue.destination as! TaskVarViewController
//                // 値を渡す
//                thirdVc.titleLabel = thirdVc
//
//                print(thirdVc.view,"りほおおおおおおおおおおおお")
                       let nextVC = segue.destination as! TaskVarViewController
                   let _ = nextVC.view // ラベルのインスタンス作成のため…ダサいw 他にいい手はないのか.
                
                let selectedIndex = eventTableView.indexPathForSelectedRow!
                let sender = eventArray[selectedIndex.row].title
                print("-----")
                print(sender)
                print("-----")
                nextVC.titleName = sender
                    // モデルそのものを渡した方が良いかと(itemList[index])
                 //   nextVC.titleName = eventArray[IndexPath.row]}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "toTaskVar", sender: nil)    //showDetailは適したIdentifierに適宜置き換えて下さい
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.performSegue(withIdentifier: "toTaskVar", sender: nil)
//    }
    
   
        

    
   
    

                        //func createEvent(success: @escaping () -> Void) {
//    do {
//        let realm = try Realm()
//        let eventModel = EventModel()
//        eventModel.title = titleTextField.text ?? ""
//        eventModel.memo = memoTextView.text
//        eventModel.date = stringFromDate(date: date as Date, format: "yyyy.MM.dd")
//        eventModel.start_time = startTextField.text ?? ""
//        eventModel.end_time = endTextField.text ?? ""
//
//        try realm.write {
//            realm.add(eventModel)
//            success()
//        }
//    } catch {
//        print("create todo error.")
//    }
//}
//func getModel() {
//    let results = realm.objects(EventModel.self)
//    var eventModels: [[String:String]] = []
//    for result in results {
//        eventModels.append(["title": result.title,
//                            "memo": result.memo,
//                            "date": result.date,
//                            "start_time": result.start_time,
//                            "end_time": result.end_time])
//    }
//}
//func filterModel() {
//    var filterdEvents: [[String:String]] = []
//    for eventModel in eventModels {
//        if eventModel["date"] == stringFromDate(date: selectedDate as Date, format: "yyyy.MM.dd") {
//            filterdEvents.append(eventModel)
//        }
//    }
//    filterdModels = filterdEvents
//}
//func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//    filterModel()
//    tableView.reloadData()
//}
//func deleteModel(selectedDate: String, indexPath: IndexPath) {
//    let results = realm.objects(EventModel.self).filter("date == '\(selectedDate)'")
//    do {
//        try realm.write {
//            realm.delete(results[indexPath.row])
//            getModel()
//        }
//    } catch {
//        print("delete data error.")
//    }
//}
//func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//    let date = stringFromDate(date: date, format: "yyyy.MM.dd")
//    var hasEvent: Bool = false
//    for eventModel in eventModels {
//        if eventModel["date"] == date {
//            hasEvent = true
//        }
//    }
//    if hasEvent {
//        return 1
//    } else {
//        return 0
//    }
//}





}
}
