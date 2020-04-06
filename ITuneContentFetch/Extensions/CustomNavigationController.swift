//
//  CustomNavigationController.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

/**
 CustomNavigationController manages to display status bar content with white in which time and battery details will be hidden. If its required then change the UIStatusBarStyle to darkContent mode
 */

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
    
    /// This method will make navigation title in large size with black font

    func setupNavigationalController() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            // Fallback on earlier versions
                self.navigationBar.isTranslucent = false
                self.navigationBar.prefersLargeTitles = true
                self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
       }
    }
}


