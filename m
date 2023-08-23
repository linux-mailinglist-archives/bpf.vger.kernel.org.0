Return-Path: <bpf+bounces-8381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C23785BBC
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792131C20C62
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B77C2E6;
	Wed, 23 Aug 2023 15:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1CAD42
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 15:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8675CC433C8;
	Wed, 23 Aug 2023 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692803801;
	bh=NSihKHbTD4Jn9DldCU6pu28QTieR1+AN7Z/GsZZggpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J27RbJJkXKeecA2nGKIjPkL2Ggsmo/Q0ci1RFtlGoi1twA6JhjWgO3/Eot4V/vULe
	 oysmPNgWYYzHFjVDy5fTTc1GgE+wwExYeHdjlQbkmAoySWc8cXeFwzC6RbIfRcA922
	 0l1WUSu2hTywu7/vyASLrVhSM2JHojNa4/OGijx3DccLvcAasdR2GVgYkLzesTVCTe
	 8cpuq8+0eL6hn+Uz8W0pIb3TRrzOs7QG8PfQPt3VXiTCRwS/RbI8rYI+7W4u4HIDXI
	 RXoIlbbPhl54/7yRCnP5lyQdzv4SBGBNP2Lxx8jcbfC0CzuDOlJdjh6013CNp3KbDK
	 cxbEjp31yTvQw==
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
Subject: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Thu, 24 Aug 2023 00:16:37 +0900
Message-Id: <169280379741.282662.12221517584561036597.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169280372795.282662.9784422934484459769.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
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

Allow fprobe events to be enabled with CONFIG_DYNAMIC_FTRACE_WITH_ARGS.
With this change, fprobe events mostly use ftrace_regs instead of pt_regs.
Note that if the arch doesn't enable HAVE_PT_REGS_COMPAT_FTRACE_REGS,
fprobe events will not be able to be used from perf.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
   - introduce ftrace_regs_get_kernel_stack_nth().
   - fix typo.
 Changes in v4:
   - Use per-cpu pt_regs stack and ftrace_partial_regs() for perf event.
---
 include/linux/ftrace.h          |   15 ++++
 kernel/trace/Kconfig            |    1 
 kernel/trace/trace_fprobe.c     |  135 ++++++++++++++++++++++++++++-----------
 kernel/trace/trace_probe_tmpl.h |    2 -
 4 files changed, 112 insertions(+), 41 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a6ed2aa71efc..fb0f87d19d35 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -194,6 +194,21 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	return ftrace_get_regs(fregs) != NULL;
 }
 
+#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
+static __always_inline unsigned long
+ftrace_regs_get_kernel_stack_nth(struct ftrace_regs *fregs, unsigned int nth)
+{
+	unsigned long *stackp;
+
+	stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
+	if (((unsigned long)(stackp + nth) & ~(THREAD_SIZE - 1)) ==
+	    ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
+		return *(stackp + nth);
+
+	return 0;
+}
+#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d56304276318..6fb4ecf8767d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -679,7 +679,6 @@ config FPROBE_EVENTS
 	select TRACING
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
-	depends on DYNAMIC_FTRACE_WITH_REGS
 	default y
 	help
 	  This allows user to add tracing events on the function entry and
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index c60d0d9f1a95..90ad28260a9f 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -132,7 +132,7 @@ static int
 process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
-	struct pt_regs *regs = rec;
+	struct ftrace_regs *fregs = rec;
 	unsigned long val;
 	int ret;
 
@@ -140,17 +140,17 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 	/* 1st stage: get value from context */
 	switch (code->op) {
 	case FETCH_OP_STACK:
-		val = regs_get_kernel_stack_nth(regs, code->param);
+		val = ftrace_regs_get_kernel_stack_nth(fregs, code->param);
 		break;
 	case FETCH_OP_STACKP:
-		val = kernel_stack_pointer(regs);
+		val = ftrace_regs_get_stack_pointer(fregs);
 		break;
 	case FETCH_OP_RETVAL:
-		val = regs_return_value(regs);
+		val = ftrace_regs_return_value(fregs);
 		break;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	case FETCH_OP_ARG:
-		val = regs_get_kernel_argument(regs, code->param);
+		val = ftrace_regs_get_argument(fregs, code->param);
 		break;
 #endif
 	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
@@ -170,7 +170,7 @@ NOKPROBE_SYMBOL(process_fetch_insn)
 /* function entry handler */
 static nokprobe_inline void
 __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		    struct pt_regs *regs,
+		    struct ftrace_regs *fregs,
 		    struct trace_event_file *trace_file)
 {
 	struct fentry_trace_entry_head *entry;
@@ -184,36 +184,36 @@ __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
 	if (!entry)
 		return;
 
-	fbuffer.regs = regs;
+	fbuffer.regs = ftrace_get_regs(fregs);
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = entry_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
 fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		  struct pt_regs *regs)
+		  struct ftrace_regs *fregs)
 {
 	struct event_file_link *link;
 
 	trace_probe_for_each_link_rcu(link, &tf->tp)
-		__fentry_trace_func(tf, entry_ip, regs, link->file);
+		__fentry_trace_func(tf, entry_ip, fregs, link->file);
 }
 NOKPROBE_SYMBOL(fentry_trace_func);
 
 /* Kretprobe handler */
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		   unsigned long ret_ip, struct pt_regs *regs,
+		   unsigned long ret_ip, struct ftrace_regs *fregs,
 		   struct trace_event_file *trace_file)
 {
 	struct fexit_trace_entry_head *entry;
@@ -227,94 +227,157 @@ __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
 	if (!entry)
 		return;
 
-	fbuffer.regs = regs;
+	fbuffer.regs = ftrace_get_regs(fregs);
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
 fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		 unsigned long ret_ip, struct pt_regs *regs)
