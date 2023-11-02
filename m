Return-Path: <bpf+bounces-13968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E373D7DF783
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA0A280F95
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB11DA3E;
	Thu,  2 Nov 2023 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681C1CF90
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:19:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B7D137;
	Thu,  2 Nov 2023 09:19:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9C4E2F4;
	Thu,  2 Nov 2023 09:19:51 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5E73F738;
	Thu,  2 Nov 2023 09:19:07 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:19:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
	bpf@vger.kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
Message-ID: <ZUPL-TeBpl1WEN7M@FVFF77S0Q05N.cambridge.arm.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-2-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908144320.2474-2-puranjay12@gmail.com>

Hi Puranjay,

On Fri, Sep 08, 2023 at 02:43:18PM +0000, Puranjay Mohan wrote:
> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> page, and thus allow multiple BPF programs sharing the a huge (2MB)
> page.
> 
> The bpf_prog_pack allocator that implements the above feature allocates
> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
> this function will be used to copy the code from RW to RX buffer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index 68908b82b168..f78a0409cbdb 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>  
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>  
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..243d6ae8d2d8 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>  	return ret;
>  }
>  
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
> + * @dst: address to modify
> + * @src: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX memory.
> + */
> +noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		ret = copy_to_kernel_nofault(waddr, src + patched, size);
> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		if (ret < 0) {
> +			raw_spin_unlock_irqrestore(&patch_lock, flags);
> +			return NULL;
> +		}
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);

As Xu mentioned, either this needs to use flush_icache_range() to IPI all CPUs
in the system, or we need to make it the caller's responsibility to do that.

Otherwise, I think this is functionally ok, but I'm not certain that it's good
for BPF to be using the FIX_TEXT_POKE0 slot as that will serialize all BPF
loading, ftrace, kprobes, etc against one another. Do we ever expect to load
multiple BPF programs in parallel, or is that serialized at a higher level?

Thanks,
Mark.

