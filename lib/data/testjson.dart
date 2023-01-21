class Resto {
  List<Datat> datat;

  Resto({this.datat});

  Resto.fromJson(Map<String, dynamic> json) {
    if (json['datat'] = null) {
      datat = <Datat>[];
      json['datat'].forEach((v) {
        datat.add(new Datat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datat = null) {
      data['datat'] = this.datat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datat {
  String type;
  Data data;

  Datat({this.type, this.data});

  Datat.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] = null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data = null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String topTitle;
  List<String> subTitles;
  List<String> address;
  String billNo;
  String ticketNo;
  String dateOfBill;
  String preprationDate;
  String time;
  String print;
  String table;
  String onlineOrderId;
  String employee;
  String till;
  String orderType;
  String customerName;
  String customerPhone;
  List<String> customerAddress;
  List<String> customerRemarks;
  String splitBillString;
  List<String> headercomments;
  List<Itemdata> itemdata;
  String key;
  double value;
  String receipt;
  List<String> printerName;
  String printType;
  int itemLength;
  bool printLogo;
  String thankyouNote;
  String thankyouNote2;
  String printerType;
  Columnheader columnheader;
  List<Columndata> columndata;
  List<String> receiptText;
  List<String> footerText;
  String url;

  Data(
      {this.topTitle,
      this.subTitles,
      this.address,
      this.billNo,
      this.ticketNo,
      this.dateOfBill,
      this.preprationDate,
      this.time,
      this.print,
      this.table,
      this.onlineOrderId,
      this.employee,
      this.till,
      this.orderType,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.customerRemarks,
      this.splitBillString,
      this.headercomments,
      this.itemdata,
      this.key,
      this.value,
      this.receipt,
      this.printerName,
      this.printType,
      this.itemLength,
      this.printLogo,
      this.thankyouNote,
      this.thankyouNote2,
      this.printerType,
      this.columnheader,
      this.columndata,
      this.receiptText,
      this.footerText,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    topTitle = json['top_title'];
    subTitles = json['sub_titles'].cast<String>();
    address = json['address'].cast<String>();
    billNo = json['bill_no'];
    ticketNo = json['ticket_no'];
    dateOfBill = json['date_of_bill'];
    preprationDate = json['prepration_date'];
    time = json['time'];
    print = json['print'];
    table = json['table'];
    onlineOrderId = json['online_order_id'];
    employee = json['employee'];
    till = json['till'];
    orderType = json['order_type'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'].cast<String>();
    customerRemarks = json['customer_remarks'].cast<String>();
    splitBillString = json['split_bill_string'];
    headercomments = json['headercomments'].cast<String>();
    if (json['itemdata'] = null) {
      itemdata = <Itemdata>[];
      json['itemdata'].forEach((v) {
        itemdata.add(new Itemdata.fromJson(v));
      });
    }
    key = json['key'];
    value = json['value'];
    receipt = json['receipt'];
    printerName = json['printer_name'].cast<String>();
    printType = json['print_type'];
    itemLength = json['item_length'];
    printLogo = json['print_logo'];
    thankyouNote = json['thankyou_note'];
    thankyouNote2 = json['thankyou_note2'];
    printerType = json['printer_type'];
    columnheader = json['columnheader'] = null ?
         new Columnheader.fromJson(json['columnheader'])
        : null;
    if (json['columndata'] = null) {
      columndata = <Columndata>[];
      json['columndata'].forEach((v) {
        columndata.add(new Columndata.fromJson(v));
      });
    }
    receiptText = json['receipt_text'].cast<String>();
    footerText = json['footer_text'].cast<String>();
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['top_title'] = this.topTitle;
    data['sub_titles'] = this.subTitles;
    data['address'] = this.address;
    data['bill_no'] = this.billNo;
    data['ticket_no'] = this.ticketNo;
    data['date_of_bill'] = this.dateOfBill;
    data['prepration_date'] = this.preprationDate;
    data['time'] = this.time;
    data['print'] = this.print;
    data['table'] = this.table;
    data['online_order_id'] = this.onlineOrderId;
    data['employee'] = this.employee;
    data['till'] = this.till;
    data['order_type'] = this.orderType;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['customer_remarks'] = this.customerRemarks;
    data['split_bill_string'] = this.splitBillString;
    data['headercomments'] = this.headercomments;
    if (this.itemdata = null) {
      data['itemdata'] = this.itemdata.map((v) => v.toJson()).toList();
    }
    data['key'] = this.key;
    data['value'] = this.value;
    data['receipt'] = this.receipt;
    data['printer_name'] = this.printerName;
    data['print_type'] = this.printType;
    data['item_length'] = this.itemLength;
    data['print_logo'] = this.printLogo;
    data['thankyou_note'] = this.thankyouNote;
    data['thankyou_note2'] = this.thankyouNote2;
    data['printer_type'] = this.printerType;
    if (this.columnheader = null) {
      data['columnheader'] = this.columnheader.toJson();
    }
    if (this.columndata = null) {
      data['columndata'] = this.columndata.map((v) => v.toJson()).toList();
    }
    data['receipt_text'] = this.receiptText;
    data['footer_text'] = this.footerText;
    data['url'] = this.url;
    return data;
  }
}

class Itemdata {
  int orderInvoiceId;
  double itemAmount;
  String itemName;
  String itemSubLine;
  List<String> toppingsWithPrice;
  List<String> toppings;
  int quantity;
  bool selected;
  double price;
  String custpmerRemarks;
  String printerName;
  String printerLabel;
  String station;
  String foodStampable;
  List<Items> items;
  String printDescription;
  bool deleted;
  bool exists;
  int displayIndex;
  bool isPrinted;
  bool madeTo;
  String menuGroup;
  bool kitchenPrint;

  Itemdata(
      {this.orderInvoiceId,
      this.itemAmount,
      this.itemName,
      this.itemSubLine,
      this.toppingsWithPrice,
      this.toppings,
      this.quantity,
      this.selected,
      this.price,
      this.custpmerRemarks,
      this.printerName,
      this.printerLabel,
      this.station,
      this.foodStampable,
      this.items,
      this.printDescription,
      this.deleted,
      this.exists,
      this.displayIndex,
      this.isPrinted,
      this.madeTo,
      this.menuGroup,
      this.kitchenPrint});

  Itemdata.fromJson(Map<String, dynamic> json) {
    orderInvoiceId = json['order_invoice_id'];
    itemAmount = json['item_amount'];
    itemName = json['item_name'];
    itemSubLine = json['item_subLine'];
    toppingsWithPrice = json['toppings_with_price'].cast<String>();
    toppings = json['toppings'].cast<String>();
    quantity = json['quantity'];
    selected = json['selected'];
    price = json['price'];
    custpmerRemarks = json['custpmer_remarks'];
    printerName = json['printer_name'];
    printerLabel = json['printer_label'];
    station = json['station'];
    foodStampable = json['food_stampable'];
    if (json['items'] = null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    printDescription = json['print_description'];
    deleted = json['deleted'];
    exists = json['exists'];
    displayIndex = json['display_index'];
    isPrinted = json['is_printed'];
    madeTo = json['made_to'];
    menuGroup = json['menu_group'];
    kitchenPrint = json['kitchen_print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_invoice_id'] = this.orderInvoiceId;
    data['item_amount'] = this.itemAmount;
    data['item_name'] = this.itemName;
    data['item_subLine'] = this.itemSubLine;
    data['toppings_with_price'] = this.toppingsWithPrice;
    data['toppings'] = this.toppings;
    data['quantity'] = this.quantity;
    data['selected'] = this.selected;
    data['price'] = this.price;
    data['custpmer_remarks'] = this.custpmerRemarks;
    data['printer_name'] = this.printerName;
    data['printer_label'] = this.printerLabel;
    data['station'] = this.station;
    data['food_stampable'] = this.foodStampable;
    if (this.items = null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['print_description'] = this.printDescription;
    data['deleted'] = this.deleted;
    data['exists'] = this.exists;
    data['display_index'] = this.displayIndex;
    data['is_printed'] = this.isPrinted;
    data['made_to'] = this.madeTo;
    data['menu_group'] = this.menuGroup;
    data['kitchen_print'] = this.kitchenPrint;
    return data;
  }
}

class Items {
  String orderInvoiceId;
  int itemAmount;
  String itemName;
  String itemSubLine;
  List<String> toppingsWithPrice;
  List<String> toppings;
  int quantity;
  bool selected;
  int price;
  String custpmerRemarks;
  String printerName;
  String printerLabel;
  String station;
  String foodStampable;
  List<String> items;
  String printDescription;
  bool deleted;
  bool exists;
  int displayIndex;
  bool isPrinted;
  bool madeTo;
  List<String> menuGroup;
  bool kitchenPrint;

  Items(
      {this.orderInvoiceId,
      this.itemAmount,
      this.itemName,
      this.itemSubLine,
      this.toppingsWithPrice,
      this.toppings,
      this.quantity,
      this.selected,
      this.price,
      this.custpmerRemarks,
      this.printerName,
      this.printerLabel,
      this.station,
      this.foodStampable,
      this.items,
      this.printDescription,
      this.deleted,
      this.exists,
      this.displayIndex,
      this.isPrinted,
      this.madeTo,
      this.menuGroup,
      this.kitchenPrint});

  Items.fromJson(Map<String, dynamic> json) {
    orderInvoiceId = json['order_invoice_id'];
    itemAmount = json['item_amount'];
    itemName = json['item_name'];
    itemSubLine = json['item_subLine'];
    toppingsWithPrice = json['toppings_with_price'].cast<String>();
    toppings = json['toppings'].cast<String>();
    quantity = json['quantity'];
    selected = json['selected'];
    price = json['price'];
    custpmerRemarks = json['custpmer_remarks'];
    printerName = json['printer_name'];
    printerLabel = json['printer_label'];
    station = json['station'];
    foodStampable = json['food_stampable'];
    items = json['items'].cast<String>();
    printDescription = json['print_description'];
    deleted = json['deleted'];
    exists = json['exists'];
    displayIndex = json['display_index'];
    isPrinted = json['is_printed'];
    madeTo = json['made_to'];
    menuGroup = json['menu_group'].cast<String>();
    kitchenPrint = json['kitchen_print'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_invoice_id'] = this.orderInvoiceId;
    data['item_amount'] = this.itemAmount;
    data['item_name'] = this.itemName;
    data['item_subLine'] = this.itemSubLine;
    data['toppings_with_price'] = this.toppingsWithPrice;
    data['toppings'] = this.toppings;
    data['quantity'] = this.quantity;
    data['selected'] = this.selected;
    data['price'] = this.price;
    data['custpmer_remarks'] = this.custpmerRemarks;
    data['printer_name'] = this.printerName;
    data['printer_label'] = this.printerLabel;
    data['station'] = this.station;
    data['food_stampable'] = this.foodStampable;
    data['items'] = this.items;
    data['print_description'] = this.printDescription;
    data['deleted'] = this.deleted;
    data['exists'] = this.exists;
    data['display_index'] = this.displayIndex;
    data['is_printed'] = this.isPrinted;
    data['made_to'] = this.madeTo;
    data['menu_group'] = this.menuGroup;
    data['kitchen_print'] = this.kitchenPrint;
    return data;
  }
}

class Columnheader {
  String column1;
  String column2;
  String column3;
  String column4;

  Columnheader({this.column1, this.column2, this.column3, this.column4});

  Columnheader.fromJson(Map<String, dynamic> json) {
    column1 = json['column1'];
    column2 = json['column2'];
    column3 = json['column3'];
    column4 = json['column4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['column1'] = this.column1;
    data['column2'] = this.column2;
    data['column3'] = this.column3;
    data['column4'] = this.column4;
    return data;
  }
}
class Columndata {
  String column1;
  String column2;
  String column3;
  String column4;

  Columndata({this.column1, this.column2, this.column3, this.column4});

  Columndata.fromJson(Map<String, dynamic> json) {
    column1 = json['column1'];
    column2 = json['column2'];
    column3 = json['column3'];
    column4 = json['column4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['column1'] = this.column1;
    data['column2'] = this.column2;
    data['column3'] = this.column3;
    data['column4'] = this.column4;
    return data;
  }
}