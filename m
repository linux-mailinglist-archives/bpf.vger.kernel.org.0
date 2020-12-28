Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B832E6C3E
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgL1Wzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 17:55:48 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:45688
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729374AbgL1UHO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 15:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609185986; bh=pnRS6Ne8ypesj+Wp8sFl8V5vaIifQ3lktb3h2yQwP3A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sFvQKAfTuKSiccv7HsJHr0it9IvuYxEJcCy4ZAl8KZrrAvAYPBP/A9+ik1Lg9ENAj7QQNwW5vuvU0eiGszKchoXBEAR5Y7kRhaWnpejam0UQpp337SpngIg1xy5GcGbTn3DxYe/oXRaanQmp0NVUObWEabhdxrjJ4Z4V+SMiTe9l0so4CYk0RhBxeIFRSd4qzLmy1OGnklECMy0LtaoXJntiWbSl6ONTBTJ7t2UKYoVPI4KIxNtV8tjvpO51K4+JoRG/ahbpsdEYX7Ie3yhaXmYyZYmwMJl0W2czNeWLWuyCAWDL9YOt8kXsfA6dZT5NW4gedihga5R9ubLQ9KfVXg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609185986; bh=4Cxx3YpjZ3C5iG7rLwC66A6nTNFHE/8m1yqTy9NSdpk=; h=Subject:To:From:Date:From:Subject; b=lEoLZTAbxND96Q2UxRupGMNW5qx2JU4uhJUIhfNicqZY9pD0y41e3v+ESeO0Oz675eAJx68O9apdglcVUJwjFXIWHSgBuMXzS9eTSmlEvRa3Xb51iG/hL6amwBcXku/CfIeVko2bHGycv95fq1GyCp3/hBW6HEujvse4jURS9He4gkPONAWWha5wYz3mTFC6wWgdM5IoM0OOJlEKKiqB1QP0Mwi0I78+SINOqajZc7lvArUBiSwkJ8GDdwqamW7qBh4KRbRPu8ptR48V9qB8A6aHL0+MtDZ8tYR2nPlmhSKIiqdo3fw83912IIc9+NS9Y0kE0OpkL64QPOoRxn8+Bw==
X-YMail-OSG: pgTuvrAVM1l7NYsNNBbxGy0EZFHz4n1shaJGzloNw0Ls_GpWFA1yPxU46IZG4oU
 nDAFXsKaSVEYydEYA1nzCrqYpByQL1AyI76p8698eUhqhCXtAj5pD5Ger3zJZmfYPrIKSxUa9FkV
 enbr5ekxvueDX6q6QtFiFbBudXzsW2i5_70ABOyD_uxxz6qzUJ1mgiSo043R9Y999dGvl8xI59..
 6jGpcP7vi7.lRtYAnlPcnPGSW0.OtdnCBYaHhEBUPQ8hoZfy3iDENCHR04KGZnGx8ddP0RXpVY1Y
 9hoKV81iwEMLvq0GrnfkB1Q5IZ8GBxHIPNacZ4VSyvSXif_EzQAh7NenuXf2j6NLrNb5RoyTqA6G
 Yn94eJAb04Gn8g_GsQEU.AW5axp1bPnPqvzzgxMlx7nyjhAizGA9mo.DVWI.eIHBZpyHZju4zStY
 zzaqom3Z4ipgUtZTWlUs95hdfyhgsf1VQYU07Ps9WuoLvKSz3P7PGMOphIzldzxjfaT8HOcfoNm7
 wPgB_gDzRKj3I0XkuNwPaoZitjZpj9ZI7ymll7EYE8IJJdnaYT5fz0VH4Atdeexv0khiTjIcEkEJ
 0SMhUrbjDn8B_7rx19_drff2XDPLc09DunPdDkH.2rU_hwKPBrS4cU7hMzYsmPPZCXHFIp6.k8iG
 WFyXmQc7CoEVxRuktkLUJCUF6_WYjG2CN6HuGysZjdzZxX2W90.9qOTl5VIW371Js8lVdjM4N2eD
 H1AwxRSuWx_Bkk6RpxMOL5zJDGiqvjjCguRiLeb8hCHM4mN_FqiUx2vlUktUBgOfGmk_EVwQi_mJ
 JaFWWdBHOLxpLbc7d1mcjKTHd8srpB6_oimrhmKqoGrKAim.Uq5INVpUbqa8clC5sGf6paSZsgbK
 99ERcVHsgfKWapjX8j_4M6tXMrBvOMR.P6WWb2idBBPOEWt86gqC0OBMrXYSewYF._vlXIYP.QU7
 A9bKnmHkVnfoFFDi3Ygs4LTlsvvMZR0svIE70Q0PzlvSGxgowqPr9XL7seGYJ_gFDocdaJsn1jYs
 Za8OH_W5_Na9KT7eAV1WrZwUJrxiSMG6JGFc235rf4yLUNpRQnjOWTNHdNTpyeprB86vreZpIZTG
 32qY0.4OlcUN.nXrexa7iLxnxbMMbIAjDrmoCPIzhYA9m3FtrJjGEoFHfoGyMuUP4nLlRVvjk6Zl
 6GjvgpUB.U3POoRF9TD_QZKokoaVei0edwDKZgjZr_VadOkK56hOPZp4bmJtQOkb1TT9tTieTFYg
 RkwZOetItWEYvrJu7qqajXdvE_cO32bczXXy6h6DEL7aXuzLrSKIxoLGaZUyrcMx3LOCE9nphPFv
 GSlfi8T2jPXttlwJtukCss.SgkUy9ly3RRWVNdKk3N_qJuggxfyHZ5tXXga5U5SPBzqhTP466KXI
 zK3.LYSDgWCzkuOQstIwH.GaJKO4IyRcXz31XERVBsrocM4ZZ6GQCrPSSzt6gEPbuvj7meR21r8a
 6OyiAbLcBkgazcCWwM.Y5F04OrLvtI1itKyT7jnjUDUYLDs6hrLLLMdMRqh70_RWoz6cb1.mtlMt
 zCo4f_6a_kuQGUC8cybCU4UI_xzjXxOLfyVU1R4XLqZ5TyU7rSk4hZX1HiCwg0X_Mt6fbd.zyRWQ
 hPH4GPBat8mfrZ7qfk0iyKKiUgl7dWOQCG50dUBs1EM0D1E9_ZLv3Npl0WSMToKXqtZviqwalG3C
 ycJ7XBYsRVQdLMjB8FEtnF76OuG_uVf29TXud_natS02DYhpoFop1A8pBFdQ8xYhzfLPtndozCLG
 MKwAeoNlSYkF37AAU4GTkiED9atwPtrCeL1.NlUhamtSYO3hDrTN_DVNao5eEWi3WHrWc7PT0ubj
 9lZrf5jJ_xQeURGKWqd1JTy0AaByzKNKvxJbSE.IUJXKVi0uaihdo605XTLR0tZ2Ew3UW46tNu3F
 NMU0lDuD8JRQ01QR.Y.4ayTsfHZGJHRUt3EUVOAMe4vs22hhuXUhuInF_GXZPLLdk7dZDgqKq9i6
 NcOWd3JIY8vpVLZZlmGiOZ9l1slV6GKXzxXLzMTHh4PAW4h0ufEoA390knhhDou7t2Ya8rzfGqje
 mTwb9jx.YVfuGasUweoL3PuZvIxiMOXSEnV3S_2QALRvtYe3zhUoQ.8HGSoI8fDOlVo9pbM4TEgZ
 KwSAWQs_kCIRBLANQ2RIMzGMO4rFKn6FuhPtDMKOsTRz2NbuKJA3ybvk6m7tJ0U09rQIeEJMhJa8
 fRE7u7KtZg0mNipzhA9gWP6eXFQrF1F.6pFAUBXsjgfEhi0j2E05A7MkuuMOfARlas9D5Knt8qRs
 wslxJa.MqhTTWIvcSZeBM7nPrc9nKUTjy1av_3.IBBK1cDdS46cYXzB6SmzRpKaHmYgDUyL1AnHt
 GA7hrZxOAIfokT0s6N0HplDbmxSqEUHaULV2o1fu8wPwYSbpX_6vLuhaEh1jchwetZnarFeXKZP2
 7pIKiE6Ln9e3XfNZYDTHUSDJrwoLA7IIphHYquOKGzcUR57AxIx0BUTPwJGVwdidva2YJdcM7xRj
 SApOuqdjjoILetS92yptMxneW4UA.9m1ddTLKdF.tPYhlHHVflJmwRXOjwqkVX.ulJPr9tZXb.HO
 65oRfeYPvhdgN3ixeBQf3ytWEeRpPASLGnRyJm_a0Tj35pmYGTv.d9KJJvZVm2AmwPRRtnOlTqGB
 Qs6xiIz5ZKae1FPyVGkMucrQOknycTrG25oRtsOF7_.fA3Qs3QPhJayVbDH0tbGnr37okOX2PP.T
 VfahQBTUFBbjnCBu8IHFkySYXAdhbc5CWESX9ikAHxOZ1AgkKIwrx6_Bs.wr9HDfCPX5IZ7Z1qJj
 tslI9cGu.nVYsNiTukXspH86.fz.ZyS.DPe7R1Acfc2JVd9pBhOR06Qf89gfInfWjtB3UDqLxkny
 QaC1SR0hUUrf90Obgw8SlnYJS_MUv4cVIMqC1sEh.yyi074Gl33eIxPc42EaPTjvBQV8wHMmFdH_
 kbHmjHW0xvQl6gONAAuhBIKq8IN8h1Vijmsy6azdFsIOFAmSlbuFNSpMdypzGmaUwNnuugw1yULQ
 tenWfskchET6L27SJ64zAlgKJZSRXabVK
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Dec 2020 20:06:26 +0000
Received: by smtp421.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b01905f8d95e2b254c7aa58e888394de;
          Mon, 28 Dec 2020 20:06:26 +0000 (UTC)
