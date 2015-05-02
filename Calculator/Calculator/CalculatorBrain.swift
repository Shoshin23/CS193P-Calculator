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
    
    private func evaluate(ops : [Op]) -> (result: Double?, remainingOps: [Op]){
        
        if !ops.isEmpty {
            var remainingOps = ops
            let operation = remainingOps.removeLast()
            
            switch operation {
            case .Operand(let operand):
                return(operand, remainingOps)
            case .UnaryOperation(_, let operation):
                 let operandEvalution = evaluate(remainingOps)
                 if let operand = operandEvalution.result {
                    return(operation(operand), operandEvalution.remainingOps)
                }
                
            case .BinaryOpeation(_, let operation):
                let operandEvaluation1 = evaluate(remainingOps)
                if let operand1 = operandEvaluation1.result {
                    let operandEvaluation2 = evaluate(operandEvaluation1.remainingOps)
                    if let operand2 = operandEvaluation2.result{
                        return(operation(operand1, operand2), operandEvaluation2.remainingOps)
                    }
                }
                
            }
            
        }
        
        
        
        return(nil, ops)
        
        
    }
    
    func evaluate() -> Double? {
        return evaluate(opStack).result
    }
    
    private func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    private func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}
    
