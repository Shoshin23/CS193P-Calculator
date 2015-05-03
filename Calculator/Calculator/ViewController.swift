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
    
    var brain = CalculatorBrain()
    
    
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
        if let result = brain.performOperation(operation) {
            displayValue = result
        }
        else {
            displayValue = nil
        }
                updateHistory(operation)
    
    }
    
    
    
   

    
    @IBAction func enter() {
        userInMiddleOfTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
            
        }
        else {
            displayValue = nil
        }
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
    var displayValue : Double! {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInMiddleOfTyping = false
        }
    }

}

