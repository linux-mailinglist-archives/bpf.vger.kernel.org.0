Return-Path: <bpf+bounces-5944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D67636F4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3651C21269
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A44BE7B;
	Wed, 26 Jul 2023 13:00:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA7A49
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD9C433CA;
	Wed, 26 Jul 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690376427;
	bh=DWqlMr8roXaG6O8LFsOi9Etaux6ORDbs/Xvw8dSo2Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2bN3agznoFdF/wMEce7jdyTpYWz8GBbGxgTIcPZJqydyJAektpDOCPqIQh0fJlC4
	 JWlE1IunzI4uieM1xAE+O0/u3s0QeVPagK9RLHm5vFErscdIxVLqPFFqEmG/smokX4
	 hDrNXUQtTs9ImiQC3NF24CZboALsPDHqEhyP4nQ/qst8XE5mmb7qkdzvCb4br6hhXa
	 O3afaZZTfvoWkcQztesj3DfKP6od9+IjCDOIZxTCAqCVWbCq5DG6ZkjWkwRqW6wU++
	 nDft2uFtZTAkq8v9AMK5UHhXTXeV2nIP1eE+PM5xCqZrvEcHuYY6fVYFrORF26EZfd
	 zxsBJSo+9+yQA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 3/9] bpf/btf: Add a function to search a member of a struct/union
Date: Wed, 26 Jul 2023 22:00:23 +0900
Message-Id: <169037642351.607919.10234149030120807556.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169037639315.607919.2613476171148037242.stgit@devnote2>
References: <169037639315.607919.2613476171148037242.stgit@devnote2>
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
---
 include/linux/btf.h |    3 +++
 kernel/bpf/btf.c    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index f7b25c615269..5258870030fc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -958,6 +958,41 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
 		return NULL;
 }
 
+/*
+ * Find a member of data structure/union by name and return it.
+ * Return NULL if not found, or -EINVAL if parameter is invalid.
+ */
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name)
+{
+	const struct btf_member *member, *ret;
+	const char *name;
+	int i;
+
+	if (!btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
+
+	for_each_member(i, type, member) {
+		if (!member->name_off) {
+			/* unnamed member: dig deeper */
+			type = btf_type_skip_modifiers(btf, member->type, NULL);
+			if (type) {
+				ret = btf_find_struct_member(btf, type,
+							     member_name);
+				if (!IS_ERR_OR_NULL(ret))
+					return ret;
+			}
+		} else {
+			name = btf_name_by_offset(btf, member->name_off);
+			if (name && !strcmp(member_name, name))
+				return member;
+		}
+	}
+
+	return NULL;
+}
+
 #define BTF_SHOW_MAX_ITER	10
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)


