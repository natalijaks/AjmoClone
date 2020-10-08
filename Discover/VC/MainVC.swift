//
//  MainVC.swift
//  Discover
//
//  Created by Natalija Krsnik on 29/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//
// Images from web: https://www.freeiconspng.com/img/4870 >fire vector icon png<
//  https://www.freeiconspng.com/img/1731">Address, location, marker, pin, place, point, pointer icon | Icon <

import UIKit

class MainVC: UIViewController {
    
    var venues = [Venues]()
    var titleLabel = UILabel()
    var venuesStackView = UIStackView()
    let buttonTitles: [String] = ["Bar", "Nightclub", "Other"]
    var buttonImages: [String] = ["bar.png", "nightclub.png", "other.png"]
    
    var venueCat = [VenueCategories]()
    var customPicks = [CustomPicks]()
    var trendings = [Trending]()
    var totalTrendings = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        navigationItem.title = "Discover"
        ReusableFunctions.shared.setNavigationLargeTitle(self)
        
        parseJSON()
        setTitleLabel()
        configureStackView()
    }
    
    func configureStackView(){
        view.addSubview(venuesStackView)
        venuesStackView.axis = .vertical
        venuesStackView.distribution = .fillEqually
        venuesStackView.spacing = 20
        
        fillStackView()
        setStackView()
    }
    
    func setStackView(){
        venuesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venuesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            venuesStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            venuesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            venuesStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func setTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.text = "Venues"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func fillStackView(){
        for i in 0...buttonTitles.count - 1 {
            let btn = VenueButtons()
            btn.setTitle(buttonTitles[i], for: .normal)
            btn.setImage(UIImage(named: buttonImages[i]), for: .normal)
            btn.tag = i
            btn.alignVertically()
            btn.addTarget(self, action: #selector(openVenues(_:)), for: .touchUpInside)
            venuesStackView.addArrangedSubview(btn)
            venuesStackView.isUserInteractionEnabled = false
        } 
    }
    
    @objc func openVenues(_ sender: UIButton){
        defaults.set(sender.currentTitle, forKey: "currentTitle")
        let vc = VenuesListVC()
        vc.venCat = venueCat
        vc.custPicks = customPicks
        vc.trend = trendings
        vc.totalTrending = totalTrendings
        vc.btnTag = sender.tag
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func parseJSON(){
        let url = "https://api.ajmo.hr/v3/venue/dashboard"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        self.venuesStackView.isUserInteractionEnabled = true
                        do {
                            let result = try JSONDecoder().decode(Venues.self, from: data)
                            
                            let venCat = result.data.venueCategories
                            let custPick = result.data.customPicks
                            let trend = result.data.trending
                            
                            venCat.forEach { element in
                                self.venueCat.append(element)
                            }
                            custPick.forEach { element in
                                self.customPicks.append(element)
                            }
                            trend.forEach { element in
                                self.trendings.append(element)
                                self.totalTrendings += 1
                            }
                            
                        } catch let error {
                            print(error)
                        }
                    }
                    
                }
                
            }.resume()
        }
    }
}
