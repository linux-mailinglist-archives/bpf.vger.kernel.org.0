Return-Path: <bpf+bounces-61600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2BAE916A
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554F44A7906
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C722F5325;
	Wed, 25 Jun 2025 22:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAD2F4334;
	Wed, 25 Jun 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892224; cv=none; b=Oec4cl4FnQKFq1I59op5AiYJEEZtEtxqZhdzHsmumHkgBYH21NQvQk3qQcATgYcxwotFAPOuTcfIgKfbA/OBwlc66R4M1xNqpSNyRL5PqTZaTC+s4vqmpOKe9U3hoAE7cyBpBRVFe6qCjBfdrj3FD4Cd49sdvcgfwKLzg9hv13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892224; c=relaxed/simple;
	bh=YSiwQWiMmvDUkDl9n3Ni1ByZ/YOz7AKyXoQfzAxC6uI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BJSq3HgEmZRxpxvOczv7drrHWMwq6E2nWzEku6ruogy70Qbti1gWc/ElGzZFIxqN2KTV3WfpHwwtTY6jXurE26y74pYrJ/1ntpaDG8Tv2XI9FszcnfAyYxEvtwOihSozI+0NaCd6mYrKHP685dbxJMlFDRcgLAI1SQ36jPZ0ZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 2CA0C1406B4;
	Wed, 25 Jun 2025 22:56:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1178E20030;
	Wed, 25 Jun 2025 22:56:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZ3K-000000043co-3zEt;
	Wed, 25 Jun 2025 18:57:14 -0400
Message-ID: <20250625225600.555017347@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 18:56:00 -0400
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
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding infrastructure
X-Stat-Signature: bs1dhgoixppk9dqgspzboertzugf8cm3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1178E20030
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+GlUwz+i7EvWtvl7SxEO6gbuJtk3lINN0=
X-HE-Tag: 1750892210-561781
X-HE-Meta: U2FsdGVkX1/NLV6uUwR8ETdou/BgYyyYn76oUqVTTGkd+QADsW9v0YFcwyWjnx0NsznILBXAC2bn/o+6L4AdB8bCrRTma4o61gVStzNkPLsIACXLvFFVHh7Td9kB9i9jyZTAaILJ4ppifT3guYvsvbwgphaKjJiWVKUtglMgGwvrJpWoJ7NTpywZ0Hr7w29kSwe8CnDc+HLc6waE+JYUc5wiEe2tRJ89IVtqihWqYSCQHFgUjVSJ6HOGxhU9u7+hZX2eEw4pPXoxXKD2QrHBWNPUwEo1HXy4Lz5g+NRwNMemuhxcVLt7wVbAWSo7K1Q6ddZy0ruLL2aS8OSEUPZRsGwSYB0BGHmzgan9lQwWdcWOz9nvsL5ghsU33koojJrnjcJUDzP0/3qNE+Lkz2cHGWSeyjniiyiuZFdoMf2uYv0T3EcMToBb2g==
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
x86 code. Or it can be in the tip tree as a separate branch on top of 6.16-rc2
(or rc3 if someone finds some issues), and I'll just base my work on top of
that. Doesn't matter either way.

Thanks!

-- Steve


[1] https://sourceware.org/binutils/wiki/sframe

Changes since v10: https://lore.kernel.org/linux-trace-kernel/20250611005421.144238328@goodmis.org/

[ Full diff between v11 and 10 at end of this message. ]

- Rename "the_end" label to "done" in unwind_user_next() to be more consistent
  to what the kernel uses. (Peter Zijlstra)

- Add a comment about what cfa and ra stand for. (Peter Zijlstra)

- Rename compat_state() to compat_fp_state() for consistency. (Peter Zijlstra)

- Lowercase macro UNWIND_GET_USER_LONG() to unwind_get_user_long()
  (Peter Zijlstra and Linus Torvalds)

