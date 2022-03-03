//
//  ViewController.swift
//  SuspendPhoto
//
//  Created by jekun on 2022/3/2.
//

import UIKit
import AVKit
//import SnapKit

class ViewController: UIViewController {
    
    var playerLayer : AVPlayerLayer = AVPlayerLayer()
    var player : AVPlayer!
    var pictureInPictureController : AVPictureInPictureController!
    var photo: PhotoLibrary!
    
    //设置PictureInPicture
    func setupPictureInPicture() {
        guard let videoURL = Bundle.main.url(forResource: "1", withExtension: "mp4") else {
            return
        }
        //设置AVPlayerLayer
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(playerLayer)
        
        //设置AVPlayer
        let asset = AVURLAsset(url: videoURL)
        let playerItem:AVPlayerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        player.actionAtItemEnd = .none
        player.rate = 0
        player.pause()
        if let player = player {
            playerLayer.player = player
        }
        
        // Ensure PiP is supported by current device.  isPictureInPictureSupported()判断设备是否支持画中画
        if AVPictureInPictureController.isPictureInPictureSupported() {
            pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
            pictureInPictureController.delegate = self
            pictureInPictureController.requiresLinearPlayback = true //隐藏快进
        } else {
            print("当前设备不支持PiP")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tt()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        // Do any additional setup after loading the view.
        setupPictureInPicture()
    }
    
    @objc func tt() {
        debugPrint("123")
        //判断Pip是否在Active状态
        guard let isActive = pictureInPictureController?.isPictureInPictureActive else { return }
        if (isActive) {
            //停止画中画
            pictureInPictureController?.stopPictureInPicture()
        } else {
            //启动画中画
            pictureInPictureController?.startPictureInPicture()
        }
    }
}

extension ViewController: AVPictureInPictureControllerDelegate {
    
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        let w:UIWindow = UIApplication.shared.windows.first!
        photo = PhotoLibrary.init(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.44, height: UIScreen.main.bounds.height * 0.44))
        w.addSubview(photo)
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        photo.stop()
    }
    
}



