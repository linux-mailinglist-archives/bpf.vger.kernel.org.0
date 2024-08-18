Return-Path: <bpf+bounces-37444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F0955C73
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792991F21554
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E1347B4;
	Sun, 18 Aug 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDTD+t6V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72100EEB9;
	Sun, 18 Aug 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985288; cv=none; b=n/J8qcR9+5akLQuRauRGIvmTwyCNMVsrOMy9RyebmD7cyuaT1rI+lUbong7o+vIfhYbDMj3uUwZGe4OuE1egOAqfSnpD9CpgIUCOHqCxYavtL1Ayb90VKIHxss7zcvsHgZ4omtEyhiCVdVCHYZLMYOLjXy0uSkj+f+9Sv9niLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985288; c=relaxed/simple;
	bh=xLlBDVht4zhad2g+4ndKTrS8bYN8KEMD4Ow1B9hlToI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buuJts9wLjD+RKFiYpiq+BM+RKLjJp/15ECb+815OUqjXJotvs9vj9D6r/6sURqZb/YbuS0NcpANxaYiG0mraXNZ7SX7AHggmy9VbVy4H5zbwdEOOvOOvm38t4F0z+lK9AobLhftQfHyZUeD1iqtiq/OssgJOzoxOCd8Ym+Hnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDTD+t6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7EDC32786;
	Sun, 18 Aug 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723985288;
	bh=xLlBDVht4zhad2g+4ndKTrS8bYN8KEMD4Ow1B9hlToI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDTD+t6VBe0vuV4YS1yoRYduS6V1DAQGaKw+94whS8pYsO80Yg5JO3Y9Oqc2lIcwr
	 FUtA9DHgH5jlyMWH/At6cJk53i4CG1VuqQTD0eqazjXzhqkZYC3F6WAPruh7kF4pAY
	 3qjCRio4OTs1Gtk7NtDR73+8q9TMUXyY2hj9m1hhC1FPBlgVUbAQm7T3jLIq8LzIJ6
	 Yf5pKY9q4l90S31niGYX+UyQaB9YtpkEaHsZv7BZyA5lLxFRinuyUo8zOk3vRfQT0a
	 0RwrdQulrGzXJNC++SDPQJf4NrwHAIyGgtrZC3yaGWBVrG9aYpvcE8vahjEJLziszS
	 tPGBfh2/2xEqQ==
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
Subject: [PATCH v13 01/20] tracing: fgraph: Fix to add new fgraph_ops to array after ftrace_startup_subops()
Date: Sun, 18 Aug 2024 21:48:03 +0900
Message-Id: <172398528350.293426.8347220120333730248.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172398527264.293426.2050093948411376857.stgit@devnote2>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
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

Fixes: c132be2c4fcc ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |   31 ++++++++++++++++++-------------
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
 


