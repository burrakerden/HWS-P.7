//
//  DetailViewController.swift
//  Hws_Project7
//
//  Created by Burak Erden on 20.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var textSpace: UILabel!
    var detailItem: Petition?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else {return}
        textSpace.text = detailItem.body

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
