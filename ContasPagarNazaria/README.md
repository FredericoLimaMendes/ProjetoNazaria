# ContasPagarNazaria

Integração ERP Senior (Nazária) → ProcFit: consulta de títulos de contas a pagar via
provedor interno de web service.

## Visão geral

- **Provedor:** `com.senior.g5.co.mfi.cpa.titulos.ConsultarTitulosNZ_1`
- **Regra LSP:** [`ConsultarTitulosNZ_1.lsp`](./ConsultarTitulosNZ_1.lsp)
- **Tabelas:** `E501TCP` (títulos), `E501MCP` (movimentos), `E095FOR` (fornecedores)
- **Consumidor:** ProcFit
- **Identificação do fornecedor:** por CNPJ (`CgcCpf`) — o ProcFit não tem acesso ao
  código interno do fornecedor no ERP, por isso o filtro `CodFor` não é alimentado pela
  regra (comportamento intencional, não é bug).

## Status

Funcionando — teste manual via client Senior retornou o título de exemplo
(CodEmp 2 / CodFil 11 / NumTit 82449) com `TipoRetorno = 1` ("Processado com sucesso").

ProcFit reportou que o título de teste (mesmo do PDF enviado pela Valdirene) não
aparece do lado deles. Novo teste conjunto agendado com Vlademir Vargette.

## Pendências

| # | Item | Status |
|---|---|---|
| 1 | Alinhamento com ProcFit — título de teste não aparece do lado deles | Em andamento |
| 2 | Substituir data fixa (`MontaData(01,01,2025,ddatbas)` hardcoded) por filtro real/incremental | Pendente |
| 3 | Confirmar se a lista fixa de `CodTns` (91568, 91569, 90555, 90558, 90564, 90563, 90585, 90571, 90572, 90573, 90578) é regra de negócio definitiva ou deve respeitar o `CodTns` enviado no request | Pendente — decisão de negócio |
| 4 | Limpeza de código morto: cursores não utilizados (`cur_e501rat`, `cur_e501mop`, `Cur_E095FOR`) e variável `vCgcCpf` | Pendente |
| 5 | Avaliar paginação/limite de linhas para evitar consulta sem corte crescendo com o tempo | Pendente |
