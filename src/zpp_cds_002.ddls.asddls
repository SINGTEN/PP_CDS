@AbapCatalog.sqlViewName: 'ZPPCDSV002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BOM表'
define view ZPP_CDS_002
  as select from mast
    inner join   mara            on mast.matnr = mara.matnr
    inner join   marc            on  mast.matnr = marc.matnr
                                 and mast.werks = marc.werks
    inner join   stko            on  stko.stlnr = mast.stlnr
                                 and stko.stlal = mast.stlal
                                 and stko.stlty = 'M'
    inner join   pbomitemvalidto on  stko.stlty = pbomitemvalidto.stlty
                                 and stko.stlnr = pbomitemvalidto.stlnr
                                 and stko.stlal = pbomitemvalidto.stlal
    inner join   stpo            on  pbomitemvalidto.stlty = stpo.stlty
                                 and pbomitemvalidto.stlnr = stpo.stlnr
                                 and pbomitemvalidto.stlkn = stpo.stlkn
  association [0..1] to mast as _itembom on  $projection.idnrk = _itembom.matnr
                                         and $projection.werks = _itembom.werks
  association [0..1] to makt as _matdesc on  $projection.matnr = _matdesc.matnr
                                         and _matdesc.spras    = $session.system_language
  association [0..1] to makt as _idesc   on  $projection.idnrk = _idesc.matnr
                                         and _idesc.spras      = $session.system_language
  association [0..1] to mara as _imat    on  $projection.idnrk = _imat.matnr
  association [0..1] to marc as _imarc   on  $projection.idnrk = _imarc.matnr
                                         and $projection.werks = _imarc.werks
{
  mara.bismt,
  mast.matnr,
  _matdesc.maktx,
  mast.werks,
  mast.stlan,
  marc.mmsta,
  marc.beskz,
  marc.sobsl,
  stko.bmeng,
  stko.bmein,
  stpo.postp,
  stpo.posnr,
  _imat.bismt         as idbis,
  stpo.idnrk,
  _idesc.maktx        as imakt,

  _imarc.mmsta        as immsta,
  _imarc.beskz        as IBESKZ,
  _imarc.sobsl        as ISOBSL,

  stpo.menge,
  stpo.meins,
  stpo.ausch,
  stpo.alpgr,
  stpo.alprf,
  stpo.alpst,
  stpo.ewahr,
  stpo.sanka,


  case
   when _itembom.matnr <> '' then 'X'
   else ''
   end                as ass,


  pbomitemvalidto.validfromdate,

  cast(
       (case
        when pbomitemvalidto.validtodate <> '00000000'
   then pbomitemvalidto.validtodate
   else '99991231'
   end) as abap.dats) as validtodate

}
