//
//  VenueButtons.swift
//  Discover
//
//  Created by Natalija Krsnik on 29/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

class VenueButtons: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButton()
    }
    
    /**
     Function that sets button properties for venue buttons (buttons on Main view controller)
     */
    func setButton(){
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 25
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
    }
    
}
