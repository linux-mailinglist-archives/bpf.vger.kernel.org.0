Return-Path: <bpf+bounces-64780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D65B16DD6
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AAA3BCB84
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CA29E11E;
	Thu, 31 Jul 2025 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ymg+jURt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014082BD58F;
	Thu, 31 Jul 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951384; cv=none; b=oz2K2anNXVkemNR2ls2G4rVgJaVm3KiMgmiBDwItX8MHoyMO65qtHa0G7Ki4eczdTXH3+9lhowXRXEWfjZ7kZyG4jQ7JBnqaAwvcD5vAj380QADFNNW0XYnw4uTF28LqGUXSfb+Mkf1JqVmiTjxAuF3rw7eHM9M76mSlGK7qtqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951384; c=relaxed/simple;
	bh=auaBoRoOdgKRbAAHlpim5adsqCB8b4GbLRekHZTKMkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PekdLUvlOawwznbWcghQXhRAfLgVYrAalFlhvn4hMa7h3Ax1t3RaynflZmyDKftzneOyVYAaWvuuQqvAc3eseggSoaLrFv6V8CeeMC0Zy8SllPXB+shUiCAKRjB6igTsaJyGhUBORijN7na9pQeIXOGHDDWyhZdBiPjSdxMBfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ymg+jURt; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753951372; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LNn/p13kNn/f26bzR/bzh+YTQFMHv9uydiGTu6ZrigQ=;
	b=Ymg+jURttMxgt/bOJF+LIhvUpX6ooOkpVGbtHlRFFMuCjrKhnTjmBDDlTnQs4Hd27L65jTfO0aypGqEDsQMFiBA2l72VzSeEPGfZRBFZ8Wf5rN25SSl65SETVXcuby5+UGuRc2PcTiWqIkt65+ZMMcIwt4Bg7q5O4bmj3Zn+cg4=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WkXYUmg_1753951370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 16:42:50 +0800
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
	Mahanta.Jambigi@ibm.com,
	Sidraya.Jayagond@ibm.com,
	wenjia@linux.ibm.com,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	jaka@linux.ibm.com
Subject: [PATCH bpf-next 4/5] libbpf: fix error when st-prefix_ops and ops from differ btf
Date: Thu, 31 Jul 2025 16:42:39 +0800
Message-ID: <20250731084240.86550-5-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250731084240.86550-1-alibuda@linux.alibaba.com>
References: <20250731084240.86550-1-alibuda@linux.alibaba.com>
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
index e067cb5776bd..3cbb6d7aadb1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1013,35 +1013,34 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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
@@ -1054,8 +1053,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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


