//
//  RealmModel.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/07/01.
//

import Foundation
import RealmSwift
class RealmModel: Object {
    

@objc dynamic var title = ""
      @objc dynamic var memo = ""
       @objc dynamic var date = "" //yyyy.MM.dd
   // @objc dynamic var start_time = "" //00:00
      //@objc dynamic var end_time = "" //00:00
   
}
