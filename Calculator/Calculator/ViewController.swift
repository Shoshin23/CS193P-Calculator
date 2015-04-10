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

}

