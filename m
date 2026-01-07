Return-Path: <bpf+bounces-78063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CBCFC4B8
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A28306D516
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA1B283CA3;
	Wed,  7 Jan 2026 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEc/8HEN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CE274B5C;
	Wed,  7 Jan 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769877; cv=none; b=lAkJkGbhxczu3OTIapABIyRlNHnyJ32A4EXapNK5y1WRQfM9btr337D+A1Z3DvhmiJtt0T/cyjxyPoiEMXRldv6EW79y6anrBqRO1dTgCghk/o83CGgNyh7/JDsTeri7xb6bca7AwFgeiFpNmhpEY11mL/D3OINz97kwdNhfWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769877; c=relaxed/simple;
	bh=bwEIRLY/Wo384cNTsyioBloALZxdiG3+w69ClunqFwc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jJM1YnUABC9rwuFZ++QZIM0ibGn94GkXm8ZmXUPvlO8AXBw6WTlr6Sf1QZRpbjXg+QFtW130IIcR998eOTWYcN9jl9jY1lip5GWtKKTWLCqTVz01EZep6nKpR9YBS2Lle9SgSlKv52biCHfuXPWWU+Wh67MVzd5S5wQIehHgFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEc/8HEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6EC4CEF7;
	Wed,  7 Jan 2026 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767769877;
	bh=bwEIRLY/Wo384cNTsyioBloALZxdiG3+w69ClunqFwc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TEc/8HENb5QI8im69ypSXiWkoYr3ug6+c3W6gQv3Slv3R1VOZChMaMUyhH5SJVOPN
	 fKSECaE63tGjFzmoRkx7sh8edOCsuRPn7BXwzBlQ5WTpTclLs8OLldsLinMWpkaRRw
	 ds6NLshFd8yd3SpXEeZyZZSDqf5aL6ySk7Iug9KxYL6kcmwNi6BoN/5AzKVSKErLUR
	 JaMq9/Fy9d1uJdqTr4lyteefgt2uf2v3LQM2nytOSd+gNC0JGGLUwwWVrSHrS86S8N
	 u64ZyE0LYcTClqxys3HA1ZCuZ5LaGwMIndPtZtl/64DpJY62Uz+H3CVDgX8wQifbJ7
	 Fs1Q3TMo5Dvig==
Content-Type: multipart/mixed; boundary="===============1006339552054496715=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <598aec184ed820be7f244c2c14b1c0b75442e7567eb52abb15dd6875053c4958@mail.kernel.org>
In-Reply-To: <20260107064352.291069-8-dongml2@chinatelecom.cn>
References: <20260107064352.291069-8-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v7 07/11] bpf,x86: add fsession support for x86_64
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 07:11:16 +0000 (UTC)

--===============1006339552054496715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a87304161d45..32c13175bc65 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>  		      struct bpf_tramp_links *tl, int stack_size,
>  		      int run_ctx_off, bool save_ret,
> -		      void *image, void *rw_image)
> +		      void *image, void *rw_image, u64 func_meta)
>  {
>  	int i;
>  	u8 *prog = *pprog;
>
>  	for (i = 0; i < tl->nr_links; i++) {
> +		if (tl->links[i]->link.prog->call_session_cookie) {
> +			/* 'stack_size + 8' is the offset of func_md in stack */
> +			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
> +			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
> +		}

This decrement of func_meta is problematic for fsession programs. When
invoke_bpf() is called for fentry, func_meta gets decremented for each
program with call_session_cookie. Later, when invoke_bpf() is called
for fexit, it receives this already-decremented func_meta value.

Since fsession programs appear in both fentry and fexit lists (same
program object), call_session_cookie is true for both. The fexit part
will see a different cookie offset than the fentry part saw.

For example, with one fsession program:
  - fentry stores func_meta with cookie offset N, then decrements to N-1
  - fexit receives N-1, stores it, and the BPF program reads offset N-1

Should the func_meta offset be reset for fexit so that each fsession
program's fentry and fexit parts access the same cookie slot?

[ ... ]

> @@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  		}
>  	}
>
> +	if (bpf_fsession_cnt(tlinks)) {
> +		/* clear all the session cookies' value */
> +		for (int i = 0; i < cookie_cnt; i++)
> +			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
> +		/* clear the return value to make sure fentry always get 0 */
> +		emit_st_r0_imm64(&prog, 0, 8);
> +	}
> +	func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
> +
>  	if (fentry->nr_links) {
>  		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
> -			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
> +			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
> +			       func_meta))
>  			return -EINVAL;
>  	}

[ ... ]

> @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>  		}
>  	}
>
> +	/* set the "is_return" flag for fsession */
> +	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
> +	if (bpf_fsession_cnt(tlinks))
> +		emit_st_r0_imm64(&prog, func_meta, nregs_off);
> +
>  	if (fexit->nr_links) {
>  		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
> -			       false, image, rw_image)) {
> +			       false, image, rw_image, func_meta)) {

At this point func_meta has already been decremented during the fentry
invoke_bpf() call above. When invoke_bpf() processes the fexit list and
encounters an fsession program (which has call_session_cookie set since
it is the same program object), it will store this modified func_meta.

The cookie offset encoded in func_meta will be different from what the
fentry part stored, causing bpf_session_cookie() to return a pointer to
a different memory location for fexit than for fentry.

> +			ret = -EINVAL;
> +			goto cleanup;
> +		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136

--===============1006339552054496715==--

