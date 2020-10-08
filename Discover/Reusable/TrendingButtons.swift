//
//  TrendingButtons.swift
//  Discover
//
//  Created by Natalija Krsnik on 02/10/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

class TrendingButtons: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButton()
    }
    
    /**
     Function that sets button properties for trending buttons (collored buttons on VenueListVC)
     */
    func setButton(){
        self.layer.cornerRadius = 15
        self.setTitleColor(UIColor.black, for: .normal)
        self.shadow(UIColor.darkGray)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
}
