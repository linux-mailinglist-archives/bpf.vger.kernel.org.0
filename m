Return-Path: <bpf+bounces-57872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A93AB1AE4
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FA8501890
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C8238D2B;
	Fri,  9 May 2025 16:51:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDA23314B;
	Fri,  9 May 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809498; cv=none; b=Nnm1MK9RXZmqoDreOETZa0Ljw89SvzhL1xN2smOV7Nv1Ez5ncu1ufhScIH1oNwBGA9YwC1YRKAtM8Ed15P4bD8YTGJl2rmnVY7795wd2WfZpit9wJXENEqZf3pCzV9y6lAhY0j8pQkdhftfUqt/DkP38vBHerfHCAdO26PHdMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809498; c=relaxed/simple;
	bh=VBFAXcko2HqgldnvVZH1iLDts/MHBEOLE0BtZfDoofM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=ET0WNY09YjYUdALt/efVnNOXjCWrspyBs+r/w2IRofDEcwqNJ4QhbaKOB7UkIiKRPD6YtquL7LipLVnunJLSACRBQsO+wRxyiTg5Ir40YHxJWIm2EvC07zyo6YV1eIWa2cVnx/iEMYwR2yxNdxxP2+T/rAIzFqaLKXf6sJ1CM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25922C4CEE4;
	Fri,  9 May 2025 16:51:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDQwz-00000002gDE-3AKg;
	Fri, 09 May 2025 12:51:53 -0400
Message-ID: <20250509164524.448387100@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 12:45:24 -0400
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
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v8 00/18] unwind_user: perf: x86: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

This series does not make any user space visible changes.
It only adds the necessary infrastructure of the deferred unwinder
and makes a few helpful cleanups to perf.

 Based off of tip/master: 864fb128fda9392e40bbb2055460cc648d26c51e

Peter and Ingo,

Would you be willing to take this series? I'd like to get this part
in the kernel in the next merge window and then we can focus on getting perf
and ftrace to use it in the next merge window.

Perf exposes a lot of the interface to user space as the perf tool needs
to handle the merging of the stacks, I figured it would be better to just
get the kernel side mostly done and then work out the kinks of the code
between user and kernel.

Are you OK with this?

I'd like to get this in the kernel for this merge window so that
Perf, ftrace, BPF and even LTTng can build on top of it simultaneously in
the next merge window. If something is found wrong with it, then it can
still be updated as no user space API has been exposed yet.


Changes since v7: https://lore.kernel.org/linux-trace-kernel/20250502164746.178864972@goodmis.org/

- Allocate unwind_cache as a structure and not just its entries
  (Ingo Molnar)
 
- Fixed white space issues
  (Ingo Molnar)

- Removed period from one of the commit subjects
  (Ingo Molnar)

- Use a timestamp instead of a "cookie"

  Instead of using a "cookie" the local_clock() is used on the first
  request, and that is used as the cookie was before. The caller
  can use that as a cookie like the previous patches for the task
  or record it in the user stacktrace event and if the requested
  event uses the local_clock timestamp, the timestamp can be used to
  know if the stacktrace is valid or not due to dropped events.

  If one call stack is dropped and the task goes back to user space
  and then back to the kernel and performs another call stack the
  tooling needs to know if that is not valid for the previous request.

- Added kerneldoc to unwind_deferred_trace()

- Updated comments to kerneldoc for unwind_deferred_request()

- Clear the unwind_mask on exit.

  If a tracer requests a deferred stacktrace after it has originally
  received one for the current stacktrace it will not trigger another
  stacktrace.

  The unwind request now returns:
    0 - successfully queued the callback
    UNWIND_ALREADY_PENDING - queued by someone else
    UNWIND_ALREADY_EXECUTED - not queued but was called previously
    Negative - An error occurred

  If perf or another tracer knows that triggering another stacktrace
  will not cause a infinite loop, then the code can be modified
  to allow a tracer to request another trace even if it has already
  received the current stacktrace.


Josh Poimboeuf (13):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user: Add compat mode frame pointer support
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      perf: Remove get_perf_callchain() init_nr argument
      perf: Have get_perf_callchain() return NULL if crosstask and user are set
      perf: Simplify get_perf_callchain() user logic
      perf: Skip user unwind if the task is a kernel thread

Steven Rostedt (5):
      unwind_user/deferred: Add unwind_deferred_trace()
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Clear unwind_mask on exit back to user space
      perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL

----
 MAINTAINERS                              |   8 +
 arch/Kconfig                             |  11 +
 arch/x86/Kconfig                         |   2 +
 arch/x86/events/core.c                   |  44 +---
 arch/x86/include/asm/ptrace.h            |   2 +
 arch/x86/include/asm/unwind_user.h       |  61 +++++
 arch/x86/include/asm/unwind_user_types.h |  17 ++
 arch/x86/kernel/ptrace.c                 |  38 ++++
 include/asm-generic/Kbuild               |   2 +
 include/asm-generic/unwind_user.h        |  24 ++
 include/asm-generic/unwind_user_types.h  |   9 +
 include/linux/entry-common.h             |   2 +
 include/linux/perf_event.h               |   2 +-
 include/linux/sched.h                    |   6 +
 include/linux/unwind_deferred.h          |  72 ++++++
 include/linux/unwind_deferred_types.h    |  17 ++
 include/linux/unwind_user.h              |  15 ++
 include/linux/unwind_user_types.h        |  35 +++
 kernel/Makefile                          |   1 +
 kernel/bpf/stackmap.c                    |   4 +-
 kernel/events/callchain.c                |  38 ++--
 kernel/events/core.c                     |   7 +-
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 367 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 130 +++++++++++
 26 files changed, 854 insertions(+), 65 deletions(-)
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

