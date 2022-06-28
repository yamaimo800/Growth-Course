import UIKit


class EventTableViewCell: UITableViewCell {
    
    @IBOutlet var textTitle: UILabel!
    @IBOutlet var textMemo: UITextView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
}
