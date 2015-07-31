//
//  ViewController.swift
//  Prememester
//
//  Created by Denzel Carter on 7/29/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MovieListViewController: UITableViewController {
    
    var resultsMovienameArray = [String]()
    var resultsImageFiles = [PFFile]()
    var resultsVideoFiles = [PFFile]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        resultsMovienameArray.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        var query = PFQuery(className: "Videos")
        var objects = query.findObjects()
        for object in objects! {
            
            self.resultsMovienameArray.append(object["name"] as! String)
            self.resultsImageFiles.append(object["picture"] as! PFFile)
            
            
            
            
            
            self.tableView.reloadData()
            
            
        }
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return resultsMovienameArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as! MovieViewCell
        
        // Configure the cell...
        
        cell.movieTxtNameLbl.text = self.resultsMovienameArray[indexPath.row]
        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                cell.movieImg.image = image
                
            }
        }
        
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! MovieViewCell
        self.performSegueWithIdentifier("viewMe", sender: self)
    }


}

