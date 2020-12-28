Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D512E6C78
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 00:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgL1XXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 18:23:09 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42647
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730703AbgL1XVA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 18:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609197613; bh=7eqO8VIk88af7FH9W93mP2ic4208n7wo2lNI8MXLnpc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RhZPpmMzDpDp8n08RCFz1zbgdnmKdF9TkLFYj4M577Y491olldQvCVLWLSN3M/rcEy5WKD5OhEpWOK+HBeytRFGh3fcnFtdQ9Rf4g1TsXUZc9wTaUjsVejNOPYPfZs/0T/JMkWTPSEtXsm4TNbpb0euXBMQOVbYk6wq9pc1hg/NCeCqDNPytAAtvaV0MdYqNskmjAJ5YB/gXilOPKJvE4UzGxX83XEJvixzz8hw5MFq+sGx3pqMyby3ODqHxMl/LvEH655omXzGy/1pk8gtx4JDFhyE9G+p1ljd2t9AZS9U1WfSGDQFiHBVUkCZ93+H4GX3uonJ3yR1DebecmMlFaQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609197613; bh=UnFnUQQiQ5NGoQVk1WmZ9oChcTE1TvxLj3rLja2yz08=; h=Subject:To:From:Date:From:Subject; b=KNoZWbuHOAipRGhSjUjn4DUxT/S62OmyS8l4CoreVL6+a+b0DlhOeVL+g2YMu34wpZABVXjuufy6SVfqJjtCatMZU0oOdEXt9E6JF0I2YZwOq1NIqXVP/5sDWnKrvrlypxRiMTzOQW/TRzKDdkqaTuq0WknYs2xrxq7yS0g7pqFER5h0BOrUmBmep1dhD1/F10nV4b1N5NIHaVNccf5FUthy31WhdGeS5y+3qT6yMhAo2TnrYBif10aqFlgxFcB20i6u7tOn8qJlWNvcAegvZKMmb+3xaPXDlBPkALDafXhwqffjmbsojk873ezRPrbTrnl62CaTF7JtSOa0Y31waw==
X-YMail-OSG: sRs4y38VM1mRW3YnBTYE_ly698lqP95MB16cRGP8gcvDGVCDTttUpoFw2R1oFh2
 .SHX7f1fX.CL_UoHM_Z6LQzuhsdbWvrdMeK3iWYIkzVkbfHWZXsEs2Uta2gYKZLqnW956ckfFDZF
 RliKTm9ebNiMm1DvhJuzcH9qoLILVSCAejS2U.aypuFUm_aBYVLYw.wk55IHU7bRfTuUFa0.Cmfr
 tShoatlgvc4MzhLhF99PFWH1ZSdL2of5Wg4AiVutkZn.xybE9pJC3lM2MSazXyofuEL.9svj7RrK
 DVK.ABKMd2Xa65xlPm2EtI7g5t5khimheszzxQpSfZeFcZCm3HZksO4haNO0WoWqnvnK8Ek5.mPY
 e07TLPzKwk9qXLSw.DaKATKDjeln63L04NJRADp.xOBbzuNd2L.hEFyGvEb1kAMKNUyndWw0d.ao
 VscHfzbbu0nJnPTFsQHh.Bb09G1_QKEuvSPBHc0IDRMuUgOF68RUgI0qBpnk4nLQyuDFfnFgqej.
 bBPToRH0bo0lb1ZR0nIOzv6UtVorCKhXk.6SAXAeNAljT9Re5H_CjzIkiiuJcjtfR.ypya6XgS.2
 KJX7p93LfwMPJ6J4abU_kLBilK5SK.SGd2Xryjz8w2HgRjUrjMQ2SttunPW9iPn5CYV9L0h6f.y1
 XFlTA9oSMgQnh3HraAlUzc7_uVuhYkF3By7UVkM3Z0UZdRIkrQ_h5bR5ETenuQQYPtegs35JIT.g
 TP7re8h53cb1oG_LD8D9K8WOF2uj6dHQ1SviMfXCRadz_rJDRT1f_t_ukUIPv3l8RRedILRtMNzH
 ESC4U_5jrzAy5hQDWTPXvGLHuEBLxBbdSFLRPZYoWgFgq3xBfZAybbM0PrxEIwDUGCb9MwSh74re
 la.79I2cFGJb5ls.VRa8y2j9v_9qf9mPOcY5vrzD8XcWeEpqhDaH4xWdLSrW9q8W.B9euLuufSBz
 P.WRbnlJ6rNRO0Qw7wqG8cMG7Zf2pWfWVwzr6GMqlozD7DgGePEHh_kpuf0u1VC0XjXktWNN41Ql
 ksuPoI_yiah.hJ8DU5PaZhP6huRweMO8qJbBtHgRjPE503LhzTE0udXZvmGGne7_8_XixJfmCZ6z
 JQ8jsNh06YpsTHHTRbAwBe11wtE23ONeYKSWt1yw3428Zt3ln3FcyZaUAQ_kP89kIUL0SfKtsFZq
 BdjbvCSgw1RPKrXBEEEhKsaOc02q32eDXs_41qt2nfhUy3Hc1BUMQIuGcvPOJat5Z7rRsIN7GfDh
 S0gVi1QMEjR3RAwjFJwGB_fMrolpApcWX0RORxj1Fu2G6VktfGhTlca8qyE6JomcN2lHz3_lMZZ5
 Za4A4qsamxPX0M5KxgWc1sA4n1hkjaakdoPlzVKBZbAmPTV_9HUStlCIcD1upc.3X3gsklR0TFPb
 RDjI1rdJyC7TrwKTJUetGhyWRQHOXRts3bCK21rwjmXyNUYOTw6qN_oepMCkB7DmylACdRSnL_WY
 NFq9ecj5JU6Klimtr1cWGnMLZ2K8kR7cX1uzfMEimFd_ed8BgTk7KmLDy3Xq_IaJlJ5TJKwG23Qc
 ZsiDBoGlaieN5BoHfpMtsrOa1bj5vqUyg4QX72UzklRc12BoHvX0V1qbzDD8IbOFgm.oXkAWEdPj
 t25dOaFqlj3PjgBNBOX9qi8GG4KosPWG3wnb58ovDYMk4pajqvjkGMDG1B750Jg2ksXATj8vym4Y
 k6AYb.qG.mLnIpvYdFmqw9RuWYKpaiVYqaA.lKy1QMmE4ItWLUnNGKXumI3mCeWnXZd7B4uLGgTR
 CFpbFOsRU.0YonG1Gc1rWV3jS3ey0fR6SAjvb9bLMwqQNM7AMjgLSVXWgP2w.gSqwZaR5i6_xwUU
 Bnjx0Z_zxnFGggFe4.0D3je8XNVs3H48yuejaZXuCVafNsaiXPzS2o7q6ly08aisFoFJSvNpDaCc
 OCY.X7hZ7Lv_UPZv_KJRkE1sasm5VGXsj08QutRtHjWcOljgnMydSBPxIxMbsgI6YEDu3i2usvUA
 PvYqFo_BYf5MsnpHNB0PvufRSASRyLrjQcXRZOaaoLZeHdky371DnBRIK7iDLBOGXrc5NrNLHg5B
 _Z.fptUGDIYTJBO7iXxoonvQBrWyoo4VoSP4SkEn6ReUggrhw_srwD2jjZK3jMGL0DMOPYuH7wTJ
 ZU6jtM4ytMgEYhCrz1Y.ZvwWkJ9.JJUSF5DUOm4Et8_nAY5XYK0bE_0Ju3H2KW45oopVKe7pgsML
 fjDNVRkeNxr36kYng7HYWz6CODAT4CKJ1fI2FPwHyyhSqlgA2oqKJgnIa6DC.d.sgN3wEtidxDPy
 6W2dQtnFYJnz9oaNRWmZ7XHh_rEjYCYDI6Jq1m2yFEjmQoaG0gGR1EPjmSzvRKXCKw6lOK2uVtmo
 VJCpdAsQmOz7b9ldzV.0LQfySxcds9VJZxF1ksPOR8ims9wkHr6_.wsS_AiQZIHMkQsIoyKO695G
 xsNVzUKu9b6x8yedqVjlvecCAJvvANuu5A29yVIkI1fTNHoyH6N3jNpl1mcpbn2JIw9N69hGcXD7
 eV6bBAoKzghkLkQ93FCIblrcSZoSmxLr6KvlHQ6cKYdoXXE_hWj5XQtJW5tHUsmxJwVScdn9r_0t
 ODjMDlRW48G8Oo7A0Iv37IZqHkvAcX18FPZYZwa.xzOfEsML63R_sR0qcGS2600Y2XRU8Q01sMj0
 vpjvxwHmL0H2hENVF1KvayUPsFbTROuhijndpNhAZOweZdupG5voommHMBzWtDldYqygTdJS2eLt
 VwlS2B1MVp761FrH.vF4tXEbkK0_YdPBk262jAPBCMhgp1wmcem1OmalbL_1vSXTSFakSyvW.Ekx
 5Ev5hKE0dvl18yPgQbXXZmhojvnWEC5GbP.7sgUbXZvhgJunyixHsgukVJMDGpvrztMU6iDQ4exN
 vRbJS4v0uLpFVJ_BZMK5Rifo7GIaXI4E5ja.YVD_oX5a5EY6a7AeJpPeplOVP911G_6h1TIZrERJ
 qSexicQLS1c9aAUO5B9amv4OE7dX5o5pIjPhit2YtH.mRxtbgjeBaNFTlT63lsvWYo5Je4vFLVE4
 PtR_6ccO3AsDyjQ.Riz5jLr4.1UBnuaQLpsVu4Ehp03wCrDgTEB23A5N22J2lR7dcEWIkKq8V.de
 rCEpzsqtz4jKXOhnpCLU5YdavQLmGvgvmIjHbnLmQkEXs9WI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Dec 2020 23:20:13 +0000
