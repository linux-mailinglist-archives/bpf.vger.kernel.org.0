Return-Path: <bpf+bounces-63262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DCB04985
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BB7AA30C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071582727F1;
	Mon, 14 Jul 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkapQhIw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169526B955;
	Mon, 14 Jul 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752528578; cv=none; b=nkUkz/S4OBpSCAyZFjZIdFXchkhSk7jVpfJhG0NnqAxnOA8J0cVoWjBD9D1ELJJ98NT/02zLHLbvyRtJ1SZ7k0FwAsf0dRpnGnSqcPgD3DWrbyjmUsHbidMlwcQU0fWCO3XL+nDLb53PmeaJSnpM8ZRMe9wcxGdOiW9/WZ3GXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752528578; c=relaxed/simple;
	bh=gldvMRLk+NiKKpzZtiNvzswR+sSX2iXa4xE1okJ0/30=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTk56J/mt1m5Kw0BIMgjY0oHm3mImqjJMXFMeQoHri1lia/VEfsBL2li5x1JXjwYWfyPvk/8uREdltUMkUfkJ3R3t/X/TZBfmmzKPTkTchi/gdQwJUgwKJKfAqBz/Rdsw3gsSpCn4l0L2nrpc+/cxB8MReco3FNE0X7f7GBYtfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkapQhIw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0d7b32322so786077666b.2;
        Mon, 14 Jul 2025 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752528575; x=1753133375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJiGxwGPIoOdCr5X8ZGf+JUrr+fYVFvrLbfJsdrvZRg=;
        b=hkapQhIwEHYxU8OhF97nb+T2wAqfgnOp5K1QlVm2HyJ/oHI7oftAZIyrfTK8vV2B0M
         Y7W0lNoNcXS+IA0bjGe8NEHvC1f+K3VszW3ndqBHesJcvkE0LpJdzeEvxK3wVDGiRuYg
         9OzsL+JU7HIUS1dmidbKdL6VZVEGsEMiypGbcEDQ/uWaJrg7R8an0hwGDqUQkGJOlvEy
         1eE4dZyBXGUN1hShKtGcinezIZHDmVTTI4SSZSAJh1hvHDwD72tsP1pZRUXEZc9ZIXuf
         jpnGGA/D+sKTigSwYmJX1uGDY0ZDJzHR5AH4/GDiCtECT3ZOFYCqfItJFCf0I1c21IQp
         9usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752528575; x=1753133375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJiGxwGPIoOdCr5X8ZGf+JUrr+fYVFvrLbfJsdrvZRg=;
        b=MEqoA5Myh+RiYNPEUpNFyk3c/DxhhkqFhX2usBlX5bh+MkTCKwZ7AcGJ36pCr3qIOx
         DiTBBQSPwk40J8mc5/7Y2hjTrMbJB5Ia/8xNVMzXtlnSp712y0egDUj0/rYXTghtJWCc
         LFl9hH7LTwJfDgx6uqpvIhbwmOQJp75A3yq9H0s+bbAggUjruNRSv576lal8flEeZFlN
         5bJkpIkk0ZJ/YHVb9ONwtZuQVupgtJdgkkrDe64WahpUqF1e1Uq2t4TJhlVjdlk4kAGl
         M/8ym+ElY52FFfk0mqXAyQhQyc5O4gus9S5YxO9xh9nDjxVxeil9e90dDPnH6cnOmSU4
         cNaw==
X-Forwarded-Encrypted: i=1; AJvYcCVe6DxDfyd1OcTC868wDnG1Ey+JIxGQCisF187eRCcWpSE775QPLXFFm07KmQZpnnFmK6eH463thn+xAp1N@vger.kernel.org, AJvYcCVsHiZVDJNhNFh5+Ri/yYCKllHbKX7oO2IEdZrDsL6fyjJwGerwczcKJo/iQwlBPQ4pxXGxU4CWIC81+NAjnH/l8e+V@vger.kernel.org, AJvYcCXCwWoUujag8z7a5alxqXdLrRZ0fMOkxxj86dTISsks2COLk0OOMkC/gk54G1KoMAOKA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDnVmL6MTOJGOkr6zY+o8hz9PJuyBsmYVGLM/0P4UqXyXRwQa
	e/6AFwD0Qv1MWwKpBFgUbxyos1U13CUxG1udYBYMCLXuHulww3SrWFr2ZT0hGjQq
