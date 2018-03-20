//
//  CustomCollectionViewCell.swift
//  Joh2
//
//  Created by johan Cesar on 2018-03-02.
//  Copyright © 2018 Johan Cesar. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCollectionViewCell: UICollectionViewCell {
    
    var parentVC : ViewController?

    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var player: AVAudioPlayer?
    
    var soundname = ""
    
    
    @IBAction func fav(_ sender: Any) {
        
        // HÄMTA UPP FAVLISTAN
        var defaults = UserDefaults.standard
        
        var favorites = [String]()
        if let favs = defaults.array(forKey: "fav")
        {
            favorites = favs as! [String]
        }
        
        // KOLLA OM REDAN FAV
        if(favorites.contains(soundname))
        {
            // OM FAV TA BORT FAV
            var newFav = [String]()
            for checkfav in favorites
            {
                if(checkfav != soundname)
                {
                    newFav.append(checkfav)
                }
            }
            favorites = newFav
            
        } else {
            // OM INTE FAV BLI FAV
            favorites.append(soundname)
        }
        
        defaults.set(favorites, forKey: "fav")
        defaults.synchronize()
        
        
        parentVC?.reloadAnimals()
    }
    
    
    
    
    
    
    @IBAction func Ljud(_ sender: UIButton) {
    
    
    
        
        guard let url = Bundle.main.url(forResource: soundname, withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        
        
        
        let duration = 0.8
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.calculationModeLinear
        
        UIView.animateKeyframes(withDuration:duration, delay: delay, options: options, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                // Animera
                self.ImageCell.transform = CGAffineTransform(translationX: 0, y: -5)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                // Animera
                self.ImageCell.transform = CGAffineTransform(translationX: 0, y: 5)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                // Animera
                self.ImageCell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            
        }) { _ in
            // Klarkod
        }
    }
    
}

