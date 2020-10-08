//
//  UIButton.swift
//  Discover
//
//  Created by Natalija Krsnik on 29/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /** function that aligns text and image in UIButton*/
    
    func alignVertically(spacing: CGFloat = 6.0) {
        guard let imgSize = imageView?.image?.size,
            let text = titleLabel?.text,
            let font = titleLabel?.font
            else { return }
        
        titleEdgeInsets = UIEdgeInsets(top: 0.0,
                                       left:-imgSize.width,
                                       bottom: -(imgSize.height + spacing),
                                       right: 0.0
        )
        
        let titleSize = text.size(withAttributes: [.font: font])
        imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: 20,
            bottom: 0.0,
            right: -titleSize.width
        )
        
        let edgeOffset = abs(titleSize.height - imgSize.height) / 2.0
        
        contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
    
    /**
     Sets label shadow
     - Parameters:
     - color: Color of the shadow
     */
    func shadow(_ color: UIColor) {
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3
        self.layer.shadowColor = color.cgColor
    }
}
