Return-Path: <bpf+bounces-33759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF192581D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F41C22796
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F1172BD5;
	Wed,  3 Jul 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5AAsqgY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602015B97C;
	Wed,  3 Jul 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001563; cv=none; b=RFxO0Rqai6vJRmhzCL2VGco13jZyMkf7bdRdUiyP6Qf7qOAYTsf1Ymk6/qFqJwG4xWxOrTHsxiz31iLhlKXL8THF5GAyXTyhxDc69QqCtv4w0svfK7Dxs/3mlN8+yWJtHbfQ296SPm6h1dUSXXhpH50MvJUsWK2rsHT3MWpEuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001563; c=relaxed/simple;
	bh=AeBjaLoROEWvvXY7IoIQZpq4ONuupJph5GFWwkgjmFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHQQjLzRD+06rW2PFZqmTocKW+139NlQ1X8V72TXakCfE2D/RNERXb0iLdb5LsbYvhTAgjlS7BIEGrAtierZwsEs1oieC2Nby9/1MHnLJsijWjZXO//tgVP/xrdEDK9koNTCKHa/+HuvuQLj+I/Ia/THvKzUlIHQnAYquKwD9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5AAsqgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9439CC2BD10;
	Wed,  3 Jul 2024 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720001563;
	bh=AeBjaLoROEWvvXY7IoIQZpq4ONuupJph5GFWwkgjmFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5AAsqgYwDg72Lp+eI8rT56dChOdUrJa7DzCPNG7zOjIpB10dLqHUL8veNj0CIvVX
	 dWrrm8pU66zs8GyCbfUYvunvPLYKh05FAX6nuuJ25iy2x13QxaR+HpdkSCjLWvH8kH
	 u1PXe1Ef2pLOmllNmPYCraqSE9og0DUR+ICAiWb8Fap/XLiIHF/3PDAWKtKdCBmCeR
	 yO8u/QW4BfFodq5FsScyapl8mYzgN88QpFFzo5o+h8s0DpkbOg8Q8I7tOedRtNe+Wf
	 WxxtU/MeMMIzECQEHJdhjbJ68V8aZ2YO/a++EzGWw3Z80AWicJeAAcMJsMeM+HK07t
	 5+d1eXvDc4vhQ==
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
Subject: [PATCH v12 19/19] fgraph: Skip push operation if no retfunc is registered
Date: Wed,  3 Jul 2024 19:12:37 +0900
Message-Id: <172000155761.63468.18000309430070229697.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172000134410.63468.13742222887213469474.stgit@devnote2>
References: <172000134410.63468.13742222887213469474.stgit@devnote2>
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

Skip push operation only when there is no fgraph_ops which sets retfunc.

This is for optimizing performance of fprobe on fgraph. Since the major
use case of fprobe is putting a probe on function entry and another
probe on exit. Since these probes are independent, if user only uses
fprobe on function entry, we don't need to push a frame information on
shadow stack.

Here is the performance improvement results;

Without this:
kprobe-multi   :    6.265 ± 0.033M/s
kretprobe-multi:    4.758 ± 0.009M/s

With this:
kprobe-multi   :    6.377 ± 0.054M/s	+1.79%
kretprobe-multi:    4.815 ± 0.007M/s	+1.20%

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |    1 +
 kernel/trace/fgraph.c  |   33 +++++++++++++++++++++++++--------
 kernel/trace/fprobe.c  |   25 ++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fabf1a0979d4..d08e5e6e725f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1220,6 +1220,7 @@ unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 #define FTRACE_RETFUNC_DEPTH 50
 #define FTRACE_RETSTACK_ALLOC_SIZE 32
 
+void ftrace_graph_update_flags(void);
 extern int register_ftrace_graph(struct fgraph_ops *ops);
 extern void unregister_ftrace_graph(struct fgraph_ops *ops);
 
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cf3ae59a436e..3a23d4e5738c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -175,6 +175,7 @@ int ftrace_graph_active;
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 static unsigned long fgraph_array_bitmask;
 static bool fgraph_skip_timestamp;
+static bool fgraph_skip_all;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -349,6 +350,9 @@ void *fgraph_reserve_data(int idx, int size_bytes)
 	int curr_ret_stack = current->curr_ret_stack;
 	int data_size;
 
