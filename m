Return-Path: <bpf+bounces-73006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E6C1FFBB
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA74E970F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C532F12CC;
	Thu, 30 Oct 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goDmxJDg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5743F9C5
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826893; cv=none; b=EyoyJ4QRYPLz/3irun04WLqE0c7K1u3ELyhk8PU6JFR8iz+pSVAXvjLOF1Wq7NFJE89LXuEQP8YRsENNc/F1e2WdzcIukZxn/czN0wvsB0IylO9rykLih3/vIcsRrRKMehiWxYoSqmVa4cAlSnRzqefv3XLZLEFlYJzJwBTKVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826893; c=relaxed/simple;
	bh=XkrPMoW4ahWw13jNVRdygtsY8cfBMsm5T9zBqt0Vl9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGI7AhBAYxB3IO9QJjpYj5xyE2Vx341VIFEuWuzplsGbvUXQ3T7HSjCFYz808jccvn6k7tVaWIHPJqWF/NaBbI5sBWwpYAODQBtR2dU92QkG6CBQLOHnYk+IeMH2v4o5l5a0fhlpXWeGinpUXGWS2GaW056atEcWIvYKytEpQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goDmxJDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDBC4CEF1;
	Thu, 30 Oct 2025 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761826893;
	bh=XkrPMoW4ahWw13jNVRdygtsY8cfBMsm5T9zBqt0Vl9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=goDmxJDgdu+FUSdfdylOBrP3RauaM+6RlW6h2If7RXwvHXsQnOYnfwpPoS2avjYzS
	 O4TH7vYmhmo7/5DQ6+03t75XsmXHQUAcoaFLquMNI9W4EhMqngI0bXaaHeQWWz5U6R
	 U+OvMw8VlpS/fhB3Un8JNFxgxQasr7l+PSfncuVob2NIbmnVOvY/MGii4DT26Z+Ehr
	 bvs29ho3uhtjgkbdcfkckA2UvTPrY2OaNE+mTpakqk2uqLZ3CamQv4rsgJt5dhPJdp
	 f6O6SyEQOYSwowS/7BSMDQTzQQW9Qg46I4oXR45Pi4aN/UoeWZd52EKmWstCE508fi
	 ty6g+z5rShrlQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Xu
 Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: arm64: fix BPF_ST into arena memory
In-Reply-To: <20251030120146.50417-1-puranjay@kernel.org>
References: <20251030120146.50417-1-puranjay@kernel.org>
Date: Thu, 30 Oct 2025 12:21:29 +0000
Message-ID: <mb61p3470twae.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

There is a build issue in this version, I have sent v2 with fix. please
review that one instead: https://lore.kernel.org/bpf/20251030121715.55214-1-puranjay@kernel.org/

Sorry for the noise.

Thanks,
Puranjay

> The arm64 JIT supports BPF_ST with BPF_PROBE_MEM32 (arena) by using the
> tmp2 register to hold the dst + arena_vm_base value and using tmp2 as the
> new dst register. But this is broken because in case is_lsi_offset()
> returns false the tmp2 will be clobbered by emit_a64_mov_i(1, tmp2, off,
> ctx); and hence the emitted store instruction will be of the form:
>
> 	strb    w10, [x11, x11]
>
> Fix this by using the third temporary register to hold the dst +
> arena_vm_base.
>
> Fixes: 339af577ec05 ("bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index ab83089c3d8f..348540b8e02d 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -785,6 +785,7 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>  	const u8 src = bpf2a64[insn->src_reg];
>  	const u8 tmp = bpf2a64[TMP_REG_1];
>  	const u8 tmp2 = bpf2a64[TMP_REG_2];
> +	const u8 tmp3 = bpf2a64[TMP_REG_3];
>  	const bool isdw = BPF_SIZE(code) == BPF_DW;
>  	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
>  	const s16 off = insn->off;
> @@ -1757,8 +1758,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>  	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
>  	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
>  		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
> -			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
> -			dst = tmp2;
> +			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
> +			dst = tmp3;
>  		}
>  		if (dst == fp) {
>  			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
> -- 
> 2.47.3

