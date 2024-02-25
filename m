Return-Path: <bpf+bounces-22667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB78862B15
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71253281311
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CF15E8C;
	Sun, 25 Feb 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYM4h7Tc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946E1AACD;
	Sun, 25 Feb 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874262; cv=none; b=LQy/9+mBzytFigVcwAF2nNGjdZ12/Mj418ynv+rZaPZJK+cNwWVOc/wLNAz05MeD2gJ5micCAymW5m3pqqWx8luikYzw+PK3Y3D1FrZddErEz9vf0uYArmHz5a7TQasaRaFwpl3WtXpO9NwnWEkkwKecHz5FgL2Y4/wTERKVbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874262; c=relaxed/simple;
	bh=1hoFmZfxu3ThG4SOgB5VhMFZeayqk0kP0HoUu8ZzkK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAQUYzJOOoAZkyoj4D1qYZ78vg3JpvN9RN0DqXDpBu3x91W6b5lJoQrmkMWCUORtKIY8PJedsaRAn5vMyNFEFvTc5jLzUYKtTUTwRRe3YiazLFbUOXT0C2sKR8PRvtwIIUt55jpIJ+9Y+bNfS8Y1N7YRc2S7z0f1MAN659DKItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYM4h7Tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBFC433C7;
	Sun, 25 Feb 2024 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874262;
	bh=1hoFmZfxu3ThG4SOgB5VhMFZeayqk0kP0HoUu8ZzkK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYM4h7TcEio2PudwoNfdc4LLal5kVacnFmOKqed5xMRhiS2cV/E/Rvd18UGKEJnZR
	 AJFllV7dHxmkVpWmA2NfTOlaF6XiG0Y1kT9ZmtSOj6WoHXax8Aj0XuAfSrpd66FDQ8
	 B1s9DuNnx3FfFyLYKpQQJZ92RiCys7MPTPv4jKHGAehUC0l/Zb5XffXCJZTGWD5hTQ
	 bdZdFtTFQhmLDBL8moH2WcoD4QWTa/7V2VJ0E7liyqNkf2Q32wr1HCQ+nYL++a2A5D
	 NqRs74ZMvkRnvnJhuYgrDzoP/4MKRDKcayI+PpkKG0QtLcTlU3x6whs11vfZwqpvk8
	 JvXp5ZtlIBqSA==
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
Subject: [PATCH v8 14/35] function_graph: Add "task variables" per task for fgraph_ops
Date: Mon, 26 Feb 2024 00:17:36 +0900
Message-Id: <170887425622.564249.11187289271451893351.stgit@devnote2>
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

Add a "task variables" array on the tasks shadow ret_stack that is the
size of longs for each possible registered fgraph_ops. That's a total
of 16, taking up 8 * 16 = 128 bytes (out of a page size 4k).

This will allow for fgraph_ops to do specific features on a per task basis
having a way to maintain state for each task.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Move fgraph_ops::idx to previous patch in the series.
 Changes in v2:
  - Make description lines shorter than 76 chars.
---
 include/linux/ftrace.h |    1 +
 kernel/trace/fgraph.c  |   70 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3d9e74ea6065..737f84104577 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1116,6 +1116,7 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops);
 
 /*
  * Sometimes we don't want to trace a function with the function
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index da5f269ce718..780976088587 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -92,10 +92,18 @@ enum {
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
-#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - (FGRAPH_RET_INDEX + 1))
+#define SHADOW_STACK_MAX_INDEX				\
+	(SHADOW_STACK_INDEX - (FGRAPH_RET_INDEX + 1 + FGRAPH_ARRAY_SIZE))
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
+/*
+ * Each fgraph_ops has a reservered unsigned long at the end (top) of the
+ * ret_stack to store task specific state.
+ */
+#define SHADOW_STACK_TASK_VARS(ret_stack) \
+	((unsigned long *)(&(ret_stack)[SHADOW_STACK_INDEX - FGRAPH_ARRAY_SIZE]))
+
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
@@ -186,6 +194,44 @@ static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
 {
 }
 
+static void ret_stack_set_task_var(struct task_struct *t, int idx, long val)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	gvals[idx] = val;
+}
+
+static unsigned long *
+ret_stack_get_task_var(struct task_struct *t, int idx)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(t->ret_stack);
+
+	return &gvals[idx];
+}
+
+static void ret_stack_init_task_vars(unsigned long *ret_stack)
+{
+	unsigned long *gvals = SHADOW_STACK_TASK_VARS(ret_stack);
+
+	memset(gvals, 0, sizeof(*gvals) * FGRAPH_ARRAY_SIZE);
+}
+
+/**
+ * fgraph_get_task_var - retrieve a task specific state variable
+ * @gops: The ftrace_ops that owns the task specific variable
+ *
+ * Every registered fgraph_ops has a task state variable
+ * reserved on the task's ret_stack. This function returns the
+ * address to that variable.
+ *
+ * Returns the address to the fgraph_ops @gops tasks specific
+ * unsigned long variable.
+ */
+unsigned long *fgraph_get_task_var(struct fgraph_ops *gops)
+{
+	return ret_stack_get_task_var(current, gops->idx);
+}
+
 /*
  * @offset: The index into @t->ret_stack to find the ret_stack entry
  * @index: Where to place the index into @t->ret_stack of that entry
@@ -795,6 +841,7 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 
 		if (t->ret_stack == NULL) {
 			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(ret_stack_list[start]);
 			t->curr_ret_stack = 0;
 			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the 0 first: */
@@ -855,6 +902,7 @@ static void
 graph_init_task(struct task_struct *t, unsigned long *ret_stack)
 {
 	atomic_set(&t->trace_overrun, 0);
+	ret_stack_init_task_vars(ret_stack);
 	t->ftrace_timestamp = 0;
 	t->curr_ret_stack = 0;
 	t->curr_ret_depth = -1;
@@ -953,6 +1001,24 @@ static int start_graph_tracing(void)
 	return ret;
 }
 
+static void init_task_vars(int idx)
+{
+	struct task_struct *g, *t;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (idle_task(cpu)->ret_stack)
+			ret_stack_set_task_var(idle_task(cpu), idx, 0);
+	}
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, t) {
+		if (t->ret_stack)
+			ret_stack_set_task_var(t, idx, 0);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -1001,6 +1067,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_return = return_run;
 		ftrace_graph_entry = entry_run;
 		command = FTRACE_START_FUNC_RET;
+	} else {
+		init_task_vars(gops->idx);
 	}
 
 	ret = ftrace_startup(&gops->ops, command);


