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
    var duration       = 0


    var secondCounter       = 0
    var minuteCounter       = 60
    var hourCounter         = 24
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
            self.minuteCounter = 60
            self.hourCounter = 24
        }
    }
    
    func updateTimeLabel() {
        if secondCounter == 0 {
            timerLabel.text = String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
        } else {
            timerLabel.text = String(Int(minuteCounter)) + ":" + String(secondCounter)
        }
    }
    
    func timerIsDone() -> Bool {
        if (duration <= totalSecondsElapsed){
            return true
        }
        else if (duration >= totalSecondsElapsed) {
            return false
        }
        return false
    }
    
    @IBAction func stopTimer(sender : AnyObject) {
        timePicker.hidden = false
        timerLabel.hidden = true
        startTimerButton.hidden = false
        stopTimerButton.hidden = true
        
        self.secondCounter = 0
        self.minuteCounter = 60
        self.hourCounter = 24
        self.countDownTimer.invalidate()
    }
    
    @IBAction func startTimer(sender : AnyObject) {
        println(self.initialDate)
        duration = Int(self.timePicker.countDownDuration)
        
        minuteCounter = time.minute
        hourCounter = time.hour
        
        /*
        NSTimeInterval duration = datePickerView.countDownDuration;
        int hours = (int)(duration/3600.0f);
        int minutes = ((int)duration - (hours * 3600))/60;
        */
        
        hourCounter = Int(Float(duration) / 3600.0)
        minuteCounter = Int(duration - (hourCounter * 3600))/60
        
//        let time : Int = Int(timePicker.countDownDuration) + ((Int(self.startHour) * 60) + Int(self.startMinute)) * 60;
//        var countDownTime = Double(((Int(self.startHour) * 60) + Int(self.startMinute)) * 60)
        
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        hourCounter = Int(startHour)
        timePicker.hidden = true
        timerLabel.hidden = false
        startTimerButton.hidden = true
        stopTimerButton.hidden = false
        print (duration)
        updateTimeLabel()
    }
    
    //Mark - tick
    
    func tickSecond (){
        self.totalSecondsElapsed++
       
        if (self.secondCounter == 0 || self.secondCounter % 60 == 0) {
            tickMinute()
        }
        self.secondCounter--
        updateTimeLabel()
    }
    
    func tickMinute (){
        
        if (self.minuteCounter == 0) {
            tickHour()
        }
        self.minuteCounter--
        updateTimeLabel()
        self.secondCounter = 60
    }
    
    func tickHour (){
        hourCounter--
        self.minuteCounter = 60
        updateTimeLabel()
    }
}

