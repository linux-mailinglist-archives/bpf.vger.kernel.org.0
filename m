Return-Path: <bpf+bounces-26796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9C8A5095
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC782885A5
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA432824A0;
	Mon, 15 Apr 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4O11m3W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D382497;
	Mon, 15 Apr 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185628; cv=none; b=Nwj4uZ8pp4mDngGisIoLN8b96CUf1UX0fZuIZxmeDpvlKVrQI+GoDFfnMTppEtCc8Sf8maCmoTfnx48cpfb/SZBexwnTn/XqUla2WZaqz+UT8BV+Gf9WvT3JHUA2mXbN+UgNeMk2988yHAvNed5he77hsj+e06536f9fLSy37vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185628; c=relaxed/simple;
	bh=R1jDsE9IaTklw2EYHTbFqPPAURhfMkjfBsuVPifKYvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBb6M4qXxBQF8ukGf5lu7gr/iuqmAbubjKxjc0e5X6sfKQd6jlPipnBlssBUqWPt9Xnc1F+VuGSbIp/LttSFDEh5ZxtliB5gTDtdLpoh4oCc+IhCCcvTympgiAReEiiUVT8GVWQnhUiA5T6xQBueLQx6albKJ6eeipcn7P/lM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4O11m3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FF0C2BD10;
	Mon, 15 Apr 2024 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185628;
	bh=R1jDsE9IaTklw2EYHTbFqPPAURhfMkjfBsuVPifKYvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4O11m3W6obKuU122ov3uOlolxoeEvoBq3f+X9e9eXJ2dZG3hFqgYBttjGyufBlJv
	 K2JB+S4KQ+JRibXcon72D7oo9iUrjnnjTu3TfFoS+A9VccQE83SRDPCy4zAA4sEaCo
	 vxDknMtBqXh1MSHcUyM+eaNYSY5PR88ssfGoYPj5azGGcvz6pNWF/U4z1LT8jIStRP
	 0eulknRG2JC4g5hxF/wbEpR8xuQUvNKZFziUixqshaXKjH6rGcVhNyjP59664/LuN5
	 gDDVRQdFUG4MAw8c1836++NFqflrFKQfFiZd1cDl8hJk096cNHkhKcSfZJxYXpeBxU
	 Dnoyya7pmgpNQ==
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
Subject: [PATCH v9 24/36] fprobe: Use ftrace_regs in fprobe entry handler
Date: Mon, 15 Apr 2024 21:53:41 +0900
Message-Id: <171318562175.254850.10050466683893341052.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v6:
  - Keep using SAVE_REGS flag to avoid breaking bpf kprobe-multi test.
---
 include/linux/fprobe.h          |    2 +-
 kernel/trace/Kconfig            |    3 ++-
 kernel/trace/bpf_trace.c        |   10 +++++++---
 kernel/trace/fprobe.c           |    3 ++-
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    4 ++--
 samples/fprobe/fprobe_example.c |    2 +-
 7 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index f39869588117..ca64ee5e45d2 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -10,7 +10,7 @@
 struct fprobe;
 
 typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
 
 typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index cb9c48a4f5bc..0aba53b7b0be 100644
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
index 9dc605f08a23..7837cf4e39d9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2577,7 +2577,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#ifdef CONFIG_FPROBE
+#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2822,10 +2822,14 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
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
@@ -3099,7 +3103,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE */
+#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9ff018245840..3d3789283873 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -46,7 +46,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	}
 
 	if (fp->entry_handler)
-		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
+		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
 
 	/* If entry_handler returns !0, nmissed is not counted. */
 	if (rh) {
@@ -182,6 +182,7 @@ static void fprobe_init(struct fprobe *fp)
 		fp->ops.func = fprobe_kprobe_handler;
 	else
 		fp->ops.func = fprobe_handler;
+
 	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
 }
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 62e6a8f4aae9..b2c20d4fdfd7 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -338,12 +338,16 @@ NOKPROBE_SYMBOL(fexit_perf_func);
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


