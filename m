Return-Path: <bpf+bounces-58586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79CABDFB4
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE41F4C3849
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48626FA57;
	Tue, 20 May 2025 15:56:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550526D4C3;
	Tue, 20 May 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756603; cv=none; b=NLrFkQR3AZoJL2MTttMbGR6NNQXWvMLa/8yUi/IQlTJAmgQPxy8urn6LAb6/Lbi3+sUE6JHG/wqq5VM5mxCsdolKY8itEUcrGZvDeZJ5aAbwCldnp2kLRREdES2d5G5xe7acGZvROT1a5M8P/nenVC8Cl1JxZCNQ/yPtkytlFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756603; c=relaxed/simple;
	bh=9t27kuG+nmeuoyFeo+Lr3zYDfVp+3AnIEpw2qvtpWCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0f3QdsvsJK5KTXPw4ymHyLBrPo6WOB2zyiKNtCXm76mKR8R4e9Se6p1dWFVdU24n77al6HplG17y2AcpymydwXn8wOfvugr49lN5C9EuVQHv7OYPVQahVaMllTa1hj3jlbQhnzIrc2QheEJGla33vkH/ICsr/O8MJfW58YvLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593CC4CEEA;
	Tue, 20 May 2025 15:56:41 +0000 (UTC)
Date: Tue, 20 May 2025 11:57:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrii
 Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Indu
 Bhagat <indu.bhagat@oracle.com>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250520115721.7a4307a2@gandalf.local.home>
In-Reply-To: <aCxM_BizulyIVcdb@gmail.com>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
	<20250519113339.027c2a68@batman.local.home>
	<aCxM_BizulyIVcdb@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 11:35:56 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > Ah, I think I forgot about that. I believe the exit path can also be a
> > faultable path. All it needs is a hook to do the exit. Is there any
> > "task work" clean up on exit? I need to take a look.  
> 
> Could you please not rush this facility into v6.16? It barely had any 
> design review so far, and I'm still not entirely sure about the 
> approach.

Hi Ingo,

Note, there has been a lot of discussion on this approach, although it's
been mostly at conferences and in meetings. At GNU Cauldron in September
2024 (before Plumbers) Josh, Mathieu and myself discussed it in quite
detail. I've then been hosting a monthly meeting with engineers from
Google, Red Hat, EffiOS, Oracle, Microsoft and others (I can invite you to
it if you would like). There's actually two meetings (one that is in a Asia
friendly timezone and another in a European friendly timezone). The first
patches from this went out in October, 2024:

  https://lore.kernel.org/all/cover.1730150953.git.jpoimboe@kernel.org/

There wasn't much discussion on it, although Peter did reply, and I believe
that we did address all of his concerns.

Josh then changed the approach from what we originally discussed, which was
to just have each tracer attach a task_work to the task it wants a trace
thinking that would be good enough, but Mathieu and I found that it doesn't
work because even a perf event can not handle this because it would need to
keep track of several tasks that may migrate.

Let me state the goal of this work, as it started from a session at the
2022 Tracing Summit in London. We needed a way to get reliable user space
stack traces without using frame pointers. We discussed various methods,
including using eh_frame but they all had issues. We concluded that it
would be nice to have an ORC unwinder (technically it's called a stack
walker), for user space.

Then in Nov 2022, I read about "sframes" which was exactly what we were
looking for:

   https://www.phoronix.com/news/GNU-Binutils-SFrame

At FOSDEM 2023, I asked Jose Marchesi (a GCC maintainer) about sframes, and
it just happened to be one of his employees that created it (Indu Bhagat).
At Kernel Recipes 2023, Brendan Gregg, during his talk, asked if it would
be great to have user space stack walking without needing to run everything
with frame pointers. I raised my hand and asked if he had heard about
"sframes", which he did not. I explained what it was and he was very
interested. After that talk, Josh Poimboeuf came up to me and asked if he
could implement this, which I agreed.

One thing that is needed for sframes is that it has to be done in a
faultable context. The sframe sections are like ORC, where it has lookup
tables, but they live in the user space address, and because they can be
large, they can't be locked into memory. This brings up the deferred
unwinding aspect.

At the LSFMMBPF 2023 conference, Indu and myself ran a session on sframes
to get a better idea on how to implement this. The perf user space stack
tracing was mentioned, where if frame pointers are not there, perf may copy
thousands of bytes of the user space stack into the perf buffer. If there's
a long system call, it may do this several times, and because the user
space stack does not change while the task is in the kernel, this is
thousands of bytes of duplicate data. I asked Jiri Olsa "why not just defer
the stack trace and only make a single entry", and I believe he replied "we
are thinking about it", but nothing further came about it.

Now, there's a serious push to get sframes upstream, and that will take a
few steps. These are:

1) Create a new user unwind stack call that is expected to be called in
   faultable context. If a tracer (perf, ftrace, BPF or whatever) knows
   it's in a faultable context and wants a trace, it can simply ask for it.

   It was also asked to have a user space system call that can get this
   trace so that a function in a user space applications can see what is
   calling it.

2) Create a deferred stack unwinding infrastructure that can be used by
   many clients (perf, ftrace, BPF or whatever) and called in any context
   (interrupt or NMI).

   As the unwind stack call needs to be in a faultable context, and it is
   very common to want both a kernel stack trace along with a user space
   stack trace and this can happen in an NMI, allow the kernel stack trace
   to be executed and delay the user stack trace.

   The accounting for this is not easy, as it has a many to many
   relationship. You could have perf, ftrace and BPF all asking for a
   delayed stack trace and they all need to be called. But each could be
   wanting a stack trace from a different set of tasks. Keeping track of
   which tracer gets a callback for which task is where this patch set
   comes in. Or at least just the infrastructure part.

3) Add sframes.

   The final part is to get this working with sframes. Where a distro
   builds all its applications with sframes enabled and then perf, ftrace,
   BPF or whatever gets access to it through this interface.

There's quite a momentum of work happening today that is being built
expecting us to get to step 3. There's no use to adding sframes to
applications if the kernel can't read them. The only way to read them is to
have this deferred infrastructure.

We've discussed the current design quiet a bit, but until there's actual
users starting to build on top of it, all the corner cases may not come
out. That's why I'm suggesting if we can just get the basic infrastructure
in this merge window, where it's not fully enabled (there are no users of
it), we can then have several users build on top of it in the next merge
window to see if it finds anything that breaks.

As perf has the biggest user space ABI, where the delayed stack trace may
be in a different event buffer than where the kernel stack trace occurred
(due to migration), it's the one I'm most concern about getting this right.
As once it is exposed to user space, it can never change. That's the one I
do want to focus on the most. But it shouldn't delay getting the non user
space visible aspect of the kernel side moving forward. If we find an
issue, it can always be changed because it doesn't affect user space.

I've been testing this on the ftrace side and so far, everything works
fine. But the ftrace side has the deferred trace always in the same
instance buffer as where it was triggered, as it doesn't depend on user
space API for that.

I've also been running this on perf and it too is working well. But I don't
know the perf interface well enough to make sure there isn't other corner
cases that I may be missing.

For 6.16, I would just like to get the common infrastructure in the kernel
so there's no dependency on different tracers. This patch set adds the
changes but does not enable it yet. This way, perf, ftrace and BPF can all
work to build on top of the changes without needing to share code.

There's only two patches that touch x86 here. I have another patch series
that removes them and implements this for ftrace, but because no
architecture has it enabled, it's just dead code. But it would also allow
to build on top of the infrastructure where any architecture could enable
it. Kind of like what PREEMPT_RT did.

-- Steve

