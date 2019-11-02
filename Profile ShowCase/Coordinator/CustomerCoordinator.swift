//
//  CustomerCoordinator.swift
//  Profile ShowCase
//
//  Created by Roberto Abreu on 11/2/19.
//  Copyright © 2019 homeappzz. All rights reserved.
//

import UIKit

class CustomerCoordinator: Coordinator {
        
    // MARK: - Public Vars
    var rootViewController: UINavigationController?
    
    func setupRootViewController() {
        let customerListViewModel = CustomerListViewModel(customerService: makeCustomerService())
        customerListViewModel.customerHasBeenSelected = { [weak self] customer in
            self?.showCustomerDetail(for: customer)
        }
        
        let customerListViewController = CustomerListViewController(viewModel: customerListViewModel)
        
        let navigationController = UINavigationController(rootViewController: customerListViewController)
        rootViewController = navigationController
    }
    
}

// MARK: - Flow
extension CustomerCoordinator {
    
    func showCustomerDetail(for customer: Customer) {
        let customerDetailViewModel = CustomerDetailViewModel(customer: customer, rowAdapter: makeRowAdapter())
        let customerDetailViewController = CustomerDetailViewController(viewModel: customerDetailViewModel)
        
        rootViewController?.pushViewController(customerDetailViewController, animated: true)
    }
    
}

// MARK: - Helpers
extension CustomerCoordinator {
    
    func makeCustomerService() -> CustomerService {
        return CustomerRemoteService()
    }
    
    func makeRowAdapter() -> RowAdapter {
        return InactiveCustomerAdapter()
    }
    
}
