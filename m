Return-Path: <bpf+bounces-27703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCE8B0F15
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE02957B6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6116D9D2;
	Wed, 24 Apr 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L47y7f5e"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A616D4E5
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973777; cv=none; b=aem72Q9MxNUvslOWizBRrcCkMOixRhAEog7OM3s/FFtEIMD7ziBg0f+6ESR7CbDqMgun/e8hX1FwxkR6AFMu7g4S/QIpyclqWMeQEwArIwZlabjk3RrPaveowYGxmgg0VwJMSIxT0HpijkPXEa/TT6xxWZz5fh69bdVLOgUF1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973777; c=relaxed/simple;
	bh=sqYw1gf30HYbeH6v0/pi81thPgpckdN8mMbX9WBWPsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYaE5bDKBTlGr4fkD73UZOUgkV8KTxZB7BqIZs7ueRjV3La3lUDGOv9VNgMMjFGccv8SFSqu51drrHgVzoOuAweSjpwam279AS/WfBy3HaE9Wl38cyI+nLuTngORW8IqsDzJ2Pw+PIE/9Ar0EGZIv6NyOQMkL70lu3F0zQQN9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L47y7f5e; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFm8Dl009699;
	Wed, 24 Apr 2024 15:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=EgUGl9Rz7betOOk0UaDJwL3d2atUaBAz19C2JavFdjI=;
 b=L47y7f5eg5Go21naD+kkUXpz6oe3bAJjuwWelMCRVei2UXFvg2MegSxHt0zrCK3eHafF
 xdSDd9ovcS1dKo6qn0fuyu4+mFj7tf9LR5LhwtBr6gEoiED0bAcpRNToackARFOJmNmB
 9x1DBrqh47a/osQ7pS+8DPqaSyh7hGRgrvr1NKs+VTfAjOJ5anmT7PzlAeQEWpCNYOVH
 RutyOD2HRFv8+hpOEY8gxWW/z40DNnqpklagzH5DxWPTUkFLiwOlNp100puQ6G2YCN5g
 TrE0V2C5GRrunNQotjOkH5dks7S47CkZs68oPYAA1DUXuNVSc0jp4w3AUdKqq4ZFnntw mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbs3vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:49:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFmTC9025314;
	Wed, 24 Apr 2024 15:49:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fb0g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:49:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCok008769;
	Wed, 24 Apr 2024 15:49:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-12;
	Wed, 24 Apr 2024 15:49:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 11/13] libbpf,bpf: share BTF relocate-related code with kernel
Date: Wed, 24 Apr 2024 16:48:04 +0100
Message-Id: <20240424154806.3417662-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: 7BU1Ylnl5L3JEY1OD6WHDphG0_xud7iA
X-Proofpoint-ORIG-GUID: 7BU1Ylnl5L3JEY1OD6WHDphG0_xud7iA

Share relocation implementation with the kernel.  As part of this,
we also need the type/string visitation functions so add them to a
btf_common.c file that also gets shared with the kernel. Relocation
code in kernel and userspace is identical save for the impementation
of the reparenting of split BTF to the relocated base BTF; this
depends on struct btf internals so is different in kernel and
userspace.

One other wrinkle on the kernel side is we have to map .BTF.ids in
modules as they were generated with the type ids used at BTF encoding
time. btf_relocate() optionally returns an array mapping from old BTF
ids to relocated ids, so we use that to fix up these references where
needed for kfuncs.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h          |  32 +++++
 kernel/bpf/Makefile          |   8 ++
 kernel/bpf/btf.c             | 227 ++++++++++++++++++++++++++++-------
 tools/lib/bpf/Build          |   2 +-
 tools/lib/bpf/btf.c          | 130 --------------------
 tools/lib/bpf/btf_common.c   | 146 ++++++++++++++++++++++
 tools/lib/bpf/btf_relocate.c |  29 +++++
 7 files changed, 399 insertions(+), 175 deletions(-)
 create mode 100644 tools/lib/bpf/btf_common.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..1cc20844f163 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -214,6 +214,7 @@ bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+struct btf *btf_base_btf(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
@@ -515,8 +516,15 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
 }
 #endif
 
+typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
+typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
+
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
+int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx);
+int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
@@ -543,6 +551,30 @@ static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 {
 	return NULL;
 }
