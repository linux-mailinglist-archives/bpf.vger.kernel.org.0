Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5815B05C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgBLS7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Feb 2020 13:59:17 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42438
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgBLS7R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Feb 2020 13:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581533956; bh=8cVK0KCjE9iMM007r/sfUO8hpn6gI09B/rc04UxoAZ0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LBKoVcXnhwLMn4NyYKZ35M8mtyQ16O39sJHosBPJ52aNtojII81YF3qgt7ixdAP37dHI4nzTpgzan79j7ufmi6wDbk7CmzNek/FyGBK3zshN0CkKGp2PNoY3FheLymidBqSqaJECYVPcUj3BK0K0N788X3wuAwAUSuTDslT7OvPLkMAZAJ6T04wAmDZL/tu/C6xX/tooM1qY+9U6sLDPdKkYi47ac+bLaQnaPoldAn2mYGFS8NduovRtfa3Hidd2bwv1F4YBeGBtNyBZ7RrVeRoNe9aVtIlkSasznaX+rnU0TYQB3oLP2HdTwLpuMIIrEXoXT4mTrL8SqILcjGA9Uw==
X-YMail-OSG: 6UnkX1EVM1lJjWOPTEH9Sa1hGqzN0mREddys.exOq__c1JbJcgjXuE2W.u8sd4g
 7hPkpppwXEPUNjpZ14eE5F8H.zc87oF5sF4fSKBLwwlpP9sQ5m6keRqLwCJVw_askE0BreRdnwjZ
 GEKsdIShYalES0SW.kbiWKkGO2c8gDVeF3dFUeiwdNGDN6geq5GQUBHTieZoasHqzTs2mXOEj.Rr
 vnoAa5exOZd4vIm1u3iV2uyCoriLJGBDTyD3ZEYRCnD2wtAm7mtDa0q2FzjGE60WXenTnWdsl8bt
 pXOXK2Eu50dmJ3sk95d3xkyM30bds8EFD94M1ulqSTzLQ2Gfifn9O_mwiOlD.LDWS2j0UNGHJDb4
 DD3ewOlxjWavM9xWgVaYJwI20S6ByIWd.D02IHYatFCKfGBd2Is1LBgpvbX3l_39adZISvoDX2zB
 fTGvAixwsyn58SFWUtRhLQY0knUpEW1lTQx4uuE0sQi9_qarZdBDTYSPA..XNo8j3_sHk8xMdk_.
 7263TLVSomB.H03deByL7_AvdXca4F.xi4bPGg2UVDe1_xSzGe8Bwgu822PXq5AMmuPvpcglqcYJ
 Pa52hZp2E1XSbo88ZWYOOEmsFwVNrt6RKcIgP75QtfyVbnvUfXCYg4Egw.SP5YCoUkG4Xq6XWgNx
 qhNGtgCP31M15smhgzvW5Z28gpL3pLwOFUsM6GEVF8H12iWIadwSU97YUpGN7aanuEGD..cnfCR7
 Vj3nSSxy5I7tvvDTfmi8H0X3IqsDbU5eNmsUyBwKSIMErosVWrljgqofUa3VArbMZKn35ftif07u
 0wjXKQzBUfMBBYyl6anQPygNVxveGsefDLLRT_d8pydKgUaNUGCz1xuwNGXXy2eUErbkiqMz1JEG
 ttPxrmReFw52OlDtjn4R9rritqnG06stioiDg1PryVnTeJxsZz5JMHtfCn7vtmlHfWBvmAdCZGTY
 rsWu9rnMMH.zDfleW9g1ixZHP8rX.WxictKDQEpiZ9JT0Kc3TO.LC.JIYBlSR1V7qrUmBwvd0la7
 Ww_EaclQrj2z1ZhYGP49N.ZQ22lPXQclY.NwfNrb96VH5efX.nJ1dxYygXVrbr0bAQvd1w5IkkVk
 lZsSN9ZZWINmwnfDvoEU0MtuCiJP.zIEM3WGpH_.l8Ca8x0ze9RZk.JntIdWRC_G5xGJ06QEacna
 RYI9kB0zLmSkmZdR3oLExMCUJJp2IKqnKJXYxYAIMxg3hjER9UoLmdub6MY5uOQYtbtb4lc8k8AM
 hlYvYOSJmHsoBdjolZy9Ke.IPtx8YAKNkVs4kSpP66n6iaD5n43NXak8GahSJ3uPP6e_eoqgni6p
 kfOa23cJwSZJL3hTtC6jnutMUOTkvXUbpQadMC8T1ypoaTDp7BNmR6BqOPXeKYitNrZjb_QG_sFZ
 OXZ9s2JuYbGgYMFHGDKc4QHNgy1HX1PHJmmZ291r7p2rc3.bsqxz5_WTJOP.fh4r8C0U8jedKU0S
 FeKIJ.A7X5yYfbyMQznohu_7YmNzdWeE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Feb 2020 18:59:16 +0000
