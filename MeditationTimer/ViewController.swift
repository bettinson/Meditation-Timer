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
    
    
    var progressView: DACircularProgressView = DACircularProgressView()
    
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
    var font = "Brandon Grotesque"
    var countDownTimer : NSTimer = NSTimer()
    var progressViewAnimationTimer : NSTimer = NSTimer()
    
    var progressTicks : Double = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UIButton.appearance().font = UIFont(name: font, size: 20)
        
        self.initialDate    = NSDate()
        
        // Default is 20 minutes
        self.timePicker.countDownDuration = 20 * 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTimeLabel() {
        if (secondCounter == 0 || secondCounter < 10)  {
            timerLabel.text = String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
        } else {
            if (hourCounter == 0){
                timerLabel.text = String(Int(minuteCounter)) + ":" + String(secondCounter)
            } else {
                timerLabel.text =  String(Int(hourCounter)) + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
        }
        if (hourCounter > 10) {
            if (secondCounter == 0 || secondCounter < 10)  {
                timerLabel.text = String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
            } else {
                timerLabel.text = String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
        }
        else if (hourCounter > 0) {
            println("Hourcounter is greater than zero")
            if (secondCounter == 0 || secondCounter < 10)  {
                timerLabel.text = "0" + String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
            } else {
                timerLabel.text = "0" + String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
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
    
    // Mark Buttons
    
    @IBAction func stopTimer(sender : AnyObject) {
        UILabel.appearance().font = UIFont(name: "Helvetica", size: 20)
        progressView.removeFromSuperview()
        timePicker.hidden = false
        timerLabel.hidden = true
        startTimerButton.hidden = false
        stopTimerButton.hidden = true
        
        self.secondCounter = 0
        self.minuteCounter = 60
        self.hourCounter = 24
        self.countDownTimer.invalidate()
        self.progressViewAnimationTimer.invalidate()
    }
    
    @IBAction func startTimer(sender : AnyObject) {
        UILabel.appearance().font = UIFont(name: font, size: 50)
        println(self.initialDate)
        duration = Int(self.timePicker.countDownDuration)
        
        progressTicks = (1/(Double(duration))) * 0.05
        println(progressTicks)
        
        startProgressAnimation()
        
        minuteCounter = time.minute
        hourCounter = time.hour
        
        hourCounter = Int(Float(duration) / 3600.0)
        minuteCounter = Int(duration - (hourCounter * 3600))/60
        
//        let time : Int = Int(timePicker.countDownDuration) + ((Int(self.startHour) * 60) + Int(self.startMinute)) * 60;
//        var countDownTime = Double(((Int(self.startHour) * 60) + Int(self.startMinute)) * 60)
        
        
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        progressViewAnimationTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "animateProgressView", userInfo: nil, repeats: true)
        
        timePicker.hidden = true
        timerLabel.hidden = false
        startTimerButton.hidden = true
        stopTimerButton.hidden = false
        print (duration)
        println (hourCounter)
        updateTimeLabel()
    }
    
    //Mark - ⭕️🔄
    
    func startProgressAnimation () {
        progressView.hidden = false
        var progressFrame : CGRect = CGRect(x: self.view.center.x - (self.view.bounds.width / 2) + 10, y: (timePicker.bounds.height) / 2, width: 300, height: 300)
        progressView = DACircularProgressView(frame: progressFrame)
        progressView.trackTintColor = UIColor(red: 82/255.0, green: 161/255.0, blue: 225/255.0, alpha: 0.2)
        progressView.progressTintColor = UIColor(red: 82/255.0, green: 161/255.0, blue: 225/255.0, alpha: 1)
        self.view.addSubview(progressView)
        view.bringSubviewToFront(stopTimerButton)
    }
    
    func animateProgressView () {
        progressView.progress += progressTicks
    }
    
    //Mark - 🕑
    
    func countDown() {
        println("Counting down")
        
        tickSecond()
        println(secondCounter)
        println(minuteCounter)
        updateTimeLabel()
        
        if timerIsDone() {
            self.countDownTimer.invalidate()
            self.secondCounter = 0
            self.minuteCounter = 60
            self.hourCounter = 24
        }
    }
    
    func tickSecond (){
        self.totalSecondsElapsed++
       
        if (self.secondCounter == 0 || self.secondCounter % 60 == 0) {
            tickMinute()
        }
        self.secondCounter--
        
    }
    
    func tickMinute (){
        
        if (self.minuteCounter == 0) {
            tickHour()
        }
        self.minuteCounter--
        
        self.secondCounter = 60
    }
    
    func tickHour (){
        hourCounter--
        self.minuteCounter = 60

    }
}

