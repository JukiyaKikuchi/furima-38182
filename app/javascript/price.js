function price (){
  const input = document.getElementById("item-price");
  input.addEventListener("input", () => {
    const inputValue = input.value;
    const addTax = document.getElementById("add-tax-price")
    addTax.innerHTML = Math.floor(inputValue * 0.1);
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.floor(inputValue - Math.floor(inputValue * 0.1));    
  })
};

window.addEventListener('load', price);
