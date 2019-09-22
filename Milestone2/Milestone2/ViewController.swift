//
//  ViewController.swift
//  Milestone2
//
//  Created by Vlastimir on 8/18/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        navigationItem.leftBarButtonItems = [trashButton, shareButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
    }

    
    @objc func addItem() {
        let alertController = UIAlertController(title: "Add new shopping item", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler:nil)

        let addAction = UIAlertAction(title: "Add", style: .default, handler: {
            [weak self, weak alertController] _ in
            guard let item = alertController?.textFields?.first?.text else { return }
            self?.addShoppingItem(item)
        })
        alertController.addAction(addAction)
        self.present(alertController, animated: true)
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list = shoppingList.joined(separator: "\n")
        let ac = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        self.present(ac, animated: true, completion: nil)
    }
    
    func addShoppingItem(_ item: String) {
        
        shoppingList.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

