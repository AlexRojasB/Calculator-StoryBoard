//
//  ViewController.swift
//  Calculator
//
//  Created by Alexander Rojas Benavides on 8/23/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let myData = ["first", "second", "third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deleteBtn.layer.cornerRadius = 30
        deleteBtn.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        clearBtn.layer.cornerRadius = 30
        clearBtn.layer.maskedCorners = [.layerMinXMinYCorner]
        
        let nib = UINib(nibName: "PreviousOperationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PreviousOperationTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.transform = tableView.transform.rotated(by: 3.14159)
    }
    
    //table funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOperationTableViewCell", for: indexPath) as! PreviousOperationTableViewCell
        cell.resultLabel?.text = "\(indexPath.row)"
        cell.operationLabel?.text = "1 + \(indexPath.row)"
       
        // cell.textLabel?.text = myData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}

