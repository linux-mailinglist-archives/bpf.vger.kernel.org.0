Return-Path: <bpf+bounces-63503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA99B081AA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DFA4E6E06
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1219DF8D;
	Thu, 17 Jul 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUulNxb5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A3381BA;
	Thu, 17 Jul 2025 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713377; cv=none; b=QURJniVXE0J0NUMd0f6zlc1cEnGO5FF4hJCimwzzRSme+ImOxl7wsX0aPAOW6qzUbp+EMOf1SJQRFUbTdPnElMka/C6cPkdVFHIirJbsw+G18UDyUbRd19BAuYDIsWoMa7gF03wg++mAD4Rp5fuGAa3fxiUgjFkI+pezes+HNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713377; c=relaxed/simple;
	bh=C2b/kOYVqI3Ik9wJG1cCvS1xgXw2Z2eD/k8cW3enH9g=;
	h=Message-ID:Date:From:To:Cc:Subject; b=s+hKEioOufLZtvLCAhzlM+7EGD2SiToNDbc/V7jBBUkz1VR15UjzXVdTp6Wi2fX+rO5nGFwmV02sStYZH6D/nZtfS3QHbUEu0tstpEZSW/3NUxiRLCc4AfGN3wtJBx+mrvBS0Yr3LsaGA3BwoeYcI83HWJntNmCcXOeYPxZHJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUulNxb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79573C4CEE7;
	Thu, 17 Jul 2025 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752713376;
	bh=C2b/kOYVqI3Ik9wJG1cCvS1xgXw2Z2eD/k8cW3enH9g=;
	h=Date:From:To:Cc:Subject:From;
	b=QUulNxb5NneF/IgLhr+ouNzzLeRNF54YSS2iwU2rss1/a4W2dqa259a/nVfNMGfVi
	 009APxLMKAQgEp7/WPTq5CceeW5g/R2f0o/O/V1xhZi0+P9iN8kF78y3r9luoeYyt6
	 yC6pDy9kFrY7+8AWxXM/8f0bry8aSZVTcfAXdoFnJa/f8kB0amBm2Kk5aM4l6twr6r
	 Wz9rJcnDKU4IvpvVIoA54uggCG0ouZdXt4AdUVTl23szDH2QrKqSkuc3A2DWdNyvv6
	 98tLDkyk88VjTMHWz1xUnWK22WpEAmuZYxUuSGKvLhb8FzeCxhHDXlFuBGNcvgx7Qd
	 nLVRv6POc9bvw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucCou-000000067RU-2IXy;
	Wed, 16 Jul 2025 20:49:56 -0400
Message-ID: <20250717004910.297898999@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 16 Jul 2025 20:49:10 -0400
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
Subject: [PATCH v14 00/12] unwind_user: x86: Deferred unwinding infrastructure
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
Of the 12 patches, only 2 are x86 specific. The rest is simply the unwinding
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
will set the corresponding bit for that tracer it its mask. As two of the bits
are used internally, this means at most 30 on 32 bit systems or 62 on 64 bit
systems of tracers may be registered at a given time.  This should not be an
issue as only one perf application, or ftrace instance should request a bit.
BPF should also use only one bit and handle any multiplexing for its users.

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

Head SHA1: f14e91fa8019acefb146869eb465966a88ef6f3b

Changes since v13: https://lore.kernel.org/linux-trace-kernel/20250708012239.268642741@kernel.org/


