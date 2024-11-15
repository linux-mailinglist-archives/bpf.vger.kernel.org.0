Return-Path: <bpf+bounces-44994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EE9CF96A
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 23:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505E628AEAA
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDD20495E;
	Fri, 15 Nov 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHCtA3wT"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EE6204934
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707691; cv=none; b=d8vTyW1NPRm8MWBNYy68li9H/oERzMMSuzqaoGm5j+Os1wwquZPSEuzr+7MwIyfh4smHVs0yZiO/orCzbVq9orC8wPgMckRqhA7Psdgs25ucTYb56hx0gUUrzCPh6QTXWlVAU9tS/YhRn0VsxW4QyfZTEiThuDBMPB50b1slfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707691; c=relaxed/simple;
	bh=UQajRaSLsBL7pg7h1+0C7DEjl70JEpI/uP4Uz/N2m98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Np8V6hduW8o1HS0UvyP3JBfcCzZjFRQR7yeQKkUTTOiSb7w5SRrJllbkwOr7sriQClvDG4zxL29A5910vaLM++5IYN9jbI8HwWMd9gjN8OD++7L7iNJ80RodCuZphEuWThwTXf0X51Z4fjNjHoXGiDRwr2Vbdu5N+dYW6Np3GpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHCtA3wT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6eb8ab6-2db4-40dc-9ce5-3f0985c93f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731707685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRmb96yZ9RNaJd0plG0WzCpDuzgYQDks6kSUyNZftRc=;
	b=OHCtA3wTfdJKICSzusu5wkk+pTMvuT5ZbdzLQ3CmGTggBoIizNJwnkC6rpfNBTbOzs6g45
	LgwW9ZHFfsR7zGXBkX/BpLBewEwyuHFGtYK5m12JKguGfTNDfBCEoNeTlwzTKsGzvuiLE0
	VGpFJSoeHGZsOnqKFdhdmUYO1zo7jzs=
Date: Fri, 15 Nov 2024 13:54:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/4] bpf: add bpf_get_cpu_cycles kfunc
Content-Language: en-GB
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>
Cc: x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20241115194841.2108634-1-vadfed@meta.com>
 <20241115194841.2108634-2-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241115194841.2108634-2-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/15/24 11:48 AM, Vadim Fedorenko wrote:
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

LGTM with a small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
> v5 -> v6:
> * add comment about dropping S64_MAX manipulation in jitted
>    implementation of rdtsc_oredered (Alexey)
> * add comment about using 'lfence;rdtsc' variant (Alexey)
> * change the check in fixup_kfunc_call() (Eduard)
> * make __arch_get_hw_counter() call more aligned with vDSO
>    implementation (Yonghong)
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
>   arch/x86/net/bpf_jit_comp.c   | 39 +++++++++++++++++++++++++++++++++
>   arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++
>   include/linux/bpf.h           |  5 +++++
>   include/linux/filter.h        |  1 +
>   kernel/bpf/core.c             | 11 ++++++++++
>   kernel/bpf/helpers.c          | 21 ++++++++++++++++++
>   kernel/bpf/verifier.c         | 41 ++++++++++++++++++++++++++++++-----
>   7 files changed, 126 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a43fc5af973d..107bd921f104 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2185,6 +2185,37 @@ st:			if (is_imm8(insn->off))
>   		case BPF_JMP | BPF_CALL: {
>   			u8 *ip = image + addrs[i - 1];
>   
> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> +				/* The default implementation of this kfunc uses
> +				 * __arch_get_hw_counter() which is implemented as
> +				 * `(u64)rdtsc_ordered() & S64_MAX`. We skip masking
> +				 * part because we assume it's not needed in BPF
> +				 * use case (two measurements close in time).
> +				 * Original code for rdtsc_ordered() uses sequence:
> +				 * 'rdtsc; nop; nop; nop' to patch it into
> +				 * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
> +				 * JIT uses 'lfence; rdtsc' variant because BPF program
> +				 * doesn't care about cookie provided by rdtsp in RCX.

rdtsp -> tdtscp?

> +				 * Save RDX because RDTSC will use EDX:EAX to return u64
> +				 */
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
>   			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>   				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> @@ -3791,3 +3822,11 @@ u64 bpf_arch_uaddress_limit(void)
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
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3ace0d6227e3..43a5207a1591 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3333,6 +3333,11 @@ void bpf_user_rnd_init_once(void);
>   u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>   u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>   
> +/* Inlined kfuncs */
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +u64 bpf_get_cpu_cycles(void);
> +#endif
> +
>   #if defined(CONFIG_NET)
>   bool bpf_sock_common_is_valid_access(int off, int size,
>   				     enum bpf_access_type type,
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 3a21947f2fd4..9cf57233874f 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1111,6 +1111,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
>   void bpf_jit_compile(struct bpf_prog *prog);
>   bool bpf_jit_needs_zext(void);
>   bool bpf_jit_inlines_helper_call(s32 imm);
> +bool bpf_jit_inlines_kfunc_call(s32 imm);
>   bool bpf_jit_supports_subprog_tailcalls(void);
>   bool bpf_jit_supports_percpu_insn(void);
>   bool bpf_jit_supports_kfunc_call(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 14d9288441f2..daa3ab458c8a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2965,6 +2965,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
>   	return false;
>   }
>   
> +/* Return true if the JIT inlines the call to the kfunc corresponding to
> + * the imm.
> + *
> + * The verifier will not patch the insn->imm for the call to the helper if
> + * this returns true.
> + */
> +bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
> +{
> +	return false;
> +}
> +
>   /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
>   bool __weak bpf_jit_supports_subprog_tailcalls(void)
>   {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 751c150f9e1c..12d40537e57b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,10 @@
>   #include <linux/btf_ids.h>
>   #include <linux/bpf_mem_alloc.h>
>   #include <linux/kasan.h>
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +#include <vdso/datapage.h>
> +#include <asm/vdso/vsyscall.h>
> +#endif
>   
>   #include "../../lib/kstrtox.h"
>   
> @@ -3057,6 +3061,20 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
>   	return ret + 1;
>   }
>   
> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
> +__bpf_kfunc u64 bpf_get_cpu_cycles(void)
> +{
> +	const struct vdso_data *vd = __arch_get_k_vdso_data();
> +
> +	vd = &vd[CS_RAW];
> +
> +	/* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and
> +	 * to VDSO_CLOCKMODE_ARCHTIMER on aarch64/risc-v.
> +	 */
> +	return __arch_get_hw_counter(vd->clock_mode, vd);
> +}
> +#endif
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(generic_btf_ids)
> @@ -3149,6 +3167,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
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

