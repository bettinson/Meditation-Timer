//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Matt Bettinson on 2014-07-26.
//  Copyright (c) 2014 Matt Bettinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var timePicker : UIDatePicker
    @IBOutlet var startTimerButton : UIButton
    @IBOutlet var timerLabel : UILabel
    @IBOutlet var stopTimerButton : UIButton
    
    let time : NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitHour | .CalendarUnitMinute, fromDate:  NSDate())
    var startHour : Int = 0
    var startMinute : Int = 0
    var startSecond : Int = 0
    var initialDate : NSDate = NSDate()
    var initialTime       = 0


    var secondCounter       = 0
    var minuteCounter       = 0
    var hourCounter         = 0
    var totalSecondsElapsed = 0
    var countDownTimer : NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialDate    = NSDate()
        // Default is 20 minutes
        self.timePicker.countDownDuration = 20 * 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func countDown() {
        println("Counting down")
        tickSecond()
        println(secondCounter)
        println(minuteCounter)
        if timerIsDone() {
            self.countDownTimer.invalidate()
            self.secondCounter = 0
            self.minuteCounter = 0
            self.hourCounter = 0
        }
    }
    
    func updateTimeLabel() {
        timerLabel.text = String(secondCounter) + ":" + String(minuteCounter)
    }
    
    func timerIsDone() -> Bool {
        if (initialTime < totalSecondsElapsed){
            return true
        }
        else if (initialTime >= totalSecondsElapsed) {
            return false
        }
        return false
    }
    
    @IBAction func stopTimer(sender : AnyObject) {
        timePicker.hidden = false
        timerLabel.hidden = true
        startTimerButton.hidden = false
        stopTimerButton.hidden = true
        
        self.countDownTimer.invalidate()
    }
    
    @IBAction func startTimer(sender : AnyObject) {
        println(self.initialDate)
        initialTime = Int(self.timePicker.countDownDuration)
        let time : Int = Int(timePicker.countDownDuration) + ((Int(self.startHour) * 60) + Int(self.startMinute)) * 60;
//        var countDownTime = Double(((Int(self.startHour) * 60) + Int(self.startMinute)) * 60)
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        timePicker.hidden = true
        timerLabel.hidden = false
        startTimerButton.hidden = true
        stopTimerButton.hidden = false
        print (initialTime)
    }
    
    //Mark - tick
    
    func tickSecond (){
        self.totalSecondsElapsed++
        self.secondCounter++
        if (self.secondCounter % 60 == 0) {
            tickMinute()
        }
        updateTimeLabel()
    }
    
    func tickMinute (){
        self.minuteCounter++
        self.secondCounter = 0
        if (self.minuteCounter % 60 == 0) {
            tickHour()
        }
        updateTimeLabel()
    }
    
    func tickHour (){
        hourCounter++
        self.minuteCounter = 0
        updateTimeLabel()
    }

        
    
    

}