- Move the functions arch_unwind_user_init() and arch_unwind_user_next() to
  the later patches when they are used. (Peter Zijlstra).

- Updated the change log of ("unwind_user/deferred: Add
  unwind_user_faultable()")

- Removed extra tab in Makefile (Peter Zijlstra)

- Renamed unwind_deferred_trace() to unwind_user_faultable()

- Rename unwind_exit_to_user_mode() to unwind_reset_info() as it is called
  in a noinstr section and the current name looks like it does
  instrumentation (Peter Zijlstra)

- Make the allocated cache fit inside a 4K page. (Peter Zijlstra)

- Added comment stating that the clock used for the timestamp must have a
  resolution that will guarantee that two system called back to back will
  have a different timestamp.

- Update change log to mention that each perf program and ftrace intance
  will register with the deferred unwinder. (Peter Zijlstra).

- Reworked to simply use a 64bit cmpxchg to update the timestamp.

- Switch timestamp to local64_t type and pending to local_t type.

- Use __clear_bit() and __set_bit() consistently with the global variable
  unwind_mask.  (Peter Zijlstra)

- Use clear_bit() and set_bit() consistently with the task unwind_mask,
  as it can race with NMIs.

- Use "bit" that was acquired by READ_ONCE() in test_and_set_bit() in
  unwind_deferred_request() instead of reading work->bit again.


Josh Poimboeuf (8):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user: Add compat mode frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86

Steven Rostedt (6):
      unwind_user/deferred: Add unwind_user_faultable()
      unwind_user/deferred: Make unwind deferral requests NMI-safe
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
 arch/x86/include/asm/unwind_user.h       |  60 ++++++
 arch/x86/include/asm/unwind_user_types.h |  17 ++
 arch/x86/kernel/ptrace.c                 |  38 ++++
 include/asm-generic/Kbuild               |   2 +
 include/asm-generic/unwind_user.h        |   5 +
 include/asm-generic/unwind_user_types.h  |   5 +
 include/linux/entry-common.h             |   2 +
 include/linux/sched.h                    |   5 +
 include/linux/unwind_deferred.h          |  76 +++++++
 include/linux/unwind_deferred_types.h    |  20 ++
 include/linux/unwind_user.h              |  45 ++++
 include/linux/unwind_user_types.h        |  39 ++++
 kernel/Makefile                          |   1 +
 kernel/exit.c                            |   2 +
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 354 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 130 ++++++++++++
 23 files changed, 834 insertions(+), 39 deletions(-)
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

Diff between v10 and v11:


diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6e850c9d3f0c..8908b8eeb99b 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -363,7 +363,7 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
-	unwind_exit_to_user_mode();
+	unwind_reset_info();
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index bf0cc0477b2e..5cfd09a8708f 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -29,7 +29,7 @@ enum {
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
-int unwind_deferred_trace(struct unwind_stacktrace *trace);
+int unwind_user_faultable(struct unwind_stacktrace *trace);
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp);
@@ -37,7 +37,7 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 void unwind_deferred_task_exit(struct task_struct *task);
 
-static __always_inline void unwind_exit_to_user_mode(void)
+static __always_inline void unwind_reset_info(void)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	unsigned long bits;
@@ -55,7 +55,7 @@ static __always_inline void unwind_exit_to_user_mode(void)
 
 	if (likely(info->cache))
 		info->cache->nr_entries = 0;
-	info->timestamp = 0;
+	local64_set(&current->unwind_info.timestamp, 0);
 }
 
 #else /* !CONFIG_UNWIND_USER */
