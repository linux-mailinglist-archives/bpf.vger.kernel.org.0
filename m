Return-Path: <bpf+bounces-47907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6ABA01D55
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0F31622B5
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 02:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509F86353;
	Mon,  6 Jan 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EpC6Jat1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DB3224;
	Mon,  6 Jan 2025 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130162; cv=none; b=IN4zpgXW8kvplUY4xMWxsBIRR/MshgKmhkmX5RxxGuuHi2cpH3oBbkZ/rMwEf602wSuB9+D8u2Hqm278ZdH4Fist0vvpVOpNvGD+U3yjJCXIYp2mB1XoYjPf8YZNS2Kx5dXt4PjN2owF+N087gVEq9YyyG6vPHyt+qq3k+H0fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130162; c=relaxed/simple;
	bh=mJZToL78iwJ+MCIKU4dt4auK5Nd4QsNRcDUFMLBHKB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYukQgB+oCgMxmrIldYSNhjYkA1c7H/sRhP7HRA2C02KYvEVhy/FYhTxCJCmVTLgHlmCjutiqejQMRlPg4EmhPPJzETOW/cpsptyWdEh5hj5fAJReEIIqmOWbC2RftW8v7aQ4OzHV8X3rU0DNGO58CS8ni4Bsamd28WA4/34BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EpC6Jat1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736130156; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=y1jg5AwJB+GR83pd0hp8N7m53aNa6Qo3Q03Y+OmDbzc=;
	b=EpC6Jat1OS/35I9MH39+RNI9UzmA7eJgcfjsFYgG2f0pSGx6bLMVf+jpzy294aUSkN8vV3h2HsV2v1Ni+nfYdAgKpS3pfRfGG6blVokRmraj+S/mNykQe5ddD2hfZpETfq8KouefxkIi/RdE5ZcL8U4fK5laDjbLqiJu8PTZ2qQ=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WMzlXYw_1736130153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 10:22:33 +0800
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
Subject: [PATCH bpf-next v4 4/5] libbpf: fix error when st-prefix_ops and ops from differ btf
Date: Mon,  6 Jan 2025 10:22:21 +0800
Message-ID: <20250106022222.80203-5-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250106022222.80203-1-alibuda@linux.alibaba.com>
References: <20250106022222.80203-1-alibuda@linux.alibaba.com>
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

+--------+-------------+-------------+---------------------------------+
|        | st_opx_xxx  | xxx         |                                 |
+--------+-------------+-------------+---------------------------------+
| case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
+--------+-------------+-------------+---------------------------------+
| case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
+--------+-------------+-------------+---------------------------------+
| case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
|        |             |             | vmlinux and mod.                |
+--------+-------------+-------------+---------------------------------+
| case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
+--------+-------------+-------------+---------------------------------+

At present, cases 0, 1, and 3 can be correctly identified, because
st_ops_xxx is searched from the same btf with xxx. In order to
handle case 2 correctly without affecting other cases, we cannot simply
change the search method for st_ops_xxx from find_btf_by_prefix_kind()
to find_ksym_btf_id(), because in this way, case 1 will not be
recognized anymore.

To address this issue, if st_ops_xxx cannot be found in the btf with xxx
and mod_btf does not exist, do find_ksym_btf_id() again to
avoid such issue.

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 tools/lib/bpf/libbpf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..56bf74894110 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1005,7 +1005,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 	const struct btf_member *kern_data_member;
 	struct btf *btf = NULL;
 	__s32 kern_vtype_id, kern_type_id;
-	char tname[256];
+	char tname[256], stname[256];
+	int ret;
 	__u32 i;
 
 	snprintf(tname, sizeof(tname), "%.*s",
@@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 	}
 	kern_type = btf__type_by_id(btf, kern_type_id);
 
+	ret = snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
+	if (ret < 0 || ret >= sizeof(stname))
+		return -ENAMETOOLONG;
+
 	/* Find the corresponding "map_value" type that will be used
 	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
 	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
 	 * btf_vmlinux.
 	 */
-	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
-						tname, BTF_KIND_STRUCT);
+	kern_vtype_id = btf__find_by_name_kind(btf, stname, BTF_KIND_STRUCT);
 	if (kern_vtype_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
-			STRUCT_OPS_VALUE_PREFIX, tname);
-		return kern_vtype_id;
+		if (kern_vtype_id == -ENOENT && !*mod_btf)
+			kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT,
+							 &btf, mod_btf);
+		if (kern_vtype_id < 0) {
+			pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
+				stname);
+			return kern_vtype_id;
+		}
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
 
@@ -1046,8 +1055,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
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


