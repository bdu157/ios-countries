//
//  CountryController.swift
//  RESTCountries
//
//  Created by Dongwoo Pae on 12/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case badData
    case noImage
}


//https://restcountries.eu/rest/v2/name/usa

class ContryController {

    var countries: [Country] = []
    
    var baseURL = URL(string: "https://restcountries.eu/rest/v2/name/")!
    
    func fetchContries(for searchTerm: String, completion:@escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let jsonDecodr = JSONDecoder()
            
            do {
                let jsonCountries = try jsonDecodr.decode([Country].self, from: data)
                self.countries = jsonCountries
                print(self.countries)
                completion(nil)
            } catch {
                NSLog("There is an error in decoding")
                completion(error)
                return
            }
        }.resume()
    }
    
    
    //fetchImage with sprites(imageURL)
       func fetchImage(at urlString: String, completion:@escaping(Result<UIImage, NetworkError>)->Void) {
           let imageURL = URL(string: urlString)!
           var request = URLRequest(url: imageURL)
           request.httpMethod = "GET"
           
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let _ = error {
                   completion(.failure(.otherError))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(.badData))
                   return
               }
               guard let image = UIImage(data: data) else {
                   completion(.failure(.noImage))
                   return
               }
               completion(.success(image))
           }.resume()
       }
    
    
    
    
}
