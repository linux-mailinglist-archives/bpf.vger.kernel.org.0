Return-Path: <bpf+bounces-31112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D450D8D7345
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2871F21761
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131610A1C;
	Sun,  2 Jun 2024 03:37:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE421173F;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299444; cv=none; b=U2CssKSem4O4+B9+Ny0Wf0bS0FIc+vxe4ZW24Ba6NAPJpPIRqzG/RuEkDRrZQagyepp6+2ffDN1LVkerfwXNNVCaqaOH8jmVeMExYNW3Hui+uOuL3VKvhfqJp/5MtwMZC28HWCkrbkmvb8WYQz+ofPjnhIcN5w6TY8r0VxDM47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299444; c=relaxed/simple;
	bh=9lgCYOF+tkC1R4x/Mh3CLz0Erih4ZZSea1s6G/+5Llo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cpuEfqD4giBrVUVcVN5OtxO0t++wbo234K0B/ItZw3tlPa2ATJklDf4vn5qwjQI/PemH6/rlaf4i/GE/Y9c+77l0MuXnzYkyeycuMQJuqPDaQaDiA7opQCEQygjKgdjbkajrUr+6qItVJxZVdca5jFZfjE7HJw5w0zrcaYBgovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C0FC4AF0D;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3D-000000094K0-2Ieq;
	Sat, 01 Jun 2024 23:38:31 -0400
Message-ID: <20240602033831.407508591@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:46 -0400
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
Subject: [PATCH v2 02/27] fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible
 by long
References: <20240602033744.563858532@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of using "ALIGN()", use BUILD_BUG_ON() as the structures should
always be divisible by sizeof(long).

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509093949.162236.14518699447151894536.stgit@devnote2
Link: http://lkml.kernel.org/r/20190524111144.GI2589@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c62e6db718a0..fdb206aeffe3 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -33,7 +33,7 @@
  * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
  */
 #define FGRAPH_FRAME_SIZE	sizeof(struct ftrace_ret_stack)
-#define FGRAPH_FRAME_OFFSET	(ALIGN(FGRAPH_FRAME_SIZE, sizeof(long)) / sizeof(long))
+#define FGRAPH_FRAME_OFFSET	DIV_ROUND_UP(FGRAPH_FRAME_SIZE, sizeof(long))
 #define SHADOW_STACK_SIZE (PAGE_SIZE)
 #define SHADOW_STACK_OFFSET			\
 	(ALIGN(SHADOW_STACK_SIZE, sizeof(long)) / sizeof(long))
@@ -103,6 +103,8 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
+	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
+
 	/*
 	 * We must make sure the ret_stack is tested before we read
 	 * anything else.
@@ -326,6 +328,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
 	int index = task->curr_ret_stack;
 
+	BUILD_BUG_ON(FGRAPH_FRAME_SIZE % sizeof(long));
+
 	index -= FGRAPH_FRAME_OFFSET * (idx + 1);
 	if (index < 0)
 		return NULL;
-- 
2.43.0



