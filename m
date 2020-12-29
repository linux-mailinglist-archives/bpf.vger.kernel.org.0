Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642552E730F
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgL2SrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 13:47:17 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:39250
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgL2SrN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Dec 2020 13:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609267586; bh=9h7Axp3xeVm3VZf4yww39KKXLiv95KOz7Sm+1nzDPBo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=F/NUUkqfAQUxI/ecj9McWy1DpYZjnL0Itnz/2ZMJLBrGHuubMcoe8LUHW1j2S8Lh57zpk5IyjWiaxDtACg932W5DlCwj8J+HRlEEaVwDDyTW2omGvoYgsjyw0gakHAWBiHNOjaF9pgkrVGiaB0GbzTg4LWL49Gro776K0ftBjsE3rceuudo413vYJnz9AJM5ehxJUAD6YPl7GWPO+F9GVlZFznZW3jlHDWb8dwiWAAeemWDv4Imf9qq6mAWjzh4tW9pErxkQdSZlgE94YDRurSbz0H8GhJYkAH6ioL9a+A0nJh3+Qkn8kDR0IQ1VeGwSdjBqofIszASGKzO06TwznQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609267586; bh=0k2eQPy+Wl8A6fedCgrE9BQisF8wHqpc9W3iu+Jrzmz=; h=Subject:To:From:Date:From:Subject; b=CzWl883ZmC/kPUUajWnMzsAYzpBRGB4CcRWclKSTDFdl4FrNrEbYhSLtP1VoRVxjr2kfNnMWdrNAMT2P1THIi2Zom07lU2ImVkIRkFhUAXIi8wSd5fiyTLHMqrx1MYcknDzoKcHITTM3UJFTey6pm5UEmRSRb72vzF3qS1vV6GJEB76EvYJI4koVGUgAwJq6HcVvwQkBCInEVS0Udt/JakWZxpLsUhWDWh8GH36XEvOYAZ1FftZy+GN8DSGJEKQTahrrsDH4wBHuMU8J29A5nFDpQrHwLFpVqpHBvMlsUQpglDb/fPP2/q8DmUw44A55XO1XTTlQcKSCyruFt+gsnA==
X-YMail-OSG: HHq2XCkVM1lJ4Jo1k7ADTmQYnIGeYiQeeCwq9sCu_FX30cfAqDA1y6HuQQwHF6F
 S_EGvMUY4xE4XAIkbPLU9wtgjuAzQZIkjpE08LMZ6XZiidsPwj8faG2AxBz3XME6Jk2fZ6MWYQeh
 ns0Q_5ou2ODxJ3oCBGA2WKNSPCmcTrUL1JAqDomPwLYSduOEHfic5yfPmAgVHyGfEMWlgftrPxZ2
 7Wke4LEznfd7kjVRO8hhE0LNkHAebnkS9oRpYXpLBDNiUukwNUK4SQF10fZ56_CCxjfGlX2fdlTK
 NQfa1LpeSeQBwzhf5yyDXZx7efQ8Iq155BVvPnwCUJ2.xjkGFm37odO0LiYhajRSfLbKzBkOiAVs
 c6eHSoZ8KKD4hEqRD9h_RFJr8uJ5ORHwy8ofrR.jeKpms3G1I2gOZ9FE.SAf8CNmakJAOB6pQwzx
 lAuVJ5L50.R0JkBmBzWQQjwcjBn.JL4cjKuOr6uyYvn3RWsnYYEjkIuftzrFdOG07dJZ3AJxLmi6
 m4x8egoBWsn9LF06KLREJeRqKW5FJFDj5OtlyA9P27SDjIsP_04HahCdkkTSB2cB9OTV7zKrwTF6
 Sihr5p2XvftPkJ.sHbq7kxvz1Ue6.woETuNaHoUV7GrQs2sdbshY9xLyYoWObG9KYGEouGjUKn16
 XIQ6SvtDzSJhAOIuB2cHmRbX.2w00J0POVK9nmOqvA5jORXv31UpbuVHPOaR8EcSUhyGKP37.ybq
 sH_UeW0LUuaExH0g0dV8qKmr5s_mL.N.bjH7YLUZx2JRXsNvtWTZQHhpBmNluI2ajonlhXrjt_sR
 KqHV.6gErqiONhRf4rgs9yrrLVjXM4kRsabBU9t4Nbf23HLgHZxBCnFd.o1Ns2EsRRh79wkbFcTZ
 Q1wIOXsxoyqX0YgjOp7aN9eF79OmDnBNaH9EqqZsn2s2_K3tTvf7mZeqSHAH_h_tIf_kfyu.LcXh
 kMUFJEIOzhFirlDbi0yNsLvKyLeXQiuGrfmOumxrOpIDJ_L4CjeZH34_.AsFrYYnu0jgdVheQ7z8
 6SFscuIEC8bcKHd3tL6sAdrh5fuxCfUI96Nfnl7XnlpoNKl3hh8bPIhhWo_uS7Wbp4R_KPn.ukB5
 OL4HuJdN7pLv8PedQKugxWE8mCIUDhb3uMJ1LrWGheHqmklkEubhjz.hhQ64p.Lm_RpS21JRJzxZ
 A6drZ_q8_mUUfEZhbgNN1fL.4.Pv7uBEVw5Hdr5XgjBMYRu5t4ItEjHb3xpJXhBf4w.FBr7mXEYX
 7xzZCV08l.Nx6qAXI4_15WlWKEWA7J7Anj_N19qzlK9jnbHjzKmzT7D.d3_zvSWoydy.j76SHm6D
 XLqRdCpnUtDgfZM6ekIky39F0S7uVSLDjfr8aNROgEYk2GlMTMkpI5K.p3Qk.rFFe7lLl7mtFGVw
 8d9TTAf0l2mmQjZSRVeLheE7Wqly0sg9MTdQvZ8Dyl8VBfG1Pkp83CK_iYy97pMOEs3.3Vo0pg67
 Jyc9h3hrPf3g4FbViX8W3kF4DsV6LtIdSRK8Cozw_exGhV52SrghSIPRdb0HyL__BVPq9n63izfT
 ZfsCuiOSlTfM_Hvgx46PBwD6bF1D..6esbb.NQZPKOiL0kdXlUFwht7ZtAEWXWKkY0Olk5YSg1k1
 eNNTOS3fyzOb_2zo5h6cxq.D_wJT0q1D9_MmglXc7Ctu67iRl_6AoP9s_fSGXXQcH306Iqt7NgS8
 eJVUstELwIOnsgUAFDGTdZOLf7Q40JNa8SKPUntMWQX10l8k5XkIGu0TCkA.Wz5jhBMIPqTK3znb
 GZ6owjOqkPMAaDNt_6uUQmricLBw0_YBagSECs4v3tNlmeKWxt_Zt2IYa9wMyssTZIRyGdI2_jAq
 mzDqhf76HGEN6HKQtM5PnX5fxPg3RqvcF2X8Bie2DOzE9xCFGy9T9by7Du5lWRq94_CiPK9ZwTu6
 IRFWrYyJFYMgd.2_K3CiES._Rmn1OjKJNYARlOSCMwIViDbn.oG9g.TUaGO0xAt6GRb2xTCbj4cD
 gUED0JMCOFg8iY86QbL4o3gNU6ZxNTMPip2kMfQlYM5oDNdzJPJsVILJgMB3yDKhxAU3WdjmIfHB
 pmeFDueNign.xTFPoECFoOKJEkQPU..CzQaTChtO7BMYHnEyaMxl9gHPTfEfctphOaqgOVJ2uRE6
 s3vO1Qgq5s0NJBjoU6mf66C0J5SNU3ZqIeoMzfQqS7HiiqZlTB6k7godcsnr0vN4KuNqt5UP3thk
 nwcQp2o0qW8E1T6LpEI8K25IiDj19SoSAW8pT5A.z.34RBnhb078hfPpwBPYyHo4AFSatla0DesN
 AlJfho0WHT3fuLax1Q8brgKMyOj8snCHpYI.LtIJH3k.OLDDoElVzu6cTOg0rm6bX7ELzEbJhNHD
 d1ncWjCK6_vJ4NkmW61jOOEvx4d8whR0IX6zgYsqhPGlAA4GxOs6mf53bfa807ZEaAkbLRCI3FzT
 7bBGbEmYXtlTDPE5pk6KPhQqnwScEiqM2MXnT2hAjkHEt6pp7RF0v3JBlEOEp1g2qfrCvhY4XRQp
 PPXCyh4z_V4z4ktWSdJOjmOccCE.Hi76WVDBPqrQqyh8dSS0gnXEuqyEPTr8Gqoslm7U6eKVL1pE
 qZfgfPYtsyDGp2dBNxV_6xBxvMd0m.aPgMJHKNEJSU05tLiLyFz_PvhCObct91YyryPGtgfvPvaQ
 v._jX0bkf7gzAoIpcfBLHKZm5QNmvp71WbZucokB0YUqiGBbnnusD6ZyqIvWR4zo0lELLwzLQ.dj
 Hpu5G8oNn12vi7h4l6XTEjWYTEZm.WRRlZk7vMLdMD0lu2.gG3YKcO4ap_mdldOJ5bSZYm3ul5Yg
 lfPGLq3Wz90ckC3zWFv5kC9708vvGjdSTSwjnJ.C3IcM923uo2XBmJqkHLEa94NdPonynGkHk1cl
 NO6xMVzWptPujGoO8eHZGmlfHNKY1w2KQkZcTLSpG1kmgbclHX_8OD6984LrwJVBNDhAvOmC_8Fu
 UDeZiFig39_74qAkUNDNETdD7haQgsSeV6obf1o96ZdDhfX9800M8wcjBiiN7wYO.jH3OfPR.WMs
 b642TVw9fpsRrWRFqmGAS0HmJbAG5F0sRERjRZHgMHn1uO5ltZN1bNI8hN79c77hk2JiHp76.dbp
 6nqaM4VyLpXxTwwNRsRdJd2BoxL.lbCGJhNY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Dec 2020 18:46:26 +0000
