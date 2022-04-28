//
//  MoviesDetailsViewController.swift
//  MoviesApp
//
//  Created by Manav Shah on 4/27/22.
//

import UIKit

class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let baseURL_back = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let backDrop = movie["backdrop_path"] as! String
        let posterURL = URL(string: baseURL+posterPath)
        let backDropURL =  URL(string: baseURL_back+backDrop)
            
        titleLabel.text = movie["title"] as! String
        synopsisLabel.text = movie["overview"] as! String
        
        posterView.af_setImage(withURL: posterURL!)
        backDropView.af_setImage(withURL: backDropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
