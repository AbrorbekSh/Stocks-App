//
//  CustomTableViewCell.swift
//  First Project
//
//  Created by Аброрбек on 06.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyTicker: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var todaysDifference: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
