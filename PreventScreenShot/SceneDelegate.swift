//
//  SceneDelegate.swift
//  PreventScreenShot
//
//  Created by M3ts LLC on 3/2/22.
//

import UIKit
import ScreenProtectorKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // Using pod 'ScreenProtectorKit' to prevent screen from user taken screen shot
    private lazy var screenProtectorKit = { return ScreenProtectorKit(window: window) }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        print("willConnectTo - screenProtectorKit.configurePreventionScreenshot()")
        screenProtectorKit.configurePreventionScreenshot()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("sceneDidBecomeActive - screenProtectorKit.enabledPreventScreenshot()")
        screenProtectorKit.enabledPreventScreenshot()
        /*
         // Not sure how to use the line below...
         screenProtectorKit.disableBlurScreen()
         screenProtectorKit.disableImageScreen()
         screenProtectorKit.disableColorScreen()
         */
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print("sceneWillResignActive - screenProtectorKit.disablePreventScreenshot()")
        screenProtectorKit.disablePreventScreenshot()
        /*
         // Not sure how to use the line below...
         screenProtectorKit.enabledBlurScreen()
         screenProtectorKit.enabledImageScreen(named: "LaunchImage")
         screenProtectorKit.enabledColorScreen(hexColor: "#572273")
         */
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

