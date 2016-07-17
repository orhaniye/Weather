//
//  DetailViewController.swift
//  Weather
//
//  Created by Zoltan on 07/11/14.
//  Copyright (c) 2014 ING Bank NV. All rights reserved.
//

import UIKit

public class DetailViewController: UIViewController {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailView: UIView!
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func updateActivityIndicator (show: Bool) {
        
        if (show) {
            temperature.text = ""
            precipitation.text = ""
            humidity.text = ""
            detail.text = ""
        }
        
        activityIndicator.hidden = !show
        detailView.hidden = show
    }
    
    public func loadData (item: Current!, error: NSError!) {
        
        temperature.text = item != nil ? String(format: "%ld", item.temperature) : "na"
        precipitation.text = item != nil ? String(format: "%2.0f%", item.precipProbability * 100) : "na"
        humidity.text = item != nil ? String(format: "%2.0f%", item.humidity * 100) : "na"
        detail.text = item != nil ? item.summary : "na"
        errorLabel.hidden = error == nil;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
