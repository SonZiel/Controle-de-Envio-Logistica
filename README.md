Português - BR

# 🚚 Controle de Envios por Transportadora

## 📌 Sobre o Projeto

O **Controle de Envios por Transportadora** é um dashboard logístico desenvolvido para monitorar, analisar e otimizar o processo de expedição de mercadorias.

A aplicação permite visualizar informações estratégicas como volumes enviados, valores faturados, desempenho por transportadora, margens de lucro e status de entrega, tudo em uma interface interativa e dinâmica.

Este projeto foi desenvolvido com foco em **análise operacional e tomada de decisão**, sendo altamente aplicável em ambientes corporativos que utilizam ERP (como Sankhya).

---
<img width="1907" height="823" alt="image" src="https://github.com/user-attachments/assets/22d224ac-f70e-4177-9fee-a37f416701c7" />
<img width="269" height="642" alt="image" src="https://github.com/user-attachments/assets/b45e2c4d-82e1-47a4-9f8e-35edfcd7713e" />
<img width="280" height="648" alt="image" src="https://github.com/user-attachments/assets/57d75861-a0f4-4281-b3d2-dffa0392f2bd" />
<img width="789" height="458" alt="image" src="https://github.com/user-attachments/assets/4d1608ea-e565-44ba-99ad-9f55b4f2199e" />
<img width="1559" height="252" alt="image" src="https://github.com/user-attachments/assets/0fc7133e-c8e0-4024-b3c9-dd6a9c0d5cc0" />
<img width="1899" height="886" alt="image" src="https://github.com/user-attachments/assets/6279d897-2a03-4520-ba95-a646de9fb5c8" />
<img width="1571" height="727" alt="image" src="https://github.com/user-attachments/assets/15800921-c548-4ac7-87de-bee7b2e8d49a" />

## 🎯 Objetivo

O objetivo principal é fornecer uma visão clara e centralizada dos envios logísticos, permitindo:

* Identificar gargalos no processo de entrega
* Analisar desempenho das transportadoras
* Acompanhar lucro e margem por nota fiscal
* Melhorar a eficiência operacional
* Reduzir custos logísticos

---

## 🖥️ Interface do Sistema

O sistema é dividido em 4 grandes áreas:

### 📊 1. Cards de Indicadores (KPIs)

Exibe métricas principais do período selecionado:

* 📄 **Total de NFs**
* 💰 **Valor total faturado**
* 📦 **Total de volumes expedidos**
* 🚛 **Quantidade de transportadoras utilizadas**

Esses indicadores são atualizados dinamicamente conforme os filtros aplicados.

---

### 📈 2. Gráficos Analíticos

#### 📦 Volumes por Transportadora

* Gráfico de barras
* Mostra a quantidade de volumes enviados por transportadora
* Ajuda a identificar concentração logística

#### 💰 Valor por Transportadora

* Gráfico de rosca (doughnut)
* Representa o faturamento por transportadora
* Facilita análise de representatividade financeira

#### 📅 Envios por Dia

* Gráfico de linha
* Mostra a quantidade de NFs expedidas por dia
* Permite identificar picos e quedas operacionais

---

### 🔎 3. Filtros Dinâmicos

Permite uma análise altamente personalizada:

* 📅 Período (Data inicial e final)
* 🚛 Transportadora (com autocomplete inteligente)
* 📦 Tipo de frete:

  * CIF
  * FOB
  * Terceiros
  * Sem frete
* 🏢 Empresa
* ⏳ Apenas pendentes de entrega

Os filtros impactam **toda a aplicação em tempo real**.

---

### 📋 4. Tabela de Notas Fiscais

A parte mais rica do sistema, contendo:

#### 📌 Informações principais:

* Número da NF
* Número único (NUNOTA)
* Data da negociação
* Cliente
* Transportadora
* Data prevista de entrega
* Status (Entregue / Pendente)
* Vendedor

#### 📊 Dados logísticos:

* Quantidade de volumes
* Valor da nota
* Valor do frete
* Tipo de frete (CIF/FOB/etc)

#### 💸 Dados financeiros (diferencial do projeto):

* **Lucro Bruto**
* **Margem (%)**
* **Lucro após despesas (frete)**

#### 🎯 Funcionalidades:

* 🔍 Busca rápida (cliente, NF, transportadora…)
* ↕️ Ordenação por coluna
* 📄 Paginação
* 🖥️ Modo fullscreen da tabela
* 🖱️ Clique para selecionar linha
* 🔗 Integração com Sankhya (abre a nota diretamente)

---

### 📊 Abas adicionais

#### ⚙️ Produtividade

* Separação
* Conferência
* Ordem de carga

#### 📝 Observações

