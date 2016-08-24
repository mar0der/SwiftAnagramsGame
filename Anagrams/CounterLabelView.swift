//
//  CounterLabelView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class CounterLabelView: UILabel{
    private var endValue: Int = 0
    private var timer: NSTimer? = nil
    
    var value: Int = 0 {
        didSet{
            self.text = " \(value)"
        }
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("use the other init")
    }
    
    init(font: UIFont, frame:CGRect){
        super.init(frame:frame)
        self.font = font
        self.backgroundColor = UIColor.clearColor()
    }
    
@objc func updateValue(timer:NSTimer){
        if(endValue < value){
            value -= 1
        }else{
            value += 1
        }
        
        if(endValue == value){
            timer.invalidate()
            self.timer = nil
        }
        
    }
    

    func setValue(newValue:Int, duration:Float) {
 
        endValue = newValue
        
        //cancel previous timer
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        //calculate the interval to fire each timer
        let deltaValue = abs(endValue - value)
        if (deltaValue != 0) {
            var interval = Double(duration / Float(deltaValue))
            if interval < 0.01 {
                interval = 0.01
            }
            
            //4 set the timer to update the value
            timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector:#selector(CounterLabelView.updateValue(_:)), userInfo: nil, repeats: true)
        }
    }
    
}
