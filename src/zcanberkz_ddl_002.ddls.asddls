@AbapCatalog.sqlViewName: 'ZCZOR_CDS_002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Canberk ZOR CDS Edu-2'
define view ZCANBERKZ_DDL_002
  as select from    vbrk as _vbrk

    inner join      vbrp as _vbrp on  _vbrk.mandt = _vbrp.mandt
                                  and _vbrk.vbeln = _vbrp.vbeln

    inner join      mara as _mara on  _vbrp.mandt = _mara.mandt
                                  and _vbrp.matnr = _mara.matnr

    left outer join vbak as _vbak on  _vbrp.mandt = _vbak.mandt
                                  and _vbrp.aubel = _vbak.vbeln

    left outer join kna1 as _kna1 on  _vbak.mandt = _kna1.mandt
                                  and _vbak.kunnr = _kna1.kunnr

    left outer join makt as _makt on  _mara.mandt = _makt.mandt
                                  and _mara.matnr = _makt.matnr
                                  and _makt.spras = $session.system_language


{
  _vbrp.vbeln,
  _vbrp.posnr,
  _vbrp.aubel,
  _vbrp.aupos,
  _vbak.kunnr,
  
  concat_with_space(_kna1.name1 , _kna1.name2 , 1 ) as kunnrAd,
  
  left(_kna1.kunnr,3 )                              as left_kunnr,
  
  length(_mara.matnr )                              as matnr_length,
  currency_conversion(amount=>_vbrp.netwr,
                 source_currency=>_vbrk.waerk,
                 target_currency=>cast('EUR'  as abap.cuky ),
                 exchange_rate_date=>_vbrk.fkdat)   as conversion_netwr,
                 
  case _vbrk.fkart
  when 'FAS' then 'Peşinat Talebi İptali'
  when 'FAZ' then 'Peşinat Talebi'
  else 'Fatura' end                                 as faturalama_turu,
  
  _vbrk.fkdat ,
  _vbrk.inco2_l




}
