class FormFieldModel {
  final String key;
  final String label;
  final bool isRequired;

  FormFieldModel({
    required this.key,
    required this.label,
    this.isRequired = false,
  });
}
