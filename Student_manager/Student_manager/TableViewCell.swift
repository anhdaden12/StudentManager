//
//  TableViewCell.swift
//  Student_manager
//
//  Created by Ngoc on 6/21/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var stName: UILabel!
    @IBOutlet weak var stPhone: UILabel!
    @IBOutlet weak var stClass: UILabel!
    @IBOutlet weak var stImage: UIImageView!
    
    @IBOutlet weak var viewImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
