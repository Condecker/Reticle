//
//  SupervisorTableViewCell.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/4/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit

class SupervisorTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
