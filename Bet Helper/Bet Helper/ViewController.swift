//
//  ViewController.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 11/28/18.
//  Copyright © 2018 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var nameOfLeague = ["Premier League", "La Liga", "Bundesliga", "League 1", "Seria A"]
    var backgroundImageLeague: [UIImage] = []
    @IBOutlet weak var leagueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    private func setupTableView() {
        leagueTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height / 5
    }
    //MARK: -Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfLeague.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = leagueTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLeagueLabel.text = nameOfLeague[indexPath.row]
        return cell
    }
    
}

