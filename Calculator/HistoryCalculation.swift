//
//  HistoryCalculation.swift
//  Calculator
//
//  Created by Alexander Rojas Benavides on 8/25/21.
//

import Foundation

struct HistoryCalculation : Identifiable {
    let id =  UUID()
    var operation: String
    var result: String
    let historyDateTime = Date()
}
