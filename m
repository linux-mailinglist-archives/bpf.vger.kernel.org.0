Return-Path: <bpf+bounces-28854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E98BE580
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF212B23EB0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157615FD1A;
	Tue,  7 May 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVKgDM7t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF815F408;
	Tue,  7 May 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091085; cv=none; b=sztCtKV1DRMVRTUazMJHBsnW9htuKaieYB+Is94rZycS1ycYWpRtZ/dAoNuqkOQLArjYJNcEGlQ0YhBDCoUhFbKJC3sOW0dSaMICTk4gsff0UhPO7bd1GamvLmggcdLKkeO2jj0216DX86keMThaBh0I4by0KSkoNJFttSCF5Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091085; c=relaxed/simple;
	bh=jf10GIgA9GQ7jpNlhmEZb2LkRHqgoKve/Rbvdt43k/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cax6ATwNU4GCt6B9K7T7lSg2HrUiGEp9Q0DllMsOxr9xDkb11WEgrVieaBbuxdOpLVq3Oj4RmgwNhKXa5WqzaxI3f78/pnxuSGnrptWsC8AsDUcVrP5AjGoOx0WsQzO5Uhl4sxytgBhbS3/xnDOhrgiUym6/T5wZBXLswLKkbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVKgDM7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC8C2BBFC;
	Tue,  7 May 2024 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091085;
	bh=jf10GIgA9GQ7jpNlhmEZb2LkRHqgoKve/Rbvdt43k/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVKgDM7tkOkCRuRl/qVCINMAAkd5n2FkCe233Ly1TxisVoSVPoJqkui8/VvLDKVl6
	 GzA5HkBhZC54P8LSoA3Kj7RoZd6zT6UwAb0VHLpjFfeRtUsB921rww/vwoC4wohr2J
	 6Zm1QQhpIiNJy9vFrLGUQ4SCY5h75XYZP6LkjkgMwmK8XBv3UzdyjEgPdMmV+KwtX5
	 CoP0M76uyz+wvClcn/9gzZEBwY0wctK4MiBiaGBqdM2Mhkb9YP0sEJWtMZBboXfNHh
	 RETnkKK1ebwcJFLpoiKowlIP8Enz1tlTexbeGcAFA4ewjHcKugSRzJVKTxpupK/uU8
	 7Skz8HJD2mRlA==
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
Subject: [PATCH v10 17/36] function_graph: Move graph notrace bit to shadow stack global var
Date: Tue,  7 May 2024 23:11:19 +0900
Message-Id: <171509107907.162236.6564679266777519065.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

The use of the task->trace_recursion for the logic used for the function
graph no-trace was a bit of an abuse of that variable. Now that there
exists global vars that are per stack for registered graph traces, use
that instead.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Make description lines shorter than 76 chars.
---
 include/linux/trace_recursion.h      |    7 -------
 kernel/trace/trace.h                 |    9 +++++++++
 kernel/trace/trace_functions_graph.c |   10 ++++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index fdfb6f66718a..ae04054a1be3 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -44,13 +44,6 @@ enum {
  */
 	TRACE_IRQ_BIT,
 
-	/*
-	 * To implement set_graph_notrace, if this bit is set, we ignore
-	 * function graph tracing of called functions, until the return
-	 * function is called to clear it.
-	 */
-	TRACE_GRAPH_NOTRACE_BIT,
-
 	/* Used to prevent recursion recording from recursing. */
 	TRACE_RECORD_RECURSION_BIT,
 };
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 7ab731b9ebc8..f23b6fbd547d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -918,8 +918,17 @@ enum {
 
 	TRACE_GRAPH_DEPTH_START_BIT,
 	TRACE_GRAPH_DEPTH_END_BIT,
+
+	/*
+	 * To implement set_graph_notrace, if this bit is set, we ignore
+	 * function graph tracing of called functions, until the return
+	 * function is called to clear it.
+	 */
+	TRACE_GRAPH_NOTRACE_BIT,
 };
 
+#define TRACE_GRAPH_NOTRACE		(1 << TRACE_GRAPH_NOTRACE_BIT)
+
 static inline unsigned long ftrace_graph_depth(unsigned long *task_var)
 {
 	return (*task_var >> TRACE_GRAPH_DEPTH_START_BIT) & 3;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66cce73e94f8..13d0387ac6a6 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -130,6 +130,7 @@ static inline int ftrace_graph_ignore_irqs(void)
 int trace_graph_entry(struct ftrace_graph_ent *trace,
 		      struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -138,7 +139,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	int ret;
 	int cpu;
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
+	if (*task_var & TRACE_GRAPH_NOTRACE)
 		return 0;
 
 	/*
@@ -149,7 +150,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
 	 * returning from the function.
 	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
-		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
+		*task_var |= TRACE_GRAPH_NOTRACE_BIT;
 		/*
 		 * Need to return 1 to have the return called
 		 * that will clear the NOTRACE bit.
@@ -240,6 +241,7 @@ void __trace_graph_return(struct trace_array *tr,
 void trace_graph_return(struct ftrace_graph_ret *trace,
 			struct fgraph_ops *gops)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
 	struct trace_array_cpu *data;
 	unsigned long flags;
@@ -249,8 +251,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 
 	ftrace_graph_addr_finish(gops, trace);
 
-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}
 


