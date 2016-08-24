//
//  AudioController.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import AVFoundation

class AudioController {
    private var audio = [String:AVAudioPlayer]()
    
    
    func preloadAudioEffects(effectFileNames:[String]){
        for effect in AudioEffectFiles {
            let soundPath = "\(NSBundle.mainBundle().resourcePath!)/\(effect)"
            let soundURL = NSURL.fileURLWithPath(soundPath)
            
            do{
                let player = try AVAudioPlayer(contentsOfURL: soundURL)
                player.numberOfLoops = 0
                player.prepareToPlay()
                audio[effect] = player
            } catch let error as NSError{
                print("Error load sounds: \(error)")
            }
          
        }
    }
    
    func playEffect(name:String){
        if let player = audio[name]{
            if player.playing{
                player.stop()
                player.currentTime = 0
                player.play()
            }else{
                player.play()
            }
        }
    }
}
