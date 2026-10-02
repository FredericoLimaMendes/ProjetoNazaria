Definir interno.com.senior.g5.co.mfi.cpa.titulos.ConsultarTitulosNZ_1 SrvConsulta;

Definir cursor cur_e501mcp;
Definir cursor cur_e501rat;
Definir cursor cur_e501mop;
Definir Cursor Cur_E095FOR;
Definir Alfa   aCodEmp;
Definir Alfa   aCodFil;
Definir Alfa   aCodFor;
Definir Alfa   aCodTns;
Definir Alfa   aSqlFor;
Definir Alfa   aSqlFil;
Definir Alfa   aSqlTns;
Definir Alfa   aVarAux;
Definir Data   dDatBas;
Definir Alfa   vCgcCpf;

MontaData(01,01,2025,ddatbas);  @-- quando definir o filtro de data tirar essa opção --@

aCodEmp = SrvConsulta.CodEmp;
EstaNulo(aCodemp,nNulo);
Se (nNulo = 1)
    Inicio
    SrvConsulta.Tiporetorno = "2";
    SrvConsulta.MensagemRetorno = "Informe o codigo da empresa.";
    VaPara Saida;
    Fim;

alfaparaint(acodemp,ncodemp);

@aCodFor = SrvConsulta.CodFor; @
aCodFil = SrvConsulta.CodFil;
aCodTns = SrvConsulta.CodTns;

Estanulo(aCodFor,nNulo);
Se (nNulo = 0)
    aSqlFor = "and e501tcp.CodFor = " + aCodFor;
Senao
    aSqlFor = " ";

EstaNulo(aCodFil,nNulo);
Se (nNulo = 0)
    aSqlFil = "and e501tcp.CodFil = " + aCodFil;
Senao
    aSqlFil = " ";

/*EstaNulo(aCodTns,nNulo);
Se (nNulo = 0)
    aSqlTns = "and e501mcp.CodTns = '" + aCodTns + "' ";
Senao
    aSqlTns = " ";
*/

Cur_E501mcp.sql "Select E501Tcp.Codemp,E501tcp.CodFil,E501tcp.CodFor,e095for.CgcCpf,E501tcp.Numtit,E501Tcp.CodTpt,e501Tcp.datemi,E501Tcp.Vlrori,E501Tcp.Vlrabe, \
                        E501Mcp.SeqMov,E501Mcp.VlrMov,E501mcp.DatMov,E501Mcp.CodTns \
                   from e501mcp,e501tcp, e095for \
                  where e501mcp.codemp=:ncodemp \
                    and e501mcp.SeqMov > 1 \
                    and e501mcp.vlrmov > 0 \
                    __inserir(:asqlfil) \
                    __inserir(:asqlfor) \
                    and e501mcp.codtns in ('91568', '91569', '90555', '90558', '90564', '90563', '90585', '90571', '90572', '90573','90578')\
                    and e501tcp.codemp = e501mcp.codemp \
                    and e501tcp.codfil = e501mcp.codfil \
                    and e501tcp.codfor = e501mcp.codfor \
                    and e501tcp.codfor = e095for.codfor \
                    and e501tcp.codtpt = e501mcp.codtpt \
                    and e501tcp.numtit = e501mcp.numtit \
                    and e501mcp.datmov >=:ddatbas \   /* quando definir o filtro de data tirar esse filtro */
              order by e501tcp.codfil,e501tcp.codfor,e501tcp.numtit,e501tcp.codtpt,e501mcp.seqmov";

nachou = 0;

Cur_e501mcp.abrircursor();
Enquanto(cur_e501mcp.achou)
    inicio
    nachou = 1;
    SrvConsulta.titulos.criarlinha();
    intparaalfa(cur_e501mcp.codemp,avaraux);
    SrvConsulta.titulos.codemp = avaraux;
    intparaalfa(cur_e501mcp.codfil,avaraux);
    SrvConsulta.titulos.codfil = avaraux;
    intparaalfa(cur_e501mcp.codfor,avaraux);
    SrvConsulta.titulos.codfor = avaraux;
    intparaalfa(cur_e501mcp.cgccpf,avaraux);
    SrvConsulta.titulos.cgcCpf = avaraux;
    SrvConsulta.titulos.codtpt = cur_e501mcp.codtpt;
    SrvConsulta.titulos.numtit = cur_e501mcp.numtit;
    Convertemascara(3,cur_e501mcp.datemi,avaraux,"DD/MM/YYYY");
    SrvConsulta.titulos.datemi = avaraux;
    Convertemascara(1,cur_e501mcp.vlrori,avaraux,"zzzzzzzzzzz9,99");
    limpaespacos(avaraux);
    SrvConsulta.titulos.vlrori = avaraux;
    Convertemascara(1,cur_e501mcp.vlrabe,avaraux,"zzzzzzzzzzz9,99");
    limpaespacos(avaraux);
    SrvConsulta.titulos.vlrabe = avaraux;
    intparaalfa(cur_e501mcp.seqmov,avaraux);
    SrvConsulta.titulos.seqmov = avaraux;
    Convertemascara(1,cur_e501mcp.vlrmov,avaraux,"zzzzzzzzzzz9,99");
    limpaespacos(avaraux);
    SrvConsulta.titulos.vlrmov = avaraux;
    Convertemascara(3,cur_e501mcp.datmov,avaraux,"DD/MM/YYYY");
    SrvConsulta.titulos.datmov = avaraux;
    SrvConsulta.titulos.codtns = cur_e501mcp.codtns;
    cur_e501mcp.proximo();
    Fim;
cur_e501mcp.fecharcursor();

Se (nachou = 0)
    Inicio
    SrvConsulta.Tiporetorno = "2";
    SrvConsulta.MensagemRetorno = "Nenhum movimento encontrado dentros dos filtros informados.";
    Fim;
Senao
    Inicio
    SrvConsulta.Tiporetorno = "1";
    SrvConsulta.MensagemRetorno = "Processado com sucesso.";
    Fim;

Saida:
