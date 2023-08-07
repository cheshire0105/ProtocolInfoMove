//
//  SecondViewController.swift
//  ProtocolInfoAndTableView
//
//  Created by cheshire on 2023/08/04.
//

import UIKit

class SecondViewController: UIViewController, ProtocolData { // 프로토콜을 채택해서 편지를 받는 방법을 알고 있다.
    
    
    var data: String? // 편지함
    
    // 편지를 받으면 넣어놓을 편지함
    func passData(_ data: String) {
        self.data = data
    }
    

    
    
    @IBOutlet weak var textFieldSecondView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            // 편지를 읽는 것.
            textFieldSecondView.text = data
        }
    }
    

}

