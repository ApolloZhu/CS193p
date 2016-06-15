//
//  ViewController.swift
//  Calculator
//
//  Created by Apollonian on 4/21/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTyping = false

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let methematicalSymbol = sender.currentTitle{
            if methematicalSymbol == "π"{
                display.text = String(M_PI)
            }
        }
    }
}
