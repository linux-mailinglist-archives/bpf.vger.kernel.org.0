Return-Path: <bpf+bounces-78285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D898D07EFE
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EEDE30312C0
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C5350A17;
	Fri,  9 Jan 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbYUapCM"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120034EEF1
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948153; cv=none; b=LD9teb4pveJY8AEvJKgNwqenEcRlL2Dgg4/IYHB4308CodPBjURLgo86C60+xogYpqtwKUfBQcC1UomLUrAj6pgmrMD/4xAoSBb4KM/15ePlWgc50EXZ7jvJkiv2mu0D4COqw9kAqNeRaPOO4JzZGVmdA0LKJXl0GsfvOh4maL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948153; c=relaxed/simple;
	bh=lj7NZ10F6eLzEkT2m0qY9WsVQg84WHKn7cwQQ5/auTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxhyCQZ5E6bZcyqyTL1qeXUkZV3TuzzYRMMAzEjI4vXOtgWiA2U03/VU64jDMcyQucV29OgYHjdVhSFdQjvL9bPlZS0WLE+PTmXPHmtf0kBGwqc9OtTSiq+8Q84WZh9/JTEKLip/dFV8gb1gr9EjW851FRpsOjhFNPhNdKKYaJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbYUapCM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767948148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvkQKokaayVkp4o4WXXuCRa1ChB35j1dhjCzrzsF5cI=;
	b=CbYUapCMuHs07sSTq2yVwlNatv3zhAcP3Iu3dlL4ndDiYPejtAndoNhokQ+fh/CpuLMR6T
	/f4LMtGfUJRFSL5pot+uGKnmTsiD7lArjrmPMAYz9XZUEURtTt1WWifEhu0ZEwI4pS/Snk
	wWA+N4HqnfyMiHbfmytHxH8sQ/yvyDM=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, eddyz87@gmail.com,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Fri, 09 Jan 2026 16:42:19 +0800
Message-ID: <2815055.mvXUDI8C0e@7940hx>
In-Reply-To: <20260109082631.246647-2-dongml2@chinatelecom.cn>
References:
 <20260109082631.246647-1-dongml2@chinatelecom.cn>
 <20260109082631.246647-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/9 16:26 Menglong Dong <menglong8.dong@gmail.com> write:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
> 
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.

This sentence is redundant, and should be remove :/

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d44c5d06623..520c413839ee 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>  	switch (imm) {
>  #ifdef CONFIG_X86_64
>  	case BPF_FUNC_get_smp_processor_id:
> +	case BPF_FUNC_get_current_task_btf:
> +	case BPF_FUNC_get_current_task:
>  		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
>  #endif
>  	default:
> @@ -23273,6 +23275,24 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			insn      = new_prog->insnsi + i + delta;
>  			goto next_insn;
>  		}
> +
> +		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
> +		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
> +		    verifier_inlines_helper_call(env, insn->imm)) {
> +			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
> +			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> +			cnt = 3;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			goto next_insn;
> +		}
>  #endif
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> -- 
> 2.52.0
> 
> 
> 





