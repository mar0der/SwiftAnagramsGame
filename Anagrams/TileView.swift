//
//  TileView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/23/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class TileView:UIImageView {
    var letter: Character
    var isMatched: Bool = false
    
    required init(coder aDecoder: NSCoder){
        fatalError("use init(letter:, side length:")
    }
    
    //5 create a new tile for a given letter
    init(letter:Character, sideLength:CGFloat){
        self.letter = letter
        
        let image = UIImage(named: "tile")!
        //superclass initializer
        //references to superview's "self" must take place after super.init
        super.init(image:image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x:0, y:0, width: image.size.width * scale, height: image.size.height * scale)
        
    }
}
