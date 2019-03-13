//
//  MainViewController
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 11/28/18.
//  Copyright © 2018 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit
class MainViewController: UIViewController {
    
    //MARK: Properties
    static let shared = MainViewController()
    var indexLeague:Int = 2
    var nameOfLeague: [String] = []
    
    //MARK: IBOutlet
    @IBOutlet weak var leagueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        startJSON()
    }
    
    private func setupTableView() {
        leagueTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func startJSON() {
        DispatchQueue.global().async {
            let httpUrl = "https://api-football-v1.p.rapidapi.com/leagues"
            guard let url = URL(string: httpUrl) else {
                return
            }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("hWUICAGXlPmshwNyRCgHnhK0VTPPp1fHJ0ujsnuwHKhVbRByY8", forHTTPHeaderField: "X-Mashape-Key")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(ApiData.self, from:
                        dataResponse)
                    for index in 1...model.api.results {
                        self.nameOfLeague.append((model.api.leagues["\(index)"]?.name ?? ""))
                    }
                    DispatchQueue.main.async {
                        self.leagueTableView.reloadData()
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    }
}

//MARK: Extension
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 8
    }
    //MARK: Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfLeague.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = leagueTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLeagueLabel.text = nameOfLeague[indexPath.row]
        indexLeague = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "presentMatchesInLeague", sender: self)
    }
}