Received: by smtp413.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ed250a7138f96ccb37d03a31fdb1f256;
          Tue, 29 Dec 2020 18:46:21 +0000 (UTC)
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
 <8f11964c-fa7e-21d1-ea60-7d918cfaabe0@schaufler-ca.com>
 <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <10442dd5-f16e-3ca4-c233-7394a11cbbad@schaufler-ca.com>
Date:   Tue, 29 Dec 2020 10:46:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e260e8c5bbbb488052cbe1f5b528d43461bc4258.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/2020 5:53 PM, Mimi Zohar wrote:
> On Mon, 2020-12-28 at 15:20 -0800, Casey Schaufler wrote:
>> On 12/28/2020 2:14 PM, Mimi Zohar wrote:
>>> On Mon, 2020-12-28 at 12:06 -0800, Casey Schaufler wrote:
>>>> On 12/28/2020 11:24 AM, Mimi Zohar wrote:
>>>>> Hi Casey,
>>>>>
>>>>> On Fri, 2020-11-20 at 12:14 -0800, Casey Schaufler wrote:
>>>>>> diff --git a/security/security.c b/security/security.c
>>>>>> index 5da8b3643680..d01363cb0082 100644
>>>>>> --- a/security/security.c
>>>>>> +++ b/security/security.c
>>>>>>
>>>>>> @@ -2510,7 +2526,24 @@ int security_key_getsecurity(struct key *ke=
y, char **_buffer)
>>>>>>
>>>>>>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, vo=
id **lsmrule)
>>>>>>  {
>>>>>> -       return call_int_hook(audit_rule_init, 0, field, op, rulest=
r, lsmrule);
>>>>>> +       struct security_hook_list *hp;
>>>>>> +       bool one_is_good =3D false;
>>>>>> +       int rc =3D 0;
>>>>>> +       int trc;
>>>>>> +
>>>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_i=
nit, list) {
>>>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot=
 >=3D lsm_slot))
