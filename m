Return-Path: <bpf+bounces-31133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B58D7364
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB381C20FD1
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A540C03;
	Sun,  2 Jun 2024 03:37:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DC3CF6A;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299447; cv=none; b=R9WtAFzKW7imS3+ddn2EHuGXRD281OI3yj5EPf9tKn76yg9B5fTcEs7JYSvSem0DrWI0nZhiZRKviimTsHZQNT6ZzP1h9pzdg550fSjPYEUGV04+Em3FmI6iUgD1qR6XFkExO4WSN+itkMHsdgtmDjVhKTvWbocyL+Siglm8VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299447; c=relaxed/simple;
	bh=Mp/RBRnPhJxFELiieLyMmnfwMLk/QV2Kygzld2RQi0M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NENnshHD5HOlwAVyVDGDG3uwyN87DeS5bsuAIKVP3uzLSj7TcFZTbutzsIfq5TmuuG/eCOdNRcj5iWdyk1TdHpDycwad50OF8vhbrBRVgf8Wk7kahkjT5nHukXSFkxqNUQgAkhRpHHL3VGYtVnSr0XkMjdoIJTor/I9oB2AC8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE08C4AF07;
	Sun,  2 Jun 2024 03:37:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3H-000000094Ux-0Zkd;
	Sat, 01 Jun 2024 23:38:35 -0400
Message-ID: <20240602033834.997761817@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:38:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 24/27] function_graph: Use static_call and branch to optimize entry function
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In most cases function graph is used by a single user. Instead of calling
a loop to call function graph callbacks in this case, call the function
entry callback directly.

Add a static_key that will be used to set the function graph logic to
either do the loop (when more than one callback is registered) or to call
the callback directly if there is only one registered callback.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 77 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4d566a0a741d..7c3b0261b1bb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -11,6 +11,7 @@
 #include <linux/jump_label.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
+#include <linux/static_call.h>
 #include <linux/slab.h>
 
 #include <trace/events/sched.h>
@@ -511,6 +512,10 @@ static struct fgraph_ops fgraph_stub = {
 	.retfunc = ftrace_graph_ret_stub,
 };
 
+static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
+DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
+DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
+
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -636,21 +641,34 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for_each_set_bit(i, &fgraph_array_bitmask,
-			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-		struct fgraph_ops *gops = fgraph_array[i];
-		int save_curr_ret_stack;
-
-		if (gops == &fgraph_stub)
-			continue;
+#ifdef CONFIG_HAVE_STATIC_CALL
+	if (static_branch_likely(&fgraph_do_direct)) {
+		int save_curr_ret_stack = current->curr_ret_stack;
 
-		save_curr_ret_stack = current->curr_ret_stack;
-		if (ftrace_ops_test(&gops->ops, func, NULL) &&
-		    gops->entryfunc(&trace, gops))
-			bitmap |= BIT(i);
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
+			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
 			current->curr_ret_stack = save_curr_ret_stack;
+	} else
+#endif
+	{
+		for_each_set_bit(i, &fgraph_array_bitmask,
+					 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
+			struct fgraph_ops *gops = fgraph_array[i];
+			int save_curr_ret_stack;
+
+			if (gops == &fgraph_stub)
+				continue;
+
+			save_curr_ret_stack = current->curr_ret_stack;
+			if (ftrace_ops_test(&gops->ops, func, NULL) &&
+			    gops->entryfunc(&trace, gops))
+				bitmap |= BIT(i);
+			else
+				/* Clear out any saved storage */
+				current->curr_ret_stack = save_curr_ret_stack;
+		}
 	}
 
 	if (!bitmap)
@@ -1155,6 +1173,8 @@ void fgraph_update_pid_func(void)
 			gops = container_of(op, struct fgraph_ops, ops);
 			gops->entryfunc = ftrace_pids_enabled(op) ?
 				fgraph_pid_func : gops->saved_func;
+			if (ftrace_graph_active == 1)
+				static_call_update(fgraph_func, gops->entryfunc);
 		}
 	}
 }
@@ -1209,6 +1229,32 @@ static void init_task_vars(int idx)
 	read_unlock(&tasklist_lock);
 }
 
+static void ftrace_graph_enable_direct(bool enable_branch)
+{
+	trace_func_graph_ent_t func = NULL;
+	int i;
+
+	for_each_set_bit(i, &fgraph_array_bitmask,
+			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
+		func = fgraph_array[i]->entryfunc;
+		fgraph_direct_gops = fgraph_array[i];
+	 }
+	if (WARN_ON_ONCE(!func))
+		return;
+
+	static_call_update(fgraph_func, func);
+	if (enable_branch)
+		static_branch_disable(&fgraph_do_direct);
+}
+
+static void ftrace_graph_disable_direct(bool disable_branch)
+{
+	if (disable_branch)
+		static_branch_disable(&fgraph_do_direct);
+	static_call_update(fgraph_func, ftrace_graph_entry_stub);
+	fgraph_direct_gops = &fgraph_stub;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -1235,7 +1281,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	ftrace_graph_active++;
 
+	if (ftrace_graph_active == 2)
+		ftrace_graph_disable_direct(true);
+
 	if (ftrace_graph_active == 1) {
+		ftrace_graph_enable_direct(false);
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
 		if (ret)
@@ -1292,6 +1342,11 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 
 	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
+	if (ftrace_graph_active == 1)
+		ftrace_graph_enable_direct(true);
+	else if (!ftrace_graph_active)
+		ftrace_graph_disable_direct(false);
+
 	if (!ftrace_graph_active) {
 		ftrace_graph_return = ftrace_stub_graph;
 		ftrace_graph_entry = ftrace_graph_entry_stub;
-- 
2.43.0



