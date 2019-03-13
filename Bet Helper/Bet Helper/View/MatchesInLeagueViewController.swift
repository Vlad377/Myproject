//
//  MatchesInLeagueViewController.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 2/12/19.
//  Copyright © 2019 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit

class MatchesInLeagueViewController: UIViewController {
    
    //MARK: Properties
    var leagueID = "2"
    var dataOfMatchList: [String] = []
    var homeTeamList: [String] = []
    var awakeTeamList: [String] = []
    
    //MARK: IBOutlet
    @IBOutlet weak var matchesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        startJSON()
    }
    
    private func setupTableView() {
        matchesTableView.register(UINib(nibName: "MatchesInLeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func startJSON() {
        DispatchQueue.global().async {
            let httpUrl = "https://api-football-v1.p.rapidapi.com/fixtures/league/\(MainViewController.shared.indexLeague)"
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
                    let model = try decoder.decode(MatchesInLeague.self, from:
                        dataResponse)
                    for index in 1...model.api.results {
                        self.dataOfMatchList.append(model.api.fixtures["\(index)"]?.eventDate ?? "")
                        self.homeTeamList.append(model.api.fixtures["\(index)"]?.homeTeam ?? "")
                        self.awakeTeamList.append(model.api.fixtures["\(index)"]?.awayTeam ?? "")
                    }
                    DispatchQueue.main.async {
                        self.matchesTableView.reloadData()
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
extension MatchesInLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 8
    }
    //MARK: Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOfMatchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = matchesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MatchesInLeagueTableViewCell else {
            return UITableViewCell()
        }
        cell.dataLabel.text = dataOfMatchList[indexPath.row]
        cell.homeTeamLabel.text = homeTeamList[indexPath.row]
        cell.awakeTeamLabel.text = awakeTeamList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "predictionInfo", sender: self)
    }
}
