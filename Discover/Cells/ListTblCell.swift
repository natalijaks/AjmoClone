//
//  ListTblCell.swift
//  Discover
//
//  Created by Natalija Krsnik on 30/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class ListTblCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElementPositions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let hotPickLabel: UILabel = {
        let label = UILabel()
        label.text = "...."
        label.backgroundColor = UIColor(patternImage: UIImage(named: "fire")!)
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 3
        label.layer.shadowColor = UIColor.white.cgColor
        return label
    }()
    
    let venueImage: UIImageView = {
        let img = UIImage(named: "bar")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 10, y: 10, width: 100, height: 70)
        return imgView
    }()
    
    func setupElementPositions(){
        addSubview(hotPickLabel)
        addSubview(venueImage)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(addressLabel)
        
        bringSubviewToFront(hotPickLabel)
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : hotPickLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-130-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-130-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : subtitleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-130-[v3]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3" : addressLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : hotPickLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : subtitleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v3]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3" : addressLabel]))
        
    }
}
