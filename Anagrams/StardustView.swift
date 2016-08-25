//
//  StardustView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/25/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class StardustView: UIView{
    private var emitter: CAEmitterLayer!
    
    required init(coder aDecoder: NSCoder){
        fatalError("use the other init")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    
    override class func layerClass() -> AnyClass{
        //configure the UIView
        return  CAEmitterLayer.self
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        let texture: UIImage? = UIImage(named: "particle")
        assert(texture != nil, "particle image not found")
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = texture!.CGImage
        emitterCell.name = "cell"
        emitterCell.birthRate = 200
        emitterCell.lifetime = 1.5
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33
        emitterCell.yAcceleration = 100
        emitterCell.xAcceleration = -200
        emitterCell.velocity = 100
        emitterCell.velocityRange = 40
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.2
        emitterCell.emissionRange = CGFloat(M_PI*2)
        
        let emitter = self.layer as! CAEmitterLayer
        emitter.emitterCells = [emitterCell]

    }
    
    func disableEmitterCell(){
        emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
    }
}