Return-Path: <bpf+bounces-61910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0DAEEB63
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABD5189F6BA
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A818C00B;
	Tue,  1 Jul 2025 00:54:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292C72605;
	Tue,  1 Jul 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331263; cv=none; b=S63oXQqRWhM0/AFreA+uONma/Rq1nHHd/7StAch26nO4es8XHewHQ6+S048Il34kKATaj/8swHHCQVvDVrFv7q+3KBF8usO8hxtc+K7wXDY1KsjP+LnKP9pR6UHT69pa/IxElV/emVNSblvmznG1dLxpNurq+JM+p4R8nMspmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331263; c=relaxed/simple;
	bh=QX1soIcg/LGD2MctiUxEihaZNkhWiGRQT8tmBHBQU6c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=G9gLGg5vAFNEySo3YJf2kV4GzxclhBcBDsphjLVNwDeZArljShi1EA168JwtmWHn4jPZFTmz6Qdjimd0O4UrffhkxKcBc9xHe1XdC9KwkexiMZZSDiexyY0MO1VvNcnptcpgNwYN/mbRNCTsdk2rEf+d0WJxLxjFihafANnwcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 83711104396;
	Tue,  1 Jul 2025 00:54:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 2724420024;
	Tue,  1 Jul 2025 00:54:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uWPGs-00000007NeF-2tmC;
	Mon, 30 Jun 2025 20:54:50 -0400
Message-ID: <20250701005321.942306427@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 30 Jun 2025 20:53:21 -0400
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v12 00/14] unwind_user: x86: Deferred unwinding infrastructure
X-Stat-Signature: juf5zu1wf4xnx9d3d4pdp8mk9789o38n
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2724420024
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IjSkoIc198HtynZRdggK+Vw34pBg/0Fs=
X-HE-Tag: 1751331254-847520
X-HE-Meta: U2FsdGVkX18wcSW/Bc7V/Kzkkc5tnDdPRPs8I0tAn4dcXhuwrL1mxxFUbxcoLWaFhJXHCpHMuWAEluwUREkBWSeCrsWpku/30BpDJ/B/Pc0JvD+I0aY/zLtEXBxwa58eTHB4PJpnxRYBp5NT/py5hYYsEvXZU0jgYkEsmj546Q2Vt2Y8Ay37kzvR5+DaqIvZ0yoEj1yRBf9K5TONHdmYFz6Qb/I8iYzwZvM8jpZQFfhSRQ6GrIIyetxUba7oe0jjP8hcQf/MeOU67RcEHYXAEOXG2o7XtJFjEIct4BwoaK1nyQcPKOErVcNtfpNmNdMeXGFfw8CDJAu0PH4WArkbRpLWqb0ypRWafqEds7fGEmH0fFi78RxJb7n/fWo1xxQ6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


[
   UPDATE: Florian Weimer is looking to having Fedora built with SFrames
           so that once this becomes available in the kernel, it will
           also be usable in Fedora.
]

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

This is based on top of v6.16-rc4 and the code is here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git unwind/core

  Head SHA1: 649fe8a37fbb8bc7eb1d420630523feb4f44d1d7

Changes since v11: https://lore.kernel.org/linux-trace-kernel/20250625225600.555017347@goodmis.org/

- Add USED bit to the task's unwind_mask to know if the faultable user stack
  function was used or not. This allows for only having to check one value on
  the way back to user space to know if it has to do more work or not.

- Fix header macro protection name to include X86 (Ingo Molnar)

- Use insn_get_seg_base() to get segment registers instead of using the
  function perf uses and making it global. Also as that function doesn't
  look to have a requirement to disable interrupts, the scoped_guard(irqsave)
  is removed.

- Check return code of insn_get_seg_base() for the unlikely event that it
  returns invalid (-1).

- Moved arch_unwind_user_init() into stacktrace.c as to use
  insn_get_seg_base(), it must include insn-eval.h that defines
  pt_regs_offset(), but that is also used in the perf generic code as an
  array and if it is included in the header file, it causes a build
  conflict.

- Update the comments that explain arch_unwind_user_init/next that a macro
  needs to be defined with those names if they are going to be used.

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
 include/linux/unwind_deferred_types.h    |  20 ++
 include/linux/unwind_user.h              |  45 ++++
 include/linux/unwind_user_types.h        |  39 ++++
 kernel/Makefile                          |   1 +
 kernel/exit.c                            |   2 +
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 357 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 130 +++++++++++
 21 files changed, 805 insertions(+)
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

