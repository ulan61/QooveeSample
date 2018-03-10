//
//  CountryUtil.swift
//  QooveeSamples
//
//  Created by Ulan Nurmamatov on 3/10/18.
//  Copyright © 2018 Ulan Nurmamatov. All rights reserved.
//

import Foundation

class CountryUtil {
    static let shared = CountryUtil()
    
    func getSortedCountriesBySection() -> (firstLetters: [String], countries: [[Country]]) {
        let countries = getAllCountries()
        let firstLetters = countries.map { $0.getFirstLetter() }
        let uniqueFirstLetters = Array(Set(firstLetters))
        let sortedFirstLetters = uniqueFirstLetters.sorted()
        let sortedCountries = sortedFirstLetters.map { firstLetter in
            return countries
                .filter { $0.getFirstLetter() == firstLetter && $0.getPhoneNumberCode() != nil }
                .sorted { $0.getName() < $1.getName() }
        }
        return (sortedFirstLetters, sortedCountries)
    }
    
    private func getAllCountries() -> [Country] {
        var countries: [Country] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            let country = Country(name: name, code: code)
            if country.getPhoneNumberCode() != nil {
                countries.append(country)
            }
        }
        
        return countries
    }
}
