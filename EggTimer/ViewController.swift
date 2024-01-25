//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer: DispatchSourceTimer?
    var player: AVAudioPlayer!
    let eggTimes: [String: Int] = ["Soft": 10, "Medium": 420, "Hard": 720]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness: String = sender.currentTitle!
        
        
        func startCountdown() {
            timer?.cancel()
            
            titleLabel.text = hardness
            progressBar.progress = 0.0
            
            let totalTime = eggTimes[hardness]!
            var seconds = eggTimes[hardness]!

            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            
            func playSound() {
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }

            timer?.schedule(deadline: .now(), repeating: 1.0)
            timer?.setEventHandler { [weak self] in
                guard let self = self else { return }

                if seconds > 0 {
                    print("\(seconds) seconds.")
                    seconds -= 1
                    
                    DispatchQueue.main.async {
                        let currentProgress: Float = (Float(seconds) / Float(totalTime))
                        self.progressBar.progress = (1.0 - currentProgress)
                    }
                } else {
                    print("Countdown finished")
                    self.timer?.cancel() // Stop the timer when the countdown is finished
                    
                    DispatchQueue.main.async {
                        self.titleLabel.text = "DONE!"
                        self.progressBar.progress = 1.0
                        
                        playSound()
                    }
                }
            }

            timer?.resume()

            // Keep the program running while the timer is active
            RunLoop.main.run(until: Date(timeIntervalSinceNow: TimeInterval(seconds)))
        }

        
        startCountdown()

    }
    
}
