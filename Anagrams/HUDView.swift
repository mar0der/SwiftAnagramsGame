//
//  HUDView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class HUDView:UIView {
    var stopwatch: StopwatchView
    var gamePoints: CounterLabelView
    
    required init(coder aDecoder: NSCoder){
        fatalError(" use other init")
    }
    
    override init(frame: CGRect) {
        self.stopwatch = StopwatchView(frame: CGRectMake(ScreenWidth/2 - 150, 0, 300, 100))
        self.stopwatch.setSeconds(0)
        
        self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRectMake(ScreenWidth - 200, 30, 200, 70))
        gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        gamePoints.value = 0
        
        super.init(frame: frame)
        self.addSubview(self.stopwatch)
        self.addSubview(gamePoints)
        //adding points label
        let pointsLabel = UILabel(frame: CGRectMake(ScreenWidth - 340, 30, 140, 70))
        pointsLabel.backgroundColor = UIColor.clearColor()
        pointsLabel.font = FontHUD
        pointsLabel.text = "Points:"
        self.addSubview(pointsLabel)
        self.userInteractionEnabled = false        
    }
}