- Folded patch 1 ("unwind_user: Add user space unwinding API) into patch 2
  ("unwind_user: Add frame pointer support") as there was no real reason
  to separate the two.

- Only check alignment of cfa instead of cfa + frame->ra_off, that way
  both ra_off and fp_off should also be aligned.

- Incorporated some of Mathieu's changes from:
  https://lore.kernel.org/all/20250710164301.3094-2-mathieu.desnoyers@efficios.com/

- Updated the get_cookie() to be more like what Peter Zijlstra proposed:
  https://lore.kernel.org/all/20250715102912.GQ1613200@noisy.programming.kicks-ass.net/

- Added comment to explain struct unwind_task id.
 
- Tweaked KernelDoc of unwind_deferred_request()

- Removed update to convert pending over to local_t as the standalone
  pending field as it goes away in later patches.

- Added WARN_ON_ONCE when unwind_deferred_request() is called from NMI
  context when an architecture doesn't support it. (Peter Zijlstra).

- Always do the try_cmpxchg() in unwind_deferred_request() instead of
  having a special case for !CAN_USE_IN_NMI as that logic is replaced in
  later patches.

- Fold ("unwind: Clear unwind_mask on exit back to user space") into
  ("unwind deferred: Use bitmask to determine which callbacks to call").

- Move unwind_mask field to the beginning of unwind_task_info for better
  alignment.

- Have unwind_deferred_request() return 1 for both pending and already
  executed. Basically it now returns 0 - queued and callback will be
  called; 1 - it is already pending or has already executed; -1 - an error
  happened. (Peter Zijlstra)

- Use atomic_long_fetch_andnot() instead of a try_cmpxchg() loop on
  info->unwind_mask when clearing pending bit. (Peter Zijlstra)

- Added atomic_long_fetch_or() to update the pending bit and new requests.
  (Peter Zilstra)

- Added a RESERVED_BITS to assign unwind_mask and make sure that no work
  being cancelled would clear one of those bits.

- The UNWIND_USED and UNWIND_PENDING are now enums.

- Have the locking of the link list walk use guard(srcu_lite)
  (Peter Zijlstra)
 
- Fixed up due to the new atomic_long logic.

- Added new patch to prevent a callback being called twice because of
  another tracer requesting a callback after other callbacks have been
  called. By using atomic_long_fetch_or() to set the work bit and PENDING
  bit, it leaves other work bits set in the task's unwind_mask that have
  already had their callabcks called. Added a new unwind_completed mask in
  the cache that is used to keep track of what callbacks have been called
  and will not call them againg until the task has left the kernel.

- Removed handling of compat code and instead added a patch that lets the
  architecture not do the deferred stacktrace if the task can not support it.
  Specifically, x86 will not do the deferred stacktrace if the task is
  running in 32 bit mode. sframes doesn't currently support 32 bit x86
  anyway, and will likely never support it.



Josh Poimboeuf (4):
      unwind_user: Add user space unwinding API with frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/x86: Enable frame pointer unwinding on x86

Steven Rostedt (8):
      unwind_user/deferred: Add unwind_user_faultable()
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Add unwind_completed mask to stop spurious callbacks
      unwind: Add USED bit to only have one conditional on way back to user space
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Finish up unwind when a task exits
      unwind deferred/x86: Do not defer stack tracing for compat tasks

----
 MAINTAINERS                           |   8 +
 arch/Kconfig                          |   7 +
 arch/x86/Kconfig                      |   1 +
 arch/x86/include/asm/unwind_user.h    |  22 ++
 include/asm-generic/Kbuild            |   1 +
 include/asm-generic/unwind_user.h     |   5 +
 include/linux/entry-common.h          |   2 +
 include/linux/sched.h                 |   5 +
 include/linux/srcu.h                  |   4 +
 include/linux/unwind_deferred.h       |  86 ++++++++
 include/linux/unwind_deferred_types.h |  39 ++++
 include/linux/unwind_user.h           |  14 ++
 include/linux/unwind_user_types.h     |  44 ++++
 kernel/Makefile                       |   1 +
 kernel/exit.c                         |   2 +
 kernel/fork.c                         |   4 +
 kernel/unwind/Makefile                |   1 +
 kernel/unwind/deferred.c              | 365 ++++++++++++++++++++++++++++++++++
 kernel/unwind/user.c                  | 128 ++++++++++++
 19 files changed, 739 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c

