//
//  StickyHeaderTableViewController.swift
//  ScratchApp
//
//  Created by HTS-676 on 13/03/25.
//


import UIKit

class StickyHeaderTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView(frame: .zero, style: .plain) // Sticky headers work with plain style
    var sections: [(title: String, content: [String])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupData()
        setupTableView()
    }

    func setupData() {
        sections = [
            (title: "Section 1", content: ["Item 1", "Item 2", "Item 3", "Item 3", "Item 3", "Item 3", "Item 3"]),
            (title: "Section 2", content: ["Item 4", "Item 5", "Item 6"]),
            (title: "Section 3", content: ["Item 7", "Item 8", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9", "Item 9"])
        ]
    }

    func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].content[indexPath.row]
        return cell
    }

    // MARK: - Sticky Section Headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray

        let label = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.bounds.width, height: 40))
        label.text = sections[section].title
        label.font = UIFont.boldSystemFont(ofSize: 18)
        headerView.addSubview(label)

        return headerView
    }
}
