Return-Path: <bpf+bounces-31314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D7E8FB5D7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D701C22266
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B361487EA;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C524145A1F;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512135; cv=none; b=dukI7NayS87twWgErfpBw51xmah/uRqnCbsIncDcyG0ZQyTE66DHVK1vJJyEtEjaivatcVabqwks2Yhg9r2oGEHx2YtYSp4fUz9vAx9ZNIFQaxH1dc9nRMcgk6GS8oayst6rX6h3kOWVmv79Jv+/nwOQRLQfKlFBOhALnGf6V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512135; c=relaxed/simple;
	bh=c9vm0JziVDoqmP/XAmZSco8JE8aUdkPgChYrMgrLdC8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PUjT0U6I5fWGlpymGyuIpdSfZI0ANQ8tOGp5w6i3tgKhD6ou0vS6IOIN2KceFhiL0g7uVHag9akOIrwTEmQxYZEMcxV1yyWW+zsCE8xsWis2xUkAfkDnJII/ThgBohODQXr37er3ibv6/ebhYm5/QnwDyImzQa6Pf6wNx8VePG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B18C32786;
	Tue,  4 Jun 2024 14:42:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMc-00000000Yvb-3oeR;
	Tue, 04 Jun 2024 10:42:14 -0400
Message-ID: <20240604144214.765821705@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
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
Subject: [for-next][PATCH 05/27] function_graph: Handle tail calls for stack unwinding
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

For the tail-call, there would be 2 or more ftrace_ret_stacks on the
ret_stack, which records "return_to_handler" as the return address except
for the last one.  But on the real stack, there should be 1 entry because
tail-call reuses the return address on the stack and jump to the next
function.

In ftrace_graph_ret_addr() that is used for stack unwinding, skip tail
calls as a real stack unwinder would do.

Link: https://lore.kernel.org/linux-trace-kernel/171509096221.162236.8806372072523195752.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190821.717065217@goodmis.org

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index aae51f746828..8de2a2662281 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -594,16 +594,26 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
 	int i = task->curr_ret_stack;
 
-	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+	if (ret != return_handler)
 		return ret;
 
 	while (i > 0) {
 		ret_stack = get_ret_stack(current, i, &i);
 		if (!ret_stack)
 			break;
-		if (ret_stack->retp == retp)
+		/*
+		 * For the tail-call, there would be 2 or more ftrace_ret_stacks on
+		 * the ret_stack, which records "return_to_handler" as the return
+		 * address except for the last one.
+		 * But on the real stack, there should be 1 entry because tail-call
+		 * reuses the return address on the stack and jump to the next function.
+		 * Thus we will continue to find real return address.
+		 */
+		if (ret_stack->retp == retp &&
+		    ret_stack->ret != return_handler)
 			return ret_stack->ret;
 	}
 
@@ -614,10 +624,11 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
 	struct ftrace_ret_stack *ret_stack;
+	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
 	int offset = task->curr_ret_stack;
 	int i;
 
-	if (ret != (unsigned long)dereference_kernel_function_descriptor(return_to_handler))
+	if (ret != return_handler)
 		return ret;
 
 	if (!idx)
@@ -626,6 +637,8 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 	i = *idx;
 	do {
 		ret_stack = get_ret_stack(task, offset, &offset);
+		if (ret_stack && ret_stack->ret == return_handler)
+			continue;
 		i--;
 	} while (i >= 0 && ret_stack);
 
-- 
2.43.0



