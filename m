Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C8168A82
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2020 00:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBUXtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 18:49:17 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:39135
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729100AbgBUXtR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 18:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582328956; bh=hiIld5BAHgqSS+vqeh3I7L0eO05YzsmcsTHBOGfaPAE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=E9SYyB1UX+/6Mam7eXOmM22a/2c8UBND5r42ZreUu5etomnrxvyVAZf1XNgFUlQ+J4KRskDRI7bF0J3PPsEIeIZAmLaf6SACu+t46z5Tr5/6+h98ZKwi9xDqdlw7YypbdbT1HKBdJFEEZw+AiNuv7tbrxqMEW0SoZffH6cfKihUYKVlp+114+ZFURWSmoi13dptm794qe+sEgwBf0rBraU7WT8TMQRKwr+3CrRRnUIby1PTSf1NM8ju9xjCNVQ7BzE6gV037Inxl3Qbhd3k47IpqQrCZB0CBR03cYp1sEvjy71hH//l/wCHkkHH1EmdedfyI5ZwH9Zi5tXpybAR+iQ==
X-YMail-OSG: oFfEH5sVM1mMMEgsPmbYSXzPOxLjYyeFkEi1dCyGT9uOyE2URwMxZDVXOCJ9yMT
 1Z0zCYm93EoDeQYsufK2adPjSb0hewcrx6Oie1JxB0XZP0U3rI31sdezqKfBsezveuaWoLdbmw6s
 wP9oqvwjbTLbvx0Xya2tHFl87cWFv6Z6JIYbu_yl6uoKscDQzaS20OwrCsZ9bkCP2nPT4DGliqH4
 RLPjqTif1Bq9Av2a29KIXJEBKAnaCafMpSkvWXZwjqiUfUG0E4tluAjPIFgxkJzigeT9a0f69iSf
 5Kdydp6OJMz9rcBneO2R1DvwZv.npww7zJ40Im.8vULzLHlrvNod1_6Xkdrm2GCIoBLvFvEO1xny
 iNgUEgHDou60GIKzQTlQfvgRanPLbjIZPp5Vfyn4t64v7BweYzot3PZwSEGmO1SbYXgFpq7XL_6q
 z0M4V.3oE9t8oUL6rCNe36JmcTm7miPnIIcK0xjU54fyp2VBUQd.yguNbC7x00ockxU7jbRfdF9t
 EPFyldre_LLE7BgoQ7i7Hd7cO4xMd8zNzmqgZz90ExksA2V8OQlrk9Um26n7yYCnhrq1yDTj8Oaj
 f2S8vdqRrXYNUsjZs4gd7EmT6lwO4vZVKzp3jCLPT28RXPhQKWqye_3KVMjuTRBzeaAl2JEz8hwk
 FClY293g3OCKO2J_hTPz1CGEo5yUrv4rqDtnuzu7FlvkytuvXpf3wpLDQIQX5UBuJ9ORsH4T98OD
 8wdLMcC_JEreWUWKKhzc6y6GCJKyk4Jr4uzfx.7Mnk7Ymc1fh1w3F2R3yPOqZi4uahcRZAUGal15
 zqYIQzR3edFfVEdfJKDasw8Ulj5T03cSqnJmDREeCkRizgt_IbsjVinew_berrq.CiIT9Oin4f1Z
 LQbK1kmotOTIHeDb6n6i1fxGEu1tXGWz2.SEPbgt_qmznSg8sTk09fOCDZZw0Rchk9zyT1q5TDoA
 AmUqNn1I8433l6htP_fx7azMTa3cvgzPoapKYlUQ_6FCfTZPGPnbfX7ryk7BNc6TlImtXyd5i.3e
 Lc.z53XZTYzpXuiEabGnqTyu0F.uqlVXsPMeWW5kjclsfuwRp0W7urhN_pmKC1bE1tA10voz.8UT
 tongEUKim49aiga72v2_VlomYBtr4X5BGP6m9LoacfmZsmJ8x6us0tx0mdYMIdwDwAAD2.TJkzk1
 .lTg0K3m6BG0tjfNb9TMwQ3OO6mQte12gJ5j0y9mB4FStuoG9tTe6lJIEtsY5h9PR3R9re_8.u5e
 mQim4USdBz6Bz.odHqjYjemuuZtxX2kHDELp3T1wgNkDXZFtSm2HasdzxEjReVXPS3ENY9f8EA7U
 Jop6fB6mnx7x59eorpmz47vjpNEgtm8qqxumlab5pc4vQwCLMBTMRjPB15z4ktQG4VrWObkIdPP0
 S2UG0dpiziSPW_UY8VQwmfkfPKfb5eXswNLHMGVBIcGhlA7FqSFrfWESvZ8sNBLkM6jDtSto3SRn
 YYv_Q6jDp9Bg95Jo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Feb 2020 23:49:16 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bddf1118258f0c0d46f9104e490f4fc7;
          Fri, 21 Feb 2020 23:49:11 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200221230933.GA23663@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e713d259-fe7f-0b4b-f3bb-30919f6b1f12@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 15:49:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221230933.GA23663@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/21/2020 3:09 PM, KP Singh wrote:
