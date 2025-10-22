Return-Path: <bpf+bounces-71850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BBBFE331
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DEFB350F9F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B78271451;
	Wed, 22 Oct 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfKsQJTX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F22F1FD2
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165687; cv=none; b=FZQ+KsiGZyu6iaN/eh4QTh91tph37LwZNWkXudimGuhAvH2pWiE/9qaxSNIS7TuhdM/qjB+er33zOIq1XefXLX5y+dL4mFbgP0ZHE1gbOUf22iuTcumfyHIPess50RCeoTLzxXOMD8geoFjKtxgGvhjLsjlFWNeLY8FdEPliz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165687; c=relaxed/simple;
	bh=/cjzEoYOZUH5gf58st5NFBxDx/pO/aQKRFNN5GRl/nk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEfwof2Subqnn/l8KhWI5tPEsZqzRvcPd8inXj5aFoViTlAgaHjZ6ne3EH0LNvKeHUcuqXECFe82EcMs5di7w73DvQcvJkqA1IXVRDUJYni/tmOT7wiznzbSyhoc3YH8poyTtptF8q3nX5OZi03Ub/B7hmQ2qnvAsCPtP+hJTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfKsQJTX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4285169c005so30140f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165682; x=1761770482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unKE/F22XNSyuW9yU5JIIPfLSp87oQ293d4LB9OETlc=;
        b=dfKsQJTXV6q0cTduGrLtM9UYCSkixPf1QSGYbO/kqQNa0ITiP3fuQuTjrl1GR/OgKw
         UUD5+UjwAw7WN4L8S6rOWgFYL+2aHPtna2mMtFE7drAYVDF73Yd+A/WmDQSNGPbu9/lG
         cspwWB4yfmZPrzwxFuJnJP7RxkJ2pXIBGPvMd8kDJIRoECgosvz7D15wgCQkcN0mtT2E
         XK0D5Vq4hjUHq7cQGBA9aO2eKyCoF9d0C4zp232OecUo2qUZrorI9A75dDRMUbmTgH/5
         76b+QbsBsMQ3GZUeFRI2vZdBVA2Uu/tj1tAG86x5A5wqDAE6QWFZJV2JP9Sc8pyX6H7i
         txRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165682; x=1761770482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unKE/F22XNSyuW9yU5JIIPfLSp87oQ293d4LB9OETlc=;
        b=qONObAL2i1vpBo8mLR60XG6OZA8ibtatX6MIokK7LJmRLo9aeEuKg+QT/fIieavEts
         YKdUr5vUpkKwW+Evb5HOZlp/x8QGfVOhyNPtPv0uxVSsQCzvxeiur7J4YnKeWNj5VZEz
         mG/odzQW34RhvgfD98BddTRw67qWcke222BX5fFN5J+FZuHVSXtoDZq4+5+cdyNnpJE4
         5VzHdjV7OQaGKagtTnSsIf/ICoeuoVhRFMC14mIxgHg1Jqo+qe1SPjCjzVgMjA4/rbwy
         3fGDzxZFOS4kFNpCYASFpKwzPRtOi+rE6marYxfVLdrg23ZQmVSSD0ELu8H4zC/ymE4g
         FitQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7ZlzvdT/Fg7yG+RpIECkVeoHaVwWljNGXO7BRURIQROz13UGM/s7Sd1t/HSxS3YHIrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdno5hXmARjKqCAwybssTXWBH6zxAy3O8Kags62Oatd5SoC8d
	5yq2MdDWTuO8J6zaf+7zQGGGe1vNTXLAVPgli3AZWc8TtpZx6Viz0u3R
X-Gm-Gg: ASbGncuTMHz3ZcnRutGepDTFWGQD26UlkIv93WTzJu1WJlqzfOJLMhtcpGjvAdnLsNZ
	Tu8bFGT6AKr3EiBRUyTFGwegjGB/J0up1uFCQ4Mqnj/bLg3LAAS/9qDg0aK9t15TeagGYBscr/z
	GwKT9Ldvm+yI2a7dyYa1Gq4t5AJ8Q3M4CsczEd22omqd9uA5KVfoN6jDXIsPMfdOwlxMMKo34hX
	ntOCQxLAbs0MvfBuso6/BCFWPEdZA58CzcaZBr3ZwgsQ20A4ajcW2v+P5vd56V8weaDxh7Q99Zi
	OhnOM8cpji3uGkwobBkhLiYPE+uFnC5dNllgOFYbf1eatE9PTO7KtaLwFLYFZfZaFgZR3FIgNy2
	b4wmzYVnA1XvZlIJj2FQZTSkJxa6dlSAvoC32qn8vNQHHjt1IPfQpHx9eiD/2xDLJxYaoDK6A+E
	Q=
