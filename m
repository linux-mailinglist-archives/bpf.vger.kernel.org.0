Return-Path: <bpf+bounces-46404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F089E9A5C
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2F91887D49
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8B1BEF9F;
	Mon,  9 Dec 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjGxYIgn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148835975;
	Mon,  9 Dec 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757621; cv=none; b=a6r777glFq/TmppsYHkHyUZnwtyQooMtHMyJkIK2TK0FDgaGtFEg4xpArr/2MICWtsTPK+n5ymCGGSEcqU1X0ij8RBgJwUXpv4sGvM71Y+RPOM9e501sYdsNFksg35itwBqHckC842V9qBEuoWLTLk1ei9D7T6HmOKh9DMY12FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757621; c=relaxed/simple;
	bh=YZveUo7ygVztpPq12Big4of4v0JPqpekSILGg/8Xioo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv8FuZxj+pd9UPKeTV75RjSfiQWO9l+u5HUN3vO2hTE0qb4XpubaTDU8NkHbsutoTT5WkjnQt1nlyFp4vIolZxylIiiV+kg1kZssSz0eGsV/EJdzZbxFGTSl+WtUAZkQY1MGjTViE70uyk0DzCJZqUtE0vCCsUMTAUGI6TKz9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjGxYIgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A0C4CED1;
	Mon,  9 Dec 2024 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733757621;
	bh=YZveUo7ygVztpPq12Big4of4v0JPqpekSILGg/8Xioo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WjGxYIgnZSRGPsPcxvScWnB5MN3VxGQVxaKuzqqqJwkzqnE104gQRAch/4hmvfXGD
	 +hq00abe6HezBdxcnl43mbYNKsokvDKRZLlgk5uSjvllF/3R7OFEx0UDuK0zywVNyP
	 d1VQrwY2QYP4KxmMIEVYzRrBJ8R2O3HSnUG+AHZtUWMV/c61ki4rRACpGqGguQFJpc
	 1UzSoQ5JXBfnisrifZCLw2UX9SVijhELSwcHpUmpjzdJNma1Xu46eYvMtl4C9BDbTb
	 HQKZrvJ+7xGCK9JsrBGrQQKzBJaIy/KGR+XS3ddi+phE+IwlX9FYUYT+006uzUCI5o
	 vD/srrIUqLH6A==
Message-ID: <11d588c2-febe-46c4-ab49-8fb0ed80faac@kernel.org>
Date: Mon, 9 Dec 2024 15:20:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Probe for ISA v4 instruction set
 extension
To: Simone Magnani <simone.magnani@isovalent.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241209102644.29880-1-simone.magnani@isovalent.com>
 <20241209145439.336362-1-simone.magnani@isovalent.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241209145439.336362-1-simone.magnani@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 14:54, Simone Magnani wrote:
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
> Changelog:
> 
> - v2:
>   - moved BPF_JMP32_A macro after BPF_JMP_A in filter.h for consistency
>     with include/linux/filter.h, noted by Quentin Monnet <qmo@kernel.org>
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


Looking again at the probe itself, does the second instruction serve any
practical purpose here? Don't you just need to test the BPF_JMP32_A?

Looks good otherwise, thank you!

Reviewed-by: Quentin Monnet <qmo@kernel.org>


> +		BPF_JMP32_A(1),
> +		BPF_MOV64_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN()
> +	};

