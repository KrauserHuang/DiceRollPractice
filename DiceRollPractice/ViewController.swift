//
//  ViewController.swift
//  DiceRollPractice
//
//  Created by Tai Chin Huang on 2020/9/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Use Outlet Collection for same diceImageView array
    @IBOutlet var diceImageViews: [UIImageView]!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var statusText: UITextView!
//    @IBOutlet weak var totalText: UILabel!
//    @IBOutlet weak var betText: UILabel!
//    @IBOutlet weak var gambleMoneyStepper: UIStepper!
    @IBOutlet weak var gambleSelector: UISegmentedControl!
    //All dice images from xcassets
    let diceImageNames = ["dice_1", "dice_2", "dice_3", "dice_4", "dice_5", "dice_6"]
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Change dice point after press the button
    @IBAction func rollButton(_ sender: UIButton) {
        
        var sum = 0
        playSound(name: "dice")
        //Setup i and it need to perform 3 times, diceImageViews.count = 3
//        for i in 0...diceImageViews.count - 1 {
//            let number = Int.random(in: 1...6)
//            diceImageViews[i].image = UIImage(named: diceImageNames[number - 1])
//            sum = sum + number
//        }
        //時間間隔起算
//        let diceTime:TimeInterval = 1.42
//        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + diceTime)
        //Setup dice from diceImageViews, which will perform 3 times
        for dice in diceImageViews {
            //Constant number which will generate random number 1-6
            let number = Int.random(in: 1...6)
            //For example, number = 5, change dice image to diceImageNames[4], which is dice_5
            dice.image = UIImage(named: diceImageNames[number - 1])
            //After run all 3 times add all the number
            sum = sum + number
        }
        pointLabel.text = "Point:   \(sum)"
        //開始判斷大小21點情形
        let segmentSelect = gambleSelector.selectedSegmentIndex
        switch segmentSelect {
        case 0:
            if sum <= 8 {
                win()
            } else {
                loseSmall()
            }
        case 2:
            if sum >= 10 {
                win()
            } else {
                loseBig()
            }
        default:
            if sum == 9 {
                win()
            } else {
                loseMiddle()
            }
        }
    }
    
//    func totalMoneyUpdate() {
//        totalText.text = "Total: $\(money)"
//    }
    
//    func gambleMoneyUpdate() {
//        betText.text = "Bet: $\(String(format: "%.f", gambleMoneyStepper.value))"
//    }
    
    func showText(){
        statusText.scrollRangeToVisible(NSRange(location: .max, length: 0))
    }
    
    func win(){
        self.statusText.text += String("\n恭喜您贏了，點數大小符合所選！")
        showText()
    }
    
    func loseSmall(){
        statusText.text += String("\n您輸了，點數都太大啦！")
        showText()
    }
    func loseBig(){
        statusText.text += String("\n您輸了，點數都太小啦！")
        showText()
    }
    
    func loseMiddle() {
        statusText.text += String("\n您輸了，點數不是9就是不行！")
        showText()
    }
    
    func playSound(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            player = try?AVAudioPlayer(contentsOf: url)
            player?.play()
        }
    }
    //Simulate shake movement
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        var sum = 0
        playSound(name: "dice")
//        let diceTime:TimeInterval = 1.42
//        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + diceTime)
        for dice in diceImageViews {
            let number = Int.random(in: 1...6)
            dice.image = UIImage(named: diceImageNames[number - 1])
            sum = sum + number
        }
        pointLabel.text = "Point:   \(sum)"
        let segmentSelect = gambleSelector.selectedSegmentIndex
        switch segmentSelect {
        case 0:
            if sum <= 8 {
                win()
            } else {
                loseSmall()
            }
        case 2:
            if sum >= 10 {
                win()
            } else {
                loseBig()
            }
        default:
            if sum == 9 {
                win()
            } else {
                loseMiddle()
            }
        }
    }

}

