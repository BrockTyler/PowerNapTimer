//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by James Pacheco on 4/12/16.
//  Copyright © 2016 James Pacheco. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let myTimer = MyTimer()
    private let notificationIdentifier = "notification"
    
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
            let initialClock = 5.0
            myTimer.startTimer(initialClock)
            scheduleNotification(with: initialClock)
        }
        setView()
    }
}

extension ViewController: TimerDelegate {
    func timerSecondTick() {
        updateTimerLabel()
    }
    
    func timeIsCompleted() {
        setView()
        createAlert()
    }
    
    func timerStopped() {
        cancelNotification()
        setView()
    }
}

extension ViewController {
    func createAlert() {
        
        // Create alert instance of UIAlertController type.
        let alert = UIAlertController(title: "Wake Up", message: "Get out of bed.", preferredStyle: .alert)
        
        // Setup alert UI
        alert.addTextField { (myNewTextField) in
            myNewTextField.placeholder = "Snooze for a few more minutes..."
            myNewTextField.keyboardType = .numberPad
        }
        
        // Define action for the alert
        let dismissAction = UIAlertAction(title: "Dimiss", style: .cancel) { (_) in
            print("Was dismissed.")
            self.cancelNotification()
        }
        
        let snoozeAction = UIAlertAction(title: "Snooze", style: .default) { (_) in
            guard let timeText = alert.textFields?.first?.text, let time = TimeInterval(timeText) else { return }
            
            self.myTimer.startTimer(time)
            self.scheduleNotification(with: time)
            self.setView()
        }
        
        // Link newly defined action to your alert object.
        alert.addAction(dismissAction)
        alert.addAction(snoozeAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}

// MARK: - User Notifications

extension ViewController {
    
    func scheduleNotification(with timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Wake Up"
        content.body = "Time to get up"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
    
    
    
}

