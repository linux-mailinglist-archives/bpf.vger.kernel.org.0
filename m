Return-Path: <bpf+bounces-52791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29BA48858
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9017A1D6A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3E26B966;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577D1F5841;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682659; cv=none; b=Rf23leZf15lDPe2to35/sPKD5XskSLPZdWf1khVnIG3MQ0LlBtfs2CygzSzFcHXfPmBycHrqQliM6L/mkAGlF/mONLZnoZWNgKSeL0Y7qepiJTeLx1bp/KzoK4zVe0foUeKRJB6gAkO1FJIHCeh3d0uJCVVfZs0Xf4SKEPwWIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682659; c=relaxed/simple;
	bh=o0vu4EXSlywMKNgJRw80ZeDrMF/DIUZY7Gu0mhkAXg0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c6CbcHVWZ0JPDYYc8UV6YNPo55rljHFkvkneVF6I1pLSoJvCZDOBpsHvCytXJi3Ea1yE1q3xjDi1/JpjVgzupOGZmudD8qoRAKXgGdAFHdZcJG55yck2A28TXpZhz1PK5vszAolIWBgMQCxtmLdliPx6R/UAZox4F5avagNGRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5222DC4CEEF;
	Thu, 27 Feb 2025 18:57:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnj5T-00000009nS3-0Yay;
	Thu, 27 Feb 2025 13:58:23 -0500
Message-ID: <20250227185822.978998710@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 27 Feb 2025 13:58:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
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
 Zheng Yejian <zhengyejian@huaweicloud.com>
Subject: [PATCH v4 3/4] ftrace: Have funcgraph-args take affect during tracing
References: <20250227185804.639525399@goodmis.org>
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 5049fe25ceef..71b2fb068b6b 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -464,7 +464,7 @@ static int graph_trace_init(struct trace_array *tr)
 	else
 		tr->gops->retfunc = trace_graph_return;
 
-	/* Make gops functions are visible before we start tracing */
+	/* Make gops functions visible before we start tracing */
 	smp_mb();
 
 	ret = register_ftrace_graph(tr->gops);
@@ -475,6 +475,28 @@ static int graph_trace_init(struct trace_array *tr)
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
@@ -1607,6 +1629,9 @@ func_graph_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	if (bit == TRACE_GRAPH_GRAPH_TIME)
 		ftrace_graph_graph_time_control(set);
 
+	if (bit == TRACE_GRAPH_ARGS)
+		return ftrace_graph_trace_args(tr, set);
+
 	return 0;
 }
 
-- 
2.47.2



