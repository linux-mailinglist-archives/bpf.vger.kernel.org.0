Return-Path: <bpf+bounces-26792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143478A5084
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371191C20D63
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C98062A;
	Mon, 15 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDQ34bdT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840173199;
	Mon, 15 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185583; cv=none; b=gA7TnhHV9BbgqQL8zLhvxkP6Mff8WKyfTyI5yDnTvhNt4A9QXAXIOlJgtvBbODCLuqWO66OSGWVpVlBGuME7BYV/PgkrYzugHK8P6MXQN6uqQgA0rYq/WekGg/LCF1qnFvg+GwronXMIvXpc12WKaJPd6VE/2/bJD9hc78bpgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185583; c=relaxed/simple;
	bh=TNcTuIAI1nyyXqaETeN6Aiz/TEyq4HnB9Qz+DldKr/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQtSO+2ZwLYQuND0QHTcm/jieX5pOegs1BJe8fXK7lORnhMStlsvZjTGPMmzYnIvqWMoyGyJfR3AE8IuCKZ4Kxdj/SyV7lluKLcikinycNwYYaxYXurjS53uKwyu7TLYmQMRf9YkiIIg5s79R3VxtlkIjqlYOYYMPIJ+DCbXyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDQ34bdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B938C113CC;
	Mon, 15 Apr 2024 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185583;
	bh=TNcTuIAI1nyyXqaETeN6Aiz/TEyq4HnB9Qz+DldKr/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDQ34bdTJzN/11aCxThz2cjgtgHbqJkYadzdGgUxPA9PRxmJh/0qKuczI+hAJwdRB
	 MjIGLAF4V0wxYWarvQHflLIPUPjLehtZMukKWxHsgJP7qzQ0sasqn+tZqRexwVxJM/
	 BXGul6hzFj5cW1c/SggnN/aUyTu/lA1ByBcPl6ZtLZhLKel+NeeksTRPzxS3Vqb336
	 V8zeWjPgCmMhtAamc2doU7Nuwrd8rGr+McAV8zZ9yieOwZmCxkbgECLZHMq794iPt1
	 jNiiTVJerwV1l4P4PDmItReFc838z9xhan9phkZ+qBneQfyfXZX3PXJ7IB6dupuzj6
	 lBy6Wj48g5T5w==
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
Subject: [PATCH v9 20/36] ftrace: Add multiple fgraph storage selftest
Date: Mon, 15 Apr 2024 21:52:57 +0900
Message-Id: <171318557716.254850.5577681315811992974.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
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

Add a selftest for multiple function graph tracer with storage on a same
function. In this case, the shadow stack entry will be shared among those
fgraph with different data storage. So this will ensure the fgraph will
not mixed those storage data.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v8:
  - Newly added.
---
 kernel/trace/trace_selftest.c |  171 ++++++++++++++++++++++++++++++-----------
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


