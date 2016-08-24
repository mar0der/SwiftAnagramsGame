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
        //load the model
        let level1 = Level(levelNumber: 1)
        //create the view and add it to the main view
        let gameView = UIView(frame:CGRectMake(0,0,ScreenWidth,ScreenHeight))
        self.view.addSubview(gameView)
        //create the hud view
        let hudView = HUDView(frame: CGRect(x:0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        
        controller.gameView = gameView
        controller.level = level1;
        controller.hud = hudView
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

