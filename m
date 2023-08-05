Return-Path: <bpf+bounces-7080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7CD771042
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCBC1C20A7D
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF02C159;
	Sat,  5 Aug 2023 14:57:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FC1FA0
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93288C433C7;
	Sat,  5 Aug 2023 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691247474;
	bh=QPz0WJ8gkkpNP4jYse4D55wibDJnHIsbjKLA3YfAOig=;
	h=From:To:Cc:Subject:Date:From;
	b=oVI0qUR9BhKMYGTuSivMfL/WkxXNliEtSuekiFj0+r6GdIy6inD/B/lEFwhoDWJLw
	 6NHswGCCWYJRRCRIKm/3V213UZvtN+/62LlAMeekPcEpTNPPXVwnzpbxGn1EvlmbVr
	 qzUKMr8Q41QZ++e3Q9olfJBjCmlrAeFmVbixVoGQWS8X5ZmvPbEwmug71RxtzbHUb0
	 fP5mAfhUfLVlAdeW+3bhyRgETpnvsEM9Voa1i2Twxn3zwLJ3Vqt60MYi3lnW7nigOI
	 cy3uplaerAzu9B4KuASbLCZCdAqmG3lVs/ahOASyYQcbSJ/cvqzjeNuiETmQgM9h9G
	 rgB8P3XqXR60g==
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
Subject: [RFC PATCH 0/5] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
Date: Sat,  5 Aug 2023 23:57:47 +0900
Message-Id: <169124746774.186149.2326708176801468806.stgit@devnote2>
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

Here is RFC series to use ftrace_regs instead of pt_regs. But this includes
the generic part and minimum modifications of arch dependent code. (e.g. not
including rethook for arm64.) This series is based on the discussion at

https://lore.kernel.org/all/20230801112036.0d4ee60d@gandalf.local.home/

This has 5 patches,

 - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
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

Thank you,

---

Masami Hiramatsu (Google) (5):
      fprobe: Use fprobe_regs in fprobe entry handler
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
 include/linux/ftrace.h          |   11 ++++++
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
 18 files changed, 130 insertions(+), 68 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

