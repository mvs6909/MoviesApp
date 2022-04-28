//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by Manav Shah on 4/27/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    var movies = [[String:Any]]()   //creating an array of Dictionaries

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("Printing in viewDidLoad in MoviesViewController")
        
        //API request to get Movies data into dataDictionary
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.movies = dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
             }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Used for number of rows in the table view
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let imageURL = URL(string: baseURL+posterPath)
        
        cell.posterView.af_setImage(withURL: imageURL!)
        
        
        
        return cell
    }
}