+	if (unlikely(fgraph_skip_all))
+		return NULL;
+
 	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
 		return NULL;
 
@@ -632,9 +636,11 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
-	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
-	if (offset < 0)
-		goto out;
+	if (likely(!fgraph_skip_all)) {
+		offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
+		if (offset < 0)
+			goto out;
+	}
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 	if (static_branch_likely(&fgraph_do_direct)) {
@@ -665,6 +671,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 				current->curr_ret_stack = save_curr_ret_stack;
 		}
 	}
+	if (unlikely(fgraph_skip_all))
+		goto out;
 
 	if (!bitmap)
 		goto out_ret;
@@ -1254,6 +1262,7 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 
 static void update_fgraph_skip_timestamp(void)
 {
+	bool skip_all = true, skip_ts = true;
 	int i;
 
 	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
@@ -1262,12 +1271,20 @@ static void update_fgraph_skip_timestamp(void)
 		if (gops == &fgraph_stub)
 			continue;
 
-		if (!gops->skip_timestamp) {
-			fgraph_skip_timestamp = false;
-			return;
-		}
+		if (!gops->skip_timestamp)
+			skip_ts = false;
+		if (gops->retfunc)
+			skip_all = false;
 	}
-	fgraph_skip_timestamp = true;
+	fgraph_skip_timestamp = skip_ts;
+	fgraph_skip_all = skip_all;
+}
+
+void ftrace_graph_update_flags(void)
+{
+	mutex_lock(&ftrace_lock);
+	update_fgraph_skip_timestamp();
+	mutex_unlock(&ftrace_lock);
 }
 
 int register_ftrace_graph(struct fgraph_ops *gops)
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index b108d26d7ee5..188a38ac3153 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -42,6 +42,9 @@ static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
 static struct hlist_head fprobe_ip_table[FPROBE_IP_TABLE_SIZE];
 static DEFINE_MUTEX(fprobe_mutex);
 
+/* Count the number of fprobe which has the exit_handler. */
+static int fprobe_nr_exit_handlers;
+
 /*
  * Find first fprobe in the hlist. It will be iterated twice in the entry
  * probe, once for correcting the total required size, the second time is
@@ -344,11 +347,18 @@ NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
 	.entryfunc	= fprobe_entry,
-	.retfunc	= fprobe_return,
+	/* retfunc is set only if any fprobe.exit_handler is set. */
 	.skip_timestamp = true,
 };
 static int fprobe_graph_active;
 
+static void fprobe_graph_switch_retfunc(bool enable)
+{
+	fprobe_graph_ops.retfunc = enable ? fprobe_return : NULL;
+	if (fprobe_graph_active)
+		ftrace_graph_update_flags();
+}
+
 /* Add @addrs to the ftrace filter and register fgraph if needed. */
 static int fprobe_graph_add_ips(unsigned long *addrs, int num)
 {
@@ -480,6 +490,8 @@ static int fprobe_init(struct fprobe *fp, unsigned long *addrs, int num)
 	size = ALIGN(fp->entry_data_size, sizeof(long));
 	if (size > MAX_FPROBE_DATA_SIZE)
 		return -E2BIG;
+	if (!fp->exit_handler && size)
+		return -EINVAL;
 	fp->entry_data_size = size;
 
 	hlist_array = kzalloc(struct_size(hlist_array, array, num), GFP_KERNEL);
@@ -564,6 +576,11 @@ int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
 
 	mutex_lock(&fprobe_mutex);
 
+	if (fp->exit_handler) {
+		fprobe_nr_exit_handlers++;
+		if (fprobe_nr_exit_handlers == 1)
+			fprobe_graph_switch_retfunc(true);
+	}
 	hlist_array = fp->hlist_array;
 	ret = fprobe_graph_add_ips(addrs, num);
 	if (!ret) {
@@ -653,6 +670,12 @@ int unregister_fprobe(struct fprobe *fp)
 	}
 	del_fprobe_hash(fp);
 
+	if (fp->exit_handler) {
+		fprobe_nr_exit_handlers--;
+		if (!fprobe_nr_exit_handlers)
+			fprobe_graph_switch_retfunc(false);
+	}
+
 	if (count)
 		fprobe_graph_remove_ips(addrs, count);
 