* Observações de frete
* Observações internas

---

### 📤 Exportação

* Exportação completa em **CSV (Excel)**
* Inclui:

  * Dados logísticos
  * Dados financeiros
  * Margens
  * Lucro

---

## 🧠 Regra de Negócio (Destaque)

O sistema calcula margem e lucro diretamente no SQL:

* Faturamento
* CMV (Custo da mercadoria vendida)
* Gastos variáveis
* Custos fixos
* Frete (impactando lucro real)

```sql
LUCRO = FATURAMENTO - CMV - GASTOS - CUSTOS
```

```sql
MARGEM (%) = LUCRO / FATURAMENTO
```

Além disso:

* Considera custo histórico por produto
* Aplica custo variável via função
* Aplica custo fixo percentual por empresa
* Ajusta lucro considerando frete (quando aplicável)

---

## ⚙️ Tecnologias Utilizadas

### 🖥️ Frontend

* HTML5
* CSS3 (layout moderno e responsivo)
* JavaScript puro (Vanilla JS)

### 📊 Gráficos

* Chart.js

### 🔙 Backend / Integração

* JSP (Java Server Pages)
* JSTL
* Integração com ERP Sankhya

### 🗄️ Banco de Dados

* Oracle SQL

---

## 🧩 Estrutura Técnica

* Query complexa com `WITH (CTE)` para cálculo de margem 
* Uso de subqueries para custo histórico
* Bind de parâmetros para filtros dinâmicos
* Processamento dos dados em JavaScript
* Renderização dinâmica de gráficos e tabela

---

## 🚀 Impacto no Negócio

Esse sistema traz ganhos reais como:

### 📈 Operacionais

* Visão clara da expedição
* Identificação de atrasos
* Monitoramento de produtividade

### 💰 Financeiros

* Controle de margem por nota
* Análise de rentabilidade por transportadora
* Identificação de prejuízos ocultos (frete)

### 🧠 Estratégicos

* Melhor escolha de transportadoras
* Otimização de custos logísticos
* Tomada de decisão baseada em dados

---

## 🔥 Diferenciais do Projeto

* Cálculo de margem direto no SQL (nível avançado)
* Dashboard completo (KPIs + gráficos + tabela)
* Filtros dinâmicos e inteligentes
* Integração com ERP real
* Interface moderna e intuitiva
* Exportação de dados pronta para análise

---

## 📌 Possíveis Melhorias Futuras

* Integração com API REST
* Dashboard em tempo real
* Controle de SLA de entrega
* Ranking automático de transportadoras
* Alertas de prejuízo por nota
* Versão mobile

---

## 👨‍💻 Autor

Desenvolvido por **Jesiel Alves 🚀**
Profissional de TI focado em evolução na área de desenvolvimento e soluções corporativas.

---

## ⭐ Considerações

Este projeto representa um avanço importante na construção de soluções completas, unindo:

* Frontend interativo
* Backend integrado
* Regras de negócio complexas
* Análise de dados

Sendo um forte exemplo de aplicação prática no ambiente empresarial.

---

English

# 🚚 Shipping Control by Carrier

## 📌 About the Project

**Shipping Control by Carrier** is a logistics dashboard designed to monitor, analyze, and optimize the shipment process.

The application provides strategic insights such as shipped volumes, total revenue, carrier performance, profit margins, and delivery status — all within a dynamic and interactive interface.

This project was built with a strong focus on **operational analysis and decision-making**, making it highly suitable for corporate environments using ERP systems (such as Sankhya).

<img width="1907" height="823" alt="image" src="https://github.com/user-attachments/assets/22d224ac-f70e-4177-9fee-a37f416701c7" />
<img width="269" height="642" alt="image" src="https://github.com/user-attachments/assets/b45e2c4d-82e1-47a4-9f8e-35edfcd7713e" />
<img width="280" height="648" alt="image" src="https://github.com/user-attachments/assets/57d75861-a0f4-4281-b3d2-dffa0392f2bd" />
<img width="789" height="458" alt="image" src="https://github.com/user-attachments/assets/4d1608ea-e565-44ba-99ad-9f55b4f2199e" />
<img width="1559" height="252" alt="image" src="https://github.com/user-attachments/assets/0fc7133e-c8e0-4024-b3c9-dd6a9c0d5cc0" />
<img width="1899" height="886" alt="image" src="https://github.com/user-attachments/assets/6279d897-2a03-4520-ba95-a646de9fb5c8" />
<img width="1571" height="727" alt="image" src="https://github.com/user-attachments/assets/15800921-c548-4ac7-87de-bee7b2e8d49a" />
---

## 🎯 Purpose

The main goal is to provide a centralized and clear view of logistics operations, enabling:

