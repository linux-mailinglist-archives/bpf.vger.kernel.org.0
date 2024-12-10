Return-Path: <bpf+bounces-46479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326D9EA6F3
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A1C282E82
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1F222619E;
	Tue, 10 Dec 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mui6jyZx"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DF2248B2;
	Tue, 10 Dec 2024 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803460; cv=none; b=h1/ywEyqXVEXNy5lmMRR5SS/q/j33o2hIaUloG1S1LA3cp/OcbSz9iuIQ7PpuL24v7AEwhIbABJ/hXhqtOKrSNXHDbtrfi/iVPNe71w2x2imStt7FllOwSN2+lzzWC2s9WsFQsmWZIimxCpQxGx4lrvxBcE9Vv4b6xSqIDO198Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803460; c=relaxed/simple;
	bh=AZOdek+RUNNOrIdFnpTnEdTFyhO7MNA3UCr2W4Qo4WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ysf5ngO4DaSOybnIh0jvDes+Ow2gHjEKA1vPrtxurWNVlVOObzlG6IW26pYSr4HKz5lQ7v0M75tyBfJrcag8o0VdtnyN54CwGsrokU+XwUu9zAp9B1aFTqWvZV/1yRNdVz1ToXpBKSXXEUwIsA2x5zSgFow06RkxaghZt4kg73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mui6jyZx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733803454; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3m/Oe9SBWSoTllrI9BCOOJJsHqYj/BHA8hL2sssyCyE=;
	b=Mui6jyZxjGczQf4SA10vYMxtcpEMGR/irecKq207IL/HHqJiFs6FkiRqazLJvAIosupyj9IQUW2zDh9u533FLcx1aTLTSnb47l/SlSU6Ie9ehJHeCW+O8Rw7sukLN6ySuSu+2mqsd3U6aVw+KFoWMUvLXGB05GED6CgnuCzZ5cg=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDSEYV_1733803452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 12:04:12 +0800
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
Subject: [PATCH bpf-next v2 4/5] libbpf: fix error when st-prefix_ops and ops from differ btf
Date: Tue, 10 Dec 2024 12:04:03 +0800
Message-ID: <20241210040404.10606-5-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241210040404.10606-1-alibuda@linux.alibaba.com>
References: <20241210040404.10606-1-alibuda@linux.alibaba.com>
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
| case 1 | btf_vmlinux | bpf_mod     | INVALID			       |
+--------+-------------+-------------+---------------------------------+
| case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
|        |             |             | vmlinux and mod.		       |
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
 tools/lib/bpf/libbpf.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 66173ddb5a2d..046feab4ec36 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -994,6 +994,27 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
+static int
+find_ksym_btf_id_by_prefix_kind(struct bpf_object *obj, const char *prefix,
+				const char *name,
+				__u16 kind, struct btf **res_btf,
+				struct module_btf **res_mod_btf)
+{
+	char btf_type_name[128];
+	int ret;
+
+	ret = snprintf(btf_type_name, sizeof(btf_type_name),
+		       "%s%s", prefix, name);
+	/* snprintf returns the number of characters written excluding the
+	 * terminating null. So, if >= BTF_MAX_NAME_SIZE are written, it
+	 * indicates truncation.
+	 */
+	if (ret < 0 || ret >= sizeof(btf_type_name))
+		return -ENAMETOOLONG;
+
+	return find_ksym_btf_id(obj, btf_type_name, kind, res_btf, res_mod_btf);
+}
+
 static int
 find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			   struct module_btf **mod_btf,
@@ -1028,9 +1049,16 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
 						tname, BTF_KIND_STRUCT);
 	if (kern_vtype_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
-			STRUCT_OPS_VALUE_PREFIX, tname);
-		return kern_vtype_id;
+		if (kern_vtype_id == -ENOENT && !*mod_btf)
+			kern_vtype_id =
+				find_ksym_btf_id_by_prefix_kind(obj, STRUCT_OPS_VALUE_PREFIX,
+								tname, BTF_KIND_STRUCT, &btf,
+								mod_btf);
+		if (kern_vtype_id < 0) {
+			pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
+				STRUCT_OPS_VALUE_PREFIX, tname);
+			return kern_vtype_id;
+		}
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
 
-- 
2.45.0


