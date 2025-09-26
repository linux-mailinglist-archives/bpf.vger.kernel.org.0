Return-Path: <bpf+bounces-69806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C949BA2AD5
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3867B7926
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 07:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285B2868AC;
	Fri, 26 Sep 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ew0z7Eoj"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AF276028;
	Fri, 26 Sep 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871088; cv=none; b=oh4XZYYyj36v5LVtirfI/SCo6VxVT80WEE1/YsDg6uqQtWeVnc05DA3k3uWPuMG+6JEuuG8CBYTLGrw1/5jusCI3K+ntQSP40zI9eJUUYsj5td8GgXqTeutf4zs6TR3JvG4czMV8FuypE1aN3dnnGLqg9Q+AXpa44R8/3DAC9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871088; c=relaxed/simple;
	bh=DZSiNp4mUrgSOCnWr/OoNntVV0aK9bR5xT1y3MmSL7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COhb4JYpdB8nI7jKSFNC2zFpCArVa44tUvtVtdb591NKjI3cIBqj9rBWNOSoI6dUCYKrV35aLlNJxB/+k6bEuurIxS+QpXrK6lkBJFtKN0VlO0FUdEayFPo09jxfBd3p1FFGeVaYkgcZsF/NExleoflughUZ98IjqvaFyaij9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ew0z7Eoj; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758871077; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GbWobDZaSf9PqXPbbZ1rtsOM9VENhukO3OXKCzullK8=;
	b=ew0z7EojK5P+5BzSOmJK61U1VFPATHn5nwzZpK1Tpa1y4dWOEWMsgqNCcrjoNfWcgtofksIf8hxyYMScRaTMMMu1MLxaJj1phUJn2g39h+RmRsecQqFUV7Ue6TavUV6Pi/Jim6ChvttHqkldkIa7vPHnfxLHyntWLqmE6nc/1oI=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WorI9XE_1758871071 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 15:17:55 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	yhs@fb.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next] libbpf: fix error when st-prefix_ops and ops from differ btf
Date: Fri, 26 Sep 2025 15:17:51 +0800
Message-ID: <20250926071751.108293-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a module registers a struct_ops, the struct_ops type and its
corresponding map_value type ("bpf_struct_ops_") may reside in different
btf objects, here are four possible case:

+--------+---------------+-------------+---------------------------------+
|        |bpf_struct_ops_| xxx_ops     |                                 |
+--------+---------------+-------------+---------------------------------+
| case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux |
+--------+---------------+-------------+---------------------------------+
| case 1 | btf_vmlinux   | mod_btf     | INVALID                         |
+--------+---------------+-------------+---------------------------------+
| case 2 | mod_btf       | btf_vmlinux | reg in mod but be used both in  |
|        |               |             | vmlinux and mod.                |
+--------+---------------+-------------+---------------------------------+
| case 3 | mod_btf       | mod_btf     | be used and reg only in mod     |
+--------+---------------+-------------+---------------------------------+

Currently we figure out the mod_btf by searching with the struct_ops type,
which makes it impossible to figure out the mod_btf when the struct_ops
type is in btf_vmlinux while it's corresponding map_value type is in
mod_btf (case 2).

The fix is to use the corresponding map_value type ("bpf_struct_ops_")
as the lookup anchor instead of the struct_ops type to figure out the
`btf` and `mod_btf` via find_ksym_btf_id(), and then we can locate
the kern_type_id via btf__find_by_name_kind() with the `btf` we just
obtained from find_ksym_btf_id().

With this change the lookup obtains the correct btf and mod_btf for case 2,
preserves correct behavior for other valid cases, and still fails as
expected for the invalid scenario (case 1).

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5161c2b39875..a93eed660404 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1018,35 +1018,34 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 	const struct btf_member *kern_data_member;
 	struct btf *btf = NULL;
 	__s32 kern_vtype_id, kern_type_id;
-	char tname[256];
+	char tname[256], stname[256];
 	__u32 i;
 
 	snprintf(tname, sizeof(tname), "%.*s",
 		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
 
-	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
-					&btf, mod_btf);
-	if (kern_type_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
-			tname);
-		return kern_type_id;
-	}
-	kern_type = btf__type_by_id(btf, kern_type_id);
+	snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFIX,
+		 (int)strlen(tname), tname);
 
-	/* Find the corresponding "map_value" type that will be used
-	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
-	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
-	 * btf_vmlinux.
+	/* Look for the corresponding "map_value" type that will be used
+	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the btf
+	 * and the mod_btf.
+	 * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
 	 */
-	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
-						tname, BTF_KIND_STRUCT);
+	kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT, &btf, mod_btf);
 	if (kern_vtype_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
-			STRUCT_OPS_VALUE_PREFIX, tname);
+		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", stname);
 		return kern_vtype_id;
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
 
+	kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+	if (kern_type_id < 0) {
+		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", tname);
+		return kern_type_id;
+	}
+	kern_type = btf__type_by_id(btf, kern_type_id);
+
 	/* Find "struct tcp_congestion_ops" from
 	 * struct bpf_struct_ops_tcp_congestion_ops {
 	 *	[ ... ]
@@ -1059,8 +1058,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			break;
 	}
 	if (i == btf_vlen(kern_vtype)) {
-		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
-			tname, STRUCT_OPS_VALUE_PREFIX, tname);
+		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
+			tname, stname);
 		return -EINVAL;
 	}
 
-- 
2.45.0


