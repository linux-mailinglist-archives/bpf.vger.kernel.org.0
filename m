Return-Path: <bpf+bounces-62587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5182AFBFD6
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 03:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E653B1897376
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 01:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D120459A;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJqq/AWf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892D1E47C5;
	Tue,  8 Jul 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937838; cv=none; b=JX5CPsnPgg0AbQw1DOapNNUN+DnMKKk5iHOkQUBg7eMMTCQDIXLkkCndkVyRga9ti6axu15uFY/MXpuZCBlL43sV4TGIG1hyYI0j/utywLOE5hYphKYT/QLSKerWQUGfQ16ZqeYpqF+tmxflPK1s5lV/ruIjzSf7Lbwx9C0z/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937838; c=relaxed/simple;
	bh=q3KFZIGLNkpnwH03Nfi71pzBFUpA97Haef1tYX2aEsk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ie5lGUoV6icWmn3q9yNnohk5LbXdqDAw7i/RCwD6yhhgEv18T7NHvAlPvfwRj210D3GwtxyEmkj8nje7yWFd4X8ZkfeucC5oSgxiLH8AtMytS5M4asGgr2B1IdDSi7j3EqToZ0UCkRVsJ4EnLxAkypf/Wtp8Fqks8ACg4oKaWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJqq/AWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF05FC4CEE3;
	Tue,  8 Jul 2025 01:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937837;
	bh=q3KFZIGLNkpnwH03Nfi71pzBFUpA97Haef1tYX2aEsk=;
	h=Date:From:To:Cc:Subject:From;
	b=FJqq/AWfv1qaDM5CEKYQSDCY47dr934X5ByB3BpchcT72jvzcFgy86Cx9Hf8L+MHD
	 ORu/inJbP8u+49Mg0CgaFCG71l/73vtwBtqKL16G4IdFfYAW1Ermxl4FRfX5g8hiSC
	 WPPEbb5oPOjPLDzfwUNyXpu2QKJNEAkViEi/8H6aHCNZYkgo/1i38RXMQ1KAJjNypu
	 TCmcAahYsalGVauWob5E6n+KpP6DDOck4ejPnB/XJTG8IlhdF7Fxl49kqr/ITomINU
	 TwlxZhCtIX6qSixBO/XWMLl1IkeAwh8MWlACfr7D9de5vT2WNJcrz4uBMNC1WDcxCE
	 2ekurxvIZ8e2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3t-00000000Bp0-3IJF;
	Mon, 07 Jul 2025 21:23:57 -0400
Message-ID: <20250708012239.268642741@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 00/14] unwind_user: x86: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is the first patch series of a set that will make it possible to be able
to use SFrames[1] in the Linux kernel. A quick recap of the motivation for
doing this.

Currently the only way to get a user space stack trace from a stack
walk (and not just copying large amount of user stack into the kernel
ring buffer) is to use frame pointers. This has a few issues. The biggest
one is that compiling frame pointers into every application and library
has been shown to cause performance overhead.

Another issue is that the format of the frames may not always be consistent
between different compilers and some architectures (s390) has no defined
format to do a reliable stack walk. The only way to perform user space
profiling on these architectures is to copy the user stack into the kernel
buffer.

SFrames is now supported in gcc binutils and soon will also be supported
by LLVM. SFrames acts more like ORC, and lives in the ELF executable
file as its own section. Like ORC it has two tables where the first table
is sorted by instruction pointers (IP) and using the current IP and finding
it's entry in the first table, it will take you to the second table which
will tell you where the return address of the current function is located
and then you can use that address to look it up in the first table to find
the return address of that function, and so on. This performs a user
space stack walk.

Now because the SFrame section lives in the ELF file it needs to be faulted
into memory when it is used. This means that walking the user space stack
requires being in a faultable context. As profilers like perf request a stack
trace in interrupt or NMI context, it cannot do the walking when it is
requested. Instead it must be deferred until it is safe to fault in user
space. One place this is known to be safe is when the task is about to return
back to user space.

Josh originally wrote the PoC of this code and his last version he posted
was back in January:

   https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/

That series contained everything from adding a new faultable user space
stack walking code, deferring the stack walk, implementing sframes,
fixing up x86 (VDSO), and even added both the kernel and user space side
of perf to make it work. But Josh also ran out of time to work on it and
I picked it up. As there's several parts to this series, I also broke
it out. Especially since there's parts of his series that do not depend
on each other.

This series contains only the core infrastructure that all the rest needs.
Of the 14 patches, only 2 are x86 specific. The rest is simply the unwinding
code that s390 can build against. I moved the 2 x86 specific to the end
of the series too.

Since multiple tracers (like perf, ftrace, bpf, etc) can attach to the
deferred unwinder and each of these tracers can attach to some or all
of the tasks to trace, there is a many to many relationship. This relationship
needs to be made in interrupt or NMI context so it can not rely on any
allocation. To handle this, a bitmask is used. There's a global bitmask of
size long which will allocate a single bit when a tracer registers for
deferred stack traces. The task struct will also have a bitmask where a
request comes in from one of the tracers to have a deferred stack trace, it
will set the corresponding bit for that tracer it its mask. As one of the bits
represents that a request has been made, this means at most 31 on 32 bit
systems or 63 on 64 bit systems of tracers may be registered at a given time.
This should not be an issue as only one perf application, or ftrace instance
should request a bit. BPF should also use only one bit and handle any
multiplexing for its users.

