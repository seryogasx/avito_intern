//
//  ViewController.swift
//  avito_intern
//
//  Created by Сергей Петров on 07.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataArray = Array<AvitoData>()
//    var dataArray = [AvitoData(company: Company(name: "Avito", employees: [Employee(name: "John", phone_number: "769453", skills: ["Swift", "iOS"]),
//                                                                           Employee(name: "Diego", phone_number: "987924", skills: ["Kotlin", "Android"]),
//                                                                           Employee(name: "Alfred", phone_number: "452533", skills: ["Objective-C", "Android", "Photoshop", "C++"]),
//                                                                           Employee(name: "John", phone_number: "212456", skills: ["Java", "Python"]),
//                                                                           Employee(name: "Mat", phone_number: "778975", skills: ["Android", "MovieMaker"]),
//                                                                           Employee(name: "Bob", phone_number: "456468", skills: ["Groovy", "Kotlin"]),
//                                                                           Employee(name: "Marty", phone_number: "321789", skills: ["Android", "PHP", "C#", /*"C++", "Python"*/])
//    ]))]
    
    let cellIdentifier = "TableViewCell"
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicator
        activityIndicator.hidesWhenStopped = true
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 5
        config.timeoutIntervalForRequest = 5
        self.session = URLSession(configuration: config)
        self.getData()
    }
    
    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    private func getData() {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            print("Wrong url!")
            return
        }
        self.session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil, let data = data else {
                print("Error detected! Cannot get data! \(error?.localizedDescription ?? "Empty description")")
                self?.showAlert(title: "Bad internet", message: "Reconnect every 5 sesonds")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
                    self?.getData()
                }
                return
            }
            
            guard let data = try? JSONDecoder().decode(AvitoData.self, from: data) else {
                print("Can't parse companies")
                return
            }
            self?.dataArray.append(data)
            self?.dataArray[0].company.employees.sort { $0.name.lowercased() < $1.name.lowercased() }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
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
        return self.dataArray[section].company.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableViewCell else {
            print("Return default table cell!")
            return UITableViewCell()
        }
        cell.setup(employee: self.dataArray[indexPath.section].company.employees[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.dataArray.count
    }
}
