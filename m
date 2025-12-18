Return-Path: <bpf+bounces-77007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC8CCD0D3
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435CA30399BF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032892FC004;
	Thu, 18 Dec 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xy7U9H8q"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BC263C8C
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080568; cv=none; b=uZWwgpTLMjcd2P6JPl2saNvwueXXyFw0eV1vk6snBF8vKhjn30i31yGjbxikq2w5TNIJbCzqhs4pAPd8DoXoUStYlic1KmMW2Tda4BEYvhHaoPbqXJBvNt1iruV0sMdoPaemn3/EnVDGkhvl9LLFQdpW8+n1E1JglmyzHxnUI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080568; c=relaxed/simple;
	bh=NKsJ2LwEFCzr9LYyZn9xL6xxjugnyEOMVERzbCUH+cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcuKbkDjlq1Ra23hZgkxypMuSxBZZszzghdtvuupgE5eOMNmVcqpz+eY8655aPfyF6GaGxvhzr+j+uEm9WruiVwci8wXWu+0+9Nk5sEsSOI3t62jPboC+K7kfDKKqKk3cXz7bDmWdITMtD7BWMDy8bDx0W9QDnY4E22NwicwUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xy7U9H8q; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1728d4e1-ce5c-476e-b057-b8a9a7621e1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766080558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I60R8WA4dxn2gytYZ6r7aYWz8herwWEhg7V+nluk9FU=;
	b=Xy7U9H8qHL77Fx0fPNGKUC/QY21WS3RBSaAH2MUdMGV42LvbEDLbSK8AdrcvH6zE37nbFR
	bbJfYYpgSAxpZjP9D6ZdNRu07Z/3MP0etTvifnPuLjEOdgx6le0/VnD8kz8V21JJ5YTU1j
	Z5eOcH9AzxCtpMjndlEC3UQj50OiS2k=
Date: Thu, 18 Dec 2025 09:55:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf: arm64: Optimize recursion detection
 by not using atomics
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20251217233608.2374187-1-puranjay@kernel.org>
 <20251217233608.2374187-3-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251217233608.2374187-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/17/25 3:35 PM, Puranjay Mohan wrote:
> BPF programs detect recursion using a per-CPU 'active' flag in struct
> bpf_prog. The trampoline currently sets/clears this flag with atomic
> operations.
>
> On some arm64 platforms (e.g., Neoverse V2 with LSE), per-CPU atomic
> operations are relatively slow. Unlike x86_64 - where per-CPU updates
> can avoid cross-core atomicity, arm64 LSE atomics are always atomic
> across all cores, which is unnecessary overhead for strictly per-CPU
> state.
>
> This patch removes atomics from the recursion detection path on arm64 by
> changing 'active' to a per-CPU array of four u8 counters, one per
> context: {NMI, hard-irq, soft-irq, normal}. The running context uses a
> non-atomic increment/decrement on its element.  After increment,
> recursion is detected by reading the array as a u32 and verifying that
> only the expected element changed; any change in another element
> indicates inter-context recursion, and a value > 1 in the same element
> indicates same-context recursion.
>
> For example, starting from {0,0,0,0}, a normal-context trigger changes
> the array to {0,0,0,1}.  If an NMI arrives on the same CPU and triggers
> the program, the array becomes {1,0,0,1}. When the NMI context checks
> the u32 against the expected mask for normal (0x00000001), it observes
> 0x01000001 and correctly reports recursion. Same-context recursion is
> detected analogously.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

LGTM with a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   include/linux/bpf.h | 33 ++++++++++++++++++++++++++++++---
>   kernel/bpf/core.c   |  3 ++-
>   2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2da986136d26..5ca2a761d9a1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -31,6 +31,7 @@
>   #include <linux/static_call.h>
>   #include <linux/memcontrol.h>
>   #include <linux/cfi.h>
> +#include <linux/unaligned.h>
>   #include <asm/rqspinlock.h>
>   
>   struct bpf_verifier_env;
> @@ -1746,6 +1747,8 @@ struct bpf_prog_aux {
>   	struct bpf_map __rcu *st_ops_assoc;
>   };
>   
> +#define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
> +
>   struct bpf_prog {
>   	u16			pages;		/* Number of allocated pages */
>   	u16			jited:1,	/* Is our filter JIT'ed? */
> @@ -1772,7 +1775,7 @@ struct bpf_prog {
>   		u8 tag[BPF_TAG_SIZE];
>   	};
>   	struct bpf_prog_stats __percpu *stats;
> -	int __percpu		*active;
> +	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for rerecursion protection */
>   	unsigned int		(*bpf_func)(const void *ctx,
>   					    const struct bpf_insn *insn);
>   	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
> @@ -2006,12 +2009,36 @@ struct bpf_struct_ops_common_value {
>   
>   static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
>   {
> -	return this_cpu_inc_return(*(prog->active)) == 1;
> +#ifdef CONFIG_ARM64
> +	u8 rctx = interrupt_context_level();
> +	u8 *active = this_cpu_ptr(prog->active);
> +	u32 val;
> +
> +	preempt_disable();
> +	active[rctx]++;
> +	val = get_unaligned_le32(active);

The 'active' already aligned with 8 (or 4 with my below suggestion).
The get_unaligned_le32() works, but maybe we could use le32_to_cpu()
instead. Maybe there is no performance difference between
get_unaligned_le32() and le32_to_cpu() so you pick get_unaligned_le32()?
It would be good to clarify in commit message if get_unaligned_le32()
is used.

> +	preempt_enable();
> +	if (val != BIT(rctx * 8))
> +		return false;
> +
> +	return true;
> +#else
> +	return this_cpu_inc_return(*(int __percpu *)(prog->active)) == 1;
> +#endif
>   }
>   
>   static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
>   {
> -	this_cpu_dec(*(prog->active));
> +#ifdef CONFIG_ARM64
> +	u8 rctx = interrupt_context_level();
> +	u8 *active = this_cpu_ptr(prog->active);
> +
> +	preempt_disable();
> +	active[rctx]--;
> +	preempt_enable();
> +#else
> +	this_cpu_dec(*(int __percpu *)(prog->active));
> +#endif
>   }
>   
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c66316e32563..b5063acfcf92 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>   		vfree(fp);
>   		return NULL;
>   	}
> -	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
> +	fp->active = __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 8,
> +					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));

Here, the alignment is 8. Can it be 4 since the above reads a 32bit value?

>   	if (!fp->active) {
>   		vfree(fp);
>   		kfree(aux);


