//
//  ViewController.swift
//  iOS Networking
//
//  Created by Douglas Cooper on 11/24/16.
//  Copyright © 2016 Douglas Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getMovieTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovieTitle(){
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=92cb81ddfc3428a603c8de20d6ee594b&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")!
    
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
    
            if error != nil {
    
                print(error!.localizedDescription)
    
            } else {
    
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any>
                    {
                        //Implement your logic
                        let movieResults = json["results"] as! [AnyObject]
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
        task.resume()

    }

}

