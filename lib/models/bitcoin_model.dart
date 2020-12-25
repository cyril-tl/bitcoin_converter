
class BitcoinResponse {
  String by;
  bool validKey;
  Results results;
  double executionTime;
  bool fromCache;

  BitcoinResponse(
      {
        this.by,
        this.validKey,
        this.results,
        this.executionTime,
        this.fromCache
      }
  );
  factory BitcoinResponse.fromJson(Map<String, dynamic> json) => BitcoinResponse(
    by: json["by"],
    validKey: json["valid_key"],
    results: Results.fromJson(json["results"]),
    executionTime: json["execution_time"],
    fromCache: json["from_cache"],
  );
/*
  BitcoinResponse.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    validKey = json['valid_key'];
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    executionTime = json['execution_time'];
    fromCache = json['from_cache'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['valid_key'] = this.validKey;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['execution_time'] = this.executionTime;
    data['from_cache'] = this.fromCache;
    return data;
  }
 */
}

class Results {
  Currencies currencies;
 /* Stocks stocks;
  List<String> availableSources;
  Bitcoin bitcoin;
  List<Taxes> taxes;
*/
  Results(
      {this.currencies,
  /*    this.stocks,
      this.availableSources,
      this.bitcoin,
      this.taxes*/
      });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    currencies: Currencies.fromJson(json["currencies"]),
  );

/*
  Results.fromJson(Map<String, dynamic> json) {
    currencies = json['currencies'] != null
        ? new Currencies.fromJson(json['currencies'])
        : null;
    stocks =
        json['stocks'] != null ? new Stocks.fromJson(json['stocks']) : null;
    availableSources = json['available_sources'].cast<String>();
    bitcoin =
        json['bitcoin'] != null ? new Bitcoin.fromJson(json['bitcoin']) : null;
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      //taxes = new List<Taxes>(); // deprecated syntax
      json['taxes'].forEach((v) {
        taxes.add(new Taxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currencies != null) {
      data['currencies'] = this.currencies.toJson();
    }
  if (this.stocks != null) {
      data['stocks'] = this.stocks.toJson();
    }
    data['available_sources'] = this.availableSources;
    if (this.bitcoin != null) {
      data['bitcoin'] = this.bitcoin.toJson();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
    }
    return data;
  }
  */
}

class Currencies {
  String source;
  Fiat usd;
  Fiat eur;
  Fiat gbp;
  Fiat jpy;
  Fiat btc;
  Currencies({
    this.source,
    this.usd,
    this.eur,
    this.gbp,
    this.jpy,
    this.btc,
  });

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
    source: json["source"],
    usd: Fiat.fromJson(json["USD"]),
    eur: Fiat.fromJson(json["EUR"]),
    gbp: Fiat.fromJson(json["GBP"]),
    jpy: Fiat.fromJson(json["JPY"]),
    btc: Fiat.fromJson(json["BTC"]),
  );

  @override
  String toString() {
    return 'Currencies{source: $source, usd: $usd, eur: $eur, gbp: $gbp, jpy: $jpy, btc: $btc}';
  }
}


class Fiat {
  String name;
  double buy;
  double sell;
  double variation;
  Fiat({
    this.name,
    this.buy,
    this.sell,
    this.variation,
  });

  factory Fiat.fromJson(Map<String, dynamic> json) {
    return Fiat(
      name: json["name"],
      buy: json["buy"].toDouble(),
      sell: json["sell"] == null ? null : json["sell"].toDouble(),
      variation: json["variation"].toDouble(),
    );
  }

