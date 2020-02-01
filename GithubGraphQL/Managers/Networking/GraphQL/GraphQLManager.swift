import Foundation
import Apollo

/*
 To generate the GraphQL Schema
 cd "${SRCROOT}/Managers/Networking/GraphQL/"
 apollo schema:download --endpoint=https://api.github.com/graphql --header="Authorization: Bearer <token>"
 */

enum GQLClient {
  static func runQuery<Query: GraphQLQuery>(request: GraphQLRequest,
                                            query: Query,
                                            operationResultHandler: GraphQLResultHandler<Query.Data>? = nil) {
    GraphQLManager.client().fetch(query: query,
                                  cachePolicy: request.cachePolicy,
                                  queue: request.queue,
                                  resultHandler: operationResultHandler)
  }
}


class GraphQLManager {

  // MARK: - Properties
  private static let shared = GraphQLManager()

  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport = HTTPNetworkTransport(url: URL(string: githubGQL)!, delegate: self)

  // Use the configured network transport in your client.
  private(set) lazy var apolloClient = ApolloClient(networkTransport: self.networkTransport)

  class func client() -> ApolloClient {
    return GraphQLManager.shared.apolloClient
  }
}


extension GraphQLManager: HTTPNetworkTransportPreflightDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
    return true
  }

  func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {

    // Get the existing headers, or create new ones if they're nil
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    headers[HttpHeaders.authorization] = "Bearer \(githubToken)"

    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
  }
}
