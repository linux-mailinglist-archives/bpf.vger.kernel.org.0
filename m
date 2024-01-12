Return-Path: <bpf+bounces-19431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1C82BE4B
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7444E2892EF
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C65EE60;
	Fri, 12 Jan 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFJJhyLl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B35EE63;
	Fri, 12 Jan 2024 10:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D80C433C7;
	Fri, 12 Jan 2024 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054423;
	bh=FIMtdTcBTgHmiwOg+KoDtODrD2ZwnJXD9R2kw/o70PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFJJhyLlEbCmFL5iiBzoiN08zvPigNZIxmTS3i9FdiP0m7QWbkGI5TRR7qejqQ88d
	 5+IPA+JeW39f6ZSd6x3vNAkJuVSVWTqYW7j/MkyQ0iDNINBJnNzzHemaSXVCvIoN9o
	 Cl9Kbe6Q0xQqObf7XKBruFTLmHpARd+n1sIlnEya0zzVA1jU1GdxZk91LRsAixqfiD
	 GULvJB6Q/OW+NVmGny3DLRMvVZmFtTgiGavA4Vb/ueQF2pPS4Ht+F5oj7vgMyVUHJs
	 sdyi+oHLyRa1z3Gli6zyZhruVfGsR6qs5lan4grZAWln9CepNl/KVHDHLdyTnthf2P
	 /7EOvpCa4gDhg==
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
Subject: [PATCH v6 14/36] function_graph: Use a simple LRU for fgraph_array index number
Date: Fri, 12 Jan 2024 19:13:37 +0900
Message-Id: <170505441697.459169.6267988498295951630.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170505424954.459169.10630626365737237288.stgit@devnote2>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
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
 Changes in v5:
  - Fix the underflow bug in fgraph_lru_release_index() and return 0
    if the release is succeded.
 Changes in v4:
  - Newly added.
---
 kernel/trace/fgraph.c |   67 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5724062846f7..ad4ea196b76e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -99,10 +99,44 @@ enum {
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
+static void fgraph_lru_init(void)
+{
+	int i;
+
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
+		fgraph_lru_table[i] = i;
+}
+
+static int fgraph_lru_release_index(int idx)
+{
+	if (idx < 0 || idx >= FGRAPH_ARRAY_SIZE ||
+	    fgraph_lru_table[fgraph_lru_last] != -1)
+		return -1;
+
+	fgraph_lru_table[fgraph_lru_last] = idx;
+	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
+	return 0;
+}
+
+static int fgraph_lru_alloc_index(void)
+{
+	int idx = fgraph_lru_table[fgraph_lru_next];
+
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
@@ -367,7 +401,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (index < 0)
 		goto out;
 
-	for (i = 0; i < fgraph_array_cnt; i++) {
+	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
 		struct fgraph_ops *gops = fgraph_array[i];
 
 		if (gops == &fgraph_stub)
@@ -935,21 +969,17 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
+	if (i < 0 ||
+	    WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
 		ret = -EBUSY;
 		goto out;
 	}
 
 	fgraph_array[i] = gops;
-	if (i + 1 > fgraph_array_cnt)
-		fgraph_array_cnt = i + 1;
 	gops->idx = i;
 
 	ftrace_graph_active++;
@@ -979,25 +1009,22 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
-	int i;
 
 	mutex_lock(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
 		goto out;
 
-	if (unlikely(gops->idx < 0 || gops->idx >= fgraph_array_cnt))
+	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE))
+		goto out;
+
+	if (WARN_ON_ONCE(fgraph_array[gops->idx] != gops))
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
 


