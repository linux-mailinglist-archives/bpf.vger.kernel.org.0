Return-Path: <bpf+bounces-20803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB91843AE9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB811C20CB9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1A67750;
	Wed, 31 Jan 2024 09:19:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE5657BE;
	Wed, 31 Jan 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692743; cv=none; b=SeYlhR2HLeSbcERKae6HsXYTQ/QVbU5/4yDcDMpd/kXUn+tB0REvqx1rLfPu/G3Ijl7x/Gw2gpqLZ6ciMtzm/yEvPocQcqzrvUwKFQ9dajysEOagrwfUYB3aqpogepueDSUc/hu4n4I/cwboTr7XMqorJ9Z6q3cE/rv/GxegM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692743; c=relaxed/simple;
	bh=ldDSBYbQsuawzE+q6s6utdmeV61rLn8VfZ8DgI5fbmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU3UozGMCDxlee1vmetwY7Rup5EwkEQ8e+gAHp0k4xz3yVikZF3MEJzZ/L1niRQpVbjDhUfkbXNdN/ClXJ6V4UrjeIdsZ+7Ix8aq/tsM5VBcPBpvsbCPo97G//a4HSf97DhCepyasXUEqvpfjIn78uA8k65Glih9qdEnkoEM2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPxL6357Rz4f3kK4;
	Wed, 31 Jan 2024 17:18:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F29C91A0171;
	Wed, 31 Jan 2024 17:18:56 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgB3RxB_ELpldj8jCg--.58078S2;
	Wed, 31 Jan 2024 17:18:55 +0800 (CST)
Message-ID: <694648e8-09ce-4a1f-8c2c-db0c6c37da5d@huaweicloud.com>
Date: Wed, 31 Jan 2024 17:18:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
 <87lecqobyb.fsf@all.your.base.are.belong.to.us>
 <4e73b095-0c08-4a6f-b2ee-8f7a071b14ee@huaweicloud.com>
 <87cytjusud.fsf@all.your.base.are.belong.to.us>
 <5d776261-338b-4ebb-bb9b-1dbc91cd06c3@huawei.com>
 <87zfwnympo.fsf@all.your.base.are.belong.to.us>
 <5a30caa3-3351-41e7-a77f-91e5959b2da6@huawei.com>
 <87le86q04a.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87le86q04a.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3RxB_ELpldj8jCg--.58078S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWrtF4DCF4fur18JFWkJFb_yoW7AF1DpF
	W3X3W7Kr4kXr1Iyr12yF18Xay0kr47JryUZr1rtr1rAr1q9r1qgF4xGF4j9FyxAr18Kr1U
	Zr4jqrW3Zw18JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/31 0:03, Björn Töpel wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2024/1/30 21:28, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huawei.com> writes:
