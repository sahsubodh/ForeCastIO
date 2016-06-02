//
//  DayDetailsTableViewCell.swift
//  ForecastIO
//
//  Created by Subodh Sah on 12/9/15.
//  Copyright © 2015 Subodh Sah. All rights reserved.
//

import UIKit

class DayDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var summaryImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
