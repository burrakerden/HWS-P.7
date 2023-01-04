//
//  ViewController.swift
//  Hws_Project7
//
//  Created by Burak Erden on 19.12.2022.
//

import UIKit

class SecondViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetititons = [Petition]()
    let urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        barButtonItems()
        getData()
    }
    
    func getData() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {   // eğer internet yoksa try? appin çökmemesini sağlıyor.
                parse(json: data)
                return
            }
        }
        showErrorMsg()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetititons = petitions
            tableView.reloadData()
        }
    }
    
    //MARK: Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetititons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTwo", for: indexPath)
        let petition = filteredPetititons[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SecondDetail") as? SecondDetailViewController {
            vc.detailItem = filteredPetititons[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: Bar Button Items
    private func barButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        let button1 = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filter))
        let button2 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reflesh))
        navigationItem.leftBarButtonItems = [button1, button2]
        
    }
    
    @objc func credits() {
        let ac2 = UIAlertController(title: "The data comes from:", message: "\(urlString)", preferredStyle: .alert)
        ac2.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(ac2, animated: true)
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Type what you wanna search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let denemeAction = UIAlertAction(title: "submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.showPetitions(for: answer)
        }
        ac.addAction(denemeAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func reflesh() {
        filteredPetititons = petitions
        tableView.reloadData()
    }
    
    func showPetitions(for filter: String) {
        filteredPetititons = filteredPetititons.filter { $0.title.contains(filter) }
        print(filteredPetititons)
        self.tableView.reloadData()
    }
    
    //MARK: Alert Controller
    func showErrorMsg() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem about....", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}
