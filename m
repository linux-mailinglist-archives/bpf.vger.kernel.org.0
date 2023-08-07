Return-Path: <bpf+bounces-7131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2ED771AAF
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366502811E2
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE71FD3;
	Mon,  7 Aug 2023 06:48:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE517E8
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 06:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0513C433C7;
	Mon,  7 Aug 2023 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691390910;
	bh=dbLyRNDw66rtMco9Z3macc8TBfHCjdg7YPc5a5Rum2s=;
	h=From:To:Cc:Subject:Date:From;
	b=ESMIgjjLZ6TVNFPZDm+7nkFhf40Hl1mivSWSwCUSdT5ajD52CJDQYYbPKvKYVONZb
	 p2tJb3bHYV0AEgIaG5AKhm2gIfRUM4o0GPZYLyC11VjWhjCzgZghvZbQxZPRXnUJxl
	 A8IqYz6BHjoQdO7U0R8ICJVFUEvJiSJiCim5fjGqXVR9boCHx2GjOdXxqmgthNpPel
	 NU40+dugZoH9tZs6Ll74Qow1RFULjnX1LhOGO4r2RnFqMnoHUyURwkrRkmDWmTjlFX
	 KS12lgGVH39v4Vfn5kvTVJswUByK3Jt3jK8cqkP/pIA5eDqxb4ATN39/nr3WHQeMZO
	 dGS2CqPUGz/ag==
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
Subject: [RFC PATCH v2 0/6] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date: Mon,  7 Aug 2023 15:48:24 +0900
Message-Id: <169139090386.324433.6412259486776991296.stgit@devnote2>
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

Here is the 2nd version of RFC series to use ftrace_regs instead of pt_regs.
But this includes the generic part and minimum modifications of arch
dependent code. (e.g. not including rethook for arm64.) This series is based
on the discussion at

https://lore.kernel.org/all/20230801112036.0d4ee60d@gandalf.local.home/

This version includes 1 patch to expose ftrace_regs. so

 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
 - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=n.
 - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. This
   introduce a new HAVE_PT_REGS_COMPAT_FTRACE_REGS which means ftrace_regs is
   just a wrapper of pt_regs (except for arm64, other architectures do this)
 - Update fprobe-events to use ftrace_regs natively.
 - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a custom
   implementation)
 - Update bpf multi-kprobe handler use ftrace_partial_regs().

Florent, feel free to add your rethook for arm64, but please do not remove
kretprobe trampoline yet. It is another discussion point. We may be possible
to use ftrace_regs for kretprobe by ftrace_partial_regs() but kretprobe
allows nest probe. (maybe we can skip that case?)

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-ftrace-regs

Thank you,

---

Masami Hiramatsu (Google) (6):
      fprobe: Use fprobe_regs in fprobe entry handler
      tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
      fprobe: rethook: Use fprobe_regs in fprobe exit handler and rethook
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      ftrace: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled


 arch/Kconfig                    |    1 +
 arch/arm64/include/asm/ftrace.h |   11 ++++++
 arch/loongarch/Kconfig          |    1 +
 arch/s390/Kconfig               |    1 +
 arch/x86/Kconfig                |    1 +
 arch/x86/kernel/rethook.c       |    9 +++--
 include/linux/fprobe.h          |    4 +-
 include/linux/ftrace.h          |   56 ++++++++++++++++++-----------
 include/linux/rethook.h         |   11 +++---
 kernel/kprobes.c                |    9 ++++-
 kernel/trace/Kconfig            |    9 ++++-
 kernel/trace/bpf_trace.c        |   14 +++++--
 kernel/trace/fprobe.c           |    8 ++--
 kernel/trace/rethook.c          |   16 ++++----
 kernel/trace/trace_fprobe.c     |   76 ++++++++++++++++++++++++---------------
 kernel/trace/trace_probe_tmpl.h |    2 +
 lib/test_fprobe.c               |   10 +++--
 samples/fprobe/fprobe_example.c |    4 +-
 18 files changed, 154 insertions(+), 89 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

