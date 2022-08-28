//
//  ViewController.swift
//  ProjectTwo
//
//  Created by Muhsin Can Yılmaz on 18.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = Int()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
    }
    
    @objc func showScore() {
        let alert = UIAlertController(title: "Current Score", message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    func askQuestion(action : UIAlertAction!) {
        
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: UIControl.State.normal)
        button2.setImage(UIImage(named: countries[1]), for: UIControl.State.normal)
        button3.setImage(UIImage(named: countries[2]), for: UIControl.State.normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased() + " Score : \(score)"
        counter += 1
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title = String()
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        }else {
            title = "Wrong"
            //score -= 1
        }
        
        if counter == 10 {
            let alert = UIAlertController(title: "Final Score", message: "Your score is \(score)/10 ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
            present(alert, animated: true)
            counter = 0
            score = 0
        }
        else if sender.tag != correctAnswer{
            let wrongAlert = UIAlertController(title: "Wrong", message: "Wrong that is the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            wrongAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: askQuestion))
            present(wrongAlert, animated: true)
        }
        else{
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        
    }
    
    
}

