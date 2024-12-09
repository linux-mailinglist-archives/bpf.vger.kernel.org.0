Return-Path: <bpf+bounces-46384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C49E92F4
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818971637C1
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD852236FE;
	Mon,  9 Dec 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUCv3DC4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BA12236F7
	for <bpf@vger.kernel.org>; Mon,  9 Dec 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745225; cv=none; b=HeV6iNXTr64aXCp1XHeEh+S2tiHY9JPWKMcirc/IW4CKG/QYHiBqqhQWXlR1ps6swfCkNS6fd5/RuDPre7EmPIn3fRlDbBp19obH8l5IDaXTwlaUMjEXBOt8wXSapNz/YknnQfmQRsggPaaTXlA/Uut48c/GVVFcuOYA0o6Asio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745225; c=relaxed/simple;
	bh=QVVsIrWdwzQiWUAS7efcIcGIIwdfxSiudRmp/pVtoho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PwiVSnzoEA+iePd0BRsrDeGSCa8o3340t2D3prxMzW83gDrl6Wq2yhsQ0//mHRa46uOaazpxnq2BXsxGsgavyGBS4163dK9n23RCXkngEYzXkReIWb7sCYJnREMl4a5P0H8u0qTKNNdUG9sgJbOIGrGTOAQRdCmX2j6nhAsq/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUCv3DC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CAEC4CEDD;
	Mon,  9 Dec 2024 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733745224;
	bh=QVVsIrWdwzQiWUAS7efcIcGIIwdfxSiudRmp/pVtoho=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LUCv3DC45BULqhJJgO58DzBtuyPdnzk91QU9L0Or+paFuHW6gfveaLoa607uAfEUV
	 NTvxyze/kd6DLJEEcWjmeyFIj1HGMKpZQQKptRtOVEqZSUo9Ebtnq5wuj+NSULL7nR
	 CRxRGy3BUGbIZkltGWgIYNCTwYJQ04NDgyPARuUkha0BkMSdFIw3X3kaSPe2s1trFd
	 at74GWF6Ch5Wuu6h/e6pjgtHT9f4G1/V4nbirXOJD+l3ESRLGG4vDvybvRrpjqgz50
	 52Yfw3jW/neSHXIuMWoMrBZY2v97R9nu2rMXlDgPddRmKPRNTVQnxKef4i0wEFpfFm
	 /0gl13CYucYlQ==
Message-ID: <9b9079ef-38cf-49f8-a0b5-a4cf669d7d6f@kernel.org>
Date: Mon, 9 Dec 2024 11:53:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Probe for ISA v4 instruction set
 extension
To: Simone Magnani <simone.magnani@isovalent.com>, bpf@vger.kernel.org
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241209102644.29880-1-simone.magnani@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 10:26, Simone Magnani wrote:
> This patch introduces a new probe to check whether the kernel supports
> instruction set extensions v4. The v4 extension comprises several new
> instructions: BPF_{SDIV,SMOD} (signed div and mod), BPF_{LD,LDX,ST,STX,MOV}
> (sign-extended load/store/move), 32-bit BPF_JA (unconditional jump),
> target-independent BPF_ALU64 BSWAP (byte-swapping 16/32/64). These have
> been introduced in the following commits respectively:
> 
> * ec0e2da ("bpf: Support new signed div/mod instructions.")
> * 1f9a1ea ("bpf: Support new sign-extension load insns")
> * 8100928 ("bpf: Support new sign-extension mov insns")
> * 4cd58e9 ("bpf: Support new 32bit offset jmp instruction")
> * 0845c3d ("bpf: Support new unconditional bswap instruction")
> 
> Support in bpftool for previous ISA extensions were added in commit
> 0fd800b2 ("bpftool: Probe for instruction set extensions"). These probes
> are useful for userspace BPF projects that want to use newer
> instruction set extensions on newer kernels, to reduce the programs'
> sizes or their complexity. LLVM provides the mcpu=v4 option since commit
> "[BPF] support for BPF_ST instruction in codegen"
> (https://github.com/llvm/llvm-project/commit/8f28e8069c4ba1110daee8bddc4d5049b6d4646e).
> 
> Signed-off-by: Simone Magnani <simone.magnani@isovalent.com>
> ---
>  tools/bpf/bpftool/feature.c  | 23 +++++++++++++++++++++++
>  tools/include/linux/filter.h | 10 ++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 4dbc4fcdf473..24fecdf8e430 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -885,6 +885,28 @@ probe_v3_isa_extension(const char *define_prefix, __u32 ifindex)
>  			   "V3_ISA_EXTENSION");
>  }
> 
> +/*
> + * Probe for the v4 instruction set extension introduced in commit 1f9a1ea821ff
> + * ("bpf: Support new sign-extension load insns").
> + */
> +static void
> +probe_v4_isa_extension(const char *define_prefix, __u32 ifindex)
> +{
> +	struct bpf_insn insns[5] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 1, 1),
> +		BPF_JMP32_A(1),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN()
> +	};
> +
> +	probe_misc_feature(insns, ARRAY_SIZE(insns),
> +			   define_prefix, ifindex,
> +			   "have_v4_isa_extension",
> +			   "ISA extension v4",
> +			   "V4_ISA_EXTENSION");
> +}
> +
>  static void
>  section_system_config(enum probe_component target, const char *define_prefix)
>  {
> @@ -1029,6 +1051,7 @@ static void section_misc(const char *define_prefix, __u32 ifindex)
>  	probe_bounded_loops(define_prefix, ifindex);
>  	probe_v2_isa_extension(define_prefix, ifindex);
>  	probe_v3_isa_extension(define_prefix, ifindex);
> +	probe_v4_isa_extension(define_prefix, ifindex);
>  	print_end_section();
>  }
> 
> diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> index 65aa8ce142e5..a2962fc56f27 100644
> --- a/tools/include/linux/filter.h
> +++ b/tools/include/linux/filter.h
> @@ -75,6 +75,16 @@
>  		.off   = 0,					\
>  		.imm   = LEN })
> 
> +/* Unconditional jumps, gotol pc + imm32 */
> +
> +#define BPF_JMP32_A(IMM)					\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_JMP32 | BPF_JA,			\
> +		.dst_reg = 0,					\
> +		.src_reg = 0,					\
> +		.off   = 0,					\
> +		.imm   = IMM })
> +
>  /* Short form of mov, dst_reg = src_reg */
> 
>  #define BPF_MOV64_REG(DST, SRC)					\


Nit: Can you please move this macro after BPF_JMP_A() in filter.h, so
that it remains consistent with the order in include/linux/filter.h?

The bpftool change looks good, thanks!

Please Cc other BPF maintainers too for bpftool patches.

Quentin

