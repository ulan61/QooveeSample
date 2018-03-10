//
//  ChooseCountryLoginViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseCountryViewController: UIViewController {
    
    private var tableView: UITableView!
    private var searchTextField: UITextField!
    private var searchIconImageView: UIImageView!
    
    private var selectedIndexPath: IndexPath!
    private var countries: [[Country]]!
    private var firstLetters: [String]!
    private var favoriteCountries = [Country(name: "Russia", code: "RU"), Country(name: "Kazakhstan", code: "KZ"), Country(name: "Uzbekistan", code: "UZ"), Country(name: "China", code: "CN")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        countries = CountryUtil.shared.getSortedCountriesBySection().countries
        firstLetters = CountryUtil.shared.getSortedCountriesBySection().firstLetters
        setupTableView()
        addGradientToBar()
        setBackImage()
        UIApplication.shared.statusBarStyle = .lightContent
        self.title = "Выбор страны"
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryLoginTableViewCell.self, forCellReuseIdentifier: "countryLoginCell")
        view.addSubview(tableView)
    }
    
    func addGradientToBar()  {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5);
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5);
        gradient.colors = [Colors.gradientFirstColor.cgColor, Colors.gradientSecondColor.cgColor, Colors.gradientThirdColor.cgColor]
        self.view.layer.addSublayer(gradient)
    }
    
    func setBackImage() {
        let backImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

extension ChooseCountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteCountries.count
        }
        else{
            return countries[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryLoginCell", for: indexPath) as! CountryLoginTableViewCell
        
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

extension ChooseCountryViewController: UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
