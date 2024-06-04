Return-Path: <bpf+bounces-31333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0D8FB5F5
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE281C24B7D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CF14A616;
	Tue,  4 Jun 2024 14:42:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74514A4DD;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512139; cv=none; b=CI7XWnsPcPKqSe1CDW7yYsQqtngSYIIE3bALhSo/nKEDrPHR/HbPIcxjIvcK4PbdryxEO22U0Z8eNBv0CL4a+uYpJZiWUkzspWAkLZHdp35xSfZFRNSaSDaqPQYpnbM7K2fVoqSXSrFsO1JqxqiH09N5FvpYcG99mj6TEI34/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512139; c=relaxed/simple;
	bh=DODPJgC5iTA3XbUH1M3g3CyluOcqeSJmFe7rf8Joak8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jqZwdOyi+CYCUE5aoy4IQczzxk0Vrl7j+0O0tgtgjmCbvoMOLoC4quHg/SUeAsHzhItyP/zsxYpRerLfKfjzIUa4AK825EBhTo2rpkdl7cm8vYcYVIQ3lk4zw8hhQxddTID55qi+Wj/XDOoZyqkd/RF4T4+HCh35Z//hfjxw+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3EC4AF13;
	Tue,  4 Jun 2024 14:42:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEVMf-00000000Z3V-24Ne;
	Tue, 04 Jun 2024 10:42:17 -0400
Message-ID: <20240604144217.350436921@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 10:41:24 -0400
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
Subject: [for-next][PATCH 21/27] ftrace: Add multiple fgraph storage selftest
References: <20240604144103.293353991@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add a selftest for multiple function graph tracer with storage on a same
function. In this case, the shadow stack entry will be shared among those
fgraph with different data storage. So this will ensure the fgraph will
not mixed those storage data.

Link: https://lore.kernel.org/linux-trace-kernel/171509111465.162236.3795819216426570800.stgit@devnote2
Link: https://lore.kernel.org/linux-trace-kernel/20240603190824.284049716@goodmis.org

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
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 171 +++++++++++++++++++++++++---------
 1 file changed, 126 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index fcdc744c245e..369efc569238 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -762,28 +762,32 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 #define SHORT_NUMBER 12345
 #define WORD_NUMBER 1234567890
 #define LONG_NUMBER 1234567890123456789LL
