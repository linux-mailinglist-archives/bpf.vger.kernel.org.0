Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043E3B0D4A
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhFVS7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 14:59:22 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58083 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVS7W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Jun 2021 14:59:22 -0400
X-Greylist: delayed 130980 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 14:59:21 EDT
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 839B1FF805;
        Tue, 22 Jun 2021 18:57:04 +0000 (UTC)
Subject: Re: BPF calls to modules?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
 <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
 <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
 <CAADnVQ+vcdO2SLnEeo5R4=8bTrkQiv-x2Ejcg08OsoZJJ4RXhw@mail.gmail.com>
 <56086fb4-3fdb-9e81-227c-721934fe2cb4@ghiti.fr>
 <CAADnVQJLwQhFZbNqA4jfJiqvKV2E8crOYns6oTCeDFeKoSmgBQ@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <a5d92288-7b74-b413-bc1d-1053d7284da8@ghiti.fr>
Date:   Tue, 22 Jun 2021 20:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQJLwQhFZbNqA4jfJiqvKV2E8crOYns6oTCeDFeKoSmgBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Le 22/06/2021 à 19:25, Alexei Starovoitov a écrit :
> On Tue, Jun 22, 2021 at 12:31 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi Alexei,
>>
>> Le 22/06/2021 à 02:28, Alexei Starovoitov a écrit :
>>> On Sun, Jun 20, 2021 at 11:43 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Le 18/06/2021 à 19:32, Andrii Nakryiko a écrit :
>>>>> On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>>>
>>>>>> Hi guys,
>>>>>>
>>>>>> First, pardon my ignorance regarding BPF, the following might be silly.
>>>>>>
>>>>>> We were wondering here
>>>>>> https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.2d27d2ac@xhacker/
>>>>>> if BPF programs that now have the capability to call kernel functions
>>>>>> (https://lwn.net/Articles/856005/) can also call modules function or
>>>>>> vice-versa?
>>>>>
>>>>> Not yet, but it was an explicit design consideration and there was
>>>>> public interest just recently. So I'd say this is going to happen
>>>>> sooner rather than later.
>>>>>
>>>>>>
>>>>>> The underlying important fact is that in riscv, we are limited to 2GB
>>>>>> offset to call functions and that restricts where we can place modules
>>>>>> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
>>>>>> the current possibly wrong layout).
>>>>>>
>>>>>> So should we make sure that modules and BPF lie in the same 2GB region?
>>>>>
>>>>> Based on the above and what you are explaining about 2GB limits, I'd
>>>>> say yes?.. Or alternatively those 2GB restrictions might perhaps be
>>>>> lifted somehow?
>>>>
>>>>
>>>> Actually we have this limit when we have PC-relative branch which is our
>>>> current code model. To better understand what happened, I took a look at
>>>> our JIT implementation and noticed that BPF_CALL are implemented using
>>>> absolute addressing so for this pseudo-instruction, the limit I evoked
>>>> does not apply. How are the kernel (and modules) symbol addresses
>>>> resolved? Is it relative or absolute? Is there then any guarantee that a
>>>> kernel or module call will always emit a BPF_CALL?
>>>
>>> Are those questions for riscv bpf JIT experts?
>>
>> Yes more or less, sorry about that, I added Bjorn in cc in case he wants
>> to intervene. But I think my last question is relevant: Is there then
>> any guarantee that a kernel or module call will always emit a BPF_CALL?
>> Because that would mean that we don't need to place BPF close to modules
>> since BPF_CALL are JITed into an absolute branch in riscv.
> 
> I don't understand what you mean with this question.
> BPF_CALL is a BPF instruction to call from bpf prog. Not into bpf prog.
> When kernel or module calls into JITed bpf prog
> they use indirect call insn of the given arch.

So a call to BPF program from kernel/module function is done using an 
indirect call. I have to check how this is actually done in riscv.

> In case of bpf dispatcher there is a generated asm code that uses jmp
> by register
> or retpoline style.
> So JITed bpf progs not only 'called' into.
>  From bpf prog the helpers and kernel funcs are called via BPF_CALL.

And this answers my question (I admit my phrasing may have been a bit 
confusing): a call to a kernel/module function from within a BPF program 
is done using a BPF_CALL.

> And this bpf insn has 32-bit offset requirement across archs. So all callable
> functions have to be in the same 4G region. So far that was the case
> for all archs.
> If riscv is going to separate things by more than 4G it will cause
> plenty of headaches
> for riscv JIT.
> 

No no, don't worry, we already are in the same 4G region, the question 
is do we need to be in the same *2G* region. I have enough material to 
continue my investigation.

Thank you very much for your time,

Alex


