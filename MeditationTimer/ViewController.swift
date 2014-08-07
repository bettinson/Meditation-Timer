//
//  ViewController.swift
//  MeditationTimer
//
//  Created by Matt Bettinson on 2014-07-26.
//  Copyright (c) 2014 Matt Bettinson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var timePicker : UIDatePicker?
    @IBOutlet var startTimerButton : UIButton?
    @IBOutlet var timerLabel : UILabel?
    @IBOutlet var stopTimerButton : UIButton?
    @IBOutlet var intitialTimeLabel : UILabel?
    
    var progressView: DACircularProgressView = DACircularProgressView()
    
    let time : NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitHour | .CalendarUnitMinute, fromDate:  NSDate())
    var startHour : Int = 0
    var startMinute : Int = 0
    var startSecond : Int = 0
    var initialDate : NSDate = NSDate()
    var duration       = 0
    var defaultBellSound : NSURL  = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("Bell", ofType: "wav"))
    
    var bellSound = AVAudioPlayer()

    var secondCounter       = 0
    var minuteCounter       = 60
    var hourCounter         = 24
    var totalSecondsElapsed = 0
    var font = "Brandon Grotesque"
    var countDownTimer : NSTimer = NSTimer()
    var progressViewAnimationTimer : NSTimer = NSTimer()
    
    var timeLabelUpdated : Bool = false
    
    var progressTicks : Double = 0
    
    override func viewDidLoad() {
        bellSound = AVAudioPlayer(contentsOfURL: defaultBellSound, error: nil)
        
        super.viewDidLoad()
        startProgressAnimation()
        startTimerButton?.titleLabel.font = UIFont(name: font, size: 20)
        stopTimerButton?.titleLabel.font = UIFont(name: font, size: 20)
        
        timerLabel?.font = UIFont(name: font, size: 20)
        view.bringSubviewToFront(timePicker!)
        self.initialDate    = NSDate()
        
        // Default is 20 minutes
        self.timePicker?.countDownDuration = 20 * 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateTimeLabel() {
        
        if (secondCounter == 0 || secondCounter < 10)  {
            timerLabel?.text = String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
        } else {
            if (hourCounter == 0){
                timerLabel?.text = String(Int(minuteCounter)) + ":" + String(secondCounter)
            } else {
                timerLabel?.text =  String(Int(hourCounter)) + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
        }
        if (hourCounter > 10) {
            if (secondCounter == 0 || secondCounter < 10)  {
                timerLabel?.text = String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
            } else {
                timerLabel?.text = String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
        }
        else if (hourCounter > 0) {
            println("Hourcounter is greater than zero")
            if (secondCounter == 0 || secondCounter < 10)  {
                timerLabel?.text = "0" + String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter) + "0"
            } else {
                timerLabel?.text = "0" + String(Int(hourCounter)) + ":" + String(Int(minuteCounter)) + ":" + String(secondCounter)
            }
        }
        if (!timeLabelUpdated) {
            intitialTimeLabel?.text = timerLabel?.text
            timeLabelUpdated = true
        }
    }
    
    func timerIsDone() -> Bool {
        if (duration <= totalSecondsElapsed){
            timeLabelUpdated = false
            bellSound.prepareToPlay()
            bellSound.play()
            return true
        }
        else if (duration >= totalSecondsElapsed) {
            return false
        }
        return false
    }
    
    // Mark Buttons
    
    @IBAction func stopTimer(sender : AnyObject) {
        UILabel.appearance().font = UIFont(name: font, size: 10)
        timePicker?.hidden = false
        timerLabel?.hidden = true
        startTimerButton?.hidden = false
        stopTimerButton?.hidden = true
        intitialTimeLabel?.hidden = true
        timeLabelUpdated = false
        
        self.secondCounter = 0
        self.minuteCounter = 60
        self.hourCounter = 24
        self.countDownTimer.invalidate()
        self.progressViewAnimationTimer.invalidate()
        startProgressAnimation()
        view.bringSubviewToFront(timePicker!)
        bellSound.stop()
    }
    
    @IBAction func startTimer(sender : AnyObject) {
        
        UILabel.appearance().font = UIFont(name: font, size: 50)
        println(self.initialDate)
        duration = Int((self.timePicker?.countDownDuration)!)
        
        progressTicks = (1/(Double(duration))) * 0.05
        println(progressTicks)
        
        minuteCounter = time.minute
        hourCounter = time.hour
        
        hourCounter = Int(Float(duration) / 3600.0)
        minuteCounter = Int(duration - (hourCounter * 3600))/60
        
//        let time : Int = Int(timePicker.countDownDuration) + ((Int(self.startHour) * 60) + Int(self.startMinute)) * 60;
//        var countDownTime = Double(((Int(self.startHour) * 60) + Int(self.startMinute)) * 60)
        
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        progressViewAnimationTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "animateProgressView", userInfo: nil, repeats: true)
        
        timePicker?.hidden = true
        timerLabel?.hidden = false
        startTimerButton?.hidden = true
        stopTimerButton?.hidden = false
        intitialTimeLabel?.hidden = false
        print (duration)
        println (hourCounter)
        updateTimeLabel()
    }
    
    //Mark - ⭕️🔄
    
    func startProgressAnimation () {
        progressView.hidden = false
        var progressFrame : CGRect = CGRect(x: self.view.center.x - (self.view.bounds.width / 2) + 35, y: (timePicker?.bounds.height)! / 2, width: 250, height: 250)
        progressView = DACircularProgressView(frame: progressFrame)
        progressView.trackTintColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        progressView.progressTintColor = UIColor(red: 82/255.0, green: 161/255.0, blue: 225/255.0, alpha: 1)
        self.view.addSubview(progressView)
        view.bringSubviewToFront(stopTimerButton!)
    }
    
    func animateProgressView () {
        progressView.progress += CGFloat(progressTicks)
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

