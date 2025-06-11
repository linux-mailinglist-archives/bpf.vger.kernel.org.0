Return-Path: <bpf+bounces-60270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CFAD47A8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 03:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C817BBA9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59898178395;
	Wed, 11 Jun 2025 01:03:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE958BE5;
	Wed, 11 Jun 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603787; cv=none; b=TBdHWd+z/ooVvTR79hSIPOu/m0L2q5+S9mjX6zFU2S3WukVN6Xi+/aobFrvctQCvWOTeKY7wpmffjPOqBm/7ucn1IMavGlG2wp8QC5iKGkIysGbZk2ipZiFyCQKojpcv9bKZT8HXFWWQyBR97mWIG4+94qVjFklAqxjvnQJsM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603787; c=relaxed/simple;
	bh=exb7JUf+tbib6ikx7I8pISV7GGgz6+WoccCrxsZNBcw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=sHEhQnSmMAfh9Th1EuPpFY22TfhneE9HJzlyt93l+G+hemOxIoRcQmX+eRUqimG7iV85ozhRampXDapJQstGX+iPUBQDKr7xURzFYG3RPUr1ScI7dlsnj4NBEn/HEBfaazoQjHQMQJ4MtsgY7TfoXC39grXk0lE2vcAji5cP/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 78199101B92;
	Wed, 11 Jun 2025 01:02:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5528933;
	Wed, 11 Jun 2025 01:02:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uP9tD-00000000v7H-3kGs;
	Tue, 10 Jun 2025 21:04:27 -0400
Message-ID: <20250611005421.144238328@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 10 Jun 2025 20:54:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 00/14] unwind_user: x86: Deferred unwinding infrastructure
X-Stat-Signature: pfzjw5btcbh94deject8f4jaqahsmhrs
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5528933
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fiif6H0yu55Yf92uluMYalVBefPqirDU=
X-HE-Tag: 1749603776-527289
X-HE-Meta: U2FsdGVkX1/PfzX7LNy/3kSVETEkmSSBUf2zi+0dIhoXabJj7R8E1enq/Yiqz8Wyjzp9a8I0lBrnAHTRLzY+LLbZj/gTGaFydDbfpSRUTh62O/CYn6T3D7bCqbGIkXgr36xNf08hI8XbUAaybDJu5XSirKKnXsiwqwhHsRA18lDeoqVPV4awpbFuW3rYvWZnc+exsEx5f/bXsIh9MRwZBMQuppGTkt2YxE8IoSd4vnbEiHYvQOxy+nKpmTPipiFlXNA7FHwfD86n37JqJAS5vyDCrCEL7aizAgS0YL5aNpOxcg+2+A+dbYAhEieX+yeIcl3GbkljKAMzJxjriqDaooV6BQFbKuy3KDh+uShyIQnqTE5NGk/VTUhebJ8khIaJTf+Ziv0LQy9PlwsGGYSLBC6QdELSKRGQqMKSIVxq58LNsaRz8iIHsQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


Hi Peter and Ingo,

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
Of the 14 patches, only 3 are x86 specific. The rest is simply the unwinding
code that s390 can build against. I moved the 3 x86 specific to the end
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
take a timestamp. This timestamp will be used as the identifier for the user
space stack trace. As the user space stack trace does not change while the
task is in the kernel, requests that come in after the first request and
before the task goes back to user space will get the same timestamp. This
timestamp also serves the purpose of knowing how far back a given user space
stack trace goes. If there's dropped events, and the events dropped miss a
task entering user space and coming back to the kernel, the new stack trace
taken when it goes back to user space should not be used with the events
before the drop happened.

When a tracer makes a request, it gets this timestamp, and the tasks bitmask
sets the bit for the requesting tracer. A task work is used to have the task
do the callbacks before it goes back to user space. When it does, it will scan
its bitmask and call all the callbacks for the tracers that have their
representing bit set. The callback will receive the user space stack trace as
well as the timestamp that was used.

That's the basic idea. Obviously there's more to it than the above
explanation, but each patch explains what it is doing, and it is broken up
step by step.

I fully tested these patches in my own test suite, which it did find minor
bugs which I fixed.

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
x86 code. Or it can be in the tip tree as a separate branch on top of 6.16-rc2
(or rc3 if someone finds some issues), and I'll just base my work on top of
that. Doesn't matter either way.

Thanks!

-- Steve


[1] https://sourceware.org/binutils/wiki/sframe

Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223435.636200356@goodmis.org/

- As asm-generic headers are not included when an architecture defines the
  header, having more than one #ifndef and setting variables does not work
  with those checks in the asm-generic header and the architecture header
  does not define all the values.
    
  o Move ARCH_INIT_USER_FP_FRAME check to linux/user_unwind.h
    
  o Have linux/user_unwind.h include asm/user_unwind.h and not have C files
    have to call the asm header directly
    
  o Remove unnecessary frame initialization
    
  o Added unwind_user.h to asm-generic/Kbuild

  o Move #indef arch_unwind_user_state to linux/user_unwind_types.h
    
  o Move the following to linux/unwind_user.h:
       #ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
       #ifndef arch_unwind_user_init
       #ifndef arch_unwind_user_next
    
- Changed UNWIND_GET_USER_LONG() to use "unsigned long" instead of u64 as
  this can be called on 32 bit architectures and just because
  "compat_state()" returns false doesn't mean that the value is 64 bit.

- Check for ret < 0 instead of just ret != 0 from return code of
  task_work_add(). Don't want to just assume it's less than zero as it
  needs to return a negative on error.

- Use BIT() macro for bit setting and testing.

- Moved the "unwind_mask" from the task_struct into the task->unwind_info
  structure.

- Fix compare with ~UNWIND_PENDING_BIT to be ~UNWIND_PENDING

- Remove unneeded include of perf_event.h


This series can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/core



Josh Poimboeuf (9):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user: Add compat mode frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86

Steven Rostedt (5):
      unwind_user/deferred: Add unwind_deferred_trace()
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Clear unwind_mask on exit back to user space
      unwind: Finish up unwind when a task exits

----
 MAINTAINERS                              |   8 +
 arch/Kconfig                             |  11 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/events/core.c                   |  44 +---
 arch/x86/include/asm/ptrace.h            |   2 +
 arch/x86/include/asm/unwind_user.h       |  60 +++++
 arch/x86/include/asm/unwind_user_types.h |  17 ++
 arch/x86/kernel/ptrace.c                 |  38 +++
 include/asm-generic/Kbuild               |   2 +
 include/asm-generic/unwind_user.h        |   5 +
 include/asm-generic/unwind_user_types.h  |   5 +
 include/linux/entry-common.h             |   2 +
 include/linux/sched.h                    |   5 +
 include/linux/unwind_deferred.h          |  75 ++++++
 include/linux/unwind_deferred_types.h    |  18 ++
 include/linux/unwind_user.h              |  33 +++
 include/linux/unwind_user_types.h        |  39 ++++
 kernel/Makefile                          |   1 +
 kernel/exit.c                            |   2 +
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 383 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 128 +++++++++++
 23 files changed, 846 insertions(+), 39 deletions(-)
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

