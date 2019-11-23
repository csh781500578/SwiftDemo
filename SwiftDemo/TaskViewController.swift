//
//  TaskViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/23.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    var list : [NBRequest] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableView.Style.grouped)
        view.rowHeight = 60
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension TaskViewController : NBTableDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let request = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = request.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let request = list[indexPath.row]
        
    }
}

