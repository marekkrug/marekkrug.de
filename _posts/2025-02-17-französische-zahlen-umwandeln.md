---
title: Französischer Zahlenkonverter
date: 2025-02-17 09:45:00 +0100
categories: [blog, programmieren]
tags: [random, mini-scripts, französisch, schule]     # TAG names should always be lowercase
description: Ein einfacher Zahlenkonverter zum umrechnen französischer Zahlen
---

## Französischer Zahlenkonverter

Ich hatte schwierigkeiten mit französischen Zahlen. Deshalb habe ich einfach mal diesen kleinen Zahlenkonverter gebaut. Viel Spaß damit:

<div class="converter-container">
<!DOCTYPE html>
<html>
<head>
  <style>
	.converter-container {
	  font-family: system-ui, -apple-system, sans-serif;
	  max-width: 600px;
	  margin: 20px auto;
	  padding: 20px;
	  border-radius: 8px;
	  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	  background-color: #f8f9fa;
	}
	
	.input-group {
	  margin-bottom: 15px;
	}
	
	input {
	  width: 100%;
	  padding: 8px;
	  border: 1px solid #ddd;
	  border-radius: 4px;
	  font-size: 16px;
	  margin-top: 5px;
	}
	
	button {
	  background-color: #007bff;
	  color: white;
	  border: none;
	  padding: 8px 16px;
	  border-radius: 4px;
	  cursor: pointer;
	  font-size: 16px;
	}
	
	button:hover {
	  background-color: #0056b3;
	}
	
	.result {
	  margin-top: 15px;
	  padding: 10px;
	  border-radius: 4px;
	  background-color: white;
	  min-height: 24px;
	}
  </style>
</head>
<body>
  <div class="converter-container">
	<div class="input-group">
	  <label for="numberInput">Geben Sie eine Zahl ein:</label>
	  <input type="number" id="numberInput" placeholder="z.B. 42">
	</div>
	<button onclick="convertNumber()">Umwandeln</button>
	<div class="result" id="result"></div>
  </div>

  <script>
	function convertToFrench(n) {
	  if (n === 0) return "zéro";
	  
	  const units = ["", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix", 
					 "onze", "douze", "treize", "quatorze", "quinze", "seize"];
	  const tens = ["", "dix", "vingt", "trente", "quarante", "cinquante", "soixante", "soixante", "quatre-vingt", "quatre-vingt"];
	  
	  if (n < 0) return `moins ${convertToFrench(-n)}`;
	  if (n < 17) return units[n];
	  if (n < 20) return `dix-${units[n-10]}`;
	  
	  if (n < 100) {
		const ten = Math.floor(n / 10);
		const unit = n % 10;
		
		if (ten === 7) {
		  if (unit === 1) return "soixante et onze";
		  return `soixante-${convertToFrench(10 + unit)}`;
		}
		if (ten === 9) {
		  return `quatre-vingt-${convertToFrench(10 + unit)}`;
		}
		if (unit === 0) return tens[ten];
		if (unit === 1) return `${tens[ten]} et ${units[unit]}`;
		return `${tens[ten]}-${units[unit]}`;
	  }
	  
	  if (n < 1000) {
		const hundreds = Math.floor(n / 100);
		const remainder = n % 100;
		
		const hundredStr = hundreds === 1 ? "cent" : `${units[hundreds]} cent`;
		if (remainder === 0) return hundredStr;
		return `${hundredStr} ${convertToFrench(remainder)}`;
	  }
	  
	  if (n < 1000000) {
		const thousands = Math.floor(n / 1000);
		const remainder = n % 1000;
		
		const thousandStr = thousands === 1 ? "mille" : `${convertToFrench(thousands)} mille`;
		if (remainder === 0) return thousandStr;
		return `${thousandStr} ${convertToFrench(remainder)}`;
	  }
	  
	  return "nombre trop grand";
	}

	function convertNumber() {
	  const input = document.getElementById('numberInput');
	  const result = document.getElementById('result');
	  const number = parseInt(input.value);
	  
	  if (isNaN(number)) {
		result.textContent = "Bitte geben Sie eine gültige Zahl ein";
		return;
	  }
	  
	  if (number < -999999 || number > 999999) {
		result.textContent = "Bitte geben Sie eine Zahl zwischen -999999 und 999999 ein";
		return;
	  }
	  
	  result.textContent = convertToFrench(number);
	}

	// Event-Listener für Enter-Taste
	document.getElementById('numberInput').addEventListener('keypress', function(e) {
	  if (e.key === 'Enter') {
		convertNumber();
	  }
	});
  </script>
</div>
</body>
</html>
</div>