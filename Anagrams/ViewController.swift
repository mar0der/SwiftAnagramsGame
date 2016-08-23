//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let controller:GameController
    
    required init(coder aDecoder: NSCoder){
        controller = GameController()
        super.init(coder: aDecoder)!
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        let level1 = Level(levelNumber: 1)
        
        let gameView = UIView(frame:CGRectMake(0,0,ScreenWidth,ScreenHeight))
        self.view.addSubview(gameView)
        
        controller.gameView = gameView
        controller.level = level1;
        controller.dealRandomAnagram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