Subject: Re: [PATCH v23 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20201120201507.11993-1-casey@schaufler-ca.com>
 <20201120201507.11993-3-casey@schaufler-ca.com>
 <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <886fcd04-6a08-d78c-dc82-301c991e5ad8@schaufler-ca.com>
Date:   Mon, 28 Dec 2020 12:06:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/2020 11:24 AM, Mimi Zohar wrote:
> Hi Casey,
>
> On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
>> diff --git a/security/security.c b/security/security.c
>> index 5da8b3643680..d01363cb0082 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>>
>> @@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *key, c=
har **_buffer)
>>
>>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void *=
*lsmrule)
>>  {
>> -       return call_int_hook(audit_rule_init, 0, field, op, rulestr, l=
smrule);
>> +       struct security_hook_list *hp;
>> +       bool one_is_good =3D false;
>> +       int rc =3D 0;
>> +       int trc;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init,=
 list) {
>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D=
 lsm_slot))
>> +                       continue;
>> +               trc =3D hp->hook.audit_rule_init(field, op, rulestr,
>> +                                              &lsmrule[hp->lsmid->slo=
t]);
>> +               if (trc =3D=3D 0)
>> +                       one_is_good =3D true;
>> +               else
>> +                       rc =3D trc;
>> +       }
>> +       if (one_is_good)
>> +               return 0;
>> +       return rc;
>>  }
> So the same string may be defined by multiple LSMs.

