Return-Path: <bpf+bounces-19423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B107382BE36
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8641F2662C
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409CF5DF33;
	Fri, 12 Jan 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNHbNiB/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B85FF0D;
	Fri, 12 Jan 2024 10:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9E9C433C7;
	Fri, 12 Jan 2024 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705054327;
	bh=BJTb9S/48BMXgKg9JdebJFjIf4uCQaHDkO4DGbu+/d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNHbNiB/xSg/7ehU4MKZbWNtREQbJVpwYTkt3lrjrf9jZ/RGJgfpwJYwNNGQQz0tv
	 OcBZQpGkcvYEDgRzYy7m/aYTaSC2aCJbQmy/Fu17w12A3t01/lcABpnPXCN8/u82Ld
	 fK/gfmREyDHlo6WpgUbIRTTcFRZK39T4IQ6hI+Iw+2Lcc1oKpDOZR0Q6OMinpglSmA
	 efv2X9NjXZ5HOUZZzrPrU1iiq2TXs7j+YGVydXLAKXnzP6bs40mAYqRa+e/pa2wTDG
	 O+RftnN4z83jMnNxuw5cGMrZbcW3I/C1B44oMNOPLYRre/Z7cuNKOARteHrRm0wxSf
	 csl00e7pnRNGA==
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
Subject: [PATCH v6 06/36] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
Date: Fri, 12 Jan 2024 19:12:01 +0900
Message-Id: <170505432176.459169.10224406939710504027.stgit@devnote2>
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


