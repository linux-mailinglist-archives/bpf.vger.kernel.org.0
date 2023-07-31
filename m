Return-Path: <bpf+bounces-6411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41DD768EC3
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214411C208F3
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F4E613F;
	Mon, 31 Jul 2023 07:30:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3666612C
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE2DC433C7;
	Mon, 31 Jul 2023 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690788639;
	bh=ZxqLQEDqyrTI+b7ozLCG2peyd8pHZudlPd6y62zwtWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpZUtMBGR106BHm0aj2xR7/CzYRk5wdguE7xIfK2kjju17dMC1Ve8PY4G1GNYkn8P
	 2LV0DgD+0uZ2JB2OfOKjP2TNXSwEacmeNU3iq2kQ+BM124AGnkMCwl8LK9dVJYNTbC
	 eFZeK+jAz/1F9dBubKz5HaIaUNZyIsrk24FSMnmUWFXms6R1GFjXeVNp/oo5KiJ3di
	 U3q5sCGsPnRGezK13vAsoxDPYLDL5D05+ljYET+h3qXjCOkCteT/bH7ZnIA/brGmOm
	 pqUNLdUbGklzV2bIIs7RMX7T6iRZx6uu6BEa2Kx/6E0Ss/2t35rnt8vNq0+atuBnuJ
	 dnNS988aIFc4A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
Date: Mon, 31 Jul 2023 16:30:34 +0900
Message-Id: <169078863449.173706.2322042687021909241.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169078860386.173706.3091034523220945605.stgit@devnote2>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
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
---
 include/linux/btf.h |    3 +++
 kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 20e3a07eef8f..4b10d57ceee0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
 					   struct btf **btf_p);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 					   s32 *nr);
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7b25c615269..8d81a4ffa67b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
 		return NULL;
 }
 
+#define BTF_ANON_STACK_MAX	16
+
+/*
+ * Find a member of data structure/union by name and return it.
+ * Return NULL if not found, or -EINVAL if parameter is invalid.
+ */
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name)
+{
+	const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
+	const struct btf_member *member;
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
+			type = btf_type_skip_modifiers(btf, member->type, NULL);
+			if (type && top < BTF_ANON_STACK_MAX)
+				anon_stack[top++] = type;
+		} else {
+			name = btf_name_by_offset(btf, member->name_off);
+			if (name && !strcmp(member_name, name))
+				return member;
+		}
+	}
+	if (top > 0) {
+		/* Pop from the anonymous stack and retry */
+		type = anon_stack[--top];
+		goto retry;
+	}
+
+	return NULL;
+}
+
 #define BTF_SHOW_MAX_ITER	10
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)


