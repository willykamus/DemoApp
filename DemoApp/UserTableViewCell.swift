//
//  UserTableViewCell.swift
//  DemoApp
//
//  Created by William Ching on 2019-04-22.
//  Copyright © 2019 William Ching. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
