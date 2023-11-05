Return-Path: <bpf+bounces-14244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D37E1467
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9582B20DED
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64EC1401C;
	Sun,  5 Nov 2023 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijq8qE6a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC48F9DA;
	Sun,  5 Nov 2023 16:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C1C433C7;
	Sun,  5 Nov 2023 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200616;
	bh=/gBbJf7g1QrUiEN7ZPrz7W4ai3w02Yrm1jHvyS8561U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijq8qE6apP/3tEMc7xQNaT1ZgohMP5WaYkHJZJLjvfucgOnkq8r8tZKlMpnIaRzoG
	 iAgl0QVwW8FRbNaoPA/aBIVbNAp1IW7ANhQrFRRo6ITaqIvkVGnn7cnFDbwRuAtGX7
	 AGAMb81eNQdq7SI/g6khmRUvWkHaqrSTyUAkslVhM09Cqa/6UbPC35PM5SJQv8T0hm
	 2lD1u208cjdCKzkYrE75U/ZT1OpISl8GDOQuSp9HdwT171hfKZgk3GzG6+kDoNzaP6
	 b+v/jsTZnxYX4auQr1LcKkM0uowq0gHJyRNe/1l6yDnU1Ng7Z+kzrq1jNiLX6UcYx/
	 0BVdFt5sbwbJw==
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
Subject: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops for fgraph with ftrace_graph_func
Date: Mon,  6 Nov 2023 01:10:10 +0900
Message-Id: <169920060974.482486.15664806338999944098.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
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

Fix to initialize the ftrace_ops of fgraph_ops with ftrace_graph_func
instead of ftrace_stub.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 597250bd30dc..858fb73440ec 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -872,7 +872,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
-	dst_ops->func = ftrace_stub;
+	dst_ops->func = ftrace_graph_func;
 	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;
 
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
@@ -1120,7 +1120,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 
 	if (!gops->ops.func) {
 		gops->ops.flags |= FTRACE_OPS_FL_STUB;
-		gops->ops.func = ftrace_stub;
+		gops->ops.func = ftrace_graph_func;
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
 #endif


