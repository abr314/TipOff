//
//  ViewController.swift
//  TipOff
//
//  Created by Abraham Brovold on 2/9/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import UIKit


class BaseTextField: UITextField {
    
    
    // prevent paste input and copy
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        
        if action == "cut:" {
            return false
        }
        
        if action == "copy:" {
            return false
        }
        
        if action == "select:"{
            return false
        }
        
        if action == "selectAll:" {
            return false
        }
        
        if action == "paste:" {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
   
    
}

class ViewController: UIKit.UIViewController, UITextFieldDelegate {
    var suppressChangeNotification: Bool = false
    @IBOutlet var baseTextField: UITextField!
    var baseTextFieldValue: Double!
    @IBOutlet var taxPercentSlider: UISlider!
    @IBOutlet var taxPercentLabel: UILabel!
    
    @IBOutlet var taxSwitch: UISwitch!
    @IBOutlet var tipSwitch: UISwitch!
    
    @IBOutlet var totalTaxPaidLabel: UILabel!
    @IBOutlet var totalTipPaidLabel: UILabel!
    @IBOutlet var finalTotalLabel: UILabel!
    @IBOutlet var tipPercentage: UISegmentedControl!
    @IBOutlet var splitStepper: UIStepper!
    @IBOutlet var splitLabel: UILabel!
  
    let tipCalc = TipCalculatorModel(taxPercentage: 0.06, tipPercentage: 0.18, baseTotal: 20.00, splitWay: 1.0)
    
    var switchState = Bool()
    var currentString = ""
    
    func refreshUI() {
        
        
        taxPercentSlider.value = Float(tipCalc.taxPercentage) * 100.0
        
        taxPercentLabel.text = "\(Int(taxPercentSlider.value))%"
        
      //  baseTextField.text.t
        
        finalTotalLabel.text = ""

        
        calculateEverything()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  baseTextField.scrollEnabled = false
        switchState = true
        taxSwitch.on = true
        taxPercentSlider.enabled = true
        taxPercentLabel.enabled = true
        
       self.baseTextField.delegate = self

       
        }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            if(countElements(currentString) <= 7){
            currentString += string
            println(currentString)
            formatCurrency(string: currentString)
            }
            else {return false}
       // let newLength = countElements(textField.text!) + countElements(string!)
           
        default:
            var array = Array(string)
            var currentStringArray = Array(currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(string: currentString)
            }
        }
        
        
        return false
    }
    
    func formatCurrency(#string: String) {
        println("format \(string)")
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var numberFromField = (NSString(string: currentString).doubleValue)/100
        baseTextField.text = formatter.stringFromNumber(numberFromField)
        println(baseTextField.text )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func taxSwitch(sender: AnyObject) {
        
        if taxSwitch.on {
            taxPercentSlider.enabled = true
            taxPercentLabel.enabled = true
            taxPercentLabel.text = String(format:"%d", taxPercentSlider.value)
            
        } else {
            taxPercentSlider.enabled = false
            taxPercentSlider.value = 0.0 
            tipCalc.taxPercentage = 0.0
            taxPercentLabel.enabled = false
            taxPercentLabel.text = String(format: "%", taxPercentSlider.value)
            
        }
        
    refreshUI()
    }
    
    
    @IBAction func tipSwitch(sender: AnyObject) {
        if tipSwitch.on {
            tipPercentage.enabled = true
            //tipCalc
            refreshUI()
          
        } else
        {
           tipPercentage.selectedSegmentIndex = UISegmentedControlNoSegment
           // tipPercentage.selectedSegmentIndex
            tipPercentage.enabled = false
            tipCalc.tipPercentage = 0.0
        }
        refreshUI()
    }
   
    
    @IBAction func segmentIndexChanged(sender: AnyObject) {
        
        switch tipPercentage.selectedSegmentIndex
        {
        case 0:
            tipCalc.tipPercentage = 0.12;
        case 1:
            tipCalc.tipPercentage = 0.15;
        case 2:
            tipCalc.tipPercentage = 0.18;
        case 3:
            tipCalc.tipPercentage = 0.20;
        case 4:
            tipCalc.tipPercentage = 0.25;
        default:
            break
        }
        refreshUI()
    }
    
    func calculateEverything() {
        tipCalc.baseTotal = Double((currentString as NSString).doubleValue) / 100.0
        
        let finalTotal = tipCalc.returnFinalTotal()
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var results = String(format:"%0.2f", finalTotal[0])
        var tipPaidResult = String(format:"%0.2f", finalTotal[1])
        var taxPaidResult = String(format:"%0.2f", finalTotal[2])
        
        var numberFromField = (NSString(string: results).doubleValue)
        var numberFromTipPaid = (NSString(string: tipPaidResult).doubleValue)
        var numberFromtTaxPaid = (NSString(string: taxPaidResult).doubleValue)
        
        formatCurrency(string: results)
        
        
        finalTotalLabel.text = formatter.stringFromNumber(numberFromField)
        totalTipPaidLabel.text = formatter.stringFromNumber(numberFromTipPaid)
        totalTaxPaidLabel.text = formatter.stringFromNumber(numberFromtTaxPaid)
    }
    
    
    
  
    
    @IBAction func taxPercentChanged(sender: AnyObject) {
        tipCalc.taxPercentage = Double(taxPercentSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewIsTapped(sender : AnyObject) {
        baseTextField.resignFirstResponder()
        refreshUI()
        
    }
    @IBAction func stepperActionButton(sender: AnyObject) {
        splitLabel.text = "\(Int(splitStepper.value))"
        tipCalc.splitWay = splitStepper.value
        refreshUI()
    }
    
    
    
    


}

