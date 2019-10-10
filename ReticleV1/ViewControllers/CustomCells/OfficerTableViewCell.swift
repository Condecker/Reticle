//
//  OfficerTableViewCell.swift
//  ReticleV1
//
//  Created by Claudia Ondecker on 4/5/19.
//  Copyright © 2019 Claudia Ondecker. All rights reserved.
//

import UIKit

class OfficerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
