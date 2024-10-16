Return-Path: <bpf+bounces-42126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11B99FD8D
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5F280E63
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B207713BAE2;
	Wed, 16 Oct 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtwEE62W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE912628D;
	Wed, 16 Oct 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040372; cv=none; b=TboCLnzsSNXYcgQf9rg5oQlImo0mfDtjFaY997oPRB0KhsML/VrrgMCymv+zQYjpzQRaPatsCMbGqKCjguXfeFvVTCEQHgLuoPx4OFCt143X44c198/p44pSK6PEVki/Hwrp1iP4UHN6jLvFkWZVhztGLTbVSBzhkPkKHeBW7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040372; c=relaxed/simple;
	bh=XOmB0ULOHupz4kFjwpmxxMW5DZpDImZiDmErO/2b6yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0e0zxarnnRvd9mwhH+ZvDtVI4SekSXSBjbL2A+yCmngM32l9eX5SuT6pm2IlOg5om75YzlMJpWplX949srHxwDd223v9TI06z5GpKalKz469mFfeKl6arY7VE4ELCTa++Ho8OVlNDQtUhFjH/i9ZO7Sjriv99fspOqGmzuPVhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtwEE62W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B5AC4CEC6;
	Wed, 16 Oct 2024 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040371;
	bh=XOmB0ULOHupz4kFjwpmxxMW5DZpDImZiDmErO/2b6yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtwEE62Wq9uYGkepHtCR2KWeb2PGJxySsbNcb6ciL92YJOAYspqieYj5f4KAfeUXI
	 coyXI1YIF2LN8snuLsY3//bQCMNo8Qy6DbkKzyI0j9SKeUBQaTuNXyInwyPN9H0ysd
	 JBoBLL6h5RYsvQOfH7rctEMk+5OT9T4h22xkBKwQeHe5TYp+P9SMpKQuYkOsSexTvw
	 2/8APlmfVLtoXnebjQb4nKaU8EJjFbFQKskGzXvvLdRIGzv0KdbqR/Yz+bhjkIa8rR
	 YjY0e+trpRqxHMhAD2DWquSHtS/jVDmfd227FE6/rrIbhZ9OnMGVYBcuZ1QXKkRt9H
	 eSXLi4/7VBd2w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v17 08/16] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Wed, 16 Oct 2024 09:59:26 +0900
Message-ID: <172904036612.36809.2502758504249659588.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172904026427.36809.516716204730117800.stgit@devnote2>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
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
Note that if the arch doesn't enable HAVE_FTRACE_REGS_HAVING_PT_REGS,
fprobe events will not be able to be used from perf.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Copy store_trace_entry_data() as store_fprobe_entry_data() for
    fprobe.
 Chagnes in v3:
  - Use ftrace_regs_get_return_value().
 Changes in v2:
  - Define ftrace_regs_get_kernel_stack_nth() for
    !CONFIG_HAVE_REGS_AND_STACK_ACCESS_API.
 Changes from previous series: Update against the new series.
---
 include/linux/ftrace.h          |   17 ++++++
 kernel/trace/Kconfig            |    1 
 kernel/trace/trace_fprobe.c     |  107 +++++++++++++++++++++++++--------------
 kernel/trace/trace_probe_tmpl.h |    2 -
 4 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6d29c640697c..4c553fe9c026 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -250,6 +250,23 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
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
+#else /* !CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+#define ftrace_regs_get_kernel_stack_nth(fregs, nth)	(0L)
+#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
+
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7f8165f2049a..82654bbfad9a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -689,7 +689,6 @@ config FPROBE_EVENTS
 	select TRACING
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
-	depends on DYNAMIC_FTRACE_WITH_REGS
 	default y
 	help
 	  This allows user to add tracing events on the function entry and
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index b68d0aa26097..41595e38fea5 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -134,7 +134,7 @@ static int
 process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
 		   void *dest, void *base)
 {
-	struct pt_regs *regs = rec;
+	struct ftrace_regs *fregs = rec;
 	unsigned long val;
 	int ret;
 
@@ -142,17 +142,17 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *edata,
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
+		val = ftrace_regs_get_return_value(fregs);
 		break;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	case FETCH_OP_ARG:
-		val = regs_get_kernel_argument(regs, code->param);
+		val = ftrace_regs_get_argument(fregs, code->param);
 		break;
 	case FETCH_OP_EDATA:
 		val = *(unsigned long *)((unsigned long)edata + code->offset);
@@ -175,7 +175,7 @@ NOKPROBE_SYMBOL(process_fetch_insn)
 /* function entry handler */
 static nokprobe_inline void
 __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		    struct pt_regs *regs,
+		    struct ftrace_regs *fregs,
 		    struct trace_event_file *trace_file)
 {
 	struct fentry_trace_entry_head *entry;
@@ -189,41 +189,71 @@ __fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs, NULL);
+	dsize = __get_data_size(&tf->tp, fregs, NULL);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
 	if (!entry)
 		return;
 
-	fbuffer.regs = regs;
+	fbuffer.regs = ftrace_get_regs(fregs);
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->ip = entry_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, NULL, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize);
 
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
 
