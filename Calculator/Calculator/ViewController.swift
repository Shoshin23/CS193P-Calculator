//
//  ViewController.swift
//  Calculator
//
//  Created by Karthik Kannan on 10/04/15.
//  Copyright (c) 2015 Karthik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    var userInMiddleOfTyping : Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit  = sender.currentTitle!
        if(userInMiddleOfTyping) {
        display.text = display.text! + digit
        }
        else {
            display.text = digit
            userInMiddleOfTyping = true
        }
    }
    
    //create an operandStack.
    
    var operandStack = Array<Double>()
    
    
    @IBAction func operate(sender: UIButton) {
    
        let operation = sender.currentTitle!
        if userInMiddleOfTyping {
            enter()
        }
        
        switch operation {
            case "✖️": performOperation {$0 * $1}
            case "➕": performOperation {$0 + $1}
            case "➗": performOperation {$1 / $0}
            case "➖": performOperation {$1 - $0}
            case "✔️": performOperation { sqrt($0) }
            default: break
            
            
        }
    
    }
    
    func performOperation(operation: (Double,Double) -> Double) { //takes two double and returns 1.
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
        displayValue = operation(operandStack.removeLast())
        enter()
        }
        
    }
    
    
    @IBAction func enter() {
        userInMiddleOfTyping = false
        operandStack.append(displayValue)
        println("\(operandStack)")
        
        
    }
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInMiddleOfTyping = false
        }
    }

}

