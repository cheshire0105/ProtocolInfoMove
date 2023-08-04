//
//  SecondViewController.swift
//  ProtocolInfoAndTableView
//
//  Created by cheshire on 2023/08/04.
//

import UIKit

class SecondViewController: UIViewController, ProtocolData {
    
    
    
    var data: String? // New property to store the data
    
    
    func passData(_ data: String) {
        self.data = data
    }
    
    
    
    
    
    @IBOutlet weak var textFieldSecondView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            textFieldSecondView.text = data
        }
    }
    
    
    
    
    
}

