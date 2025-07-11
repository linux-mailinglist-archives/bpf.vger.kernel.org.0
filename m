Return-Path: <bpf+bounces-63049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3152B01F1C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFC97ABE73
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73172E764B;
	Fri, 11 Jul 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIVGggrW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BB2E612B;
	Fri, 11 Jul 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244011; cv=none; b=RYjMo4DtjJ2g+XmvdRfYfX+Uzd29odljB1sG5BEqrHlwMTHV0wTFV+Z4wJGynUycyZAOo3Nz1FHujL+v3hUlsN8icXNA4xQfyNclqzN3YD5tZujTBqT7wk8ObNIDF1B6GGh54Gf64xrOI7KfuAa5bAp07p/ryKtCtHctgZBTUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244011; c=relaxed/simple;
	bh=FfMiSRStzxbidMZH6QNfoVJy9vPSxpBAXuFX/AKkUTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZW5SoWfN7mcVKa+v9DwliPW1kcjyFCFYKuoZKqhaCMEj8sRWNMgqBeNCJlmfFMqw4VhPaez5cSlZv4OzvlmExPihaI7LJFmtIPDYLsr0bB1Bfi/is6k5oyIul0n+j31XzjPeZExIJ7iBw08Dun5rZ/YMApdW3+vf7scB0j1FJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIVGggrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF5EC4CEED;
	Fri, 11 Jul 2025 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244011;
	bh=FfMiSRStzxbidMZH6QNfoVJy9vPSxpBAXuFX/AKkUTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIVGggrWKr1C79TZ+faVFd+qIm3hNfpOEAsggnq1KS5E6JH54f4jlpyxw84/ffkM0
	 UhNDiitZygkABnadoJTramixMFe8jMYM9YNcobIOD2n158aeupvUfcWjD5VaoE7rsq
	 jXQDMyun50Cn/TvATapcy547Df4To9+JV+hX5wGSNlhxytvKCWYyJPSrU0+g6tdIht
	 hmslsCwlgs0kX5vQA25uOBS8tl2DLiPAO+NnVZx6bjW9qasYK8XGBv2QUp/pqx2Ru1
	 AJTFVq2PYIASFEt/+vQYlFsXmaD8/EcRmpMGFp1PIgeobp1Q4l6Q1mG0WggAQudeT5
	 6ouPluY19RsUA==
Date: Fri, 11 Jul 2025 15:26:45 +0100
From: Will Deacon <will@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxwell Bland <mbland@motorola.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Dao Huang <huangdao1@oppo.com>
Subject: Re: [PATCH bpf-next v9 2/2] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Message-ID: <aHEfJZjW9dTXCgw3@willie-the-truck>
References: <20250505223437.3722164-4-samitolvanen@google.com>
 <20250505223437.3722164-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505223437.3722164-6-samitolvanen@google.com>

On Mon, May 05, 2025 at 10:34:40PM +0000, Sami Tolvanen wrote:
> From: Puranjay Mohan <puranjay12@gmail.com>
> 
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
> 
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
> 
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Co-developed-by: Maxwell Bland <mbland@motorola.com>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Dao Huang <huangdao1@oppo.com>
> ---
>  arch/arm64/include/asm/cfi.h    | 23 +++++++++++++++++++++++
>  arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++++
>  arch/arm64/net/bpf_jit_comp.c   | 22 +++++++++++++++++++---
>  3 files changed, 67 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cfi.h
> 
> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> new file mode 100644
> index 000000000000..670e191f8628
> --- /dev/null
> +++ b/arch/arm64/include/asm/cfi.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CFI_H
> +#define _ASM_ARM64_CFI_H
> +
> +#ifdef CONFIG_CFI_CLANG
> +#define __bpfcall
> +static inline int cfi_get_offset(void)
> +{
> +	return 4;

Needs a comment.

> +}
> +#define cfi_get_offset cfi_get_offset
> +extern u32 cfi_bpf_hash;
> +extern u32 cfi_bpf_subprog_hash;
> +extern u32 cfi_get_func_hash(void *func);
> +#else
> +#define cfi_bpf_hash 0U
> +#define cfi_bpf_subprog_hash 0U
> +static inline u32 cfi_get_func_hash(void *func)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_CFI_CLANG */
> +#endif /* _ASM_ARM64_CFI_H */

This looks like an awful lot of boiler plate to me. The only thing you
seem to need is the CFI offset -- why isn't that just a constant that we
can define (or a Kconfig symbol?).

> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 8ff6610af496..71c153488dad 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -8,11 +8,13 @@
>  
>  #define pr_fmt(fmt) "alternatives: " fmt
>  
> +#include <linux/cfi_types.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
>  #include <linux/elf.h>
>  #include <asm/cacheflush.h>
>  #include <asm/alternative.h>
> +#include <asm/cfi.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
>  #include <asm/module.h>
> @@ -298,3 +300,26 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
>  		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
>  }
>  EXPORT_SYMBOL(alt_cb_patch_nops);
> +
> +#ifdef CONFIG_CFI_CLANG
> +struct bpf_insn;
> +
> +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> +extern unsigned int __bpf_prog_runX(const void *ctx,
> +				    const struct bpf_insn *insn);
> +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
> +
> +/* Must match bpf_callback_t */
> +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
> +
> +u32 cfi_get_func_hash(void *func)
> +{
> +	u32 hash;
> +
> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
> +		return 0;
> +
> +	return hash;
> +}
> +#endif /* CONFIG_CFI_CLANG */

I don't think this should be in alternative.c. It's probably better off
either as a 'static inline' in the new cfi.h header.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 70d7c89d3ac9..3b3691e88dd5 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bpf.h>
> +#include <linux/cfi.h>
>  #include <linux/filter.h>
>  #include <linux/memory.h>
>  #include <linux/printk.h>
> @@ -164,6 +165,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>  		emit(insn, ctx);
>  }
>  
> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> +		emit(hash, ctx);
> +}
> +
>  /*
>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
>   * remaining bits are guaranteed to be 0x1. So we can compose the address
> @@ -474,7 +481,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>  	const bool is_main_prog = !bpf_is_subprog(prog);
>  	const u8 fp = bpf2a64[BPF_REG_FP];
>  	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
> -	const int idx0 = ctx->idx;
>  	int cur_offset;
>  
>  	/*
> @@ -500,6 +506,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
>  	 *
>  	 */
>  
> +	emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
> +	const int idx0 = ctx->idx;
> +
>  	/* bpf function may be invoked by 3 instruction types:
>  	 * 1. bl, attached via freplace to bpf prog via short jump
>  	 * 2. br, attached via freplace to bpf prog via long jump
> @@ -2009,9 +2018,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		jit_data->ro_header = ro_header;
>  	}
>  
> -	prog->bpf_func = (void *)ctx.ro_image;
> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>  	prog->jited = 1;
> -	prog->jited_len = prog_size;
> +	prog->jited_len = prog_size - cfi_get_offset();

Why do we add the offset even when CONFIG_CFI_CLANG is not enabled?

Will

