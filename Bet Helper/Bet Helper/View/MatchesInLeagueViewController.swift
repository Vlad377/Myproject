//
//  MatchesInLeagueViewController.swift
//  Bet Helper
//
//  Created by Vladyslav Zhulavskyi on 2/12/19.
//  Copyright © 2019 Vladyslav Zhulavskyi. All rights reserved.
//

import UIKit

class MatchesInLeagueViewController: UIViewController {
    var someLeague = League()
    @IBOutlet weak var titleNavBar: UINavigationBar!
    @IBOutlet weak var matchesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = someLeague.name
    }
}
