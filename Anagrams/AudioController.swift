//
//  AudioController.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import AVFoundation

class AudioController {
    fileprivate var audio = [String:AVAudioPlayer]()
    
    
    func preloadAudioEffects(_ effectFileNames:[String]){
        for effect in AudioEffectFiles {
            let soundPath = "\(Bundle.main.resourcePath!)/\(effect)"
            let soundURL = URL(fileURLWithPath: soundPath)
            
            do{
                let player = try AVAudioPlayer(contentsOf: soundURL)
                player.numberOfLoops = 0
                player.prepareToPlay()
                audio[effect] = player
            } catch let error as NSError{
                print("Error load sounds: \(error)")
            }
          
        }
    }
    
    func playEffect(_ name:String){
        if let player = audio[name]{
            if player.isPlaying{
                player.stop()
                player.currentTime = 0
                player.play()
            }else{
                player.play()
            }
        }
    }
}
