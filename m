Return-Path: <bpf+bounces-28777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CA8BDFDE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444471F2571A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615ED1514E0;
	Tue,  7 May 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvUm8W89"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3ED14EC7E;
	Tue,  7 May 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078313; cv=none; b=NXfQn+0kNEHEuaKsEA+N7o6rgfm5sJzZPPeeaK/J/XCEyAmhR4z3wXD3H7t2crtUFKqOtdTFA1fAK2ogPzyCnHo6V39IClywddBznyHEipzlXiqAyBBn++GC2OwjjMlDtU475ttkdAHo3lyERbid7w9j69kg9Wy4sDfFcAX5gT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078313; c=relaxed/simple;
	bh=f6wbMbCLTQCjpEEEl/TaVKzRMwt6S9ZGL8N+Xi6Q5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHHYpEABQCJ8NBm+2q1Xd0qqsmgzNrHdVrKvczZYZsjG1SWf4vFWtlPcto6lcGsVwin1WRYd4Zt3VRtphbeXBvrFAbKgDV4AgYcW5ipAGBPVcmZRknudstTep9CIIzHS9tUAwfE6yBY7HorLeOdW2W9hQZv+R0oF63JpdBl2uqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvUm8W89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0249C2BBFC;
	Tue,  7 May 2024 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715078311;
	bh=f6wbMbCLTQCjpEEEl/TaVKzRMwt6S9ZGL8N+Xi6Q5NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvUm8W89kxquA0pPXEj7m6Sd2oIh4lI5FGDMNvoptYIx/XRYpMxtD8o+6YrYqq/Ls
	 4OXkLIvASechkYU8LDUHw0gdDxWZupzv7UN5e4Gr7E84MBiWFNbti2V3IBtEAuZJ4V
	 HwGg38stsWj7M6N17msxiReG5UZfbGB7lggvjFtrc/nL8t0nFtF9hUXkmw6bmQba9l
	 0Gh2bheNmsXZv78rcoHimombn83Z52GMonaYxsFWsFnOvh3MX2gS+BiH/Yde+dKeSZ
	 DFKBRbLSyi3G6pnvSu/ATxG/x79AYJP9erE1+82rCgCuZO52V/kUkscXKLrCZ561Vb
	 3SwthMUU1d68g==
Date: Tue, 7 May 2024 16:02:04 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH v4 1/2] powerpc64/bpf: fix tail calls for PCREL addressing
Message-ID: <ziidl5jisk3szmhoe6ncs52gtftp45juyq2zn72fisdprlazyg@dy5wmue7q4i6>
References: <20240502173205.142794-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502173205.142794-1-hbathini@linux.ibm.com>

On Thu, May 02, 2024 at 11:02:04PM GMT, Hari Bathini wrote:
> With PCREL addressing, there is no kernel TOC. So, it is not setup in
> prologue when PCREL addressing is used. But the number of instructions
> to skip on a tail call was not adjusted accordingly. That resulted in
> not so obvious failures while using tailcalls. 'tailcalls' selftest
> crashed the system with the below call trace:
> 
>   bpf_test_run+0xe8/0x3cc (unreliable)
>   bpf_prog_test_run_skb+0x348/0x778
>   __sys_bpf+0xb04/0x2b00
>   sys_bpf+0x28/0x38
>   system_call_exception+0x168/0x340
>   system_call_vectored_common+0x15c/0x2ec
> 
> Also, as bpf programs are always module addresses and a bpf helper in
> general is a core kernel text address, using PC relative addressing
> often fails with "out of range of pcrel address" error. Switch to
> using kernel base for relative addressing to handle this better.
> 
> Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> * Changes in v4:
>   - Fix out of range errors by switching to kernelbase instead of PC
>     for relative addressing.
> 
> * Changes in v3:
>   - New patch to fix tailcall issues with PCREL addressing.
> 
> 
>  arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 79f23974a320..4de08e35e284 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -202,7 +202,8 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
>  	EMIT(PPC_RAW_BLR());
>  }
>  
> -static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u64 func)
> +static int
> +bpf_jit_emit_func_call_hlp(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
>  {
>  	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
>  	long reladdr;
> @@ -211,19 +212,20 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>  		return -EINVAL;
>  
>  	if (IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
> -		reladdr = func_addr - CTX_NIA(ctx);
> +		reladdr = func_addr - local_paca->kernelbase;
>  
>  		if (reladdr >= (long)SZ_8G || reladdr < -(long)SZ_8G) {
> -			pr_err("eBPF: address of %ps out of range of pcrel address.\n",
> -				(void *)func);
> +			pr_err("eBPF: address of %ps out of range of 34-bit relative address.\n",
> +			       (void *)func);
>  			return -ERANGE;
>  		}
> -		/* pla r12,addr */
> -		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(1) | IMM_H18(reladdr));
> -		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | IMM_L(reladdr));
> -		EMIT(PPC_RAW_MTCTR(_R12));
> -		EMIT(PPC_RAW_BCTR());
> -
> +		EMIT(PPC_RAW_LD(_R12, _R13, offsetof(struct paca_struct, kernelbase)));
> +		/* Align for subsequent prefix instruction */
> +		if (!IS_ALIGNED((unsigned long)fimage + CTX_NIA(ctx), 8))
> +			EMIT(PPC_RAW_NOP());

We don't need the prefix instruction to be aligned to a doubleword 
boundary - it just shouldn't cross a 64-byte boundary. Since we know the 
exact address of the instruction here, we should be able to check for 
that case.

> +		/* paddi r12,r12,addr */
> +		EMIT(PPC_PREFIX_MLS | __PPC_PRFX_R(0) | IMM_H18(reladdr));
> +		EMIT(PPC_INST_PADDI | ___PPC_RT(_R12) | ___PPC_RA(_R12) | IMM_L(reladdr));
>  	} else {
>  		reladdr = func_addr - kernel_toc_addr();
>  		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
> @@ -233,9 +235,9 @@ static int bpf_jit_emit_func_call_hlp(u32 *image, struct codegen_context *ctx, u
>  
>  		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
>  		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
> -		EMIT(PPC_RAW_MTCTR(_R12));
> -		EMIT(PPC_RAW_BCTRL());
>  	}
> +	EMIT(PPC_RAW_MTCTR(_R12));
> +	EMIT(PPC_RAW_BCTRL());

This change shouldn't be necessary since these instructions are moved 
back into the conditional in the next patch.

Other than those minor comments:
Reviewed-by: Naveen N Rao <naveen@kernel.org>


- Naveen