When the first request is made for a deferred stack trace from a task, it will
generate a unique cookie. This cookie will be used as the identifier for the
user space stack trace. As the user space stack trace does not change while the
task is in the kernel, requests that come in after the first request and before
the task goes back to user space will get the same cookie.  If there's dropped
events, and the events dropped miss a task entering user space and coming back
to the kernel, the new stack trace taken when it goes back to user space should
not be used with the events before the drop happened.

When a tracer makes a request, it gets this cookie, and the tasks bitmask
sets the bit for the requesting tracer. A task work is used to have the task
do the callbacks before it goes back to user space. When it does, it will scan
its bitmask and call all the callbacks for the tracers that have their
representing bit set. The callback will receive the user space stack trace as
well as the cookie that was used. It's up to the tracer to use the cookie
or not to map the user space stack trace taken back to the events where
it was requested.

That's the basic idea. Obviously there's more to it than the above
explanation, but each patch explains what it is doing, and it is broken up
step by step.

I run two SFrame meetings once a month (one in Asia friendly timezone and
the other in Europe friendly). We have developers from Google, Oracle, Red Hat,
IBM, EfficiOS, Meta, Microsoft, and more that attend. (If anyone is interested
in attending let me know). I have been running this since December of 2024.
Last year in GNU Cauldron, a few of us got together to discuss the design
and such. We are pretty confident that the current design is sound. We have
working code on top of this and have been testing it.

Since the s390 folks want to start working on this (they have patches to
sframes already from working on the prototypes), I would like this series
to be a separate branch based on top of v6.16-rc2. Then all the subsystems
that want to work on top of this can as there's no real dependency between
them.

I have more patches on top of this series that add perf support, ftrace
support, sframe support and the x86 fix ups (for VDSO). But each of those
patch series can be worked on independently, but they all depend on this
series (although the x86 specific patches at the end isn't necessarily
needed, at least for other architectures).

Please review, and if you are happy with them, lets get them in a branch
that we all can use. I'm happy to take it in my tree if I can get acks on the
x86 code. Or it can be in the tip tree as a separate branch on top of 6.16-rc4
and I'll just base my work on top of that. Doesn't matter either way.

[1] https://sourceware.org/binutils/wiki/sframe

The code for this series is located here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/core


Changes since v12: https://lore.kernel.org/linux-trace-kernel/20250701005321.942306427@goodmis.org/

- Make unwind_user_start() and unwind_user_next() static. There's no
  reason that they need to be used by other files.

- Move for_each_user_frame() macro into user.c

- Remove extra parenthesis around start in for_each_user_frame() macro
  (Mathieu Desnoyers)

- Added test when use_fp is true to make sure fp < sp (Jens Remus)

- Make sure the address read is word aligned (Linus Torvalds)

- With new alignment check, updated to handle compat mode.

- Replaced the timestamp with the generated cookie logic again. Instead of
  using a 64 bit word where the CPU part of the cookie is just 12 bits,
  make it two 32 bit words, where the CPU that the cookie is generated on
  is one word and the second word is just a per cpu counter. This allows
  for just using a 32 bit cmpxchg which works on all archs that have safe
  NMI cmpxchg.

- Now that the timestamp has been replaced by a cookie that uses only a 32
  bit cmpxchg(), this code just checks if the architecture has a safe
  cmpxchg that can be used in NMI and doesn't do the 64 bit check.
  Only the pending value is converted to local_t.

- Removed no longer used local.h headers from unwind_deferred_types.h


Josh Poimboeuf (7):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user: Add compat mode frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/x86: Enable frame pointer unwinding on x86
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86

Steven Rostedt (7):
      unwind_user/deferred: Add unwind_user_faultable()
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Clear unwind_mask on exit back to user space
      unwind: Add USED bit to only have one conditional on way back to user space
      unwind: Finish up unwind when a task exits

----
 MAINTAINERS                              |   8 +
 arch/Kconfig                             |  11 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/include/asm/unwind_user.h       |  42 ++++
 arch/x86/include/asm/unwind_user_types.h |  17 ++
 arch/x86/kernel/stacktrace.c             |  28 +++
 include/asm-generic/Kbuild               |   2 +
 include/asm-generic/unwind_user.h        |   5 +
 include/asm-generic/unwind_user_types.h  |   5 +
 include/linux/entry-common.h             |   2 +
 include/linux/sched.h                    |   5 +
 include/linux/unwind_deferred.h          |  79 +++++++
 include/linux/unwind_deferred_types.h    |  26 +++
 include/linux/unwind_user.h              |  39 ++++
 include/linux/unwind_user_types.h        |  39 ++++
 kernel/Makefile                          |   1 +
 kernel/exit.c                            |   2 +
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 363 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 147 +++++++++++++
 21 files changed, 828 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 arch/x86/include/asm/unwind_user_types.h
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/asm-generic/unwind_user_types.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c