Received: by smtp413.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID be356aea687687c8383fffc0d92d3664;
          Mon, 28 Dec 2020 23:20:11 +0000 (UTC)
Subject: Re: [PATCH v23 02/23] LSM: Create and manage the lsmblob data
 structure.
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201120201507.11993-1-casey@schaufler-ca.com>
 <20201120201507.11993-3-casey@schaufler-ca.com>
 <b0e154a0db21fcb42303c7549fd44135e571ab00.camel@linux.ibm.com>
 <886fcd04-6a08-d78c-dc82-301c991e5ad8@schaufler-ca.com>
 <07784164969d0c31debd9defaedb46d89409ad78.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
Date:   Mon, 28 Dec 2020 15:20:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <07784164969d0c31debd9defaedb46d89409ad78.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/2020 2:14 PM, Mimi Zohar wrote:
> On Mon, 2020-12-28 at 12:06 -0800, Casey Schaufler wrote:
>> On 12/28/2020 11:24 AM, Mimi Zohar wrote:
>>> Hi Casey,
>>>
>>> On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 5da8b3643680..d01363cb0082 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>>
>>>> @@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *key,=
 char **_buffer)
>>>>
>>>>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void=
 **lsmrule)
>>>>  {
>>>> -       return call_int_hook(audit_rule_init, 0, field, op, rulestr,=
 lsmrule);
>>>> +       struct security_hook_list *hp;
>>>> +       bool one_is_good =3D false;
>>>> +       int rc =3D 0;
>>>> +       int trc;
>>>> +
>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_ini=
t, list) {
>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=
=3D lsm_slot))
>>>> +                       continue;
>>>> +               trc =3D hp->hook.audit_rule_init(field, op, rulestr,=

>>>> +                                              &lsmrule[hp->lsmid->s=
lot]);
>>>> +               if (trc =3D=3D 0)
>>>> +                       one_is_good =3D true;
>>>> +               else
>>>> +                       rc =3D trc;
>>>> +       }
>>>> +       if (one_is_good)
>>>> +               return 0;
>>>> +       return rc;
>>>>  }
>>> So the same string may be defined by multiple LSMs.
>> Yes. Any legal AppArmor label would also be a legal Smack label.
>>
>>>>  int security_audit_rule_known(struct audit_krule *krule)
>>>> @@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit_k=
rule *krule)
>>>>         return call_int_hook(audit_rule_known, 0, krule);
>>>>  }
>>>>
>>>> -void security_audit_rule_free(void *lsmrule)
>>>> +void security_audit_rule_free(void **lsmrule)
>>>>  {
>>>> -       call_void_hook(audit_rule_free, lsmrule);
>>>> +       struct security_hook_list *hp;
>>>> +
>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_fre=
e, list) {
>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=
=3D lsm_slot))
>>>> +                       continue;
>>>> +               hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
>>>> +       }
>>>>  }
>>>>
>>> If one LSM frees the string, then the string is deleted from all LSMs=
=2E=20
>>> I don't understand how this safe.
>> The audit system doesn't have a way to specify which LSM
>> a watched label is associated with. Even if we added one,
>> we'd still have to address the current behavior. Assigning
>> the watch to all modules means that seeing the string
>> in any module is sufficient to generate the event.
> I originally thought loading a new LSM policy could not delete existing=

