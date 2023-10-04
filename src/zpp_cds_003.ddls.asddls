@AbapCatalog.sqlViewName: 'ZPPCDSV003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '途程清單'
define view ZPP_CDS_003
  as select from mapl
    inner join   mara on mapl.matnr = mara.matnr
    inner join   marc on  mapl.matnr = marc.matnr
                      and mapl.werks = marc.werks
    inner join   plko on  plko.plnty = 'N'
                      and mapl.plnnr = plko.plnnr
                      and mapl.plnal = plko.plnal
    inner join   plas on  plko.plnty = plas.plnty
                      and plko.plnnr = plas.plnnr
                      and plko.plnal = plas.plnal
    inner join   plpo on  plas.plnty = plpo.plnty
                      and plas.plnnr = plpo.plnnr
                      and plas.plnkn = plpo.plnkn
                      and plas.zaehl = plpo.zaehl
  association [0..1] to crhd as _wc      on  _wc.objty  = 'A'
                                         and $projection.arbid = _wc.objid
  association [1..1] to crtx as _wcd     on  _wcd.objty  = 'A'
                                         and $projection.arbid = _wcd.objid
                                         and _wcd.spras = $session.system_language
  association [0..1] to makt as _matdesc on  $projection.matnr     = _matdesc.matnr
                                         and _matdesc.spras = $session.system_language

{
  mapl.werks,
  mara.bismt,
  mapl.matnr,
  _matdesc.maktx,
  mapl.plnnr,
  mapl.plnal,
  plpo.vornr,
  plpo.steus,
  _wc.arbpl  as wc,
  _wcd.ktext as wcd,
  plpo.ktsch,
  plpo.ltxa1,
  plpo.bmsch,
  plpo.meinh,
  plpo.umrez,
  plpo.umren,
  plpo.arbid
}
