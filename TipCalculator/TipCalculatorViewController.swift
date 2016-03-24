//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Laurent Shala on 6/28/15.
//  Copyright (c) 2015 Chronos. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var amountBeforeTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    @IBOutlet weak var splitResultLabel: UILabel!
    
    //MARK:- Properties
    var tipCalc = TipCalc(amountBeforeTax: 25.00, tipPercentage: 0.2)
    
    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        amountBeforeTextField.text = String(format: "%0.2f", arguments: [tipCalc.amountBeforeTax])
        tipPercentageLabel.text = String(format: "Tip %d%%:", arguments: [Int(tipCalc.tipPercentage * 100)])
    }
    
    func calcTip(){
        tipCalc.tipPercentage = Float(tipPercentageSlider.value)
        tipCalc.amountBeforeTax = ((amountBeforeTextField.text)! as NSString).floatValue
        tipCalc.calculateTip()
        updateUI()
    }
    
    func updateUI(){
        resultLabel.text = String(format: "Total: $%0.2f Tip: $%0.2f", arguments: [tipCalc.totalAmount, tipCalc.tipAmount])
        splitResultLabel.text = String(format: "Total:$%0.2f Tip: $%0.2f", arguments: [(tipCalc.totalAmount / numberOfPeopleSlider.value), (tipCalc.tipAmount / numberOfPeopleSlider.value)])
    }
    
    //MARK:- UIControl Events
    @IBAction func amountBeForTaxTextFieldChanged(sender: AnyObject) {
        calcTip()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == amountBeforeTextField{
            textField.resignFirstResponder()
            calcTip()
        }
        return true
    }
    
    @IBAction func tipPercentageSliderValueChanges(sender: AnyObject) {
    tipPercentageLabel.text! = String(format: "Tip: %2d%%", arguments: [Int(tipPercentageSlider.value * 100)])
    calcTip()
    }

    @IBAction func split(sender: AnyObject) {
        numberOfPeopleLabel.text! = String(format: "Split: %1d%", arguments: [Int(numberOfPeopleSlider.value)])
        calcTip()
    }

}

