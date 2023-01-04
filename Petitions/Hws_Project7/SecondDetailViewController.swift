//
//  SecondDetailViewController.swift
//  Hws_Project7
//
//  Created by Burak Erden on 21.12.2022.
//

import UIKit

class SecondDetailViewController: UIViewController {

    @IBOutlet weak var secondLabel: UILabel!
    var detailItem: Petition?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else {return}
        secondLabel.text = detailItem.body

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
