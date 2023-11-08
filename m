Return-Path: <bpf+bounces-14487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB407E58AF
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069AC1C20B4F
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E31A28E;
	Wed,  8 Nov 2023 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acy4qeR6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D810A15;
	Wed,  8 Nov 2023 14:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C151CC433C7;
	Wed,  8 Nov 2023 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453524;
	bh=BJTb9S/48BMXgKg9JdebJFjIf4uCQaHDkO4DGbu+/d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Acy4qeR6BmcEQIGzPtHgOgB0gKQWzzYs3q3oYarlZc076haMeyyfEC9YzRmimIDDw
	 yChtK1EyyMO6JJfs7T5C5Xd/g8i5c+LZbJ8fGQSEh2ueMA5xbuTdT+8Q1usaEPA30/
	 G7/8A+L1F+jJhYu00RzU545pcHZRXIyNPk5TXUYTlkHq1wIU+E1nBN1RcppKb+Xv2K
	 DbVJnnTZSm+IYeZ9ma/6stb7jIlu0aPS6dBQnRRSkmDZ0z9PYwYumtdzCNQfJWNRCb
	 KQvpIIGZqeK8rfyHkvBoYageUDVVhi9f0hf1CZYG6ZKZUza1IK1VJIc58YW20EqeRU
	 2NUTsAG4iorNQ==
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
Subject: [RFC PATCH v2 05/31] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
Date: Wed,  8 Nov 2023 23:25:18 +0900
Message-Id: <169945351784.55307.8993860437930966865.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
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
 kernel/trace/fgraph.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 30edeb6d4aa9..837daf929d2a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -26,10 +26,9 @@
 #endif
 
 #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
-#define FGRAPH_RET_INDEX (ALIGN(FGRAPH_RET_SIZE, sizeof(long)) / sizeof(long))
+#define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
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


