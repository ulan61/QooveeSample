//
//  ChooseCountrySettingsViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/7/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseCountrySettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    static func storyboardInstance() -> UIViewController?{
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }
    
    var sectionsCountries: [[Country]]!
    var sortedFirstLetters: [String]!
    var selectedIndexPath: IndexPath!
    var favoriteCountries = ["Россия", "Казахстан", "Узбекистан", "Китай"]
    
    @IBOutlet weak var footerView: UIView! {
        didSet{
            let shadowSize : CGFloat = 16.0
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: self.footerView.frame.size.width + shadowSize,
                                                       height: self.footerView.frame.size.height + shadowSize))
            self.footerView.layer.masksToBounds = false
            self.footerView.layer.shadowColor = UIColor(red: 214.0/255, green: 224.0/255, blue: 231/255, alpha: 1).cgColor
            self.footerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.footerView.layer.shadowOpacity = 0.3
            self.footerView.layer.shadowPath = shadowPath.cgPath
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var continueButton: UIButton!{
        didSet{
            continueButton.layer.cornerRadius = 10
            continueButton.backgroundColor = Colors.continueButtonColor
            continueButton.setTitle("ПРОДОЛЖИТЬ", for: .normal)
        }
    }
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.textColor = Colors.searchTextFieldColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let countries = getCountries()
        let firstLetters = countries.map { $0.firstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))
        self.sortedFirstLetters = uniqueFirstLetters.sorted()
        self.sectionsCountries = sortedFirstLetters.map { firstLetter in
            return countries
                .filter { $0.firstLetter == firstLetter } // only names with the same first letter in title
                .sorted { $0.name < $1.name }
        }
        UIApplication.shared.statusBarStyle = .lightContent
        
        addGradient()
        setBackImage()
        self.title = "Выбор страны"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favoriteCountries.count
        }
        else{
            return sectionsCountries[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        if indexPath.section == 0 {
            cell.countryNameLabel.text = favoriteCountries[indexPath.row]
            let code = localeForCountry(countryName: favoriteCountries[indexPath.row])
            cell.flagImageView.image = emojiFlag(code: code!).image()
        }
        else{
            let country = sectionsCountries[indexPath.section-1][indexPath.row]
            cell.countryNameLabel.text = country.name
            cell.flagImageView.image = country.emojiFlag.image()
        }
        
        if let selectedIndexPath = self.selectedIndexPath {
            if selectedIndexPath == indexPath {
                cell.checkImage = #imageLiteral(resourceName: "checkboxPressed")
            }
            else{
                cell.checkImage = nil
            }
        }
        else{
            cell.checkImage = nil
        }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCountries.count + 1
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
            headerLabel.text = "ИЗБРАННЫЕ"
        }
        else{
            headerLabel.text = self.sortedFirstLetters[section - 1]
        }
        headerLabel.textColor = Colors.searchTextFieldColor
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CountryTableViewCell
        self.selectedIndexPath = indexPath
        cell.checkImage = #imageLiteral(resourceName: "checkboxPressed")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CountryTableViewCell else{
            return
        }
        cell.checkImage = nil
    }
    
    func getCountries() -> [Country] {
        var countries: [Country] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "ru_RU").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            let flag = emojiFlag(code: code)
            let country = Country(name: name, emojiFlag: flag)
            countries.append(country)
        }
        
        return countries
    }
    
    func emojiFlag(code:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in code.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func localeForCountry(countryName : String) -> String?
    {
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "ru_RU").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            if countryName.lowercased() == name.lowercased() {
                return code
            }
        }
        return nil
    }

    
    func addGradient()  {
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


