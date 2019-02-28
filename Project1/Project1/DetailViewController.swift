//
//  DetailViewController.swift
//  Project1
//
//  Created by Vlastimir Radojevic on 27/2/19.
//  Copyright © 2019 Vlastimir Radojevic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImag: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedImag
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImag {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