>>>>>> +                       continue;
>>>>>> +               trc =3D hp->hook.audit_rule_init(field, op, rulest=
r,
>>>>>> +                                              &lsmrule[hp->lsmid-=
>slot]);
>>>>>> +               if (trc =3D=3D 0)
>>>>>> +                       one_is_good =3D true;
>>>>>> +               else
>>>>>> +                       rc =3D trc;
>>>>>> +       }
>>>>>> +       if (one_is_good)
>>>>>> +               return 0;
>>>>>> +       return rc;
>>>>>>  }
>>>>> So the same string may be defined by multiple LSMs.
>>>> Yes. Any legal AppArmor label would also be a legal Smack label.
>>>>
>>>>>>  int security_audit_rule_known(struct audit_krule *krule)
>>>>>> @@ -2518,14 +2551,31 @@ int security_audit_rule_known(struct audit=
_krule *krule)
>>>>>>         return call_int_hook(audit_rule_known, 0, krule);
>>>>>>  }
>>>>>>
>>>>>> -void security_audit_rule_free(void *lsmrule)
>>>>>> +void security_audit_rule_free(void **lsmrule)
>>>>>>  {
>>>>>> -       call_void_hook(audit_rule_free, lsmrule);
>>>>>> +       struct security_hook_list *hp;
>>>>>> +
>>>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_f=
ree, list) {
>>>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot=
 >=3D lsm_slot))