@@ -63,12 +63,13 @@ static __always_inline void unwind_exit_to_user_mode(void)
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
-static inline int unwind_deferred_trace(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
 static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
+
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}
-static inline void unwind_exit_to_user_mode(void) {}
+static inline void unwind_reset_info(void) {}
 
 #endif /* !CONFIG_UNWIND_USER */
 
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index f384e7f45783..4308367f1887 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <asm/local64.h>
+#include <asm/local.h>
+
 struct unwind_cache {
 	unsigned int		nr_entries;
 	unsigned long		entries[];
@@ -11,8 +14,7 @@ struct unwind_task_info {
 	struct unwind_cache	*cache;
 	struct callback_head	work;
 	unsigned long		unwind_mask;
-	u64			timestamp;
-	u64			nmi_timestamp;
+	local64_t		timestamp;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index c70da8f7e54c..46f995cda606 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -14,10 +14,22 @@
  #define in_compat_mode(regs) false
 #endif
 
+/*
+ * If an architecture needs to initialize the state for a specific
+ * reason, for example, it may need to do something different
+ * in compat mode, it can define arch_unwind_user_init to a
+ * function that will perform this initialization.
+ */
 #ifndef arch_unwind_user_init
 static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
 #endif
 
+/*
+ * If an architecture requires some more updates to the state between
+ * stack frames, it can define arch_unwind_user_next to a function
+ * that will update the state between reading stack frames during
+ * the user space stack walk.
+ */
 #ifndef arch_unwind_user_next
 static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
 #endif
diff --git a/kernel/unwind/Makefile b/kernel/unwind/Makefile
index 6752ac96d7e2..eae37bea54fd 100644
--- a/kernel/unwind/Makefile
+++ b/kernel/unwind/Makefile
@@ -1 +1 @@
- obj-$(CONFIG_UNWIND_USER)		+= user.o deferred.o
+ obj-$(CONFIG_UNWIND_USER)	+= user.o deferred.o
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 6c95f484568e..c783d273a2dc 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -8,10 +8,42 @@
 #include <linux/task_work.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 
-#define UNWIND_MAX_ENTRIES 512
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a 64bit safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#if defined(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && \
+	!defined(CONFIG_GENERIC_ATOMIC64)
+# define CAN_USE_IN_NMI		1
+static inline u64 assign_timestamp(struct unwind_task_info *info,
+				   u64 timestamp)
+{
+	u64 old = 0;
+	if (!local64_try_cmpxchg(&info->timestamp, &old, timestamp))
+		timestamp = old;
+	return timestamp;
+}
+#else
+# define CAN_USE_IN_NMI		0
+static inline u64 assign_timestamp(struct unwind_task_info *info,
+				   u64 timestamp)
+{
+	/* For archs that do not allow NMI here */
+	local64_set(&info->timestamp, timestamp);
+	return timestamp;
+}
+#endif
+
+/* Make the cache fit in a 4K page */
+#define UNWIND_MAX_ENTRIES					\
+	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
@@ -27,9 +59,16 @@ static inline bool unwind_pending(struct unwind_task_info *info)
 /*
  * Read the task context timestamp, if this is the first caller then
  * it will set the timestamp.
+ *
+ * For this to work properly, the timestamp (local_clock()) must
+ * have a resolution that will guarantee a different timestamp
+ * everytime a task makes a system call. That is, two short
+ * system calls back to back must have a different timestamp.
  */
 static u64 get_timestamp(struct unwind_task_info *info)
 {
+	u64 timestamp;
+
 	lockdep_assert_irqs_disabled();
 
 	/*
@@ -38,27 +77,15 @@ static u64 get_timestamp(struct unwind_task_info *info)
 	 * this request and it means that this request will be
 	 * valid for the stracktrace.
 	 */
-	if (!info->timestamp) {
-		WRITE_ONCE(info->timestamp, local_clock());
-		barrier();
-		/*
-		 * If an NMI came in and set a timestamp, it means that
-		 * it happened before this timestamp was set (otherwise
-		 * the NMI would have used this one). Use the NMI timestamp
-		 * instead.
-		 */
-		if (unlikely(info->nmi_timestamp)) {
-			WRITE_ONCE(info->timestamp, info->nmi_timestamp);
-			barrier();
-			WRITE_ONCE(info->nmi_timestamp, 0);
-		}
-	}
+	timestamp = local64_read(&info->timestamp);
+	if (timestamp)
+		return timestamp;
 
-	return info->timestamp;
+	return assign_timestamp(info, local_clock());
 }
 
 /**
- * unwind_deferred_trace - Produce a user stacktrace in faultable context
+ * unwind_user_faultable - Produce a user stacktrace in faultable context
  * @trace: The descriptor that will store the user stacktrace
  *
  * This must be called in a known faultable context (usually when entering
@@ -69,7 +96,7 @@ static u64 get_timestamp(struct unwind_task_info *info)
  * Return: 0 on success and negative on error
  *         On success @trace will contain the user space stacktrace
  */
-int unwind_deferred_trace(struct unwind_stacktrace *trace)
+int unwind_user_faultable(struct unwind_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	struct unwind_cache *cache;
@@ -131,21 +158,14 @@ static void process_unwind_deferred(struct task_struct *task)
 	trace.nr = 0;
 	trace.entries = NULL;
 
-	unwind_deferred_trace(&trace);
-
-	/* Check if the timestamp was only set by NMI */
-	if (info->nmi_timestamp) {
-		WRITE_ONCE(info->timestamp, info->nmi_timestamp);
-		barrier();
-		WRITE_ONCE(info->nmi_timestamp, 0);
-	}
+	unwind_user_faultable(&trace);
 
-	timestamp = info->timestamp;
+	timestamp = local64_read(&info->timestamp);
 
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (bits & BIT(work->bit))
+		if (test_bit(work->bit, &bits))
 			work->func(work, &trace, timestamp);
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
@@ -168,62 +188,6 @@ void unwind_deferred_task_exit(struct task_struct *task)
 	task_work_cancel(task, &info->work);
 }
 
-static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
-{
-	struct unwind_task_info *info = &current->unwind_info;
-	bool inited_timestamp = false;
-	int ret;
-
-	/* Always use the nmi_timestamp first */
-	*timestamp = info->nmi_timestamp ? : info->timestamp;
-
-	if (!*timestamp) {
-		/*
-		 * This is the first unwind request since the most recent entry
-		 * from user space. Initialize the task timestamp.
-		 *
-		 * Don't write to info->timestamp directly, otherwise it may race
-		 * with an interruption of get_timestamp().
-		 */
-		info->nmi_timestamp = local_clock();
-		*timestamp = info->nmi_timestamp;
-		inited_timestamp = true;
-	}
-
-	/* Is this already queued */
-	if (info->unwind_mask & BIT(work->bit)) {
-		return unwind_pending(info) ? UNWIND_ALREADY_PENDING :
-			UNWIND_ALREADY_EXECUTED;
-	}
-
-	if (unwind_pending(info))
-		goto out;
-
-	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
-	if (ret < 0) {
-		/*
-		 * If this set nmi_timestamp and is not using it,
-		 * there's no guarantee that it will be used.
-		 * Set it back to zero.
-		 */
-		if (inited_timestamp)
-			info->nmi_timestamp = 0;
-		return ret;
-	}
-
-	/*
-	 * This is the first to set the PENDING_BIT, clear all others
-	 * as any other bit has already had their callback called, and
-	 * those callbacks should not be called again because of this
-	 * new callback. If they request another callback, then they
-	 * will get a new one.
-	 */
-	info->unwind_mask = UNWIND_PENDING;
-out:
-	return test_and_set_bit(work->bit, &info->unwind_mask) ?
-		UNWIND_ALREADY_PENDING : 0;
-}
-
 /**
  * unwind_deferred_request - Request a user stacktrace on task exit
  * @work: Unwind descriptor requesting the trace
@@ -238,6 +202,9 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
  * Its value will also be passed to the callback function.  It can be
  * used to stitch kernel and user stack traces together in post-processing.
  *
+ * Note, the architecture must have a local_clock() implementation that
+ * guarantees a different timestamp per task systemcall.
+ *
  * It's valid to call this function multiple times for the same @work within
  * the same task entry context.  Each call will return the same timestamp
  * while the task hasn't left the kernel. If the callback is not pending because
@@ -264,8 +231,9 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
-	if (in_nmi())
-		return unwind_deferred_request_nmi(work, timestamp);
+	/* NMI requires having safe 64 bit cmpxchg operations */
+	if (!CAN_USE_IN_NMI && in_nmi())
+		return -EINVAL;
 
 	/* Do not allow cancelled works to request again */
 	bit = READ_ONCE(work->bit);
@@ -279,7 +247,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	old = READ_ONCE(info->unwind_mask);
 
 	/* Is this already queued */
-	if (old & BIT(bit)) {
+	if (test_bit(bit, &old)) {
 		/*
 		 * If pending is not set, it means this work's callback
 		 * was already called.
@@ -305,8 +273,12 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 	 * the pending bit as well as cleared the other bits. Just
 	 * jump to setting the bit for this work.
 	 */
-	if (!try_cmpxchg(&info->unwind_mask, &old, bits))
-		goto out;
+	if (CAN_USE_IN_NMI) {
+		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
+			goto out;
+	} else {
+		info->unwind_mask = bits;
+	}
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
@@ -315,9 +287,8 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 		WRITE_ONCE(info->unwind_mask, 0);
 
 	return ret;
-
  out:
-	return test_and_set_bit(work->bit, &info->unwind_mask) ?
+	return test_and_set_bit(bit, &info->unwind_mask) ?
 		UNWIND_ALREADY_PENDING : 0;
 }
 
@@ -336,7 +307,7 @@ void unwind_deferred_cancel(struct unwind_work *work)
 	/* Do not allow any more requests and prevent callbacks */
 	work->bit = -1;
 
-	clear_bit(bit, &unwind_mask);
+	__clear_bit(bit, &unwind_mask);
 
 	synchronize_srcu(&unwind_srcu);
 
@@ -358,7 +329,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);
-	unwind_mask |= BIT(work->bit);
+	__set_bit(work->bit, &unwind_mask);
 
 	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 29e1f497a26e..2bb7995c3f23 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -22,16 +22,16 @@ static inline bool fp_state(struct unwind_user_state *state)
 	       state->type == UNWIND_USER_TYPE_FP;
 }
 
-static inline bool compat_state(struct unwind_user_state *state)
+static inline bool compat_fp_state(struct unwind_user_state *state)
 {
 	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
 	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
 }
 
-#define UNWIND_GET_USER_LONG(to, from, state)				\
+#define unwind_get_user_long(to, from, state)				\
 ({									\
 	int __ret;							\
-	if (compat_state(state))					\
+	if (compat_fp_state(state))					\
 		__ret = get_user(to, (u32 __user *)(from));		\
 	else								\
 		__ret = get_user(to, (unsigned long __user *)(from));	\
@@ -46,24 +46,26 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (compat_state(state))
+	if (compat_fp_state(state))
 		frame = &compat_fp_frame;
 	else if (fp_state(state))
 		frame = &fp_frame;
 	else
-		goto the_end;
+		goto done;
 
+	/* Get the Canonical Frame Address (CFA) */
 	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
-		goto the_end;
+		goto done;
 
-	if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))
-		goto the_end;
+	/* Find the Return Address (RA) */
+	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
+		goto done;
 
-	if (frame->fp_off && UNWIND_GET_USER_LONG(fp, cfa + frame->fp_off, state))
-		goto the_end;
+	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
+		goto done;
 
 	state->ip = ra;
 	state->sp = cfa;
@@ -74,7 +76,7 @@ int unwind_user_next(struct unwind_user_state *state)
 
 	return 0;
 
-the_end:
+done:
 	state->done = true;
 	return -EINVAL;
 }

