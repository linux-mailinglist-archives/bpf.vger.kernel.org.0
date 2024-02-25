Return-Path: <bpf+bounces-22659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36C862B04
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623AC280FE9
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECFA14F90;
	Sun, 25 Feb 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI07BCLu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681E14286;
	Sun, 25 Feb 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874175; cv=none; b=niUKCa+dk9LQo4UOsgX56kVq/qJjrXCBy91W772kCeU2E8UByNC4Y5824zZjcpld3jGlLocaJObG2jVfniCExprQJ1/lsXI0H/pYjFtD3CRITReTxcnhopUca+jpwGdX8A84qS3GiF5wDIeuMR8z9vYG1hpMHL62+lNPF23oxgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874175; c=relaxed/simple;
	bh=tA+xME0cqxvdm/SL6/3HnWW/4VMwGO83nJFglJrGK1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwYmzP9L3N6id8cDyNAFG3zLG92br0Hjvx8XzbznrMAj7SvKw31MyLNf+GIIAoVb2Gr8NJJfxJ94jDp3zsFxe2k0hr9xW69ha0Vm21V7EwmR8R78163UC0kR7btigFj7Gve29nOayn6NVsP1D4lMx6DNsZqbNRxk5UnFUISTTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI07BCLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E81C433C7;
	Sun, 25 Feb 2024 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874175;
	bh=tA+xME0cqxvdm/SL6/3HnWW/4VMwGO83nJFglJrGK1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pI07BCLunb1Z7O7HMxKRY6JsbvM0mWjF6qz7qb0NTuVLCXZosxTin6XaSPg9/yMA2
	 FnFfMfsaMbKmKOZ7R3eCiov9ha2zIBaWZHVxMgmxw4YRiG5pdILIdFG8+Ci4yOhr9G
	 mm9xHBJVkWXqBZb6E/l8y0V5LAqhz7qmBpejlahAXIYCWZ8XeXRJRWiRjXjPs2ZOwd
	 PzMt8AQQ9jBPlnEvGnW13Hahj3ClvxvVvtrkRxQreIBeSqwOsWE5qPz6jMT2POdfvw
	 8t4Vus8hnX1bhOEW9/OSN37xy1YcMOUiNW6bKNmEPcI+31cFg75SomIfr+SZE7d8v7
	 HJ8BjRsfGRDQA==
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
Subject: [PATCH v8 06/35] function_graph: Add an array structure that will allow multiple callbacks
Date: Mon, 26 Feb 2024 00:16:09 +0900
Message-Id: <170887416943.564249.17524784323819186379.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170887410337.564249.6360118840946697039.stgit@devnote2>
References: <170887410337.564249.6360118840946697039.stgit@devnote2>
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

Add an array structure that will eventually allow the function graph tracer
to have up to 16 simultaneous callbacks attached. It's an array of 16
fgraph_ops pointers, that is assigned when one is registered. On entry of a
function the entry of the first item in the array is called, and if it
returns zero, then the callback returns non zero if it wants the return
callback to be called on exit of the function.

The array will simplify the process of having more than one callback
attached to the same function, as its index into the array can be stored on
the shadow stack. We need to only save the index, because this will allow
the fgraph_ops to be freed before the function returns (which may happen if
the function call schedule for a long time).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Remove unneeded brace.
---
 kernel/trace/fgraph.c |  114 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6f8d36370994..3f9dd213e7d8 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -39,6 +39,11 @@
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
+static int fgraph_array_cnt;
+#define FGRAPH_ARRAY_SIZE	16
+
+static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
+
 /* Both enabled by default (can be cleared by function_graph tracer flags */
 static bool fgraph_sleep_time = true;
 
@@ -62,6 +67,20 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 }
 #endif
 
