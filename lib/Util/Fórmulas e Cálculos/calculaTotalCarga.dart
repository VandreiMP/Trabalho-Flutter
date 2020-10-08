double calculaValorTotalCarga(double precoLiquido, double unitario) {
  if ((precoLiquido != null && unitario != null)) {
    return (precoLiquido * unitario);
  } else if (precoLiquido == null || unitario == null) {
    return 0.00;
  }
}
