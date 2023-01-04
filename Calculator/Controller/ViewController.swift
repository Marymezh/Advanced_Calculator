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
            let temp = String(newValue).removeAfterPointIfZero()
            displayLabel.text =  temp.setMaxLength(of: 12)
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
                } else {
                displayLabel.text = buttonTitle
                isFinishedTypingNumber = false
                }
            } else {
                // checking if there is already one "." on the display, if not, we add a dot, if yes - we skip
                if buttonTitle == "." && (displayLabel.text?.range(of: ".") != nil)  { return }
                displayLabel.text?.append(contentsOf: buttonTitle)
            }
        }
    }
}


extension String {
    // set the max length of the number to display
    func setMaxLength(of maxLength: Int) -> String {
        var tmp = self
        
        if tmp.count > maxLength {
            var numbers = tmp.map({$0})
            
            if numbers[maxLength - 1] == "." {
                numbers.removeSubrange(maxLength+1..<numbers.endIndex)
            } else {
                numbers.removeSubrange(maxLength..<numbers.endIndex)
            }
            
            tmp = String(numbers)
        }
        return tmp
    }
    
    // remove the '.0' when the number is not decimal
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

