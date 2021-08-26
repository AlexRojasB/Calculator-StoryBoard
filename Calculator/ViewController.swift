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
    @IBOutlet weak var displayLabel: UILabel!
    private var isDecimalPointAdded: Bool = false
    private var isANumberNeeded: Bool = false
    private var isAnOperationAdded: Bool = false
    private var pendingOperation: Int = -1
    private var currentNumber: String = "0"
    private var previousNumber: Double = 0
    
    private var historicalCalculations: [HistoryCalculation] = []
    
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
    
    @IBAction func ClearDisplayLabel(_ sender: UIButton) {
        InitialState()
    }
    
    func InitialState() {
        displayLabel.text = "0"
        isDecimalPointAdded = false
        isANumberNeeded = false
        isAnOperationAdded = false
        pendingOperation = -1
        currentNumber = "0"
        previousNumber = 0
    }
    
    @IBAction func DeleteDigit(_ sender: UIButton) {
        var currentDisplay =  displayLabel.text!
        var removedChar = ""
        if currentDisplay.count > 0 {
           removedChar = String(currentDisplay.removeLast())
        }
        let lastChar = currentDisplay.last
        if lastChar == "x" || lastChar == "/" || lastChar == "+" || lastChar == "-" {
            currentDisplay.removeLast()
            currentDisplay.removeLast()
            isANumberNeeded = false
            pendingOperation = -1
            isAnOperationAdded = false
            
            
        }
        if removedChar == "." {
            isDecimalPointAdded = false
        }
        if currentDisplay.count == 0 || lastChar == " "
        {
            isANumberNeeded = true
        }
        displayLabel.text = currentDisplay
        currentNumber = currentDisplay
        
    }
    
    @IBAction func AddDecimal(_ sender: UIButton) {
        if !isDecimalPointAdded {
            isDecimalPointAdded = true
            isANumberNeeded = true
            displayLabel.text = "\(displayLabel.text!)."
            currentNumber = "\(currentNumber)."
        }
    }
    
    func GetIndexOf(letter: String, data: String) -> Int {
        var index: Int = -1
            
            if let range: Range<String.Index> = data.range(of: letter) {
                 index = data.distance(from: data.startIndex, to: range.lowerBound)
            }
        return index
    }
    
    @IBAction func AddOperation(_ sender:UIButton) {
        if !isANumberNeeded && !isAnOperationAdded {
            isAnOperationAdded = true
            isANumberNeeded = true
        pendingOperation = sender.tag
        var operationText = " "
        switch pendingOperation {
        case 0:
            operationText = "\(operationText)+ "
        case 1:
            operationText = "\(operationText)- "
        case 2:
            operationText = "\(operationText)x "
        case 3:
            operationText = "\(operationText)/ "
        default:
            operationText = ""
        }
            displayLabel.text = "\(displayLabel.text!)\(operationText)"
            previousNumber = Double(currentNumber)!
            currentNumber = ""
            isDecimalPointAdded = false
        }
        
    }
    
    @IBAction func GetUserInput(_ sender: UIButton) {
        let inputText = sender.titleLabel!.text
        currentNumber = "\(currentNumber)\(inputText!)"
        var displayText = displayLabel.text
        if displayText?.count == 1 && displayText == "0" {
            displayText = ""
        }
        displayLabel.text = "\(displayText!)\(inputText!)"
        if isANumberNeeded {
            isANumberNeeded = false
        }
    }
    
    @IBAction func PerformOperation(_ sender: UIButton) {
        if isAnOperationAdded && !isANumberNeeded {
                
            var result: Double = 0.0
        let currentNumberConverted = Double(currentNumber)!
        switch pendingOperation {
        case 0:
            result = previousNumber + currentNumberConverted
        case 1:
            result = previousNumber - currentNumberConverted
        case 2:
            result = previousNumber * currentNumberConverted
        case 3:
            result = previousNumber / currentNumberConverted
        default:
            InitialState()
        }
            
            var currentDisplay = displayLabel.text!
            var resultString = ""
            if GetIndexOf(letter: ".", data: currentDisplay) > 0 {
                resultString = "\(result)"
            } else {
                resultString = "\(Int(result))"
            }
            historicalCalculations.append(HistoryCalculation(operation: currentDisplay, result: resultString))
           historicalCalculations = historicalCalculations.sorted(by: { $0.historyDateTime.compare($1.historyDateTime) == .orderedDescending })
            self.tableView.reloadData()
        }
       InitialState()
    }
    //table funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalCalculations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOperationTableViewCell", for: indexPath) as! PreviousOperationTableViewCell
        cell.resultLabel?.text = "\(historicalCalculations[indexPath.row].result)"
        cell.operationLabel?.text = "\(historicalCalculations[indexPath.row].operation)"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}

