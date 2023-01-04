//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            let displayText = displayLabel.text ?? ""
            let displayNum = Double(displayText) ?? 0
            return displayNum
        }
        set {
            // rounding the result to 10 digits max after decimal point
            let roundedValue = Double(round(10000000000 * newValue) / 10000000000)
            displayLabel.text = String(roundedValue).removeAfterPointIfZero()
        }
    }
    
    private var calcLogic = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        isFinishedTypingNumber = true
        calcLogic.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            guard let result = calcLogic.calculate(title: calcMethod) else {return}
            displayValue = result
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let buttonTitle = sender.currentTitle {
            
            if isFinishedTypingNumber == true {
                if buttonTitle == "." {
                    displayLabel.text = "0."
                    isFinishedTypingNumber = false
                } else if buttonTitle == "0" && displayLabel.text == "0" {
                    return
                } else {
                    displayLabel.text = buttonTitle
                    isFinishedTypingNumber = false
                }
            } else {
                // checking if there is already one "." on the display, if not, we add a dot, if yes - we skip
                if buttonTitle == "." && (displayLabel.text?.range(of: ".") != nil) { return }
                displayLabel.text?.append(contentsOf: buttonTitle)
            }
        }
    }
}


extension String {
    func removeAfterPointIfZero() -> String {
        let token = self.components(separatedBy: ".")
        
        if !token.isEmpty && token.count == 2 {
            switch token[1] {
            case "0", "00", "000", "0000", "00000", "000000":
                return token[0]
            default:
                return self
            }
        }
        return self
    }
}

