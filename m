Return-Path: <bpf+bounces-51130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B85CA308F6
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D4161F52
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6771F4E2F;
	Tue, 11 Feb 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZjG3clFi"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DAC1F4632;
	Tue, 11 Feb 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270649; cv=none; b=Ko/FipKQ5gpGKK1x8I+eNJ0l4l85ToTMSOnsot9hYM3M6+f7iliB1XzAcl9V626dNWyZzlt+QIe4hUJRYpV60dXxQFzDFwQFGaQIOjMgW02Y+Ds4cWHqn4nyA9VEbECksG0X4+CBp+tc1cRkYR7uPzdW81TK4MwkUsO88MGPeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270649; c=relaxed/simple;
	bh=Ep4/leq6trCdcX57RASQAAb/ONCLiZL4UA7MghOCpP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olDrFLIY2oLGkF3h1jCjRDH40GNl9oxVvhiUzFD0WacJoR6RaDU6zXJ0wIpcCvDKZ6uxiShIPSPyICezfxIfwiFuhFO3CL4nm7Oy76Nt3pZmeXIZweJx40E6T1AQ5Yb9qT+JrSfyEg6miQ8Vq9XzWAim8qufU7T9tVlGxb2nCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZjG3clFi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SnnXynEmlnD9mw13jyduYJJjR4QpkYRf9mDUFXT/E+0=; b=ZjG3clFisqwpnxOsPgGIRruXqx
	8QuCo21iTmNtA6L3oGAkWV8wwGF5SXmBQVm24dCPw/Xf0/socdwWDjeEiMdwY+bbrKN572w5+tSah
	3buRtHGBAkk5RdQacffe2t6pXXXck25ooq09TcpM3rzf8ogJppS5Hd2/qMJBxwz8/h78EHosEtqlw
	yh8As5a7NTXjWoLrjHYxIinA6GHVVfR5sLRFpfCyQIxo33TRbeCbfPgxsnJrsNgSxStnVZdg5FvB3
	jeydxQ/HdkUjgetGod4rv6ZGo48/aGfEkecisXfNyyqX/bmLWUsAN6Vxf9UgXi5wSftlyEjPKnuoZ
	SBy6Mdjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thnkG-00000000ydI-3HfM;
	Tue, 11 Feb 2025 10:44:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E50383004AF; Tue, 11 Feb 2025 11:43:52 +0100 (CET)
Date: Tue, 11 Feb 2025 11:43:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250211104352.GC29593@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net>
 <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>

On Mon, Feb 10, 2025 at 08:37:06PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 10, 2025 at 2:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Do you force unload the BPF program?
> 
> Not yet. As you can imagine, cancelling bpf program is much
> harder than sending sigkill to the user space process.

So you are killing the user program? Because it wasn't at all clear what
if anything is done when this failure case is tripped.

> The prog needs to safely free all the resources it holds.
> This work was ongoing for a couple years now with numerous discussions.

Well, for you maybe, I'm new here. This is only the second submission,
and really only the first one I got to mostly read.

> > Even the simple AB-BA case,
> >
> >   CPU0          CPU1
> >   lock-A        lock-B
> >   lock-B        lock-A <-
> >
> > just having a random lock op return -ETIMO doesn't actually solve
> > anything. Suppose CPU1's lock-A will time out; it will have to unwind
> > and release lock-B before CPU0 can make progress.
> >
> > Worse, if CPU1 isn't quick enough to unwind and release B, then CPU0's
> > lock-B will also time out.
> >
> > At which point they'll both try again and you're stuck in the same
> > place, no?
> 
> Not really. You're missing that deadlock is not a normal case.

Well, if this is unpriv user programs, you should most definitely
consider them the normal case. Must assume user space is malicious.

> As soon as we have cancellation logic working we will be "sigkilling"
> prog where deadlock was detected.

Ah, so that's the plan, but not yet included here? This means that every
BPF program invocation must be 'cancellable'? What if kernel thread is
hitting tracepoint or somesuch?

So much details not clear to me and not explained either :/

> In this patch the verifier guarantees that the prog must check
> the return value from bpf_res_spin_lock().

Yeah, but so what? It can check and still not do the right thing. Only
checking the return value is consumed somehow doesn't really help much.

> The prog cannot keep re-trying.
> The only thing it can do is to exit.

Right, but it might have already modified things, how are you going to
recover from that?

> Failing to grab res_spin_lock() is not a normal condition.

If you're going to be exposing this to unpriv, I really do think you
should assume it to be the normal case.

> The prog has to implement a fallback path for it,

But verifier must verify it is sane fallback, how can it do that?

> > Given you *have* to unwind to make progress; why not move the entire
> > thing to a wound-wait style lock? Then you also get rid of the whole
> > timeout mess.
> 
> We looked at things like ww_mutex_lock, but they don't fit.
> wound-wait is for databases where deadlock is normal and expected.
> The transaction has to be aborted and retried.

Right, which to me sounds exactly like what you want for unpriv.

Have the program structured such that it must acquire all locks before
it does a modification / store -- and have the verifier enforce this.
Then any lock failure can be handled by the bpf core, not the program
itself. Core can unlock all previously acquired locks, and core can
either re-attempt the program or 'skip' it after N failures.

It does mean the bpf core needs to track the acquired locks -- which you
already do, except it becomes mandatory, prog cannot acquire more than
~32 locks.

> res_spin_lock is different. It's kinda safe spin_lock that doesn't
> brick the kernel.

Well, 1/2 second is pretty much bricked imo.

> That was a conscious trade-off. Deadlocks are not normal.

I really do think you should assume they are normal, unpriv and all
that.


