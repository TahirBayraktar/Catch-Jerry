//
//  ViewController.swift
//  Jerry'i Yakala
//
//  Created by Tahir Bayraktar on 29.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer=Timer()
    var imageArray=[UIImageView]()
    var counter=30
    var timerHidden = Timer()
    var score=0
    var highScore=0

    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView1.isUserInteractionEnabled=true
        imageView2.isUserInteractionEnabled=true
        imageView3.isUserInteractionEnabled=true
        imageView4.isUserInteractionEnabled=true
        imageView5.isUserInteractionEnabled=true
        imageView6.isUserInteractionEnabled=true
        imageView7.isUserInteractionEnabled=true
        imageView8.isUserInteractionEnabled=true
        imageView9.isUserInteractionEnabled=true
        
        let gestureRecognizer1=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        imageView1.addGestureRecognizer(gestureRecognizer1)
        imageView2.addGestureRecognizer(gestureRecognizer2)
        imageView3.addGestureRecognizer(gestureRecognizer3)
        imageView4.addGestureRecognizer(gestureRecognizer4)
        imageView5.addGestureRecognizer(gestureRecognizer5)
        imageView6.addGestureRecognizer(gestureRecognizer6)
        imageView7.addGestureRecognizer(gestureRecognizer7)
        imageView8.addGestureRecognizer(gestureRecognizer8)
        imageView9.addGestureRecognizer(gestureRecognizer9)
    
        counter=30
        timerLabel.text="Timer:\(counter)"
        
        
        let saveScore=UserDefaults.standard.object(forKey: "counter")
        if saveScore==nil{
            highScore=0
            highLabel.text="High Score:\(highScore)"
        }
        if let newScore = saveScore as? Int{
            highScore=newScore
            highLabel.text = "High Score:\(highScore)"
        }
      
       
        
        imageArray=[imageView1,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        timerHidden=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hiddenJerry), userInfo: nil, repeats: true)
        hiddenJerry()
        
    }
    
    @objc func timerFunction(){
        
            timerLabel.text="Timer:\(counter)"
            counter-=1
            if counter==0{
            timer.invalidate()
            timerHidden.invalidate()
            for i in imageArray{
                i.isHidden=true
            }
            timerLabel.text="The END"
            if timerLabel.text=="The END"{
                restartApp(tittle: "Time's Up", message: "Do you want to play again?")
            }
                
            }
            if self.highScore<self.score{
                    self.highScore=self.score
                    highLabel.text="High Score:\(self.score)"
                    UserDefaults.standard.set(self.score,forKey: "counter")
            }
                
        
       
        
    }
    @objc func hiddenJerry(){
        for i in imageArray{
            i.isHidden=true
        }
        let random=Int(arc4random_uniform(UInt32(imageArray.count-1)))
        imageArray[random].isHidden=false
    }
    @objc func increaseScore(){
      
        score+=1
        scoreLabel.text="Score:\(score)"
        
        
    }
    func restartApp(tittle:String,message:String){
        let alert=UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton=UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel,handler: nil)
        let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
            self.score=0
            self.scoreLabel.text="Score:\(self.score)"
            self.counter=30
            self.timerLabel.text=String(self.counter)
            
            self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
            self.timerHidden=Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenJerry), userInfo: nil, repeats: true)
            
        }
        alert.addAction(okButton)
        alert.addAction(replayButton)
       
        self.present(alert, animated: true, completion: nil)
        
    
    }
        
        
        
    
    
    
    }


    

