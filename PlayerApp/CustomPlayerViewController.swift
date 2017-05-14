//
//  CustomPlayerViewController.swift
//  PlayerApp
//
//  Created by Aina Cuxart on 14/5/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class CustomPlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
//        if let videoURL = URL(string: "http://webb1.nice264.com/npaw/hls_samples/bbb/playlist.m3u8") {
//            
//            var player: AVPlayer = AVPlayer.init(url: videoURL)
//            if self.player != nil {
//                self.player = player
//                self.player?.play()
//            }
//            
//        }
        
        
//                let player = AVPlayer(url: videoURL!)
//                let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = self.view.bounds
//                self.view.layer.addSublayer(playerLayer)
//                player.play()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //        http://webb1.nice264.com/npaw/hls_samples/bbb/playlist.m3u8
        if let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") {
            player = PlayerActions.init(url: videoURL)
            player?.play()
        }
        
        print("STATUS: \(player?.status)")
    }

}
