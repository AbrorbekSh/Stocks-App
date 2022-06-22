//
//  CustomTableViewCell.swift
//  First Project
//
//  Created by Аброрбек on 06.06.2022.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func didTapped(with cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var starOutlet: UIButton!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyTicker: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var difference: UILabel!
    
    weak var delegate: CustomTableViewCellDelegate?
    var isFav : Bool = false {
        didSet {
            if isFav {
                starOutlet.tintColor = UIColor(red: 1, green: 0.8471, blue: 0, alpha: 1.0)
            } else {
                starOutlet.tintColor = .lightGray
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func starButtonPressed(_ sender: UIButton) {
        delegate?.didTapped(with: self)
    }
}
