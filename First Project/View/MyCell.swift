//
//  MyCell.swift
//  First Project
//
//  Created by Аброрбек on 27.06.2022.
//

import UIKit

class MyCell: UICollectionViewCell {
    weak var textLabel : UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
        textLabel = label
        textLabel.font = .boldSystemFont(ofSize: 14)
        textLabel.textAlignment = .center
        contentView.backgroundColor = UIColor(hexString: "#F0F4F7")
        contentView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
