//
//  ViewController.swift
//  Calculator
//
//  Created by Apollonian on 4/21/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!

    private var userIsInTheMiddleOfTyping = false

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }

    private var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }

    var savedProgram: CalculatorBrain.PropertyList?

    @IBAction func save() {
        savedProgram = brain.program
    }

    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }

    private var brain = CalculatorBrain()

    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let methematicalSymbol = sender.currentTitle{
            brain.performOperation(methematicalSymbol)
        }
        displayValue = brain.result
    }
}
