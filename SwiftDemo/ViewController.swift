//
//  ViewController.swift
//  Demo
//
//  Created by hanrychen on 2019/11/11.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var list : [NBRequest] = []
    
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
        //        let metadataProvider = LPMetadataProvider()
        //        let url = URL(string: "https://www.apple.com/ipad")!
        //
        //        metadataProvider.startFetchingMetadata(for: url) { metadata, error in
        //            if error != nil {
        //                // The fetch failed; handle the error.
        //                return
        //            }
        //
        //            // Make use of fetched metadata.
        //        }
        
        let headers = HTTPHeaders([
            HTTPHeader(name: "1", value: "one"),
            HTTPHeader(name: "2", value: "two"),
            HTTPHeader(name: "3", value: "three"),
            HTTPHeader(name: "4", value: "four"),
            HTTPHeader(name: "4", value: "five")
            ])
        let _ = headers.dictionary
        
        print("最后一行")
        var name = "hanry"
        change(&name)
        print(name)
    }
    
    func change(_ name: inout String) {
        name += " chen"
        print(name)
    }
    
    func loadData() {
        guard let filePath = Bundle.main.path(forResource: "request", ofType: "geojson") else {
            return
        }
        
        do {
            guard let data = NSData.init(contentsOfFile: filePath) else {
                return
            }
            let diction = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            guard let json = diction as? [String: Any] else {
                return
            }
            if let array = json["request"] as? [[String: Any]] {
                for (obj) in array {
                    if let request = NBRequest.deserialize(from: obj) {
                        list.append(request)
                    }
                }
            }
        } catch {
        }
        
        tableView.reloadData()
    }
    
    func pushToRequestVC(_ request: NBRequest) {
        let vc = WebViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableView.Style.grouped)
        view.rowHeight = 60
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        pushToRequestVC(request)
    }
}

