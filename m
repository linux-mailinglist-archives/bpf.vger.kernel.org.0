Return-Path: <bpf+bounces-48634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE48A0A743
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 06:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8168E3A8AF2
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C3839F4;
	Sun, 12 Jan 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVz9rd+H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDF632;
	Sun, 12 Jan 2025 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736659602; cv=none; b=ujP2o+yi+C/troUlX7fmlj6MF+bBay7a1JV7qbiXrEwcM61h7LbsCwm8yY0ZJwsZZ4B2I0NUCI6ORxBnwW2jW/xpi58KQRx7O+WaG1/LjaUdod4ZoP5olxd+O236RjwZuSzYTmDLpCsEkblMPRUwTpjEuzQpT2bCy51QxJQZeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736659602; c=relaxed/simple;
	bh=WEuTKqsqdUyEs81BC4WOvmVz9HYQKyyQ9xf+QyvZH1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv6fgDRct6r9EteVsfxKD3CDzfwAJ1F9Zuh43MeygK4mcAaW5DHtJ2oZbDQvPOJCFDkC7MSz5qIN3fXQrlabuFFEmXmEeSR6AF1ZnVKh1vY6+VqrZoPbqBZX5LLLrCLOSRhAVFjgLZJdcWAaAIPZuxOIM1DKvol1Uy49RUllksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVz9rd+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE9BC4CEE0;
	Sun, 12 Jan 2025 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736659600;
	bh=WEuTKqsqdUyEs81BC4WOvmVz9HYQKyyQ9xf+QyvZH1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVz9rd+HP/ZfGeJ7amyLZFnacEoymLHIxjT7g5Ns16yCMb5niLWPWaLxzB3t4/qpB
	 9kcpbfEkWO5JOfgdbfjSiTxxrF3thsmvxQLIYiKbKLKUpEpCHCso/fM4QdBHp7BIkB
	 T1QYfOmnhYUupubPrlA1zoY+jJOVs2bBNHSrCQ7F0YHZUKbxjO5cokcjtA5gHZ8oHE
	 tJzbN3qnvHK/a9TXyXiKfif2w8Qqq2Tdy1CSUh3F7Pf+omyWsDqKVsz5C0er9owYhq
	 RJfMMC7/H8uSiYKUSJdBB1eVT1Q4zxA1WhYAB+Jtke4JwQzq2RN2gFFPC2R0fXyMrp
	 fmyLN9NKEm1Zg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] fgraph: Move trace_clock_local() for return time to function_graph tracer
Date: Sun, 12 Jan 2025 14:26:35 +0900
Message-ID: <173665959558.1629214.16724136597211810729.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Z3aSuql3fnXMVMoM@krava>
References: <Z3aSuql3fnXMVMoM@krava>
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

Since the ftrace_graph_ret::rettime is only referred in the function_graph
tracer, the trace_clock_local() call in fgraph is just an overhead for
other fgraph users.

Move the trace_clock_local() for recording return time to function_graph
tracer and the rettime field is just zeroed in the fgraph side.
That rettime field is updated by one of the function_graph tracer and
cached for other function_graph tracer instances.

According to Jiri's report[1], removing this function will gain fprobe
performance ~27%.

[1] https://lore.kernel.org/all/Z3aSuql3fnXMVMoM@krava/

Reported-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h               |   11 +++++++++++
 kernel/trace/fgraph.c                |    2 +-
 kernel/trace/trace_functions_graph.c |    2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 07092dfb21a4..a2fb7360d6e2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1155,6 +1155,17 @@ struct ftrace_graph_ret {
 	unsigned long long rettime;
 } __packed;
 
+static inline void ftrace_graph_ret_record_time(struct ftrace_graph_ret *trace)
+{
+	if (!trace->rettime)
+		trace->rettime = trace_clock_local();
+}
+
+static inline void ftrace_graph_ret_init_time(struct ftrace_graph_ret *trace)
+{
+	trace->rettime = 0;
+}
+
 struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c928527251e3..bc1e5f0493b6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -826,7 +826,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		return (unsigned long)panic;
 	}
 
-	trace.rettime = trace_clock_local();
+	ftrace_graph_ret_init_time(&trace);
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index d0e4f412c298..7e4d91d42d8e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -327,6 +327,7 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 	int size;
 	int cpu;
 
+	ftrace_graph_ret_record_time(trace);
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (*task_var & TRACE_GRAPH_NOTRACE) {
@@ -361,6 +362,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	struct fgraph_times *ftimes;
 	int size;
 
+	ftrace_graph_ret_record_time(trace);
 	ftrace_graph_addr_finish(gops, trace);
 
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {


