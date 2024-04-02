// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI
import SkipWeb
import NetSkipModel


public struct ContentView: View {
    static var defaultSearchEngines: [SearchEngine] = [
        .google,
        .duckduckgo,
        .bing,
        .yahoo,
        .yandex,
        .baidu,
        .ecosia,
        .qwant,
        .swisscows,
        .startpage,
        .searx,
        .gigablast,
        .dogpile,
    ]

    let config = WebEngineConfiguration(javaScriptEnabled: true, searchEngines: Self.defaultSearchEngines)
    let store = try! NetSkipWebBrowserStore(url: URL.documentsDirectory.appendingPathComponent("netskip.sqlite"))

    public init() {
    }

    public var body: some View {
        NavigationStack {
            #if SKIP || os(iOS)
            WebBrowser(configuration: config, store: store)
                #if SKIP
                // eliminate blank space on Android: https://github.com/skiptools/skip/issues/99#issuecomment-2010650774
                .toolbar(.hidden, for: .navigationBar)
                #endif
            #endif
        }
    }
}


extension SearchEngine {
    public static let swisscows = SearchEngine(id: "swisscows", name: {
        NSLocalizedString("Swisscows", bundle: .module, comment: "search engine name for Swisscows")
    }) { q, l in
        "https://swisscows.com/web?query=\(q)"
    } suggestionURL: { q, l in
        // ["sailor moon","sailor","sailer verlag","sailfish","sailer"]
        "https://api.swisscows.com/suggest?query=\(q)&locale=\(l)" // &itemsCount=5
    }
}

extension SearchEngine {
    public static let duckduckgo = SearchEngine(id: "duckduckgo", name: {
        NSLocalizedString("DuckDuckGo", bundle: .module, comment: "search engine name for DuckDuckGo")
    }) { q, l in
        "https://duckduckgo.com/?q=\(q)"
    } suggestionURL: { q, l in
        "https://duckduckgo.com/ac/?q=\(q)&kl=\(l)"
    }
}

extension SearchEngine {
    public static let google = SearchEngine(id: "google", name: {
        NSLocalizedString("Google", bundle: .module, comment: "search engine name for Google")
    }) { q, l in
        "https://www.google.com/search?q=\(q)"
    } suggestionURL: { q, l in
        "https://www.google.com/complete/search?q=\(q)&client=safari&hl=\(l)"
    }
}

extension SearchEngine {
    public static let bing = SearchEngine(id: "bing", name: {
        NSLocalizedString("Bing", bundle: .module, comment: "search engine name for Bing")
    }) { q, l in
        "https://www.bing.com/search?q=\(q)"
    } suggestionURL: { q, l in
        // seems to require an API key
        nil // "https://www.bing.com/AS/Suggestions?q=\(q)"
    }
}

extension SearchEngine {
    public static let yahoo = SearchEngine(id: "yahoo", name: {
        NSLocalizedString("Yahoo!", bundle: .module, comment: "search engine name for Yahoo")
    }) { q, l in
        "https://search.yahoo.com/search?p=\(q)"
    } suggestionURL: { q, l in
        nil // https://search.yahooapis.com/WebSearchService/V1/relatedSuggestion?appid=YahooDemo&output=json&query=sail
    }
}

extension SearchEngine {
    public static let yandex = SearchEngine(id: "yandex", name: {
        NSLocalizedString("Yandex", bundle: .module, comment: "search engine name for Yandex")
    }) { q, l in
        "https://yandex.com/search/?text=\(q)"
    } suggestionURL: { q, l in
        nil // "https://suggest.yandex.net/suggest-ff.cgi?part=\(q)&uil=en&lid=1000000&clid=1000000&reqenc=utf-8&region=us"
    }
}

extension SearchEngine {
    public static let baidu = SearchEngine(id: "baidu", name: {
        NSLocalizedString("Baidu", bundle: .module, comment: "search engine name for baidu")
    }) { q, l in
        "http://www.baidu.com/s?wd=\(q)"
    } suggestionURL: { q, l in
        nil
    }
}

extension SearchEngine {
    public static let ecosia = SearchEngine(id: "ecosia", name: {
        NSLocalizedString("Ecosia", bundle: .module, comment: "search engine name for Ecosia")
    }) { q, l in
        "https://www.ecosia.org/search?q=\(q)"
    } suggestionURL: { q, l in
        nil
    }
}

extension SearchEngine {
    public static let qwant = SearchEngine(id: "qwant", name: {
        NSLocalizedString("Qwant", bundle: .module, comment: "search engine name for Qwant")
    }) { q, l in
        "https://www.qwant.com/?q=\(q)"
    } suggestionURL: { q, l in
        // {"status":"success","data":{"items":[{"value":"sailor moon","suggestType":0},{"value":"sailor","suggestType":0},{"value":"sailboat","suggestType":0},{"value":"sailpoint","suggestType":0},{"value":"sailrite","suggestType":0},{"value":"sailfish","suggestType":0},{"value":"sailboat insurance","suggestType":0}],"special":[]}}
        nil // "https://api.qwant.com/v3/suggest?q=\(q)&locale=\(l)"
    }
}

extension SearchEngine {
    public static let startpage = SearchEngine(id: "startpage", name: {
        NSLocalizedString("StartPage", bundle: .module, comment: "search engine name for StartPage")
    }) { q, l in
        "https://www.startpage.com/do/dsearch?query=\(q)"
    } suggestionURL: { q, l in
        nil
    }
}

extension SearchEngine {
    public static let searx = SearchEngine(id: "searx", name: {
        NSLocalizedString("Searx", bundle: .module, comment: "search engine name for Searx")
    }) { q, l in
        "https://searx.me/?q=\(q)"
    } suggestionURL: { q, l in
        nil
    }
}

extension SearchEngine {
    public static let gigablast = SearchEngine(id: "gigablast", name: {
        NSLocalizedString("GigaBlast", bundle: .module, comment: "search engine name for GigaBlast")
    }) { q, l in
        "https://www.gigablast.com/search?q=\(q)"
    } suggestionURL: { q, l in
        nil
    }
}

extension SearchEngine {
    public static let dogpile = SearchEngine(id: "dogpile", name: {
        NSLocalizedString("Dogpile", bundle: .module, comment: "search engine name for Dogpile")
    }) { q, l in
        "https://www.dogpile.com/serp?q=\(q)"
    } suggestionURL: { q, l in
        nil // "https://www.dogpile.com/serp/suggestions.js?qc=QUERY&_=1646097468734"
    }
}

//extension SearchEngine {
//    public static let XXX = SearchEngine(id: "XXX", name: {
//        NSLocalizedString("XXX", bundle: .module, comment: "search engine name for XXX")
//    }) { q, l in
//        "XXX"
//    } suggestionURL: { q, l in
//        "XXX"
//    }
//}

