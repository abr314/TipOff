//
//  TipCalculatorModel.swift
//  TipOff
//
//  Created by Abraham Brovold on 2/9/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var taxPercentage: Double
    var tipPercentage: Double
    var baseTotal: Double
    var splitWay: Double
    
    init(taxPercentage: Double, tipPercentage: Double, baseTotal: Double, splitWay: Double) {
       self.taxPercentage = taxPercentage
        self.tipPercentage = tipPercentage
        self.baseTotal = baseTotal
        self.splitWay = splitWay
        }
    
    
    func returnFinalTotal() -> Double {
        var finalTotal = Double()
        var totalWithoutTip = Double()
        finalTotal = baseTotal + ((tipPercentage / 100) + (taxPercentage / 100)) / splitWay
        
        return finalTotal
    }
   
    
    
}