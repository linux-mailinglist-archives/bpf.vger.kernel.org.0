Return-Path: <bpf+bounces-7083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5A771048
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A28281C55
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B04C159;
	Sat,  5 Aug 2023 14:58:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1553BA4B
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 14:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28A4C433C8;
	Sat,  5 Aug 2023 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691247510;
	bh=fjaYPjmq2BoIv7RB2HzPUoTjb8xMQJDDRRopt22BLAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YS5ehamyR5LmjE824aRhjllQA0SnAYFtS4LqRRj8q0OA/ALWaUjW0x6Nc9wsodgPm
	 FifP/X8tVxSypyuJpHDqyC84csbCqKE+OVM6HkV2DMkTCpg/HbyIzDmtsGObutO9y5
	 yk086RR9YHZ/2qC3zaesxcpAFj1HlAQ0X3/tkdUVFIYzHu84sEVq3ZaYTmGLKmIgh5
	 xcDgxU4Bb8m214nPLEyotAEL05WDf5UsHyUONYnQ8zST9kSZVxFW3hKXfY+wXOoxkn
	 fv2mVnXdudKKqti4Lusonz0qpPgVfIK65qGYo8ZSLD/nd2LQH6WNDdauZKsOejyxZb
	 ENfX4vt67ytbQ==
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
Subject: [RFC PATCH 3/5] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Sat,  5 Aug 2023 23:58:24 +0900
Message-Id: <169124750396.186149.18312551315786049736.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169124746774.186149.2326708176801468806.stgit@devnote2>
References: <169124746774.186149.2326708176801468806.stgit@devnote2>
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
fprobe events will not be able to use from perf.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/Kconfig            |    1 -
 kernel/trace/trace_fprobe.c     |   72 ++++++++++++++++++++++-----------------
 kernel/trace/trace_probe_tmpl.h |    2 +
 3 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7d6abb5bd861..e9b7bd88cf9e 100644
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
index f440c97e050f..4e9c250dbd19 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -132,25 +132,30 @@ static int
 process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
-	struct pt_regs *regs = rec;
-	unsigned long val;
+	struct ftrace_regs *fregs = rec;
+	unsigned long val, *stackp;
 	int ret;
 
 retry:
 	/* 1st stage: get value from context */
 	switch (code->op) {
 	case FETCH_OP_STACK:
-		val = regs_get_kernel_stack_nth(regs, code->param);
+		stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
+		if (((unsigned long)(stackp + code->param) & ~(THREAD_SIZE - 1)) ==
+		    ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
+			val = *(stackp + code->param);
+		else
+			val = 0;
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
@@ -170,7 +175,7 @@ NOKPROBE_SYMBOL(process_fetch_insn)
 /* function entry handler */
 static nokprobe_inline void
 __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		    struct pt_regs *regs,
+		    struct ftrace_regs *fregs,
 		    struct trace_event_file *trace_file)
 {
 	struct fentry_trace_entry_head *entry;
@@ -184,36 +189,36 @@ __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
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
@@ -227,37 +232,37 @@ __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
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
 
 static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-			    struct pt_regs *regs)
+			    struct ftrace_regs *fregs, struct pt_regs *regs)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fentry_trace_entry_head *entry;
@@ -269,7 +274,7 @@ static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (hlist_empty(head))
 		return 0;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -280,7 +285,7 @@ static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 
 	entry->ip = entry_ip;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -289,7 +294,8 @@ NOKPROBE_SYMBOL(fentry_perf_func);
 
 static void
 fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		unsigned long ret_ip, struct pt_regs *regs)
+		unsigned long ret_ip, struct ftrace_regs *fregs,
+		struct pt_regs *regs)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fexit_trace_entry_head *entry;
@@ -301,7 +307,7 @@ fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (hlist_empty(head))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs);
+	dsize = __get_data_size(&tf->tp, fregs);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
@@ -312,7 +318,7 @@ fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
 
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
@@ -327,14 +333,15 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 	struct pt_regs *regs = ftrace_get_regs(fregs);
 	int ret = 0;
 
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+		fentry_trace_func(tf, entry_ip, fregs);
+
+#ifdef CONFIG_PERF_EVENTS
 	if (!regs)
 		return 0;
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fentry_trace_func(tf, entry_ip, regs);
-#ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		ret = fentry_perf_func(tf, entry_ip, regs);
+		ret = fentry_perf_func(tf, entry_ip, fregs, regs);
 #endif
 	return ret;
 }
@@ -347,14 +354,15 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
 	struct pt_regs *regs = ftrace_get_regs(fregs);
 
+	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
+		fexit_trace_func(tf, entry_ip, ret_ip, fregs);
+
+#ifdef CONFIG_PERF_EVENTS
 	if (!regs)
 		return;
 
-	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fexit_trace_func(tf, entry_ip, ret_ip, regs);
-#ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		fexit_perf_func(tf, entry_ip, ret_ip, regs);
+		fexit_perf_func(tf, entry_ip, ret_ip, fregs, regs);
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


