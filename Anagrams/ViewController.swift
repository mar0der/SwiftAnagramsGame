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
        //create the view and add it to the main view
        let gameView = UIView(frame:CGRectMake(0,0,ScreenWidth,ScreenHeight))
        self.view.addSubview(gameView)
        //create the hud view
        let hudView = HUDView(frame: CGRect(x:0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        
        controller.gameView = gameView
        controller.hud = hudView
        controller.onAnagramSolved = self.showLevelMenu
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showLevelMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showLevelMenu() {
        let alertController = UIAlertController(title:"Choose Difficulty Level", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let easy = UIAlertAction(title: "Easy-peasy", style: .Default, handler: {(alert:UIAlertAction!) in
            self.showLevel(1)
            })
        let hard = UIAlertAction(title: "Challenge accepted", style: .Default, handler: {(alert:UIAlertAction!) in
            self.showLevel(2)
        })
        
        let hardest = UIAlertAction(title: "I am totally hard-core", style: .Default, handler: {(alert:UIAlertAction!) in
            self.showLevel(3)
        })
        
        alertController.addAction(easy)
        alertController.addAction(hard)
        alertController.addAction(hardest)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func showLevel(levelNumber: Int){
        controller.level = Level(levelNumber: levelNumber)
        controller.dealRandomAnagram()
    }

}