>>>>>> +                       continue;
>>>>>> +               hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot])=
;
>>>>>> +       }
>>>>>>  }
>>>>>>
>>>>> If one LSM frees the string, then the string is deleted from all LS=
Ms.=20
>>>>> I don't understand how this safe.
>>>> The audit system doesn't have a way to specify which LSM
>>>> a watched label is associated with. Even if we added one,
>>>> we'd still have to address the current behavior. Assigning
>>>> the watch to all modules means that seeing the string
>>>> in any module is sufficient to generate the event.
>>> I originally thought loading a new LSM policy could not delete existi=
ng
>>> LSM labels, but that isn't true.  If LSM labels can come and go based=

>>> on policy, with this code, could loading a new policy for one LSM
>>> result in deleting labels of another LSM?
>> No. I could imagine a situation where changing policy on
>> a system where audit rules have been set could result in
>> confusion, but that would be true in the single LSM case.
>> It would require that secids used in the old policy be
>> used for different labels in the new policy. That would
>> not be sane behavior. I know it's impossible for Smack.
>>
>> This is one of the reasons I'm switching from a single secid
>> to a collection of secids. You don't want unnatural behavior
>> of one LSM to impact the behavior of another.
>>
>>
>>>>>> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void =
*lsmrule)
>>>>>> +int security_audit_rule_match(u32 secid, u32 field, u32 op, void =
**lsmrule)
>>>>>>  {
>>>>>> -       return call_int_hook(audit_rule_match, 0, secid, field, op=
, lsmrule);
>>>>>> +       struct security_hook_list *hp;
>>>>>> +       int rc;
>>>>>> +
>>>>>> +       hlist_for_each_entry(hp, &security_hook_heads.audit_rule_m=
atch, list) {
>>>>>> +               if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot=
 >=3D lsm_slot))
>>>>>> +                       continue;
>>>>>> +               rc =3D hp->hook.audit_rule_match(secid, field, op,=

>>>>>> +                                              &lsmrule[hp->lsmid-=
>slot]);
>>>>>> +               if (rc)
>>>>>> +                       return rc;
>>>>> Suppose that there is an IMA dont_measure or dont_appraise rule, if=
 one
>>>>> LSM matches, then this returns true, causing any measurement or
>>>>> integrity verification to be skipped.
>>>> Yes, that is correct. Like the audit system, you're doing a string b=
ased
>>>> lookup, which pretty well has to work this way. I have proposed comp=
ound
>>>> label specifications in the past, but even if we accepted something =
like
>>>> "apparmor=3Ddates,selinux=3Dfigs" we'd still have to be compatible w=
ith the
>>>> old style inputs.
>>>>
>>>>> Sample policy rules:
>>>>> dont_measure obj_type=3Dfoo_log
>>>>> dont_appraise obj_type=3Dfoo_log
>>> IMA could extend the existing policy rules like "lsm=3D[selinux] |
>>> [smack] | [apparmor]", but that assumes that the underlying
>>> infrastructure supports it.
>> Yes, but you would still need rational behavior in the
>> case where someone has old IMA policy rules.
> From an IMA perspective, allowing multiple LSMs to define the same
> policy label is worse than requiring the label be constrained to a
> particular LSM.

Just to be sure we're talking about the same thing,
the case I'm referring to is something like a file with
two extended attributes:

	security.apparmor MacAndCheese
	security.SMACK64 MacAndCheese

and an IMA rule that says

	dont_measure obj_type=3DMacAndCheese

In this case the dont_measure will be applied to both.
On the other hand,

	security.apparmor MacAndCheese
	security.SMACK64 FranksAndBeans

would also apply the rule to both, which is not
what you want. Unfortunately, there is no way to
differentiate which LSM hit the rule.

So now I'm a little confused. The case where both LSMs
use the same label looks like it works right, where the
case where they're different doesn't.

I'm beginning to think that identifying which LSMs matched
a rule (it may be none, either or both) is the right solution.
I don't think that audit is as sensitive to this.


>
>>>>> Are there any plans to prevent label collisions or at least notify =
of a
>>>>> label collision?
>>>> What would that look like? You can't say that Smack isn't allowed
>>>> to use valid AppArmor labels. How would Smack know? If the label is
>>>> valid to both, how would you decide which LSM gets to use it?
> Unfortunately, unless audit supports per LSM labels, the infrastructure=

> needs to detect and prevent the label collision.

That would be a massive performance hit.

>
>>> As this is a runtime issue, when loading a new policy at least flag t=
he
>>> collision.  When removing the label, when it is defined by multiple
>>> LSMs, at least flag the removal.
>> To what end would the collision be flagged? What would you do with
>> the information?
> LSM label collision is probably an example of kernel integrity critical=

> data (yet to be upstreamed).
>
>>>>>> +       }
>>>>>> +       return 0;
>>>>>>  }
>>>>>>  #endif /* CONFIG_AUDIT */
>

