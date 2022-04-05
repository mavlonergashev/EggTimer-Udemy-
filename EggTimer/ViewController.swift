//
//  ViewController.swift
//  EggTimer
//
//  Created by Mavlon on 05/04/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    var counter = 0
    var timer = Timer()
    let eggTimes = ["Soft":5, "Medium":7, "Hard":12]
    var hardness = ""
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        self.hardness = sender.currentTitle!
        self.counter = eggTimes[hardness]!
        
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStarted), userInfo: nil, repeats: true)
    }
    
    @objc func timerStarted() {
        let totalCount = eggTimes[hardness]!
        self.progressBar.progress = (Float(totalCount) - Float(counter))/Float(totalCount)
        //print("\((Float(totalCount) - Float(counter))/Float(totalCount))")
        
        if counter > 0 {
            //print(String(self.counter))
            counter -= 1
        } else {
            //print("Completed")
            playSound()
            self.timer.invalidate()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
