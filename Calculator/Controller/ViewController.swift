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
//        guard let displayText = displayLabel.text else {
//            fatalError ("No text in the display label")}
//        guard let displayNum = Double(displayText) else {
//            fatalError("Can not convert display label text into a Double")}
//        return displayNum
        }
        set {
            displayLabel.text = String(newValue)
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
            
//            if let result = calcLogic.calculate(title: calcMethod) {
//                displayValue = result
//            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let buttonTitle = sender.currentTitle {
            
            if isFinishedTypingNumber == true {
                displayLabel.text = buttonTitle
                isFinishedTypingNumber = false
            } else {
                if buttonTitle == "." {
                    let isInt = floor(displayValue) == displayValue
                    if !isInt {
                        return
                    }
                }
                displayLabel.text?.append(contentsOf: buttonTitle)
            }
        }
    }
}

