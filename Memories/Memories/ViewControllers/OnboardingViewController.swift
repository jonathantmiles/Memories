//
//  OnboardingViewController.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        localNotificationHelper.getAuthorizationStatus() { (granted) in
            self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getStarted(_ sender: Any) {
        localNotificationHelper.requestAuthorization() { (success) in
            self.localNotificationHelper.scheduleDailyReminderNotification()
            self.performSegue(withIdentifier: "OnboardingSegue", sender: nil)
        }
    }
    
    // MARK: - Properties
    
    var localNotificationHelper = LocalNotificationHelper()
}
