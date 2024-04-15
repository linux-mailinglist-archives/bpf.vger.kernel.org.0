Return-Path: <bpf+bounces-26751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6538A48C3
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3388B22F82
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247822EFB;
	Mon, 15 Apr 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfwz+WxX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72E22638
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165227; cv=none; b=iZLjleiND/XV2udk+7+lCmT8nbseRO4px/8jpLEAKxVyETbG0q3kpMj9SpaHNGb72bHii/jXAqKfs63XrXpMKMM8zrcU88LZ+VUzLp4FduxlJ2g2BODEcTxz73P7AHbF/wFnHZmS4TD6tYdHyNAJq4b5r4cDU+5aYCoiMPG+cJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165227; c=relaxed/simple;
	bh=hI1ImZuD4MtyBx70PUSFix6Ajtea0wMbCKe8L/3v+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3FFaak7BaB4FRkfbrszpLQ1ZQCxRcHQh3OgLOZk1+T9kUh+sOsheFlms6lWY1vhx9ag2MkvlJi4IeTcbZqyZ3FflJZpKwAOaAQBNaUCi15xedBIu33V/sFHJ1c0w0+k2ZgaCFJvBjfA+zqugM4Rp/VM8YMMZNg0BcLRbU9GgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfwz+WxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF96C32786;
	Mon, 15 Apr 2024 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713165227;
	bh=hI1ImZuD4MtyBx70PUSFix6Ajtea0wMbCKe8L/3v+Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kfwz+WxX4OnZCXGFtjBzjL9126WIkdrbjltIC8HAHlnoFmUHRdTxctELKKeDm3/G3
	 0KpuRm2j9xyTgugEs3AJUH0reYdRAqSLjrD2xMAdgwz2/pBTa1U26p1rg2Ivg5H4Qq
	 td+149Vd7AD+yzKZOTyLPyE2DDKdUMQdrUQ/blgav/mJ7SW2z1CdViCOZ5Q1qImmHx
	 iQpS/a6Sn6pES0kXsdO/iE7gout/0mGCogD26pMxeEJvlQssheoqIJBA4UUupmROd/
	 4f5oAxom4n+SWtO1yf87LvEkyoUBBS05Muyq07R4dlHGUB1AcG5VBJ9Om7TSnzB//l
	 g9aTHmbIc8oOw==
Date: Mon, 15 Apr 2024 12:42:43 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH v3 2/2] powerpc/bpf: enable kfunc call
Message-ID: <6ktv57iaptqnquimayjyqbpjrmedyenvdrobx3dkxei7for75n@w3uzj4rvvivt>
References: <20240402105806.352037-1-hbathini@linux.ibm.com>
 <20240402105806.352037-2-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105806.352037-2-hbathini@linux.ibm.com>

On Tue, Apr 02, 2024 at 04:28:06PM +0530, Hari Bathini wrote:
> Currently, bpf jit code on powerpc assumes all the bpf functions and
> helpers to be kernel text. This is false for kfunc case, as function
> addresses can be module addresses as well. So, ensure module addresses
> are supported to enable kfunc support.
> 
> Emit instructions based on whether the function address is kernel text
> address or module address to retain optimized instruction sequence for
> kernel text address case.
> 
> Also, as bpf programs are always module addresses and a bpf helper can
> be within kernel address as well, using relative addressing often fails
> with "out of range of pcrel address" error. Use unoptimized instruction
> sequence for both kernel and module addresses to work around this, when
> PCREL addressing is used.

I guess we need a fixes tag for this?
Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")

It will be good to separate out this fix into a separate patch.

Also, I know I said we could use the generic PPC_LI64() for pcrel, but 
we may be able to use a more optimized sequence when calling bpf kernel 
helpers.  See stub_insns[] in module_64.c for an example where we load 
paca->kernelbase, then use a prefixed load instruction to populate the 
lower 34-bit value. For calls out to module area, we can use the generic 
PPC_LI64() macro only if it is outside range of a prefixed load 
instruction.

