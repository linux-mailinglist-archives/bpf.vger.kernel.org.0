Return-Path: <bpf+bounces-13971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1B7DF79D
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4B9B21287
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40B1DA5D;
	Thu,  2 Nov 2023 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF61CAB9
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5F7BE3;
	Thu,  2 Nov 2023 09:26:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B402F4;
	Thu,  2 Nov 2023 09:27:20 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278723F738;
	Thu,  2 Nov 2023 09:26:37 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:26:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
Message-ID: <ZUPNuiYlgADjZMNa@FVFF77S0Q05N.cambridge.arm.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-3-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908144320.2474-3-puranjay12@gmail.com>

On Fri, Sep 08, 2023 at 02:43:19PM +0000, Puranjay Mohan wrote:
> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
> 
> Implement aarch64_insn_set() which is similar to text_poke_set() of x86.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index f78a0409cbdb..551933338739 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>  
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +int aarch64_insn_set(void *dst, const u32 insn, size_t len);
>  void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>  
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 243d6ae8d2d8..63d9e0e77806 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>  	return dst;
>  }
>  
> +/**
> + * aarch64_insn_set - memset for RX memory regions.
> + * @dst: address to modify
> + * @c: value to set
> + * @len: length of memory region.
> + *
> + * Useful for JITs to fill regions of RX memory with illegal instructions.
> + */
> +noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +
> +	/* A64 instructions must be word aligned */
> +	if ((uintptr_t)dst & 0x3)
> +		return -EINVAL;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		memset32(waddr, insn, size / 4);

Do we need to use a specific instruction passed by the caller, or can we
hard-code a trapping instruction here?

If we don't care about the specific instruction, it'd be best to memset this to
0, as 0x00000000 is UDF #0 (which will trap), and that way memset can use DC
ZVA to zero the memory, which is faster than 4 bytes at a time.

If we did that, we can rename this to something like:

	aarch64_insn_clear(void *dst, size_t len)

> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);

Assuming the point of this is to trap if/when we accidentally execute the freed
instructions, we need an IPI here, and so this should use flush_icache_range()
or make it the caller's responsibility to do so.

Mark.

> +
> +	return 0;
> +}
> +
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>  {
>  	u32 *tp = addr;
> -- 
> 2.40.1
> 
> 

