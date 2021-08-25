//
//  ViewController.swift
//  Calculator
//
//  Created by Alexander Rojas Benavides on 8/23/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deleteBtn.layer.cornerRadius = 30
        deleteBtn.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        clearBtn.layer.cornerRadius = 30
        clearBtn.layer.maskedCorners = [.layerMinXMinYCorner]
        
    }


}