+		 unsigned long ret_ip, struct ftrace_regs *fregs)
 {
 	struct event_file_link *link;
 
 	trace_probe_for_each_link_rcu(link, &tf->tp)
-		__fexit_trace_func(tf, entry_ip, ret_ip, regs, link->file);
+		__fexit_trace_func(tf, entry_ip, ret_ip, fregs, link->file);
 }
 NOKPROBE_SYMBOL(fexit_trace_func);
 
 #ifdef CONFIG_PERF_EVENTS
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
+
+static __always_inline
+struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
+{
+	/* See include/linux/ftrace.h, this returns &fregs->regs */
+	return ftrace_partial_regs(fregs, NULL);
+}
+
+#define perf_fprobe_return_regs(regs) do {} while (0)
+
+#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
+/* Since fprobe handlers can be nested, pt_regs buffer need to be a stack */
+#define PERF_FPROBE_REGS_MAX	4
+
+struct pt_regs_stack {
+	struct pt_regs regs[PERF_FPROBE_REGS_MAX];
+	int idx;
+};
+
+static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
+
+static __always_inline
+struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
+{
+	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
+	struct pt_regs *regs;
+
+	if (stack->idx < PERF_FPROBE_REGS_MAX) {
+		regs = stack->regs[stack->idx++];
+		return ftrace_partial_regs(fregs, regs);
+	}
+	return NULL;
+}
+
+static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs)
+{
+	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
+
+	if (WARN_ON_ONCE(regs != stack->regs[stack->idx]))
+		return;
+
+	--stack->idx;
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
 static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-			    struct pt_regs *regs)
+			    struct ftrace_regs *fregs)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fentry_trace_entry_head *entry;
 	struct hlist_head *head;
 	int size, __size, dsize;
+	struct pt_regs *regs;
 	int rctx;
 
+	regs = perf_fprobe_partial_regs(fregs);
+	if (!regs)
+		return -EINVAL;
+
 	head = this_cpu_ptr(call->perf_events);
 	if (hlist_empty(head))
-		return 0;
+		goto out;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
-		return 0;
+		goto out;
 
 	entry->ip = entry_ip;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
+out:
+	perf_fprobe_return_regs(regs);
 	return 0;
 }
 NOKPROBE_SYMBOL(fentry_perf_func);
 
 static void
 fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		unsigned long ret_ip, struct pt_regs *regs)
+		unsigned long ret_ip, struct ftrace_regs *fregs)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fexit_trace_entry_head *entry;
 	struct hlist_head *head;
 	int size, __size, dsize;
+	struct pt_regs *regs;
 	int rctx;
 
+	regs = perf_fprobe_partial_regs(fregs);
+	if (!regs)
+		return;
+
 	head = this_cpu_ptr(call->perf_events);
 	if (hlist_empty(head))
-		return;
+		goto out;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
 	entry = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!entry)
-		return;
+		goto out;
 
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
+out:
+	perf_fprobe_return_regs(regs);
 }
 NOKPROBE_SYMBOL(fexit_perf_func);
 #endif	/* CONFIG_PERF_EVENTS */
@@ -324,17 +387,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
-	struct pt_regs *regs = ftrace_get_regs(fregs);
 	int ret = 0;
 
-	if (!regs)
-		return 0;
-
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fentry_trace_func(tf, entry_ip, regs);
+		fentry_trace_func(tf, entry_ip, fregs);
+
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		ret = fentry_perf_func(tf, entry_ip, regs);
+		ret = fentry_perf_func(tf, entry_ip, fregs);
 #endif
 	return ret;
 }
@@ -345,16 +405,13 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return;
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fexit_trace_func(tf, entry_ip, ret_ip, regs);
+		fexit_trace_func(tf, entry_ip, ret_ip, fregs);
+
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		fexit_perf_func(tf, entry_ip, ret_ip, regs);
+		fexit_perf_func(tf, entry_ip, ret_ip, fregs);
 #endif
 }
 NOKPROBE_SYMBOL(fexit_dispatcher);
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 3935b347f874..05445a745a07 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -232,7 +232,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 /* Sum up total data length for dynamic arrays (strings) */
 static nokprobe_inline int
-__get_data_size(struct trace_probe *tp, struct pt_regs *regs)
+__get_data_size(struct trace_probe *tp, void *regs)
 {
 	struct probe_arg *arg;
 	int i, len, ret = 0;


