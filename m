Return-Path: <bpf+bounces-32263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00F90A20F
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 03:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3681F248A9
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56CA17F4E7;
	Mon, 17 Jun 2024 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw6QVtQR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8212FF6A;
	Mon, 17 Jun 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589003; cv=none; b=goj5RzJT+uNtZMLdDhcITQDJld6uI7M8wTUhRLKcEBphz2p0knQ4Ca5n2MDiJZA3EnS+dQau9S2iE3OEDHLs5a0BsghXn7lZWIMgGfFq20l3AET3sPUFC5BmP3fqutCfNRea23XSq3UqYTPBTkMXoTv0utNcusagc8JGimH8PeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589003; c=relaxed/simple;
	bh=NheZlQukXrHe+aAqSQt20W9ihRV2X4255gLoqcg7brw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpRSLUcuZ8bCIMQXpV9cZopsvm9ean1BFHDzfkRwg7yO2qSe550XnWYgvtyWb/o2NnVrOCA5x0PIuIMkk5WHDjJLIELhIU0MR8+tufcyuWM48+Qx4F8RKf0T2RlQN1XZ4sJyCN4syfpLeMXN3Y6hvmAoiHA1P/CR44rLO39RRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw6QVtQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BF3C2BBFC;
	Mon, 17 Jun 2024 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718589002;
	bh=NheZlQukXrHe+aAqSQt20W9ihRV2X4255gLoqcg7brw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nw6QVtQRaoS4WUF3g1P6l1m+RA1PnZV72WOfiuhHMQp2RepZEjWMZ+p+eLz3++27w
	 wp8bfJ4EYJ7in0idip8Tj0CEV9qQQUwogJV7/T6iPOji2mfuLz2CW93nEojZU0B0OJ
	 JCkzRoSzxyVPinmUibxs3zSKwj+ws10ssP3n0YxfG6bZ+HIqkn9MTBrX5H9+NVR6mz
	 1lzMfJAwoufluGbRrI0tYSOMO5mwR/sirD7eTz+m65rZD8nEudr9pBAOEp6l6UyOV7
	 SS1fAcSvHirzNREvkPr2e8rXB8uaGhn1Ae/nZVHrHDsSBSuCTwJN93DxMd1t/vn9kK
	 BcVx7Bnwhq5uA==
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
Subject: [PATCH v11 18/18] fgraph: Skip recording calltime/rettime if it is not nneeded
Date: Mon, 17 Jun 2024 10:49:56 +0900
Message-Id: <171858899671.288820.1294786279157013093.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171858878797.288820.237119113242007537.stgit@devnote2>
References: <171858878797.288820.237119113242007537.stgit@devnote2>
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
index d8a58b940d81..fabf1a0979d4 100644
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
index d735a8c872bb..cf3ae59a436e 100644
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
 
@@ -1242,6 +1252,24 @@ static void ftrace_graph_disable_direct(bool disable_branch)
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
@@ -1267,6 +1295,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->idx = i;
 
 	ftrace_graph_active++;
+	update_fgraph_skip_timestamp();
 
 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);
@@ -1298,6 +1327,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		update_fgraph_skip_timestamp();
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -1321,8 +1351,8 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
-
 	ftrace_graph_active--;
+	update_fgraph_skip_timestamp();
 
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index afa52d9816cf..24bb8edec8a3 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -345,6 +345,7 @@ NOKPROBE_SYMBOL(fprobe_return);
 static struct fgraph_ops fprobe_graph_ops = {
 	.entryfunc	= fprobe_entry,
 	.retfunc	= fprobe_return,
+	.skip_timestamp = true,
 };
 static int fprobe_graph_active;
 


