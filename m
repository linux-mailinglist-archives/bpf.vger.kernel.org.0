Return-Path: <bpf+bounces-7114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC10771884
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 04:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8213728110E
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146EA816;
	Mon,  7 Aug 2023 02:55:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD29A41
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 02:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC5AC433C7;
	Mon,  7 Aug 2023 02:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691376903;
	bh=rV1bOw0hiZEtTOaUVe7fSzFVckAJ245a4sD8LTyT1SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCZG/V3fcbZVNuMOaTj3EJJObTyrXo5Q4DaxzsTy7pvcVIHUFsu1FKiF5Hu5cc+MY
	 LcKUM95FijXPv+8p5I+hYNeoi8YsfasDjOC/teENOMP50uosuuXwTq0XH/aMPN6nv2
	 YkocZgQOhBO706c6uE51VhTbz7YaOXjPiG2tbgYfYmrxrXBkrK9Md+3A3QQc1hRKof
	 wOl1toGSyJ6TDnj44HCBykS5FII3CYI456r7PDovemhXAUzXrDmfvOHEo82M245tcO
	 UVa0qEtZuw0B1Jpl+y2QW6uR/hDz6ZIwBTklAaeU63ciMMDH9+zCVR3ekCOVxjjTSD
	 k3aLJxZAK5uOA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v5 3/9] tracing/probes: Add a function to search a member of a struct/union
Date: Mon,  7 Aug 2023 11:54:58 +0900
Message-Id: <169137689818.271367.4200174950023036516.stgit@devnote2>
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

Add btf_find_struct_member() API to search a member of a given data structure
or union from the member's name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
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
---
 kernel/trace/trace_btf.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h |    4 +++
 2 files changed, 61 insertions(+)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 82cbbeeda071..109a238437cf 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -50,3 +50,60 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
 		return NULL;
 }
 
+#define BTF_ANON_STACK_MAX	16
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
+	struct {
+		u32 tid;
+		u32 offset;
+	} anon_stack[BTF_ANON_STACK_MAX];
+	const struct btf_member *member;
+	u32 tid, cur_offset = 0;
+	const char *name;
+	int i, top = 0;
+
+retry:
+	if (!btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
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
+				return member;
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
+
+	return NULL;
+}
+
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 2ef1b2367e1e..fb2919a74225 100644
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


