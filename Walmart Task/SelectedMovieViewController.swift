//
//  SelectedMovieViewController.swift
//  Walmart Task
//
//  Created by Romal Shah on 5/3/17.
//  Copyright © 2017 Romal Shah. All rights reserved.
//

import UIKit

class SelectedMovieViewController: UIViewController {
    
    var titleString = ""
    var dict:NSDictionary = [:]

    @IBOutlet weak var moviebannerImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!


    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!

    @IBOutlet weak var movieTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(dict)
        let imageString = "http://image.tmdb.org/t/p/w185//"
        let imaStr = dict.value(forKey: "poster_path") as? String
        if (imaStr == nil ){
            
        }
        else {
            let url = URL(string: imageString + imaStr!)
            let imageData = try? Data(contentsOf: url!)
            let myImage =  UIImage(data: imageData!)
            moviebannerImage.image = myImage
            
        }
        movieTitle.text = dict.value(forKey: "original_title") as? String
       overViewLabel.text = dict.value(forKey: "overview") as? String
        popularityLabel.text = dict.value(forKey: "popularity") as? String
        originalLanguageLabel.text = dict.value(forKey: "original_language") as? String
        releaseDateLabel.text = dict.value(forKey: "release_date") as? String
        

        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
