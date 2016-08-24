//
//  StopwatchView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class StopwatchView: UILabel {
    required init(coder aDecoder: NSCoder){
        fatalError("use init (frame:)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.font = FontHUDBig
    }
    
    func setSeconds(seconds: Int) {
        self.text = String(format: " %02i : %02i", seconds/60, seconds % 60)
    }
}
