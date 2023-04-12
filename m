Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9696DFDF0
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDLSuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDLSuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 14:50:55 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE80526E
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681325446; bh=BgOuKCF/kmf1/gUiUuSyZzC4fie431t5QX5kTu/yImw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fq7pPLcHvEzWYWlxneN5C/FgzczQFwL97tEX9DfqGcJAw0OXXahNFQy5HeYVGkFXyLxS4T/lWAi2olttBcr2MdxZiwnkw82K54G2VCXdXCj76PkEWOa/9YcLVGNIG8m9SyZ3BOClkbajDY03ZFIqUAHGfJ1M5TM2zE1ugVJOyOO0GKJZ7mRaXBRPSCIyFW+6vSQ8GKEiN3PWBcZUGLngJj8agctiId0c0v4lfW5Lce3ySycbLrW6LiFC5VSQKMgWQSGZM3BM+aC9GkQ3I8Hde3LGXasQXC8eHwfUOFlMAu9IJhsQkq1TNGqwZjpmHxFpxzZfPse3KO757Mq2teZ+sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681325446; bh=PMso4qki4Kz0znKE33xH/L0NT0nMjfbxhwbGPLIoLkl=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nAh8Q6AUkC5cCjzGnT175iMhl7C4Y7D95mnrK18NMEPTgaRsReFbqCxeeaN5C4RkEnjOa7LOoXvFYqmJzJxOEiOn2W8U9iEOnKtpJi8LnOKzwebDgksBxv3+NwDhnCFS9yRKLC+FbaGY3RNF0cuyvYSdzXouYH5wq9XDghZWhQKdOsD7zxD00qGK52fsq0jpPdCeSZrMLuqonef5Y8qf1xzWQuPYZz3xbtBinHDCTuDjLcrx0EgyMGaD15YJcIqEWGdvHktB1YHwVGz8q5G2xssHrVDtn7wH5+NsG07dqc2bDmhbNIxKQdl26LfNm9/t39BplzlMq5tPE5XOnDirrA==
X-YMail-OSG: 51lc1jkVM1ksYEIkd5NPq6A27qvdiLWHDrVdOsPrdAxwbiBrdc7KOQv_ingBk0j
 13LfZU5iIMh28mvgi5s_CaTOpmkdKiZ7WgTjJZoY9nsy8M5ngnIcI7g7M5LU2hv5q3nKmGaYMtR4
 Rv4_c1RcY57EzO87wniMlX5JLmdC5Ffk0uFa1OoPTdhTw14eJ6fMEciilKyVC6M17yc5lPohFLjq
 lVbVO3ShsWEqvd_sU_9hnRhN7Kiis0Z9rkz3QGK2ef.V1Es5uoWRNNHlVpwhkPmG2oPd4ydA8cHe
 IiRvzJAIDiEFpDmQrYCvuMaK8xhQg5aLDnQMmujROkYFbI8MXN.w6D1pi1qQM16B7.IdIuMsG9tC
 SAXGjkDkCus1XAwiGqHd5rJnDWuiIRsHCL8ZKtosJ8tBowSGQmd8J6iujZE35Q9Luo3b005UW9sv
 nI.2RqKP8f1Xx7nuyewlzhxsWkVaGCoXLKJSVgwvC4WLd9gD7lMQ0ISyk.v8Y1BJeYdQ0vYKj.1r
 8znm18lexsY6Ioy1tjYeGLoPMpz5LVOZtiZFqi1eYMR2DaxEBtHwBoJ9TfqNRYrMVlYB0uuZl1ii
 QjCLJBYuxqe77VQ.tOHhYq0PK_8j1SCDzmcD3TXv7B7eC5qucg27FiZEd97BEZSAB9YHUfQAxiuH
 8G9hGB1Kv3Ut3OG43vzOeFcXuO0ROPJhBacwyKGw3ZWXcMTU8fPKTeRoR6sLulWjbfMlsCk6wUm2
 HBGSc5KtbNKQZiKIHScTxYEdiIPKwbFBN336.V6Ksqr1ueCl8rg22JfOEV0fMlN9mpUHQ_lKN3mc
 _mrQ16pfFZDHzEUF8VQ1EoAYpXKOfapzeqRd0.qq01Fs99g5bhrgFqC2SOxYGd1wtVu1jX_562IZ
 s4xeJTTI7p3GlFafvYl0p8v93FXfhkYojSa0__0l6.AJODVaILIwXrsVFEMRJkvrWg6AALz.t1qH
 5NDWTq.XZaK_O1JsSmCjcB6B_978aJaiPHAv6bZs6FfQSGNgprRP.XfCH4cu_73hucqHBzW.gacT
 vc1KkENbJFJPL_Fk_s.zlHFb6.1f_4aXLDVnb6a5U9CaOIB8bLV.WjATplOiCSPKjytB_anQP5rl
 eQowQt66ubyFqEW34RGulHoUC8WQWyTy_B1t0a.C1TzLOHMEU2tmUlW4GKog6mbgowiJh7oh_8__
 16zDy6b88.Exv6DfZZMg4DNOR8dFpgryT32.Egg.UMCVGMnwZVCzyQIlvnsGnnZccBxz.pOd2PJp
 844NoWJVtZSMwVX1lFWuGzwFJY39i5z28iEZCPyVc2nKVfapg9hI8kRFF6vVsSyr1whdJcz7hJWi
 _XLDaaagDHkfR.NLZpUleCt7UWO2KaAIYS9aAmxsgO5tdej_WcY90fKuN6GECWkoxZ9Gd0Y1D40u
 Oao2ETPLb1AtVw0h2CiANuARxK3bTL2uOyChG68jUMyxkIcyrEM_Y8lhC0t9l8xta8zfFCnMU3wo
 Nv1d3094hA9PMJ8c4KfaaDzD7bEZxaIC.N5GjvyLjg4.rNy6fnyH1e5EzTbsZeHqy.OGOFz84cRo
 aWyVeAXTGVM7FstZkGGbNDgZAokAGGGv3SA_o.emt72vNEvzFOhoWoUwgstSUvDjcNuRrafXFLTp
 QpWHGjcn_Qvb5dx3DJ4ONnoVSg7A5UXo9T7aqhJdMN9zkRctz_M_yAv1aQYXkA83kupfi7oiwP4L
 f8cqua6n.wi5.zViyuGNnJ4sl0QJ8uFtJkL2gM5iw0OGLu9InKeOeDC7MslZK.jMgDwJfSnb0.P7
 v5V26f9Fwq7DxtEikJIDyNbXCSZpLUqGnVs5hMsSw7yFzkPgyNzmoIaqKsE4AfrmpleuVYiYPfTg
 05uQCf_AOw3QEkqgXG2ggAuacBQmytTVavZDGEt_evjYdPc00Td6r7Zk7AUXj_oBqn9SqXvWgx0U
 iS_F.5ynjr1G4hD7wDGwT_4HpOBY2gyBAzqypgFUBnI.cz4eriWE_iGdCLvaMvPkOpr3yWDluLgp
 4.cnquxPfHHzVmtBJHD_ASWDvzPQbRqzPj6xzWb9xc8QeYEvDoZA8kb6qi1K.MjMOq1UJ2XG0m_.
 o.cWNyghkvQvHPk.Choapw8O_LQSWfHwMKiLr.8oKZxLT7kSl1XaDcsty4JC3PCH3MQOdzmcp97J
 SFdF.kQotggK_W1Kropw.C1B8cuQxqJHl6nhkhXcubO0x2OapHLXxlM3VOz9osdiuAfl9A4.Jutz
 _8GFfN_qc1eKBHO.HHFHkMkb8M3jhcB_Yt11g3cC8QEoNlxfaGPrxANQna5nJc7FclxVNydJ6BrB
 HKVs.b8YMMIs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 43dc0c8d-dfc9-412f-9070-1fe2ed1f0ac2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Apr 2023 18:50:46 +0000
