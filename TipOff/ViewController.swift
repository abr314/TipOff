//
//  ViewController.swift
//  TipOff
//
//  Created by Abraham Brovold on 2/9/15.
//  Copyright (c) 2015 Abraham Brovold. All rights reserved.
//

import UIKit


class ViewController: UIKit.UIViewController {

    @IBOutlet var baseTextField: UITextView!
    @IBOutlet var taxPercentSlider: UISlider!
    @IBOutlet var taxPercentLabel: UILabel!
    
    @IBOutlet var finalTotalLabel: UILabel!
    @IBOutlet var tipPercentage: UISegmentedControl!
    @IBOutlet var splitStepper: UIStepper!
    @IBOutlet var splitLabel: UILabel!
  
    let tipCalc = TipCalculatorModel(taxPercentage: 0.06, tipPercentage: 0.18, baseTotal: 20.00, splitWay: 1.0)
    
    func refreshUI() {
        
   //     baseTextField.text = String(format: "%0.2f", tipCalc.baseTotal)
        
        taxPercentSlider.value = Float(tipCalc.taxPercentage) * 100.0
        
        taxPercentLabel.text = "\(Int(taxPercentSlider.value))%"
        
        finalTotalLabel.text = ""
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    @IBAction func doCalculate(sender: AnyObject) {
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
        
    }
    @IBAction func stepperActionButton(sender: AnyObject) {
        splitLabel.text = "\(Int(splitStepper.value))"
        tipCalc.splitWay = splitStepper.value
    }
    
    
    
    


}