+
+static inline int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
+{
+	return 0;
+}
+
+static inline int btf_relocate(void *log, struct btf *btf, const struct btf *base_btf,
+			       __u32 **map_ids)
+{
+	return 0;
+}
+
+static inline int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit,
+					  void *ctx)
+{
+	return 0;
+}
+
+static inline int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit,
+					  void *ctx)
+{
+	return 0;
+}
+
 static inline const char *btf_name_by_offset(const struct btf *btf,
 					     u32 offset)
 {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 368c5d86b5b7..d705dbe2b226 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -49,3 +49,11 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_SYSCALL) += btf_common.o
+$(obj)/btf_common.o: $(srctree)/tools/lib/bpf/btf_common.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
+$(obj)/btf_relocate.o: $(srctree)/tools/lib/bpf/btf_relocate.c FORCE
+	$(call if_changed_rule,cc_o_c)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8291fbfd27b1..2f304b77bab4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -273,6 +273,7 @@ struct btf {
 	u32 start_str_off; /* first string offset (0 for base BTF) */
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
+	__u32 *base_map; /* map from distilled base BTF -> vmlinux BTF ids */
 };
 
 enum verifier_phase {
@@ -1734,7 +1735,13 @@ static void btf_free(struct btf *btf)
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
-	kvfree(btf->data);
+	/* only split BTF allocates data, but btf->data is non-NULL for
+	 * vmlinux BTF too.
+	 */
+	if (btf->base_btf)
+		kvfree(btf->data);
+	if (btf->kernel_btf)
+		kvfree(btf->base_map);
 	kfree(btf);
 }
 
@@ -1763,6 +1770,90 @@ void btf_put(struct btf *btf)
 	}
 }
 
