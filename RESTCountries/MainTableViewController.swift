//
//  MainTableViewController.swift
//  RESTCountries
//
//  Created by Dongwoo Pae on 12/7/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    let countryController = ContryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.countryController.countries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let country = self.countryController.countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.region
        cell.imageView?.image = UIImage(named: country.alpha3Code.lowercased())
        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSeeDetail" {
            guard let detailVC = segue.destination as? DetailViewController,
                let selectedRow = tableView.indexPathForSelectedRow else {return}
            let country = self.countryController.countries[selectedRow.row]
            detailVC.country = country
        }
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //add fetch here using searchBar.text
        let searchTerm = searchBar.text!
        self.countryController.fetchContries(for: searchTerm) { (error) in
            if let error = error {
                NSLog("there is an error in fetching countries: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
