Return-Path: <bpf+bounces-8270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7EA784777
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A3D281136
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABA1DDDF;
	Tue, 22 Aug 2023 16:26:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65E1D2E6
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C10C433C8;
	Tue, 22 Aug 2023 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692721567;
	bh=M0yvt9XhZlKteG4rq6911+5kqkZiiyrV8Vdh/k3iy5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cnr1S/Sy+0F8FIgeXlSiDjs0zBxioLjRU8WEycgszF7j8sH3oAV19R6G/LCSqP5MX
	 bq0bNyiiZInyYvTzj5cbMQ358j/IzLo6XaImnUW71BV0tyknHqFTG8NTczk9gwr7hH
	 QZKVkYVzg5dHAySTy6lpfkkb1gtqYhEA2eo8UoggUwy8+4LuQ8x647hWn+EyMG9iIp
	 AWql+EFY8AmMU2NM520W3qAfpzxcnnu+jM8h5mGqkS0DuGNpXjNoOIDfJbSd2iawVB
	 ee8y5q1hQQKAJlnLtP6wKxsjVzsUnhnesHIO8WwFm+etWOrfhyMGrY+9VmsFiUajZM
	 ShenasIwP0G7g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 3/9] tracing/probes: Add a function to search a member of a struct/union
Date: Wed, 23 Aug 2023 01:26:02 +0900
Message-Id: <169272156248.160970.8868479822371129043.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169272153143.160970.15584603734373446082.stgit@devnote2>
References: <169272153143.160970.15584603734373446082.stgit@devnote2>
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

Add btf_find_struct_member() API to search a member of a given data structure
or union from the member's name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes in v3:
  - Remove simple input check.
  - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
  - Move the code next to btf_get_func_param().
  - Use for_each_member() macro instead of for-loop.
  - Use btf_type_skip_modifiers() instead of btf_type_by_id().
 Changes in v4:
  - Use a stack for searching in anonymous members instead of nested call.
 Changes in v5:
  - Move the generic functions into a new file, trace_btf.c, for avoiding
    tree-merge conflict.
  - Return anon_offset for calculating correct offset from root struct.
 Changes in v6:
  - Allocate anon_stack from heap instead of stack.
---
 kernel/trace/trace_btf.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h |    4 +++
 2 files changed, 73 insertions(+)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index d70b8ee9af37..ca224d53bfdc 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/btf.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 
 #include "trace_btf.h"
 
@@ -51,3 +52,71 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
 		return NULL;
 }
 
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
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 98685e9a556c..4bc44bc261e6 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -5,3 +5,7 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
 					   struct btf **btf_p);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 					   s32 *nr);
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name,
+						u32 *anon_offset);


