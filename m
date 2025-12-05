Return-Path: <bpf+bounces-76110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D51CA7E14
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA515305D3A3
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F13101B1;
	Fri,  5 Dec 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyDLLfHv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5862FFF9B;
	Fri,  5 Dec 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943290; cv=none; b=RNxj32dY3RApANKU8UmRUPlgSaIggjW0L5uvUgFt/FQ2DMKe1WPOHwXluzmA85blR9E6idGGYeC0wpDVZaXxipQyUhS0JLYbVhaHs/AsWaPb27mPTsOfiioAHm1J4wvyqn3S0dMV4sfsWwqLFnbVCqnp6Nc/vutJw+xkEtSdzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943290; c=relaxed/simple;
	bh=TrAgTSCpSKLsxNjx4lejjyOcT5oTXu93a4+3+YTmZ3w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hpR/v/HQMIXr+mI9mcWm/hosdYj9+K4bHgWD9sZd07D4EzQhm3aoBtOr0+yjbLEMabGorok1Ty/bS7dysczh3fw32J8WC1zPDtwNU5PrBCtTsugGAVWzEcPgT3pCrzgsjyJwruLZ2r4py5QaRp/bqdINTW9N2+yQ+VQN0/HHg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyDLLfHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C877C4CEF1;
	Fri,  5 Dec 2025 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764943289;
	bh=TrAgTSCpSKLsxNjx4lejjyOcT5oTXu93a4+3+YTmZ3w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VyDLLfHvRoVuPjT70NTIft3b3xSkl+nI6nikeo3MyRxk6zRaNPXlNBKx6Wz6WBAHc
	 Zkk5yZZCTPhHBbMq6CG/aPlmM14FHSik+eIpZLtil7LtvDc4tNtYkmiR/WsK8xylI6
	 eUQQO6/l5pZQArBOMRHQTaUktho4y8UCpIJdih7wkXBc8Fo5W+/jE2GutZJDp3+6mu
	 kudUyP63pxf42kOpdfCd1o6oiIxP2r9dNiAzxbTV5AoJPYiTBI2OmnZPOMNbAwRZY8
	 e1JgXAEyT/SJ7nAPf5X2oqQFhplzBWf8D8KozHFyV93+IlDFJ1t7CJnhoP/IA3PrDG
	 gypy4Cv4CLZJQ==
Content-Type: multipart/mixed; boundary="===============8834443675323528757=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc13dfdbbcdde12aeebc6970e354b8dbbb81454f063a7861e54fbde1b510dc06@mail.kernel.org>
In-Reply-To: <1957532cd4b87b450a2efc0e9d732f448bcf9706.1764930425.git.skb99@linux.ibm.com>
References: <1957532cd4b87b450a2efc0e9d732f448bcf9706.1764930425.git.skb99@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 1/2] powerpc64/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Dec 2025 14:01:27 +0000 (UTC)

--===============8834443675323528757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 5e976730b2f5..d53e9cd7563f 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 1fe37128c876..816f9d7d9e5d 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -918,6 +918,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>  	case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
>  	case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
>
> +		if (insn_is_mov_percpu_addr(&insn[i])) {
> +			if (IS_ENABLED(CONFIG_SMP)) {
> +				EMIT(PPC_RAW_LD(tmp1_reg, _R13, offsetof(struct paca_struct, data_offset)));
> +				EMIT(PPC_RAW_ADD(dst_reg, src_reg, tmp1_reg));
> +			} else if (src_reg != dst_reg) {
> +				EMIT(PPC_RAW_MR(dst_reg, src_reg));
> +			}
> +		}
> +

Does this code need a break statement here? After handling the per-CPU
MOV instruction, execution falls through to the subsequent MOV handling
code. In the common case where dst_reg != src_reg with CONFIG_SMP
enabled, the code first emits ADD to compute the per-CPU address in
dst_reg, but then continues to the final else-if in this case statement
which emits MR dst_reg, src_reg, overwriting the computed address.

Other architectures (x86 and arm64) use break after their per-CPU
instruction handling in bpf_jit_build_body()->BPF_MOV case.

>  		if (insn_is_cast_user(&insn[i])) {
>  			EMIT(PPC_RAW_RLDICL_DOT(tmp1_reg, src_reg, 0, 32));
>  			PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));
>  			PPC_BCC_SHORT(COND_EQ, (ctx->idx + 2) * 4);
>  			EMIT(PPC_RAW_OR(tmp1_reg, dst_reg, tmp1_reg));
>  			EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
>  			break;
>  		}
>
>  		if (imm == 1) {
>  			/* special mov32 for zext */
>  			EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
>  			break;
>  		} else if (off == 8) {
>  			EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
>  		} else if (off == 16) {
>  			EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
>  		} else if (off == 32) {
>  			EMIT(PPC_RAW_EXTSW(dst_reg, src_reg));
>  		} else if (dst_reg != src_reg)
                        ^^^^
			This condition can be true for per-CPU instructions
			(which have off == -1), causing the computed per-CPU
			address to be overwritten with src_reg.

>  			EMIT(PPC_RAW_MR(dst_reg, src_reg));
>  		goto bpf_alu32_trunc;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19964922727

--===============8834443675323528757==--