> LSM labels, but that isn't true.  If LSM labels can come and go based
> on policy, with this code, could loading a new policy for one LSM
> result in deleting labels of another LSM?

No. I could imagine a situation where changing policy on
a system where audit rules have been set could result in
confusion, but that would be true in the single LSM case.
It would require that secids used in the old policy be
used for different labels in the new policy. That would
not be sane behavior. I know it's impossible for Smack.

This is one of the reasons I'm switching from a single secid
to a collection of secids. You don't want unnatural behavior
of one LSM to impact the behavior of another.


>
>>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *l=
smrule)
>>>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void **=
lsmrule)
>>>>  {
>>>> -       return call_int_hook(audit_rule_match, 0, secid, field, op, =
lsmrule);
>>>> +       struct security_hook_list *hp;
>>>> +       int rc;
>>>> +
>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_mat=
ch, list) {
>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >=
=3D lsm_slot))
>>>> +                       continue;
>>>> +               rc =3D hp->hook.audit_rule_match(secid, field, op,
>>>> +                                              &lsmrule[hp->lsmid->s=
lot]);
>>>> +               if (rc)
>>>> +                       return rc;
>>> Suppose that there is an IMA dont_measure or dont_appraise rule, if o=
ne
>>> LSM matches, then this returns true, causing any measurement or
>>> integrity verification to be skipped.
>> Yes, that is correct. Like the audit system, you're doing a string bas=
ed
>> lookup, which pretty well has to work this way. I have proposed compou=
nd
>> label specifications in the past, but even if we accepted something li=
ke
>> "apparmor=3Ddates,selinux=3Dfigs" we'd still have to be compatible wit=
h the
>> old style inputs.
>>
>>> Sample policy rules:
>>> dont_measure obj_type=3Dfoo_log
>>> dont_appraise obj_type=3Dfoo_log
> IMA could extend the existing policy rules like "lsm=3D[selinux] |
> [smack] | [apparmor]", but that assumes that the underlying
> infrastructure supports it.

Yes, but you would still need rational behavior in the
case where someone has old IMA policy rules.

>
>>> Are there any plans to prevent label collisions or at least notify of=
 a
>>> label collision?
>> What would that look like? You can't say that Smack isn't allowed
>> to use valid AppArmor labels. How would Smack know? If the label is
>> valid to both, how would you decide which LSM gets to use it?
> As this is a runtime issue, when loading a new policy at least flag the=

> collision.  When removing the label, when it is defined by multiple
> LSMs, at least flag the removal.

To what end would the collision be flagged? What would you do with
the information?

>
>>>> +       }
>>>> +       return 0;
>>>>  }
>>>>  #endif /* CONFIG_AUDIT */

