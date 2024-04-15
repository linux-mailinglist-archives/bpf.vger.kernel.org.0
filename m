Return-Path: <bpf+bounces-26785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BD8A5063
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A61E1C21D52
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6078C7A;
	Mon, 15 Apr 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQqrKs+S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158C73163;
	Mon, 15 Apr 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185498; cv=none; b=NC+xLbwiHwiWHL9AZUNW8lGUnYOSWyH9CLu3iYyUX6458Se3efMz8tkB82kqiNwO8lFitvXc7NzlgUFNAPlshC+ODot4pfzeDj9dq5q+s8nRY92MyokNDl33xl9otYPcUR+oXVjiIbB9+eFf5Mm3nTz1fYdQTi3o7ePYt2yqHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185498; c=relaxed/simple;
	bh=cyQB+nzI5io0btkPERC0oL8fWVahvmm7TT6YJby8cHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6M+TPjyUiHP6+2MSPcBqgxsLa45UwWgVy8d+7w4k9FuiQdJJTviZbsuZpKLS3RsMmDjoItQrp9CFf1yhdvyZlkKOu5FIeC4mjOPmRD7wb5DlThZIsV8LLx8mvRs4if/FpFtIlHSsxFG+NKQVlv3j0E85M6jE3jXV/SCJslG6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQqrKs+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55D8C113CC;
	Mon, 15 Apr 2024 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185497;
	bh=cyQB+nzI5io0btkPERC0oL8fWVahvmm7TT6YJby8cHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQqrKs+SbPbRPha33MJYfsS8cYh/JNlWDMr+fuApxnjLWlu35hVX3FRwI/DeFj3Lr
	 k6gOuFT2c6Y8aLC1XohddWJPGvo4hIN3eVdGeukJlWatSyjI03kqho0MKeHY/8zEWo
	 CoSyxY0UqxuX63R+xsR+CExVduBw2qHwmDKj5RzMuJ4L3qyZjXDdCpYPxlaK0cWeYP
	 qbp+92nJndHb0JldG10xxahYZJ2fBz7gnS90TEllHuCHJA78qMmmqJmWFc3X5sEckN
	 uYxhWg5vDzXghuoLPQp/lB8W1w68AAHRAToGi7U2Wff1DY2VdfasnwpAm1l/khhsLI
	 zvAdmJx1xQC7Q==
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
Subject: [PATCH v9 13/36] function_graph: Use a simple LRU for fgraph_array index number
Date: Mon, 15 Apr 2024 21:51:31 +0900
Message-Id: <171318549135.254850.10548833007838101346.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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
index aa9a4fac3373..7e73bc3eab8b 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -99,10 +99,48 @@ enum {
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
 static inline int get_ret_stack_index(struct task_struct *t, int offset)
 {
 	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
@@ -367,7 +405,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (index < 0)
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++) {
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
 		if (gops == &fgraph_stub)
@@ -919,7 +957,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 	int ret = 0;
-	int i;
+	int i = -1;
 
 	mutex_lock(&ftrace_lock);
 
@@ -935,21 +973,16 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
@@ -973,6 +1006,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	if (ret) {
 		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
+		fgraph_lru_release_index(i);
 	}
 out:
 	mutex_unlock(&ftrace_lock);
@@ -982,25 +1016,20 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
 


