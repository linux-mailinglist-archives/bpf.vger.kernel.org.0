Return-Path: <bpf+bounces-37451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A514B955C83
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C3282C0C
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF384D0D;
	Sun, 18 Aug 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8n1fStl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8A286A3;
	Sun, 18 Aug 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985361; cv=none; b=icv6X0pgLNAUui1Gx+BoJVFYtQTcJqChgRl580v82WsIvOQBUL8f/y4u88NyNcqBU7n/qe0smlatiaUuH0D3H3tUP6TJNg94i+nr5A61rXAt5MrGSuuFip1pMkz8PkbBCvJUZfuyCshrFTWUiiJY7BX/skTD0H/2wZtaCm8bcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985361; c=relaxed/simple;
	bh=HIuUHRP2bZeiOHc7iM1LDG4JhKapAaol6dDufhclus4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXxk8MsXCcI30a43f4AvgN9e9RBUTiYzui/5KS0ImB62wSqLsbKDxooTVpyuJWquSJ8UdgLJH6WzPd4rOocY/946cEBpZwfXt5llicUpud1zcNnfuo+FFjQw29ndBilvUvwNTXhsbQ5JglRU4jDWE9ydp+bQ/5ZPVwOfXrf1zus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8n1fStl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408D1C4AF0B;
	Sun, 18 Aug 2024 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985361;
	bh=HIuUHRP2bZeiOHc7iM1LDG4JhKapAaol6dDufhclus4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8n1fStluPMtVJhJiBjJc8bWpLwvAvt0dc4Lv0HwHpsIpmgos9kBMsFqeabEHjG0T
	 dhN2Ve1d/bv/GKnSGEHrhKC9RPXXOO9iG8kObS/xM5kDOM4usIfESec5rkof53rfiL
	 7UKz3P0Bnb8DwZ0/ULmQGgz2/tqfCbAPTvHQ7XfPuUDJFabXvqMsJUXBIHKR/fWzxq
	 AH9gRe2MchCcfwzI6lGslJIkL2t4UdCDVYoGAvNUrwccqvjrD8K/7UfoTWajSk6obl
	 oijj33BdilayIwh4Ps+ljwHMD3uJgLaD2WpRepWiL3SuBbzc7d0/TBh7jGbaKmmrKw
	 AQw5L09zk/iUA==
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
Subject: [PATCH v13 08/20] fprobe: Use ftrace_regs in fprobe exit handler
Date: Sun, 18 Aug 2024 21:49:16 +0900
Message-Id: <172398535633.293426.2157498788084697864.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398527264.293426.2050093948411376857.stgit@devnote2>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
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

Change the fprobe exit handler to use ftrace_regs structure instead of
pt_regs. This also introduce HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means
the ftrace_regs's memory layout is equal to the pt_regs so that those are
able to cast. Fprobe introduces a new dependency with that.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v3:
   - Use ftrace_regs_get_return_value()
  Changes from previous series: NOTHING, just forward ported.
---
 arch/loongarch/Kconfig          |    1 +
 arch/s390/Kconfig               |    1 +
 arch/x86/Kconfig                |    1 +
 include/linux/fprobe.h          |    2 +-
 include/linux/ftrace.h          |    6 ++++++
 kernel/trace/Kconfig            |    8 ++++++++
 kernel/trace/bpf_trace.c        |    6 +++++-
 kernel/trace/fprobe.c           |    3 ++-
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    6 +++---
 samples/fprobe/fprobe_example.c |    2 +-
 11 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 974f08f65f63..73cb657496c8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -122,6 +122,7 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 12e942cfbcde..eebc299f424b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -175,6 +175,7 @@ config S390
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 047384e4d93a..59788d8b220e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -218,6 +218,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index ca64ee5e45d2..ef609bcca0f9 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -14,7 +14,7 @@ typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
 			       void *entry_data);
 
 typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
 
 /**
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e7c41d9988e1..a1b2ef492c7f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -162,6 +162,12 @@ struct ftrace_regs {
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
+#ifdef CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+
+static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs));
+
+#endif /* CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	if (!fregs)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0c6a03554c13..2e2b39699542 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of ftrace_regs_get_argument() and
 	 ftrace_regs_get_stack_pointer().
 
+config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+	bool
+	help
+	 If this is set, the memory layout of the ftrace_regs data structure
+	 is the same as the pt_regs. So the pt_regs is possible to be casted
+	 to ftrace_regs.
+
 config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	bool
 	help
@@ -288,6 +295,7 @@ config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
 	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
+	depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_RETHOOK
 	select RETHOOK
 	default n
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 947808a002d0..cdba9981b048 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2874,10 +2874,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 
 static void
 kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *fregs,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true, data);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3d3789283873..90a3c8e2bbdf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -124,6 +124,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
 	int bit;
 
 	if (!fp || fprobe_disabled(fp))
@@ -141,7 +142,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 		return;
 	}
 
-	fp->exit_handler(fp, fpr->entry_ip, ret_ip, regs,
+	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
 	ftrace_test_recursion_unlock(bit);
 }
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b2c20d4fdfd7..273cdf3cf70c 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -359,10 +359,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 NOKPROBE_SYMBOL(fentry_dispatcher);
 
 static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
 		fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data);
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index ff607babba18..271ce0caeec0 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -59,9 +59,9 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
-				    struct pt_regs *regs, void *data)
+				    struct ftrace_regs *fregs, void *data)
 {
-	unsigned long ret = regs_return_value(regs);
+	unsigned long ret = ftrace_regs_get_return_value(fregs);
 
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	if (ip != target_ip) {
@@ -89,7 +89,7 @@ static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
 				      unsigned long ret_ip,
-				      struct pt_regs *regs, void *data)
+				      struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index c234afae52d6..bfe98ce826f3 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -67,7 +67,7 @@ static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 }
 
 static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
-				unsigned long ret_ip, struct pt_regs *regs,
+				unsigned long ret_ip, struct ftrace_regs *regs,
 				void *data)
 {
 	unsigned long rip = ret_ip;


