Return-Path: <bpf+bounces-56274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13990A94308
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A4D8A3274
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F271D5143;
	Sat, 19 Apr 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YabAh6e1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7381BE4E;
	Sat, 19 Apr 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745060824; cv=none; b=oQB0FTYT4qCXnk6rM9SgCa44CcB39bWaoEtjw0qn8qiMyEdPNshDjVeYf6EJHR8HVMvD5fNkuJkTG9JID50vqqM7jew8NrsRQ0RaUVz8Y7cECecBdvWc7YNiSf4CXBoTzRCcgQ3YNumWINOlM2Lr56+DNifqjBj6cEU8yD0KsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745060824; c=relaxed/simple;
	bh=DSPAM263iwNs6J7exfjk+BXtsBHZVOZpvJhNDpyAmyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTlrKJw/BMfIHGURtkMsS4sdret7DhuIfpUJqTt7jaVphKez4hFmhjIGjX5mCWeiCPV4TT0x/SQJBm1qRWhKktEmQoK/6XAgqMnWxUPcO7LhcjrdNc/+CLavFvGd33z8H8pAw+Iiy/ncKQ0kSHD3LmHfg3bsXT+l0f8XxE+VjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YabAh6e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884DFC4CEE7;
	Sat, 19 Apr 2025 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745060824;
	bh=DSPAM263iwNs6J7exfjk+BXtsBHZVOZpvJhNDpyAmyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YabAh6e1h9zcx77wIQ1BxgBVBvygWOrUgtb3HYbDgkq0LSnrLYfl0KVxbPQa+rtLn
	 D6Vnotxm2gFI49YQJsZxcFzykAUgegr7YG2H2A5CM/Ax68zbbINK7Mt0aPmVx0mmI2
	 9mfiHaIYFdPO2QTk3zrKicClMO1/dMpHseMebVFXY2FVSuiW0BqVUxHD1kaViO3qt7
	 ci6mmx4YkNWAUiWvFkXz/Ytabi5TU6xzLkAXDZW3pbU34gJn6CRhf4db2r7EcSk9UJ
	 HRT80iXfrVRbVLg6HaDssWpgxgzCX/2ZEuwhnd9HYVfUmy+1RRudDEyA6NQbUE5OPN
	 0quiBMnH9KTYA==
Date: Sat, 19 Apr 2025 16:31:15 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc64/bpf: fix JIT code size calculation of bpf
 trampoline
Message-ID: <imwcjnoebhice2omsuaakozniph57chxuj2idzbe3dcaqb677l@inx53g65yusp>
References: <20250416194037.204424-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416194037.204424-1-hbathini@linux.ibm.com>

On Thu, Apr 17, 2025 at 01:10:37AM +0530, Hari Bathini wrote:
> arch_bpf_trampoline_size() provides JIT size of the BPF trampoline
> before the buffer for JIT'ing it is allocated. The total number of
> instructions emitted for BPF trampoline JIT code depends on where
> the final image is located. So, the size arrived at with the dummy
> pass in arch_bpf_trampoline_size() can vary from the actual size
> needed in  arch_prepare_bpf_trampoline().  When the instructions
> accounted in  arch_bpf_trampoline_size() is less than the number of
> instructions emitted during the actual JIT compile of the trampoline,
> the below warning is produced:
> 
>   WARNING: CPU: 8 PID: 204190 at arch/powerpc/net/bpf_jit_comp.c:981 __arch_prepare_bpf_trampoline.isra.0+0xd2c/0xdcc
> 
> which is:
> 
>   /* Make sure the trampoline generation logic doesn't overflow */
>   if (image && WARN_ON_ONCE(&image[ctx->idx] >
>   			(u32 *)rw_image_end - BPF_INSN_SAFETY)) {
> 
> So, during the dummy pass, instead of providing some arbitrary image
> location, account for maximum possible instructions if and when there
> is a dependency with image location for JIT'ing.
> 
> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com/
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> Changes since v1:
> - Pass NULL for image during intial pass and account for max. possible
>   instruction during this pass as Naveen suggested.
> 
> 
>  arch/powerpc/net/bpf_jit.h        | 20 ++++++++++++++++---
>  arch/powerpc/net/bpf_jit_comp.c   | 33 ++++++++++---------------------
>  arch/powerpc/net/bpf_jit_comp64.c |  9 +++++++++
>  3 files changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 6beacaec63d3..4c26912c2e3c 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -51,8 +51,16 @@
>  		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
>  	} while (0)
>  
> -/* Sign-extended 32-bit immediate load */
> +/*
> + * Sign-extended 32-bit immediate load
> + *
> + * If this is a dummy pass (!image), account for
> + * maximum possible instructions.
> + */
>  #define PPC_LI32(d, i)		do {					      \
> +	if (!image)							      \
> +		ctx->idx += 2;						      \
> +	else {								      \
>  		if ((int)(uintptr_t)(i) >= -32768 &&			      \
>  				(int)(uintptr_t)(i) < 32768)		      \
>  			EMIT(PPC_RAW_LI(d, i));				      \
> @@ -60,10 +68,15 @@
>  			EMIT(PPC_RAW_LIS(d, IMM_H(i)));			      \
>  			if (IMM_L(i))					      \
>  				EMIT(PPC_RAW_ORI(d, d, IMM_L(i)));	      \
> -		} } while(0)
> +		}							      \
> +	} } while (0)
>  
>  #ifdef CONFIG_PPC64
> +/* If dummy pass (!image), account for maximum possible instructions */
>  #define PPC_LI64(d, i)		do {					      \
> +	if (!image)							      \
> +		ctx->idx += 5;						      \
> +	else {								      \
>  		if ((long)(i) >= -2147483648 &&				      \
>  				(long)(i) < 2147483648)			      \
>  			PPC_LI32(d, i);					      \
> @@ -84,7 +97,8 @@
>  			if ((uintptr_t)(i) & 0x000000000000ffffULL)	      \
>  				EMIT(PPC_RAW_ORI(d, d, (uintptr_t)(i) &       \
>  							0xffff));             \
> -		} } while (0)
> +		}							      \
> +	} } while (0)

