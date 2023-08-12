Return-Path: <bpf+bounces-7635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F569779D41
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 07:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553182819FF
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A721861;
	Sat, 12 Aug 2023 05:36:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007B1CCAF
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 05:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4AEC433C8;
	Sat, 12 Aug 2023 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691818602;
	bh=Hjg+oD7Py8e2iRbW+X9hkt0S7jTShCbs6h0nFpkBIkY=;
	h=From:To:Cc:Subject:Date:From;
	b=Zkd6pBoWDJS51IzDbWWsVc2PAqFRu8XHd8GLfN0mcM4dz9KPovP8KY/bIKFxux5SB
	 VuhX6Pc9kNx2n+v4UzCCA3KD5aQPej5CTIRWwtu9M7rj4Z5Tajxi1+ri3jUhKdrCnp
	 xEr+GxVJC+xyuWZxlv8DtkQitgMRZ03/c/AFpzhtCBTnR9+On2UkQn1phHMuNObsCv
	 +lVRYCwW5hv0nCWtkA5VEV4w0nJQ318CV2CgZ8Efqg+vFudZbA3jxk7KwA1c0xELys
	 6mt3y+WcfvwerxeG16B6vKpumS52gb1zxWpCuY33xNgdd+PWnjRrz7cARGy11ZleHJ
	 ZSNZ8OT3Wq4Wg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 0/8] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date: Sat, 12 Aug 2023 14:36:35 +0900
Message-Id: <169181859570.505132.10136520092011157898.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 3rd version of RFC series to use ftrace_regs instead of pt_regs.
The previous version is here;

https://lore.kernel.org/all/169139090386.324433.6412259486776991296.stgit@devnote2/

This also includes the generic part and minimum modifications of arch
dependent code. (e.g. not including rethook for arm64.) This series is based
on the discussion at

https://lore.kernel.org/all/20230801112036.0d4ee60d@gandalf.local.home/

This version added some documentation updates, fix typos, fix some build errors
on arm64 and s390, rename config name to HAVE_PT_REGS_TO_FTRACE_REGS_CAST, Use
FTRACE_OPS_FL_SAVE_ARGS in fprobe, add ftrace_regs_get_kernel_stack_nth()
and add check HAVE_REGS_AND_STACK_ACCESS_API=y for ftrace_regs APIs.

 - Document fix for the current fprobe callback prototype
 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
 - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
 - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
   introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_regs is
   just a wrapper of pt_regs (except for arm64, other architectures do this)
 - Update fprobe-events to use ftrace_regs natively.
 - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
   implementation)
 - Update bpf multi-kprobe handler use ftrace_partial_regs().
 - Update document to new fprobe callbacks.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs

Thank you,

---

Masami Hiramatsu (Google) (8):
      Documentation: probes: Add a new ret_ip callback parameter
      fprobe: Use fprobe_regs in fprobe entry handler
      tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
      fprobe: rethook: Use ftrace_regs in fprobe exit handler and rethook
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      Documentations: probes: Update fprobe document to use ftrace_regs


 Documentation/trace/fprobe.rst  |   18 +++++---
 arch/Kconfig                    |    1 
 arch/arm64/include/asm/ftrace.h |   11 +++++
 arch/loongarch/Kconfig          |    1 
 arch/s390/Kconfig               |    1 
 arch/s390/include/asm/ftrace.h  |    4 ++
 arch/x86/Kconfig                |    1 
 arch/x86/kernel/rethook.c       |   13 +++---
 include/linux/fprobe.h          |    4 +-
 include/linux/ftrace.h          |   83 +++++++++++++++++++++++++++++----------
 include/linux/rethook.h         |   11 +++--
 kernel/kprobes.c                |   10 ++++-
 kernel/trace/Kconfig            |    9 ++++
 kernel/trace/bpf_trace.c        |   14 ++++---
 kernel/trace/fprobe.c           |   10 ++---
 kernel/trace/rethook.c          |   16 ++++----
 kernel/trace/trace_fprobe.c     |   69 +++++++++++++++++++-------------
 kernel/trace/trace_probe_tmpl.h |    2 -
 lib/test_fprobe.c               |   10 ++---
 samples/fprobe/fprobe_example.c |    4 +-
 20 files changed, 191 insertions(+), 101 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

