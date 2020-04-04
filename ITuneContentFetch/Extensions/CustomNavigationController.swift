//
//  CustomNavigationController.swift
//  ITuneContentFetch
//
//  Created by Bharatraj Rai on 4/3/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UINavigationController {
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


