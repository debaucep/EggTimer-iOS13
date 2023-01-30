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
    
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var timerProgressBar: UIProgressView!
    
    
    // before release set 300 / 420 / 720 secs 
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var counter = 0
    var totalTime = 0
    var secondsPassed = 0
    var stepperValue = 0 {
        didSet {
            counter = stepperValue
        }
    }
    var timer = Timer()
    
    // Sound
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // end of Sound
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        let timeInSeconds = eggTimes [hardness]!
        totalTime = eggTimes [hardness]!
        
        print ("Time in seconds is \(timeInSeconds)")
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        stepperValue = timeInSeconds
        
        timerProgressBar.progress = 0.0
        secondsPassed = 0
        upperLabel.text = hardness


        
    }
    
    
    @IBAction func startOverButton(_ sender: UIButton) {
        
        timer.invalidate()
        timerProgressBar.progress = 0.0
        secondsPassed = 0
        upperLabel.text = "How do you like your eggs?"
        
    }
    
    
    
    
    @objc func updateCounter() {
        //example functionality
        if secondsPassed <= totalTime {
            //print("\(counter) seconds")
            
            let percentageProgress = Float (secondsPassed) / Float (totalTime)
            print (percentageProgress)
            timerProgressBar.progress = Float (percentageProgress)
            
            secondsPassed += 1
            
        } else {
            timer.invalidate()
            upperLabel.text = "DONE"
            playSound()
            
        }
        
    }
    
}




