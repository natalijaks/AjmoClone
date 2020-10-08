//
//  ReusableFunctions.swift
//  Discover
//
//  Created by Natalija Krsnik on 30/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

class ReusableFunctions {
    static let shared = ReusableFunctions() //Using singleton pattern
    
    /**
     Function that sets large and normal title for navigation bar
     */
    func setNavigationLargeTitle(_ vc: UIViewController){
        
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        vc.navigationController?.navigationBar.tintColor = UIColor.backgroundColor
        
        //set background- and text color for normal and large navbar title
        let app = UINavigationBarAppearance()
        app.backgroundColor = UIColor.headerColor
        
        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.backgroundColor]
        app.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.backgroundColor]
        
        vc.navigationController?.navigationBar.scrollEdgeAppearance = app
        vc.navigationController?.navigationBar.standardAppearance = app
    }
    
}