+struct btf *btf_base_btf(const struct btf *btf)
+{
+	return btf->base_btf;
+}
+
+struct btf_rewrite_strs {
+	struct btf *btf;
+	const struct btf *old_base_btf;
+	int str_start;
+	int str_diff;
+	__u32 *str_map;
+};
+
+static __u32 btf_find_str(struct btf *btf, const char *s)
+{
+	__u32 offset = 0;
+
+	while (offset < btf->hdr.str_len) {
+		while (!btf->strings[offset])
+			offset++;
+		if (strcmp(s, &btf->strings[offset]) == 0)
+			return offset;
+		while (btf->strings[offset])
+			offset++;
+	}
+	return -ENOENT;
+}
+
+static int btf_rewrite_strs(__u32 *str_off, void *ctx)
+{
+	struct btf_rewrite_strs *r = ctx;
+	const char *s;
+	int off;
+
+	if (!*str_off)
+		return 0;
+	if (*str_off >= r->str_start) {
+		*str_off += r->str_diff;
+	} else {
+		s = btf_str_by_offset(r->old_base_btf, *str_off);
+		if (!s)
+			return -ENOENT;
+		if (r->str_map[*str_off]) {
+			off = r->str_map[*str_off];
+		} else {
+			off = btf_find_str(r->btf->base_btf, s);
+			if (off < 0)
+				return off;
+			r->str_map[*str_off] = off;
+		}
+		*str_off = off;
+	}
+	return 0;
+}
+
+int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
+{
+	struct btf_rewrite_strs r = {};
+	struct btf_type *t;
+	int i, err;
+
+	r.old_base_btf = btf_base_btf(btf);
+	if (!r.old_base_btf)
+		return -EINVAL;
+	r.btf = btf;
+	r.str_start = r.old_base_btf->hdr.str_len;
+	r.str_diff = base_btf->hdr.str_len - r.old_base_btf->hdr.str_len;
+	r.str_map = kvcalloc(r.old_base_btf->hdr.str_len, sizeof(*r.str_map),
+			     GFP_KERNEL | __GFP_NOWARN);
+	if (!r.str_map)
+		return -ENOMEM;
+	btf->base_btf = base_btf;
+	btf->start_id = btf_nr_types(base_btf);
+	btf->start_str_off = base_btf->hdr.str_len;
+	for (i = 0; i < btf->nr_types; i++) {
+		t = (struct btf_type *)btf_type_by_id(btf, i + btf->start_id);
+		err = btf_type_visit_str_offs((struct btf_type *)t, btf_rewrite_strs, &r);
+		if (err)
+			break;
+	}
+	kvfree(r.str_map);
+	return err;
+}
+
 static int env_resolve_init(struct btf_verifier_env *env)
 {
 	struct btf *btf = env->btf;
@@ -5981,23 +6072,15 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 BTF_ID_LIST(bpf_ctx_convert_btf_id)
 BTF_ID(struct, bpf_ctx_convert)
 
-struct btf *btf_parse_vmlinux(void)
+static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name,
+				  void *data, unsigned int data_size)
 {
-	struct btf_verifier_env *env = NULL;
-	struct bpf_verifier_log *log;
 	struct btf *btf = NULL;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
 		return ERR_PTR(-ENOENT);
 
-	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
-	if (!env)
-		return ERR_PTR(-ENOMEM);
-
-	log = &env->log;
-	log->level = BPF_LOG_KERNEL;
-
 	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
 	if (!btf) {
 		err = -ENOMEM;
@@ -6005,10 +6088,10 @@ struct btf *btf_parse_vmlinux(void)
 	}
 	env->btf = btf;
 
-	btf->data = __start_BTF;
-	btf->data_size = __stop_BTF - __start_BTF;
+	btf->data = data;
+	btf->data_size = data_size;
 	btf->kernel_btf = true;
-	snprintf(btf->name, sizeof(btf->name), "vmlinux");
+	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
 	if (err)
@@ -6028,20 +6111,11 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
-	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
-	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
-
 	refcount_set(&btf->refcnt, 1);
 
-	err = btf_alloc_id(btf);
-	if (err)
-		goto errout;
-
-	btf_verifier_env_free(env);
 	return btf;
 
 errout:
-	btf_verifier_env_free(env);
 	if (btf) {
 		kvfree(btf->types);
 		kfree(btf);
@@ -6049,19 +6123,59 @@ struct btf *btf_parse_vmlinux(void)
 	return ERR_PTR(err);
 }
 
+struct btf *btf_parse_vmlinux(void)
+{
+	struct btf_verifier_env *env = NULL;
+	struct bpf_verifier_log *log;
+	struct btf *btf;
+	int err;
+
+	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
+	if (!env)
+		return ERR_PTR(-ENOMEM);
+
+	log = &env->log;
+	log->level = BPF_LOG_KERNEL;
+	btf = btf_parse_base(env, "vmlinux", __start_BTF, __stop_BTF - __start_BTF);
+	if (!IS_ERR(btf)) {
+		/* btf_parse_vmlinux() runs under bpf_verifier_lock */
+		bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
+		err = btf_alloc_id(btf);
+		if (err) {
+			btf_free(btf);
+			btf = ERR_PTR(err);
+		}
+	}
+	btf_verifier_env_free(env);
+	return btf;
+}
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
-static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
+/* If .BTF_ids section was created with distilled base BTF, both base and
+ * split BTF ids will need to be mapped to actual base/split ids for
+ * BTF now that it has been relocated.
+ */
+static __u32 btf_id_map(const struct btf *btf, __u32 id)
+{
+	if (!btf->base_btf || !btf->base_map)
+		return id;
+	return btf->base_map[id];
+}
+
+static struct btf *btf_parse_module(const char *module_name, const void *data,
+				    unsigned int data_size, void *base_data,
+				    unsigned int base_data_size)
 {
+	struct btf *btf = NULL, *vmlinux_btf, *base_btf = NULL;
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
-	struct btf *btf = NULL, *base_btf;
-	int err;
+	int err = 0;
 
-	base_btf = bpf_get_btf_vmlinux();
-	if (IS_ERR(base_btf))
-		return base_btf;
-	if (!base_btf)
+	vmlinux_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(vmlinux_btf))
+		return vmlinux_btf;
+	if (!vmlinux_btf)
 		return ERR_PTR(-EINVAL);
 
 	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
@@ -6071,6 +6185,16 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	log = &env->log;
 	log->level = BPF_LOG_KERNEL;
 
+	if (base_data) {
+		base_btf = btf_parse_base(env, ".BTF.base", base_data, base_data_size);
+		if (IS_ERR(base_btf)) {
+			err = PTR_ERR(base_btf);
+			goto errout;
+		}
+	} else {
+		base_btf = vmlinux_btf;
+	}
+
 	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
 	if (!btf) {
 		err = -ENOMEM;
@@ -6110,12 +6234,22 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	if (base_btf != vmlinux_btf) {
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_map);
+		if (err)
+			goto errout;
+		btf_free(base_btf);
+		base_btf = vmlinux_btf;
+	}
+
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
 errout:
 	btf_verifier_env_free(env);
+	if (base_btf != vmlinux_btf)
+		btf_free(base_btf);
 	if (btf) {
 		kvfree(btf->data);
 		kvfree(btf->types);
@@ -7668,7 +7802,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
+		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+				       mod->btf_base_data, mod->btf_base_data_size);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
@@ -7992,7 +8127,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	bool add_filter = !!kset->filter;
 	struct btf_kfunc_set_tab *tab;
 	struct btf_id_set8 *set;
-	u32 set_cnt;
+	u32 set_cnt, i;
 	int ret;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX) {
@@ -8038,21 +8173,15 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		goto end;
 	}
 
