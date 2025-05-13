Return-Path: <bpf+bounces-58145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC36AB5F77
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFAE319E73B1
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AD02116F6;
	Tue, 13 May 2025 22:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800A19DF61;
	Tue, 13 May 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175726; cv=none; b=KSdwiBt++xXTmh4R8R/0kM0crRbOf7XTpBwKfr68pG7mJjmMs/HhD6CuLcDEeG3VLTHBcR/bAIGPrHElaIRsuT4EsIS+r43cTxBLiKayeuFvCPZDn5sViC+TbrReHBGtO4KaGPH6HpcEgkMEwS3e/tf0/jN6yvVV/vQMevvjkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175726; c=relaxed/simple;
	bh=K8UsTuoitWC/iipHbtsG6xwLRP1rA/H6Xu2FVEoo/vY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BwHQfDuHZBYKSnqgYF5X+4DZgZcSYBSPt7JkZ/GWuKUjcqISyu3aYktSxNDaqn13LSLvinMm7zQB9ixHijgPtxgBae0FG88hFPfhVFdDR6Wz9Rr0YhkEL41lHo2gLE8jTLpiRN6OT/AU6bLiD8u+bNn00sB1l2TvmX6rqwnxxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66107C4CEEB;
	Tue, 13 May 2025 22:35:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uEyE3-00000004sZ7-0N2S;
	Tue, 13 May 2025 18:35:51 -0400
Message-ID: <20250513223435.636200356@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 May 2025 18:34:35 -0400
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
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This series does not make any user space visible changes.
It only adds the necessary infrastructure of the deferred unwinder.

 Based off of tip/master: d60119b82d8871c66563f8657bb3e550a80234de

This has modifications in x86 and I would like it to go through the x86
tree. Preferably it can go into this merge window so we can focus on getting
perf and ftrace to work on top of this.

Perf exposes a lot of the interface to user space as the perf tool needs
to handle the merging of the stacks, I figured it would be better to just
get the kernel side mostly done and then work out the kinks of the code
between user and kernel.

As there is no exposure to user space at this time, if something is found
wrong with it it can be fixed without worrying about breaking API.

I ran all these patches through my tests and they passed
(had to add the fix for the CONFIG_MODULE in tip/master:
 https://lore.kernel.org/all/20250513025839.495755-1-ebiggers@kernel.org/)

Changes since v8: https://lore.kernel.org/all/20250509164524.448387100@goodmis.org/

- The patches posted here have not been updated since v8.

- Removed updates to perf proper

  This is only to create the unwind infrastructure so that perf and
  ftrace can be worked on simultaneously without dependencies for
  each.

- Discussion about using guard for SRCU

   Andrii Nakryiko brought up using guard for SRCU around the
   list iteration, but it was decided that just using the normal
   methods were fine for this use case.


Josh Poimboeuf (9):
      unwind_user: Add user space unwinding API
      unwind_user: Add frame pointer support
      unwind_user/x86: Enable frame pointer unwinding on x86
      perf/x86: Rename and move get_segment_base() and make it global
      unwind_user: Add compat mode frame pointer support
      unwind_user/x86: Enable compat mode frame pointer unwinding on x86
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface
      unwind_user/deferred: Make unwind deferral requests NMI-safe

Steven Rostedt (4):
      unwind_user/deferred: Add unwind_deferred_trace()
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Clear unwind_mask on exit back to user space

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
 include/linux/sched.h                    |   6 +
 include/linux/unwind_deferred.h          |  72 ++++++
 include/linux/unwind_deferred_types.h    |  17 ++
 include/linux/unwind_user.h              |  15 ++
 include/linux/unwind_user_types.h        |  35 +++
 kernel/Makefile                          |   1 +
 kernel/fork.c                            |   4 +
 kernel/unwind/Makefile                   |   1 +
 kernel/unwind/deferred.c                 | 367 +++++++++++++++++++++++++++++++
 kernel/unwind/user.c                     | 130 +++++++++++
 22 files changed, 829 insertions(+), 39 deletions(-)
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