X-Gm-Gg: ASbGnctcwF4P+FDMSMefyR9B/XtHfxgXUeToYq8JjT3P44m6out33h5v/DbFsx0o0l9
	g5ZySw9/QMd3lLhuiCJgvZeUA2wXDDTPyhrfBTI3cYLLmul1gr1kfwugz4Jpj4iT1usG4yHPb79
	HDfveGb6uDxDFGYVT/47IfMLSOpibFwrvaJFO7isBwucYLm6/R20PCC8Xcr289MT+z3SJJc4FZo
	6bQ/bB0GAOH0h6A5NPJ8hdOYW/atcZp72Fbp0WzJn5XiDsMY5coSOTRgmsjxXMVhSu0GR6EIcqq
	zw00DZk2ramK1tlziD0267llgrT1ygxM/S6IhqaVTq23HOzsFoYhYjrNR0hYZaeeSURu06kyU37
	4+m3GsHkVElkVkF6rNxmo
X-Google-Smtp-Source: AGHT+IE7ho9+M9wBq24vyywEbsmFN+94NI0/oBAySh0dbA1ZsT0dm+5sqRJUMGZKHxsp7TNzEc9snA==
X-Received: by 2002:a17:907:da7:b0:ae6:859a:9e6c with SMTP id a640c23a62f3a-ae6fbf441c9mr1638060966b.3.1752528574914;
        Mon, 14 Jul 2025 14:29:34 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e94321sm892299866b.30.2025.07.14.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:29:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Jul 2025 23:29:32 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aHV2vLQiWIbSrttH@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-10-jolsa@kernel.org>
 <20250714173915.b9edd474742de46bcbe9c617@kernel.org>
 <20250714092801.GO905792@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714092801.GO905792@noisy.programming.kicks-ass.net>

On Mon, Jul 14, 2025 at 11:28:01AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> 
> > > +SYSCALL_DEFINE0(uprobe)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(current);
> > > +	unsigned long ip, sp, ax_r11_cx_ip[4];
> > > +	int err;
> > > +
> > > +	/* Allow execution only from uprobe trampolines. */
> > > +	if (!in_uprobe_trampoline(regs->ip))
> > > +		goto sigill;
> > > +
> > 
> > /*
> >  * When syscall from the trampoline, including a call to the trampoline
> >  * the stack will be shown as;
> >  *  regs->sp[0]: [rax]
> >  *          [1]: [r11]
> >  *          [2]: [rcx]
> >  *          [3]: [return-address] (probed address + sizeof(call-instruction))
> >  *
> >  * And the `&regs->sp[4]` should be the `sp` value when probe is hit.
> >  */
> > 
> > > +	err = copy_from_user(ax_r11_cx_ip, (void __user *)regs->sp, sizeof(ax_r11_cx_ip));
> > > +	if (err)
> > > +		goto sigill;
> > > +
> > > +	ip = regs->ip;
> > > +
> > > +	/*
> > > +	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
> > > +	 * - adjust ip to the probe address, call saved next instruction address
> > > +	 * - adjust sp to the probe's stack frame (check trampoline code)
> > > +	 */
> > > +	regs->ax  = ax_r11_cx_ip[0];
> > > +	regs->r11 = ax_r11_cx_ip[1];
> > > +	regs->cx  = ax_r11_cx_ip[2];
> > > +	regs->ip  = ax_r11_cx_ip[3] - 5;
> > > +	regs->sp += sizeof(ax_r11_cx_ip);
> > > +	regs->orig_ax = -1;
> > > +
> 
> Would not a structure be more natural?
> 
> /*
>  * See uprobe syscall trampoline; the call to the trampoline will push
>  * the return address on the stack, the trampoline itself then pushes
>  * cx, r11 and ax.
>  */
> struct uprobe_syscall_args {
> 	unsigned long ax;
> 	unsigned long r11;
> 	unsigned long cx;
> 	unsigned long retaddr;
> };
> 
> 	err = copy_from_user(sys_args, (void __user *)regs->sp, sizeof(sys_args));
> 	if (err)
> 		goto sigill;
> 
> 	ip = regs->ip;
> 
> 	regs->ax  = sys_args->ax;
> 	regs->r11 = sys_args->r11;
> 	regs->cx  = sys_args->cx;
> 	regs->ip  = sys_args->retaddr - CALL_INSN_SIZE;
> 	regs->sp += sizeof(sys_args);
> 
> etc.. ?

I was mimicking sys_uretprobe, but using struct does seem better

thanks,
jirka

