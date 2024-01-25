//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer: DispatchSourceTimer?
    
    let eggTimes: [String: Int] = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness: String = sender.currentTitle!
        
        
        func startCountdown() {
            timer?.cancel()
            
            var seconds = eggTimes[hardness]!

            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())

            timer?.schedule(deadline: .now(), repeating: 1.0)
            timer?.setEventHandler { [weak self] in
                guard let self = self else { return }

                if seconds > 0 {
                    print("\(seconds) seconds.")
                    seconds -= 1
                } else {
                    print("Countdown finished")
                    self.timer?.cancel() // Stop the timer when the countdown is finished
                }
            }

            timer?.resume()

            // Keep the program running while the timer is active
            RunLoop.main.run(until: Date(timeIntervalSinceNow: TimeInterval(seconds)))
        }

        
        startCountdown()

    }
    
}
