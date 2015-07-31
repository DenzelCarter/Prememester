//
//  MovieDetailedViewController.swift
//  Prememester
//
//  Created by Denzel Carter on 7/29/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import MediaPlayer

class MovieDetailedViewController: UIViewController {
    var moviePlayer:MPMoviePlayerController!
    var detailItem: AnyObject?
    var videoObject: PFObject!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var query = PFQuery(className: "Videos")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for object in objects! {
                    var theVideo:PFFile = object.objectForKey("video") as! PFFile
                    var url:NSURL = NSURL(string: theVideo.url!)!
                    theVideo.getDataInBackgroundWithBlock({ (data:NSData?, error: NSError?) -> Void in
                        if error == nil {
                            self.moviePlayer = MPMoviePlayerController(contentURL: url)
                            self.moviePlayer.view.frame = CGRect(x: 20, y: 100, width: 200, height: 150)
                            
                            self.view.addSubview(self.moviePlayer.view)
                            self.moviePlayer.fullscreen = true
                            
                            self.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
                            self.moviePlayer.prepareToPlay()
                            self.moviePlayer.play()
                            
                            
                            
                        }
                        
                    })
                    
                }
            }
            
        }
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
