//
//  VenuesListVC.swift
//  Discover
//
//  Created by Natalija Krsnik on 30/09/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class VenuesListVC: UIViewController {
    
    //MARK:- Elements on screen
    var masterView = UIView()
    var collViewVenueImg: UICollectionView!
    var tblList: UITableView = UITableView()
    var customCellIdentifier = "venueCell"
    var customTblCellIndentifier = "listCell"
    var safeArea: UILayoutGuide = UILayoutGuide()
    var tableView = UIView()

    var venCat = [VenueCategories]()
    var custPicks = [CustomPicks]()
    var trend = [Trending]()
    var filteredVenues = [Trending]()
    var filteredByHotPick = [Trending]()
    var totalTrending: Int = 0
    var btnTag = 0
    
    lazy var contentView = CGSize(width: view.frame.width, height: view.frame.height + 100)
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame:.zero)
        view.backgroundColor = .clear
        view.contentSize = contentView
        view.frame = self.view.bounds
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        return view
    }()
    
    let lblTrending: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblAllVenues: UILabel = {
        let label = UILabel()
        label.text = "All venues"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var btnL1Trending = UIButton()
    var btnL2Trending = UIButton()
    var btnR1Trending = UIButton()
    var btnR2Trending = UIButton()
    
    
    //MARK:- Common functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColor
        safeArea = view.layoutMarginsGuide
        
        filterByVenue()
        filterByHotPick()
        setNavControllerProperties()
        setTrendingButtons()
        setElementsOnScreen()
        
        setBtnTxtAndColor()

    }
    
    //MARK:- Custom functions
    func setNavControllerProperties(){
        navigationItem.title = defaults.string(forKey: "currentTitle")
    }
    
    func filterByVenue(){
        let title = defaults.string(forKey: "currentTitle")
        self.filteredVenues = trend.filter { p in
            (p.venue_categories?.contains(where: { $0.name == title }))!
        }
    }
    
    func filterByHotPick(){
       self.filteredByHotPick = filteredVenues.filter { p in
            p.bat == 1
        }
    }
    
    func setElementsOnScreen(){
        tblList.tableFooterView = UIView()
        
        scrollView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 100)

        view.addSubview(scrollView)
        scrollView.addSubview(masterView)
        scrollView.addSubview(tableView)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 250, height: 200)
        layout.scrollDirection = .horizontal
        collViewVenueImg = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collViewVenueImg.delegate = self
        collViewVenueImg.dataSource = self
        collViewVenueImg.register(VenueCVCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        collViewVenueImg.backgroundColor = UIColor.backgroundColor
        collViewVenueImg.isPagingEnabled = true
        
        masterView.addSubview(collViewVenueImg)
        masterView.addSubview(lblTrending)
        masterView.addSubview(btnL1Trending)
        masterView.addSubview(btnL2Trending)
        masterView.addSubview(btnR1Trending)
        masterView.addSubview(btnR2Trending)
        masterView.addSubview(lblAllVenues)

        masterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            masterView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            masterView.widthAnchor.constraint(equalToConstant: scrollView.bounds.width),
            masterView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        collViewVenueImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collViewVenueImg.topAnchor.constraint(equalTo: masterView.topAnchor, constant: 10),
            collViewVenueImg.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 40),
            collViewVenueImg.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -40)
        ])
        
        lblTrending.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTrending.topAnchor.constraint(equalTo: collViewVenueImg.bottomAnchor, constant: 10),
            lblTrending.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        btnL1Trending.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnL1Trending.topAnchor.constraint(equalTo: lblTrending.bottomAnchor, constant: 30),
            btnL1Trending.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 40),
            btnL1Trending.heightAnchor.constraint(equalToConstant: 50),
            btnL1Trending.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        btnL2Trending.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnL2Trending.topAnchor.constraint(equalTo: btnL1Trending.bottomAnchor, constant: 10),
            btnL2Trending.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 40),
            btnL2Trending.heightAnchor.constraint(equalToConstant: 50),
            btnL2Trending.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        btnR1Trending.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnR1Trending.topAnchor.constraint(equalTo: lblTrending.bottomAnchor, constant: 30),
            btnR1Trending.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -40),
            btnR1Trending.heightAnchor.constraint(equalToConstant: 50),
            btnR1Trending.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        btnR2Trending.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnR2Trending.topAnchor.constraint(equalTo: btnR1Trending.bottomAnchor, constant: 10),
            btnR2Trending.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -40),
            btnR2Trending.heightAnchor.constraint(equalToConstant: 50),
            btnR2Trending.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        lblAllVenues.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblAllVenues.topAnchor.constraint(equalTo: btnL2Trending.bottomAnchor, constant: 30),
            lblAllVenues.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20),
            lblAllVenues.bottomAnchor.constraint(equalTo: masterView.bottomAnchor, constant: 0)
        ])
        
        
        let totalHeight = (totalTrending * 100 + 200)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: masterView.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(totalHeight)),
            tableView.widthAnchor.constraint(equalToConstant: scrollView.bounds.width)
        ])
        
        tableView.addSubview(tblList)

        tblList.register(ListTblCell.self, forCellReuseIdentifier: customTblCellIndentifier)
        tblList.delegate = self
        tblList.dataSource = self
        tblList.backgroundColor = .clear
        tblList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tblList.topAnchor.constraint(equalTo: tableView.topAnchor),
            tblList.leftAnchor.constraint(equalTo: view.leftAnchor),
            tblList.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            tblList.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setTrendingButtons(){
        btnL1Trending = TrendingButtons()
        btnL1Trending.frame = CGRect(x: 0, y: 100, width: 100, height: 50)
        btnL1Trending.addTarget(self, action: #selector(openTrendings(_:)), for: .touchUpInside)
        
        btnL2Trending = TrendingButtons()
        btnL2Trending.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btnL2Trending.addTarget(self, action: #selector(openTrendings(_:)), for: .touchUpInside)
        
        btnR1Trending = TrendingButtons()
        btnR1Trending.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btnR1Trending.addTarget(self, action: #selector(openTrendings(_:)), for: .touchUpInside)
       
        btnR2Trending = TrendingButtons()
        btnR2Trending.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        btnR2Trending.addTarget(self, action: #selector(openTrendings(_:)), for: .touchUpInside)
    }
    
    func setBtnTxtAndColor(){
        btnL1Trending.setTitle(self.venCat[btnTag].popularTags[0].tag.name + " (" + String(self.venCat[btnTag].popularTags[0].tags) + ")", for: .normal)
        btnL1Trending.accessibilityLabel = self.venCat[btnTag].popularTags[0].tag.name
        btnL1Trending.backgroundColor = UIColor().hexToRGB(self.venCat[btnTag].popularTags[0].tag.color)
     
        btnR1Trending.setTitle(self.venCat[btnTag].popularTags[1].tag.name + " (" + String(self.venCat[btnTag].popularTags[1].tags) + ")", for: .normal)
        btnR1Trending.accessibilityLabel = self.venCat[btnTag].popularTags[1].tag.name
        btnR1Trending.backgroundColor = UIColor().hexToRGB(self.venCat[btnTag].popularTags[1].tag.color)
        
        btnL2Trending.setTitle(self.venCat[btnTag].popularTags[2].tag.name + " (" + String(self.venCat[btnTag].popularTags[2].tags) + ")", for: .normal)
        btnL2Trending.accessibilityLabel = self.venCat[btnTag].popularTags[2].tag.name
        btnL2Trending.backgroundColor = UIColor().hexToRGB(self.venCat[btnTag].popularTags[2].tag.color)
        
        btnR2Trending.setTitle(self.venCat[btnTag].popularTags[3].tag.name + " (" + String(self.venCat[btnTag].popularTags[3].tags) + ")", for: .normal)
        btnR2Trending.accessibilityLabel = self.venCat[btnTag].popularTags[3].tag.name
        btnR2Trending.backgroundColor = UIColor().hexToRGB(self.venCat[btnTag].popularTags[3].tag.color)
    }

    @objc func openTrendings(_ sender: UIButton){
        let vc = FilteredListVC()
        vc.trend = self.trend
        vc.filterTitle = sender.accessibilityLabel!
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension VenuesListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredByHotPick.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.filteredByHotPick.sort(by: {$0.id < $1.id})
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! VenueCVCell
        cell.backgroundColor = UIColor.backgroundColor
        cell.nameLabel.text = filteredByHotPick[indexPath.item].name
        cell.subtitleLabel.text = filteredByHotPick[indexPath.item].subtitle
        
        cell.hotPickLabel.isHidden = true
        if filteredVenues[indexPath.item].bat == 1{
          cell.hotPickLabel.isHidden = false
        }
        
        //Get image
        let imgVenue = filteredByHotPick[indexPath.item].picture_url
        if imgVenue != "" {
           let url = URL(string:(imgVenue!))
            let d = URLSession.shared.dataTask(with: url!) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                }
            }
            d.resume()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.name = filteredByHotPick[indexPath.item].name
        vc.type = filteredByHotPick[indexPath.item].subtitle
        vc.smoking = filteredByHotPick[indexPath.item].smoking_area ?? 0
        vc.location = filteredByHotPick[indexPath.item].address
        vc.desc = filteredByHotPick[indexPath.item].description
        vc.primaryTag = filteredByHotPick[indexPath.item].primary_tag_group ?? "No tags"
        vc.detailImage = filteredByHotPick[indexPath.item].picture_url ?? ""
        vc.tag = filteredByHotPick[indexPath.item].primary_tag_group ?? ""
         
        for value in filteredByHotPick[indexPath.item].allTags.primaryTags {
            vc.tagNames.append(value.name)
        }
        for value in filteredByHotPick[indexPath.item].allTags.secondaryTags {
            vc.secondaryTagNames.append(value.name)
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension VenuesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVenues.count//totalTrending
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.filteredVenues.sort(by: {$0.name < $1.name})
        
        let cell = tableView.dequeueReusableCell(withIdentifier: customTblCellIndentifier, for: indexPath) as! ListTblCell
        cell.nameLabel.text = filteredVenues[indexPath.item].name
        cell.subtitleLabel.text = filteredVenues[indexPath.item].subtitle
        cell.addressLabel.text = filteredVenues[indexPath.item].address
        cell.hotPickLabel.isHidden = true
        if filteredVenues[indexPath.item].bat == 1{
            cell.hotPickLabel.isHidden = false
        }
        
        //Get image
        let imgVenue = filteredVenues[indexPath.item].picture_url
        if imgVenue != "" {
            let url = URL(string:(imgVenue!))
            let d = URLSession.shared.dataTask(with: url!) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.venueImage.image = UIImage(data: data)
                    }
                }
            }
            d.resume()
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.name = filteredVenues[indexPath.item].name
        vc.type = filteredVenues[indexPath.item].subtitle
        vc.smoking = filteredVenues[indexPath.item].smoking_area ?? 0
        vc.location = filteredVenues[indexPath.item].address
        vc.desc = filteredVenues[indexPath.item].description
        vc.primaryTag = filteredVenues[indexPath.item].primary_tag_group ?? "No tags"
        vc.detailImage = filteredVenues[indexPath.item].picture_url ?? ""
        vc.tag = filteredVenues[indexPath.item].primary_tag_group ?? ""
        
        for value in filteredVenues[indexPath.item].allTags.primaryTags {
            vc.tagNames.append(value.name)
        }
        for value in filteredVenues[indexPath.item].allTags.secondaryTags {
            vc.secondaryTagNames.append(value.name)
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: totalTrending * 130)
    }
    
}
