Return-Path: <bpf+bounces-66101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F0B2E440
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 19:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 189EC4E56C4
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 17:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4F261B77;
	Wed, 20 Aug 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBpblKnV"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328325B695;
	Wed, 20 Aug 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711847; cv=none; b=hfVkqXm888TMv577+NqG1C+PwPZnepzLIeYB5deucaG4OTjUxiK78L+xXZQEY4VdRLrDJNr7bCys2UYCZJg13dqwOxEB+Q5ttF+gUrZXtfm10gMtd9KIrMjPTeu0sNj5rZLQ8oUSae3XtdteSM+MqoTCzLt0mVuutnJuKuEaCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711847; c=relaxed/simple;
	bh=FxL0NxPkofe7NitBUHU2NGWpht5QsXyst077cFH7HgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+Wl6BBJJLoWLCTMB+OniLm+fUZUwwPWXJS3iMU+01z56w4Z1wXbNBOGaAso9Wnl8Cv2S7hW3UzXQpeTtIFnyRy2VTpVyHXAKtm23vz0ZdcXTVToal3Vb2v64JMzbUOfYWZ34UMMdqrkO8X0eOVyi1NLvY01oQG99KFQhL36csA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JBpblKnV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CfXNl7lKE0vtMJcFjNQzDmOnCiJgkTHDL4PjmkqEICo=; b=JBpblKnVn/dbHdwKCXz0r8bp+4
	Wdn6labcFr3klEUj+nlpRHx60aLQSw8r1CUvvsn/JFmRPOURmkqJMgP52bh3hINxLhGvSVcO3VFi6
	pzcPWxJiQqGU7JGCBwtHrFAdL0vi87azNaAWrZvfNaoVU9V23y3LR4mMxmNdTAVSOCTVegZR9FIv+
	WcAGEif2sJYKV1294MPZqjkJS9PvyGklM5hbX4FZezUnSGjVKReT41bnkPMDNMLLuDrKIfg6F6mG8
	k9wKLmaj4IUNEifXN6IHTXe3QwJKLlU2QAABzM5atIYFrY4T9RCFcLHWuoBEOZmGAUUUrJyfMN3Qj
	jyoCnYHw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uomqi-00000000NIB-3sSK;
	Wed, 20 Aug 2025 17:43:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9472B300385; Wed, 20 Aug 2025 19:43:47 +0200 (CEST)
Date: Wed, 20 Aug 2025 19:43:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "songliubraving@fb.com" <songliubraving@fb.com>,
	"alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <20250820174347.GM3245006@noisy.programming.kicks-ass.net>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250819191515.GM3289052@noisy.programming.kicks-ass.net>
 <20250820123033.GL3245006@noisy.programming.kicks-ass.net>
 <9ece46a40ae89925312398780c3bc3518f229aff.camel@intel.com>
 <20250820171237.GL4067720@noisy.programming.kicks-ass.net>
 <62574323ba73b0fec42a106ccc29f707b5696094.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62574323ba73b0fec42a106ccc29f707b5696094.camel@intel.com>

On Wed, Aug 20, 2025 at 05:26:38PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2025-08-20 at 19:12 +0200, Peter Zijlstra wrote:
> > > Are we effectively allowing arbitrary shadow stack push here? 
> > 
> > Yeah, why not? Userspace shadow stacks does not, and cannot, protect
> > from the kernel being funneh. It fully relies on the kernel being
> > trusted. So the kernel doing a shstk_{pop,push}() to make things line up
> > properly shouldn't be a problem.
> 
> Emulating a call/ret should be fine.
> 
> > 
> > > I see we need to be in in_uprobe_trampoline(), but there is no mmap
> > > lock taken, so it's a racy check.
> > 
> > Racy how? Isn't this more or less equivalent to what a normal CALL
> > instruction would do?
> 
> Racy in terms of the "is trampoline" check happening before the write to the
> shadow stack. I was thinking like a TOCTOU thing. The "Allow execution only from
> uprobe trampolines" check is not very strong.
> 
> As for call equivalence, args.retaddr comes from userspace, right?

Yeah. So this whole thing is your random code having a 5 byte nop. And
instead of using INT3 to turn it into #BP, we turn it into "CALL
uprobe_trampoline".

That trampoline looks like:

	push %rcx
	push %r11
	push %rax;
	mov $__NR_uprobe, %rax
	syscall
	pop %rax
	pop %r11
	pop %rcx
	ret

Now, that syscall handler is the one doing shstk_pop/push. But it does
that right along with modifying the normal SP.

Basically the syscall copies the 4 (CALL,PUSH,PUSH,PUSH) words from the
stack into a local struct (args), adjusts SP, and adjusts IP to point to
the CALL instruction that got us here (retaddr-5).

This way, we get the same context as that #BP would've gotten. Then we
run uprobe crap, and on return:

 - sp changed, we take the (slow) IRET path out, and can just jump
   wherever -- typically right after the CALL that got us here, no need
   to re-adjust the stack and take the trampoline tail.

 - sp didn't change, we take the (fast) sysexit path out, and have to
   re-apply the CALL,PUSH,PUSH,PUSH such that the trampoline tail can
   undo them again.

The added shstk_pop/push() exactly match the above undo/redo of the CALL
(and other stack ops).

> > > I'm questioning if the security posture tweak is worth thinking about for
> > > whatever the level of intersection of uprobes usage and shadow stack is
> > > today.
> > 
> > I have no idea how much code is built with shadow stack enabled today;
> > but I see no point in not supporting uprobes on it. The whole of
> > userspace shadow stacks only ever protects from userspace attacking
> > other userspace -- and that protection isn't changed by this.
> 
> Isn't this just about whether to support an optimization for uprobes?

Yes. But supporting the shstk isn't hard (as per this patch), it exactly
matches what it already does to the normal stack. So I don't see a
reason not to do it.

Anyway, I'm not a huge fan of any of this. I suspect FRED will make all
this fancy code totally irrelevant. But until people have FRED enabled
hardware in large quantities, I suppose this has a use.

