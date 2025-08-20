Return-Path: <bpf+bounces-66099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98BB2E311
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CD0A218D0
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC033471E;
	Wed, 20 Aug 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBKiNEge"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0833326D7B;
	Wed, 20 Aug 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709974; cv=none; b=GdBNtGhm54Q1cA5R2GGJbW7c0L7kN50ybh4TJsNs/0XuJ7FV4T6oApg3parOLtnDhrkZ9pOl9mSaz8qJDR3L5nioLr0jlsfsFqZ5KdU6UnMhR+9XLosz/OAaKq4SQR0zkdH98NH4KooGEf67mwlznuYEqJAUE1DU+C2Kurpoo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709974; c=relaxed/simple;
	bh=IUQCrjs8m4Ns2oVel2RgzZr7Q4fBAMYsIrt1ZEBwx7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjtZcUuOoMKI0/uNlA6mGSk0JsI2WgxstTNKpEgtYhvGcH9q7lKm7n5V5EpKQQtMG2aQ7GhnPUfKOpddITQBfEnsSU5TIOwqvufhqTr40hMSgQa1YU4phFFRnuhrB5kbK0/8jKIGCigQNU25SCs3WdusKAdSb0qqu96okmpyOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BBKiNEge; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=anYBpTxYy91S8Bgh2DpMeL5weuTxz6TOM+GO3HCRBd0=; b=BBKiNEgeQhJ4xEn0/QNOwePLQr
	cFJr/WHypUBYPiGigloL77/E7c1oPba6PvzO4vnyJZNjKQAU78y6BqNCnjebKL3i9KEAs2Nj8OLCv
	qbOXWsch2+BJ9bVaXDMMS3sEdRNVx3Oq8HMDQvnoURsAhXDP6Of8dxRd1AH4hxKqm0Ska0uDM7pGj
	njCXcs5A1huGOzF8BI1Xua+wuLL9uOatvf1dDFIH2ozbk8H2xR8y/ZlF7DZ843ObEKlciSTaaENvB
	czJwlQM64cUQA83SnhsfSRmVluDShhEgF5aEae6HB0XpTMi/wPAHwkkYBhlZS2KZkyYOannJKlsJf
	NDnCBtSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uomMY-00000009ipb-1fMy;
	Wed, 20 Aug 2025 17:12:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5A5203002ED; Wed, 20 Aug 2025 19:12:37 +0200 (CEST)
Date: Wed, 20 Aug 2025 19:12:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "jolsa@kernel.org" <jolsa@kernel.org>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>,
	"haoluo@google.com" <haoluo@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250820171237.GL4067720@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
 <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>

