Return-Path: <bpf+bounces-31240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26D8D897A
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61FA1F25738
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6C513D289;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6F13C9D0;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=eZaojl70b/HkKBT0MUzSS2viS5vrTmRPux5uQ0Ee4RY07OZ3RG7YLS+DPQFrfgHC9ZeamkkqeMTKj1uJBLQ/4hNy/OXhm6tiRlZQF9MUCfUPCCgNxKMKIXKKFdUiO2Z+0GPhYr+oiDiE7oua2T4VMlEMO7DWGMADZPnQxFMNhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=9LpGl/CYTHJuPvy0Cg8mag2iEBwvUFaJNUn1Vi1Mfk8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=U2z9fpcybj7gDCiwj1xcG/A0xprKnh/7RsUW2Fo5xy23bqVSSfTw/BQII0WEbcBdg9xgW3PZZ1Cu7HrTb6FhOZ0VU6EB/maNNBvU/mx4nmz/Yf+mO0hzIM6lqybdJ6bEhxXMcfgKt8APLLkzQdD7dP9hMY5W2Qxpfib3zHsR2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD7EC4AF55;
	Mon,  3 Jun 2024 19:07:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2d-00000009Tsw-1DHN;
	Mon, 03 Jun 2024 15:08:23 -0400
Message-ID: <20240603190823.147421545@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:18 -0400
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
Subject: [PATCH v3 14/27] function_graph: Use a simple LRU for fgraph_array index number
References: <20240603190704.663840775@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the fgraph_array index is used for the bitmap on the shadow
stack, it may leave some entries after a function_graph instance is
removed. Thus if another instance reuses the fgraph_array index soon
after releasing it, the fgraph may confuse to call the newer callback
for the entries which are pushed by the older instance.
To avoid reusing the fgraph_array index soon after releasing, introduce
a simple LRU table for managing the index number. This will reduce the
possibility of this confusion.

Link: https://lore.kernel.org/linux-trace-kernel/171509103267.162236.6885097397289135378.stgit@devnote2

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 71 ++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30bed20c655f..7fd9b03bd170 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -124,10 +124,48 @@ enum {
 DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
 int ftrace_graph_active;
 
-static int fgraph_array_cnt;
-
 static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
 
+/* LRU index table for fgraph_array */
+static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
+static int fgraph_lru_next;
+static int fgraph_lru_last;
+
+/* Initialize fgraph_lru_table with unused index */
+static void fgraph_lru_init(void)
+{
+	int i;
+
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
+		fgraph_lru_table[i] = i;
+}
+
+/* Release the used index to the LRU table */
+static int fgraph_lru_release_index(int idx)
+{
+	if (idx < 0 || idx >= FGRAPH_ARRAY_SIZE ||
+	    WARN_ON_ONCE(fgraph_lru_table[fgraph_lru_last] != -1))
+		return -1;
+
+	fgraph_lru_table[fgraph_lru_last] = idx;
+	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
+	return 0;
+}
+
+/* Allocate a new index from LRU table */
+static int fgraph_lru_alloc_index(void)
+{
+	int idx = fgraph_lru_table[fgraph_lru_next];
+
+	/* No id is available */
+	if (idx == -1)
+		return -1;
+
+	fgraph_lru_table[fgraph_lru_next] = -1;
+	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
+	return idx;
+}
+
 /* Get the FRAME_OFFSET from the word from the @offset on ret_stack */
 static inline int get_frame_offset(struct task_struct *t, int offset)
 {
@@ -374,7 +412,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++) {
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
 		if (gops == &fgraph_stub)
@@ -925,7 +963,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 	int ret = 0;
-	int i;
+	int i = -1;
 
 	mutex_lock(&ftrace_lock);
 
@@ -933,21 +971,16 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		/* The array must always have real data on it */
 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
 			fgraph_array[i] = &fgraph_stub;
+		fgraph_lru_init();
 	}
 
-	/* Look for an available spot */
-	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
-		if (fgraph_array[i] == &fgraph_stub)
-			break;
-	}
-	if (i >= FGRAPH_ARRAY_SIZE) {
+	i = fgraph_lru_alloc_index();
+	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
 		ret = -ENOSPC;
 		goto out;
 	}
 
 	fgraph_array[i] = gops;
-	if (i + 1 > fgraph_array_cnt)
-		fgraph_array_cnt = i + 1;
 	gops->idx = i;
 
 	ftrace_graph_active++;
@@ -975,6 +1008,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
+		fgraph_lru_release_index(i);
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -984,25 +1018,20 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
-	int i;
 
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	if (unlikely(gops->idx < 0 || gops->idx >= fgraph_array_cnt))
+	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
+		     fgraph_array[gops->idx] != gops))
 		goto out;
 
-	WARN_ON_ONCE(fgraph_array[gops->idx] != gops);
+	if (fgraph_lru_release_index(gops->idx) < 0)
+		goto out;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
-	if (gops->idx + 1 == fgraph_array_cnt) {
-		i = gops->idx;
-		while (i >= 0 && fgraph_array[i] == &fgraph_stub)
-			i--;
-		fgraph_array_cnt = i + 1;
-	}
 
 	ftrace_graph_active--;
 
-- 
2.43.0