Received: by hermes--production-bf1-5f9df5c5c4-fgkgh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b0c0f8afb3ff64e3b55c48b455034d43;
          Wed, 12 Apr 2023 18:38:44 +0000 (UTC)
Message-ID: <36eefdf1-7ffa-0970-33ce-3feec4983e55@schaufler-ca.com>
Date:   Wed, 12 Apr 2023 11:38:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230412043300.360803-1-andrii@kernel.org>
 <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
 <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/12/2023 11:06 AM, Paul Moore wrote:
> On Wed, Apr 12, 2023 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
>>> On Wed, Apr 12, 2023 at 12:33 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>> Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security, which
>>>> are meant to allow highly-granular LSM-based control over the usage of BPF
>>>> subsytem. Specifically, to control the creation of BPF maps and BTF data
>>>> objects, which are fundamental building blocks of any modern BPF application.
>>>>
>>>> These new hooks are able to override default kernel-side CAP_BPF-based (and
>>>> sometimes CAP_NET_ADMIN-based) permission checks. It is now possible to
>>>> implement LSM policies that could granularly enforce more restrictions on
>>>> a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
>>>> capabilities), but also, importantly, allow to *bypass kernel-side
>>>> enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications and use
>>>> cases.
>>> One of the hallmarks of the LSM has always been that it is
>>> non-authoritative: it cannot unilaterally grant access, it can only
>>> restrict what would have been otherwise permitted on a traditional
>>> Linux system.  Put another way, a LSM should not undermine the Linux
>>> discretionary access controls, e.g. capabilities.
>>>
>>> If there is a problem with the eBPF capability-based access controls,
>>> that problem needs to be addressed in how the core eBPF code
>>> implements its capability checks, not by modifying the LSM mechanism
>>> to bypass these checks.

Agreed. A lot of thought went into this. The LSM mechanism would be
vastly different if the hooks were authoritative instead of restrictive.

>> I think semantics matter here. I wouldn't view this as _bypassing_
>> capability enforcement: it's just more fine-grained access control.
>>
>> For example, in many places we have things like:
>>
>>         if (!some_check(...) && !capable(...))
>>                 return -EPERM;
>>
>> I would expect this is a similar logic. An operation can succeed if the
>> access control requirement is met. The mismatch we have through-out the
>> kernel is that capability checks aren't strictly done by LSM hooks. And
>> this series conceptually, I think, doesn't violate that -- it's changing
>> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
>> yet here).
> Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
> when it returns a positive value "bypasses kernel checks".  The patch
> isn't based on either Linus' tree or the LSM tree, I'm guessing it is
> based on a eBPF tree, so I can't say with 100% certainty that it is
> bypassing a capability check, but the description claims that to be
> the case.
>
> Regardless of how you want to spin this, I'm not supportive of a LSM
> hook which allows a LSM to bypass a capability check.  A LSM hook can
> be used to provide additional access control restrictions beyond a
> capability check, but a LSM hook should never be allowed to overrule
> an access denial due to a capability check.
>
>> The reason CAP_BPF was created was because there was nothing else that
>> would be fine-grained enough at the time.

There's nothing stopping you from having a fine grained mechanism that
further restricts a process with CAP_BPF. SELinux implements many checks
that can, policy willing, restrict a process with a capability from doing
what the capability permits.

> The LSM layer predates CAP_BPF, and one could make a very solid
> argument that one of the reasons LSMs exist is to provide
> supplementary controls due to capability-based access controls being a
> poor fit for many modern use cases.
>
> --
> paul-moore.com
