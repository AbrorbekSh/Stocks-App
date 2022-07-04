//
//  FirstHeader.swift
//  First Project
//
//  Created by Аброрбек on 27.06.2022.
//

import UIKit

class FirstHeader: UICollectionViewCell {
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
        textLabel.text = "Popular requests"
        textLabel.font = UIFont.boldSystemFont(ofSize: 25)
        textLabel.textAlignment = .left
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SecondHeader: UICollectionViewCell {
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
        textLabel.text = "You've searched for this"
        textLabel.font = UIFont.boldSystemFont(ofSize: 25)
        textLabel.textAlignment = .left
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
