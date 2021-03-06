//
//  ViewController.swift
//  Project2
//
//  Created by user on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets & Attributes
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0 {
        didSet {
            if score > bestScore {
                bestScore = score
                saveScore()
                showNewBestScore()
            }
        }
    }
    var correctAnswer = 0
    var scoreCounter = 0
    var bestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        let defaults = UserDefaults.standard
        defaults.integer(forKey: "BestScore")
    }
    
    func askQuestion(action: UIAlertAction!) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        //challenge 3 Day 22: Go back to project 2 and add a bar button item that shows their score when tapped.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreTapped))
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        //Challenge 1
        title = countries[correctAnswer].uppercased() //+ "   score: \(score)"
    }
    
    //MARK: - IBAction buttonTapped
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
//Challenge 3 day 58: Go back to project 2 and make the flags scale down with a little bounce when pressed.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { finished in
            sender.transform = .identity
        }

        
//Challenge 3: When someone chooses the wrong flag, tell them their mistake in your alert message.
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            scoreCounter += 1
        } else {
            //
            title = "Wrong, this is \(countries[correctAnswer].uppercased())"
            score -= 1
            scoreCounter += 1
        }
        
        //Challenge 2: Keep track of how many questions have been asked, and show one final alert controller after they have answered 10.
        
        if scoreCounter < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "End of the Game. You guessed right \(score) times", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            scoreCounter = 0
        }
    }
    
    //MARK: - Methods
    //challenge 3 Day 22: Go back to project 2 and add a bar button item that shows their score when tapped.
    @objc func scoreTapped() {
        let score = UIAlertController(title: "Score Status", message: "Your score is \(score)", preferredStyle: .alert)
        score.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        present(score, animated: true)
    }
    
    func saveScore() {
        let defaults = UserDefaults()
        defaults.setValue(bestScore, forKey: "BestScore")
    }

//Challenge 2 day 49 Modify project 2 so that it saves the player???s highest score, and shows a special message if their new score beat the previous high score.
    func showNewBestScore() {
        let ac = UIAlertController(title: "Best Score!", message: "Your best score is: \(bestScore)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Back to the game", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

