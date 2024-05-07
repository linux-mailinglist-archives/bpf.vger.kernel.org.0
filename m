Return-Path: <bpf+bounces-28856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B78BE563
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EDD1F21A7E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631A16C697;
	Tue,  7 May 2024 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7kc/Xh0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DC16C44F;
	Tue,  7 May 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091111; cv=none; b=uQwT3tifHpuS1XWfOIJDR8S36lgFlatb4a5T1GOClvENYJEH49nv+YsdOUKwMbU+rv0S889Y8/Fc2aErRI4uvJTKeuNAdTn4PzkZUEWzl90zq5fbS/3DMJnt2v2T0SmFcPnFXeYYoCV9ix9VtHl0VE7gQzK7i/KQH1xaCKYQ8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091111; c=relaxed/simple;
	bh=DCBfBfFOj9Ld9CrPA0WKtDdiYIvAX5GbnRe38AM0AAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9itnBuGZl7eu/L+JqNLPllyA8X6dy4cQmzMnjAVftO1kfObA2rBJMafEa/oe2mVI1sNm/bOjBUPKUIAvKUjchpJwSH1wLKL/tmdtbwQljM5V3jTg9KgndhZqTUiPz8NpL1KA+vNG/wZ7yffHKAtjXk3yObb0ej4Q62y2b3C2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7kc/Xh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4D9C2BBFC;
	Tue,  7 May 2024 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715091109;
	bh=DCBfBfFOj9Ld9CrPA0WKtDdiYIvAX5GbnRe38AM0AAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7kc/Xh0bm10K7fVvo5Q45nnKgCOqOPajjhJtf89elg1RaBjOh9nd0rScI4bct29Y
	 CpZIKehjCsh4N30/BoB1LWDjeO3/fB5k6OCtfcJc6v6QrCWRE2IM8gZ3dOla25QStK
	 7wLzmhfvnza9IZXEYVS8CNiVVgUnwUbGNtwaFkSx/OpHjBDj6e2boybriaXNyihrwS
	 wljV/fBdBq3AIYLqn6y9G6ewi89SDtdcUiuxYCP9gmri2fDCKZFSgPliieWf7X0v9M
	 kIVMyNOdk+3J1JoBdFvgl61Cv1mdiGEo3PKulEnmOMr9iEv5ZMTbSp2HkFOabIHj3I
	 xaEQ5jP3lxiVw==
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
Subject: [PATCH v10 19/36] function_graph: Add selftest for passing local variables
Date: Tue,  7 May 2024 23:11:42 +0900
Message-Id: <171509110271.162236.11047551496319744627.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171509088006.162236.7227326999861366050.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Add boot up selftest that passes variables from a function entry to a
function exit, and make sure that they do get passed around.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Add reserved size test.
  - Use pr_*() instead of printk(KERN_*).
---
 kernel/trace/trace_selftest.c |  169 +++++++++++++++++++++++++++++++++++++++++
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


