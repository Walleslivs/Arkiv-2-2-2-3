//
//  ViewController.swift
//  Johantest2
//
//  Created by johan Cesar on 2018-03-02.
//  Copyright © 2018 Johan Cesar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var player: AVAudioPlayer?
    
    let allAnimals = ["Beaver","Cat","Chicken","Cow","Dog","Donkey","Duck","Elephant","Rooster","Lion","Monkey","Penguin","Pig","Polar Bear","Seal","Zebra"]
    
    var favorites = [String]()
    
    var mainMenu = [String]()
    
    
    override func viewDidLoad() {
        
        mainMenu = allAnimals
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func showFavs(_ sender: Any) {
        // HÄMTA UPP FAVLISTAN
        let defaults = UserDefaults.standard
        
        if let favs = defaults.array(forKey: "fav")
        {
            favorites = favs as! [String]
        }
        
        mainMenu = favorites
        collectionView.reloadData()
    }
    
    @IBAction func showAll(_ sender: Any) {
        mainMenu = allAnimals
        collectionView.reloadData()
    }
    
    func reloadAnimals()
    {
        if(mainMenu == allAnimals)
        {
            collectionView.reloadData()
        } else {
            // HÄMTA UPP FAVLISTAN
            let defaults = UserDefaults.standard
            
            if let favs = defaults.array(forKey: "fav")
            {
                favorites = favs as! [String]
            }
            
            mainMenu = favorites
            collectionView.reloadData()
        }
        
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            
            "customCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.parentVC = self
        
        cell.ImageCell.image = UIImage(named: mainMenu[indexPath.row])
       
        cell.soundname = mainMenu[indexPath.row]
        
        let defaults = UserDefaults.standard
        
        var favorites = [String]()
        if let favs = defaults.array(forKey: "fav")
        {
            favorites = favs as! [String]
        }
        
        if(favorites.contains(mainMenu[indexPath.row]))
        {
            // ÄR FAV VISA FAV BILD
            cell.favButton.backgroundColor = UIColor.green
        } else {
            // INTE FAV VISA INTE FAV BILD
            cell.favButton.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let url = Bundle.main.url(forResource: mainMenu[indexPath.item], withExtension: "mp3") else {
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
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/2, height: view.frame.width/2)
        
        
    }
}
/*dnksandhsain
 */
