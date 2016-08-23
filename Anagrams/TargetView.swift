//
//  TargetView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/23/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit
class TargetView: UIImageView{
    var letter: Character
    var isMatched:Bool = false
    
    required init(coder aDecoder:NSCoder){
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter:Character, sideLength:CGFloat){
        self.letter = letter
        
        let image = UIImage(named: "slot")!
        super.init(image:image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRectMake(0,0, image.size.width * scale, image.size.height * scale)
        
    }
}
