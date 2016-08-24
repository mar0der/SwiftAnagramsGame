//
//  CounterLabelView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class CounterLabelView: UILabel{
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
}
