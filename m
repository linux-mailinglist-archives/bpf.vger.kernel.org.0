Return-Path: <bpf+bounces-27222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46318AAF58
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C7E1F23A03
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063A12838E;
	Fri, 19 Apr 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htnFnpLK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BF622;
	Fri, 19 Apr 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533428; cv=none; b=ACTI05/BqHwXRJXz12GK1EmJz+V7sItc9myhRnNzs9nmrnLJWGJrfES8GEXELQvLopXB5+pk4bIQW8MXTNNz2Bpd6rGKJ3DL7/Q694fhugkD4YmbevkL3s+vlW0+IUmLCte8bb7QQvIp8aYIOYkYHfQJqy9TBZZ1ZFFpRLBD1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533428; c=relaxed/simple;
	bh=GXF1iPLLsj+lPXqnRynd5BnS/PTOStGizUC5EOHysNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tppFRRGtsiiDLL457RDCg+HqFnu9g/lHzDbanufjq2mvlkzRHGir3kfhM+r+FVH460YhrMYdLJHb1eMbJQsRSR5CxrR6Onbk+YKEECBuMiJviQgVzHFaCQs6IQY42c6vrNsaX/mElmZpBXoCykpLPq0vvUbe2DMW2T9gL/Qpp00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htnFnpLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48960C072AA;
	Fri, 19 Apr 2024 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713533427;
	bh=GXF1iPLLsj+lPXqnRynd5BnS/PTOStGizUC5EOHysNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htnFnpLKUSBz/vJ9dnPp+b0bf9XprdmpWhRTyEsZvcP/PTxto6lTDWQfnMbtWPgFz
	 HJ01QUIaGpU/39+h4NNSYULFKYqtWH6g8tWuYsLYdsPuVB6/e+EOYwGUVcIEgP2J0u
	 mou9DWbhtW+FC/FMZ4RKaZR2x80a4bh12UfQQ0FHumxT3coPI1bZrYSLvG/dcBFnXq
	 2dEBxYm/V5myDO/Khh+DWJO6axW6VX15erkyG/qrJZWvb26wjwLmJ4JN/qYC2rFz+p
	 hAWRMjm6R4hZvK8o+v8oLrpXGMpQJ79mllMN4bZQoY7DmLwyCh/oDnn97L0T1roXh7
	 Q7OmyNJKOl1lw==
Date: Fri, 19 Apr 2024 14:30:20 +0100
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>,
	Florent Revest <revest@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] arm64, bpf: add internal-only MOV instruction
 to resolve per-CPU addrs
Message-ID: <20240419133020.GC3148@willie-the-truck>
References: <20240405091707.66675-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405091707.66675-1-puranjay12@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Apr 05, 2024 at 09:17:07AM +0000, Puranjay Mohan wrote:
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
> 
> Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> the tpidr_el1/2 register of that CPU.
> 
> To support this BPF instruction in the ARM64 JIT, the following ARM64
> instructions are emitted:
> 
> mov dst, src		// Move src to dst, if src != dst
> mrs tmp, tpidr_el1/2	// Move per-cpu offset of the current cpu in tmp.
> add dst, dst, tmp	// Add the per cpu offset to the dst.
> 
> If CONFIG_SMP is not defined, then nothing is emitted if src == dst, and
> mov dst, src is emitted if dst != src.
> 
> To measure the performance improvement provided by this change, the
> benchmark in [1] was used:
> 
> Before:
> glob-arr-inc   :   23.597 ± 0.012M/s
> arr-inc        :   23.173 ± 0.019M/s
> hash-inc       :   12.186 ± 0.028M/s
> 
> After:
> glob-arr-inc   :   23.819 ± 0.034M/s
> arr-inc        :   23.285 ± 0.017M/s
> hash-inc       :   12.419 ± 0.011M/s
> 
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/include/asm/insn.h |  7 +++++++
>  arch/arm64/lib/insn.c         | 11 +++++++++++
>  arch/arm64/net/bpf_jit.h      |  6 ++++++
>  arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index db1aeacd4cd9..d16d68550c22 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -135,6 +135,11 @@ enum aarch64_insn_special_register {
>  	AARCH64_INSN_SPCLREG_SP_EL2	= 0xF210
>  };
>  
> +enum aarch64_insn_system_register {
> +	AARCH64_INSN_SYSREG_TPIDR_EL1	= 0xC684,
> +	AARCH64_INSN_SYSREG_TPIDR_EL2	= 0xE682,
> +};

I think these constants should have bit 15 as 0...

> +
>  enum aarch64_insn_variant {
>  	AARCH64_INSN_VARIANT_32BIT,
>  	AARCH64_INSN_VARIANT_64BIT
> @@ -686,6 +691,8 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
>  }
>  #endif
>  u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
> +u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
> +			 enum aarch64_insn_system_register sysreg);
>  
>  s32 aarch64_get_branch_offset(u32 insn);
>  u32 aarch64_set_branch_offset(u32 insn, s32 offset);
> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index a635ab83fee3..b008a9b46a7f 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c
> @@ -1515,3 +1515,14 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
>  
>  	return insn;
>  }
> +
> +u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
> +			 enum aarch64_insn_system_register sysreg)
> +{
> +	u32 insn = aarch64_insn_get_mrs_value();
> +
> +	insn &= ~GENMASK(19, 0);
> +	insn |= sysreg << 5;

... otherwise you're shifting into the opcode bits at the top. It works
out because bit 20 is 1, but I think it would be better to rework your
aarch64_insn_system_register values.

> +	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT,
> +					    insn, result);
> +}
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index 23b1b34db088..b627ef7188c7 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -297,4 +297,10 @@
>  #define A64_ADR(Rd, offset) \
>  	aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
>  
> +/* MRS */
> +#define A64_MRS_TPIDR_EL1(Rt) \
> +	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
> +#define A64_MRS_TPIDR_EL2(Rt) \
> +	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
> +
>  #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 76b91f36c729..e9ad9f257a18 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -877,6 +877,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  			emit(A64_ORR(1, tmp, dst, tmp), ctx);
>  			emit(A64_MOV(1, dst, tmp), ctx);
>  			break;
> +		} else if (insn_is_mov_percpu_addr(insn)) {
> +			if (dst != src)
> +				emit(A64_MOV(1, dst, src), ctx);
> +#ifdef CONFIG_SMP

CONFIG_SMP is always 'y' on arm64.

Will

