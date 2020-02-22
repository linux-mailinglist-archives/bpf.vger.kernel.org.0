Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F41168B61
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2020 02:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBVBEo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 20:04:44 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:33634
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727720AbgBVBEo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Feb 2020 20:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582333483; bh=GYToVjgD1TiujmOimFzM/iFsm6FNePn9F6VW/EmsZB4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SJZzcxiU9opsb3/c1upIQjiqEMtg94xWXtxZuT3lkQkfgbyzAp5+FTIf8hvKIOtn77mjvzisUjazLlF0XmO4hCmJppzOB4A+rtQhyM7NodG1QotK1zVTBv1nGBOjbWDD4O1YXmu7yns7Xsjxgg3iqrWYJFBCOQdSESqsJN7sMAfzHXIZ8Xpi5XJXWA1FJYWOj1N19I09MzuTKEdeTjCpN/4nEoTkte//OPFHKbnIdkEGsIHQUMQkebKCO26DjAmm0CLUQcJlWtg9/7kyLI/9dTr65gly++BMUjmBFBelD6fCLp96in91CadH4EEFaUgUd7QmGF87gau1To1sXGulpQ==
X-YMail-OSG: a6CtSsYVM1nvlCb3CmsmiWc3YPG1JImqyo8dlWPM.W48NcHfQkZyvYkvvEe615k
 fmaJbBSw4diFNdoHrZC0P_BbdvrkSgVuQOd8kOYGdxpvPbSIuzEcOoPqxDpROIlLnJe0YCJA6kIV
 7DocCAAWh1gv596rayjQfT82e23aKouM8Omf7gPK8CiH7B3Xyv43vJTJ8sQw6tx7nADNhAAFrQ0t
 V4OHUR5qdht56hRYRYI8VBq584Tkeq5qK.l_rL0zBaUHHIgEX2DID5fjgQGUyxdOxnWjs702ioQu
 e_kVHa3UYKveu6mVyvy4ezz2bmAAkhcaSQRq2PlqhuCAtQL33dphEV38Pyg6EuqVDy6cNtWmb0uW
 q1s.pak79lEdogYyl3m6TKB8n7xz0twNyCj9W27LCrJYylu31aXTfClducetXkgXnHWWwqtZ6DJK
 dSgv6BwXySZn0eMsMePcnd1WVwINxiiVRsqni5r8LJlymsX1rpdzu7e8rI8CDI.To.VHgjyEiN2d
 Ytqer7efwQIFqqPoZ7QxpjxR2XDNoZoDSNg6JIjvZ1aD52kDPbHNy.VxgwFVoG8eYyOai4a8TYMU
 tWMNhxOf4mzQ3wp9rc_xLf8jfU_.OtA9539Tleksse8TYAxd2nA6WJCfrjQAHrCxQtLG1lS8hnxr
 bqbstelhZJ8UScB8EyeNTu2b5M76wcAoZWn5tx9XkDJOTADnRiKaSrjMFtNQHHvFSM.3gjmE0k9M
 03J2U0yIXVctUmnnPv1W_BRAua4MGb.uKKficD6fhQ0bjYimTU1qiAbndfPUqQLUB2LNAVO3cwKs
 9NyBOjOHakc8yliUyHQ0xMPNtGktpcvr9QmutNfp3_KW0WBAMW85b_YxZEhHoz_0EiILMTBI2bmN
 ZVQhTb7EztMpy66RhM8pNzF2Kmj06Lq94w1IP5UUXczJTPHk3tj2AvvF_gsnBTtJSE22xk_4EPJT
 cMrJMzjBtZJMzRS9UhdM9otbJ9IfrsmNNrx9Dam9eGzT7Pxup_AyN6yc_Wky5AMwHDEF6DGgVSTt
 xSJcpP6.wRk_0160JeGdf4W5FnxHXYuWINZHvPcienzi.UJeN80fhUNY5SqujQmAOrX1U453v_fk
 oMfID5vB7Ojdq4UyBfo1bKQ2.aBH75qOCS8Z8D4svtyBLZxtTsoyy9WJc70tJsTo6Wyva1ASapu9
 GA8hnid31gds6VxYfFyskrF_PErX59SDWIOwMfT2o24oGMWADsdYxOM6r49FsOUhWozJ2XggvG7A
 UpeHF6Q9tnhe8KuOr3B_hhQ1skr2iWRAp.BQJF7TXQgCUkFOzeNA6EG_1DltyBWvhuRXrDMFCCPI
 4K1g3m.amyhhSt6I_9dz8lKwiSvp3HvoOyW4lJKUdFt00ENtVthRpEWZvAEaAM9g7USNtCQE1RNN
 kgkQm0N4am45Fxg9yCs3kxoOj.uELZS7vC1QyTuCByhWQk1XH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 22 Feb 2020 01:04:43 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4e58bc254b84e4d639d11dbcc15b5eb2;
          Sat, 22 Feb 2020 01:04:39 +0000 (UTC)
