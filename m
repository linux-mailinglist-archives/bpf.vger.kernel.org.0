Return-Path: <bpf+bounces-31245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235758D8980
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BDA1F25857
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70813D2A6;
	Mon,  3 Jun 2024 19:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C413CFB1;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441633; cv=none; b=HbEgIZNshP5TinBKAQyHGAfXFOa61x97Da56wpMmP40L0+2jBVX1OsaC43V09lBR3haZphz944e0kNGqE2XyRhdC3ZqnbXYAMamMSNImE9h/WV4Z+652/WiQlPGxA5Zl6u26yZF0IQC4PrFgd+s136a5kmuNWMspdbZN/OGkYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441633; c=relaxed/simple;
	bh=fTaaCzW/dX3tmDpJTRy222XLic23m/x+oc1DZLADNPI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oateFayPM0nthbIu/1LSyHAfkyrkDMMrtxfOq+x9EXDZbS273PxHshX0TQAc3kFTKI0kcVtb6cfgN8VIwqxvIAwfoCUDl/Rz16R8OqLycu1HFMimyPMyOzKpxDTVyDOWHKc4ezjWU3TiSf0Gx7Qw2YDBSTA2d2od7Yri0DIdNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB7AC4DDE6;
	Mon,  3 Jun 2024 19:07:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sED2e-00000009TwR-1nAz;
	Mon, 03 Jun 2024 15:08:24 -0400
Message-ID: <20240603190824.284049716@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Jun 2024 15:07:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
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
Subject: [PATCH v3 21/27] ftrace: Add multiple fgraph storage selftest
References: <20240603190704.663840775@goodmis.org>
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



