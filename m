Return-Path: <bpf+bounces-47556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D79FB510
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E051885204
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502811D63DE;
	Mon, 23 Dec 2024 20:14:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EE1D4610;
	Mon, 23 Dec 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984890; cv=none; b=lQeNO/5mg7EO2cKvt1cagqHgjtmondlcIlLlIHlqU/xFQZ15QJV2PyZxcoVF9fBDUzQHswW7yvRIusLfM/9+aPHI/BJT+RyUOdzigy+hM4Kk19xomjxEFM64oaI2vqjbum1PYNk9wzGFlFi2n40C9qleul9v66fzlKs9emawCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984890; c=relaxed/simple;
	bh=aioXTzNoufIGKq8lGq2O+Xy3xmBkovxOiAm5ccPP91s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gcNpaW0nAT58Qjf/Z2N0i2QVzkkse9S7FZhXoyVRsLrR2loP33zvS4qwiToESKpJ12nKkfT0+DDp1ys6WOgR/JPSv4K+vNUw0uoQO0npowEVW3bLhi/CXuVWgggJvgEb9FFAKwnVdNTDivv28qGwLnhMlnOONLjA0V5/xeIVkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2EAC4CEE2;
	Mon, 23 Dec 2024 20:14:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tPoq6-0000000Dg9p-1fXj;
	Mon, 23 Dec 2024 15:15:42 -0500
Message-ID: <20241223201542.240760965@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 23 Dec 2024 15:13:50 -0500
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
Subject: [PATCH v2 3/4] ftrace: Have funcgraph-args take affect during tracing
References: <20241223201347.609298489@goodmis.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c8eda9bebdf4..d1ee001f5a8e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -469,7 +469,7 @@ static int graph_trace_init(struct trace_array *tr)
 	else
 		tr->gops->retfunc = trace_graph_return;
 
-	/* Make gops functions are visible before we start tracing */
+	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
 	ret = register_ftrace_graph(tr->gops);
@@ -480,6 +480,28 @@ static int graph_trace_init(struct trace_array *tr)
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
@@ -1609,6 +1631,9 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (bit == TRACE_GRAPH_GRAPH_TIME)
 		ftrace_graph_graph_time_control(set);
 
+	if (bit == TRACE_GRAPH_ARGS)
+		return ftrace_graph_trace_args(tr, set);
+
 	return 0;
 }
 
-- 
2.45.2