+static nokprobe_inline
+void store_fprobe_entry_data(void *edata, struct trace_probe *tp, struct ftrace_regs *fregs)
+{
+	struct probe_entry_arg *earg = tp->entry_arg;
+	unsigned long val = 0;
+	int i;
+
+	if (!earg)
+		return;
+
+	for (i = 0; i < earg->size; i++) {
+		struct fetch_insn *code = &earg->code[i];
+
+		switch (code->op) {
+		case FETCH_OP_ARG:
+			val = ftrace_regs_get_argument(fregs, code->param);
+			break;
+		case FETCH_OP_ST_EDATA:
+			*(unsigned long *)((unsigned long)edata + code->offset) = val;
+			break;
+		case FETCH_OP_END:
+			goto end;
+		default:
+			break;
+		}
+	}
+end:
+	return;
+}
+
 /* function exit handler */
 static int trace_fprobe_entry_handler(struct fprobe *fp, unsigned long entry_ip,
-				unsigned long ret_ip, struct pt_regs *regs,
+				unsigned long ret_ip, struct ftrace_regs *fregs,
 				void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
 
 	if (tf->tp.entry_arg)
-		store_trace_entry_data(entry_data, &tf->tp, regs);
+		store_fprobe_entry_data(entry_data, &tf->tp, fregs);
 
 	return 0;
 }
@@ -231,7 +261,7 @@ NOKPROBE_SYMBOL(trace_fprobe_entry_handler)
 
 static nokprobe_inline void
 __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		   unsigned long ret_ip, struct pt_regs *regs,
+		   unsigned long ret_ip, struct ftrace_regs *fregs,
 		   void *entry_data, struct trace_event_file *trace_file)
 {
 	struct fexit_trace_entry_head *entry;
@@ -245,60 +275,63 @@ __fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs, entry_data);
+	dsize = __get_data_size(&tf->tp, fregs, entry_data);
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
 					   sizeof(*entry) + tf->tp.size + dsize);
 	if (!entry)
 		return;
 
-	fbuffer.regs = regs;
+	fbuffer.regs = ftrace_get_regs(fregs);
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, entry_data, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, entry_data, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 static void
 fexit_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		 unsigned long ret_ip, struct pt_regs *regs, void *entry_data)
+		 unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data)
 {
 	struct event_file_link *link;
 
 	trace_probe_for_each_link_rcu(link, &tf->tp)
-		__fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data, link->file);
+		__fexit_trace_func(tf, entry_ip, ret_ip, fregs, entry_data, link->file);
 }
 NOKPROBE_SYMBOL(fexit_trace_func);
 
 #ifdef CONFIG_PERF_EVENTS
 
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
 
 	head = this_cpu_ptr(call->perf_events);
 	if (hlist_empty(head))
 		return 0;
 
-	dsize = __get_data_size(&tf->tp, regs, NULL);
+	dsize = __get_data_size(&tf->tp, fregs, NULL);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
-	entry = perf_trace_buf_alloc(size, NULL, &rctx);
+	entry = perf_trace_buf_alloc(size, &regs, &rctx);
 	if (!entry)
 		return 0;
 
+	regs = ftrace_fill_perf_regs(fregs, regs);
+
 	entry->ip = entry_ip;
 	memset(&entry[1], 0, dsize);
-	store_trace_args(&entry[1], &tf->tp, regs, NULL, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 	return 0;
@@ -307,31 +340,34 @@ NOKPROBE_SYMBOL(fentry_perf_func);
 
 static void
 fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
-		unsigned long ret_ip, struct pt_regs *regs,
+		unsigned long ret_ip, struct ftrace_regs *fregs,
 		void *entry_data)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
 	struct fexit_trace_entry_head *entry;
 	struct hlist_head *head;
 	int size, __size, dsize;
+	struct pt_regs *regs;
 	int rctx;
 
 	head = this_cpu_ptr(call->perf_events);
 	if (hlist_empty(head))
 		return;
 
-	dsize = __get_data_size(&tf->tp, regs, entry_data);
+	dsize = __get_data_size(&tf->tp, fregs, entry_data);
 	__size = sizeof(*entry) + tf->tp.size + dsize;
 	size = ALIGN(__size + sizeof(u32), sizeof(u64));
 	size -= sizeof(u32);
 
-	entry = perf_trace_buf_alloc(size, NULL, &rctx);
+	entry = perf_trace_buf_alloc(size, &regs, &rctx);
 	if (!entry)
 		return;
 
+	regs = ftrace_fill_perf_regs(fregs, regs);
+
 	entry->func = entry_ip;
 	entry->ret_ip = ret_ip;
-	store_trace_args(&entry[1], &tf->tp, regs, entry_data, sizeof(*entry), dsize);
+	store_trace_args(&entry[1], &tf->tp, fregs, entry_data, sizeof(*entry), dsize);
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
 }
@@ -343,17 +379,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
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
@@ -364,16 +397,12 @@ static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return;
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
-		fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data);
+		fexit_trace_func(tf, entry_ip, ret_ip, fregs, entry_data);
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
-		fexit_perf_func(tf, entry_ip, ret_ip, regs, entry_data);
+		fexit_perf_func(tf, entry_ip, ret_ip, fregs, entry_data);
 #endif
 }
 NOKPROBE_SYMBOL(fexit_dispatcher);
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 2caf0d2afb32..f39b37fcdb3b 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -232,7 +232,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 /* Sum up total data length for dynamic arrays (strings) */
 static nokprobe_inline int
-__get_data_size(struct trace_probe *tp, struct pt_regs *regs, void *edata)
+__get_data_size(struct trace_probe *tp, void *regs, void *edata)
 {
 	struct probe_arg *arg;
 	int i, len, ret = 0;


