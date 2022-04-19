// Valid email format <any symbols>@<any characters, numbers or dash>.<any characters, numbers, dash or comma>
final RegExp kEmailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+[.]+[?:\.[a-zA-Z0-9-.]+]*$',
);

// Valis password At least 8 symbols long, at least one lower case, one upper case and one number
final RegExp kPasswordRegExp = RegExp(
  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
);
