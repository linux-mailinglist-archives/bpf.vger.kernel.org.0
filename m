Return-Path: <bpf+bounces-78446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E55D0CE11
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 04:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4370B302D513
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9D254B1F;
	Sat, 10 Jan 2026 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VpTk5vyI"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B005257845
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016655; cv=none; b=N1iXBRJ3AcNeWar8eWyn4kV9P9HN0MPse1y/MaWRfNy+KRcXIcVfPcbNTZGvgQzDNKbcHODPTuYKFcN6NRbRr270F6MloNQUAdGyQhciuqV7EazHa6yTJAVkdsF+0NP0AulbxCPundE57gdTWaOiKlDHgSx2nXL2J5xPWddXCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016655; c=relaxed/simple;
	bh=iTMM4g9f1J7Hpud0eqVVLDr2hIdB+z4qosj1Uq1Vb80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0VPm5ry5lBvQj6COgSjcRZqgSnEdbNyHLNrtkWz0+WSJstytSfY8oo/g+ok8uozPZ7QkuCovJdXqQ2QrqphedBpxR3gU/3WGPRwnRijw3yhKb2/0WfcGFJMrd462rTP9VHgnS7nYvuFa4m1tilkKenVMe9sUwBzjOHajH5XHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VpTk5vyI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768016641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmSlK4v0hDoLbBAPJoN73VL/31kYh3aJHRKBgS+SBSE=;
	b=VpTk5vyISf9iDekD6UBWG5QLA7TAGC2nJ0sGkEdxqCe9uuUbTbWu93+CiZIsZgcrSar+5+
	jK96lUJarQgaaRqxAhX7riaZ5D48dbFwDNSd7pAdTayM70MUCzO0kelrEendurT3qM3+O6
	THlz1QqIcao3PCOT2jrP5nCfDkvESwY=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, eddyz87@gmail.com,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Sat, 10 Jan 2026 11:43:47 +0800
Message-ID: <3031509.e9J7NaK4W3@7950hx>
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

On 2026/1/9 16:26, Menglong Dong wrote:
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
> 
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.
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

The !CONFIG_SMP case is still not handled properly here.
In the CONFIG_SMP case, I think &current_task is always
u32, so we can remove the casting. Therefore, this code
will be suitable for !CONFIG_SMP too.

> +			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);

In !CONFIG_SMP case, &current_task is a normal variable
pointer, and the BPF_MOV64_PERCPU_REG() will be ignored,
which makes the whole logic right.

I'll do more testing on it.

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
> 





