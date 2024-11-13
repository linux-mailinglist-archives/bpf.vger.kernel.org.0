Return-Path: <bpf+bounces-44784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1559C7A84
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B21B27D5A
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5A201253;
	Wed, 13 Nov 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lU8/i2xO"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BA200CB6
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519533; cv=none; b=m50pmnd9ozw5exJG+SQNFdJXmG989OzJdjwGyL4i4BLRrj5+9sCaCIoKXVLOrpGrTYrCM2OMYIE7u+ZeWOzxoGOA3mVAv4jVKz4Ub2FKctpES/gmp8skZZXgjY3CY0mfNQFxejQTL53VRRqw2nWAwBRuXxcCXCmqT3J/lUrEX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519533; c=relaxed/simple;
	bh=+peNhwPwbEOFER7sBdyFFnQmeuHeJYr1P37IvqL6iLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgamqzOTb4/Kw5Q5gxMGh3eC88Oi8wGdELI4wDasx49dWbzqNKc4+SqYfnc5YmsP5xaD3+KTuYYLiS+lLWUSqfTnJOn7dK6u/fMVJnNuSsqORgy8S0cBuFctGEJnS0eLcVFwjb4SmChR3At0Q+GJvJbC1XinU28drYvxPFBi/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lU8/i2xO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c10fd70-ef6d-4762-b5a4-7ed912d97693@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731519528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bC2jec5gd8V6EVdDRchp+EbDAZJ40KM6M5FM7KDv4FM=;
	b=lU8/i2xOnsmL86e4MI89LdgG8OY95Hi4KdGq8dhp7t8XX8TAbsEUKW5jXOtPb46mnmN/uT
	pKv0GgBEk1U8PDwlXamvFG7xPUHbfRomTf7LqAXdJkk+aYpt/NBvAURfOjYXdvHxcMqOpd
	/9HD0G5T3qpGbuf8FccEImyMTAI3UVA=
Date: Wed, 13 Nov 2024 09:38:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
Content-Language: en-GB
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mykola Lysenko
 <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20241109004158.2259301-1-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241109004158.2259301-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 4:41 PM, Vadim Fedorenko wrote:
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v4 -> v5:
> * use if instead of ifdef with IS_ENABLED
> v3 -> v4:
> * change name of the helper to bpf_get_cpu_cycles (Andrii)
> * Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
>    it on architectures which do not have vDSO functions and data
> * reduce the scope of check of inlined functions in verifier to only 2,
>    which are actually inlined.
> v2 -> v3:
> * change name of the helper to bpf_get_cpu_cycles_counter to explicitly
>    mention what counter it provides (Andrii)
> * move kfunc definition to bpf.h to use it in JIT.
> * introduce another kfunc to convert cycles into nanoseconds as more
>    meaningful time units for generic tracing use case (Andrii)
> v1 -> v2:
> * Fix incorrect function return value type to u64
> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>    mark_fastcall_pattern_for_call() to avoid clobbering in case of
>    running programs with no JIT (Eduard)
> * Avoid rewriting instruction and check function pointer directly
>    in JIT (Alexei)
> * Change includes to fix compile issues on non x86 architectures
> ---
>   arch/x86/net/bpf_jit_comp.c   | 28 ++++++++++++++++++++++++++++
>   arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++++
>   include/linux/bpf.h           |  5 +++++
>   include/linux/filter.h        |  1 +
>   kernel/bpf/core.c             | 11 +++++++++++
>   kernel/bpf/helpers.c          | 13 +++++++++++++
>   kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
>   7 files changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..4f78ed93ee7f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2126,6 +2126,26 @@ st:			if (is_imm8(insn->off))
>   		case BPF_JMP | BPF_CALL: {
>   			u8 *ip = image + addrs[i - 1];
>   
> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> +				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
> +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
> +				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> +					EMIT_LFENCE();
> +				EMIT2(0x0F, 0x31);
> +
> +				/* shl RDX, 32 */
> +				maybe_emit_1mod(&prog, BPF_REG_3, true);
> +				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
> +				/* or RAX, RDX */
> +				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
> +				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
> +				/* restore RDX from R11 */
> +				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
> +
> +				break;
> +			}
> +
>   			func = (u8 *) __bpf_call_base + imm32;
>   			if (tail_call_reachable) {
>   				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> @@ -3652,3 +3672,11 @@ u64 bpf_arch_uaddress_limit(void)
>   {
>   	return 0;
>   }
> +
> +/* x86-64 JIT can inline kfunc */
> +bool bpf_jit_inlines_kfunc_call(s32 imm)
> +{
> +	if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
> +		return true;
> +	return false;
> +}
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
> index de0f9e5f9f73..e6097a371b69 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>   			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>   				int err;
>   
> +				if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> +					if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> +						EMIT3(0x0F, 0xAE, 0xE8);
> +					EMIT2(0x0F, 0x31);
> +					break;
> +				}
> +
>   				err = emit_kfunc_call(bpf_prog,
>   						      image + addrs[i],
>   						      insn, &prog);
> @@ -2621,3 +2628,10 @@ bool bpf_jit_supports_kfunc_call(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_inlines_kfunc_call(s32 imm)
> +{
> +	if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
> +		return true;
> +	return false;
> +}

[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 395221e53832..5c6c0383ebf4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,9 @@
>   #include <linux/btf_ids.h>
>   #include <linux/bpf_mem_alloc.h>
>   #include <linux/kasan.h>
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +#include <vdso/datapage.h>
> +#endif
>   
>   #include "../../lib/kstrtox.h"
>   
> @@ -3023,6 +3026,13 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
>   	return ret + 1;
>   }
>   
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +__bpf_kfunc u64 bpf_get_cpu_cycles(void)
> +{
> +	return __arch_get_hw_counter(1, NULL);

Some comment to explain what '1' mean in the above?

> +}
> +#endif
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(generic_btf_ids)
> @@ -3115,6 +3125,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
> +#endif
>   BTF_KFUNCS_END(common_btf_ids)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {
[...]

