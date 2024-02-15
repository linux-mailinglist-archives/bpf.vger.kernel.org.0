Return-Path: <bpf+bounces-22070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F4885603B
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135D11C20FF8
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A51369AC;
	Thu, 15 Feb 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je7Zb/T+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201213699A
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993602; cv=none; b=QIbkm4/nfFiSU2c1RKokoOkWBASEPu9tG57laPZMUC86EesX3NA2IYczNmlcS2+5mFEEiOCz+1S3hwM5HFaKn1yWf24iNCeIZBhEZmtjfsS9mgBlskUkGjtogbWybbhYM/Ov+Tv8mGz0Ba9T4ZeDLPeyzGQuG8MEDQaX77rvYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993602; c=relaxed/simple;
	bh=sIn7ntggYTGoSRtIVBaHZzG27AVLz9PNpeuEa5swXs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1TmpFsTIqUxbg4FOGgFpDdP4xcSALZLEiYttVyYKyrqE1TXS3+hSPqFDiySC5bmoHVKZ0pFITC/Rk5c+NsAXK2Illtabcs5F8MJ78CZMRHocgcehqmwx0vKa7kidAZ5JtU/OMIXRVjJcxj57yeFbGdUYX2hRpOgfewoRTL9oB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je7Zb/T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D014C433F1;
	Thu, 15 Feb 2024 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707993602;
	bh=sIn7ntggYTGoSRtIVBaHZzG27AVLz9PNpeuEa5swXs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Je7Zb/T+SN6lgJEbbxn+dL4kt/YqL7+OW5ZudRXFpCn5WxPoF0yuDcbxgUDp8MtW3
	 nhGgsn/MYudK1KdlxrZDeXWT8dYwlpbI91Ye3TJsQya+p/JSOQJy+uQxSMIW+oTpiS
	 Gx6BAdM7amwXbFXTZe8SZ0ufHBy5J07EG0uKIVsFOqx7MFKLg31g8XM/afWL4fBfRi
	 /IhoQ9B4AthdgmoPlozlVcA3soWaPB7gfFwQZI1KI5EAuvfeywMH3CpQDVzVO5TEzU
	 H9CHPZ924xOWA+0KOmo8vuskR4D1P5kawBD9FolAdaCKFVsshPrniMAaXjWJ9zcFk4
	 ZeKJYXFLm/4dg==
Date: Thu, 15 Feb 2024 16:07:12 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH v2 1/2] powerpc/bpf: ensure module addresses are supported
Message-ID: <bsrdswaublna5mrrf4kvvimmrpd45eitg7eacmuk773z2pgdp5@laxsuelbuapz>
References: <20240201171249.253097-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201171249.253097-1-hbathini@linux.ibm.com>

On Thu, Feb 01, 2024 at 10:42:48PM +0530, Hari Bathini wrote:
> Currently, bpf jit code on powerpc assumes all the bpf functions and
> helpers to be kernel text. This is false for kfunc case, as function
> addresses are mostly module addresses in that case. Ensure module
> addresses are supported to enable kfunc support.

I don't think that statement is entirely accurate. Our current 
assumptions are still correct in the sense that:
1. all BPF helpers are part of core kernel text, calls to which are 
generated in bpf_jit_emit_func_call_hlp().
2. bpf-to-bpf calls go out to module area where the JIT output of BPF 
subprogs are written to, handled by bpf_jit_emit_func_call_rel().

kfunc calls add another variant where BPF progs can call directly into a 
kernel function (similar to a BPF helper call), except for the fact that 
the said function could be in a kernel module.

> 
> Assume kernel text address for programs with no kfunc call to optimize
> instruction sequence in that case. Add a check to error out if this
> assumption ever changes in the future.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> Changes in v2:
> * Using bpf_prog_has_kfunc_call() to decide whether to use optimized
>   instruction sequence or not as suggested by Naveen.
> 
> 
>  arch/powerpc/net/bpf_jit.h        |   5 +-
>  arch/powerpc/net/bpf_jit_comp.c   |   4 +-
>  arch/powerpc/net/bpf_jit_comp32.c |   8 ++-
>  arch/powerpc/net/bpf_jit_comp64.c | 109 ++++++++++++++++++++++++------
>  4 files changed, 97 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index cdea5dccaefe..fc56ee0ee9c5 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -160,10 +160,11 @@ static inline void bpf_clear_seen_register(struct codegen_context *ctx, int i)
>  }
>  
>  void bpf_jit_init_reg_mapping(struct codegen_context *ctx);
> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func);
> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
> +			       bool has_kfunc_call);
>  int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
>  		       u32 *addrs, int pass, bool extra_pass);
> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call);
>  void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>  void bpf_jit_realloc_regs(struct codegen_context *ctx);
>  int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 0f9a21783329..7b4103b4c929 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -163,7 +163,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  	 * update ctgtx.idx as it pretends to output instructions, then we can
>  	 * calculate total size from idx.
>  	 */
> -	bpf_jit_build_prologue(NULL, &cgctx);
> +	bpf_jit_build_prologue(NULL, &cgctx, bpf_prog_has_kfunc_call(fp));
>  	addrs[fp->len] = cgctx.idx * 4;
>  	bpf_jit_build_epilogue(NULL, &cgctx);
>  
> @@ -192,7 +192,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>  		/* Now build the prologue, body code & epilogue for real. */
>  		cgctx.idx = 0;
>  		cgctx.alt_exit_addr = 0;
> -		bpf_jit_build_prologue(code_base, &cgctx);
> +		bpf_jit_build_prologue(code_base, &cgctx, bpf_prog_has_kfunc_call(fp));
>  		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
>  				       extra_pass)) {
>  			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> index 2f39c50ca729..447747e51a58 100644
> --- a/arch/powerpc/net/bpf_jit_comp32.c
> +++ b/arch/powerpc/net/bpf_jit_comp32.c
> @@ -123,7 +123,7 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>  	}
>  }
>  
> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call)
>  {
>  	int i;
>  
> @@ -201,7 +201,8 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>  }
>  
>  /* Relative offset needs to be calculated based on final image location */
> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
> +			       bool has_kfunc_call)
>  {
>  	s32 rel = (s32)func - (s32)(fimage + ctx->idx);
>  
> @@ -1054,7 +1055,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>  				EMIT(PPC_RAW_STW(bpf_to_ppc(BPF_REG_5), _R1, 12));
>  			}
>  
> -			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
> +			ret = bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr,
> +							 bpf_prog_has_kfunc_call(fp));
>  			if (ret)
>  				return ret;
>  
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 79f23974a320..385a5df1670c 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -122,12 +122,17 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
>  {
>  }
>  
> -void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
> +void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx, bool has_kfunc_call)
>  {
>  	int i;
>  
>  #ifndef CONFIG_PPC_KERNEL_PCREL
> -	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
> +	/*
> +	 * If the program doesn't have a kfunc call, all BPF helpers are part of kernel text
> +	 * and all BPF programs/functions utilize the kernel TOC. So, optimize the
> +	 * instruction sequence by using kernel toc in r2 for that case.
> +	 */
> +	if (!has_kfunc_call && IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2))
>  		EMIT(PPC_RAW_LD(_R2, _R13, offsetof(struct paca_struct, kernel_toc)));

