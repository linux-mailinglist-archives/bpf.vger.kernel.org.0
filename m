Return-Path: <bpf+bounces-71364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F70BEFF6E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176D3188AB68
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB02EC0A1;
	Mon, 20 Oct 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZGTIwQXd"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8112C0261;
	Mon, 20 Oct 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949128; cv=none; b=CUuhpULycveajovf8c1J02CgN1BqgS5M/nqbJAufftptc05Q0vV9YFLGVQG72iBMtybtMIwFV4M+RqFtAgoC2y+HqII/rcuWmQDvMytskByeZlGcJ5TvZ4FUGiZHydXKmvNA7ubzwJG+zx6EHLjzEw7YVwbLfrJCcfstLsM13sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949128; c=relaxed/simple;
	bh=h10TWGtQbNLx7Uwu6iLo8QTiXH6hWwJWnxPaZe3lnmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXuZfXi4bEK+sU9bau3qZ7XWC/TTSggil6xrM9G5WOmr+coxHj0yhnpr4fnOaKUby2Lb5Vilms0WdHp3Sy4xJJIUf0G7RP2ZJokDArurQ+qIFJBxEL2L/c2o/qchYZdr5DqVeTOhosGcKAZtinYR37KDe7mr7hGz5cvIPP5u1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZGTIwQXd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760949122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blCx5J3DD1p19G2rVM4AkHWF/aMiJJt8EXysTr9sQd8=;
	b=ZGTIwQXddHBTCbqttMwB3GuldbQIbxE4TwdDvTVYvDyCqfCqURetc9d5u4HkMVHmOnyXdI
	aClN5dvuPsWHiLm/1vwbeFMUy53h0bb+BXoSpCjBUJGKh2FxBhAro9o+Z77w4lnNJfd/lV
	G6RgbTGJYme2Hf3dnb5lbAP+GkswhZA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting for
 x86_64
Date: Mon, 20 Oct 2025 16:31:44 +0800
Message-ID: <6206161.lOV4Wx5bFT@7950hx>
In-Reply-To: <aPXwlJ57B9egtr8x@krava>
References:
 <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn> <aPXwlJ57B9egtr8x@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/20 16:19, Jiri Olsa wrote:
> On Sat, Oct 18, 2025 at 10:21:22PM +0800, Menglong Dong wrote:
> 
> SNIP
> 
> >  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
> >  	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> > @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  					 void *func_addr)
> >  {
> >  	int i, ret, nr_regs = m->nr_args, stack_size = 0;
> > -	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
> > +	int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> > +	    arg_stack_off, rbx_off;
> >  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> > +	struct bpf_tramp_links *session = &tlinks[BPF_TRAMP_SESSION];
> >  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> >  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> >  	void *orig_call = func_addr;
> > @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  	 *
> >  	 * RBP - nregs_off [ regs count	     ]  always
> >  	 *
> > +	 * RBP - session_off [ session flags ] tracing session
> > +	 *
> >  	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> >  	 *
> >  	 * RBP - rbx_off   [ rbx value       ]  always
> > @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  	/* regs count  */
> >  	stack_size += 8;
> >  	nregs_off = stack_size;
> > +	stack_size += 8;
> > +	session_off = stack_size;
> 
> should this depend on session->nr_links ?

Hmm...my mistake, it should. And this also break the bpf_get_func_ip(),
which I'll fix in the next version.

> 
> jirka
> 
> >  
> >  	if (flags & BPF_TRAMP_F_IP_ARG)
> >  		stack_size += 8; /* room for IP address argument */
> > @@ -3345,6 +3442,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  			return -EINVAL;
> >  	}
> >  
> > +	if (session->nr_links) {
> > +		if (invoke_bpf_session_entry(m, &prog, session, regs_off,
> > +					     run_ctx_off, session_off,
> > +					     image, rw_image))
> > +			return -EINVAL;
> > +	}
> > +
> >  	if (fmod_ret->nr_links) {
> >  		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
> >  				   GFP_KERNEL);
> > @@ -3409,6 +3513,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >  		}
> >  	}
> >  
> > +	if (session->nr_links) {
> > +		if (invoke_bpf_session_exit(m, &prog, session, regs_off,
> > +					    run_ctx_off, session_off,
> > +					    image, rw_image)) {
> > +			ret = -EINVAL;
> > +			goto cleanup;
> > +		}
> > +	}
> > +
> >  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> >  		restore_regs(m, &prog, regs_off);
> >  
> 
> 





