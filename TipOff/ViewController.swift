//
//  ViewController.swift
//  TipOff
//
//  Created by Abraham Brovold on 2/9/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import UIKit


class BaseTextField: UITextView {
    
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

class ViewController: UIKit.UIViewController {

    @IBOutlet var baseTextField: UITextView!
    @IBOutlet var taxPercentSlider: UISlider!
    @IBOutlet var taxPercentLabel: UILabel!
    
    @IBOutlet var taxSwitch: UISwitch!
    @IBOutlet var tipSwitch: UISwitch!
    
    @IBOutlet var finalTotalLabel: UILabel!
    @IBOutlet var tipPercentage: UISegmentedControl!
    @IBOutlet var splitStepper: UIStepper!
    @IBOutlet var splitLabel: UILabel!
  
    let tipCalc = TipCalculatorModel(taxPercentage: 0.06, tipPercentage: 0.18, baseTotal: 20.00, splitWay: 1.0)
    
    var switchState = Bool()
    
    func refreshUI() {
        
        
        taxPercentSlider.value = Float(tipCalc.taxPercentage) * 100.0
        
        taxPercentLabel.text = "\(Int(taxPercentSlider.value))%"
        
        finalTotalLabel.text = ""
        
        calculateEverything()
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchState = true
        taxSwitch.on = true
        taxPercentSlider.enabled = true
        taxPercentLabel.enabled = true
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
   
    
 /*   func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text.endIndex > 7) {
    }
*/
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
          
        } else
        {
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
        tipCalc.baseTotal = Double((baseTextField.text as NSString).doubleValue)
        
        let finalTotal = tipCalc.returnFinalTotal()
        
        // var results =
        
        finalTotalLabel.text = String(format:"%0.2f", finalTotal[0])
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

