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
    
    @IBOutlet var splitStepper: UIStepper!
    @IBOutlet var splitLabel: UILabel!
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func taxPercentChanged(sender: AnyObject) {
        tipCalc.taxPct = Double(taxPercentSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewIsTapped(sender : AnyObject) {
        baseTextField.resignFirstResponder()
        
    }
    @IBAction func stepperActionButton(sender: AnyObject) {
        splitLabel.text = "\(Int(splitStepper.value))"
    }
    
    func refreshUI() {
        
        baseTextField.text = String(format: "%0.2f", tipCalc.total)
        
        taxPercentSlider.value = Float(tipCalc.taxPct) * 100.0
        
        taxPercentLabel.text = "\(Int(taxPercentSlider.value))%"
        
    }
    
    


}

