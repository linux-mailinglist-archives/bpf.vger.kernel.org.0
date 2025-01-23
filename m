Return-Path: <bpf+bounces-49554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E6A19CB2
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7967A6705
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3455CDF1;
	Thu, 23 Jan 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yPKsfpOO"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353202914;
	Thu, 23 Jan 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597598; cv=none; b=Igk4BloYIzOFygr7IxWiV9UggtMrYbNQgqbHkW8DWMIk188U6Vzvwq3Ba+6cneTL1GJPhK/gHqkMQVpBrYwPdGMW5iEqnEdPVX4O2OwIWCsFjD75akKlI0pfFSRQzhQrhSV0N/iA8I0ektEo+Gzsrx/5DzYkWrhMwivvy8uTkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597598; c=relaxed/simple;
	bh=b5l7Uhwy605LBFzXOfuCeWr/EoeeH1tXVvE34YkTew4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzciuYweLwMVn5dT7pW/j3LTC0PMAf60mIy17Yl8XQ8ucTmA9THp8WpMuB7EYo631eatAxRvvZha7rDrszLPc0xy65GUPrkIy1lHoXqWz8Kn+XkKrD7yU9UCNWBfaeAa+oKUOp+PW++VAyHv3KtRpxDJOyes8RTpUJVSwb4XEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yPKsfpOO; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737597593; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fBoUXZhOHulTaSlWjuky3gyPuk4Zonyz3mVwHnwA+hU=;
	b=yPKsfpOOA3savvuWYknEIHE/DcnyNtZ1SnGV58tXcr+i29ovEucHMLo40MpTFTCaW5vp0z70S87b034TuV0oxrdAL6hDRzGLrOD77V5CK/uWhGfvQvhARx+SqTNrvmHwi29UBIiSGuk1hOLDepErQJFb0okzpOLTgg4IkD2k6AU=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WO9yfJ._1737597590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 09:59:51 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	ast@kernel.org,
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
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v7 5/6] libbpf: fix error when st-prefix_ops and ops from differ btf
Date: Thu, 23 Jan 2025 09:59:41 +0800
Message-ID: <20250123015942.94810-6-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250123015942.94810-1-alibuda@linux.alibaba.com>
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a struct_ops named xxx_ops was registered by a module, and
it will be used in both built-in modules and the module itself,
so that the btf_type of xxx_ops will be present in btf_vmlinux
instead of in btf_mod, which means that the btf_type of
bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.

Here are four possible case:

+--------+---------------+-------------+---------------------------------+
|        | st_ops_xxx_ops| xxx_ops     |                                 |
+--------+---------------+-------------+---------------------------------+
| case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux |
+--------+---------------+-------------+---------------------------------+
| case 1 | btf_vmlinux   | bpf_mod     | INVALID                         |
+--------+---------------+-------------+---------------------------------+
| case 2 | btf_mod       | btf_vmlinux | reg in mod but be used both in  |
|        |               |             | vmlinux and mod.                |
+--------+---------------+-------------+---------------------------------+
| case 3 | btf_mod       | btf_mod     | be used and reg only in mod     |
+--------+---------------+-------------+---------------------------------+

At present, cases 0, 1, and 3 can be correctly identified, because
st_ops_xxx_ops is searched from the same btf with xxx_ops. In order to
handle case 2 correctly without affecting other cases, we cannot simply
change the search method for st_ops_xxx_ops from find_btf_by_prefix_kind()
to find_ksym_btf_id(), because in this way, case 1 will not be
recognized anymore.

To address the issue, we always look for st_ops_xxx_ops first,
figure out the btf, and then look for xxx_ops with the very btf to avoid
such issue.

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6c262d0152f8..81f4d65f9c95 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1005,35 +1005,34 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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
@@ -1046,8 +1045,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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


