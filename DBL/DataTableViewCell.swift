//
//  DataTableViewCell.swift
//  DBL
//
//  Created by Apple on 26/07/17.
//  Copyright © 2017 SmartMobile Technologies. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var lblbusName: UILabel!
    @IBOutlet weak var lblNearBy: UILabel!
    @IBOutlet weak var lblKm: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