You should now also be able to remove the padding we add in 
bpf_jit_comp64.c for 'case BPF_LD | BPF_IMM | BPF_DW:'

>  #define PPC_LI_ADDR	PPC_LI64
>  
>  #ifndef CONFIG_PPC_KERNEL_PCREL
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 2991bb171a9b..c0684733e9d6 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -504,10 +504,11 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
>  	EMIT(PPC_RAW_ADDI(_R3, _R1, regs_off));
>  	if (!p->jited)
>  		PPC_LI_ADDR(_R4, (unsigned long)p->insnsi);
> -	if (!create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx], (unsigned long)p->bpf_func,
> -			   BRANCH_SET_LINK)) {
> -		if (image)
> -			image[ctx->idx] = ppc_inst_val(branch_insn);
> +	/* Account for max possible instructions during dummy pass for size calculation */
> +	if (image && !create_branch(&branch_insn, (u32 *)&ro_image[ctx->idx],
> +				    (unsigned long)p->bpf_func,
> +				    BRANCH_SET_LINK)) {
> +		image[ctx->idx] = ppc_inst_val(branch_insn);
>  		ctx->idx++;
>  	} else {
>  		EMIT(PPC_RAW_LL(_R12, _R25, offsetof(struct bpf_prog, bpf_func)));
> @@ -889,7 +890,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  			bpf_trampoline_restore_tail_call_cnt(image, ctx, func_frame_offset, r4_off);
>  
>  		/* Reserve space to patch branch instruction to skip fexit progs */
> -		im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
> +		if (ro_image) /* image is NULL for dummy pass */
> +			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
>  		EMIT(PPC_RAW_NOP());
>  	}
>  
> @@ -912,7 +914,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  		}
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
> +		if (ro_image) /* image is NULL for dummy pass */
> +			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
>  		PPC_LI_ADDR(_R3, im);
>  		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
>  						 (unsigned long)__bpf_tramp_exit);
> @@ -973,25 +976,9 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>  			     struct bpf_tramp_links *tlinks, void *func_addr)
>  {
>  	struct bpf_tramp_image im;
> -	void *image;
>  	int ret;
>  
> -	/*
> -	 * Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 * This will NOT cause fragmentation in direct map, as we do not
> -	 * call set_memory_*() on this buffer.
> -	 *
> -	 * We cannot use kvmalloc here, because we need image to be in
> -	 * module memory range.
> -	 */
> -	image = bpf_jit_alloc_exec(PAGE_SIZE);
> -	if (!image)
> -		return -ENOMEM;
> -
> -	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
> -					    m, flags, tlinks, func_addr);
> -	bpf_jit_free_exec(image);
> -
> +	ret = __arch_prepare_bpf_trampoline(&im, NULL, NULL, NULL, m, flags, tlinks, func_addr);
>  	return ret;
>  }
>  
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 233703b06d7c..91f9efe8b8d7 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -225,6 +225,15 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
>  	}
>  
>  #ifdef CONFIG_PPC_KERNEL_PCREL
> +	/*
> +	 * If fimage is NULL (the initial pass to find image size),
> +	 * account for the maximum no. of instructions possible.
> +	 */
> +	if (!fimage) {
> +		ctx->idx += 7;
> +		return 0;
> +	}
> +

I would merge this with the below if conditional so that this gets 
noticed if the instruction sequence below ever changes.

>  	reladdr = func_addr - local_paca->kernelbase;
>  
>  	if (reladdr < (long)SZ_8G && reladdr >= -(long)SZ_8G) {

Other than that:
Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen


