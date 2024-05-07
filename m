Return-Path: <bpf+bounces-28850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D681B8BE558
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FF81C23FAC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1316190C;
	Tue,  7 May 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nds1pTYM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73615FA7E;
	Tue,  7 May 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091039; cv=none; b=YGq/UQE8SvkXPxMszyJ8MhwMdAXPe4w4vu4pwQ4d7m+iwfsWjGuDQm2tihNWVp2domYD+D8hadI0D1s9Fgm5lSxFPzlG0JfNrGkWacp6DDlNz82yn1ksmD2l3vagGnCsMOXDZk5+D11NeUdVW3y3T7M7G57fG2XpXSz6v/aQWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091039; c=relaxed/simple;
	bh=5nInqF9qURKOZ0esvHEpkoi/4RvEUChykR3zq5VSXc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAGJ0c7x+CrOPgnwjCwRf84fZjYqfpLrkFzQvSA46B+JpDjb8MaCf2sU3B2gteBNwbJzJ9RMm/G/cxrLChyP3D6tsujteWplEGhtGV8rY+IPHnoL5R/sBymP5ceDbLs3LN8MOcGmJnXavsUCnBnKxxwLBK7kQpUh3B/YXNrOgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nds1pTYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FD5C2BBFC;
	Tue,  7 May 2024 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091038;
	bh=5nInqF9qURKOZ0esvHEpkoi/4RvEUChykR3zq5VSXc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nds1pTYMbVbld+y7/r7Hsscs1PhGVez7VFIpNH81TAeYGbWCyn9tiuIMN43leBNO7
	 Tzjvl9kzmQTllGluctP7eyAGibYkOD5ALCyr4YsFDvlGE9+yDKbQbFJx0R8qMDJVba
	 QIO9kpuACGUUPaXJETN5e4QpSeCy6jMzm7g2Me2Y5+O0c1u13B3pxlhYyPKBpKcF4N
	 p45JB4dG3xKgIzj5nb6NJscy+A135DIM1VuG3lDNd7k+5FFG4LFxsIAUB0xfdZ7Uca
	 373pdQd9j5x0WAZdD6qVGSkgSofNB9/KfCU/IefiAl+RXutcKaujfPWG+xrSRuGttG
	 SpMbPEBVMgTLQ==
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
Subject: [PATCH v10 13/36] function_graph: Use a simple LRU for fgraph_array index number
Date: Tue,  7 May 2024 23:10:32 +0900
Message-Id: <171509103267.162236.6885097397289135378.stgit@devnote2>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the fgraph_array index is used for the bitmap on the shadow
stack, it may leave some entries after a function_graph instance is
removed. Thus if another instance reuses the fgraph_array index soon
after releasing it, the fgraph may confuse to call the newer callback
for the entries which are pushed by the older instance.
To avoid reusing the fgraph_array index soon after releasing, introduce
a simple LRU table for managing the index number. This will reduce the
possibility of this confusion.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Add a WARN_ON_ONCE() if fgraph_lru_table[] is broken when releasing
    index, and remove WARN_ON_ONCE() from unregister_ftrace_graph()
  - Fix to release allocated index if register_ftrace_graph() fails.
  - Add comments and code cleanup.
 Changes in v5:
  - Fix the underflow bug in fgraph_lru_release_index() and return 0
    if the release is succeded.
 Changes in v4:
  - Newly added.
---
 kernel/trace/fgraph.c |   71 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index b6949e4fda79..c00a299decb1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -97,10 +97,48 @@ enum {
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
 static inline int get_frame_offset(struct task_struct *t, int offset)
 {
 	return t->ret_stack[offset] & FGRAPH_FRAME_OFFSET_MASK;
@@ -365,7 +403,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (offset < 0)
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++) {
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
 		if (gops == &fgraph_stub)
@@ -917,7 +955,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
@@ -971,6 +1004,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	if (ret) {
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
+		fgraph_lru_release_index(i);
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -980,25 +1014,20 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
 


