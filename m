Return-Path: <bpf+bounces-7637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A305A779D45
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA801C20B30
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECE185F;
	Sat, 12 Aug 2023 05:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C651CCAF
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 05:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E98FC433C7;
	Sat, 12 Aug 2023 05:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691818625;
	bh=4qPUZlUTFHSQi/UelkxI/UnG2AeW5ahcJbFTYeUciiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq0c7qn155A+dPZs9LWUvRezDgvEEvskGy2s1eGHvyaC+UIrZMrKtrfGEtz+r9C9g
	 Qcgr5QypW/GoRWya2vyZpaRaenSD5iD8TN36lQO7urxCoLAWGH+jZB/c2Vjz3Rv9rn
	 GcI0DbwKKkwzo5IQ6YPGU4gXorXG45Ci9CEqggSjB0ubmJI8HirXSJjfR4uyV/pEa2
	 ITTnC6U0IRcKONVZAyQS/OfXQ+iqW+IhnPuMtj/yIspHqhBU2ZWFSKfq6SbAGjF6be
	 I8IMksN/A813oOqLpI/YtIrn0HJGP23rEVkH4lN0MYPgoKCPsnDX2Cj0i4oxIYIF9a
	 fs/ihMbkwST4g==
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
Subject: [PATCH v3 2/8] fprobe: Use fprobe_regs in fprobe entry handler
Date: Sat, 12 Aug 2023 14:36:59 +0900
Message-Id: <169181861911.505132.8322840504168319403.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169181859570.505132.10136520092011157898.stgit@devnote2>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
on arm64.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Use FTRACE_OPS_FL_SAVE_ARGS instead of FTRACE_OPS_FL_SAVE_REGS.
---
 include/linux/fprobe.h          |    2 +-
 kernel/trace/Kconfig            |    3 ++-
 kernel/trace/bpf_trace.c        |   10 +++++++---
 kernel/trace/fprobe.c           |    4 ++--
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    4 ++--
 samples/fprobe/fprobe_example.c |    2 +-
 7 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 3e03758151f4..36c0595f7b93 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -35,7 +35,7 @@ struct fprobe {
 	int			nr_maxactive;
 
 	int (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *regs,
 			     void *entry_data);
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
 			     unsigned long ret_ip, struct pt_regs *regs,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..976fd594b446 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -287,7 +287,7 @@ config DYNAMIC_FTRACE_WITH_ARGS
 config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_RETHOOK
 	select RETHOOK
 	default n
@@ -672,6 +672,7 @@ config FPROBE_EVENTS
 	select TRACING
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
+	depends on DYNAMIC_FTRACE_WITH_REGS
 	default y
 	help
 	  This allows user to add tracing events on the function entry and
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bd1a42b23f3f..126acbfdb26f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2467,7 +2467,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#ifdef CONFIG_FPROBE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2659,10 +2659,14 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 static int
 kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
-			  unsigned long ret_ip, struct pt_regs *regs,
+			  unsigned long ret_ip, struct ftrace_regs *fregs,
 			  void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return 0;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
@@ -2917,7 +2921,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE */
+#else /* !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3b21f4063258..07deb52df44a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -46,7 +46,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	}
 
 	if (fp->entry_handler)
-		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
+		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
 
 	/* If entry_handler returns !0, nmissed is not counted. */
 	if (rh) {
@@ -182,7 +182,7 @@ static void fprobe_init(struct fprobe *fp)
 		fp->ops.func = fprobe_kprobe_handler;
 	else
 		fp->ops.func = fprobe_handler;
-	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
+	fp->ops.flags |= FTRACE_OPS_FL_SAVE_ARGS;
 }
 
 static int fprobe_init_rethook(struct fprobe *fp, int num)
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index dfe2e546acdc..4d3ae79f036e 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -320,12 +320,16 @@ NOKPROBE_SYMBOL(fexit_perf_func);
 #endif	/* CONFIG_PERF_EVENTS */
 
 static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	int ret = 0;
 
+	if (!regs)
+		return 0;
+
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
 		fentry_trace_func(tf, entry_ip, regs);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 24de0e5ff859..ff607babba18 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -40,7 +40,7 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
 
 static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
-				    struct pt_regs *regs, void *data)
+				    struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
@@ -81,7 +81,7 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 				      unsigned long ret_ip,
-				      struct pt_regs *regs, void *data)
+				      struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	return 0;
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 64e715e7ed11..1545a1aac616 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -50,7 +50,7 @@ static void show_backtrace(void)
 
 static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 				unsigned long ret_ip,
-				struct pt_regs *regs, void *data)
+				struct ftrace_regs *fregs, void *data)
 {
 	if (use_trace)
 		/*


