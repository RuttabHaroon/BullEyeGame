//
//  ViewController.swift
//  BullsEye
//
//  Created by RUTTAB on 8/10/19.
//  Copyright © 2019 RUTTAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addImagesToSlider()
        
        scoreLabel.text = "\(score)"
        
        startNewGame()
        
    }

    
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
        
    }
    
    func addImagesToSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    

    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
//        let message = "The value of the slider is: \(currentValue)" +
//            "\nThe target value is: \(targetValue)" +
//            "\nThe difference is: \(difference)"

    
        let message = "You scored \(points) points"
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            points += 5
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.startNewRound()
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print("The current value of slider is:",slider.value)
    }
 
    
    @IBAction func startOver() {
        startNewGame()
    }
}

