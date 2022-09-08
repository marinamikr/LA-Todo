//
//  TableViewCell.swift
//  Todo
//
//  Created by 原田摩利奈 on 9/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var todoLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
