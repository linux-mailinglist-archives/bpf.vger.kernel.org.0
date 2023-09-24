Return-Path: <bpf+bounces-10711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3EF7AC99C
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8244D1C20863
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE986FB1;
	Sun, 24 Sep 2023 13:35:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB466AD7;
	Sun, 24 Sep 2023 13:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502AC433C8;
	Sun, 24 Sep 2023 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695562553;
	bh=u2nyym0I4JWAL7/jlXor9L9b2/H9LF78NMAR4qOqvVs=;
	h=From:To:Cc:Subject:Date:From;
	b=WR3HudULejpxM7z1JGSFl2PFi/T4sz/uaJ3mp7dyyCDv+716gCf3gvLnXAYobf9Kr
	 Zi99jrdnUzKSL7JBk4theF3qQVfGIzcLir6jc7so7OA3TunfJ4pI5HM9GblWuyTiKD
	 IVOsKBE0aeRAcxxOULBBaqNdsPRueJoknqlwqsuMmUxd8sFYZ69DVPx26DeOlhabaU
	 FUvT3NjU8tPzzxnvCDRzXnGVkjYwWwF0yOum0ZMLPUNJ5YGmNvhj2nOHczPlKlue4E
	 fivnWFI3uVqZfCjMYnAD0nP7t3MX7LLui+0f01msEF1AcM9rakOYoAtAXFlpEMTDZc
	 OTQtuDQ+4yLnQ==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v5 00/12] tracing: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date: Sun, 24 Sep 2023 22:35:47 +0900
Message-Id: <169556254640.146934.5654329452696494756.stgit@devnote2>
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

Here is the 5th version of the series to use ftrace_regs instead of pt_regs
in fprobe.
The previous version is here;

https://lore.kernel.org/all/169280372795.282662.9784422934484459769.stgit@devnote2/

In this version, I decided to use perf's own per-cpu pt_regs array to
copy the required registers[8/12]. Thus this version adds a patch which
adds a new ftrace_fill_perf_regs() API. So the ftrace_partial_regs() will
be used for BPF and ftrace_fill_perf_regs() is used for perf events.

This also adds a fix for RISCV ftrace[1/12]. When kernel is built with
disabling CONFIG_DYNAMIC_FTRACE_WITH_REGS on RISCV, it stores partial
registers on the stack, but it doesn't make it fit to struct ftrace_regs.
But since the 4th argument of ftrace_func_t is ftrace_regs *, it breaks
the ABI. So fixing it to save registers on ftrace_regs (== pt_regs on RISCV).

Another new patch [3/12] is adding a comment about the requirements for
the ftrace_regs.

 - RISCV ftrace fix to save registers on struct ftrace_regs correctly.
 - Document fix for the current fprobe callback prototype.
 - Add a comment of requirement for the ftrace_regs.
 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
 - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
 - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
   implementation)
 - Introduce ftrace_fill_perf_regs() for perf pt_regs.
 - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
   introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_regs is
   just a wrapper of pt_regs (except for arm64, other architectures do this)
 - Update fprobe-events to use ftrace_regs natively.
 - Update bpf multi-kprobe handler use ftrace_partial_regs().
 - Update document for new fprobe callbacks.
 - Add notes for the $argN and $retval.

This series can be applied against the trace-v6.6-rc2 on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs

Thank you,

---

Masami Hiramatsu (Google) (12):
      riscv: ftrace: Fix to pass correct ftrace_regs to ftrace_func_t functions
      Documentation: probes: Add a new ret_ip callback parameter
      tracing: Add a comment about the requirements of the ftrace_regs
      fprobe: Use ftrace_regs in fprobe entry handler
      tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
      fprobe: rethook: Use ftrace_regs in fprobe exit handler and rethook
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      Documentation: probes: Update fprobe document to use ftrace_regs
      Documentation: tracing: Add a note about argument and retval access


 Documentation/trace/fprobe.rst      |   18 +++--
 Documentation/trace/fprobetrace.rst |    8 ++
 Documentation/trace/kprobetrace.rst |    8 ++
 arch/Kconfig                        |    1 
 arch/arm64/include/asm/ftrace.h     |   18 +++++
 arch/loongarch/Kconfig              |    1 
 arch/loongarch/kernel/rethook.c     |   10 +--
 arch/loongarch/kernel/rethook.h     |    4 +
 arch/powerpc/include/asm/ftrace.h   |    7 ++
 arch/riscv/kernel/mcount-dyn.S      |   67 ++++++++----------
 arch/riscv/kernel/probes/rethook.c  |   12 ++-
 arch/riscv/kernel/probes/rethook.h  |    6 +-
 arch/s390/Kconfig                   |    1 
 arch/s390/include/asm/ftrace.h      |    9 ++
 arch/s390/kernel/rethook.c          |   10 ++-
 arch/s390/kernel/rethook.h          |    2 -
 arch/x86/Kconfig                    |    1 
 arch/x86/include/asm/ftrace.h       |    7 ++
 arch/x86/kernel/rethook.c           |   13 ++--
 include/linux/fprobe.h              |    4 +
 include/linux/ftrace.h              |  128 +++++++++++++++++++++++++++++------
 include/linux/rethook.h             |   11 ++-
 kernel/kprobes.c                    |   10 ++-
 kernel/trace/Kconfig                |    9 ++
 kernel/trace/bpf_trace.c            |   14 ++--
 kernel/trace/fprobe.c               |   10 +--
 kernel/trace/rethook.c              |   16 ++--
 kernel/trace/trace_fprobe.c         |   70 +++++++++++--------
 kernel/trace/trace_probe_tmpl.h     |    2 -
 lib/test_fprobe.c                   |   10 +--
 samples/fprobe/fprobe_example.c     |    4 +
 31 files changed, 327 insertions(+), 164 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

