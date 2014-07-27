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
    
    let time : NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitHour | .CalendarUnitMinute, fromDate:  NSDate())
    var startHour : Int = 0
    var startMinute : Int = 0
    var initialDate : NSDate


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.startHour = time.hour
        self.startMinute = time.minute
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func countDown() {
        println("Counting down")
    }
    
    func createTimer() -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
    }
    
    @IBAction func startTimer(sender : AnyObject) {
        self.initialDate = NSDate()
        let time : Int = Int(timePicker.countDownDuration) + ((Int(self.startHour) * 60) + Int(self.startMinute)) * 60;
        var countDownTime = Double(((Int(self.startHour) * 60) + Int(self.startMinute)) * 60)
        let countDownTimer = createTimer()
        
        print (countDownTimer)
//        
//        print(time)
//        print ("\n")
//        print (self.startHour)
//        print (":")
//        print (self.startMinute)
//        print ("\n")
    }
    
    

}

