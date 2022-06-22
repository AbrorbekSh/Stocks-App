//
//  MyCollectionViewCell.swift
//  First Project
//
//  Created by Аброрбек on 20.06.2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellButtonOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func cellButtonPressed(_ sender: UIButton) {
    }
    
//    func customCell(nameForButton: String){
//        cellButtonOutlet.setTitle(nameForButton, for: .normal)
//    }
    
}
