//
//  ChooseCountryLoginViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit
import PinLayout

class ChooseCountryBaseViewController: UIViewController {
    
    internal var tableView: UITableView!
    private var searchTextField: UITextField!
    private var searchIconImageView: UIImageView!
    
    private var selectedIndexPath: IndexPath!
    private var countries: [[Country]]!
    private var firstLetters: [String]!
    private var favoriteCountries = [Country(name: "Russia", code: "RU"), Country(name: "Kazakhstan", code: "KZ"), Country(name: "Uzbekistan", code: "UZ"), Country(name: "China", code: "CN")]

    private var reuseIdentifier: String!
    
    private var navBarHeight: CGFloat!{
        return self.navigationController?.navigationBar.bounds.height
    }
    
    private var statusBarHeight: CGFloat!{
        return UIApplication.shared.statusBarFrame.height
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchIconImageView.pin.top(navBarHeight + statusBarHeight + 16).left(20).width(16).height(16)
        searchTextField.pin.after(of: searchIconImageView).marginLeft(14).right(20).top(navBarHeight + statusBarHeight + 16)
                           .width(self.view.bounds.width - 40).aspectRatio((self.view.bounds.width - 40)/18.0)
        tableView.pin.below(of: [searchIconImageView,searchTextField]).marginTop(16).left(0).right(0).bottom(0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        countries = CountryUtil.shared.getSortedCountriesBySection().countries
        firstLetters = CountryUtil.shared.getSortedCountriesBySection().firstLetters
        setupSearchTextField()
        setupSearchIcon()
        addGradientToBar()
        setBackImage()
        UIApplication.shared.statusBarStyle = .lightContent
        self.title = "Выбор страны"
        self.view.backgroundColor = .white
    }
    
    internal func setupTableView(cellClass: AnyClass?, reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
        tableView = UITableView(frame: CGRect(x: 0, y: 50, width: self.view.bounds.width, height: self.view.bounds.height - 50))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        self.view.addSubview(tableView)
    }
    
    private func setupSearchIcon(){
        searchIconImageView = UIImageView(frame: CGRect(x: 20, y: 17, width: 16, height: 16))
        searchIconImageView.image = #imageLiteral(resourceName: "iconSearch")
        self.view.addSubview(searchIconImageView)
    }
    
    private func setupSearchTextField(){
        searchTextField = UITextField(frame: CGRect(x: 20, y: 17, width: 98, height: 18))
        searchTextField.placeholder = "Поиск страны"
        searchTextField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        self.view.addSubview(searchTextField)
    }
    
    private func addGradientToBar()  {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: statusBarHeight + navBarHeight)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5);
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5);
        gradient.colors = [Colors.gradientFirstColor.cgColor, Colors.gradientSecondColor.cgColor, Colors.gradientThirdColor.cgColor]
        self.view.layer.addSublayer(gradient)
    }
    
    private func setBackImage() {
        let backImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

extension ChooseCountryBaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteCountries.count
        }
        else{
            return countries[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CountryBaseTableViewCell
        
        if indexPath.section == 0 {
            let country = favoriteCountries[indexPath.row]
            cell.initWith(country: country)
        }
        else{
            let country = countries[indexPath.section-1][indexPath.row]
            cell.initWith(country: country)
        }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return firstLetters.count + 1
    }
}

extension ChooseCountryBaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.headerColor
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 8, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont.boldSystemFont(ofSize: 12)
        headerLabel.addCharacterSpacing()
        
        if section == 0 {
            headerLabel.text = "FAVORITES"
        }
        else{
            headerLabel.text = self.firstLetters[section - 1]
        }
        
        headerLabel.textColor = Colors.searchTextFieldColor
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
}
