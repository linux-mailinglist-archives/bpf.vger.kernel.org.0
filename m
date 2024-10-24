Return-Path: <bpf+bounces-43063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B057E9AECC4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E161C23355
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B41F81BC;
	Thu, 24 Oct 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TIcrbN9U"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C91F4FC2
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789007; cv=none; b=DQ/JiejNFiOFm4hiKsulYfq/nD6N7yT/0IwBMzokP2eK4+/zIT0M5/1HjTaz+Wm/qAzTAQrdpP0BtUH+V+d2k89joLnez5wuO5rmbyefT2nuswsDycEzf45dskUGI19zWnho7L85xWz73FJTf2slkgP1dTJ1PHfeK0nPwRunxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789007; c=relaxed/simple;
	bh=/armHdgJSP+GLKMURrfk/W4zoFXMPKjhnVoHhxbfP74=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LxINKN+tiyYivIX6mIP8Txk9Ax81WMCNJgBpmyfqL/6ydgMWV/QPrzTuOXwA4+sNpBOdBO8xcq/3j34nd6qYrDFnoPvf8/rUczVNVeBXSK0SwRfHjx5QVMxYumF1cTbNtHtfUMhXWiSxcqaXmrnEbOPqV17NM+gpM1A4xTnKQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TIcrbN9U; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c92c4f52-d24b-45de-9d8a-c845acbb3269@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729789003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzwISSmDm0reuvlR0Z7/fr7h9fu+IbXI2kZFAnAMmxU=;
	b=TIcrbN9UdDPhV91FIFiJPME9Z2SfQ1TMBvFOpqq5k4KP7FhFjvD9V90IL/HYkVDwv50gS/
	I5yrNoM5KWXDeTb6d9nfFYRxG+g5uVj4cA79C+NiAIwxvN7KH9xi0/eoz5g/0pvhFPF1LR
	90EnGgltZCWfWBnS+CepCMpaQgP9MRI=
Date: Thu, 24 Oct 2024 09:56:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-2-leon.hwang@linux.dev>
 <87faf17b-51aa-487f-8d49-bf297a64ffa6@linux.dev>
 <0f61509c-3a00-422a-90f3-89bdfbd20037@linux.dev>
 <c3e4f79c-8453-4e2d-b96f-a7ac718843cf@linux.dev>
 <d3629f38-9579-468b-8fdb-6e3000590ef4@linux.dev>
 <a2686faa-cdca-410f-b2c8-0521c08e758e@linux.dev>
