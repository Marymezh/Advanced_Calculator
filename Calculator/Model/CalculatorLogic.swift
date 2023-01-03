//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Мария Межова on 03.01.2023.
//  Copyright © 2023 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    private var intermediateCalculation: (firstNumber: Double, calcOperation: String)?
    
    mutating func setNumber (_ number: Double) {
        self.number = number
    }
    
    mutating func calculate (title: String) -> Double? {
        
        if let n = number {
            switch title {
            case "AC": return 0
            case "+/-": return n * -1
            case "%": return n * 0.01
            case "=": return performTwoNumberCalculation(n2: n)
            default: self.intermediateCalculation = (firstNumber: n, calcOperation: title)
            }
        }
        return nil
    }
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.firstNumber,
           let operation = intermediateCalculation?.calcOperation {
            
            switch operation {
            case "+": return n1 + n2
            case "-": return n1 - n2
            case "×": return n1 * n2
            case "÷": return n1 / n2
            default: fatalError("The operation doesn't match any of the cases.")
            }
        }
        return nil
    }
}
