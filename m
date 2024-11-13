Return-Path: <bpf+bounces-44814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBE9C7E40
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4221283151
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB118C012;
	Wed, 13 Nov 2024 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P+2+6THy"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2017837A
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536904; cv=none; b=Ez/GxxLnEWGJ3TX7vO+fDZLX71jp6iEzxktmz6GEC1FcIjsdEitrE9jzYNb/2hkhj9hguWbM1bMbo332mLvEMW/bdI3ExYosKhKvOrtu+93Xnl/KYzYZ2nIIqNIHkA4HfCi1JLi65cORG2GQJZlj1zqpvkO1mMSnJiaLUq9Vsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536904; c=relaxed/simple;
	bh=9Oi9SzddF7SAmmZw47WSbfZDNY+k8EX0FsJFqTxhxPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6BHYjlCBydRskkNhstOaZBQlPvrfb5sHCOFnUQs5Im5vM5holu5fjJaNOPrM2u51XYPVVwoIuWFMbuTPO7rw9v8yr7TeuAxyJs4sZo81EPVdQt3gW4a5rWrkFG0eQf/mU1Ye5BRHxkKyQL9dWfz8wkn/pVGtB1poxw/bOlK5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P+2+6THy; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <57894723-e8ba-44f3-8c0c-0b5455069405@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731536900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YA+sar+UfDoTn7b45l7dUjawDtemYWtc1FWgPB/U/qY=;
	b=P+2+6THyLX1sfMTuQeV3E6KrEIcHnWxnAyP+dgjjd0Mgevz6IPrfgWjRCLe29Q46JBF7Q3
	9R57ibjjxQGWNzrqAAD78Dk0S8lZdrSDUT+ihe1N2o2yF2tPa9FqS5bHlIOtHgBOwCyD0m
	QtB7ANl6ipX5iMgmXqfyv2+2rq0bImk=
Date: Wed, 13 Nov 2024 22:28:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
To: Yonghong Song <yonghong.song@linux.dev>, Vadim Fedorenko
 <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
 <3c10fd70-ef6d-4762-b5a4-7ed912d97693@linux.dev>
 <27ee9031-3304-49a5-ac82-0fbe50294646@linux.dev>
 <bcb4f6eb-737c-4023-b643-8d27105438fc@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <bcb4f6eb-737c-4023-b643-8d27105438fc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 18:42, Yonghong Song wrote:
> 
> 
> 
> On 11/13/24 9:52 AM, Vadim Fedorenko wrote:
>> On 13/11/2024 17:38, Yonghong Song wrote:
>>>
>>>
>>>
>>> On 11/8/24 4:41 PM, Vadim Fedorenko wrote:
>>>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>>>> it into rdtsc ordered call. Other architectures will get JIT
>>>> implementation too if supported. The fallback is to
>>>> __arch_get_hw_counter().
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>>> ---
>>>> v4 -> v5:
>>>> * use if instead of ifdef with IS_ENABLED
>>>> v3 -> v4:
>>>> * change name of the helper to bpf_get_cpu_cycles (Andrii)
>>>> * Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
>>>>    it on architectures which do not have vDSO functions and data
>>>> * reduce the scope of check of inlined functions in verifier to only 2,
>>>>    which are actually inlined.
>>>> v2 -> v3:
>>>> * change name of the helper to bpf_get_cpu_cycles_counter to explicitly
>>>>    mention what counter it provides (Andrii)
>>>> * move kfunc definition to bpf.h to use it in JIT.
>>>> * introduce another kfunc to convert cycles into nanoseconds as more
>>>>    meaningful time units for generic tracing use case (Andrii)
>>>> v1 -> v2:
>>>> * Fix incorrect function return value type to u64
>>>> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>>>>    mark_fastcall_pattern_for_call() to avoid clobbering in case of
>>>>    running programs with no JIT (Eduard)
>>>> * Avoid rewriting instruction and check function pointer directly
>>>>    in JIT (Alexei)
>>>> * Change includes to fix compile issues on non x86 architectures
>>>> ---
>>>>   arch/x86/net/bpf_jit_comp.c   | 28 ++++++++++++++++++++++++++++
>>>>   arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++++
>>>>   include/linux/bpf.h           |  5 +++++
>>>>   include/linux/filter.h        |  1 +
>>>>   kernel/bpf/core.c             | 11 +++++++++++
>>>>   kernel/bpf/helpers.c          | 13 +++++++++++++
>>>>   kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
>>>>   7 files changed, 101 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index 06b080b61aa5..4f78ed93ee7f 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -2126,6 +2126,26 @@ st:            if (is_imm8(insn->off))
>>>>           case BPF_JMP | BPF_CALL: {
>>>>               u8 *ip = image + addrs[i - 1];
>>>> +            if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>>> +                imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>>> +                /* Save RDX because RDTSC will use EDX:EAX to 
>>>> return u64 */
>>>> +                emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>>>> +                if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>>>> +                    EMIT_LFENCE();
>>>> +                EMIT2(0x0F, 0x31);
>>>> +
>>>> +                /* shl RDX, 32 */
>>>> +                maybe_emit_1mod(&prog, BPF_REG_3, true);
>>>> +                EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>>>> +                /* or RAX, RDX */
>>>> +                maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>>>> +                EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>>>> +                /* restore RDX from R11 */
>>>> +                emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
>>>> +
>>>> +                break;
>>>> +            }
>>>> +
>>>>               func = (u8 *) __bpf_call_base + imm32;
>>>>               if (tail_call_reachable) {
>>>> LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>>> @@ -3652,3 +3672,11 @@ u64 bpf_arch_uaddress_limit(void)
>>>>   {
>>>>       return 0;
>>>>   }
>>>> +
>>>> +/* x86-64 JIT can inline kfunc */
>>>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>>>> +{
>>>> +    if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
>>>> +        return true;
>>>> +    return false;
>>>> +}
>>>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/ 
>>>> bpf_jit_comp32.c
>>>> index de0f9e5f9f73..e6097a371b69 100644
>>>> --- a/arch/x86/net/bpf_jit_comp32.c
>>>> +++ b/arch/x86/net/bpf_jit_comp32.c
>>>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, 
>>>> int *addrs, u8 *image,
>>>>               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>>                   int err;
>>>> +                if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>>> +                    if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>>>> +                        EMIT3(0x0F, 0xAE, 0xE8);
>>>> +                    EMIT2(0x0F, 0x31);
>>>> +                    break;
>>>> +                }
>>>> +
>>>>                   err = emit_kfunc_call(bpf_prog,
>>>>                                 image + addrs[i],
>>>>                                 insn, &prog);
>>>> @@ -2621,3 +2628,10 @@ bool bpf_jit_supports_kfunc_call(void)
>>>>   {
>>>>       return true;
>>>>   }
>>>> +
>>>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>>>> +{
>>>> +    if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
>>>> +        return true;
>>>> +    return false;
>>>> +}
>>>
>>> [...]
>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 395221e53832..5c6c0383ebf4 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -23,6 +23,9 @@
>>>>   #include <linux/btf_ids.h>
>>>>   #include <linux/bpf_mem_alloc.h>
>>>>   #include <linux/kasan.h>
>>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>>> +#include <vdso/datapage.h>
>>>> +#endif
>>>>   #include "../../lib/kstrtox.h"
>>>> @@ -3023,6 +3026,13 @@ __bpf_kfunc int bpf_copy_from_user_str(void 
>>>> *dst, u32 dst__sz, const void __user
>>>>       return ret + 1;
>>>>   }
>>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>>> +__bpf_kfunc u64 bpf_get_cpu_cycles(void)
>>>> +{
>>>> +    return __arch_get_hw_counter(1, NULL);
>>>
>>> Some comment to explain what '1' mean in the above?
>>
>> That's arch-specific value which translates to HW implemented counter on
>> all architectures which have vDSO gettimeofday() implementation.
>>
>> For x86 it translates to VDSO_CLOCKMODE_TSC, while for aarch64/RISC-V
>> it's VDSO_CLOCKMODE_ARCHTIMER. Actually, for RISC-V the value of the
>> first parameter doesn't matter at all, for aarch64 it should be 0.
>> The only arch which is more strict about this parameter is x86, but it
>> has it's own special name...
> 
> So in the future, if we want add aarch64 support or other architecture,
> the argument could be different, right?

No, that's the point. This value will be the same for all architectures.
I'll do the implementation for aarch64 once this series is in.

> 
> I think we should avoid to have arch specific control in helpers.c.
> How about we define a __weak func like bpf_arch_get_hw_counter() so we
> have
> 
> __bpf_kfunc u64 bpf_get_cpu_cycles(void)
> {
>      return bpf_arch_get_hw_counter();
> }
> 
> Each arch can implement their own bpf_arch_get_hw_counter().
> Do you think this will make more sense? This should not impact jit inlining
> of this kfunc.
> 
>>
>>>
>>>> +}
>>>> +#endif
>>>> +
>>>>   __bpf_kfunc_end_defs();
>>>>   BTF_KFUNCS_START(generic_btf_ids)
>>>> @@ -3115,6 +3125,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | 
>>>> KF_SLEEPABLE)
>>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | 
>>>> KF_RET_NULL | KF_SLEEPABLE)
>>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | 
>>>> KF_SLEEPABLE)
>>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>>> +BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
>>>> +#endif
>>>>   BTF_KFUNCS_END(common_btf_ids)
>>>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>>> [...]
>>
> 


