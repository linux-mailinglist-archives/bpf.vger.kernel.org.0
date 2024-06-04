Return-Path: <bpf+bounces-31336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94868FB5FF
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5D01C24F33
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292EC14B949;
	Tue,  4 Jun 2024 14:42:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87914B07A;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512140; cv=none; b=pjuQoygkiThCidezu3OdRNfEJZdyaEVkJrsuCSXpdM4+CsvspQLp4Fw6dAhXrePe3g5LMianro8Q+RfTIP/kRNsqfxqhR2tQEyXZxF32sG4rwekq0Z/ZKPm9cRVEtJDlFqgxtAvMLGv6hdrvLFdyDHkAOfdetg84L3hg3Jjxcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512140; c=relaxed/simple;
	bh=395fk8BtpJ1/aVzTVpOcPZBJz0c012Ont4Ro29hIzqw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kxy/Tw4DSbmO5YNvR1ThR8Wp856z0Q1lBelPBDu0dHiKpBdu4OBGSLHorkMgjEnM3MbYK+fEplICI2KMtrrCLri5hUOwEoKI+e9Xsnfw7FGFUUjlYUgAOLOLIHssQNlVVBFCFuxqzWxGqIbAOvcuPtv7O+81/lc5/AI1QV87d0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15406C4AF10;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMg-00000000Z5V-0ajs;
	Tue, 04 Jun 2024 10:42:18 -0400
Message-ID: <20240604144218.003617145@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:28 -0400
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
Subject: [for-next][PATCH 25/27] function_graph: Use static_call and branch to optimize return
 function
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In most cases function graph is used by a single user. Instead of calling
a loop to call function graph callbacks in this case, call the function
return callback directly.

Use the static_key that is set when the function graph tracer has less
than 2 callbacks registered. It will do the direct call in that case, and
will do the loop over all callers when there are 2 or more callbacks
registered.

Link: https://lore.kernel.org/linux-trace-kernel/20240603190824.921460797@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7c3b0261b1bb..4bf91eebbb08 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -514,6 +514,7 @@ static struct fgraph_ops fgraph_stub = {
 
 static struct fgraph_ops *fgraph_direct_gops = &fgraph_stub;
 DEFINE_STATIC_CALL(fgraph_func, ftrace_graph_entry_stub);
+DEFINE_STATIC_CALL(fgraph_retfunc, ftrace_graph_ret_stub);
 DEFINE_STATIC_KEY_TRUE(fgraph_do_direct);
 
 /**
@@ -808,13 +809,21 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 
 	bitmap = get_bitmap_bits(current, offset);
 
-	for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
-		struct fgraph_ops *gops = fgraph_array[i];
+#ifdef CONFIG_HAVE_STATIC_CALL
+	if (static_branch_likely(&fgraph_do_direct)) {
+		if (test_bit(fgraph_direct_gops->idx, &bitmap))
+			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops);
+	} else
+#endif
+	{
+		for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
+			struct fgraph_ops *gops = fgraph_array[i];
 
-		if (gops == &fgraph_stub)
-			continue;
+			if (gops == &fgraph_stub)
+				continue;
 
-		gops->retfunc(&trace, gops);
+			gops->retfunc(&trace, gops);
+		}
 	}
 
 	/*
@@ -1232,17 +1241,20 @@ static void init_task_vars(int idx)
 static void ftrace_graph_enable_direct(bool enable_branch)
 {
 	trace_func_graph_ent_t func = NULL;
+	trace_func_graph_ret_t retfunc = NULL;
 	int i;
 
 	for_each_set_bit(i, &fgraph_array_bitmask,
 			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
 		func = fgraph_array[i]->entryfunc;
+		retfunc = fgraph_array[i]->retfunc;
 		fgraph_direct_gops = fgraph_array[i];
 	 }
 	if (WARN_ON_ONCE(!func))
 		return;
 
 	static_call_update(fgraph_func, func);
+	static_call_update(fgraph_retfunc, retfunc);
 	if (enable_branch)
 		static_branch_disable(&fgraph_do_direct);
 }
@@ -1252,6 +1264,7 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	if (disable_branch)
 		static_branch_disable(&fgraph_do_direct);
 	static_call_update(fgraph_func, ftrace_graph_entry_stub);
+	static_call_update(fgraph_retfunc, ftrace_graph_ret_stub);
 	fgraph_direct_gops = &fgraph_stub;
 }
 
-- 
2.43.0



