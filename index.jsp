<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="pt-BR">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Relatorio Logistico - Envios por Transportadora</title>
<snk:load/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js"></script>
<style>
  :root {
    --bg: #f4f3f0; --surface: #ffffff; --surface2: #f9f8f5;
    --border: rgba(0,0,0,0.10); --border2: rgba(0,0,0,0.18);
    --text: #1a1a18; --text2: #5f5e5a; --text3: #888780;
    --teal: #1D9E75; --teal-light: #E1F5EE; --teal-dark: #0F6E56;
    --amber: #BA7517; --amber-light: #FAEEDA;
    --red: #A32D2D; --red-light: #FCEBEB;
    --blue: #185FA5; --blue-light: #E6F1FB;
    --radius: 10px; --radius-sm: 6px;
  }
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Segoe UI', system-ui, sans-serif; background: var(--bg); color: var(--text); font-size: 14px; line-height: 1.5; }
  header { background: var(--surface); border-bottom: 1px solid var(--border2); padding: 14px 24px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; }
  .logo { display: flex; align-items: center; gap: 10px; }
  .logo-box { width: 32px; height: 32px; background: var(--teal); border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center; font-size: 16px; }
  .logo-text { font-size: 15px; font-weight: 600; letter-spacing: -0.3px; }
  .logo-sub { font-size: 12px; color: var(--text2); }
  .layout { display: grid; grid-template-columns: 260px 1fr; min-height: calc(100vh - 57px); }
  aside { background: var(--surface); border-right: 1px solid var(--border); padding: 20px 16px; display: flex; flex-direction: column; gap: 20px; }
  .filter-title { font-size: 11px; font-weight: 600; color: var(--text3); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 6px; }
  .filter-group { display: flex; flex-direction: column; gap: 8px; }
  label { font-size: 12px; color: var(--text2); display: block; margin-bottom: 3px; }
  input[type=text], input[type=date], select {
    width: 100%; padding: 7px 10px; border: 1px solid var(--border2);
    border-radius: var(--radius-sm); background: var(--surface2);
    color: var(--text); font-size: 13px; outline: none;
  }
  input:focus, select:focus { border-color: var(--teal); }
  input.disabled { background: #ececec; color: #999; }
  .btn { padding: 8px 16px; border-radius: var(--radius-sm); font-size: 13px; font-weight: 500; cursor: pointer; border: none; width: 100%; transition: opacity 0.15s; }
  .btn-primary { background: var(--teal); color: #fff; }
  .btn-ghost { background: transparent; color: var(--text2); border: 1px solid var(--border2); margin-top: 4px; }
  .btn-ghost:hover { background: var(--surface2); }
  main { padding: 20px 24px; display: flex; flex-direction: column; gap: 20px; overflow: auto; }
  .metrics { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; }
  .metric-card { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 14px 16px; }
  .metric-label { font-size: 11px; color: var(--text3); text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 6px; }
  .metric-value { font-size: 22px; font-weight: 600; letter-spacing: -0.5px; }
  .metric-sub { font-size: 11px; color: var(--text2); margin-top: 3px; }
  .charts { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
  .chart-card { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 16px 18px; }
  .chart-card.full { grid-column: 1 / -1; }
  .card-title { font-size: 13px; font-weight: 600; margin-bottom: 14px; }
  .table-card { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; }
  .table-header { padding: 14px 18px; border-bottom: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; }
  .search-wrap { position: relative; }
  .search-wrap input { padding: 6px 10px 6px 28px; width: 260px; font-size: 12px; }
  .search-icon { position: absolute; left: 8px; top: 50%; transform: translateY(-50%); color: var(--text3); font-size: 13px; pointer-events: none; }
  .table-wrap { overflow-x: auto; }
  table { width: 100%; border-collapse: collapse; font-size: 12px; }
  thead th { padding: 9px 12px; text-align: left; font-size: 10px; font-weight: 600; color: var(--text3); text-transform: uppercase; letter-spacing: 0.5px; background: var(--surface2); border-bottom: 1px solid var(--border); white-space: nowrap; cursor: pointer; user-select: none; }
  thead th:hover { color: var(--text); }
  tbody tr { border-bottom: 1px solid var(--border); cursor: pointer; }
  tbody tr:hover { background: var(--surface2); }
  tbody tr:last-child { border-bottom: none; }
  tbody td { padding: 9px 12px; white-space: nowrap; }
  .badge { display: inline-block; padding: 2px 8px; border-radius: 20px; font-size: 10px; font-weight: 600; }
  .b-cif  { background: var(--teal-light);  color: var(--teal-dark); }
  .b-fob  { background: var(--amber-light); color: var(--amber); }
  .b-terc { background: var(--blue-light);  color: var(--blue); }
  .b-sem  { background: var(--surface2);    color: var(--text3); border: 1px solid var(--border2); }
  .val-pos { color: var(--teal-dark); font-weight: 600; }
  .val-neg { color: var(--red); font-weight: 600; }
  .tabs { display: flex; border-bottom: 1px solid var(--border); }
  .tab { padding: 10px 18px; font-size: 13px; cursor: pointer; color: var(--text2); border-bottom: 2px solid transparent; margin-bottom: -1px; }
  .tab.act { color: var(--teal-dark); border-bottom-color: var(--teal); font-weight: 500; }
  .tc { display: none; }
  .tc.act { display: block; }
  .pagination { padding: 12px 18px; border-top: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; font-size: 12px; color: var(--text2); }
  .pag-btns { display: flex; gap: 4px; }
  .pb { padding: 4px 10px; border: 1px solid var(--border2); background: var(--surface); border-radius: var(--radius-sm); cursor: pointer; font-size: 12px; }
  .pb.act { background: var(--teal); color: #fff; border-color: var(--teal); }
  .no-data, .loading { text-align: center; padding: 36px; color: var(--text3); font-style: italic; }
  .layout.fullscreen aside { display: none; }
  .layout.fullscreen main { grid-column: 1 / -1; width: 100%; }
  .table-card.fullscreen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: 999;
    margin: 0;
    border-radius: 0;
    box-shadow: 0 0 0 9999px rgba(0,0,0,0.4);
    display: flex;
    flex-direction: column;
    background: var(--surface);
  }
  .table-card.fullscreen .table-wrap { flex: 1; overflow: auto; }
  .table-card.fullscreen .table-header,
  .table-card.fullscreen .pagination { z-index: 1000; }
  .table-card.fullscreen .table-card { border-radius: 0; }
  /* Autocomplete */
  .ac-wrap { position: relative; }
  .ac-list { position: absolute; top: 100%; left: 0; right: 0; background: var(--surface); border: 1px solid var(--border2); border-radius: 0 0 var(--radius-sm) var(--radius-sm); max-height: 220px; overflow-y: auto; z-index: 999; box-shadow: 0 4px 12px rgba(0,0,0,0.12); }
  .ac-item { padding: 8px 10px; cursor: pointer; font-size: 12px; border-bottom: 1px solid var(--border); display: flex; gap: 8px; }
  .ac-item:hover { background: var(--teal-light); }
  .ac-cod { font-weight: 600; color: var(--teal-dark); min-width: 36px; }
  .ac-nome { color: var(--text2); }
  .ac-selected { background: var(--teal-light); border: 1px solid var(--teal); border-radius: var(--radius-sm); padding: 6px 10px; font-size: 12px; color: var(--teal-dark); font-weight: 500; display: flex; align-items: center; justify-content: space-between; margin-top: 4px; }
  .ac-selected button { background: none; border: none; cursor: pointer; color: var(--teal-dark); font-size: 14px; padding: 0; }
  tbody tr.row-selected { background: var(--teal-light) !important; }
  tbody tr.row-selected td { color: var(--teal-dark); font-weight: 500; }
  tbody tr.row-selected { background: var(--teal-light) !important; }
  tbody tr.row-selected td { color: var(--teal-dark); font-weight: 500; }
</style>
</head>
<body>

<header>
  <div class="logo">
    <div class="logo-box">&#x1F69A;</div>
    <div>
      <div class="logo-text">Controle de Envios</div>
      <div class="logo-sub">Logistica &middot; Transportadoras</div>
    </div>
  </div>
  <span style="font-size:12px;color:var(--text3);" id="upd"></span>
</header>

<div class="layout">
  <aside>
    <div>
      <div class="filter-title">Periodo</div>
      <div class="filter-group">
        <div><label>Data inicial</label><input type="date" id="fini"></div>
        <div><label>Data final</label><input type="date" id="ffin"></div>
      </div>
    </div>
    <div>
      <div class="filter-title">Filtros</div>
      <div class="filter-group">
        <div>
          <label>Transportadora</label>
          <div class="ac-wrap">
            <input type="text" id="ftr_nome" placeholder="Digite nome ou codigo..." autocomplete="off" oninput="buscarTransp(this.value)">
            <input type="hidden" id="ftr" value="0">
            <div id="acList" class="ac-list" style="display:none;"></div>
          </div>
          <div id="acSelecionado" style="display:none;"></div>
        </div>
        <div>
          <label>CIF/FOB</label>
          <select id="ffr">
            <option value="">Todos</option>
            <option value="C">CIF</option>
            <option value="F">FOB</option>
            <option value="T">Terceiros</option>
            <option value="S">Sem Frete</option>
          </select>
        </div>
        <div>
          <label>Empresa</label>
          <select id="femp">
            <option value="0">Todas</option>
            <option value="1">Empresa 1</option>
            <option value="2">Empresa 2</option>
            <option value="3">Empresa 3</option>
          </select>
        </div>
        <div>
          <label style="display:flex;align-items:center;gap:8px;cursor:pointer;">
            <input type="checkbox" id="fpendentes" onchange="togglePendentes()"> Pendentes Entrega
          </label>
        </div>
      </div>
    </div>
    <button class="btn btn-primary" onclick="aplicar()">&#x1F50D; Aplicar Filtros</button>
    <button class="btn btn-ghost" onclick="limpar()">Limpar Filtros</button>
    <div style="margin-top:auto;padding-top:16px;border-top:1px solid var(--border);">
      <div class="filter-title">Exportar</div>
      <button class="btn btn-ghost" style="margin-top:6px;" onclick="exportCSV()">&#x2B07; Exportar CSV</button>
    </div>
  </aside>

  <main>
    <div class="metrics">
      <div class="metric-card"><div class="metric-label">Total de NFs</div><div class="metric-value" id="mnf">-</div><div class="metric-sub">no periodo</div></div>
      <div class="metric-card"><div class="metric-label">Valor Total NFs</div><div class="metric-value" id="mvlr">-</div><div class="metric-sub">soma do periodo</div></div>
      <div class="metric-card"><div class="metric-label">Total de Volumes</div><div class="metric-value" id="mvol">-</div><div class="metric-sub">volumes expedidos</div></div>
      <div class="metric-card"><div class="metric-label">Transportadoras</div><div class="metric-value" id="mtr">-</div><div class="metric-sub">ativas no periodo</div></div>
    </div>

    <div class="charts">
      <div class="chart-card"><div class="card-title">Volumes por Transportadora</div><div style="position:relative;height:240px;"><canvas id="cVol"></canvas></div></div>
      <div class="chart-card"><div class="card-title">Valor (R$) por Transportadora</div><div style="position:relative;height:240px;"><canvas id="cVlr"></canvas></div></div>
      <div class="chart-card full"><div class="card-title">Envios por Dia</div><div style="position:relative;height:180px;"><canvas id="cLine"></canvas></div></div>
    </div>

    <div class="table-card">
      <div class="table-header">
        <div style="display:flex;align-items:center;gap:12px;">
          <span style="font-size:13px;font-weight:600;">Notas Fiscais</span>
          <span id="tcnt" style="font-size:11px;color:var(--text3);"></span>
        </div>
        <div style="display:flex;align-items:center;gap:8px;">
          <div class="search-wrap">
            <span class="search-icon">&#x1F50D;</span>
            <input type="text" id="tsrch" placeholder="Buscar NF, Nro unico, cliente, transportadora..." oninput="renderTabela()">
          </div>
          <button class="pb" id="btnFullscreen" style="padding:6px 10px;" onclick="toggleTableFullscreen()">&#x26F6;</button>
        </div>
      </div>

      <div class="tabs">
        <div class="tab act" onclick="swtab(this,'t1')">Principal</div>
        <div class="tab"     onclick="swtab(this,'t2')">Produtividade</div>
        <div class="tab"     onclick="swtab(this,'t3')">Observacoes</div>
      </div>

      <div class="table-wrap">
        <div id="t1" class="tc act">
          <table>
            <thead><tr>
              <th onclick="srt('numnota')">N NF</th>
              <th onclick="srt('nunota')" >N Unico</th> 
              <th onclick="srt('dtneg')">Data</th>
              <th onclick="srt('cli')">Cliente</th>
              <th onclick="srt('trp')">Transportadora</th>
              <th onclick="srt('dtprev')">Data Prevista</th>
              <th onclick="srt('entrg')">Entrega</th>
              <th onclick="srt('ven')">Vendedor</th>
              <th onclick="srt('vol')" style="text-align:right">Volumes</th>
              <th onclick="srt('vlr')" style="text-align:right">Valor NF</th>
              <th onclick="srt('frt')" style="text-align:right">Vlr Frete</th>
              <th onclick="srt('tf')">CIF/FOB</th>
              <th onclick="srt('tfrt')">Tipo Frete</th>
              <th onclick="srt('emp')">Empresa</th>
              <th onclick="srt('lucro')" style="text-align:right">Lucro Bruto</th>
              <th onclick="srt('margem')" style="text-align:right">Margem %</th>
              <th onclick="srt('lucro_despesa')" style="text-align:right">Lucro Despesa</th>
            </tr></thead>
            <tbody id="b1"><tr><td colspan="13" class="loading">Aplique os filtros para carregar os dados.</td></tr></tbody>
          </table>
        </div>
        <div id="t2" class="tc">
          <table>
            <thead><tr>
              <th>N NF</th><th>Cliente</th><th>Separador</th>
              <th>Inicio Sep.</th><th>Fim Sep.</th>
              <th>Conferente</th><th>Inicio Conf.</th><th>Fim Conf.</th><th>Ord.Carga</th>
            </tr></thead>
            <tbody id="b2"></tbody>
          </table>
        </div>
        <div id="t3" class="tc">
          <table>
            <thead><tr>
              <th>N NF</th><th>Cliente</th><th>Transportadora</th>
              <th>Obs. Frete</th><th>Obs. Interna</th>
            </tr></thead>
            <tbody id="b3"></tbody>
          </table>
        </div>
      </div>

      <div class="pagination">
        <span id="pinfo"></span>
        <div class="pag-btns" id="pbts"></div>
      </div>
    </div>
  </main>
</div>

<script>

var ALL = [], FIL = [];
var sortC = 'dtneg', sortD = -1;
var pg = 1, PP = 15;
var chartVol = null, chartVlr = null, chartLine = null;
var acTimer = null;
var selectedRow = null;
var selectedRow = null;

// ===== DATAS PADRAO =====
(function(){
    var hoje = new Date();
    var prim = new Date(hoje.getFullYear(), hoje.getMonth(), 1);
    function fmt(d){ return d.toISOString().split('T')[0]; }
    document.getElementById('fini').value = fmt(prim);
    document.getElementById('ffin').value = fmt(hoje);
    var pIni = "${P_DATAINI}", pFim = "${P_DATAFIM}";
    if(pIni && pIni.indexOf('$') < 0) document.getElementById('fini').value = pIni;
    if(pFim && pFim.indexOf('$') < 0) document.getElementById('ffin').value = pFim;
})();

// ===== AUTOCOMPLETE =====
function buscarTransp(termo){
    clearTimeout(acTimer);
    var list = document.getElementById('acList');
    if(!termo || termo.length < 2){ list.style.display='none'; list.innerHTML=''; return; }
    acTimer = setTimeout(function(){
        var like = '%' + termo.toUpperCase() + '%';
        var q = "SELECT CODPARC, NOMEPARC FROM TGFPAR " +
                "WHERE (UPPER(NOMEPARC) LIKE ? OR TO_CHAR(CODPARC) LIKE ?) " +
                "AND ATIVO = 'S' AND ROWNUM <= 15 ORDER BY NOMEPARC";
        var params = [{value:like,type:"S"},{value:like,type:"S"}];
        executeQuery(q, params, function(res){
            var dados = JSON.parse(res);
            if(!dados || dados.length===0){
                list.innerHTML='<div class="ac-item"><span class="ac-nome">Nenhuma encontrada</span></div>';
                list.style.display='block'; return;
            }
            list.innerHTML = dados.map(function(p){
                var nome = (p.NOMEPARC||'').replace(/"/g,'&quot;');
                return '<div class="ac-item" onclick="selecionarTransp('+p.CODPARC+',\''+nome.replace(/'/g,"\\'")+'\')">'+
                       '<span class="ac-cod">'+p.CODPARC+'</span>'+
                       '<span class="ac-nome">'+p.NOMEPARC+'</span></div>';
            }).join('');
            list.style.display='block';
        }, function(err){
            list.innerHTML='<div class="ac-item"><span class="ac-nome">Erro: '+err+'</span></div>';
            list.style.display='block';
        });
    }, 300);
}

function selecionarTransp(cod, nome){
    document.getElementById('ftr').value = cod;
    document.getElementById('ftr_nome').value = '';
    document.getElementById('acList').style.display='none';
    document.getElementById('acList').innerHTML='';
    var sel = document.getElementById('acSelecionado');
    sel.style.display='block';
    sel.innerHTML='<div class="ac-selected"><span>'+cod+' - '+nome+'</span>'+
                  '<button onclick="limparTransp()">x</button></div>';
}

function limparTransp(){
    document.getElementById('ftr').value='0';
    document.getElementById('ftr_nome').value='';
    document.getElementById('acSelecionado').style.display='none';
    document.getElementById('acSelecionado').innerHTML='';
}

document.addEventListener('click', function(e){
    if(!e.target.closest('.ac-wrap')){
        var list = document.getElementById('acList');
        if(list) list.style.display='none';
    }
});

// ===== FORMATOS =====
function brl(v){
    return 'R$ '+(v||0).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
}
function fmtDate(d){
    if(!d) return '';
    var dt = (d instanceof Date)?d:new Date(d);
    return dt.toLocaleDateString('pt-BR');
}
function badgeFrete(tf){
    var mapa={'CIF':'b-cif','FOB':'b-fob','Terceiros':'b-terc','Sem Frete':'b-sem'};
    return '<span class="badge '+(mapa[tf]||'b-sem')+'">'+(tf||'-')+'</span>';
}
function margCls(v){ return v >= 0 ? 'val-pos' : 'val-neg'; }

// ===== APLICAR FILTROS =====
function aplicar(){
    var pendentes = document.getElementById('fpendentes').checked;
    var dataIni = document.getElementById('fini').value;
    var dataFim = document.getElementById('ffin').value;
    if(!dataIni || !dataFim){ alert("Informe as datas de inicio e fim."); return; }

    var codTransp = parseInt(document.getElementById('ftr').value) || 0;
    var cifFob = document.getElementById('ffr').value || " ";
    var empresa   = parseInt(document.getElementById('femp').value) || 0;

    document.getElementById('upd').textContent = "Carregando...";
    document.getElementById('b1').innerHTML = '<tr><td colspan="13" class="loading">Buscando dados...</td></tr>';

    // ==============================================================
    // QUERY COM CTE (WITH MARGEM)
    //
    // CONTAGEM DE ? NA QUERY:
    //   WITH MARGEM -> BETWEEN ? AND ?          = posicoes 1, 2
    //   SELECT principal -> BETWEEN ? AND ?     = posicoes 3, 4
    //   AND (CODPARCTRANSP = ? OR ? = 0)        = posicoes 5, 6
    //   AND (CIF_FOB = ? OR ? = ' ')            = posicoes 7, 8
    //   AND (CODEMPNEGOC = ? OR ? = 0)          = posicoes 9, 10
    //   TOTAL = 10 parametros bind
    // ==============================================================
    var query =
    "WITH MARGEM AS ( " +
    "    SELECT " +
    "        ite.nunota, " +

    "        (ite.qtdneg * ite.vlrunit) AS FATURAMENTO, " +

    "        (ite.qtdneg * NVL(( " +
    "            SELECT cus.cussemicm " +
    "            FROM tgfcus cus " +
    "            WHERE cus.codprod = ite.codprod " +
    "              AND cus.codemp  = cab.codemp " +
    "              AND cus.dtatual <= cab.dtneg " +
    "            ORDER BY cus.dtatual DESC " +
    "            FETCH FIRST 1 ROW ONLY " +
    "        ), 0)) AS CMV, " +

    "        NVL(AD_GET_CUSTO_VAR_2(ite.nunota, ite.sequencia), 0) AS GASTOS_VARIAVEIS, " +

    "        (ite.qtdneg * ite.vlrunit * ( " +
    "            SELECT PERCCFOUTROS/100 " +
    "            FROM TGFCGM CGM " +
    "            WHERE CGM.CODEMP = CAB.CODEMP " +
    "        )) AS CUSTO_FIXO " +

    "    FROM tgfcab cab " +
    "    JOIN tgfite ite ON cab.nunota = ite.nunota " +

    "    WHERE cab.dtneg BETWEEN ? AND ? " +
    ") " +

    "SELECT " +
    "    CAB.NUNOTA, " +
    "    CAB.NUMNOTA, " +
    "    CAB.VLRNOTA, " +
    "    CAB.QTDVOL, " +
    "    CAB.DTNEG, " +
    "    CAB.CODVEND, " +
    "    VEN.APELIDO, " +
    "    CAB.VLRFRETE, " +

    "    PAR_CLI.NOMEPARC AS NOME_CLIENTE, " +
    "    PAR_TRP.CODPARC AS COD_TRANSPORTADORA, " +
    "    PAR_TRP.NOMEPARC AS NOME_TRANSPORTADORA, " +

    "   (SELECT TR.DTPREVENTREGA    " +
    "    FROM AD_COTFRETE CT    "+
    "    INNER JOIN AD_TRANSPCOTFRETE TR ON TR.NUREG = CT.NUREG "+
    "    WHERE CT.NUNOTA = COALESCE(    " +
            
    "           (SELECT CT2.NUNOTA  " +
    "            FROM AD_COTFRETE CT2   " +
    "           WHERE CT2.NUNOTA = cab.nunota   " +
    "            AND ROWNUM = 1),   " +
            
    "            (SELECT MIN(VAR.NUNOTAORIG)    " +
    "            FROM TGFVAR VAR    " +
    "            WHERE VAR.NUNOTA = cab.nunota))    " +
    "    AND ROWNUM = 1) AS DATA_PREV, " +

    "    CAB.AD_OBSFRETE, " +

    "   CASE WHEN CAB.AD_ENTREGA2 = 'S' THEN 'Entregue' " + 
    "     WHEN CAB.AD_ENTREGA2 IS NULL THEN 'Pendente'  " +
    "     ELSE ' ' END AS ENTREGA,  " +

    "    CAB.AD_OBSERVACAOINTERNA, " +
    "    EMP.NOMEFANTASIA, " +
    "    CAB.ORDEMCARGA, " +

    "    CASE WHEN CAB.CIF_FOB='C' THEN 'CIF' WHEN CAB.CIF_FOB='F' THEN 'FOB' " +
    "         WHEN CAB.CIF_FOB='T' THEN 'Terceiros' WHEN CAB.CIF_FOB='S' THEN 'Sem Frete' " +
    "         ELSE 'Outros' END AS CIF_FOB, " +

    "    CASE WHEN CAB.TIPFRETE='S' THEN 'Incluso' WHEN CAB.TIPFRETE='N' THEN 'Extra Nota' " +
    "    ELSE 'Outros' END AS TIPFRETE, " +

    "    SUM(MGM.FATURAMENTO) AS FATURAMENTO, " +
    "    SUM(MGM.CMV) AS CMV, " +
    "    SUM(MGM.GASTOS_VARIAVEIS) AS GASTOS_VARIAVEIS, " +
    "    SUM(MGM.CUSTO_FIXO) AS CUSTO_FIXO, " +

    "    (SUM(MGM.FATURAMENTO) - SUM(MGM.CMV) - " +
    "     SUM(MGM.GASTOS_VARIAVEIS) - SUM(MGM.CUSTO_FIXO)) AS LUCRO_BRUTO, " +

    "    ROUND((SUM(MGM.FATURAMENTO) - SUM(MGM.CMV) - " +
    "           SUM(MGM.GASTOS_VARIAVEIS) - SUM(MGM.CUSTO_FIXO)) " +
    "           / NULLIF(SUM(MGM.FATURAMENTO),0) * 100, 2) AS MARGEM_PERCENTUAL, " +

        
    "     CASE  WHEN CAB.TIPFRETE = 'N' THEN " +
    "           (SUM(MGM.FATURAMENTO) - SUM(MGM.CMV) - " +
    "            SUM(MGM.GASTOS_VARIAVEIS) - SUM(MGM.CUSTO_FIXO) - CAB.VLRFRETE) " + 
    "       ELSE (SUM(MGM.FATURAMENTO) - SUM(MGM.CMV) - SUM(MGM.GASTOS_VARIAVEIS) - SUM(MGM.CUSTO_FIXO)) " +
    "     END AS LUCRO_DESPESA " +

    "FROM TGFCAB CAB " +
    "LEFT JOIN TGFPAR PAR_CLI ON PAR_CLI.CODPARC = CAB.CODPARC " +
    "LEFT JOIN TGFPAR PAR_TRP ON PAR_TRP.CODPARC = CAB.CODPARCTRANSP " +
    "INNER JOIN TSIEMP EMP ON EMP.CODEMP = CAB.CODEMPNEGOC " +
    "LEFT JOIN TGFVEN VEN ON VEN.CODVEND = CAB.CODVEND " +
    "LEFT JOIN MARGEM MGM ON MGM.NUNOTA = CAB.NUNOTA " +

    "WHERE CAB.TIPMOV = 'V' " +
    "AND CAB.STATUSNOTA = 'L' " +
    "AND CAB.DTNEG BETWEEN ? AND ? " +
    "AND (CAB.CODPARCTRANSP = ? OR ? = 0) " +
    "AND (CAB.CIF_FOB = ? OR ? = ' ') " +
    "AND (CAB.CODEMPNEGOC = ? OR ? = 0) " +
    "AND CAB.CODPARCTRANSP <> 0 " +
    (pendentes ? "AND CAB.AD_ENTREGA2 IS NULL " : "") +

    "GROUP BY " +
    "    CAB.NUNOTA, CAB.NUMNOTA, CAB.VLRNOTA, CAB.CODVEND, VEN.APELIDO, CAB.QTDVOL, CAB.DTNEG, CAB.VLRFRETE, " +
    "    PAR_CLI.NOMEPARC,CAB.AD_ENTREGA2, PAR_TRP.CODPARC, PAR_TRP.NOMEPARC, " +
    "    CAB.AD_OBSFRETE, CAB.AD_OBSERVACAOINTERNA, EMP.NOMEFANTASIA, CAB.ORDEMCARGA, CAB.CIF_FOB, CAB.TIPFRETE " +

    "ORDER BY CAB.DTNEG DESC";

    var params = [
        // Posicoes 1 e 2: BETWEEN do CTE WITH MARGEM
        {value: dataIni + " 00:00:00", type: "D"},
        {value: dataFim + " 23:59:59", type: "D"},
        // Posicoes 3 e 4: BETWEEN do SELECT principal
        {value: dataIni + " 00:00:00", type: "D"},
        {value: dataFim + " 23:59:59", type: "D"},
        // Posicoes 5 e 6: filtro transportadora
        {value: codTransp, type: "I"},
        {value: codTransp, type: "I"},
        // Posicoes 7 e 8: filtro CIF/FOB
        {value: cifFob, type: "S"},
        {value: cifFob, type: "S"},
        // Posicoes 9 e 10: filtro empresa
        {value: empresa,   type: "I"},
        {value: empresa,   type: "I"}
    ];

    executeQuery(query, params, function(res){
        var dados = JSON.parse(res);
        document.getElementById('upd').textContent = "Atualizado: " + new Date().toLocaleTimeString('pt-BR');

        if(!dados || dados.length === 0){
            ALL = []; FIL = [];
            document.getElementById('b1').innerHTML = '<tr><td colspan="13" class="no-data">Nenhuma nota encontrada.</td></tr>';
            atualizarMetricas();
            return;
        }

        ALL = dados.map(function(r){
            return {
                numnota:    r.NUMNOTA,
                nunota:     r.NUNOTA,
                dtneg:      new Date(r.DTNEG),
                dtfmt:      fmtDate(r.DTNEG),
                cli:        r.NOME_CLIENTE           || '-',
                trp:        r.NOME_TRANSPORTADORA    || '-',
                codtrp:     r.COD_TRANSPORTADORA     || '',
                dtprev:     fmtDate(r.DATA_PREV),
                entrg:      r.ENTREGA                || '-',
                vendedor:   r.APELIDO                || '-',
                vol:        parseFloat(r.QTDVOL)     || 0,
                vlr:        parseFloat(r.VLRNOTA)    || 0,
                frt:        parseFloat(r.VLRFRETE)   || 0,
                tf:         r.CIF_FOB                || '-',
                tfrt:       r.TIPFRETE                || '-',
                emp:        r.NOMEFANTASIA           || '-',
                obsF:       r.AD_OBSFRETE            || '',
                obsI:       r.AD_OBSERVACAOINTERNA   || '',
                oc:         r.ORDEMCARGA             || '',
                // Campos de margem
                lucro:      parseFloat(r.LUCRO_BRUTO)      || 0,
                margem:     parseFloat(r.MARGEM_PERCENTUAL) || 0,
                lucro_despesa: parseFloat(r.LUCRO_DESPESA)       || 0
            };
        });

        FIL = ALL; pg = 1;
        atualizarMetricas();
        renderTabela();
        renderGraficos();

    }, function(err){
        document.getElementById('upd').textContent = "Erro ao carregar.";
        alert("Erro ao carregar dados:\n" + err);
    });
}

function togglePendentes(){
    // Apenas marca/desmarca a opção, o período continua selecionável
}

// ===== LIMPAR =====
function limpar(){
    limparTransp();
    document.getElementById('ffr').value  = '';
    document.getElementById('femp').value = '0';
}

// ===== METRICAS =====
function atualizarMetricas(){
    document.getElementById('mnf').textContent  = FIL.length;
    document.getElementById('mvlr').textContent = brl(FIL.reduce(function(s,r){ return s+r.vlr; }, 0));
    document.getElementById('mvol').textContent = FIL.reduce(function(s,r){ return s+r.vol; }, 0);
    document.getElementById('mtr').textContent  = new Set(FIL.map(function(r){ return r.trp; })).size;
}
// ===== SELECIONAR LINHA =====
function selecionarLinha(el){
    if(selectedRow) selectedRow.classList.remove('row-selected');
    el.classList.add('row-selected');
    selectedRow = el;
}
// ===== SELECIONAR LINHA =====
function selecionarLinha(el){
    if(selectedRow) selectedRow.classList.remove('row-selected');
    el.classList.add('row-selected');
    selectedRow = el;
}

// ===== ABRIR NOTA =====
function abrirNota(nunota){
    openApp('br.com.sankhya.com.mov.CentralNotas', {
        NUNOTA: nunota
    });
}
// ===== ABRIR DETALHES =====
function abrirDetalhes(nunota){
    openLevel('01U', {
        nunota: nunota  
    });
}
// ===== TABELA =====
function renderTabela(){
    var busca = (document.getElementById('tsrch').value || '').toLowerCase();
    var d = FIL.filter(function(r){
        if(!busca) return true;
        return String(r.numnota).indexOf(busca) >= 0 ||
               String(r.nunota).indexOf(busca)  >= 0 ||
               r.cli.toLowerCase().indexOf(busca) >= 0 ||
               r.trp.toLowerCase().indexOf(busca) >= 0 ||
               r.emp.toLowerCase().indexOf(busca) >= 0;
    });

    d.sort(function(a,b){
        var va=a[sortC], vb=b[sortC];
        if(sortC==='dtneg') return sortD*(va-vb);
        if(typeof va==='number') return sortD*(va-vb);
        return sortD*String(va).localeCompare(String(vb),'pt-BR');
    });

    var total=d.length, totalP=Math.ceil(total/PP)||1;
    if(pg>totalP) pg=totalP;
    var pag=d.slice((pg-1)*PP, pg*PP);

    document.getElementById('tcnt').textContent = total+' registro(s)';
    document.getElementById('pinfo').textContent = 'Pagina '+pg+' de '+totalP+' ('+total+' registros)';

    var b1=document.getElementById('b1');
    b1.innerHTML = pag.length===0
        ? '<tr><td colspan="13" class="no-data">Nenhum registro encontrado.</td></tr>'
        : pag.map(function(r){
            var lCls  = margCls(r.lucro);
            var mCls  = margCls(r.margem);
            var lrCls = margCls(r.lucro_despesa);
            return '<tr onclick="selecionarLinha(this)" ondblclick="abrirDetalhes('+r.nunota+')">'+
                '<td><strong>'+r.numnota+'</strong></td>'+
                '<td><strong style="color:#185FA5;cursor:pointer" onclick="abrirNota('+r.nunota+')">'+r.nunota+'</strong></td>'+
                '<td>'+r.dtfmt+'</td>'+
                '<td>'+r.cli+'</td>'+
                '<td>'+r.trp+'</td>'+
                '<td>'+r.dtprev+'</td>'+
                '<td>'+r.entrg+'</td>'+
                '<td>'+r.vendedor+'</td>'+
                '<td style="text-align:right">'+r.vol+'</td>'+
                '<td style="text-align:right">'+brl(r.vlr)+'</td>'+
                '<td style="text-align:right">'+(r.frt?brl(r.frt):'-')+'</td>'+
                '<td>'+badgeFrete(r.tf)+'</td>'+
                '<td>'+r.tfrt+'</td>'+
                '<td>'+r.emp+'</td>'+
                '<td style="text-align:right" class="'+lCls+'">'+brl(r.lucro)+'</td>'+
                '<td style="text-align:right" class="'+mCls+'">'+r.margem.toFixed(1)+'%</td>'+
                '<td style="text-align:right" class="'+lrCls+'">'+brl(r.lucro_despesa)+'</td>'+
            '</tr>';
          }).join('');

    document.getElementById('b3').innerHTML = pag.map(function(r){
        return '<tr onclick="selecionarLinha(this)">'+
            '<td><strong>'+r.numnota+'</strong></td>'+
            '<td>'+r.cli+'</td>'+
            '<td>'+r.trp+'</td>'+
            '<td>'+r.vendedor+'</td>'+
            '<td>'+(r.obsF||'-')+'</td>'+
            '<td>'+(r.obsI||'-')+'</td>'+
        '</tr>';
    }).join('');

    renderPagina(totalP);
}

function renderPagina(totalP){
    var el=document.getElementById('pbts');
    el.innerHTML='';
    for(var i=1;i<=totalP;i++){
        el.innerHTML+='<button class="pb'+(i===pg?' act':'')+'" onclick="irPag('+i+')">'+i+'</button>';
    }
}
function irPag(n){ pg=n; renderTabela(); }

// ===== ORDENACAO =====
function srt(col){
    if(sortC===col) sortD*=-1; else { sortC=col; sortD=1; }
    renderTabela();
}

// ===== GRAFICOS =====
var CORES=['#1D9E75','#185FA5','#BA7517','#A32D2D','#6B4FA0','#2A7A9B','#C46C1A','#3D7A3D','#7A4080','#4A7A6A'];

function renderGraficos(){
    var grupos={};
    FIL.forEach(function(r){
        if(!grupos[r.trp]) grupos[r.trp]={vol:0,vlr:0};
        grupos[r.trp].vol+=r.vol; grupos[r.trp].vlr+=r.vlr;
    });
    var labels=Object.keys(grupos);
    var vols=labels.map(function(k){return grupos[k].vol;});
    var vlrs=labels.map(function(k){return grupos[k].vlr;});
    var cores=labels.map(function(_,i){return CORES[i%CORES.length];});

    if(chartVol) chartVol.destroy();
    chartVol=new Chart(document.getElementById('cVol'),{
        type:'bar', data:{labels:labels,datasets:[{data:vols,backgroundColor:cores,borderRadius:4}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true}}}
    });
    if(chartVlr) chartVlr.destroy();
    chartVlr=new Chart(document.getElementById('cVlr'),{
        type:'doughnut', data:{labels:labels,datasets:[{data:vlrs,backgroundColor:cores}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{position:'right',labels:{boxWidth:12,font:{size:11}}}}}
    });

    var porDia={};
    FIL.forEach(function(r){ porDia[r.dtfmt]=(porDia[r.dtfmt]||0)+1; });
    var dias=Object.keys(porDia).sort(function(a,b){
        return new Date(a.split('/').reverse().join('-'))-new Date(b.split('/').reverse().join('-'));
    });
    if(chartLine) chartLine.destroy();
    chartLine=new Chart(document.getElementById('cLine'),{
        type:'line',
        data:{labels:dias,datasets:[{label:'NFs expedidas',data:dias.map(function(k){return porDia[k];}),
            borderColor:'#1D9E75',backgroundColor:'rgba(29,158,117,0.12)',borderWidth:2,pointRadius:3,tension:0.3,fill:true}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{display:false}},scales:{y:{beginAtZero:true}}}
    });
}

// ===== ABAS =====
function swtab(el,id){
    document.querySelectorAll('.tab').forEach(function(t){t.classList.remove('act');});
    document.querySelectorAll('.tc').forEach(function(t){t.classList.remove('act');});
    el.classList.add('act');
    document.getElementById(id).classList.add('act');
}

// ===== FULLSCREEN TABELA =====
function toggleTableFullscreen(){
    var layout = document.querySelector('.layout');
    var card = document.querySelector('.table-card');
    var btn = document.getElementById('btnFullscreen');
    var inFull = card.classList.toggle('fullscreen');
    layout.classList.toggle('fullscreen', inFull);
    btn.innerHTML = inFull ? '&#x2715;' : '&#x26F6;';
    btn.title = inFull ? 'Minimizar tabela' : 'Maximizar tabela';
}

// ===== EXPORTAR CSV =====
function exportCSV(){
    if(FIL.length===0){ alert("Sem dados para exportar."); return; }
    function esc(v){ return '"'+String(v==null?'':v).replace(/"/g,'""')+'"'; }
    var SEP=";";
    var header=["NF","Nro Unico","Data","Cliente","Vendedor","Transportadora", "Data Prevista", "Entrega","Volumes",
                "Valor NF","Vlr Frete","CIF/FOB","Tipo Frete","Empresa",
                "Lucro Bruto","Margem %","Lucro Rota"];
    var linhas=FIL.map(function(r){
        return [esc(r.numnota),esc(r.nunota),esc(r.dtfmt),esc(r.cli),esc(r.vendedor),esc(r.trp) ,
                esc(r.vol), esc(r.entrg),
                esc(r.vlr.toFixed(2).replace('.',',')),
                esc(r.frt.toFixed(2).replace('.',',')),
                esc(r.dtprev),
                esc(r.tf), esc(r.tfrt), esc(r.emp),
                esc(r.lucro.toFixed(2).replace('.',',')),
                esc(r.margem.toFixed(2).replace('.',',')),
                esc(r.lucro_despesa.toFixed(2).replace('.',','))].join(SEP);
    });
    var csv="sep=;\r\n"+header.map(esc).join(SEP)+"\r\n"+linhas.join("\r\n");
    var blob=new Blob(["\uFEFF"+csv],{type:'text/csv;charset=utf-8;'});
    var url=URL.createObjectURL(blob);
    var a=document.createElement('a');
    a.href=url; a.download='envios_transportadora.csv'; a.click();
    URL.revokeObjectURL(url);
}

</script>
</body>
</html>