Received: by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4e718907107bca3f337af6f8d79602ff;
          Wed, 12 Feb 2020 18:59:10 +0000 (UTC)
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     KP Singh <kpsingh@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
 <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
 <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
 <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
 <1cd10710-a81b-8f9b-696d-aa40b0a67225@iogearbox.net>
 <20200212024542.gdsafhvqykucdp4h@ast-mbp>
 <bee0fd08-b9f2-83e4-2882-475b81c74303@schaufler-ca.com>
 <20200212162613.GB259057@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9eddd26d-9157-7f8d-c6d1-ab3f11a526e2@schaufler-ca.com>
Date:   Wed, 12 Feb 2020 10:59:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212162613.GB259057@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/12/2020 8:26 AM, KP Singh wrote:
> On 12-Feb 07:52, Casey Schaufler wrote:
>> On 2/11/2020 6:45 PM, Alexei Starovoitov wrote:
>>> On Wed, Feb 12, 2020 at 01:09:07AM +0100, Daniel Borkmann wrote:
>>>> Another approach could be to have a special nop inside call_int_hook=
()
>>>> macro which would then get patched to avoid these situations. Somewh=
at
>>>> similar like static keys where it could be defined anywhere in text =
but
>>>> with updating of call_int_hook()'s RC for the verdict.
>> Tell me again why you can't register your BPF hooks like all the
>> other security modules do? You keep reintroducing BPF as a special
>> case, and I don't see why.
> I think we tried to answer this in the discussion we had:
>
>  https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.or=
g/T/#meb1eea982e63be0806f9bba58e91160871803752

I understand your arguments, but remain unconvinced.

> BPF should not allocate a wrapper (to be statically regsitered at
> init) for each LSM hook and run the programs from within that as this
> implies adding overhead across the board for every hook even if
> it's never used (i.e. no BPF program is attached to the hook).

SELinux would run faster if it didn't have hooks installed where
there is no policy loaded that would ever fail for them. That's
not the infrastructure's problem.

> We can, with the suggestions discussed here, avoid adding unncessary
> overhead for unused hooks. And, as Alexei mentioned, adding overhead
> when not really needed is especially bad for LSM hooks like
> sock_sendmsg.

You're adding overhead for systems that have BPF built, but not used.

> The other LSMs do not provide dynamic / mutable hooks, so it makes
> sense for them to register the hooks once at load time.

As mentioned above, the hooks may not be mutable, but policy
may make them pointless. That is the security module's problem,
not the infrastructure's.

>
> - KP
>
>>> Sounds nice in theory. I couldn't quite picture how that would look
>>> in the code, so I hacked:
>>> diff --git a/security/security.c b/security/security.c
>>> index 565bc9b67276..ce4bc1e5e26c 100644
>>> --- a/security/security.c
> [...]

