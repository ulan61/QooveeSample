//
//  ChooseCountryLoginViewController.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/9/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import UIKit

class ChooseCountryLoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static func storyboardInstance() -> UIViewController?{
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController
    }
    
    var sectionsCountries: [[Country]]!
    var sortedFirstLetters: [String]!
    var selectedIndexPath: IndexPath!
    var favoriteCountries = ["Russia", "Kazakhstan", "Uzbekistan", "China"]
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
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
                .filter { $0.firstLetter == firstLetter} // only names with the same first letter in title
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
            cell.phoneNumberCodeLabel.text = "+" + getCountryCallingCode(countryRegionCode: code!)!
        }
        else{
            let country = sectionsCountries[indexPath.section-1][indexPath.row]
            cell.countryNameLabel.text = country.name
            cell.flagImageView.image = country.emojiFlag.image()
            cell.phoneNumberCodeLabel.text = "+" + country.phoneNumberCode
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
            headerLabel.text = "FAVORITES"
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
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func getCountries() -> [Country] {
        var countries: [Country] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            let flag = emojiFlag(code: code)
            let phoneNumberCode = getCountryCallingCode(countryRegionCode: code) ?? ""
            if phoneNumberCode != ""{
                let country = Country(name: name, emojiFlag: flag, phoneNumberCode: phoneNumberCode)
                countries.append(country)
            }
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
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
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
    
    func getCountryCallingCode(countryRegionCode:String)->String?{
        
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AC":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryRegionCode]
        return countryDialingCode
        
    }
}
