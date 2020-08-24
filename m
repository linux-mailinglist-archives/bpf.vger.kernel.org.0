Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6F2506F9
	for <lists+bpf@lfdr.de>; Mon, 24 Aug 2020 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHXRyb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 13:54:31 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:36600
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgHXRyb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 13:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598291670; bh=wZWdeV82grk1vCCG3xyxethbZMe/msX85Us+HfU7CEg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jv9ij9F16qa1xzyTPbSC3hnDR9x22zIAPzidexwZ8V1iieDz9qQ/QN8c/5W2Jbv/RvY9OghklFdK6UC6ACXnwnKkaK3gEPYF8slGbb77OJvt89udcJQ8lt2o4FGalovEt69dZXhzGFXVWNdmXn1gITh97KNgA+x/yghb5m+RtTs8K2DGYGRBZ1LxhgNYCQ3SfIPqnvfxfAr2gm3uL7bMB3nXUNFDDCIWXqu5LNhtLYa25Yd3J0/PWMsQuNwPbggpYy5BOzmhLnBlo+rTYbN6ON3DNDscx4cBjle9Lt+xCYKgqNTsGFJXQcVRYZI+dI+jl8UzPaoiJqqp1OZjhWTVhQ==
X-YMail-OSG: Ws92fo4VM1mkc77h2D.KIK2Of1VKQjfcG5Xhd0ffvRyyGPxmw9R4IkYrt3w_B4b
 uRu0TI7SB834dyQBAW16L3WTq8guJKN9SnGrQI682oRyq8S0HBrrClnY0tm608wSl6e3kY7Mt1aO
 _TwTmWs8c9b7CReMmupYS_BFSTdILsnwtqeVd4ASRxDgYVrePEB48z4xAIbuk9Wt0eY1ntsCuV0N
 ndQVjlcXGGF1NcPAwXX3R7Awt2x_J_2_EMq3GkSJSfHkzKUSXzkWm6te2_2R0uOQfmPb6I9sqmCf
 DhCvnkDN6PgwBLxxC9nJk5zT13M05d4EHWhzDIeNEpdq6pzj9so6aOfOmHpLFU4gIBGMERjL21WM
 lLx3pmo38q5YF6e4rPEefVJwOhHFzQvzbT7kGM2gLh6M67pPYu9rcsll2EaXzshDj2UE4bgk4h0z
 EJD9MzIm2kS5dMGquCPX_kiRTlgFfI8WBufDu4YehRbblA7tbIA8glPx5jecV.DPDLSW19ACBDIV
 BkUpCHmGP7Iu_8ANK0LDOBjhnE9QzbLVz1.fz_fe20UroPQRTqOPL2oAEtlu2NeLk2NZcgO5mOpR
 SInSnlqLSrrKn8O1SQJOHDmwDYx5mV1vYVytf0tDe4cGcDx47goIaEHpbAWg3avgrUIdVDwngvtJ
 xdUEUeQIYM5Xx7u14JXVpK5Ib06jDfAv_YeHma3cvtO1DlAs6FP9AH2TxRGQDwIKf7NTf0qhlv.x
 bK48ym9Bw_PvQnrqHgVJIXEoHM0mX_dH_udz50xk4J7BYNesuvKx9JT3Q6p7oRYNnWQRMWd0VOyE
 7rIuNK4.k4LytuDmTc_TSJl_UUvGCh9BsyZSOxSBJTufmGspWuIN4ksYXsOGG3aw0slVVo2L44iO
 fEQmBsFjAVslIG9ZeCHgoJvo9aYQuI81W_uC0n7gn8G6NS0ulF7vJoop4D5PYyylIt8N4u9VStW1
 agihrNPCnfxLp3_oR.gEOemkPgt_iJcdk614qyiGNKHia_fQAr4iHPcR2SlXyhhZ1c85xjf4yTjE
 B3Fxup53R1f1YHFJp5qUk7BdTYVgaQu3Wmi3h9jYyFe_xdXLG0xFQpd0a._wNrLqoFBmgC9RJiF8
 _D3CQmdMGmxndAzeE5XwNIyw1tFUVo7urFX_A5p42ad71YG.1U4xQ6iTjdQzif4a.YHw2q58F9ds
 Uy39Nr4CvGo_zhZT6Dk1W4wg9FVEtW5aUxbTZVFJgSs583KudHfuUTIZGXJ_i7liInk3QGuI2tRd
 zpH.1lsfZjpRTMzJQu4fGAWP.PLbs1p0PO6LNj_4e777B2DC2tRgahap0rzyqkXoIgstGQuhHXGs
 0KxDgruSu3k9EPUQhyv0oXDER8iiKPHQs_FwCze07PxxvntxkXcRSuLlHALZduypZH0CBJuYizUK
 A0mBeQoFFQ35XUBUU1y_6oCoWRIznzI577W5FeDQXKuEOPZb..FtUGTHdoikcFPLt4YO31C2t.bQ
 ScOGwV2hCGpehlb0oPMb1k1Y2FMeodRGu.jaGcMb4oGVhHiM_aimKPooogDH9S6OzZRgFLSbBY6X
 5G0lBS86LqJKcNwVHcvZzWz0tcrwnweTi6vQMuLUDQyK1pB9NMDaBEonHoI8IXLH5tVZCjewdCMH
 PZqw_tM36DJszZMAbNQAtJ5mH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Aug 2020 17:54:30 +0000
