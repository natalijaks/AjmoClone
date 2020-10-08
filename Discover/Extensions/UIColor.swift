//
//  UIColor.swift
//  Discover
//
//  Created by Natalija Krsnik on 29/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    static let headerColor = UIColor(red: 255/255, green: 141/255, blue: 0/255, alpha: 1)
    
    /**
     Function that returns UIColor from HEX string
     */
    func hexToRGB(_ hex: String) -> UIColor {
        var hexColor = hex
        
        if hexColor.hasPrefix("#"){ hexColor.remove(at: hexColor.startIndex) }
        
        var rgbColor: UInt64  = 0
        Scanner(string: hexColor).scanHexInt64(&rgbColor)
        
        return UIColor.init(red: CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgbColor & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat((rgbColor & 0x0000FF)) / 255.0,
                            alpha: 1.0)
    }
    
}
