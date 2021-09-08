//
//  ViewController.swift
//  avito_intern
//
//  Created by Сергей Петров on 07.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = Array<AvitoData>()
    let cellIdentifier = "TableViewCell"
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 5
        config.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: config)
        
        self.getData()
    }

    private func getData() {
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            print("Wrong url!")
            return
        }
        self.session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil, let data = data else {
                print("Error detected! Cannot get data! \(error?.localizedDescription ?? "Empty description")")
                return
            }
            
            guard let data = try? JSONDecoder().decode(AvitoData.self, from: data) else {
                print("Can't parse companies")
                return
            }
            self?.dataArray.append(data)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }.resume()
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.dataArray[section].company.name
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeader") as? TableViewHeader else {
            return UITableViewHeaderFooterView()
        }
        header.setup(title: self.dataArray[section].company.name)
        return header
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray[section].company.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else {
            print("return default cell!")
            return UITableViewCell()
        }
        cell.setup(employee: self.dataArray[indexPath.section].company.employees[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.dataArray.count
    }
}
