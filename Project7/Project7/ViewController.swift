//
//  ViewController.swift
//  Project7
//
//  Created by Vlastimir on 9/28/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITextFieldDelegate {
    
    var petitions = [Petition]()
    var filterString = String()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .done, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(openFilterAC))
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from Wheeler people api of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func openFilterAC() {
        let ac = UIAlertController(title: "Filter by", message: nil, preferredStyle: .alert)
        ac.addTextField { [weak self] textField in
            textField.delegate = self
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.filterList()
        }))
        present(ac, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        filterString = textField.text!
    }
    
    func filterList() {
        if filterString.isEmpty {
            filteredPetitions = petitions
        } else {
            filteredPetitions = []
            filteredPetitions = petitions.filter {
                $0.title.lowercased().range(of: filterString.lowercased()) != nil
            }
        }
        tableView.reloadData()
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed, please check your connection and try again.", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(ac, animated: true)
        }
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

