---
title: Französischer Zahlenkonverter
date: 2025-02-17 09:45:00 +0100
categories: [blog, programmieren]
tags: [random-projects, mini-scripts, französisch, schule, educational]
description: Ein einfacher Zahlenkonverter zum umrechnen französischer Zahlen
---

Ich hatte Schwierigkeiten mit der Aussprache von französischen Zahlen. Deshalb habe ich diesen kleinen Zahlenumrechner gebaut, mit dem man Zahlen in französische Zahlen umwandeln kann. Viel Spaß damit:

<div class="converter-container">
  <style>
    .converter-container {
      font-family: var(--body-font-family, system-ui, -apple-system, sans-serif);
      width: 100%;
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      background-color: var(--card-bg, #f5f5f5);
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
    .result {
      padding: 1rem;
      border-radius: 4px;
      background-color: var(--card-bg, white);
      min-height: 3rem;
      font-size: clamp(1.2rem, 4vw, 2rem);
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      word-wrap: break-word;
      word-break: break-word;
      color: var(--text-color, #333);
    }
    .input-group {
      margin-top: 0.5rem;
    }
    .converter-container input {
      width: 100%;
      padding: 1rem;
      border: 1px solid var(--border-color, #ddd);
      border-radius: 4px;
      font-size: clamp(1rem, 3vw, 1.5rem);
      background-color: var(--input-bg, white);
      color: var(--text-color, #333);
    }
    .tooltip {
      position: relative;
      display: inline-block;
      cursor: help;
    }
    .tooltip-text {
      visibility: hidden;
      position: absolute;
      z-index: 999;
      bottom: 125%;
      left: 50%;
      transform: translateX(-50%);
      width: 300px;
      background-color: var(--tooltip-bg, #333);
      color: var(--tooltip-text, #fff);
      text-align: left;
      padding: 10px;
      border-radius: 6px;
      font-size: 14px;
      opacity: 0;
      transition: opacity 0.3s;
    }
    .tooltip:hover .tooltip-text {
      visibility: visible;
      opacity: 1;
    }
    .number-part {
      padding: 2px 4px;
      border-radius: 3px;
    }
    .unit { color: var(--unit-color, #4CAF50); }
    .tens { color: var(--tens-color, #2196F3); }
    .hundred { color: var(--hundred-color, #F44336); }
    .thousand { color: var(--thousand-color, #9C27B0); }
    .connector { color: var(--connector-color, #FF9800); }
    .legend {
      margin-top: 20px;
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      font-size: 14px;
      color: var(--text-color, #333);
    }
    .legend-item {
      display: flex;
      align-items: center;
      gap: 5px;
    }
    .legend-color {
      width: 20px;
      height: 20px;
      border-radius: 3px;
    }
  </style>

  <div class="result" id="result">input a number</div>
  <div class="input-group">
    <input type="number" 
           id="numberInput" 
           placeholder="z.B. 42" 
           inputmode="numeric" 
           pattern="[0-9]*">
  </div>
  <div class="legend">
    <div class="legend-item">
      <div class="legend-color" style="background-color: #4CAF50"></div>
      Basic Numbers (1-16)
    </div>
    <div class="legend-item">
      <div class="legend-color" style="background-color: #2196F3"></div>
      Tens (20-90)
    </div>
    <div class="legend-item">
      <div class="legend-color" style="background-color: #F44336"></div>
      Hundreds
    </div>
    <div class="legend-item">
      <div class="legend-color" style="background-color: #9C27B0"></div>
      Thousands
    </div>
    <div class="legend-item">
      <div class="legend-color" style="background-color: #FF9800"></div>
      Connectors
    </div>
  </div>
</div>

<script defer>
  (function() {
    const numberRules = {
      'un': { de: 'Eins - Grundzahl', en: 'One - Basic number', fr: 'Un - Nombre de base' },
      'deux': { de: 'Zwei - Grundzahl', en: 'Two - Basic number', fr: 'Deux - Nombre de base' },
      'trois': { de: 'Drei - Grundzahl', en: 'Three - Basic number', fr: 'Trois - Nombre de base' },
      'quatre': { de: 'Vier - Grundzahl', en: 'Four - Basic number', fr: 'Quatre - Nombre de base' },
      'cinq': { de: 'Fünf - Grundzahl', en: 'Five - Basic number', fr: 'Cinq - Nombre de base' },
      'six': { de: 'Sechs - Grundzahl', en: 'Six - Basic number', fr: 'Six - Nombre de base' },
      'sept': { de: 'Sieben - Grundzahl', en: 'Seven - Basic number', fr: 'Sept - Nombre de base' },
      'huit': { de: 'Acht - Grundzahl', en: 'Eight - Basic number', fr: 'Huit - Nombre de base' },
      'neuf': { de: 'Neun - Grundzahl', en: 'Nine - Basic number', fr: 'Neuf - Nombre de base' },
      'dix': { de: 'Zehn', en: 'Ten', fr: 'Dix' },
      'onze': { de: 'Elf', en: 'Eleven', fr: 'Onze' },
      'douze': { de: 'Zwölf', en: 'Twelve', fr: 'Douze' },
      'treize': { de: 'Dreizehn', en: 'Thirteen', fr: 'Treize' },
      'quatorze': { de: 'Vierzehn', en: 'Fourteen', fr: 'Quatorze' },
      'quinze': { de: 'Fünfzehn', en: 'Fifteen', fr: 'Quinze' },
      'seize': { de: 'Sechzehn', en: 'Sixteen', fr: 'Seize' },
      'vingt': { de: 'Zwanzig', en: 'Twenty', fr: 'Vingt - Base for 20' },
      'trente': { de: 'Dreißig', en: 'Thirty', fr: 'Trente - Base for 30' },
      'quarante': { de: 'Vierzig', en: 'Forty', fr: 'Quarante - Base for 40' },
      'cinquante': { de: 'Fünfzig', en: 'Fifty', fr: 'Cinquante - Base for 50' },
      'soixante': { de: 'Sechzig', en: 'Sixty', fr: 'Soixante - Base for 60' },
      'soixante-dix': { de: 'Siebzig (60+10)', en: 'Seventy (60+10)', fr: 'Soixante-dix - 60 plus 10' },
      'quatre-vingt': { de: 'Achtzig (4x20)', en: 'Eighty (4x20)', fr: 'Quatre-vingt - 4 times 20' },
      'quatre-vingts': { de: 'Achtzig (mit s, wenn allein)', en: 'Eighty (with s when alone)', fr: 'Quatre-vingts - utilisé pour 80 exactement' },
      'quatre-vingt-dix': { de: 'Neunzig (4x20+10)', en: 'Ninety (4x20+10)', fr: 'Quatre-vingt-dix - 80 plus 10' },
      'cent': { de: 'Hundert', en: 'Hundred', fr: 'Cent' },
      'mille': { de: 'Tausend', en: 'Thousand', fr: 'Mille' },
      'et': { de: 'und', en: 'and', fr: 'et' }
    };

    function init() {
      const input = document.getElementById('numberInput');
      const result = document.getElementById('result');
      
      if (!input || !result) return;

      input.addEventListener('input', function() {
        const number = parseInt(this.value);
        
        if (this.value === '') {
          result.innerHTML = "input a number";
          return;
        }
        
        if (isNaN(number)) {
          result.innerHTML = "input a valid number";
          return;
        }
        
        if (number < -999999 || number > 999999) {
          result.innerHTML = "input a number between -999999 and 999999";
          return;
        }
        
        const frenchNumber = convertToFrench(number);
        result.innerHTML = colorizeAndAddTooltips(frenchNumber);
      });
    }

    // [Rest of your JavaScript functions remain the same]
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', init);
    } else {
      init();
    }
  })();
</script>

---

J'avais du mal à prononcer les chiffres français. C'est pourquoi j'ai construit ce petit convertisseur de nombres qui permet de convertir des nombres en chiffres français. Amusez-vous bien avec :)

---

I had difficulties with the pronunciation of French numbers. That's why I made this little number converter to convert numbers into French numbers. Have fun with it :)