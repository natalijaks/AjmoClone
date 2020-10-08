//
//  VenueCVCell.swift
//  Discover
//
//  Created by Natalija Krsnik on 30/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class VenueCVCell: UICollectionViewCell {
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.backgroundColor = UIColor.backgroundColor
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = UIColor.backgroundColor
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let hotPickLabel: UILabel = {
        let label = UILabel()
        label.text = "Hot pick"
        label.backgroundColor = UIColor(patternImage: UIImage(named: "fire")!)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElementPositions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupElementPositions()
    }
    
    func setupElementPositions(){
        addSubview(hotPickLabel)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        bringSubviewToFront(hotPickLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : hotPickLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : hotPickLabel]))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: self.bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: self.bounds.height/2)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
    }
    
}