-
-static int fgraph_store_size __initdata;
-static const char *fgraph_store_type_name __initdata;
-static char *fgraph_error_str __initdata;
-static char fgraph_error_str_buf[128] __initdata;
+#define ERRSTR_BUFLEN 128
+
+struct fgraph_fixture {
+	struct fgraph_ops gops;
+	int store_size;
+	const char *store_type_name;
+	char error_str_buf[ERRSTR_BUFLEN];
+	char *error_str;
+};
 
 static __init int store_entry(struct ftrace_graph_ent *trace,
 			      struct fgraph_ops *gops)
 {
-	const char *type = fgraph_store_type_name;
-	int size = fgraph_store_size;
+	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
+	const char *type = fixture->store_type_name;
+	int size = fixture->store_size;
 	void *p;
 
 	p = fgraph_reserve_data(gops->idx, size);
 	if (!p) {
-		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		snprintf(fixture->error_str_buf, ERRSTR_BUFLEN,
 			 "Failed to reserve %s\n", type);
-		fgraph_error_str = fgraph_error_str_buf;
 		return 0;
 	}
 
-	switch (fgraph_store_size) {
+	switch (size) {
 	case 1:
 		*(char *)p = BYTE_NUMBER;
 		break;
@@ -804,7 +808,8 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
 static __init void store_return(struct ftrace_graph_ret *trace,
 				struct fgraph_ops *gops)
 {
-	const char *type = fgraph_store_type_name;
+	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
+	const char *type = fixture->store_type_name;
 	long long expect = 0;
 	long long found = -1;
 	int size;
@@ -812,20 +817,18 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 
 	p = fgraph_retrieve_data(gops->idx, &size);
 	if (!p) {
-		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		snprintf(fixture->error_str_buf, ERRSTR_BUFLEN,
 			 "Failed to retrieve %s\n", type);
-		fgraph_error_str = fgraph_error_str_buf;
 		return;
 	}
-	if (fgraph_store_size > size) {
-		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+	if (fixture->store_size > size) {
+		snprintf(fixture->error_str_buf, ERRSTR_BUFLEN,
 			 "Retrieved size %d is smaller than expected %d\n",
-			 size, (int)fgraph_store_size);
-		fgraph_error_str = fgraph_error_str_buf;
+			 size, (int)fixture->store_size);
 		return;
 	}
 
-	switch (fgraph_store_size) {
+	switch (fixture->store_size) {
 	case 1:
 		expect = BYTE_NUMBER;
 		found = *(char *)p;
@@ -845,45 +848,44 @@ static __init void store_return(struct ftrace_graph_ret *trace,
 	}
 
 	if (found != expect) {
-		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		snprintf(fixture->error_str_buf, ERRSTR_BUFLEN,
 			 "%s returned not %lld but %lld\n", type, expect, found);
-		fgraph_error_str = fgraph_error_str_buf;
 		return;
 	}
-	fgraph_error_str = NULL;
+	fixture->error_str = NULL;
 }
 
-static struct fgraph_ops store_bytes __initdata = {
-	.entryfunc		= store_entry,
-	.retfunc		= store_return,
-};
-
-static int __init test_graph_storage_type(const char *name, int size)
+static int __init init_fgraph_fixture(struct fgraph_fixture *fixture)
 {
 	char *func_name;
 	int len;
-	int ret;
 
-	fgraph_store_type_name = name;
-	fgraph_store_size = size;
+	snprintf(fixture->error_str_buf, ERRSTR_BUFLEN,
+		 "Failed to execute storage %s\n", fixture->store_type_name);
+	fixture->error_str = fixture->error_str_buf;
 
-	snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
-		 "Failed to execute storage %s\n", name);
-	fgraph_error_str = fgraph_error_str_buf;
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	len = strlen(func_name);
+
+	return ftrace_set_filter(&fixture->gops.ops, func_name, len, 1);
+}
+
+/* Test fgraph storage for each size */
+static int __init test_graph_storage_single(struct fgraph_fixture *fixture)
+{
+	int size = fixture->store_size;
+	int ret;
 
 	pr_cont("PASSED\n");
 	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
 
-	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
-	len = strlen(func_name);
-
-	ret = ftrace_set_filter(&store_bytes.ops, func_name, len, 1);
+	ret = init_fgraph_fixture(fixture);
 	if (ret && ret != -ENODEV) {
 		pr_cont("*Could not set filter* ");
 		return -1;
 	}
 
-	ret = register_ftrace_graph(&store_bytes);
+	ret = register_ftrace_graph(&fixture->gops);
 	if (ret) {
 		pr_warn("Failed to init store_bytes fgraph tracing\n");
 		return -1;
@@ -891,30 +893,109 @@ static int __init test_graph_storage_type(const char *name, int size)
 
 	DYN_FTRACE_TEST_NAME();
 
-	unregister_ftrace_graph(&store_bytes);
+	unregister_ftrace_graph(&fixture->gops);
 
-	if (fgraph_error_str) {
-		pr_cont("*** %s ***", fgraph_error_str);
+	if (fixture->error_str) {
+		pr_cont("*** %s ***", fixture->error_str);
 		return -1;
 	}
 
 	return 0;
 }
+
+static struct fgraph_fixture store_bytes[4] __initdata = {
+	[0] = {
+		.gops = {
+			.entryfunc		= store_entry,
+			.retfunc		= store_return,
+		},
+		.store_size = 1,
+		.store_type_name = "byte",
+	},
+	[1] = {
+		.gops = {
+			.entryfunc		= store_entry,
+			.retfunc		= store_return,
+		},
+		.store_size = 2,
+		.store_type_name = "short",
+	},
+	[2] = {
+		.gops = {
+			.entryfunc		= store_entry,
+			.retfunc		= store_return,
+		},
+		.store_size = 4,
+		.store_type_name = "word",
+	},
+	[3] = {
+		.gops = {
+			.entryfunc		= store_entry,
+			.retfunc		= store_return,
+		},
+		.store_size = 8,
+		.store_type_name = "long long",
+	},
+};
+
+static __init int test_graph_storage_multi(void)
+{
+	struct fgraph_fixture *fixture;
+	bool printed = false;
+	int i, ret;
+
+	pr_cont("PASSED\n");
+	pr_info("Testing multiple fgraph storage on a function: ");
+
+	for (i = 0; i < ARRAY_SIZE(store_bytes); i++) {
+		fixture = &store_bytes[i];
+		ret = init_fgraph_fixture(fixture);
+		if (ret && ret != -ENODEV) {
+			pr_cont("*Could not set filter* ");
+			printed = true;
+			goto out;
+		}
+
+		ret = register_ftrace_graph(&fixture->gops);
+		if (ret) {
+			pr_warn("Failed to init store_bytes fgraph tracing\n");
+			printed = true;
+			goto out;
+		}
+	}
+
+	DYN_FTRACE_TEST_NAME();
+out:
+	while (--i >= 0) {
+		fixture = &store_bytes[i];
+		unregister_ftrace_graph(&fixture->gops);
+
+		if (fixture->error_str && !printed) {
+			pr_cont("*** %s ***", fixture->error_str);
+			printed = true;
+		}
+	}
+	return printed ? -1 : 0;
+}
+
 /* Test the storage passed across function_graph entry and return */
 static __init int test_graph_storage(void)
 {
 	int ret;
 
-	ret = test_graph_storage_type("byte", 1);
+	ret = test_graph_storage_single(&store_bytes[0]);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_single(&store_bytes[1]);
 	if (ret)
 		return ret;
-	ret = test_graph_storage_type("short", 2);
+	ret = test_graph_storage_single(&store_bytes[2]);
 	if (ret)
 		return ret;
-	ret = test_graph_storage_type("word", 4);
+	ret = test_graph_storage_single(&store_bytes[3]);
 	if (ret)
 		return ret;
-	ret = test_graph_storage_type("long long", 8);
+	ret = test_graph_storage_multi();
 	if (ret)
 		return ret;
 	return 0;
-- 
2.43.0



