function price () {
  const priceField = document.getElementById('item-price');
  const taxPriceElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');

  if (priceField) {
    priceField.addEventListener('input', () => {
      const price = parseInt(priceField.value, 10);

      if (!isNaN(price) && price >= 300 && price <= 9999999) {
        const taxPrice = Math.floor(price * 0.1);
        const profit = price - taxPrice;

        taxPriceElement.textContent = taxPrice;
        profitElement.textContent = profit;
      } else {
        taxPriceElement.textContent = '';
        profitElement.textContent = '';
      }
    });
  }
}

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);