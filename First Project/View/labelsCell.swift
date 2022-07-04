//
//  labelsCell.swift
//  First Project
//
//  Created by Аброрбек on 02.07.2022.
//

import UIKit

class labelsCell: UICollectionViewCell {
    weak var txtLabel : UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            ])
        
        txtLabel = label
        txtLabel.font = UIFont(name: "Montserrat", size: 14)
        txtLabel.font = .systemFont(ofSize: 14, weight: .semibold)
//        txtLabel.textColor = .lightGray
        txtLabel.textAlignment = .center
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