  @override
  String toString() {
    return 'Fiat{name: $name, buy: $buy, sell: $sell, variation: $variation}';
  }
}
/*
class Currencies {
  String source;
  USD uSD;
  USD eUR;
  GBP gBP;
  GBP aRS;
  GBP cAD;
  GBP aUD;
  GBP jPY;
  GBP cNY;
  USD bTC;

  Currencies(
      {this.source,
      this.uSD,
      this.eUR,
      this.gBP,
      this.aRS,
      this.cAD,
      this.aUD,
      this.jPY,
      this.cNY,
      this.bTC});

  Currencies.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
    eUR = json['EUR'] != null ? new USD.fromJson(json['EUR']) : null;
    gBP = json['GBP'] != null ? new GBP.fromJson(json['GBP']) : null;
    aRS = json['ARS'] != null ? new GBP.fromJson(json['ARS']) : null;
    cAD = json['CAD'] != null ? new GBP.fromJson(json['CAD']) : null;
    aUD = json['AUD'] != null ? new GBP.fromJson(json['AUD']) : null;
    jPY = json['JPY'] != null ? new GBP.fromJson(json['JPY']) : null;
    cNY = json['CNY'] != null ? new GBP.fromJson(json['CNY']) : null;
    bTC = json['BTC'] != null ? new USD.fromJson(json['BTC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    if (this.eUR != null) {
      data['EUR'] = this.eUR.toJson();
    }
    if (this.gBP != null) {
      data['GBP'] = this.gBP.toJson();
    }
    if (this.aRS != null) {
      data['ARS'] = this.aRS.toJson();
    }
    if (this.cAD != null) {
      data['CAD'] = this.cAD.toJson();
    }
    if (this.aUD != null) {
      data['AUD'] = this.aUD.toJson();
    }
    if (this.jPY != null) {
      data['JPY'] = this.jPY.toJson();
    }
    if (this.cNY != null) {
      data['CNY'] = this.cNY.toJson();
    }
    if (this.bTC != null) {
      data['BTC'] = this.bTC.toJson();
    }
    return data;
  }
}

class USD {
  String name;
  double buy;
  double sell;
  double variation;

  USD({this.name, this.buy, this.sell, this.variation});

  USD.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buy = json['buy'];
    sell = json['sell'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['variation'] = this.variation;
    return data;
  }
}

class GBP {
  String name;
  double buy;
  Null sell;
  double variation;

  GBP({this.name, this.buy, this.sell, this.variation});

  GBP.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buy = json['buy'];
    sell = json['sell'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['variation'] = this.variation;
    return data;
  }
}

class Stocks {
  IBOVESPA iBOVESPA;
  IBOVESPA nASDAQ;
  CAC cAC;
  CAC nIKKEI;

  Stocks({this.iBOVESPA, this.nASDAQ, this.cAC, this.nIKKEI});

  Stocks.fromJson(Map<String, dynamic> json) {
    iBOVESPA = json['IBOVESPA'] != null
        ? new IBOVESPA.fromJson(json['IBOVESPA'])
        : null;
    nASDAQ =
        json['NASDAQ'] != null ? new IBOVESPA.fromJson(json['NASDAQ']) : null;
    cAC = json['CAC'] != null ? new CAC.fromJson(json['CAC']) : null;
    nIKKEI = json['NIKKEI'] != null ? new CAC.fromJson(json['NIKKEI']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iBOVESPA != null) {
      data['IBOVESPA'] = this.iBOVESPA.toJson();
    }
    if (this.nASDAQ != null) {
      data['NASDAQ'] = this.nASDAQ.toJson();
    }
    if (this.cAC != null) {
      data['CAC'] = this.cAC.toJson();
    }
    if (this.nIKKEI != null) {
      data['NIKKEI'] = this.nIKKEI.toJson();
    }
    return data;
  }
}

class IBOVESPA {
  String name;
  String location;
  double points;
  double variation;

  IBOVESPA({this.name, this.location, this.points, this.variation});

  IBOVESPA.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    points = json['points'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['points'] = this.points;
    data['variation'] = this.variation;
    return data;
  }
}

class CAC {
  String name;
  String location;
  double variation;

  CAC({this.name, this.location, this.variation});

  CAC.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['location'] = this.location;
    data['variation'] = this.variation;
    return data;
  }
}

class Bitcoin {
  BlockchainInfo blockchainInfo;
  Coinbase coinbase;
  BlockchainInfo bitstamp;
  Coinbase foxbit;
  Mercadobitcoin mercadobitcoin;

  Bitcoin(
      {this.blockchainInfo,
      this.coinbase,
      this.bitstamp,
      this.foxbit,
      this.mercadobitcoin});

  Bitcoin.fromJson(Map<String, dynamic> json) {
    blockchainInfo = json['blockchain_info'] != null
        ? new BlockchainInfo.fromJson(json['blockchain_info'])
        : null;
    coinbase = json['coinbase'] != null
        ? new Coinbase.fromJson(json['coinbase'])
        : null;
    bitstamp = json['bitstamp'] != null
        ? new BlockchainInfo.fromJson(json['bitstamp'])
        : null;
    foxbit =
        json['foxbit'] != null ? new Coinbase.fromJson(json['foxbit']) : null;
    mercadobitcoin = json['mercadobitcoin'] != null
        ? new Mercadobitcoin.fromJson(json['mercadobitcoin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blockchainInfo != null) {
      data['blockchain_info'] = this.blockchainInfo.toJson();
    }
    if (this.coinbase != null) {
      data['coinbase'] = this.coinbase.toJson();
    }
    if (this.bitstamp != null) {
      data['bitstamp'] = this.bitstamp.toJson();
    }
    if (this.foxbit != null) {
      data['foxbit'] = this.foxbit.toJson();
    }
    if (this.mercadobitcoin != null) {
      data['mercadobitcoin'] = this.mercadobitcoin.toJson();
    }
    return data;
  }
}

class BlockchainInfo {
  String name;
  List<String> format;
  double last;
  double buy;
  double sell;
  double variation;

  BlockchainInfo(
      {this.name, this.format, this.last, this.buy, this.sell, this.variation});

  BlockchainInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    format = json['format'].cast<String>();
    last = json['last'];
    buy = json['buy'];
    sell = json['sell'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['format'] = this.format;
    data['last'] = this.last;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['variation'] = this.variation;
    return data;
  }
}

class Coinbase {
  String name;
  List<String> format;
  double last;
  double variation;

  Coinbase({this.name, this.format, this.last, this.variation});

  Coinbase.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    format = json['format'].cast<String>();
    last = json['last'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['format'] = this.format;
    data['last'] = this.last;
    data['variation'] = this.variation;
    return data;
  }
}

class Mercadobitcoin {
  String name;
  List<String> format;
  double last;
  double buy;
  double sell;
  double variation;

  Mercadobitcoin(
      {this.name, this.format, this.last, this.buy, this.sell, this.variation});

  Mercadobitcoin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    format = json['format'].cast<String>();
    last = json['last'];
    buy = json['buy'];
    sell = json['sell'];
    variation = json['variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['format'] = this.format;
    data['last'] = this.last;
    data['buy'] = this.buy;
    data['sell'] = this.sell;
    data['variation'] = this.variation;
    return data;
  }
}

class Taxes {
  String date;
  double cdi;
  double selic;
  double dailyFactor;
  double selicDaily;
  double cdiDaily;

  Taxes(
      {this.date,
      this.cdi,
      this.selic,
      this.dailyFactor,
      this.selicDaily,
      this.cdiDaily});

  Taxes.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    cdi = json['cdi'];
    selic = json['selic'];
    dailyFactor = json['daily_factor'];
    selicDaily = json['selic_daily'];
    cdiDaily = json['cdi_daily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['cdi'] = this.cdi;
    data['selic'] = this.selic;
    data['daily_factor'] = this.dailyFactor;
    data['selic_daily'] = this.selicDaily;
    data['cdi_daily'] = this.cdiDaily;
    return data;
  }
}
*/
