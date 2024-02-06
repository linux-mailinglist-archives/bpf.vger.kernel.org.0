Return-Path: <bpf+bounces-21318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B14884B8E2
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EF6289D33
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B388134CD1;
	Tue,  6 Feb 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQnVhub6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CE134CC2;
	Tue,  6 Feb 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232122; cv=none; b=g7IOv0L98FYjR93FZS7NdLHeWHoOnK5irUzvrPoX4rxiZ3lgtp3pJPwaKecuyA/WcvBclx15QlyBXXmej18HbswFf98zYRk8E++Z+LhncNwyCqzPtJFl/diJP/Yar0N5fLraSTTZChshfg3pex7s9yDEM9jmhgXq9ci19H0FGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232122; c=relaxed/simple;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxYrAgHFY/XMTShB4tEbeYzU5CCJqiRfSElOu7FEficjBzOUaSOcnRW1kITOo6Hg8BWW+4FGAIBdW4ca1q/a7hXYf+1iVhjJbj3H7pn9Yeq5E3jGIMb5axo40tE1EJTw4G9NgeCyPbFJ+Sqk3eVqkODon3fHgdURsIeITw3emk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQnVhub6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9719CC43390;
	Tue,  6 Feb 2024 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232122;
	bh=v6a8A4n/NQNVvl6IUBlyb4ncY6wKsPnocwxI4QmL7G4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQnVhub6V+x9VzaS4J+qqX7sfnUSbbornWCaLcO3hsFS+ImOvdng9znvsrF0imNj2
	 A4VKH1ng2FtNeyUZxdr822jTEUVpGZUQQfzbgMA5A8G+qJNI356PCOTZAn7wLasmub
	 h4gGripv/GYAmh1BJrnI9JTIARJQZ9XwBx6Z3GCZf8eBxHnk1voVrESy+g6Y8Vqvdg
	 pQe1DGQEi2UAaOKC4z4Hzsw5Ob72m2R8dTNqqlEfwKHea11gbf5hM5iArPtJKK+vfX
	 9kvl2G0FyEUVJYUjKRDEdBQ2a1fenhSY79OpQcp6kQUXLMlZBiRmjGUi6ztJ9xmlKd
	 SQ30nxW1lKKqw==
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
Subject: [PATCH v7 06/36] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
Date: Wed,  7 Feb 2024 00:08:36 +0900
Message-Id: <170723211649.502590.2604541564082439754.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170723204881.502590.11906735097521170661.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
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

Instead of using "ALIGN()", use BUILD_BUG_ON() as the structures should
always be divisible by sizeof(long).

Link: http://lkml.kernel.org/r/20190524111144.GI2589@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v7:
  - Use DIV_ROUND_UP() to calculate FGRAPH_RET_INDEX
---
 kernel/trace/fgraph.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30edeb6d4aa9..6f8d36370994 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -26,10 +26,9 @@
 #endif
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
-#define SHADOW_STACK_INDEX			\
-	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
+#define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
 
@@ -91,6 +90,8 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
+
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
@@ -325,6 +326,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
 	int index = task->curr_ret_stack;
 
+	BUILD_BUG_ON(FGRAPH_RET_SIZE % sizeof(long));
+
 	index -= FGRAPH_RET_INDEX * (idx + 1);
 	if (index < 0)
 		return NULL;


