---
title: Französischer Zahlenkonverter
date: 2025-02-17 09:45:00 +0100
categories: [blog, programmieren]
tags: [random-projects, mini-scripts, französisch, schule, educational]     # TAG names should always be lowercase
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
    .tooltip {
      position: relative;
      display: inline-block;
      cursor: help;
    }
    .tooltip-text {
      visibility: hidden;
      position: absolute;
      z-index: 1;
      bottom: 125%;
      left: 50%;
      transform: translateX(-50%);
      width: 300px;
      background-color: #333;
      color: #fff;
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
    .unit { color: #4CAF50; }         /* Green for basic numbers */
    .tens { color: #2196F3; }           /* Blue for tens */
    .hundred { color: #F44336; }        /* Red for hundreds */
    .thousand { color: #9C27B0; }       /* Purple for thousands */
    .connector { color: #FF9800; }      /* Orange for connectors (et, -) */
    .legend {
      margin-top: 20px;
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      font-size: 14px;
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
    @media (max-height: 600px) {
      .converter-container {
        margin: 10px auto;
        padding: 10px;
      }
      .tooltip-text {
        width: 200px;
        font-size: 12px;
      }
    }
  </style>
</head>
<body>
  <div class="converter-container">
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

  <script>
    // Expanded dictionary with concise French number rules:
    const numberRules = {
      'un': {
        de: 'Eins - Grundzahl',
        en: 'One - Basic number',
        fr: 'Un - Nombre de base'
      },
      'deux': {
        de: 'Zwei - Grundzahl',
        en: 'Two - Basic number',
        fr: 'Deux - Nombre de base'
      },
      'trois': {
        de: 'Drei - Grundzahl',
        en: 'Three - Basic number',
        fr: 'Trois - Nombre de base'
      },
      'quatre': {
        de: 'Vier - Grundzahl',
        en: 'Four - Basic number',
        fr: 'Quatre - Nombre de base'
      },
      'cinq': {
        de: 'Fünf - Grundzahl',
        en: 'Five - Basic number',
        fr: 'Cinq - Nombre de base'
      },
      'six': {
        de: 'Sechs - Grundzahl',
        en: 'Six - Basic number',
        fr: 'Six - Nombre de base'
      },
      'sept': {
        de: 'Sieben - Grundzahl',
        en: 'Seven - Basic number',
        fr: 'Sept - Nombre de base'
      },
      'huit': {
        de: 'Acht - Grundzahl',
        en: 'Eight - Basic number',
        fr: 'Huit - Nombre de base'
      },
      'neuf': {
        de: 'Neun - Grundzahl',
        en: 'Nine - Basic number',
        fr: 'Neuf - Nombre de base'
      },
      'dix': {
        de: 'Zehn',
        en: 'Ten',
        fr: 'Dix'
      },
      'onze': {
        de: 'Elf',
        en: 'Eleven',
        fr: 'Onze'
      },
      'douze': {
        de: 'Zwölf',
        en: 'Twelve',
        fr: 'Douze'
      },
      'treize': {
        de: 'Dreizehn',
        en: 'Thirteen',
        fr: 'Treize'
      },
      'quatorze': {
        de: 'Vierzehn',
        en: 'Fourteen',
        fr: 'Quatorze'
      },
      'quinze': {
        de: 'Fünfzehn',
        en: 'Fifteen',
        fr: 'Quinze'
      },
      'seize': {
        de: 'Sechzehn',
        en: 'Sixteen',
        fr: 'Seize'
      },
      'vingt': {
        de: 'Zwanzig',
        en: 'Twenty',
        fr: 'Vingt - Base for 20'
      },
      'trente': {
        de: 'Dreißig',
        en: 'Thirty',
        fr: 'Trente - Base for 30'
      },
      'quarante': {
        de: 'Vierzig',
        en: 'Forty',
        fr: 'Quarante - Base for 40'
      },
      'cinquante': {
        de: 'Fünfzig',
        en: 'Fifty',
        fr: 'Cinquante - Base for 50'
      },
      'soixante': {
        de: 'Sechzig',
        en: 'Sixty',
        fr: 'Soixante - Base for 60'
      },
      'soixante-dix': {
        de: 'Siebzig (60+10)',
        en: 'Seventy (60+10)',
        fr: 'Soixante-dix - 60 plus 10'
      },
      'quatre-vingt': {
        de: 'Achtzig (4x20)',
        en: 'Eighty (4x20)',
        fr: 'Quatre-vingt - 4 times 20'
      },
      'quatre-vingts': {
        de: 'Achtzig (mit s, wenn allein)',
        en: 'Eighty (with s when alone)',
        fr: 'Quatre-vingts - utilisé pour 80 exactement'
      },
      'quatre-vingt-dix': {
        de: 'Neunzig (4x20+10)',
        en: 'Ninety (4x20+10)',
        fr: 'Quatre-vingt-dix - 80 plus 10'
      },
      'cent': {
        de: 'Hundert – wird für Zahlen ab 100 verwendet. Bei Rundzahlen (z. B. 200) wird ein "s" angehängt.',
        en: 'Hundred – used for numbers starting at 100. For round numbers (e.g., 200), add an "s".',
        fr: 'Cent – utilisé pour les nombres à partir de 100. Un "s" est ajouté pour les nombres ronds (ex. 200 → deux cents).'
      },
      'mille': {
        de: 'Tausend – wird für Zahlen ab 1000 verwendet. "Mille" nimmt niemals ein "s".',
        en: 'Thousand – used for numbers starting at 1000. "Mille" never takes an "s".',
        fr: 'Mille – utilisé pour les nombres à partir de 1000. "Mille" ne prend jamais de "s".'
      },
      'et': {
        de: 'und – wird nur bei Zahlen, die auf 1 enden (außer bei 81, 91), verwendet.',
        en: 'and – used only for numbers ending in 1 (except 81, 91).',
        fr: 'et – utilisé uniquement pour les nombres se terminant par 1 (sauf 81, 91).'
      }
    };

    function createTooltip(word) {
      if (numberRules[word]) {
        return `
          <span class="tooltip">
            ${word}
            <span class="tooltip-text">
              🇩🇪 ${numberRules[word].de}<br>
              🇬🇧 ${numberRules[word].en}<br>
              🇫🇷 ${numberRules[word].fr}
            </span>
          </span>
        `;
      }
      return word;
    }

    // This function now checks for hyphenated sub-parts as well.
    function colorizeAndAddTooltips(number) {
      let parts = number.split(' ');
      return parts.map(part => {
        if (part.includes('-')) {
          return part.split('-').map(p => {
            let cssClass = 'unit';
            if (p.includes('mille')) cssClass = 'thousand';
            else if (p.includes('cent')) cssClass = 'hundred';
            else if (p.includes('vingt') || p.includes('trente') || p.includes('quarante') ||
                     p.includes('cinquante') || p.includes('soixante')) cssClass = 'tens';
            else if (p === 'et') cssClass = 'connector';
            return `<span class="number-part ${cssClass}">${createTooltip(p)}</span>`;
          }).join('-');
        } else {
          let cssClass = 'unit';
          if (part.includes('mille')) cssClass = 'thousand';
          else if (part.includes('cent')) cssClass = 'hundred';
          else if (part.includes('vingt') || part.includes('trente') || part.includes('quarante') ||
                   part.includes('cinquante') || part.includes('soixante')) cssClass = 'tens';
          else if (part === 'et') cssClass = 'connector';
          return `<span class="number-part ${cssClass}">${createTooltip(part)}</span>`;
        }
      }).join(' ');
    }

    function convertToFrench(n) {
      if (n === 0) return "zéro";
      if (n < 0) return `moins ${convertToFrench(-n)}`;

      const units = ["", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix", 
                     "onze", "douze", "treize", "quatorze", "quinze", "seize"];
      const tens = ["", "dix", "vingt", "trente", "quarante", "cinquante", "soixante"];

      if (n < 17) return units[n];
      if (n < 20) return `dix-${units[n-10]}`;

      if (n < 100) {
        const ten = Math.floor(n / 10);
        const unit = n % 10;

        if (ten === 7) {
          // 70-79: "soixante" + 10-19
          if (unit === 1) return "soixante et onze";
          return `soixante-${convertToFrench(10 + unit)}`;
        }
        if (ten === 8) {
          // 80 is "quatre-vingts" when round, otherwise no "s" and no "et"
          if (unit === 0) return "quatre-vingts";
          return `quatre-vingt-${units[unit]}`;
        }
        if (ten === 9) {
          // 90-99: "quatre-vingt" + 10-19
          return `quatre-vingt-${convertToFrench(10 + unit)}`;
        }
        if (unit === 0) return tens[ten];
        if (unit === 1) return `${tens[ten]} et ${units[unit]}`;
        return `${tens[ten]}-${units[unit]}`;
      }

      if (n < 1000) {
        const hundreds = Math.floor(n / 100);
        const remainder = n % 100;
        let hundredStr = (hundreds === 1 ? "cent" : `${units[hundreds]} cent`);
        // Add an "s" for round hundreds greater than 100
        if (remainder === 0 && hundreds > 1) hundredStr += "s";
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
  </script>
</body>
</html>
</div>

---

J'avais du mal à prononcer les chiffres français. C'est pourquoi j'ai construit ce petit convertisseur de nombres qui permet de convertir des nombres en chiffres français. Amusez-vous bien avec :)

---

I had difficulties with the pronunciation of French numbers. That's why I made this little number converter to convert numbers into French numbers. Have fun with it :)