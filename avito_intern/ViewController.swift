//
//  ViewController.swift
//  avito_intern
//
//  Created by Сергей Петров on 07.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var companies = Array<AvitoData>()
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
            self?.companies.append(data)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }.resume()
    }
}


extension ViewController: UITableViewDelegate {
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.companies[section].company.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else {
            print("return default cell!")
            return UITableViewCell()
        }
        cell.setup(employee: self.companies[indexPath.section].company.employees[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.companies.count
    }
}
