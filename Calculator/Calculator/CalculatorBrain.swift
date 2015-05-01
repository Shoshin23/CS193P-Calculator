//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Karthik Kannan on 01/05/15.
//  Copyright (c) 2015 Karthik. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOpeation(String, (Double, Double) -> Double)
        
    }
    
    private var opStack = [Op]()
    private var knownOps = [String: Op]()
    
    init() {
        knownOps["×"] = Op.BinaryOpeation("×", *)
        knownOps["÷"] = Op.BinaryOpeation("÷") {$1 / $0}
        knownOps["-"] = Op.BinaryOpeation("-") {$1 - $0}
        knownOps["+"] = Op.BinaryOpeation("+", +)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("cos", cos)
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        
    }
    
    }
    
