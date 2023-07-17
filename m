Return-Path: <bpf+bounces-5104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C07567C9
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB988281168
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF80253DC;
	Mon, 17 Jul 2023 15:23:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE492AD26
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 15:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01632C433C7;
	Mon, 17 Jul 2023 15:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689607431;
	bh=DHVTx0hal1LvLnlrU3Axy5dJ3lhJGA8GVR5jpKF4jhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZxXXYzhpZFBO4M4QHLtv7C4cVPWjYG+Kxb00IplTDMV86B0B6fGIxBzZRmFSo6D1
	 NMxlH4ildfklCTLfMXMMXlphdUGZtGnd7tNhC8Fz4TNpxHvUabQl8epBQTkfYOb/0z
	 Hd0QDoaUQkV9YYBj3u0+pqgY33fQcPevyU6Ru+K5neL41+cDZDRRi8LDpIcBI4AW7D
	 YxAicfJQoPumhr3nQBUKYYzP0YTX/Qe7y5lAxpAlbR6ModDj6QiVRiwBuSAIYUChA3
	 k+tFZP1TvFrlYMSfUAp0VAyGdPU8geUq9qFTejBDEQ2WeFaJO6JO7dXUGAC96syKBf
	 qoAES80/9i45A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 3/9] bpf/btf: Add a function to search a member of a struct/union
Date: Tue, 18 Jul 2023 00:23:47 +0900
Message-Id: <168960742712.34107.9849785489776347376.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
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
---
 include/linux/btf.h |    3 +++
 kernel/bpf/btf.c    |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 98fbbcdd72ec..097fe9b51562 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -225,6 +225,9 @@ const struct btf_type *btf_find_func_proto(struct btf *btf,
 					   const char *func_name);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 					   s32 *nr);
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e015b52956cb..452ffb0393d6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1992,6 +1992,44 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
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
+	const struct btf_member *members, *ret;
+	const char *name;
+	int i, vlen;
+
+	if (!btf || !member_name || !btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
+
+	vlen = btf_type_vlen(type);
+	members = (const struct btf_member *)(type + 1);
+
+	for (i = 0; i < vlen; i++) {
+		if (!members[i].name_off) {
+			/* unnamed union: dig deeper */
+			type = btf_type_by_id(btf, members[i].type);
+			if (!IS_ERR_OR_NULL(type)) {
+				ret = btf_find_struct_member(btf, type,
+							     member_name);
+				if (!IS_ERR_OR_NULL(ret))
+					return ret;
+			}
+		} else {
+			name = btf_name_by_offset(btf, members[i].name_off);
+			if (name && !strcmp(member_name, name))
+				return &members[i];
+		}
+	}
+
+	return NULL;
+}
+
 static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
 {
 	while (type_id < btf->start_id)


