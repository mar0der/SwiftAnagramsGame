//
//  ExplodeView.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class ExplodeView: UIView{
    
    fileprivate var emitter: CAEmitterLayer!
    
    override class var layerClass : AnyClass{
        return CAEmitterLayer.self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use the other initializer")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        let texture:UIImage? = UIImage(named:"particle")
        assert(texture != nil, "particle image not found")
        
        let emitterCell = CAEmitterCell()
        
        emitterCell.contents = texture!.cgImage
        
        emitterCell.name = "cell"
        
        //create 1000 particles per second and set the lifetime to 0.75 seconds
        emitterCell.birthRate = 1000
        emitterCell.lifetime = 0.75
        
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33
        
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.2
        
        emitterCell.emissionRange = CGFloat(M_PI*2)
        
        emitter.emitterCells = [emitterCell]
        
        var delay = Int64(0.05 * Double(NSEC_PER_SEC))
        var delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.disableEmitterCell()
        }
        
        //remove explosion view
        delay = Int64(0.75 * Double(NSEC_PER_SEC))
        delayTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.removeFromSuperview()
        }
    }
    
    func disableEmitterCell(){
        emitter.setValue(0, forKey:  "emitterCells.cell.birthRate")
    }
}
