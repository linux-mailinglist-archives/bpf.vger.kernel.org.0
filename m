Return-Path: <bpf+bounces-20734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC28426AF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDB91F26C2F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D86DCF9;
	Tue, 30 Jan 2024 14:10:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F6BB3C;
	Tue, 30 Jan 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623820; cv=none; b=FZUXOjTsULbSP7tnXGyIwSEOxcZ0lwQLKscCpL1SVbm1iOe8x8WmoLDU7ikIrxRxsHq0tBsb9J/XcGxYPNBkwEGTtI2CEWzvUVqVYEbMZ+dHp5DOjhyQsrqn70hpQlNdG7Ls6SyT2GG8pYAeGePyCranzGp1RcsCikDb7U9M1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623820; c=relaxed/simple;
	bh=jJXfbb/IS81FZ0fo7h7ykJXehvtxlzre6FqF9MmiTJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SD2DfKjFkICBhQr8Xq2KEJAILsou8imG+eKkaQBERdXOxIEg3pxgu08Fz+o9hE/hsEHQny8fwrCsP0g63SOesjoWLimn9Jt1xhRC0jsk3JPlG5SuKBiwr/yLyXmwFBC4AEJ4JGNZqq6+6/qprOax/PK0aReuLH9lbqgOXswqlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TPRqZ6WBszJpQM;
	Tue, 30 Jan 2024 22:09:14 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D25C1402CD;
	Tue, 30 Jan 2024 22:10:14 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 30 Jan 2024 22:10:13 +0800
Message-ID: <5a30caa3-3351-41e7-a77f-91e5959b2da6@huawei.com>
Date: Tue, 30 Jan 2024 22:10:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
 <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
 <87cytjusud.fsf@all.your.base.are.belong.to.us>
 <5d776261-338b-4ebb-bb9b-1dbc91cd06c3@huawei.com>
 <87zfwnympo.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87zfwnympo.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/1/30 21:28, Björn Töpel wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2024/1/30 16:29, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>
>>>> On 2023/9/28 17:59, Björn Töpel wrote:
>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>
>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>
>>>>>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>>>>>> the TCC can be propagated from the parent process to the subprocess, but
>>>>>> the TCC of the parent process cannot be restored when the subprocess
>>>>>> exits. Since the RV64 TCC is initialized before saving the callee saved
>>>>>> registers into the stack, we cannot use the callee saved register to
>>>>>> pass the TCC, otherwise the original value of the callee saved register
>>>>>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>>>>>> similar to x86_64, i.e. using a non-callee saved register to transfer
>>>>>> the TCC between functions, and saving that register to the stack to
>>>>>> protect the TCC value. At the same time, we also consider the scenario
>>>>>> of mixing trampoline.
>>>>>
>>>>> Hi!
>>>>>
>>>>> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have a
>>>>> fixed pro/epilogue like some of the other JITs. I think we can do better
>>>>> here, so that the pass-TCC-via-register can be used, and the additional
>>>>> stack access can be avoided.
>>>>>
>>>>> Today, the TCC is passed via a register (a6) and can be viewed as a
>>>>> "state" variable/transparent argument/return value. As you point out, we
>>>>> loose this when we do a call. On (any) calls we move the TCC to a
>>>>> callee-saved register.
>>>>>
>>>>> WDYT about the following scheme:
>>>>>
>>>>> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>>>>>      for the main program.
>>>>> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>>>>>      a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
>>>>> 3 For all other calls, a6 is passed transparently.
>>>>>
>>>>> For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
>>>>> a BPF helper or not.
>>>>>
>>>>> In summary; Determine in the JIT if we're leaving BPF-land, and need to
>>>>> move the TCC to a callee-saved reg, or not, and save us a bunch of stack
>>>>> store/loads.
>>>>>
>>>>
>>>> Valuable scheme. But we need to consider TCC back propagation. Let me
>>>> show an example of calling subprog with TCC stored in A6:
>>>>
>>>> prog1(TCC==1){
>>>>        subprog1(TCC==1)
>>>>            -> tailcall1(TCC==0)
>>>>                -> subprog2(TCC==0)
>>>>        subprog3(TCC==0) <--- should be TCC==1
>>>>            -\-> tailcall2 <--- can't be called
>>>> }
>>
>> Let's back with this example again. Imagine that the tailcall chain is a
>> list limited to 33 elements. When the list has 32 elements, we call
>> subprog1 and then tailcall1. At this time, the list elements count
>> becomes 33. Then we call subprog2 and return prog1. At this time, the
>> list removes 1 element and becomes 32 elements. At this time, there
>> still can perform 1 tailcall.
>>
>> I've attached a diagram that shows mixing tailcall and subprogs is
>> nearly a "call". It can return to caller function.
> 
> Hmm. Let me put my Q in another way.
> 
> The kernel calls into BPF_PROG_RUN() (~a BPF context). Would it ever be
> OK to do more than 33 tail calls, regardless of subprogs or not?
> 
> In your example, TCC is 1. You are allowed to perform one tail call. In
> your example prog1 performs two.
> 
> My view of TCC has always been ~a counter of the number of tailcalls~.
> 
> With your example expanded:
> prog1(TCC==33){
>        subprog1(TCC==33)
>            -> tailcall1(TCC==33) -> tailcall1(TCC==32) -> tailcall1(TCC==31) -> ... // 33 times
>        // Lehui says TCC should be 33 again.
>        // Björn says "it's the number of tailcalls", and subprog3 cannot perform a tail call
>        subprog3(TCC==?)

Yes, my view is take this something like a stack，while you take this as 
a fixed global value.

prog1(TCC==33){
     subprog1(TCC==33)
         -> tailcall1(TCC==33) -> tailcall1(TCC==32) -> 
tailcall1(TCC==31) -> ... // 33 times -> subprog2(TCC==0)
     subprog3(TCC==33)
	-> tailcall1(TCC==33) -> tailcall1(TCC==32) -> tailcall1(TCC==31) -> 
... // 33 times

>            
> My view has, again, been than TCC is a run-time count of the number
> tailcalls (fentry/fexit patch bpf-programs included).
> 
> What does x86 and arm64 do?

When subprog return back to caller bpf program, they both restore TCC to 
the value when enter into subprog. The ARM64 uses the callee saved 
register to store the TCC. When the ARM64 exits, the TCC is restored to 
the value when it enter. The while x86 uses the stack to do the same thing.

> 
> 
> Björn

