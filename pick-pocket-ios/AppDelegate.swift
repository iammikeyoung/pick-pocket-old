//
//  AppDelegate.swift
//  pick-pocket-ios
//
//  Created by Nicholas Servidio on 1/7/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = PickLockViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