In-Reply-To: <a2686faa-cdca-410f-b2c8-0521c08e758e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/24/24 9:38 AM, Yonghong Song wrote:
>
> On 10/23/24 8:33 PM, Leon Hwang wrote:
>>
>> On 24/10/24 10:29, Yonghong Song wrote:
>>> On 10/21/24 6:46 PM, Leon Hwang wrote:
>>>> On 22/10/24 01:49, Yonghong Song wrote:
>>>>> On 10/21/24 6:39 AM, Leon Hwang wrote:
>>>>>> In the x86_64 JIT, when calling a function, tailcall info is
>>>>>> propagated if
>>>>>> the program is tail_call_reachable, regardless of whether the 
>>>>>> function
>>>>>> is a
>>>>>> subprog, helper, or kfunc. However, this propagation is 
>>>>>> unnecessary for
>>>>>> not-tail_call_reachable subprogs, helpers, or kfuncs.
>>>>>>
>>>>>> The verifier can determine if a subprog is tail_call_reachable.
>>>>>> Therefore,
>>>>>> it can be optimized to only propagate tailcall info when the 
>>>>>> callee is
>>>>>> subprog and the subprog is actually tail_call_reachable.
>>>>>>
>>>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>>>> ---
>>>>>>     arch/x86/net/bpf_jit_comp.c | 4 +++-
>>>>>>     kernel/bpf/verifier.c       | 6 ++++++
>>>>>>     2 files changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/x86/net/bpf_jit_comp.c 
>>>>>> b/arch/x86/net/bpf_jit_comp.c
>>>>>> index 06b080b61aa57..6ad6886ecfc88 100644
>>>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>>>> @@ -2124,10 +2124,12 @@ st:            if (is_imm8(insn->off))
>>>>>>                   /* call */
>>>>>>             case BPF_JMP | BPF_CALL: {
>>>>>> +            bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
>>>>>> +            bool subprog_tail_call_reachable = dst_reg;
>>>>>>                 u8 *ip = image + addrs[i - 1];
>>>>>>                   func = (u8 *) __bpf_call_base + imm32;
>>>>>> -            if (tail_call_reachable) {
>>>>>> +            if (pseudo_call && subprog_tail_call_reachable) {
>>>>> Why we need subprog_tail_call_reachable? Does
>>>>>       tail_call_reachable && psueudo_call
>>>>> work the same way?
>>>>>
>>>> 'tail_call_reachable && pseudo_call' works too. However, it will
>>>> propagate tailcall info to subprog even if the subprog is not
>>>> tail_call_reachable.
>>>>
>>>> subprog_tail_call_reachable indicates the subprog requires tailcall 
>>>> info
>>>> from its caller.
>>>> So, 'pseudo_call && subprog_tail_call_reachable' is better.
>>> In verifier.c, we have
>>>    func[i]->aux->tail_call_reachable = env-
>>>> subprog_info[i].tail_call_reachable;
>>> that is subprog_info tail_call_reachable has been transferred to 
>>> func[i]
>>> tail_call_reachable.
>>>
>>> In x86 do_jit() func, we have
>>>    bool tail_call_reachable = bpf_prog->aux->tail_call_reachable
>>>
>>> So looks like we do not need verifier.c change here.
>>> Did I miss anything? Could you give a concrete example to show
>>> subprog_tail_call_reachable approach is better than 
>>> tail_call_reachable?
>> Sure, here's an example:
>>
>> struct {
>>     __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>     __uint(key_size, sizeof(u32));
>>     __uint(value_size, sizeof(u32));
>>     __uint(max_entries, 1);
>> } jmp_table SEC(".maps");
>>
>> static __noinline int
>> subprog_tc1(struct __sk_buff *skb)
>> {
>>     volatile int retval = TC_ACT_OK;
>>
>>     bpf_tail_call_static(skb, jmp_table, 0);
>>     return retval;
>> }
>>
>> static __noinline int
>> subprog_tc2(struct __sk_buff *skb)
>> {
>>     volatile int retval = TC_ACT_OK;
>>
>>     return retval;
>> }
>>
>> SEC("tc")
>> int entry_tc(struct __sk_buff *skb)
>> {
>>     u32 pid = bpf_get_smp_processor_id();
>>     // do something with pid
>>     subprog_tc2(skb);
>>     return subprog_tc1(skb);
>> }
>>
>>  From the verifier's perspective, both entry_tc and subprog_tc1 are
>> tail_call_reachable.
>>
>> When handling 'BPF_JMP | BPF_CALL' in the x86 do_jit() for entry_tc,
>> three cases arise:
>>
>> 1. bpf_get_smp_processor_id()
>> 2. subprog_tc1()
>> 3. subprog_tc2()
>>
>> At this point in x86 do_jit() for entry_tc, entry_tc is considered
>> tail_call_reachable. The check 'bool pseudo_call = src_reg ==
>> BPF_PSEUDO_CALL' is used to determine whether to call a subprogram.
>>
>> The question is: when should tailcall info be propagated? Should it be
>> when entry_tc is tail_call_reachable, even if subprog_tc2 is called, or
>> when subprog_tc1 is specifically tail_call_reachable?
>>
>> I believe it is better to propagate the tailcall info when subprog_tc1
>> is tail_call_reachable.
>
> Okay, I see. Thanks for explanation.
>
> You use the insn->dst_reg to record whether callee is tail call
> reachable or not. I think you can reuse insn->off which currently
> represents subprog number but it is not used for jit. We can
> use that to indicate callee is tail call reachable or not.
>
> Something like below:
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..b3c76bf59e65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2127,7 +2127,8 @@ st:                       if (is_imm8(insn->off))
>                         u8 *ip = image + addrs[i - 1];
>
>                         func = (u8 *) __bpf_call_base + imm32;
> -                       if (tail_call_reachable) {
> +                       /* insn->off == 1 means the callee is tail 
> call reachable */
> +                       if (src_reg == BPF_PSEUDO_CALL && insn->off == 
> 1) {
> LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>                                 ip += 7;
>                         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba..2ccadc1ac22e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20096,6 +20096,8 @@ static int jit_subprogs(struct 
> bpf_verifier_env *env)
>                                 continue;
>                         subprog = insn->off;
>                         insn->imm = 
> BPF_CALL_IMM(func[subprog]->bpf_func);
> +                       /* Indicate whether callee is tail call 
> reachable or not */
> +                       insn->off = 
> func[subprog]->aux->tail_call_reachable;
>                 }
>
> WDYT?

Sorry, the above seems not working since verifier do jit twice for the same prog
and two jit'ed results need to be the same. The above change could make jit result
different between two passes.

>
>>
>> Thanks,
>> Leon
>>
>

