//
//  NewsListView.swift
//  FootballcoApp
//
//  Created by sebastianstaszczyk on 25/05/2022.
//

import SwiftUI

struct NewsListView: View {

    @ObservedObject var viewModel: NewsListVM

    var body: some View {
        List {
            ForEach(viewModel.articles) { article in
                NewsListRowView(article: article, onTap: { navigate(to: article) })
                    .listRowInsets(EdgeInsets())
            }

            if viewModel.isMorePages {
                ProgressView()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear { viewModel.binding.loadMore.send() }
            }
        }
        .listStyle(.plain)
        .navigationTitle("News")
        .overlay(LoadingIndicator(isLoading: viewModel.isLoading))
    }

    private func navigate(to article: Article) {
        viewModel.binding.navigateTo.send(.newsDetails(for: article))
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView(viewModel: .init(coordinator: nil))
    }
}

struct LoadingIndicator: View {

    let isLoading: Bool

    var body: some View {
        if isLoading { ProgressView() }
    }
}
