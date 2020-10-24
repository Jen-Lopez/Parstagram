//
//  postCell.swift
//  parstagram
//
//  Created by Jennifer Lopez on 10/23/20.
//  Copyright © 2020 Jennifer Lopez. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
