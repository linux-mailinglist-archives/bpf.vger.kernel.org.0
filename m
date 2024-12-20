Return-Path: <bpf+bounces-47483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E99F9B14
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C49A1898A9D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292921C180;
	Fri, 20 Dec 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6Rm3AU+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7638DEC
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725915; cv=none; b=ZDs/bx+ZkaTHBmsiO+RGhsijwe/kJldu4kV+SS2eprHRgNk+2njnkFM9dOAqI6J4GCxbTxHVZ4RAR+yR1mA+GjX1EhJhTt3QKnlssVZANnSP7tEz4Mfpn9IOTXcZEuUuZ9/As6Ysh4vrw3v9dQCG7bPwgf/3gTTxMdj+k+fMhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725915; c=relaxed/simple;
	bh=ctZAaWBWTTNYRziwj6wiNjReyeuvQuEq/xEaMdb55io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2/dFQqlOwwzryt4cl+Mj+p4yTWnQOyPq+Ri2ZJKmhydZcqBxONG4p0tTi8W/7gm4wniefgVBzVfx/hy+YDxhsQHgSUkiWyqHdsWX/XiBXOwpkdLQaVpqj5kcKP3bajYtjyopx5z5V87hEhTmXt00qPgiWi+aAWBwoyvLHkRQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6Rm3AU+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734725910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LMP4KKSwTNYOP90oGmJqp0m8f48t4ywQmgh7oUrcPu8=;
	b=Q6Rm3AU+P5prAIbEBaLQRyafGlYhCoM5ha14PwhKMJDJ3/mSWmGC7iVtok+RpROQ2BwoNe
	DBOtuGsfBWmq7AgCAuy287xpoBGlAmDp26QnXK8fFyl56ls3NnBK4hGrXugK8urTSYwOEs
	KLi3xq1cNgsr3x8eeHANNNk0l5xzWGM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH bpf-next] bpf: Reject struct_ops registration that uses module ptr and the module btf_id is missing
Date: Fri, 20 Dec 2024 12:18:18 -0800
Message-ID: <20241220201818.127152-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

There is a UAF report in the bpf_struct_ops when CONFIG_MODULES=n.
In particular, the report is on tcp_congestion_ops that has
a "struct module *owner" member.

For struct_ops that has a "struct module *owner" member,
it can be extended either by the regular kernel module or
by the bpf_struct_ops. bpf_try_module_get() will be used
to do the refcounting and different refcount is done
based on the owner pointer. When CONFIG_MODULES=n,
the btf_id of the "struct module" is missing:

WARN: resolve_btfids: unresolved symbol module

Thus, the bpf_try_module_get() cannot do the correct refcounting.

Not all subsystem's struct_ops requires the "struct module *owner" member.
e.g. the recent sched_ext_ops.

This patch is to disable bpf_struct_ops registration if
the struct_ops has the "struct module *" member and the
"struct module" btf_id is missing. The btf_type_is_fwd() helper
is moved to the btf.h header file for this test.

This has happened since the beginning of bpf_struct_ops which has gone
through many changes. The Fixes tag is set to a recent commit that this
patch can apply cleanly. Considering CONFIG_MODULES=n is not
common and the age of the issue, targeting for bpf-next also.

Fixes: 1611603537a4 ("bpf: Create argument information for nullable arguments.")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/bpf/74665.1733669976@localhost/
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/btf.h         |  5 +++++
 kernel/bpf/bpf_struct_ops.c | 21 +++++++++++++++++++++
 kernel/bpf/btf.c            |  5 -----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..2a08a2b55592 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -353,6 +353,11 @@ static inline bool btf_type_is_scalar(const struct btf_type *t)
 	return btf_type_is_int(t) || btf_type_is_enum(t);
 }
 
+static inline bool btf_type_is_fwd(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
+}
+
 static inline bool btf_type_is_typedef(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 606efe32485a..040fb1cd840b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -310,6 +310,20 @@ void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 	kfree(arg_info);
 }
 
+static bool is_module_member(const struct btf *btf, u32 id)
+{
+	const struct btf_type *t;
+
+	t = btf_type_resolve_ptr(btf, id, NULL);
+	if (!t)
+		return false;
+
+	if (!__btf_type_is_struct(t) && !btf_type_is_fwd(t))
+		return false;
+
+	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
@@ -389,6 +403,13 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			goto errout;
 		}
 
+		if (!st_ops_ids[IDX_MODULE_ID] && is_module_member(btf, member->type)) {
+			pr_warn("'struct module' btf id not found. Is CONFIG_MODULES enabled? bpf_struct_ops '%s' needs module support.\n",
+				st_ops->name);
+			err = -EOPNOTSUPP;
+			goto errout;
+		}
+
 		func_proto = btf_type_resolve_func_ptr(btf,
 						       member->type,
 						       NULL);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 28246c59e12e..8396ce1d0fba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -498,11 +498,6 @@ bool btf_type_is_void(const struct btf_type *t)
 	return t == &btf_void;
 }
 
-static bool btf_type_is_fwd(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
-}
-
 static bool btf_type_is_datasec(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
-- 
2.43.5