> Thanks Casey,
>
> I appreciate your quick responses!
>
> On 21-Feb 14:31, Casey Schaufler wrote:
>> On 2/21/2020 11:41 AM, KP Singh wrote:
>>> On 21-Feb 11:19, Casey Schaufler wrote:
>>>> On 2/20/2020 9:52 AM, KP Singh wrote:
>>>>> From: KP Singh <kpsingh@google.com>
>>>> Again, apologies for the CC list trimming.
>>>>
>>>>> # v3 -> v4
>>>>>
>>>>>   https://lkml.org/lkml/2020/1/23/515
>>>>>
>>>>> * Moved away from allocating a separate security_hook_heads and add=
ing a
>>>>>   new special case for arch_prepare_bpf_trampoline to using BPF fex=
it
>>>>>   trampolines called from the right place in the LSM hook and toggl=
ed by
>>>>>   static keys based on the discussion in:
>>>>>
>>>>>     https://lore.kernel.org/bpf/CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJ=
a07h=3Do_6B6+Q-u5g@mail.gmail.com/
>>>>>
>>>>> * Since the code does not deal with security_hook_heads anymore, it=
 goes
>>>>>   from "being a BPF LSM" to "BPF program attachment to LSM hooks".
> [...]
>
>>>> likely harmful.
>>> We will be happy to document each of the macros in detail. Do note a
>>> few things here:
>>>
>>> * There is really nothing magical about them though,
>>
>> +#define LSM_HOOK_void(NAME, ...) \
>> +	noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
>> +
>> +#include <linux/lsm_hook_names.h>
>> +#undef LSM_HOOK
>>
>> I haven't seen anything this ... novel ... in a very long time.
> This is not "novel", it's a fairly common pattern followed in tracing:
>
> For example, the TRACE_INCLUDE macro which is used for tracepoints:
>
> =C2=A0 include/trace/define_trace.h
>
> and used in:
>
> =C2=A0 * include/trace/bpf_probe.h
>
> =C2=A0 =C2=A0 https://github.com/torvalds/linux/blob/master/include/tra=
ce/bpf_probe.h#L110
>
> =C2=A0 * include/trace/perf.h
>
> =C2=A0 =C2=A0 https://github.com/torvalds/linux/blob/master/include/tra=
ce/perf.h#L90
>
> =C2=A0 * include/trace/trace_events.h
>
>     https://github.com/torvalds/linux/blob/master/include/trace/trace_e=
vents.h#L402

I can't say I care for that, either, and it's a simpler case.

>> I see why you want to do this, but you're tying the two sets
>> of code together unnaturally. When (not if) the two sets diverge
>> you're going to be introducing another clever way to deal with
> I don't fully understand what "two sets diverge means" here. All the
> BPF headers need is the name, return type and the args. This is the
> same information which is needed by the call_{int, void}_hooks and the
> LSM declarataions (i.e. security_hook_heads and
> security_list_options).

As you've noticed, not all the interfaces can use call_{int,void}_hooks.
If you've been following the stacking efforts, you'll see that increasing=
=2E

At some point I anticipate a BPF hook that needs different information
than the LSM hook. That's been discussed, too. Asserting that it will
never happen does not make me comfortable.

>> the special case.
>>
>> It's not that I don't understand what you're doing. It's that
>> I don't like what you're doing. Explanation doesn't make me like
>> it better.
> As I have previously said, we will be happy to (and have already)
> updated our approach based on the consensus we arrive at here.

Not to put too fine a point on it, but I have raised the same
objection - that you should use the infrastructure as it is -
each time. I do not see consensus, I see you plowing ahead with
the direction you've chosen in spite of the significant objection.

>  The
> best outcome would be to not sacrifice performance as the LSM hooks
> are called from various performance critical code-paths.

Then help me tune the infrastructure to be better in those cases.

> It would be great to know the maintainers' (BPF and Security)
> perspective on this as well.

Many eyes and all that, but the BPF maintainers haven't been working
with the LSM infrastructure and won't be familiar with its quirks.


