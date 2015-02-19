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
    
    
    func returnFinalTotal() -> [Double] {
        var taxPaid: Double
        var totalWithTax: Double
        var totalWithTaxTip: Double
        var tipPaid: Double
        
        taxPaid = (baseTotal*taxPercentage)
        totalWithTax = baseTotal + taxPaid
        tipPaid = (totalWithTax*tipPercentage)
        totalWithTaxTip = (totalWithTax + tipPaid)
    
        let resultsArray:[Double] = [totalWithTaxTip / splitWay, tipPaid / splitWay, taxPaid / splitWay]
        
        
        
      return resultsArray
    
    }
   
    
    
}