On Wed, Aug 20, 2025 at 03:58:14PM +0000, Edgecombe, Rick P wrote:
> I'm not sure we should optimize for shadow stack yet. Unless it's easy to think
> about... (below)
> 
> On Wed, 2025-08-20 at 14:30 +0200, Peter Zijlstra wrote:
> > --- a/arch/x86/include/asm/shstk.h
> > +++ b/arch/x86/include/asm/shstk.h
> > @@ -23,6 +23,8 @@ int setup_signal_shadow_stack(struct ksi
> >  int restore_signal_shadow_stack(void);
> >  int shstk_update_last_frame(unsigned long val);
> >  bool shstk_is_enabled(void);
> > +int shstk_pop(u64 *val);
> > +int shstk_push(u64 val);
> >  #else
> >  static inline long shstk_prctl(struct task_struct *task, int option,
> >  			       unsigned long arg2) { return -EINVAL; }
> > @@ -35,6 +37,8 @@ static inline int setup_signal_shadow_st
> >  static inline int restore_signal_shadow_stack(void) { return 0; }
> >  static inline int shstk_update_last_frame(unsigned long val) { return 0; }
> >  static inline bool shstk_is_enabled(void) { return false; }
> > +static inline int shstk_pop(u64 *val) { return -ENOTSUPP; }
> > +static inline int shstk_push(u64 val) { return -ENOTSUPP; }
> >  #endif /* CONFIG_X86_USER_SHADOW_STACK */
> >  
> >  #endif /* __ASSEMBLER__ */
> > --- a/arch/x86/kernel/shstk.c
> > +++ b/arch/x86/kernel/shstk.c
> > @@ -246,6 +246,46 @@ static unsigned long get_user_shstk_addr
> >  	return ssp;
> >  }
> >  
> > +int shstk_pop(u64 *val)
> > +{
> > +	int ret = 0;
> > +	u64 ssp;
> > +
> > +	if (!features_enabled(ARCH_SHSTK_SHSTK))
> > +		return -ENOTSUPP;
> > +
> > +	fpregs_lock_and_load();
> > +
> > +	rdmsrq(MSR_IA32_PL3_SSP, ssp);
> > +	if (val && get_user(*val, (__user u64 *)ssp))
> > +	    ret = -EFAULT;
> > +	ssp += SS_FRAME_SIZE;
> > +	wrmsrq(MSR_IA32_PL3_SSP, ssp);
> > +
> > +	fpregs_unlock();
> > +
> > +	return ret;
> > +}
> > +
> > +int shstk_push(u64 val)
> > +{
> > +	u64 ssp;
> > +	int ret;
> > +
> > +	if (!features_enabled(ARCH_SHSTK_SHSTK))
> > +		return -ENOTSUPP;
> > +
> > +	fpregs_lock_and_load();
> > +
> > +	rdmsrq(MSR_IA32_PL3_SSP, ssp);
> > +	ssp -= SS_FRAME_SIZE;
> > +	wrmsrq(MSR_IA32_PL3_SSP, ssp);
> > +	ret = write_user_shstk_64((__user void *)ssp, val);
> 
> Should we role back ssp if there is a fault?

Ah, probably. And same with pop I suppose, don't adjust ssp if we can't
read it etc.

> > +	fpregs_unlock();
> > +
> > +	return ret;
> > +}
> > +
> >  #define SHSTK_DATA_BIT BIT(63)
> >  
> >  static int put_shstk_data(u64 __user *addr, u64 data)
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -804,7 +804,7 @@ SYSCALL_DEFINE0(uprobe)
> >  {
> >  	struct pt_regs *regs = task_pt_regs(current);
> >  	struct uprobe_syscall_args args;
> > -	unsigned long ip, sp;
> > +	unsigned long ip, sp, sret;
> >  	int err;
> >  
> >  	/* Allow execution only from uprobe trampolines. */
> > @@ -831,6 +831,9 @@ SYSCALL_DEFINE0(uprobe)
> >  
> >  	sp = regs->sp;
> >  
> > +	if (shstk_pop(&sret) == 0 && sret != args.retaddr)
> > +		goto sigill;
> > +
> >  	handle_syscall_uprobe(regs, regs->ip);
> >  
> >  	/*
> > @@ -855,6 +858,9 @@ SYSCALL_DEFINE0(uprobe)
> >  	if (args.retaddr - 5 != regs->ip)
> >  		args.retaddr = regs->ip;
> >  
> > +	if (shstk_push(args.retaddr) == -EFAULT)
> > +		goto sigill;
> > +
> 
> Are we effectively allowing arbitrary shadow stack push here? 

Yeah, why not? Userspace shadow stacks does not, and cannot, protect
from the kernel being funneh. It fully relies on the kernel being
trusted. So the kernel doing a shstk_{pop,push}() to make things line up
properly shouldn't be a problem.

> I see we need to be in in_uprobe_trampoline(), but there is no mmap
> lock taken, so it's a racy check.

Racy how? Isn't this more or less equivalent to what a normal CALL
instruction would do?

> I'm questioning if the security posture tweak is worth thinking about for
> whatever the level of intersection of uprobes usage and shadow stack is today.

I have no idea how much code is built with shadow stack enabled today;
but I see no point in not supporting uprobes on it. The whole of
userspace shadow stacks only ever protects from userspace attacking
other userspace -- and that protection isn't changed by this.


