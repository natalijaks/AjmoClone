//
//  FilteredListVC.swift
//  Discover
//
//  Created by Natalija Krsnik on 01/10/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class FilteredListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var filteredTblList: UITableView = UITableView()
    var customTblFilterIndentifier = "listCell"
    var trend = [Trending]()
    var filterTitle = ""
    var filteredArray = [Trending]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = filterTitle
        filter()
        setElementsOnScreen()
    }
    
    func filter(){
        filteredArray = trend.filter { tag in
            tag.allTags.primaryTags.contains(where: { $0.name == filterTitle }) ||
                tag.allTags.secondaryTags.contains(where: { $0.name == filterTitle })
        }
    }
    
    func setElementsOnScreen(){
        view.addSubview(filteredTblList)
        
        filteredTblList.register(ListTblCell.self, forCellReuseIdentifier: customTblFilterIndentifier)
        filteredTblList.delegate = self
        filteredTblList.dataSource = self
        filteredTblList.tableFooterView = UIView()
        
        filteredTblList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filteredTblList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filteredTblList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            filteredTblList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filteredTblList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }

}


extension FilteredListVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.filteredArray.sort(by: {$0.name < $1.name})
        let cell = tableView.dequeueReusableCell(withIdentifier: customTblFilterIndentifier, for: indexPath) as! ListTblCell
        
        cell.nameLabel.text = filteredArray[indexPath.item].name
        cell.addressLabel.text = filteredArray[indexPath.item].address
        
        //Get image
        let imgVenue = filteredArray[indexPath.item].picture_url
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.name = filteredArray[indexPath.item].name
        vc.type = filteredArray[indexPath.item].subtitle
        vc.smoking = filteredArray[indexPath.item].smoking_area ?? 0
        vc.location = filteredArray[indexPath.item].address
        vc.desc = filteredArray[indexPath.item].description
        vc.primaryTag = filteredArray[indexPath.item].primary_tag_group ?? "No tags"
        vc.detailImage = filteredArray[indexPath.item].picture_url ?? ""
        vc.tag = filteredArray[indexPath.item].primary_tag_group ?? ""
        
        for value in filteredArray[indexPath.item].allTags.primaryTags {
            vc.tagNames.append(value.name)
        }
        for value in filteredArray[indexPath.item].allTags.secondaryTags {
            vc.secondaryTagNames.append(value.name)
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

