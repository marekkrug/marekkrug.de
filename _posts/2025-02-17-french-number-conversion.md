---
title: Französischer Zahlenkonverter
date: 2025-02-17 09:45:00 +0100
categories: [blog, programmieren]
tags: [random, mini-scripts, französisch, schule]     # TAG names should always be lowercase
description: Ein einfacher Zahlenkonverter zum umrechnen französischer Zahlen
---

Ich hatte Schwierigkeiten mit der Aussprache von französischen Zahlen. Deshalb habe ich diesen kleinen Zahlenumrechner gebaut, mit dem man Zahlen in französische Zahlen umwandeln kann. Viel Spaß damit:

<div class="converter-container">
<html>
<head>
  <style>
    .converter-container {
      font-family: system-ui, -apple-system, sans-serif;
      width: 100%;
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      background-color: rgba(100,100,100,0.5);
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
    
    .result {
      padding: 1rem;
      border-radius: 4px;
      background-color: rgba(100,100,100,0.8);
      min-height: 3rem;
      font-size: clamp(1.2rem, 4vw, 2rem);
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      word-wrap: break-word;
      word-break: break-word;
    }
    
    .input-group {
      margin-top: 0.5rem;
    }
    
    input {
      background-color: rgba(100,100,100,0.5);
      width: 100%;
      padding: 1rem;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: clamp(1rem, 3vw, 1.5rem);
    }
    
    label {
      font-size: clamp(0.9rem, 2.5vw, 1.2rem);
    }

    /* Mobile-spezifische Anpassungen */
    @media (max-height: 600px) {
      .converter-container {
        margin: 10px auto;
        padding: 10px;
      }
      
      .result {
        min-height: 2.5rem;
        padding: 0.5rem;
      }
      
      input {
        padding: 0.5rem;
      }
    }
    
    /* Tablet-spezifische Anpassungen */
    @media (min-width: 768px) and (max-width: 1024px) {
      .converter-container {
        max-width: 90%;
      }
    }
  </style>
</head>
<body>
  <div class="converter-container">
    <div class="result" id="result">Gib eine Zahl ein, um sie in Französisch umzuwandeln</div>
    <div class="input-group">
      <input type="number" 
             id="numberInput" 
             placeholder="z.B. 42" 
             inputmode="numeric" 
             pattern="[0-9]*">
    </div>
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

    const input = document.getElementById('numberInput');
    const result = document.getElementById('result');

    input.addEventListener('input', function() {
      const number = parseInt(this.value);
      
      if (this.value === '') {
        result.textContent = "Geben Sie eine Zahl ein";
        return;
      }
      
      if (isNaN(number)) {
        result.textContent = "Bitte geben Sie eine gültige Zahl ein";
        return;
      }
      
      if (number < -999999 || number > 999999) {
        result.textContent = "Bitte geben Sie eine Zahl zwischen -999999 und 999999 ein";
        return;
      }
      
      result.textContent = convertToFrench(number);
    });
  </script>
</body>
</html>
</div>

---

J'avais du mal à prononcer les chiffres français. C'est pourquoi j'ai construit ce petit convertisseur de nombres qui permet de convertir des nombres en chiffres français. Amusez-vous bien avec :)

---

I had difficulties with the pronunciation of French numbers. That's why I made this little number converter to convert numbers into French numbers. Have fun with it :)