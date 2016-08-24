//
//  ExplodeView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class ExplodeView: UIView{
    
    private var emitter: CAEmitterLayer!
    
    override class func layerClass() -> AnyClass{
        return CAEmitterLayer.self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use the other initializer")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
}
