class Account {
  final String name;
  String category;
  String url;
  String user;
  String password;
  String phone;
  String mail;
  String note;
  String lastMod;

  Account(
      {this.name,
      this.category,
      this.url,
      this.user,
      this.password,
      this.phone,
      this.mail,
      this.note,
      this.lastMod,
      });

  static Account mock() {
    return new Account(
      name: '码云',
      category: '编程',
      url: 'www.coding',
      user: '770698596@',
      password: '180126',
      phone: '12344',
      mail: '1223@qq.co',
      note: '备注在此',
      lastMod: '2018-04-19'
    );
  }
}