+int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
+{
+	return 0;
+}
+
+static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace)
+{
+}
+
+static struct fgraph_ops fgraph_stub = {
+	.entryfunc = ftrace_graph_entry_stub,
+	.retfunc = ftrace_graph_ret_stub,
+};
+
 /**
  * ftrace_graph_stop - set to permanently disable function graph tracing
  *
@@ -159,7 +178,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 		goto out;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
+	if (!fgraph_array[0]->entryfunc(&trace))
 		goto out_ret;
 
 	return 0;
@@ -274,7 +293,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 	trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif
 	trace.rettime = trace_clock_local();
-	ftrace_graph_return(&trace);
+	fgraph_array[0]->retfunc(&trace);
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
@@ -410,11 +429,6 @@ void ftrace_graph_sleep_time_control(bool enable)
 	fgraph_sleep_time = enable;
 }
 
-int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
-{
-	return 0;
-}
-
 /*
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
@@ -652,37 +666,54 @@ static int start_graph_tracing(void)
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int ret = 0;
+	int i;
 
 	mutex_lock(&ftrace_lock);
 
-	/* we currently allow only one tracer registered at a time */
-	if (ftrace_graph_active) {
+	if (!fgraph_array[0]) {
+		/* The array must always have real data on it */
+		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
+			fgraph_array[i] = &fgraph_stub;
+	}
+
+	/* Look for an available spot */
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		if (fgraph_array[i] == &fgraph_stub)
+			break;
+	}
+	if (i >= FGRAPH_ARRAY_SIZE) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	register_pm_notifier(&ftrace_suspend_notifier);
+	fgraph_array[i] = gops;
+	if (i + 1 > fgraph_array_cnt)
+		fgraph_array_cnt = i + 1;
 
 	ftrace_graph_active++;
-	ret = start_graph_tracing();
-	if (ret) {
-		ftrace_graph_active--;
-		goto out;
-	}
 
-	ftrace_graph_return = gops->retfunc;
+	if (ftrace_graph_active == 1) {
+		register_pm_notifier(&ftrace_suspend_notifier);
+		ret = start_graph_tracing();
+		if (ret) {
+			ftrace_graph_active--;
+			goto out;
+		}
+
+		ftrace_graph_return = gops->retfunc;
 
-	/*
-	 * Update the indirect function to the entryfunc, and the
-	 * function that gets called to the entry_test first. Then
-	 * call the update fgraph entry function to determine if
-	 * the entryfunc should be called directly or not.
-	 */
-	__ftrace_graph_entry = gops->entryfunc;
-	ftrace_graph_entry = ftrace_graph_entry_test;
-	update_function_graph_func();
+		/*
+		 * Update the indirect function to the entryfunc, and the
+		 * function that gets called to the entry_test first. Then
+		 * call the update fgraph entry function to determine if
+		 * the entryfunc should be called directly or not.
+		 */
+		__ftrace_graph_entry = gops->entryfunc;
+		ftrace_graph_entry = ftrace_graph_entry_test;
+		update_function_graph_func();
 
-	ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
+	}
 out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
@@ -690,19 +721,36 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
+	int i;
+
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	ftrace_graph_active--;
-	ftrace_graph_return = ftrace_stub_graph;
-	ftrace_graph_entry = ftrace_graph_entry_stub;
-	__ftrace_graph_entry = ftrace_graph_entry_stub;
-	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-	unregister_pm_notifier(&ftrace_suspend_notifier);
-	unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	for (i = 0; i < fgraph_array_cnt; i++)
+		if (gops == fgraph_array[i])
+			break;
+	if (i >= fgraph_array_cnt)
+		goto out;
 
+	fgraph_array[i] = &fgraph_stub;
+	if (i + 1 == fgraph_array_cnt) {
+		for (; i >= 0; i--)
+			if (fgraph_array[i] != &fgraph_stub)
+				break;
+		fgraph_array_cnt = i + 1;
+	}
+
+	ftrace_graph_active--;
+	if (!ftrace_graph_active) {
+		ftrace_graph_return = ftrace_stub_graph;
+		ftrace_graph_entry = ftrace_graph_entry_stub;
+		__ftrace_graph_entry = ftrace_graph_entry_stub;
+		ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
+		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
+	}
  out:
 	mutex_unlock(&ftrace_lock);
 }


