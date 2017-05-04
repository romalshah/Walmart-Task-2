//
//  ViewController.swift
//  Walmart Task
//
//  Created by Romal Shah on 5/3/17.
//  Copyright © 2017 Romal Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var moviesArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as! MovieTableViewCell
        let movieDetails = moviesArray[indexPath.row] as! NSDictionary
        let imageString = "http://image.tmdb.org/t/p/w185//"
        let imaStr = movieDetails.value(forKey: "poster_path") as? String
        if (imaStr == nil ){
        
        }
        else {
            let url = URL(string: imageString + imaStr!)
            let imageData = try? Data(contentsOf: url!)
            let myImage =  UIImage(data: imageData!)
            cell.movieimageView.image = myImage

        }
        cell.movieTitleLabel.text = movieDetails.value(forKey: "title") as? String
        cell.movieOverViewLabel.text = movieDetails.value(forKey: "original_language") as? String

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220;
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let selectedMovieViewController = storyboard.instantiateViewController(withIdentifier: "MovieVC") as! SelectedMovieViewController
        selectedMovieViewController.dict = moviesArray[indexPath.row]  as! NSDictionary
        self.navigationController?.pushViewController(selectedMovieViewController, animated: true)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let string = "https://api.themoviedb.org/3/search/movie?api_key=eb902d819e0129551c1689f6025c1ec3&query="
        let url = URL(string: string + searchBar.text!)
        if let data = try? Data(contentsOf: url!) {
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                
                //Store response in NSDictionary for easy access
                let dict = parsedData as? NSDictionary
                moviesArray = dict?.object(forKey: "results") as! NSArray
                print(moviesArray)
           tableView.reloadData()
            }
                //else throw an error detailing what went wrong
            catch let error as NSError {
                print("Details of JSON parsing error:\n \(error)")
            }
        }
    }
}

