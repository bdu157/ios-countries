//
//  DetailViewController.swift
//  RESTCountries
//
//  Created by Dongwoo Pae on 12/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyTextView: UITextView!
    @IBOutlet weak var languageTextView: UITextView!
    
    
    var country: Country? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    private func updateViews() {
        guard let country = country, isViewLoaded else {return}
        self.flagImageView.image = UIImage(named: country.alpha3Code.lowercased())
        self.nameLabel.text = country.name
        self.regionLabel.text = country.region
        self.capitalLabel.text = country.capital
        self.populationLabel.text = String(country.population)
        self.currencyTextView.text = country.currencies.map{$0.code + "\n"}.joined(separator: " ")
        self.languageTextView.text = country.languages.map{$0.name + "\n"}.joined(separator: " ")
    }

}
