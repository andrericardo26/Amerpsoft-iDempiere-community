﻿-- View: amf_payment_v

DROP VIEW IF EXISTS amf_payment_v;

CREATE OR REPLACE VIEW amf_payment_v AS 
 SELECT c_payment.c_payment_id, c_payment.ad_client_id, c_payment.ad_org_id, c_payment.isactive, c_payment.created, c_payment.createdby, c_payment.updated, c_payment.updatedby, c_payment.documentno, c_payment.datetrx, c_payment.isreceipt, c_payment.c_doctype_id, c_payment.trxtype, c_payment.c_bankaccount_id, c_payment.c_bpartner_id, c_payment.c_invoice_id, c_payment.c_bp_bankaccount_id, c_payment.c_paymentbatch_id, c_payment.tendertype, c_payment.creditcardtype, c_payment.creditcardnumber, c_payment.creditcardvv, c_payment.creditcardexpmm, c_payment.creditcardexpyy, c_payment.micr, c_payment.routingno, c_payment.accountno, c_payment.checkno, c_payment.a_name, c_payment.a_street, c_payment.a_city, c_payment.a_state, c_payment.a_zip, c_payment.a_ident_dl, c_payment.a_ident_ssn, c_payment.a_email, c_payment.voiceauthcode, c_payment.orig_trxid, c_payment.ponum, c_payment.c_currency_id, c_payment.c_conversiontype_id, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN c_payment.payamt
            ELSE c_payment.payamt * (-1)::numeric
        END AS payamt, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN c_payment.discountamt
            ELSE c_payment.discountamt * (-1)::numeric
        END AS discountamt, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN c_payment.writeoffamt
            ELSE c_payment.writeoffamt * (-1)::numeric
        END AS writeoffamt, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN c_payment.taxamt
            ELSE c_payment.taxamt * (-1)::numeric
        END AS taxamt, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN c_payment.overunderamt
            ELSE c_payment.overunderamt * (-1)::numeric
        END AS overunderamt, 
        CASE c_payment.isreceipt
            WHEN 'Y'::bpchar THEN 1
            ELSE (-1)
        END AS multiplierap, 
        c_payment.isoverunderpayment, c_payment.isapproved, c_payment.r_pnref, 
        c_payment.r_result, c_payment.r_respmsg, c_payment.r_authcode, 
        c_payment.r_avsaddr, c_payment.r_avszip, c_payment.r_info, c_payment.processing, 
        c_payment.oprocessing, c_payment.docstatus, c_payment.docaction, c_payment.isprepayment, c_payment.c_charge_id, 
        c_payment.isreconciled, c_payment.isallocated, c_payment.isonline, c_payment.processed, c_payment.posted, c_payment.c_campaign_id, 
        c_payment.c_project_id, c_payment.c_activity_id, c_payment.ad_orgtrx_id, c_payment.chargeamt, c_payment.c_order_id, c_payment.dateacct, 
        c_payment.description, c_payment.isselfservice, c_payment.processedon, c_payment.reversal_id,
        CONCAT(to_char(c_payment.payamt, '999999999999D99S'),'  ',baa.name,' ',to_char(c_payment.dateacct, 'DD/MM/YYYY') ,' ',c_doctype.docbasetype,'-',c_payment.documentno,'-',c_payment.description) as description_ext
   FROM c_payment c_payment
   LEFT JOIN c_doctype c_doctype ON (c_doctype.c_doctype_id = c_payment.c_doctype_id)
   LEFT JOIN c_bankaccount baa ON (c_payment.c_bankaccount_id = baa.c_bankaccount_id)
   ORDER BY baa.name, c_payment.dateacct DESC ;
ALTER TABLE amf_payment_v
  OWNER TO adempiere;
