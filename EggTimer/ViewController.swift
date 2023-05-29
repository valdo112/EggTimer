//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

    
class ViewController: UIViewController {
    
    var eggTimes = ["Soft": 3, "Medium": 4
                    , "Hard": 5]
    var timer = Timer()

    var secondsPassed = 0
    
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var eggProcess: UIProgressView!
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        self.timer.invalidate()
        let hardness = sender.currentTitle!
        let totalTime = eggTimes[hardness]!
        eggProcess.progress = 0.0
        secondsPassed = 0
        doneLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < totalTime {
                
                
                self.secondsPassed += 1
                let percentageProgress = Float(self.secondsPassed) / Float(totalTime)
                
                self.eggProcess.progress = Float(percentageProgress)
                print(Float(percentageProgress))
                
                
            
            }
            else{
                self.doneLabel.text = "Done"
                Timer.invalidate()
                self.playSound()
                
            }
            
            
            
        }
        
        
        
    }
}
