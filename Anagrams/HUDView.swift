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
    var hintButton: UIButton!
    
    required init(coder aDecoder: NSCoder){
        fatalError(" use other init")
    }
    
    override init(frame: CGRect) {
        self.stopwatch = StopwatchView(frame: CGRect(x: ScreenWidth/2 - 150, y: 0, width: 300, height: 100))
        self.stopwatch.setSeconds(0)
        
        self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRect(x: ScreenWidth - 200, y: 30, width: 200, height: 70))
        gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        gamePoints.value = 0
        
        super.init(frame: frame)
        self.addSubview(self.stopwatch)
        self.addSubview(gamePoints)
        //adding points label
        let pointsLabel = UILabel(frame: CGRect(x: ScreenWidth - 340, y: 30, width: 140, height: 70))
        pointsLabel.backgroundColor = UIColor.clear
        pointsLabel.font = FontHUD
        pointsLabel.text = "Points:"
        self.addSubview(pointsLabel)
        self.isUserInteractionEnabled = true
        
        let hintButtonImage = UIImage(named: "btn")!
        
        self.hintButton = UIButton(type:.custom)
        hintButton.setTitle("Hint!", for: UIControlState())
        hintButton.titleLabel?.font = FontHUD
        hintButton.setBackgroundImage(hintButtonImage, for: UIControlState())
        hintButton.frame = CGRect(x: 50, y: 30, width: hintButtonImage.size.width, height: hintButtonImage.size.height)
        hintButton.alpha = 0.8
        self.addSubview(hintButton)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        if hitView is UIButton {
            return hitView
        }
        
        return nil
    }
}
