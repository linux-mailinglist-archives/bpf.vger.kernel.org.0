Return-Path: <bpf+bounces-56796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF2A9DD05
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7201890381
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667F1E8327;
	Sat, 26 Apr 2025 20:06:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EB2628D;
	Sat, 26 Apr 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697994; cv=none; b=lYtu55Sz3I2ii3l+pxO4h5T9IkSjT/FlBvfqJjuGdf+XR3PO8YxwzPBBygRGs1fCKZ7pt4vK4nO2PIgi9FZxzA+f0i6FwaEVPbqi57yLxTb2nnk5QXR27zYXQ6wRHJc3vYuBXuVbhK8b3OI4hFsLqPdB+HrCX9YaVpNVpp1mUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697994; c=relaxed/simple;
	bh=MsTrO+1ne8sHT0CmfxeIoNCxi2M7Yv+mTJfpHw2klGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoYWkE5KvZhqArTnsM8ks5DRdix8xLm6RxuYhysdVTBWAduej9aCNGg8ZsMwHHeWEFCFE29GHN7/7i9sFmqHog60cZWiFCqmnMGCCzoqw2BQMsyFO/oPOTl4vf0Xulsg9bs27vWERKSX06lKzOlz+IxpjfxhsCjg4ee2YdoEHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AB4C4CEE2;
	Sat, 26 Apr 2025 20:06:31 +0000 (UTC)
Date: Sat, 26 Apr 2025 16:06:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
 <mingo@redhat.com>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: Introduce task_*() helpers for PF_ flags
Message-ID: <20250426160630.46108366@gandalf.local.home>
In-Reply-To: <aA0pDUDQViCA1hwi@gmail.com>
References: <20250425204120.639530125@goodmis.org>
	<20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
	<20250426084320.335d4cb2@batman.local.home>
	<aA0pDUDQViCA1hwi@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 20:42:21 +0200
Ingo Molnar <mingo@kernel.org> wrote:


> > kernel/sched/core.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> > kernel/sched/fair.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
> > kernel/trace/bpf_trace.c:                    current->flags & (PF_KTHREAD | PF_EXITING)))
> > kernel/trace/bpf_trace.c:       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))
> > 
> > Maybe we can have a: is_user_exiting_or_kthread() ?  
> 
> No, we don't need is_user_exiting_or_kthread(). At all. Ever. In this 
> universe. Or in any alternative universes. We don't even need 
> is_user_exiting_or_kthread() in horror fiction novels written for 
> kernel developers: there's really a limit to the level of horror that 
> people are able to accept. Sheesh ...

Ingo,

A simple "No we do not need that" would suffice. This isn't 2005 anymore,
where we come up with creative ways to insult each other. We're better now.



> And no, we don't need separate helpers for !task_kthread() et al: the C 
> logical negation unary operator is perfectly readable when placed 
> before a function call or a macro invocation, and a competent Linux 
> kernel developer is expected to recognize it on sight:
> 
> 	if (!task_kthread(task))
> 		...

Not really. I originally tried just having a single "is_kernel_thread()"
where I would use the "!is_kernel_thread()" for user thread, but honestly,
it wasn't much better than the "!(task->flags & PF_KTHREAD)".

And just because it's not a kernel thread, does it mean it will always be a
user space thread? Could it one day also be a guest thread (if we decide to
have such a thing)?

Wanting to know if something is a user space thread, "if (!task_kthread(task))"
seems short sighted. As it assumes that we only have two types of threads.
It may be true today, but may not be the case in the future.

	if (!task_kthread(task))

Still takes a second more to understand that's a user space thread than:

	if (task_user(task))

would.

-- Steve

