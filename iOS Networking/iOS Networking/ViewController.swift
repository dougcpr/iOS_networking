//
//  ViewController.swift
//  iOS Networking
//
//  Created by Douglas Cooper on 11/24/16.
//  Copyright © 2016 Douglas Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*  1. Calling the super delegeta to intialize view did load function(s): getMovieTitle
        2. FUNCTION: getMovieTitle()
         2a. Sets up Session Configuration and URL for HTTP request
          2b. Intializes local variable, task, to a session data task
          2c. If no error returns, an HTTP request is made and variable json is
              cast as a Dictionary<String, any>. The movie db returns 4 parameters:
              total pages accessible, results (how many hits you received), total potential hits,
              and the number of pages you hit
          2d. Assigns a variable to the results array
          2e. Loops over results array and queries for movie titles, and prints title
    */
    

    //************************************//
    //************************************//
    // 1.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getMovieTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //************************************//
    //************************************//
    // 2. Function Call
    func getMovieTitle(){
        
        // 2a. Session Configuration
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=92cb81ddfc3428a603c8de20d6ee594b&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")!
    
        // 2b. Task Assignment
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
    
            if error != nil {
    
                print(error!.localizedDescription)
    
            } else {
                
                // 2c. Make the HTTP GET Request
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                    {
                        // 2d. Assign a local variable to the HTTP response of results
                        let movieResults = json["results"] as! [AnyObject]
                        // 2e. Iterate over the results and look for the key "title"
                        //     Print any values associated with key "title"
                        for results in movieResults {
                            let title = results["title"] as! String
                            print(title)
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
    
                }
            }
    
        })
        
        // 2f. Start the task
        task.resume()

    }

}

