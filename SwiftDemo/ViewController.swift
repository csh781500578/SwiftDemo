//
//  ViewController.swift
//  Demo
//
//  Created by hanrychen on 2019/11/11.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var model : NBVCModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadData() {
        defer {
            reloadData()
        }
        
        guard let json = NBFileClient.default.jsonData("viewController.geojson") else {
            return
        }

        guard let data = json["data"] as? [String: AnyObject] else {
            return
        }
        model = NBVCModel.deserialize(from: data)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func pushToVC(_ model: NBVCObjcModel?) {
        guard let value = model else {
            return
        }
        if let vc = value.viewController {
            if let cls = NSClassFromString(vc) as? UIViewController.Type {
                let controller = cls.init()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableView.Style.grouped)
        view.rowHeight = 60
        view.sectionHeaderHeight = 60
        view.sectionFooterHeight = 0.5
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        return view
    }()
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let message = model?.messages?[section]
        if message?.open == false {
            return 0
        }
        return message?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let message = model?.messages?[section]
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? NBSectionHeaderView {
            view.model = message
        }
        let view = NBSectionHeaderView(reuseIdentifier: "header")
        view.model = message
        view.didSelectViewBlock = {[weak self] in
            self?.reloadData()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = model?.messages?[indexPath.section]
        let objc = message?.list?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = objc?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let message = model?.messages?[indexPath.section]
        let objc = message?.list?[indexPath.row]
        pushToVC(objc)
    }
}

