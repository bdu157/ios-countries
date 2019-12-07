//
//  Country.swift
//  RESTCountries
//
//  Created by Dongwoo Pae on 12/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

struct Country: Codable {
    let name: String
    let alpha3Code: String
    let region: String
    let capital: String
    let population: Int
    let currencies: [Currency]
    
    struct Currency: Codable {
        let code: String
    }
    
    let languages: [Language]
    
    struct Language: Codable {
        let name: String
    }
    
}