>>>
>>>> On 2024/1/30 16:29, Björn Töpel wrote:
>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>
>>>>>> On 2023/9/28 17:59, Björn Töpel wrote:
>>>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>>>
>>>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>>>
>>>>>>>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>>>>>>>> the TCC can be propagated from the parent process to the subprocess, but
>>>>>>>> the TCC of the parent process cannot be restored when the subprocess
>>>>>>>> exits. Since the RV64 TCC is initialized before saving the callee saved
>>>>>>>> registers into the stack, we cannot use the callee saved register to
>>>>>>>> pass the TCC, otherwise the original value of the callee saved register
>>>>>>>> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
>>>>>>>> similar to x86_64, i.e. using a non-callee saved register to transfer
>>>>>>>> the TCC between functions, and saving that register to the stack to
>>>>>>>> protect the TCC value. At the same time, we also consider the scenario
>>>>>>>> of mixing trampoline.
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> The RISC-V JIT tries to minimize the stack usage, e.g. it doesn't have a
>>>>>>> fixed pro/epilogue like some of the other JITs. I think we can do better
>>>>>>> here, so that the pass-TCC-via-register can be used, and the additional
>>>>>>> stack access can be avoided.
>>>>>>>
>>>>>>> Today, the TCC is passed via a register (a6) and can be viewed as a
>>>>>>> "state" variable/transparent argument/return value. As you point out, we
>>>>>>> loose this when we do a call. On (any) calls we move the TCC to a
>>>>>>> callee-saved register.
>>>>>>>
>>>>>>> WDYT about the following scheme:
>>>>>>>
>>>>>>> 1 Pickup the arm64 bpf2bpf/tailmix mechanism of just clearing the TCC
>>>>>>>       for the main program.
>>>>>>> 2 For BPF helper calls, move TCC to s6, perform the call, and restore
>>>>>>>       a6. Dito for kfunc calls (BPF_PSEUDO_KFUNC_CALL).
>>>>>>> 3 For all other calls, a6 is passed transparently.
>>>>>>>
>>>>>>> For 2 bpf_jit_get_func_addr() can be used to determine if the callee is
>>>>>>> a BPF helper or not.
>>>>>>>
>>>>>>> In summary; Determine in the JIT if we're leaving BPF-land, and need to
>>>>>>> move the TCC to a callee-saved reg, or not, and save us a bunch of stack
>>>>>>> store/loads.
>>>>>>>
>>>>>>
>>>>>> Valuable scheme. But we need to consider TCC back propagation. Let me
>>>>>> show an example of calling subprog with TCC stored in A6:
>>>>>>
>>>>>> prog1(TCC==1){
>>>>>>         subprog1(TCC==1)
>>>>>>             -> tailcall1(TCC==0)
>>>>>>                 -> subprog2(TCC==0)
>>>>>>         subprog3(TCC==0) <--- should be TCC==1
>>>>>>             -\-> tailcall2 <--- can't be called
>>>>>> }
>>>>
>>>> Let's back with this example again. Imagine that the tailcall chain is a
>>>> list limited to 33 elements. When the list has 32 elements, we call
>>>> subprog1 and then tailcall1. At this time, the list elements count
>>>> becomes 33. Then we call subprog2 and return prog1. At this time, the
>>>> list removes 1 element and becomes 32 elements. At this time, there
>>>> still can perform 1 tailcall.
>>>>
>>>> I've attached a diagram that shows mixing tailcall and subprogs is
>>>> nearly a "call". It can return to caller function.
>>>
>>> Hmm. Let me put my Q in another way.
>>>
>>> The kernel calls into BPF_PROG_RUN() (~a BPF context). Would it ever be
>>> OK to do more than 33 tail calls, regardless of subprogs or not?
>>>
>>> In your example, TCC is 1. You are allowed to perform one tail call. In
>>> your example prog1 performs two.
>>>
>>> My view of TCC has always been ~a counter of the number of tailcalls~.
>>>
>>> With your example expanded:
>>> prog1(TCC==33){
>>>         subprog1(TCC==33)
>>>             -> tailcall1(TCC==33) -> tailcall1(TCC==32) -> tailcall1(TCC==31) -> ... // 33 times
>>>         // Lehui says TCC should be 33 again.
>>>         // Björn says "it's the number of tailcalls", and subprog3 cannot perform a tail call
>>>         subprog3(TCC==?)
>>
>> Yes, my view is take this something like a stack，while you take this as
>> a fixed global value.
>>
>> prog1(TCC==33){
>>       subprog1(TCC==33)
>>           -> tailcall1(TCC==33) -> tailcall1(TCC==32) ->
>> tailcall1(TCC==31) -> ... // 33 times -> subprog2(TCC==0)
>>       subprog3(TCC==33)
>> 	-> tailcall1(TCC==33) -> tailcall1(TCC==32) -> tailcall1(TCC==31) ->
>> ... // 33 times
>>
>>>             
>>> My view has, again, been than TCC is a run-time count of the number
>>> tailcalls (fentry/fexit patch bpf-programs included).
>>>
>>> What does x86 and arm64 do?
>>
>> When subprog return back to caller bpf program, they both restore TCC to
>> the value when enter into subprog. The ARM64 uses the callee saved
>> register to store the TCC. When the ARM64 exits, the TCC is restored to
>> the value when it enter. The while x86 uses the stack to do the same thing.
> 
> Ok! Thanks for clarifying. I'll continue reviewing the v2 of your
> series!
> 
> BTW, I wonder if we can trigger this [1] on RV64 -- i.e. calling the
> main prog, will reset the tcc count.
> 
> [1] https://lore.kernel.org/bpf/20240104142226.87869-1-hffilwlqm@gmail.com/

Yes, I have been paying attention to this matter recently and will 
allocate time to analyze it.


