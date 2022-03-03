//
//  AppDelegate.swift
//  SuspendPhoto
//
//  Created by jekun on 2022/3/2.
//

import UIKit
import AVKit
@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow = UIWindow.init(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.window.rootViewController = ViewController()
//        self.window.makeKeyAndVisible()
        //需要设置App 的AVAudioSession的Category为playback模式
        if AVPictureInPictureController.isPictureInPictureSupported() {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.playback)
            } catch {
                print("Setting category to AVAudioSessionCategoryPlayback failed.")
            }
        }
        return true
    }


}
