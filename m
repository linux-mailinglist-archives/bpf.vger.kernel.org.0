Return-Path: <bpf+bounces-37463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A8955C9D
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30BB1C21221
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F5148FF3;
	Sun, 18 Aug 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOonnQkR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD30B674;
	Sun, 18 Aug 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985488; cv=none; b=J9bg/UiVoMBA7+TLpOhZrH6f3W3c/XSZNqS6JQ84+96KS8qy0egVeBQ9NPN6a4QQrpRNiSH91MIJyKggFj4NGHvBBxuulGTcbK3Fbt+hT2BoUGg6gMd0aqafcsTuswMEqJcsbl4gx3hNQQKPmo6tI8lt9Eo1I2DAJxkyLOiEwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985488; c=relaxed/simple;
	bh=amoRD0d8bJ/7dPaqGBhYcBhuedEEvM42PqERJ3MQPSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reMGWEFvkeqJfzgFAj89HDPmLid/xWIKt1T+OgT/DeTSGD/wRniMIM+WTdIyoO9PgJP0bZi3RMz10M1AV22Hsyzkhjjt9753q8rxnhf4JXJGCZJZ/j4Q04BUU1mhHHxRLK4mSrdFRdG1f6yVVEvqnNueVahf9MdfV+maCjy6Gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOonnQkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CA5C32786;
	Sun, 18 Aug 2024 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985487;
	bh=amoRD0d8bJ/7dPaqGBhYcBhuedEEvM42PqERJ3MQPSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOonnQkRwbLhJdN89o1+DXgEpdvb0iNbe5GC1i+NAX3yQ63Jkp1JH82FhgSfYUygD
	 H9s60jqmdxO3ro1PqkoE3t66A5sWyEzIcj3c6Fj81dEktPjC8yRnxP4qNoP1BzUHwa
	 zluxk3lhGG9VpBMzO8AJyp0XRcsCzJD/gurFpEIsRQJ6VT0+c17cpJuUvIPl7rnWyo
	 SQKWGIJ+Cryb9dYrRIJ/tnSvPspD3oLOjzxWCIRr5iVc149XqqDQdD73myFGble3TB
	 qyviqvuC0Aj4puPG5FzgzAw9kYXRKrQHA0Gpj8znyL2dZxzuVFHxkawweNi2SgeBh0
	 He56kKP5NCvKw==
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
Subject: [PATCH v13 20/20] fgraph: Skip recording calltime/rettime if it is not nneeded
Date: Sun, 18 Aug 2024 21:51:22 +0900
Message-Id: <172398548220.293426.5389568053134223004.stgit@devnote2>
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

Skip recording calltime and rettime if the fgraph_ops does not need it.
This is a kind of performance optimization for fprobe. Since the fprobe
user does not use these entries, recording timestamp in fgraph is just
a overhead (e.g. eBPF, ftrace). So introduce the skip_timestamp flag,
and all fgraph_ops sets this flag, skip recording calltime and rettime.

Here is the performance results measured by
 tools/testing/selftests/bpf/benchs/run_bench_trigger.sh

Without this:
kprobe-multi   :    5.700 ± 0.065M/s
kretprobe-multi:    4.239 ± 0.006M/s

With skip-timestamp:
kprobe-multi   :    6.265 ± 0.033M/s	+9.91%
kretprobe-multi:    4.758 ± 0.009M/s	+12.24%

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v11:
  - Simplify it to be symmetric on push and pop. (Thus the timestamp
    getting place is a bit shifted.)
 Changes in v10:
  - Add likely() to skipping timestamp.
 Changes in v9:
  - Newly added.
---
 include/linux/ftrace.h |    2 ++
 kernel/trace/fgraph.c  |   36 +++++++++++++++++++++++++++++++++---
 kernel/trace/fprobe.c  |    1 +
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 63fb91088a23..bab6fabb3fa1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1160,6 +1160,8 @@ struct fgraph_ops {
 	void				*private;
 	trace_func_graph_ent_t		saved_func;
 	int				idx;
+	/* If skip_timestamp is true, this does not record timestamps. */
+	bool				skip_timestamp;
 };
 
 void *fgraph_reserve_data(int idx, int size_bytes);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 6a3e2db16aa4..c116a92839ae 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -174,6 +174,7 @@ int ftrace_graph_active;
 
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 static unsigned long fgraph_array_bitmask;
+static bool fgraph_skip_timestamp;
 
 /* LRU index table for fgraph_array */
 static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
@@ -557,7 +558,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 		return -EBUSY;
 	}
 
-	calltime = trace_clock_local();
+	/* This is not really 'likely' but for keeping the least path to be faster. */
+	if (likely(fgraph_skip_timestamp))
+		calltime = 0LL;
+	else
+		calltime = trace_clock_local();
 
 	offset = READ_ONCE(current->curr_ret_stack);
 	ret_stack = RET_STACK(current, offset);
@@ -728,6 +733,12 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	*ret = ret_stack->ret;
 	trace->func = ret_stack->func;
 	trace->calltime = ret_stack->calltime;
+	/* This is not really 'likely' but for keeping the least path to be faster. */
+	if (likely(!trace->calltime))
+		trace->rettime = 0LL;
+	else
+		trace->rettime = trace_clock_local();
+
 	trace->overrun = atomic_read(&current->trace_overrun);
 	trace->depth = current->curr_ret_depth;
 	/*
@@ -788,7 +799,6 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
@@ -1248,6 +1258,24 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	fgraph_direct_gops = &fgraph_stub;
 }
 
+static void update_fgraph_skip_timestamp(void)
+{
+	int i;
+
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
+		struct fgraph_ops *gops = fgraph_array[i];
+
+		if (gops == &fgraph_stub)
+			continue;
+
+		if (!gops->skip_timestamp) {
+			fgraph_skip_timestamp = false;
+			return;
+		}
+	}
+	fgraph_skip_timestamp = true;
+}
+
 int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
@@ -1271,6 +1299,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->idx = i;
 
 	ftrace_graph_active++;
+	update_fgraph_skip_timestamp();
 
 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);
@@ -1303,6 +1332,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		update_fgraph_skip_timestamp();
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -1326,8 +1356,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
-
 	ftrace_graph_active--;
+	update_fgraph_skip_timestamp();
 
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 5a0b4ef52fa7..b108d26d7ee5 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -345,6 +345,7 @@ NOKPROBE_SYMBOL(fprobe_return);
 static struct fgraph_ops fprobe_graph_ops = {
 	.entryfunc	= fprobe_entry,
 	.retfunc	= fprobe_return,
+	.skip_timestamp = true,
 };
 static int fprobe_graph_active;
 