Yes. Any legal AppArmor label would also be a legal Smack label.

>>  int security_audit_rule_known(struct audit_krule *krule)
>> @@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit_kru=
le *krule)
>>         return call_int_hook(audit_rule_known, 0, krule);
>>  }
>>
>> -void security_audit_rule_free(void *lsmrule)
>> +void security_audit_rule_free(void **lsmrule)
>>  {
>> -       call_void_hook(audit_rule_free, lsmrule);
>> +       struct security_hook_list *hp;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free,=
 list) {
>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D=
 lsm_slot))
>> +                       continue;
>> +               hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
>> +       }
>>  }
>>
> If one LSM frees the string, then the string is deleted from all LSMs. =

> I don't understand how this safe.

The audit system doesn't have a way to specify which LSM
a watched label is associated with. Even if we added one,
we'd still have to address the current behavior. Assigning
the watch to all modules means that seeing the string
in any module is sufficient to generate the event.

>
>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsm=
rule)
>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **ls=
mrule)
>>  {
>> -       return call_int_hook(audit_rule_match, 0, secid, field, op, ls=
mrule);
>> +       struct security_hook_list *hp;
>> +       int rc;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match=
, list) {
>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=3D=
 lsm_slot))
>> +                       continue;
>> +               rc =3D hp->hook.audit_rule_match(secid, field, op,
>> +                                              &lsmrule[hp->lsmid->slo=
t]);
>> +               if (rc)
>> +                       return rc;
> Suppose that there is an IMA dont_measure or dont_appraise rule, if one=

> LSM matches, then this returns true, causing any measurement or
> integrity verification to be skipped.

Yes, that is correct. Like the audit system, you're doing a string based
lookup, which pretty well has to work this way. I have proposed compound
label specifications in the past, but even if we accepted something like
"apparmor=3Ddates,selinux=3Dfigs" we'd still have to be compatible with t=
he
old style inputs.

>
> Sample policy rules:
> dont_measure obj_type=3Dfoo_log
> dont_appraise obj_type=3Dfoo_log
>
> Are there any plans to prevent label collisions or at least notify of a=

> label collision?

What would that look like? You can't say that Smack isn't allowed
to use valid AppArmor labels. How would Smack know? If the label is
valid to both, how would you decide which LSM gets to use it?

>
> Mimi
>
>> +       }
>> +       return 0;
>>  }
>>  #endif /* CONFIG_AUDIT */

