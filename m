Return-Path: <bpf+bounces-7113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF90771883
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894F1281103
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860281A;
	Mon,  7 Aug 2023 02:54:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405F642
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CBBC433C8;
	Mon,  7 Aug 2023 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376892;
	bh=SRfHcWNQ4ICcFJ2Rv+nVTbK4OPLke1PFMlqHLMr73Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/OlDOAEcrCnXMIXBNskuBSIBOy+SFFnrBSPrRzFcX6lGPAqe+VQG1uFVIZz220QQ
	 I/kRTwHBevcZDOvirmo+Uu70NcDEbcwjcRvDfIYzMWmn0HEa5GuvQ0EBrF9ZwnShzU
	 VEWjMXSf/AKxdsV3P7RXp+CLnSmLvgmNs2Jt1GtLSX5d0EmlZpz1qOO5n2ewc970Qe
	 H2UzMJwOzjvjABWo6ybZdzYzIK0ijzqZNPykJGDS8jtGhH/6icDkQl2uULCGywKHkg
	 Ppl3Vq19jbl63fY01U4UAqlaEkfV5k56Y2nw9aJCbHJCUWwuZFvOkdhs4pNJoy+QTX
	 f498bt3vujqmw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 2/9] tracing/probes: Move finding func-proto API and getting func-param API to trace_btf
Date: Mon,  7 Aug 2023 11:54:48 +0900
Message-Id: <169137688818.271367.11100920774974880710.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169137686814.271367.11218568219311636206.stgit@devnote2>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
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

Move generic function-proto find API and getting function parameter API
to BTF library code from trace_probe.c. This will avoid redundant efforts
on different feature.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Remove perameter check.
  - Fix a typo.
  - Add a type check for btf_get_func_param() and add comment for that.
  - Use bpf_find_btf_id() and add bpf_put().
  - Move the code before btf_show() related code.
 Changes in v5:
  - Move the generic functions into a new file, trace_btf.c, for avoiding
    tree-merge conflict.
---
 kernel/trace/Makefile      |    1 +
 kernel/trace/trace_btf.c   |   52 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h   |    7 ++++++
 kernel/trace/trace_probe.c |   51 +++++++++----------------------------------
 4 files changed, 71 insertions(+), 40 deletions(-)
 create mode 100644 kernel/trace/trace_btf.c
 create mode 100644 kernel/trace/trace_btf.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 64b61f67a403..057cd975d014 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
+obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
new file mode 100644
index 000000000000..82cbbeeda071
--- /dev/null
+++ b/kernel/trace/trace_btf.c
@@ -0,0 +1,52 @@
+#include <linux/btf.h>
+#include <linux/kernel.h>
+
+#include "trace_btf.h"
+
+/*
+ * Find a function proto type by name, and return the btf_type with its btf
+ * in *@btf_p. Return NULL if not found.
+ * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
+ */
+const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
+{
+	const struct btf_type *t;
+	s32 id;
+
+	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
+	if (id < 0)
+		return NULL;
+
+	/* Get BTF_KIND_FUNC type */
+	t = btf_type_by_id(*btf_p, id);
+	if (!t || !btf_type_is_func(t))
+		goto err;
+
+	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
+	t = btf_type_by_id(*btf_p, t->type);
+	if (!t || !btf_type_is_func_proto(t))
+		goto err;
+
+	return t;
+err:
+	btf_put(*btf_p);
+	return NULL;
+}
+
+/*
+ * Get function parameter with the number of parameters.
+ * This can return NULL if the function has no parameters.
+ * It can return -EINVAL if the @func_proto is not a function proto type.
+ */
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
+{
+	if (!btf_type_is_func_proto(func_proto))
+		return ERR_PTR(-EINVAL);
+
+	*nr = btf_type_vlen(func_proto);
+	if (*nr > 0)
+		return (const struct btf_param *)(func_proto + 1);
+	else
+		return NULL;
+}
+
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
new file mode 100644
index 000000000000..2ef1b2367e1e
--- /dev/null
+++ b/kernel/trace/trace_btf.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/btf.h>
+
+const struct btf_type *btf_find_func_proto(const char *func_name,
+					   struct btf **btf_p);
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
+					   s32 *nr);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ecbe28f8d676..c3ac5698e80b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
+#include "trace_btf.h"
 
 #include "trace_probe.h"
 
@@ -361,38 +362,6 @@ static const char *type_from_btf_id(struct btf *btf, s32 id)
 	return NULL;
 }
 
-static const struct btf_type *find_btf_func_proto(const char *funcname,
-						  struct btf **btf_p)
-{
-	const struct btf_type *t;
-	struct btf *btf = NULL;
-	s32 id;
-
-	if (!funcname)
-		return ERR_PTR(-EINVAL);
-
-	id = bpf_find_btf_id(funcname, BTF_KIND_FUNC, &btf);
-	if (id <= 0)
-		return ERR_PTR(-ENOENT);
-
-	/* Get BTF_KIND_FUNC type */
-	t = btf_type_by_id(btf, id);
-	if (!t || !btf_type_is_func(t))
-		goto err;
-
-	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
-	t = btf_type_by_id(btf, t->type);
-	if (!t || !btf_type_is_func_proto(t))
-		goto err;
-
-	*btf_p = btf;
-	return t;
-
-err:
-	btf_put(btf);
-	return ERR_PTR(-ENOENT);
-}
-
 static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
 						   struct btf **btf_p, bool tracepoint)
 {
@@ -403,12 +372,13 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 	if (!funcname || !nr)
 		return ERR_PTR(-EINVAL);
 
-	t = find_btf_func_proto(funcname, &btf);
-	if (IS_ERR(t))
+	t = btf_find_func_proto(funcname, &btf);
+	if (!t)
 		return (const struct btf_param *)t;
 
-	*nr = btf_type_vlen(t);
-	param = (const struct btf_param *)(t + 1);
+	param = btf_get_func_param(t, nr);
+	if (IS_ERR_OR_NULL(param))
+		goto err;
 
 	/* Hide the first 'data' argument of tracepoint */
 	if (tracepoint) {
@@ -421,6 +391,7 @@ static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr
 		return param;
 	}
 
+err:
 	btf_put(btf);
 	return NULL;
 }
@@ -496,8 +467,8 @@ static const struct fetch_type *parse_btf_retval_type(
 
 	if (ctx->funcname) {
 		/* Do not use ctx->btf, because it must be used with ctx->param */
-		t = find_btf_func_proto(ctx->funcname, &btf);
-		if (!IS_ERR(t)) {
+		t = btf_find_func_proto(ctx->funcname, &btf);
+		if (t) {
 			typestr = type_from_btf_id(btf, t->type);
 			btf_put(btf);
 		}
@@ -512,8 +483,8 @@ static bool is_btf_retval_void(const char *funcname)
 	struct btf *btf;
 	bool ret;
 
-	t = find_btf_func_proto(funcname, &btf);
-	if (IS_ERR(t))
+	t = btf_find_func_proto(funcname, &btf);
+	if (!t)
 		return false;
 
 	ret = (t->type == 0);