-	/* We don't need to allocate, concatenate, and sort module sets, because
-	 * only one is allowed per hook. Hence, we can directly assign the
-	 * pointer and return.
-	 */
-	if (!vmlinux_set) {
-		tab->sets[hook] = add_set;
-		goto do_add_filter;
-	}
-
 	/* In case of vmlinux sets, there may be more than one set being
 	 * registered per hook. To create a unified set, we allocate a new set
 	 * and concatenate all individual sets being registered. While each set
 	 * is individually sorted, they may become unsorted when concatenated,
 	 * hence re-sorting the final set again is required to make binary
 	 * searching the set using btf_id_set8_contains function work.
+	 *
+	 * For module sets, we need to allocate as we may need to relocate
+	 * BTF ids.
 	 */
 	set_cnt = set ? set->cnt : 0;
 
@@ -8082,11 +8211,14 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	/* Concatenate the two sets */
 	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	/* Now that the set is copied, update with relocated BTF ids */
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+		set->pairs[i].id = btf_id_map(btf, set->pairs[i].id);
+
 	set->cnt += add_set->cnt;
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
 
-do_add_filter:
 	if (add_filter) {
 		hook_filter = &tab->hook_filters[hook];
 		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
@@ -8204,7 +8336,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 		return PTR_ERR(btf);
 
 	for (i = 0; i < kset->set->cnt; i++) {
-		ret = btf_check_kfunc_protos(btf, kset->set->pairs[i].id,
+		ret = btf_check_kfunc_protos(btf, btf_id_map(btf, kset->set->pairs[i].id),
 					     kset->set->pairs[i].flags);
 		if (ret)
 			goto err_out;
@@ -8303,7 +8435,7 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 {
 	struct btf_id_dtor_kfunc_tab *tab;
 	struct btf *btf;
-	u32 tab_cnt;
+	u32 tab_cnt, i;
 	int ret;
 
 	btf = btf_get_module_btf(owner);
@@ -8354,6 +8486,13 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	btf->dtor_kfunc_tab = tab;
 
 	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
+
+	/* remap BTF ids based on BTF relocation (if any) */
+	for (i = tab_cnt; i < tab_cnt + add_cnt; i++) {
+		tab->dtors[i].btf_id = btf_id_map(btf, tab->dtors[i].btf_id);
+		tab->dtors[i].kfunc_btf_id = btf_id_map(btf, tab->dtors[i].kfunc_btf_id);
+	}
+
 	tab->cnt += add_cnt;
 
 	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 336da6844d42..567abaa52131 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o btf_relocate.o
+	    usdt.o zip.o elf.o features.o btf_common.o btf_relocate.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f00a84fea9b5..7be33560bd94 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5034,136 +5034,6 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
 	return btf__parse_split(path, vmlinux_btf);
 }
 
-int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
-{
-	int i, n, err;
-
-	switch (btf_kind(t)) {
-	case BTF_KIND_INT:
-	case BTF_KIND_FLOAT:
-	case BTF_KIND_ENUM:
-	case BTF_KIND_ENUM64:
-		return 0;
-
-	case BTF_KIND_FWD:
-	case BTF_KIND_CONST:
-	case BTF_KIND_VOLATILE:
-	case BTF_KIND_RESTRICT:
-	case BTF_KIND_PTR:
-	case BTF_KIND_TYPEDEF:
-	case BTF_KIND_FUNC:
-	case BTF_KIND_VAR:
-	case BTF_KIND_DECL_TAG:
-	case BTF_KIND_TYPE_TAG:
-		return visit(&t->type, ctx);
-
-	case BTF_KIND_ARRAY: {
-		struct btf_array *a = btf_array(t);
-
-		err = visit(&a->type, ctx);
-		err = err ?: visit(&a->index_type, ctx);
-		return err;
-	}
-
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION: {
-		struct btf_member *m = btf_members(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *m = btf_params(t);
-
-		err = visit(&t->type, ctx);
-		if (err)
-			return err;
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	case BTF_KIND_DATASEC: {
-		struct btf_var_secinfo *m = btf_var_secinfos(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->type, ctx);
-			if (err)
-				return err;
-		}
-		return 0;
-	}
-
-	default:
-		return -EINVAL;
-	}
-}
-
-int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx)
-{
-	int i, n, err;
-
-	err = visit(&t->name_off, ctx);
-	if (err)
-		return err;
-
-	switch (btf_kind(t)) {
-	case BTF_KIND_STRUCT:
-	case BTF_KIND_UNION: {
-		struct btf_member *m = btf_members(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_ENUM: {
-		struct btf_enum *m = btf_enum(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_ENUM64: {
-		struct btf_enum64 *m = btf_enum64(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	case BTF_KIND_FUNC_PROTO: {
-		struct btf_param *m = btf_params(t);
-
-		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
-			err = visit(&m->name_off, ctx);
-			if (err)
-				return err;
-		}
-		break;
-	}
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
 {
 	const struct btf_ext_info *seg;
diff --git a/tools/lib/bpf/btf_common.c b/tools/lib/bpf/btf_common.c
new file mode 100644
index 000000000000..ddec3f3ac423
--- /dev/null
+++ b/tools/lib/bpf/btf_common.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2021 Facebook */
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+static inline struct btf_var_secinfo *btf_var_secinfos(const struct btf_type *t)
+{
+	return (struct btf_var_secinfo *)(t + 1);
+}
+
+#else
+#include "btf.h"
+#include "libbpf_internal.h"
+#endif
+
+int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
+{
+	int i, n, err;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		return 0;
+
+	case BTF_KIND_FWD:
+	case BTF_KIND_CONST:
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
+		return visit(&t->type, ctx);
+
+	case BTF_KIND_ARRAY: {
+		struct btf_array *a = btf_array(t);
+
+		err = visit(&a->type, ctx);
+		err = err ?: visit(&a->index_type, ctx);
+		return err;
+	}
+
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		struct btf_member *m = btf_members(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->type, ctx);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *m = btf_params(t);
+
+		err = visit(&t->type, ctx);
+		if (err)
+			return err;
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->type, ctx);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	case BTF_KIND_DATASEC: {
+		struct btf_var_secinfo *m = btf_var_secinfos(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->type, ctx);
+			if (err)
+				return err;
+		}
+		return 0;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx)
+{
+	int i, n, err;
+
+	err = visit(&t->name_off, ctx);
+	if (err)
+		return err;
+
+	switch (btf_kind(t)) {
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		struct btf_member *m = btf_members(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->name_off, ctx);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_ENUM: {
+		struct btf_enum *m = btf_enum(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->name_off, ctx);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_ENUM64: {
+		struct btf_enum64 *m = btf_enum64(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->name_off, ctx);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *m = btf_params(t);
+
+		for (i = 0, n = btf_vlen(t); i < n; i++, m++) {
+			err = visit(&m->name_off, ctx);
+			if (err)
+				return err;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index d9340375f4a3..8d3865cf193b 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -1,11 +1,40 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024, Oracle and/or its affiliates. */
 
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/string.h>
+#include <linux/bpf_verifier.h>
+
+#define btf__type_by_id		btf_type_by_id
+#define btf__type_cnt		btf_nr_types
+#define btf__base_btf		btf_base_btf
+#define btf__name_by_offset	btf_name_by_offset
+#define btf_kflag		btf_type_kflag
+
+#define calloc(nmemb, size)	kvcalloc(nmemb, size, GFP_KERNEL | __GFP_NOWARN)
+#define free(ptr)		kvfree(ptr)
+
+static inline __u8 btf_int_bits(const struct btf_type *t)
+{
+	return BTF_INT_BITS(*(__u32 *)(t + 1));
+}
+
+static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
+{
+	return (struct btf_decl_tag *)(t + 1);
+}
+
+#else
+
 #include "btf.h"
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+#endif /* __KERNEL__ */
+
 struct btf;
 
 #define BTF_MAX_NR_TYPES 0x7fffffffU
-- 
2.31.1


