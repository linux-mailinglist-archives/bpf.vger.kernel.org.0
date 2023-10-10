Return-Path: <bpf+bounces-11808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0EA7BFE82
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF01C20D8A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFC1F932;
	Tue, 10 Oct 2023 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZ9crXHk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544B1DFEC;
	Tue, 10 Oct 2023 13:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B53C433C8;
	Tue, 10 Oct 2023 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696946063;
	bh=CNWvC9NpuHMARHhr8MyzieDE2CJlBdi0q9ScP3wU4Pk=;
	h=From:To:Cc:Subject:Date:From;
	b=WZ9crXHkqfRHOuwF5nSBT/H/QN11ggSEKBro2yDSNAM6nbU6+rc79pvijcGFsp4RK
	 kj27z4TB/14zehVxsb1V4yLR8cg9XMwpyG4oDwxPJ42IgHsCU91qO3m01sSWdES8nY
	 M0G03ThhjBrkEjEEQpB2olWoufBDBEC/n4ey4+C/KWh+lF2rAt9IEVzIVG6IrXzuzO
	 NptVfj5tQgvc5lK23RAeiVWx2C4U0u3sxygBOlbffhN1v4kqn9YgENIyjU1Zkq56Ey
	 9yX1Sc4EmlMNjCd0plo4OFfZ7f7W7Aguu5nJ+RpFjfolPgCUljrueflCbuFCMHDIyl
	 JxT6wHCzBaC6A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org
Subject: [PATCH] bpf/btf: Move tracing BTF APIs to the BTF library
Date: Tue, 10 Oct 2023 22:54:19 +0900
Message-Id: <169694605862.516358.5321950027838863987.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Move the BTF APIs used in tracing to the BTF library code for sharing it
with others.
Previously, to avoid complex dependency in a series I made it on the
tracing tree, but now it is a good time to move it to BPF tree because
these functions are pure BTF functions.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/btf.h        |   24 +++++++++
 kernel/bpf/btf.c           |  115 +++++++++++++++++++++++++++++++++++++++++
 kernel/trace/Makefile      |    1 
 kernel/trace/trace_btf.c   |  122 --------------------------------------------
 kernel/trace/trace_btf.h   |   11 ----
 kernel/trace/trace_probe.c |    2 -
 6 files changed, 140 insertions(+), 135 deletions(-)
 delete mode 100644 kernel/trace/trace_btf.c
 delete mode 100644 kernel/trace/trace_btf.h

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..8372d93ea402 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -507,6 +507,14 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
+const struct btf_type *btf_find_func_proto(const char *func_name,
+					   struct btf **btf_p);
+const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
+					   s32 *nr);
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name,
+						u32 *anon_offset);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -559,6 +567,22 @@ static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
 {
 	return false;
 }
+static inline const struct btf_type *btf_find_func_proto(const char *func_name,
+							 struct btf **btf_p)
+{
+	return NULL;
+}
+static inline const struct btf_param *
+btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
+{
+	return NULL;
+}
+static inline const struct btf_member *
+btf_find_struct_member(struct btf *btf, const struct btf_type *type,
+		       const char *member_name, u32 *anon_offset)
+{
+	return NULL;
+}
 #endif
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8090d7fb11ef..e5cbf3b31b78 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -912,6 +912,121 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
 	return t;
 }
 
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
+#define BTF_ANON_STACK_MAX	16
+
+struct btf_anon_stack {
+	u32 tid;
+	u32 offset;
+};
+
+/*
+ * Find a member of data structure/union by name and return it.
+ * Return NULL if not found, or -EINVAL if parameter is invalid.
+ * If the member is an member of anonymous union/structure, the offset
+ * of that anonymous union/structure is stored into @anon_offset. Caller
+ * can calculate the correct offset from the root data structure by
+ * adding anon_offset to the member's offset.
+ */
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name,
+						u32 *anon_offset)
+{
+	struct btf_anon_stack *anon_stack;
+	const struct btf_member *member;
+	u32 tid, cur_offset = 0;
+	const char *name;
+	int i, top = 0;
+
+	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
+	if (!anon_stack)
+		return ERR_PTR(-ENOMEM);
+
+retry:
+	if (!btf_type_is_struct(type)) {
+		member = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	for_each_member(i, type, member) {
+		if (!member->name_off) {
+			/* Anonymous union/struct: push it for later use */
+			type = btf_type_skip_modifiers(btf, member->type, &tid);
+			if (type && top < BTF_ANON_STACK_MAX) {
+				anon_stack[top].tid = tid;
+				anon_stack[top++].offset =
+					cur_offset + member->offset;
+			}
+		} else {
+			name = btf_name_by_offset(btf, member->name_off);
+			if (name && !strcmp(member_name, name)) {
+				if (anon_offset)
+					*anon_offset = cur_offset;
+				goto out;
+			}
+		}
+	}
+	if (top > 0) {
+		/* Pop from the anonymous stack and retry */
+		tid = anon_stack[--top].tid;
+		cur_offset = anon_stack[top].offset;
+		type = btf_type_by_id(btf, tid);
+		goto retry;
+	}
+	member = NULL;
+
+out:
+	kfree(anon_stack);
+	return member;
+}
+
 #define BTF_SHOW_MAX_ITER	10
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..64b61f67a403 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -99,7 +99,6 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
-obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
deleted file mode 100644
index ca224d53bfdc..000000000000
--- a/kernel/trace/trace_btf.c
+++ /dev/null
@@ -1,122 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/btf.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-
-#include "trace_btf.h"
-
-/*
- * Find a function proto type by name, and return the btf_type with its btf
- * in *@btf_p. Return NULL if not found.
- * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
- */
-const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
-{
-	const struct btf_type *t;
-	s32 id;
-
-	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
-	if (id < 0)
-		return NULL;
-
-	/* Get BTF_KIND_FUNC type */
-	t = btf_type_by_id(*btf_p, id);
-	if (!t || !btf_type_is_func(t))
-		goto err;
-
-	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
-	t = btf_type_by_id(*btf_p, t->type);
-	if (!t || !btf_type_is_func_proto(t))
-		goto err;
-
-	return t;
-err:
-	btf_put(*btf_p);
-	return NULL;
-}
-
-/*
- * Get function parameter with the number of parameters.
- * This can return NULL if the function has no parameters.
- * It can return -EINVAL if the @func_proto is not a function proto type.
- */
-const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
-{
-	if (!btf_type_is_func_proto(func_proto))
-		return ERR_PTR(-EINVAL);
-
-	*nr = btf_type_vlen(func_proto);
-	if (*nr > 0)
-		return (const struct btf_param *)(func_proto + 1);
-	else
-		return NULL;
-}
-
-#define BTF_ANON_STACK_MAX	16
-
-struct btf_anon_stack {
-	u32 tid;
-	u32 offset;
-};
-
-/*
- * Find a member of data structure/union by name and return it.
- * Return NULL if not found, or -EINVAL if parameter is invalid.
- * If the member is an member of anonymous union/structure, the offset
- * of that anonymous union/structure is stored into @anon_offset. Caller
- * can calculate the correct offset from the root data structure by
- * adding anon_offset to the member's offset.
- */
-const struct btf_member *btf_find_struct_member(struct btf *btf,
-						const struct btf_type *type,
-						const char *member_name,
-						u32 *anon_offset)
-{
-	struct btf_anon_stack *anon_stack;
-	const struct btf_member *member;
-	u32 tid, cur_offset = 0;
-	const char *name;
-	int i, top = 0;
-
-	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
-	if (!anon_stack)
-		return ERR_PTR(-ENOMEM);
-
-retry:
-	if (!btf_type_is_struct(type)) {
-		member = ERR_PTR(-EINVAL);
-		goto out;
-	}
-
-	for_each_member(i, type, member) {
-		if (!member->name_off) {
-			/* Anonymous union/struct: push it for later use */
-			type = btf_type_skip_modifiers(btf, member->type, &tid);
-			if (type && top < BTF_ANON_STACK_MAX) {
-				anon_stack[top].tid = tid;
-				anon_stack[top++].offset =
-					cur_offset + member->offset;
-			}
-		} else {
-			name = btf_name_by_offset(btf, member->name_off);
-			if (name && !strcmp(member_name, name)) {
-				if (anon_offset)
-					*anon_offset = cur_offset;
-				goto out;
-			}
-		}
-	}
-	if (top > 0) {
-		/* Pop from the anonymous stack and retry */
-		tid = anon_stack[--top].tid;
-		cur_offset = anon_stack[top].offset;
-		type = btf_type_by_id(btf, tid);
-		goto retry;
-	}
-	member = NULL;
-
-out:
-	kfree(anon_stack);
-	return member;
-}
-
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
deleted file mode 100644
index 4bc44bc261e6..000000000000
--- a/kernel/trace/trace_btf.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/btf.h>
-
-const struct btf_type *btf_find_func_proto(const char *func_name,
-					   struct btf **btf_p);
-const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
-					   s32 *nr);
-const struct btf_member *btf_find_struct_member(struct btf *btf,
-						const struct btf_type *type,
-						const char *member_name,
-						u32 *anon_offset);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4dc74d73fc1d..b33c424b8ee0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -12,7 +12,7 @@
 #define pr_fmt(fmt)	"trace_probe: " fmt
 
 #include <linux/bpf.h>
-#include "trace_btf.h"
+#include <linux/btf.h>
 
 #include "trace_probe.h"
 