I don't think this is the correct approach. As far as I can see, we can 
still retain the current function calling sequence utilizing TOC even 
when a kfunc call is present. More on that below...

>  #endif
>  
> @@ -202,12 +207,17 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>  	EMIT(PPC_RAW_BLR());
>  }
>  
> -static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func)
> +static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func,
> +				      bool has_kfunc_call)
>  {
>  	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>  	long reladdr;
>  
> -	if (WARN_ON_ONCE(!core_kernel_text(func_addr)))
> +	/*
> +	 * If the program doesn't have a kfunc call, all BPF helpers are assumed to be part of
> +	 * kernel text. Don't proceed if that assumption ever changes in future.
> +	 */
> +	if (!has_kfunc_call && WARN_ON_ONCE(!core_kernel_text(func_addr)))
>  		return -EINVAL;

Rather than pass around the presence of a kfunc call in a particular BPF 
prog, I think we should be able to update bpf_jit_emit_func_call_hlp() 
to handle module addresses. That way, existing calling sequence can 
continue to be used for BPF helpers and other BPF functions.

bpf_jit_get_func_addr() should return the correct function address for a 
kfunc call. So, all we need here is to check if that address belongs to 
a module and use a different instruction sequence for that:
- for pcrel and elf abiv2, we can simply load the full address using 
  PPC_LI64() and use that, rather than utilizing the TOC. Note that we 
  will need to use the GEP here so the target function can setup its own 
  TOC. For elf abiv2, we will need an additional instruction after the 
  bctrl() to load the kernel toc from paca.
- for elf abiv1, we will need to load the function address and toc value 
  from the function descriptor, followed by restoring kernel toc like 
  above.

For kfunc calls to core kernel functions, we should be able to retain 
existing sequence using TOC.

>  
>  	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
> @@ -225,30 +235,55 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>  		EMIT(PPC_RAW_BCTR());
>  
>  	} else {
> -		reladdr = func_addr - kernel_toc_addr();
> -		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> -			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
> -			return -ERANGE;
> -		}
> +		if (has_kfunc_call) {
> +#ifdef PPC64_ELF_ABI_v1
> +			/* func points to the function descriptor */
> +			PPC_LI64(b2p[TMP_REG_2], func);
> +			/* Load actual entry point from function descriptor */
> +			PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_2], 0);
> +			/* ... and move it to CTR */
> +			EMIT(PPC_RAW_MTCTR(b2p[TMP_REG_1]));
> +			/*
> +			 * Load TOC from function descriptor at offset 8.
> +			 * We can clobber r2 since we get called through a
> +			 * function pointer (so caller will save/restore r2)
> +			 * and since we don't use a TOC ourself.
> +			 */
> +			PPC_BPF_LL(2, b2p[TMP_REG_2], 8);
> +#else
> +			/* We can clobber r12 */
> +			PPC_LI64(12, func);
> +			EMIT(PPC_RAW_MTCTR(12));
> +#endif
> +		} else {
> +			reladdr = func_addr - kernel_toc_addr();
> +			if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> +				pr_err("eBPF: address of %ps out of range of kernel_toc.\n",
> +				       (void *)func);
> +				return -ERANGE;
> +			}
>  
> -		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
> -		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
> -		EMIT(PPC_RAW_MTCTR(_R12));
> +			EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
> +			EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
> +			EMIT(PPC_RAW_MTCTR(_R12));
> +		}
>  		EMIT(PPC_RAW_BCTRL());
>  	}
>  
>  	return 0;
>  }
>  
> -int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
> +int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func,
> +			       bool has_kfunc_call)
>  {

This function shouldn't need any changes since this is only for calling 
other bpf progs.

- Naveen


