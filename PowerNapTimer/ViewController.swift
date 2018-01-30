//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by James Pacheco on 4/12/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        myTimer.delegate = self
    }
    
    func setView() {
        updateTimerLabel()
        // If timer is running, start button title should say "Cancel". If timer is not running, title should say "Start nap"
        if myTimer.isOn {
            startButton.setTitle("Cancel", for: UIControlState())
        } else {
            startButton.setTitle("Start nap", for: UIControlState())
        }
    }
    
    func updateTimerLabel() {
        timerLabel.text = myTimer.timeAsString()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if myTimer.isOn {
            myTimer.stopTimer()
        } else {
            myTimer.startTimer(15)
        }
        setView()
    }
}

extension ViewController: TimerDelegate {
    func timerSecondTick() {
        print("timer second tick run")
    }
    
    func timeIsCompleted() {
        print("timer completed run")
    }
    
    func timerStopped() {
        print("timer stopped run")
    }
    
    
}
