//
//  DetailVC.swift
//  Discover
//
//  Created by Natalija Krsnik on 01/10/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var masterView = UIView()
    var name: String = ""
    var type: String = ""
    var smoking: Int = 0
    var location: String = ""
    var desc: String = ""
    var primaryTag: String = ""
    var tagNames: [String] = []
    var secondaryTagNames: [String] = []
    var detailImage: String = ""
    var tag: String = ""
    
    lazy var contentView = CGSize(width: view.frame.width, height: view.frame.height + 100)
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame:.zero)
        view.contentSize = contentView
        view.frame = self.view.bounds
        view.backgroundColor = .white
        return view
    }()
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 10, y: 10, width: 100, height: 70)
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
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
    
    let btnOpenTime: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    let btnLocation: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(named:"location"), for: .normal)
        return button
    }()
    
    let btnSmoking: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.3)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Smoking", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    let lblTitleDes: UILabel = {
        let label = UILabel()
        label.text = "Ideal place for..."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let txtDescription: UITextView = {
        let txt = UITextView()
        txt.text = "Title description"
        txt.textColor = .black
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.sizeToFit()
        txt.isScrollEnabled = false
        
        return txt
    }()
    
    let lblTag: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let lblTagList: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let lblExpect: UILabel = {
        let label = UILabel()
        label.text = "What to expect"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let lblExpectList: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setElementsOnScreen()
        setData()
    }
    
    func setElementsOnScreen(){
        scrollView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 100)
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(masterView)
        
        masterView.addSubview(imgView)
        masterView.addSubview(nameLabel)
        masterView.addSubview(typeLabel)
        masterView.addSubview(btnOpenTime)
        masterView.addSubview(btnLocation)
        masterView.addSubview(btnSmoking)
        masterView.addSubview(lblTitleDes)
        masterView.addSubview(txtDescription)
        masterView.addSubview(lblTag)
        masterView.addSubview(lblTagList)
        masterView.addSubview(lblExpect)
        masterView.addSubview(lblExpectList)
        
        masterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            masterView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            masterView.widthAnchor.constraint(equalToConstant: scrollView.bounds.width),
            masterView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: masterView.topAnchor, constant: 0),
            imgView.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 0),
            imgView.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: 0),
            imgView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        btnOpenTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnOpenTime.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            btnOpenTime.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        btnLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnLocation.topAnchor.constraint(equalTo: btnOpenTime.bottomAnchor, constant: 10),
            btnLocation.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        btnSmoking.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnSmoking.topAnchor.constraint(equalTo: btnLocation.bottomAnchor, constant: 10),
            btnSmoking.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 0),
            btnSmoking.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: 0),
            btnSmoking.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        lblTitleDes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTitleDes.topAnchor.constraint(equalTo: btnSmoking.bottomAnchor, constant: 10),
            lblTitleDes.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        txtDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            txtDescription.topAnchor.constraint(equalTo: lblTitleDes.bottomAnchor, constant: 10),
            txtDescription.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20),
            txtDescription.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -20)
        ])
        
        lblTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTag.topAnchor.constraint(equalTo: txtDescription.bottomAnchor, constant: 30),
            lblTag.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        lblTagList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTagList.topAnchor.constraint(equalTo: lblTag.bottomAnchor, constant: 10),
            lblTagList.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20),
            lblTagList.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -10)
        ])
        
        lblExpect.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblExpect.topAnchor.constraint(equalTo: lblTagList.bottomAnchor, constant: 20),
            lblExpect.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20)
        ])
        
        lblExpectList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblExpectList.topAnchor.constraint(equalTo: lblExpect.bottomAnchor, constant: 20),
            lblExpectList.leadingAnchor.constraint(equalTo: masterView.leadingAnchor, constant: 20),
            lblExpectList.trailingAnchor.constraint(equalTo: masterView.trailingAnchor, constant: -10)
        ])
        
    }
    
    func setData(){
        nameLabel.text = name
        typeLabel.text = type
        if smoking == 0 {
            btnSmoking.setTitle("No smoking area", for: .normal)
        }else{
            btnSmoking.setTitle("Smoking area", for: .normal)
        }
        
        btnLocation.setTitle(location, for: .normal)
        lblTag.text = tag
        
        //html string
        let htmlData = NSString(string: desc).data(using: String.Encoding.unicode.rawValue)
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        txtDescription.attributedText = attributedString
        
        let tags = tagNames.joined(separator: ", ")
        lblTagList.text = tags
        
        let secondTags = secondaryTagNames.joined(separator: ", ")
        lblExpectList.text = secondTags
        
        //Get image
        let imgDetail = detailImage
        if imgDetail != "" {
            let url = URL(string:(imgDetail))
            let d = URLSession.shared.dataTask(with: url!) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.imgView.image = UIImage(data: data)
                        
                    }
                }
            }
            d.resume()
        }
    }
    
    
}
