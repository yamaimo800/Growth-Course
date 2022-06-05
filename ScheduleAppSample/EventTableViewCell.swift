//
//  EventTableViewCell.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/07/07.
//

import UIKit


class EventTableViewCell: UITableViewCell {

    
    @IBOutlet var textTitle: UILabel!
    @IBOutlet var textMemo: UITextView!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    
   
}
