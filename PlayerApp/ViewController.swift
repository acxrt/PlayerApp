//
//  ViewController.swift
//  PlayerApp
//
//  Created by Aina Cuxart on 14/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import UIKit
import AVFoundation
import PlayerFramework
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    var player: PlayerActions = PlayerActions()
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") {
            player = PlayerActions.init(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            
            self.view.layer.addSublayer(playerLayer)
            
            // Observe if video finishes
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.playerDidFinishPlaying(note:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            // Start video
            player.play()
            
            // HTTP Request
            makeFakeHTTPRequest(success: { stringSuccess in
                
                print("Request Success! We get: \(stringSuccess)")
                
            }, failure: {error in
                
                print("Request error :( We get: \(error)")
            })
        }
    }

    
    
    @IBAction func PlayPauseButtonPressed(_ sender: Any) {
        
        if player.rate != 1.0 { // Not playing
            
            playPauseButton.setTitle("Pause", for: .normal)
            player.resume()
            
            // HTTP Request
            makeFakeHTTPRequest(success: { stringSuccess in
                
                print("Request Success! We get: \(stringSuccess)")
                
            }, failure: {error in
                
                print("Request error :( We get: \(error)")
            })
        }
        else { // Playing
            
            playPauseButton.setTitle("Play", for: .normal)
            player.pause()
        }
    }
    
    @IBAction func StopButtonPressed(_ sender: Any) {
        
        player.stop()
    }
    
    func playerDidFinishPlaying(note: NSNotification) {
        
        // HTTP Request
        makeFakeHTTPRequest(success: { stringSuccess in
            
            print("Request Success! We get: \(stringSuccess)")
            
        }, failure: {error in
            
            print("Request error :( We get: \(error)")
        })

        // Stop video
        player.stop()
        playPauseButton.setTitle("Play", for: .normal)
        
    }
    
    
    func makeFakeHTTPRequest(success:@escaping (String) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request("https://www.randomRequest.com/aaafc040/download?count=10").responseJSON { response in
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                
                success("\(resJson)")
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                
                failure(error)
            }
        }
    }
}

