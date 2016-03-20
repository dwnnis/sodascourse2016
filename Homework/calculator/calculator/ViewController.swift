//
//  ViewController.swift
//  calculator
//
//  Created by denniswang on 2016/3/17.
//  Copyright © 2016年 dwnnis. All rights reserved.
//

import UIKit
import CalculatorCore

class ViewController: UIViewController {

    var core: Core<Float>!
    var didResetCoreSteps = false
    let displayNumberFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        core = Core()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func numericButtonClicked(sender: UIButton) {
        if Float(displayLabel.text!)! == 0 {
            if displayLabel.text! == "0." {
                displayLabel.text = displayLabel.text! + sender.currentTitle!
            } else {
                displayLabel.text = sender.currentTitle!
            }
        } else {
            if didResetCoreSteps == true {
                displayLabel.text = sender.currentTitle!
                didResetCoreSteps = false
            } else {
                displayLabel.text = displayLabel.text! + sender.currentTitle!
            }
        }
        
    }
    
    @IBAction func operatorButtonClicked(sender: UIButton) {
        
        let buttonClicked = sender.currentTitle
//        print(buttonClicked)

        do {
            try self.core.addStep(Float(displayLabel.text!)!)
        } catch {
            print("Add Operator Failed.")
        }
        
        switch buttonClicked! {
        case "/":
            try! self.core.addStep(/)
        case "x":
            try! self.core.addStep(*)
        case "-":
            try! self.core.addStep(-)
        case "+":
            try! self.core.addStep(+)
        default:
            break
        }
        
        displayLabel.text = "0"
        print(core)
        
    }

    @IBAction func resetButtonClicked(sender: UIButton) {
        displayLabel.text = "0"
        
        // and remember to reset the Core.
        core = Core()
    }
    
    @IBAction func calculateButtonClicked(sender: UIButton) {
        try! self.core.addStep(Float(displayLabel.text!)!)
        let Result = try! self.core.calculate()
//        displayLabel.text = numberFormatter.stringFromNumber(Result)
        if Result % 1 == 0 {
            displayLabel.text = String(format: "%.0f", Result)
        } else {
            displayLabel.text = ("\(Result)")
        }
        core = Core()
        didResetCoreSteps = true
    }
    
    @IBAction func signChangedButtonClicked(sender: UIButton) {
//        displayLabel.text = numberFormatter.stringFromNumber(Float(displayLabel.text!)! * -1)
        if Float(displayLabel.text!)! % 1 == 0 {
            displayLabel.text! = String(format: "%.0f", Float(displayLabel.text!)! * -1)
        } else {
            displayLabel.text! = String(Float(displayLabel.text!)! * -1)
        }
    }
    
    @IBAction func dotSignButtonClicked(sender: UIButton) {
        if Float(displayLabel.text!)! % 1 == 0 {
            displayLabel.text! = displayLabel.text! + "."
        }
    }
}