X-Google-Smtp-Source: AGHT+IGh0GLLdjFBGi5Y/tsXH9nF2sfGR5neIPd614tGmkEBYvy3EnkjHraKKTLmiYbIfHg64UFXJw==
X-Received: by 2002:a05:6000:400d:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-42704d98980mr14222089f8f.31.1761165682163;
        Wed, 22 Oct 2025 13:41:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm46152755e9.0.2025.10.22.13.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:41:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 22 Oct 2025 22:41:20 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Feng Yang <yangfeng59949@163.com>,
	andrii@kernel.org, bpf@vger.kernel.org, jpoimboe@kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aPlBcKq7S-bD3B56@krava>
References: <20251015121138.4190d046@gandalf.local.home>
 <20251022090429.136755-1-yangfeng59949@163.com>
 <aPjO0yLCxPbUJP9r@krava>
 <20251022102819.7675ee7a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022102819.7675ee7a@gandalf.local.home>

On Wed, Oct 22, 2025 at 10:28:19AM -0400, Steven Rostedt wrote:
> On Wed, 22 Oct 2025 14:32:19 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > thanks for the report.. so above is from arm?
> > 
> > yes the x86_64 starts with:
> >   unwind_start(&state, current, NULL, (void *)regs->sp);
> > 
> > I seems to get reasonable stack traces on x86 with the change below,
> > which just initializes fields in regs that are used later on and sets
> > the stack so the ftrace_graph_ret_addr code is triggered during unwind
> > 
> > but I'm not familiar with this code, Masami, Josh, any idea?
> 
> Oh! This is an issue with a stack trace happening from a callback of the
> exit handler?

yes, it's triggered via:

  return_to_handler
    ftrace_return_to_handler
      fprobe_return
        kprobe_multi_link_exit_handler
	  kprobe_multi_link_prog_run
	    bpf_prog_run
	      bpf_prog..
	        bpf_get_stackid
		  get_perf_callchain
		    perf_callchain_kernel
		      unwind_start

> 
> OK, that makes much more sense. As I don't think the code handles that
> properly.
> 
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 367da3638167..2d2bb8c37b56 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -353,6 +353,8 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
> >  SYM_CODE_START(return_to_handler)
> >  	UNWIND_HINT_UNDEFINED
> 
> I believe the above UNWIND_HINT_UNDEFINED means that if ORC were to hit
> this, it should just give up.
> 
> This is because tracing the exit of the function really doesn't fit in the
> normal execution paradigm.
> 
> The entry is easy. It's the same as if the callback was called by the
> function being traced. The exit is more difficult because the function
> being traced has already did its return. Now the callback is in this limbo
> area of being called between a return and the caller.

I followed rethook trampoline arch_rethook_trampoline code which does similar
stuff and gets similar treatment in unwind_recover_ret_addr like fgraph

> 
> >  	ANNOTATE_NOENDBR
> > +	push $return_to_handler
> > +	UNWIND_HINT_FUNC
> 
> OK, so what happened here is that you put in the return_to_handle into the
> stack and told ORC that this is a normal function, and that when it
> triggers to do a lookup from the handler itself.

together with the "push $return_to_handler" it suppose to instruct ftrace_graph_ret_addr
to go get the 'real' return address from shadow stack

> 
> I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?

if I remove the initial UNWIND_HINT_UNDEFINED I get objtool warning
about unreachable instruction

> 
> >  
> >  	/* Save ftrace_regs for function exit context  */
> >  	subq $(FRAME_SIZE), %rsp
> > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> >  	movq %rax, RAX(%rsp)
> >  	movq %rdx, RDX(%rsp)
> >  	movq %rbp, RBP(%rsp)
> > +	movq %rsp, RSP(%rsp)
> > +	movq $0, EFLAGS(%rsp)
> > +	movq $__KERNEL_CS, CS(%rsp)
> 
> Is this simulating some kind of interrupt?

there are several checks in pt_regs on these fields 

- in get_perf_callchain we check user_mode(regs) so CS has to be set
- in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set

> 
> >  	movq %rsp, %rdi
> >  
> >  	call ftrace_return_to_handler
> 
> Now it gets tricky in the ftrace_return_to_handler as the first thing it
> does is to pop the shadow stack, which makes the return_to_handler lookup
> different, as its no longer on the stack that the unwinder will use.

hum strange.. the resulting stack trace seems ok, I'll make it a
selftest I send it

ftrace_graph_ret_addr that checks on the 'real return address seems
to have 2 ways of getting to it:

        i = *idx ? : task->curr_ret_stack;

I dont know how that previous pop affects this, but I'm sure it's
more complicated than this ;-)

jirka


> 
> The return address will live in the "ret" variable of that function, which
> the unwinder will not have access to. Yeah, this will not be easy to solve.
> 
> -- Steve
> 
> 
> > @@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
> >  	movq RDX(%rsp), %rdx
> >  	movq RAX(%rsp), %rax
> >  
> > -	addq $(FRAME_SIZE), %rsp
> > +	addq $(FRAME_SIZE) + 8, %rsp
> > +
> >  	/*
> >  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
> >  	 * since IBT would demand that contain ENDBR, which simply isn't so for
> 