* Identification of delivery bottlenecks
* Carrier performance analysis
* Profit and margin tracking per invoice
* Operational efficiency improvements
* Reduction of logistics costs

---

## 🖥️ System Interface

The system is divided into 4 main areas:

---

### 📊 1. KPI Cards

Displays key metrics for the selected period:

* 📄 **Total Invoices**
* 💰 **Total Revenue**
* 📦 **Total Shipped Volumes**
* 🚛 **Active Carriers**

These indicators update dynamically based on applied filters.

---

### 📈 2. Analytical Charts

#### 📦 Volumes by Carrier

* Bar chart
* Displays shipment volume per carrier
* Helps identify logistics concentration

#### 💰 Revenue by Carrier

* Doughnut chart
* Shows revenue distribution by carrier
* Supports financial analysis

#### 📅 Shipments per Day

* Line chart
* Displays number of shipments per day
* Helps identify operational peaks and drops

---

### 🔎 3. Dynamic Filters

Allows highly customizable data analysis:

* 📅 Date range (start and end)
* 🚛 Carrier (with smart autocomplete)
* 📦 Freight type:

  * CIF
  * FOB
  * Third-party
  * No freight
* 🏢 Company
* ⏳ Pending deliveries only

All filters affect the entire dashboard in real time.

---

### 📋 4. Invoice Table

The most detailed part of the system:

#### 📌 Main Information:

* Invoice number
* Unique ID (NUNOTA)
* Transaction date
* Customer
* Carrier
* Expected delivery date
* Delivery status (Delivered / Pending)
* Salesperson

#### 📊 Logistics Data:

* Volume quantity
* Invoice value
* Freight value
* Freight type

#### 💸 Financial Data (Key Feature):

* **Gross Profit**
* **Margin (%)**
* **Net Profit (after freight costs)**

#### 🎯 Features:

* 🔍 Smart search (invoice, customer, carrier…)
* ↕️ Column sorting
* 📄 Pagination
* 🖥️ Fullscreen table mode
* 🖱️ Row selection
* 🔗 ERP integration (opens invoice directly in Sankhya)

---

### 📊 Additional Tabs

#### ⚙️ Productivity

* Picking process
* Checking process
* Load order

#### 📝 Notes

* Freight notes
* Internal notes

---

### 📤 Export

* Full export to **CSV (Excel)**
* Includes:

  * Logistics data
  * Financial data
  * Margins
  * Profit

---

## 🧠 Business Logic (Highlight)

The system calculates profit and margin directly in SQL:

* Revenue
* COGS (Cost of Goods Sold)
* Variable costs
* Fixed costs
* Freight (affecting real profit)

```sql
PROFIT = REVENUE - COGS - COSTS
```

```sql
MARGIN (%) = PROFIT / REVENUE
```

Additional rules:

* Uses historical product cost
* Applies variable costs via database function
* Applies fixed cost percentage per company
* Adjusts profit considering freight when applicable

---

## ⚙️ Technologies Used

### 🖥️ Frontend

* HTML5
* CSS3 (modern and responsive layout)
* Vanilla JavaScript

### 📊 Charts

* Chart.js

### 🔙 Backend / Integration

* JSP (Java Server Pages)
* JSTL
* Sankhya ERP integration

### 🗄️ Database

* Oracle SQL

---

## 🧩 Technical Structure

* Complex query using `WITH (CTE)` for margin calculation
* Subqueries for historical cost
* Parameter binding for dynamic filters
* Data processing in JavaScript
* Dynamic rendering of charts and tables

---

## 🚀 Business Impact

This system delivers real benefits such as:

### 📈 Operational

* Clear visibility of shipping operations
* Identification of delays
* Productivity monitoring

### 💰 Financial

* Margin control per invoice
* Carrier profitability analysis
* Detection of hidden losses (freight costs)

### 🧠 Strategic

* Better carrier selection
* Logistics cost optimization
* Data-driven decision-making

---

## 🔥 Key Features

* Advanced SQL-based margin calculation
* Complete dashboard (KPIs + charts + table)
* Smart and dynamic filtering
* Real ERP integration
* Modern and intuitive UI
* Ready-to-use data export

---

## 📌 Future Improvements

* REST API integration
* Real-time dashboard updates
* Delivery SLA tracking
* Automatic carrier ranking
* Loss alerts per invoice
* Mobile version

---

## 👨‍💻 Author

Developed by **Jesiel Alves 🚀**
IT professional focused on growth in software development and enterprise solutions.

---

## ⭐ Final Notes

This project represents a significant step toward building complete solutions by combining:

* Interactive frontend
* Integrated backend
* Complex business rules
* Data analysis

It stands as a strong example of a real-world enterprise application.

---


