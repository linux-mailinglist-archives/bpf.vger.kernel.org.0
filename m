Return-Path: <bpf+bounces-52586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CEA4501E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA513B4D9E
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFA219319;
	Tue, 25 Feb 2025 22:26:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D98215F44;
	Tue, 25 Feb 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522375; cv=none; b=YVD3vMIMQNMkcPK1warUUIdAGK8gV9+ccEoDivr3XGy8wixpuCUd6csuHHj53FRAAfowTY9mTLbO0ii3QzWwewB/ZoSKdnJ8HlVO5tYiwRLvtVO42tGAh/xICnGAv4iEtXnGlEpCR9f0vMoYCBIZgkCiTrVjpsFrqNVSx7WZS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522375; c=relaxed/simple;
	bh=V6yqo14s8VZnghlNKFkP7GDMB8LaMpi+LaJvcGP8TW8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VSEme1+mvK/y3nL+8JnyxdTmDExFKHclpJjLD5HX5GNmwkinj8Ns6zid6mBNnhWUhgDtnIoTVLRa1wQ86kMlmi4QzVxPKZ9ZLr5COSa/GgJHa+ZeMyfUyBKGOzf4nBcQnhroZTvRqDaV6IwOOQqtJE3qh7KYjp4DCtmy4F5wTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F94DC4CEEE;
	Tue, 25 Feb 2025 22:26:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tn3OA-00000009CJg-0CN1;
	Tue, 25 Feb 2025 17:26:54 -0500
Message-ID: <20250225222653.895547257@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 17:26:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 Donglin Peng <dolinux.peng@gmail.com>,
 Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: [PATCH v3 3/4] ftrace: Have funcgraph-args take affect during tracing
References: <20250225222601.423129938@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently, when function_graph is started, it looks at the option
funcgraph-args, and if it is set, it will enable tracing of the arguments.

But if tracing is already running, and the user enables funcgraph-args, it
will have no effect. Instead, it should enable argument tracing when it is
enabled, even if it means disabling the function graph tracing for a short
time in order to do the transition.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Guo Ren <guoren@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>
Link: https://lore.kernel.org/20241223201542.240760965@goodmis.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 406b21472bde..49fcf665cb58 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -462,7 +462,7 @@ static int graph_trace_init(struct trace_array *tr)
 	else
 		tr->gops->retfunc = trace_graph_return;
 
-	/* Make gops functions are visible before we start tracing */
+	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
 	ret = register_ftrace_graph(tr->gops);
@@ -473,6 +473,28 @@ static int graph_trace_init(struct trace_array *tr)
 	return 0;
 }
 
+static int ftrace_graph_trace_args(struct trace_array *tr, int set)
+{
+	trace_func_graph_ent_t entry;
+
+	if (set)
+		entry = trace_graph_entry_args;
+	else
+		entry = trace_graph_entry;
+
+	/* See if there's any changes */
+	if (tr->gops->entryfunc == entry)
+		return 0;
+
+	unregister_ftrace_graph(tr->gops);
+
+	tr->gops->entryfunc = entry;
+
+	/* Make gops functions visible before we start tracing */
+	smp_mb();
+	return register_ftrace_graph(tr->gops);
+}
+
 static void graph_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_cmdline_record();
@@ -1605,6 +1627,9 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (bit == TRACE_GRAPH_GRAPH_TIME)
 		ftrace_graph_graph_time_control(set);
 
+	if (bit == TRACE_GRAPH_ARGS)
+		return ftrace_graph_trace_args(tr, set);
+
 	return 0;
 }
 
-- 
2.47.2



