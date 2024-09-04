Return-Path: <bpf+bounces-38941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F496CAEC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B01B2158E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1769A1865F5;
	Wed,  4 Sep 2024 23:43:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722917C99B;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493406; cv=none; b=cfmBYE3W2xDfkBMX4JyXOzc552s95YPyHhq1lwudnSYfIFBHl6eybgkumKNLur+lYyz4GdtGJ3kZiu2m5n1ow+T5Tb9EHXjzXHtBpmCHyPSE2sIkyU0Ygjn8TFZDR9qYrkoXjz2k3QQZTN1S7Nqf5uIPVmP/CYK+2XsbAxCZ2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493406; c=relaxed/simple;
	bh=+WPVg+WaOEDJGm5/PXSMmD8jN2HQFBqGoZ67+9/Ors4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FWLGNZOI9AB855xIf0N0UQ+r6TE/XFatpQJDRtCqzwNcwuI+AuBtiDHswYdD050nDPT7W+2rYaPqdODxlTIlCbPDNPtAKpfwQWwZZvrgwOiOm6tH3tC0IT2Q6g/fOm2X+lRFoLVANyfLbE7667m+bUZOPj/XQpei/fqmZ+uEVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B27DC4CEC8;
	Wed,  4 Sep 2024 23:43:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slzfn-00000005BnR-39rT;
	Wed, 04 Sep 2024 19:44:27 -0400
Message-ID: <20240904234427.612375392@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 19:44:12 -0400
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
Subject: [for-linus][PATCH 1/6] tracing: fgraph: Fix to add new fgraph_ops to array after
 ftrace_startup_subops()
References: <20240904234411.443593140@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the register_ftrace_graph() assigns a new fgraph_ops to
fgraph_array before registring it by ftrace_startup_subops(), the new
fgraph_ops can be used in function_graph_enter().

In most cases, it is still OK because those fgraph_ops's hashtable is
already initialized by ftrace_set_filter*() etc.

But if a user registers a new fgraph_ops which does not initialize the
hash list, ftrace_ops_test() in function_graph_enter() causes a NULL
pointer dereference BUG because fgraph_ops->ops.func_hash is NULL.

This can be reproduced by the below commands because function profiler's
fgraph_ops does not initialize the hash list;

 # cd /sys/kernel/tracing
 # echo function_graph > current_tracer
 # echo 1 > function_profile_enabled

To fix this problem, add a new fgraph_ops to fgraph_array after
ftrace_startup_subops(). Thus, until the new fgraph_ops is initialized,
we will see fgraph_stub on the corresponding fgraph_array entry.

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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
Fixes: c132be2c4fcc ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d1d5ea2d0a1b..d7d4fb403f6f 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1206,18 +1206,24 @@ static void init_task_vars(int idx)
 	read_unlock(&tasklist_lock);
 }
 
-static void ftrace_graph_enable_direct(bool enable_branch)
+static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *gops)
 {
 	trace_func_graph_ent_t func = NULL;
 	trace_func_graph_ret_t retfunc = NULL;
 	int i;
 
-	for_each_set_bit(i, &fgraph_array_bitmask,
-			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
-		func = fgraph_array[i]->entryfunc;
-		retfunc = fgraph_array[i]->retfunc;
-		fgraph_direct_gops = fgraph_array[i];
-	 }
+	if (gops) {
+		func = gops->entryfunc;
+		retfunc = gops->retfunc;
+		fgraph_direct_gops = gops;
+	} else {
+		for_each_set_bit(i, &fgraph_array_bitmask,
+				 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
+			func = fgraph_array[i]->entryfunc;
+			retfunc = fgraph_array[i]->retfunc;
+			fgraph_direct_gops = fgraph_array[i];
+		}
+	}
 	if (WARN_ON_ONCE(!func))
 		return;
 
@@ -1256,8 +1262,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ret = -ENOSPC;
 		goto out;
 	}
-
-	fgraph_array[i] = gops;
 	gops->idx = i;
 
 	ftrace_graph_active++;
@@ -1266,7 +1270,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_disable_direct(true);
 
 	if (ftrace_graph_active == 1) {
-		ftrace_graph_enable_direct(false);
+		ftrace_graph_enable_direct(false, gops);
 		register_pm_notifier(&ftrace_suspend_notifier);
 		ret = start_graph_tracing();
 		if (ret)
@@ -1281,14 +1285,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	} else {
 		init_task_vars(gops->idx);
 	}
-
 	/* Always save the function, and reset at unregistering */
 	gops->saved_func = gops->entryfunc;
 
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
+	if (!ret)
+		fgraph_array[i] = gops;
+
 error:
 	if (ret) {
-		fgraph_array[i] = &fgraph_stub;
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
@@ -1324,7 +1329,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
 	if (ftrace_graph_active == 1)
-		ftrace_graph_enable_direct(true);
+		ftrace_graph_enable_direct(true, NULL);
 	else if (!ftrace_graph_active)
 		ftrace_graph_disable_direct(false);
 
-- 
2.43.0



