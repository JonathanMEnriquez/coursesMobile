//
//  CustomCell.swift
//  iCourses
//
//  Created by user on 1/23/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
