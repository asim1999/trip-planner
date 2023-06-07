class Trip{
  final String _id;
  final String _country;
  final DateTime _startDate;
  final DateTime _endDate;

  Trip(this._id, this._country, this._startDate, this._endDate);

  DateTime get endDate => _endDate;

  DateTime get startDate => _startDate;

  String get country => _country;

  String get id => _id;
}