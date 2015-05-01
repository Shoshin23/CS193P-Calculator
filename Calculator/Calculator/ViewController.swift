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
    
    @IBOutlet weak var history: UILabel!
    var historyIsBlank = false
    
    
    var userInMiddleOfTyping : Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit  = sender.currentTitle!
        if(userInMiddleOfTyping) {
            if(digit != "." || display.text!.rangeOfString(".") == nil) {
                display.text = display.text! + digit
            }
        }
        else {
            display.text = digit
            userInMiddleOfTyping = true
        }
      //when someone appends digit.
    }
    
    //create an operandStack.
    
    var operandStack = Array<Double>()
    
    
    @IBAction func operate(sender: UIButton) {
    
        let operation = sender.currentTitle!
        if userInMiddleOfTyping {
            enter()
        }
        
        switch operation {
            case "x": performOperation {$0 * $1}
            case "+": performOperation {$0 + $1}
            case "÷": performOperation {$1 / $0}
            case "-": performOperation {$1 - $0}
            case "√": performOperation { sqrt($0) }
            case "sin": performOperation { sin($0) }
            case "cos": performOperation { cos($0) }
            default: break
            
            
        }
        updateHistory(operation)
    
    }
    
    private func performOperation(operation: (Double,Double) -> Double) { //takes two double and returns 1.
        if operandStack.count >= 2
        {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
        //after an operation is performed.
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
        updateHistory(display.text!)
        
        
    }
    
    func updateHistory(newItem:String) {
        if(historyIsBlank) {
            historyIsBlank = false
            history.text = newItem
        }
        else {
            history.text = history.text! + " \(newItem)"
        }
    }
    
    @IBAction func clear() {
        
        //clear display 
        display.text = "0.0"
        history.text = "0.0"
        //clear operandStack
        operandStack = Array<Double>()
        //reset userInMiddleOfTyping
        userInMiddleOfTyping = false
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

