Return-Path: <bpf+bounces-78067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE0CFC792
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 08:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A79301226F
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2727FB32;
	Wed,  7 Jan 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGtFeV//"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12860259C84
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772575; cv=none; b=m+EkPuchOL9kxliF/j80Af6jcLJKXe5xV3QwoqPJwEADI9JL9tmC6bkuVDSUEVV8dNv6ijzGu1Gzx3Wpjll+ksBfVTjYGdrwQuHhNoW5l0tY2viGNCpqp1sQbltl2XBnyKcEqlSBoXMzgTo+oiJnh1VwEfSBWKfdFOHFlQJWzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772575; c=relaxed/simple;
	bh=96y+B6b9oBXSLFYpa70we0PaRw8fmnzeDJoy4QCy/OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs2du3DhllvG3qqv3hMx1FaDg3OgaGyRMTa7EAlMHQjdVwlzztyiiWJUfmhgKEo5W2JZwowv0XEExPtyFTTaSwaPZMqMnMP/IlgWv+ygkc0i/PfyK+ZJMjxVjBD98RBLekJHUgYiWERMVlDPwUXrP7SaIfaRnOw2BxO0K5lY/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGtFeV//; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767772570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UY5sSVMcc+gsvnsh0rtWtWs3D5HJrtwOQbkCHjEVOM=;
	b=IGtFeV//w4cQ8LwjYu/bGUaR6OBtvtjoDyxW923K1sR8G/pz1t2/fO/yYIhvOGhTRADMi+
	HSM+mZE92dbjWh0v9Qr2uWfoe2kb08SPMO2gSWkZdu+i3aknjj9+fi0pc+LlohfY3nStu3
	rXQS114i+97Z2Gj2Kp7x1TLWXhb7+fg=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, andrii@kernel.org,
 bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v7 07/11] bpf,x86: add fsession support for x86_64
Date: Wed, 07 Jan 2026 15:55:52 +0800
Message-ID: <3026409.e9J7NaK4W3@7940hx>
In-Reply-To:
 <598aec184ed820be7f244c2c14b1c0b75442e7567eb52abb15dd6875053c4958@mail.kernel.org>
References:
 <20260107064352.291069-8-dongml2@chinatelecom.cn>
 <598aec184ed820be7f244c2c14b1c0b75442e7567eb52abb15dd6875053c4958@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/7 15:11 bot+bpf-ci@kernel.org write:
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a87304161d45..32c13175bc65 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >  		      struct bpf_tramp_links *tl, int stack_size,
> >  		      int run_ctx_off, bool save_ret,
> > -		      void *image, void *rw_image)
> > +		      void *image, void *rw_image, u64 func_meta)
> >  {
> >  	int i;
> >  	u8 *prog = *pprog;
> >
> >  	for (i = 0; i < tl->nr_links; i++) {
> > +		if (tl->links[i]->link.prog->call_session_cookie) {
> > +			/* 'stack_size + 8' is the offset of func_md in stack */
> > +			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
> > +			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
> > +		}
> 
> This decrement of func_meta is problematic for fsession programs. When
> invoke_bpf() is called for fentry, func_meta gets decremented for each
> program with call_session_cookie. Later, when invoke_bpf() is called
> for fexit, it receives this already-decremented func_meta value.
> 
> Since fsession programs appear in both fentry and fexit lists (same
> program object), call_session_cookie is true for both. The fexit part
> will see a different cookie offset than the fentry part saw.
> 
> For example, with one fsession program:
>   - fentry stores func_meta with cookie offset N, then decrements to N-1
>   - fexit receives N-1, stores it, and the BPF program reads offset N-1
> 
> Should the func_meta offset be reset for fexit so that each fsession
> program's fentry and fexit parts access the same cookie slot?
> 
> [ ... ]
> 
> > @@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  		}
> >  	}
> >
> > +	if (bpf_fsession_cnt(tlinks)) {
> > +		/* clear all the session cookies' value */
> > +		for (int i = 0; i < cookie_cnt; i++)
> > +			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
> > +		/* clear the return value to make sure fentry always get 0 */
> > +		emit_st_r0_imm64(&prog, 0, 8);
> > +	}
> > +	func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
> > +
> >  	if (fentry->nr_links) {
> >  		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
> > -			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
> > +			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
> > +			       func_meta))
> >  			return -EINVAL;
> >  	}
> 
> [ ... ]
> 
> > @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  		}
> >  	}
> >
> > +	/* set the "is_return" flag for fsession */
> > +	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
> > +	if (bpf_fsession_cnt(tlinks))
> > +		emit_st_r0_imm64(&prog, func_meta, nregs_off);
> > +
> >  	if (fexit->nr_links) {
> >  		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
> > -			       false, image, rw_image)) {
> > +			       false, image, rw_image, func_meta)) {
> 
> At this point func_meta has already been decremented during the fentry
> invoke_bpf() call above. When invoke_bpf() processes the fexit list and
> encounters an fsession program (which has call_session_cookie set since
> it is the same program object), it will store this modified func_meta.

I think you misunderstand something. The "func_meta" that modified in
invoke_bpf() will not affect the value of "func_meta" here. We pass the value
of func_meta to invoke_bpf(), not the address.

This part should be OK, as it is covered by the selftests.

Thanks!
Menglong Dong

> 
> The cookie offset encoded in func_meta will be different from what the
> fentry part stored, causing bpf_session_cookie() to return a pointer to
> a different memory location for fexit than for fentry.
> 
> > +			ret = -EINVAL;
> > +			goto cleanup;
> > +		}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136
> 





