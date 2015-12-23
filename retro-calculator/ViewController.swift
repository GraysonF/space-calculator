//
//  ViewController.swift
//  retro-calculator
//
//  Created by Grayson faircloth on 12/22/15.
//  Copyright © 2015 Grayson Faircloth. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        
        do {
            
            
        try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
            
        } catch let err as NSError{
            
            print(err.debugDescription)
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn: UIButton!) {
        
        buttonSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
       
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
       
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
       
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
       
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
       
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        
        buttonSound.play()
        
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        currentOperation = Operation.Empty
        result = ""
        
        outputLbl.text = "0"
        
    }
    
    
    
    
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                }
                    
                else if currentOperation == Operation.Divide {
                    
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                    
                }
                    
                else if currentOperation == Operation.Subtract {
                    
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                    
                }
                    
                else if currentOperation == Operation.Add {
                    
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                    
                }
                
                leftValString = result
                outputLbl.text = result
                
            }
            
                currentOperation = op
           
                
            }
      
        else {
        
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
        
    }
    
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    
    
    
}