Received: by smtp424.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 56d747b8779068a3f044ba03cad1d4c1;
          Mon, 24 Aug 2020 17:54:29 +0000 (UTC)
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com, Kees Cook <keescook@chromium.org>,
        thgarnie@chromium.org, KP Singh <kpsingh@google.com>,
        paul.renauld.epfl@gmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com>
 <CA+i-1C09YZ8aCr6p5NOA2e3Ji5TKwdET=qAy=M328NK--L=0RA@mail.gmail.com>
 <66a35f25-53be-17c3-8ab3-7cb32b0bc77a@schaufler-ca.com>
 <CA+i-1C1GwgYJAfaUofzv47nyryQ15znE6OLWhAN-gsscm6mMoA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <04b2d1ca-1524-d503-084c-4b27d55f862c@schaufler-ca.com>
Date:   Mon, 24 Aug 2020 10:54:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+i-1C1GwgYJAfaUofzv47nyryQ15znE6OLWhAN-gsscm6mMoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/24/2020 10:04 AM, Brendan Jackman wrote:
> On Mon, 24 Aug 2020 at 18:43, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 8/24/2020 8:20 AM, Brendan Jackman wrote:
>>> On Fri, 21 Aug 2020 at 00:46, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 8/20/2020 9:47 AM, Brendan Jackman wrote:
>>> [...]
>>>> What does NOP really look like?
>>> The NOP is the same as a regular function call but the CALL
>>> instruction is replaced with a NOP instruction. The code that sets up
>>> the call parameters is unchanged, and so is the code that expects to
>>> get the return value in eax or whatever.
>> Right. Are you saying that NOP is in-line assembler in your switch?
> That's right - although it's behind the static_call API that the patch
> depends on ([5] in the original mail).
>
>>> That means we cannot actually
>>> call the static_calls for NULL slots, we'd get undefined behaviour
>>> (except for void hooks) - this is what Peter is talking about in the
>>> sibling thread.
>> Referring to the "sibling thread" is kinda confusing, and
>> assumes everyone is one all the right mailing lists, and knows
>> which other thread you're talking about.
> Sure, sorry - here's the Lore link for future reference:
>
> https://lore.kernel.org/lkml/20200820164753.3256899-1-jackmanb@chromium.org/T/#m5a6fb3f10141049ce43e18a41f154796090ae1d5
>
>>> For this reason, there are _no gaps_ in the callback table. For a
>>> given LSM hook, all the slots after base_slot_idx are filled,
>> Why go to all the trouble of maintaining the base_slot_idx
>> if NOP is so cheap? Why not fill all unused slots with NOP?
>> Worst case would be a hook with no users, in which case you
>> have 11 NOPS in the void hook case and 11 "if (ret != DEFAULT_RET)"
>> and 11 NOPS in the int case. No switch magic required. Even
>> better, in the int case you have two calls/slot, the first is the
>> module supplied function (or NOP) and the second is
>>         int isit(int ret) { return (ret != DEFAULT_RET) ? ret : 0; }
>> (or NOP).
>>
>> The no security module case degenerates to 22 NOP instructions
>> and no if checks of any sort. I'm not the performance guy, but
>> that seems better than maintaining and checking base_slot_idx
>> to me.
> The switch trick is not really motivated by performance.

Then what is its motivation? It makes the code more complicated,
and is unnecessary.

> I think all the focus on the NOPs themselves is a bit misleading here
> - we _can't_ execute the NOPs for the int hooks, because there are
> instructions after them that expect a function to have just returned a
> value, which NOP doesn't do.

That's what I was hoping to address with the second call in the slot.
The first call in the slot would be either the module supplied code
or a NOP if the module isn't using the hook. The second would be
supplied by the LSM infrastructure and would be NOP if the module
didn't use the hook. The LSM supplied function would do the necessary
checking. Its more complicated than the void case, but not that much
more complicated than the existing list based scheme.

The concern about the non-existent return on a NOP can be dealt with
by setting up initial conditions correctly in most cases. Dealing with
multiple security modules providing information (e.g. secid_to_secctx)
is where it gets tricky.

>  When there is a NOP in the slot instead
> of a CALL, it would appear to "return" whatever value is leftover in
> the return register. At the C level, this is why the static_call API
> doesn't allow static_call_cond to return a value (which is what PeterZ
> is referring to in the thread I linked above).
>
> So, we could drop the switch trick for void hooks and just use
> static_call_cond, but this doesn't work for int hooks. IMO that
> variation between the two hook types would just add confusion.

With the number of cases where the switch trick isn't going to
work in the long term I'm disinclined to think it makes things
less confusing.


>>>>> +#define __UNROLL_MACRO_LOOP_20(MACRO, ...) \
>>>>> + __UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__) \
>>>>> + MACRO(19, __VA_ARGS__)
>>>>> +
>>>> Where does "20" come from? Why are you unrolling beyond 11?
>>> It's just an arbitrary limit on the unrolling macro implementation, we
>>> aren't actually unrolling beyond 11 where the macro is used (N is set
>>> to 11).
>> I'm not a fan of including macros you can't use, especially
>> when they're just obvious variants of other macros.
> Not sure what you mean here - is there already a macro that does what
> UNROLL_MACRO_LOOP does?

No, I'm saying that __UNROLL_MACRO_LOOP_20() will never be used on
a system that has at most 11 security modules. You've added a bunch of
text that serves no purpose. "Future expansion" is pretty silly here.

