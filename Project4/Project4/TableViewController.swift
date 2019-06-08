//
//  TableViewController.swift
//  Project4
//
//  Created by Vlastimir on 6/8/19.
//  Copyright © 2019 Vlastimir. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websiteList = [String]()
    var delegate: OpenWebsite?

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websiteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = websiteList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        delegate?.openWebsite(tableView.cellForRow(at: indexPath)!)
    }
}