Subject: Re: [PATCH bpf-next v4 0/8] MAC and Audit policy using eBPF (KRSI)
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <85e89b0c-5f2c-a4b1-17d3-47cc3bdab38b@schaufler-ca.com>
 <20200221194149.GA9207@chromium.org>
 <8a2a2d59-ec4b-80d1-2710-c2ead588e638@schaufler-ca.com>
 <202002211617.28EAC6826@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7fd415e0-35c8-e30e-e4b8-af0ba286f628@schaufler-ca.com>
Date:   Fri, 21 Feb 2020 17:04:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202002211617.28EAC6826@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/21/2020 4:22 PM, Kees Cook wrote:
> On Fri, Feb 21, 2020 at 02:31:18PM -0800, Casey Schaufler wrote:
>> On 2/21/2020 11:41 AM, KP Singh wrote:
>>> On 21-Feb 11:19, Casey Schaufler wrote:
>>>> On 2/20/2020 9:52 AM, KP Singh wrote:
>>>>> From: KP Singh <kpsingh@google.com>
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
>>>> I've finally been able to review the entire patch set.
>>>> I can't imagine how it can make sense to add this much
>>>> complexity to the LSM infrastructure in support of this
>>>> feature. There is macro magic going on that is going to
>>>> break, and soon. You are introducing dependencies on BPF
>>>> into the infrastructure, and that's unnecessary and most
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
>> I see why you want to do this, but you're tying the two sets
>> of code together unnaturally. When (not if) the two sets diverge
>> you're going to be introducing another clever way to deal with
>> the special case.
> I really like this approach: it actually _simplifies_ the LSM piece in
> that there is no need to keep the union and the hook lists in sync any
> more: they're defined once now. (There were already 2 lists, and this
> collapses the list into 1 place for all 3 users.) It's very visible in
> the diffstat too (~300 lines removed):

Erk. Too many smart people like this. I still don't, but it's possible
that I could learn to.

>
>  include/linux/lsm_hook_names.h | 353 +++++++++++++++++++
>  include/linux/lsm_hooks.h      | 622 +--------------------------------=

>  2 files changed, 359 insertions(+), 616 deletions(-)
>
> Also, there is no need to worry about divergence: the BPF will always
> track the exposed LSM. Backward compat is (AIUI) explicitly a
> non-feature.

As written you're correct, it can't diverge. My concern is about
what happens when someone decides that they want the BPF and hook
to be different. I fear there will be a hideous solution.

> I don't see why anything here is "harmful"?

Injecting large chucks of code via an #include does nothing
for readability. I've seen it fail disastrously many times,
usually after the original author has moved on and entrusted
the code to someone who missed some of the nuance.

I'll drop objection to this bit, but still object to making
BPF special in the infrastructure. It doesn't need to be and
it is exactly the kind of additional complexity we need to
avoid.
=C2=A0