> 
> With module addresses supported, override bpf_jit_supports_kfunc_call()
> to enable kfunc support. Since module address offsets can be more than
> 32-bit long on PPC64, override bpf_jit_supports_far_kfunc_call() to
> enable 64-bit pointers.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> * Changes in v3:
>   - Retained optimized instruction sequence when function address is
>     a core kernel address as suggested by Naveen.
>   - Used unoptimized instruction sequence for PCREL addressing to
>     avoid out of range errors for core kernel function addresses.
>   - Folded patch that adds support for kfunc calls with patch that
>     enables/advertises this support as suggested by Naveen.
> 
> 
>  arch/powerpc/net/bpf_jit_comp.c   | 10 +++++++
>  arch/powerpc/net/bpf_jit_comp64.c | 48 ++++++++++++++++++++-----------
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 0f9a21783329..dc7ffafd7441 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -359,3 +359,13 @@ void bpf_jit_free(struct bpf_prog *fp)
>  
>  	bpf_prog_unlock_free(fp);
>  }
> +
> +bool bpf_jit_supports_kfunc_call(void)
> +{
> +	return true;
> +}
> +
> +bool bpf_jit_supports_far_kfunc_call(void)
> +{
> +	return IS_ENABLED(CONFIG_PPC64) ? true : false;
> +}
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c 
> b/arch/powerpc/net/bpf_jit_comp64.c
> index 7f62ac4b4e65..ec3adf715c55 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -207,24 +207,14 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>  	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>  	long reladdr;
>  
> -	if (WARN_ON_ONCE(!core_kernel_text(func_addr)))
> +	/*
> +	 * With the introduction of kfunc feature, BPF helpers can be part of kernel as
> +	 * well as module text address.
> +	 */
> +	if (WARN_ON_ONCE(!kernel_text_address(func_addr)))
>  		return -EINVAL;
>  
> -	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
> -		reladdr = func_addr - CTX_NIA(ctx);
> -
> -		if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {
> -			pr_err("eBPF: address of %ps out of range of pcrel address.\n",
> -				(void *)func);
> -			return -ERANGE;
> -		}
> -		/* pla r12,addr */
> -		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(1) | IMM_H18(reladdr));
> -		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | IMM_L(reladdr));
> -		EMIT(PPC_RAW_MTCTR(_R12));
> -		EMIT(PPC_RAW_BCTR());
> -
> -	} else {
> +	if (core_kernel_text(func_addr) && !IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
>  		reladdr = func_addr - kernel_toc_addr();
>  		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
>  			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
> @@ -235,6 +225,32 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>  		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
>  		EMIT(PPC_RAW_MTCTR(_R12));
>  		EMIT(PPC_RAW_BCTRL());
> +	} else {
> +		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1)) {
> +			/* func points to the function descriptor */
> +			PPC_LI64(bpf_to_ppc(TMP_REG_2), func);
> +			/* Load actual entry point from function descriptor */
> +			EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
> +			/* ... and move it to CTR */
> +			EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
> +			/*
> +			 * Load TOC from function descriptor at offset 8.
> +			 * We can clobber r2 since we get called through a
> +			 * function pointer (so caller will save/restore r2)
> +			 * and since we don't use a TOC ourself.
> +			 */
> +			EMIT(PPC_RAW_LD(2, bpf_to_ppc(TMP_REG_2), 8));
> +			EMIT(PPC_RAW_BCTRL());

I thought we started using TOC for ABIv1 when we moved to using an 
optimized function call sequence for bpf helpers?  If so, we will need 
to load kernel toc here for subsequent calls to BPF helpers.

> +		} else {
> +			/* We can clobber r12 */
> +			PPC_LI64(12, func);
> +			EMIT(PPC_RAW_MTCTR(12));
> +			EMIT(PPC_RAW_BCTRL());
> +#ifndef CONFIG_PPC_KERNEL_PCREL
> +			/* Restore kernel TOC */
> +			EMIT(PPC_RAW_LD(2, 13, offsetof(struct paca_struct, kernel_toc)));
> +#endif
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.44.0
> 

- Naveen


