Return-Path: <bpf+bounces-31328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBFB8FB5F1
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B809D1C23C0B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9691F14A098;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C5149DFD;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512138; cv=none; b=sbNDuPk4Yzg7Z6486oFpDymR35JO4HYTSnddixIzH1YLkrFsfmwgUNTKawz02pwxitmdASAxIwvdk5Fx4MGWRxxZXDqqttkMPBv0HrxrQSdNuzgd5xKqtEZ6/lZvNuN21WSXlMlw6/EJLWN3KfDobLLdc5oGD/RSLVxcCHNyTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512138; c=relaxed/simple;
	bh=IAIIS8v+bosYlzGF5MlMyH1JE3oZnqIvLkRzeTIUn68=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=s0gzALquwKv1HuCTk53gj61QqECaDBimvR4/BaV4k16twr4pR/x/BX7c0N6KLBni8fzf1DHmvsAKeKHU1Fcj38QOBcHIeSPLV/rBqpUnWeTPgRrOwQHYuPZRzp+A4BCI0rlfTaqTHnnlMziIhnJQS0m4V1UZNPzgLxEOsSy0kA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C553C2BBFC;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMf-00000000Z31-1OBA;
	Tue, 04 Jun 2024 10:42:17 -0400
Message-ID: <20240604144217.192319975@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:23 -0400
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
Subject: [for-next][PATCH 20/27] function_graph: Add selftest for passing local variables
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add boot up selftest that passes variables from a function entry to a
function exit, and make sure that they do get passed around.

Co-developed with Masami Hiramatsu:
Link: https://lore.kernel.org/linux-trace-kernel/171509110271.162236.11047551496319744627.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190824.122952310@goodmis.org

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
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 169 ++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index f8f55fd79e53..fcdc744c245e 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -756,6 +756,173 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define BYTE_NUMBER 123
+#define SHORT_NUMBER 12345
+#define WORD_NUMBER 1234567890
+#define LONG_NUMBER 1234567890123456789LL
+
+static int fgraph_store_size __initdata;
+static const char *fgraph_store_type_name __initdata;
+static char *fgraph_error_str __initdata;
+static char fgraph_error_str_buf[128] __initdata;
+
+static __init int store_entry(struct ftrace_graph_ent *trace,
+			      struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	int size = fgraph_store_size;
+	void *p;
+
+	p = fgraph_reserve_data(gops->idx, size);
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to reserve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return 0;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		*(char *)p = BYTE_NUMBER;
+		break;
+	case 2:
+		*(short *)p = SHORT_NUMBER;
+		break;
+	case 4:
+		*(int *)p = WORD_NUMBER;
+		break;
+	case 8:
+		*(long long *)p = LONG_NUMBER;
+		break;
+	}
+
+	return 1;
+}
+
+static __init void store_return(struct ftrace_graph_ret *trace,
+				struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	long long expect = 0;
+	long long found = -1;
+	int size;
+	char *p;
+
+	p = fgraph_retrieve_data(gops->idx, &size);
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to retrieve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+	if (fgraph_store_size > size) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Retrieved size %d is smaller than expected %d\n",
+			 size, (int)fgraph_store_size);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		expect = BYTE_NUMBER;
+		found = *(char *)p;
+		break;
+	case 2:
+		expect = SHORT_NUMBER;
+		found = *(short *)p;
+		break;
+	case 4:
+		expect = WORD_NUMBER;
+		found = *(int *)p;
+		break;
+	case 8:
+		expect = LONG_NUMBER;
+		found = *(long long *)p;
+		break;
+	}
+
+	if (found != expect) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "%s returned not %lld but %lld\n", type, expect, found);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+	fgraph_error_str = NULL;
+}
+
+static struct fgraph_ops store_bytes __initdata = {
+	.entryfunc		= store_entry,
+	.retfunc		= store_return,
+};
+
+static int __init test_graph_storage_type(const char *name, int size)
+{
+	char *func_name;
+	int len;
+	int ret;
+
+	fgraph_store_type_name = name;
+	fgraph_store_size = size;
+
+	snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		 "Failed to execute storage %s\n", name);
+	fgraph_error_str = fgraph_error_str_buf;
+
+	pr_cont("PASSED\n");
+	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
+
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	len = strlen(func_name);
+
+	ret = ftrace_set_filter(&store_bytes.ops, func_name, len, 1);
+	if (ret && ret != -ENODEV) {
+		pr_cont("*Could not set filter* ");
+		return -1;
+	}
+
+	ret = register_ftrace_graph(&store_bytes);
+	if (ret) {
+		pr_warn("Failed to init store_bytes fgraph tracing\n");
+		return -1;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	unregister_ftrace_graph(&store_bytes);
+
+	if (fgraph_error_str) {
+		pr_cont("*** %s ***", fgraph_error_str);
+		return -1;
+	}
+
+	return 0;
+}
+/* Test the storage passed across function_graph entry and return */
+static __init int test_graph_storage(void)
+{
+	int ret;
+
+	ret = test_graph_storage_type("byte", 1);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("short", 2);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("word", 4);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("long long", 8);
+	if (ret)
+		return ret;
+	return 0;
+}
+#else
+static inline int test_graph_storage(void) { return 0; }
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 /* Maximum number of functions to trace before diagnosing a hang */
 #define GRAPH_MAX_FUNC_TEST	100000000
 
@@ -913,6 +1080,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	ftrace_set_global_filter(NULL, 0, 1);
 #endif
 
+	ret = test_graph_storage();
+
 	/* Don't test dynamic tracing, the function tracer already did */
 out:
 	/* Stop it if we failed */
-- 
2.43.0



