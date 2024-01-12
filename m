Return-Path: <bpf+bounces-19444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51BB82BE6A
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3641F21F3C
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9460BBB;
	Fri, 12 Jan 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9alAlbr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F864AB0;
	Fri, 12 Jan 2024 10:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B41C433F1;
	Fri, 12 Jan 2024 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054574;
	bh=oiJYB2UuFrGS8fIQt3vASzn+Wih9LPxEKlaTTe/MYC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9alAlbrPpR2TPX3Rf1N0YUGuI8mZozN9VoTkscMHXFEY/Y3LgLoPdJ6wpbvglyji
	 CJNiL4VxTvngtiGXgvG2DwtoFq+WP1NoVOHfox5vnbnkSnT2zXc6Ji4JoCf8SjUIjs
	 +8CqVBk7K6GAxre9giB5k5mdHJoXF85nJ2l+6YPrXc3sWSOIinnWS7gkvyNH8nL+5O
	 pjbUk5GROADwXdu/hWlXnhplgRC9iB57RF9GG7mbltwqQCsYdj8DOAAfKuamluFLWC
	 j6L+Wc3LtqYvFLWK1XCUPaxdxP02ibrd53Ieh6hR8HVk3dlUMalK3AqzFMSZ+1vcxC
	 322emnmUo/EPg==
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
Subject: [PATCH v6 27/36] fprobe: Use ftrace_regs in fprobe exit handler
Date: Fri, 12 Jan 2024 19:16:08 +0900
Message-Id: <170505456827.459169.5071371071652498082.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170505424954.459169.10630626365737237288.stgit@devnote2>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
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
 include/linux/ftrace.h          |    5 +++++
 kernel/trace/Kconfig            |    8 ++++++++
 kernel/trace/bpf_trace.c        |    6 +++++-
 kernel/trace/fprobe.c           |    3 ++-
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    6 +++---
 samples/fprobe/fprobe_example.c |    2 +-
 11 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ee123820a476..b0bd252aefe8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,6 +108,7 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d5d8f99d1f25..5736c1970f49 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -168,6 +168,7 @@ config S390
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 375ad280ee75..1a8b5d447e85 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
+	select HAVE_PT_REGS_TO_FTRACE_REGS_CAST	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 36c0595f7b93..879a30956009 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -38,7 +38,7 @@ struct fprobe {
 			     unsigned long ret_ip, struct ftrace_regs *regs,
 			     void *entry_data);
 	void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data);
 };
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index da2a23f5a9ed..a72a2eaec576 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -159,6 +159,11 @@ struct ftrace_regs {
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
+#ifdef CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST
+
+static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs));
+
+#endif /* CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 805d72ab77c6..1a2544712690 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -60,6 +60,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
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
@@ -291,6 +298,7 @@ config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
 	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
+	depends on HAVE_PT_REGS_TO_FTRACE_REGS_CAST || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_RETHOOK
 	select RETHOOK
 	default n
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d3f8745d8ead..efb792f8f2ea 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2749,10 +2749,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 
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
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index a932c3a79e8f..31210423efc3 100644
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
index ef6b36fd05ae..3982626c82e6 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -341,10 +341,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
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
 		fexit_trace_func(tf, entry_ip, ret_ip, regs);
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
index 1545a1aac616..d476d1f07538 100644
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


