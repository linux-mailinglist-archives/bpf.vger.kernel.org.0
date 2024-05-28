Return-Path: <bpf+bounces-30722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702288D1B36
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932911C21081
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C563616E866;
	Tue, 28 May 2024 12:25:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BC16D9DC
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899127; cv=none; b=H8fxd+NuZNgcVKdzHgcFYWrHO70GBoXT2+RMctItY7saImZq8czxzaUIoQUwznOJrr4lzRuM6d4Nrcrx4BXrQ8fLW+e56J3YSkOF+nHLd8HJy3tCAPc61V/HbvO/ZxnSv/K8H8r3NQ+2sfVNisI6OYzcnAyyB/nUzwNFdpSBnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899127; c=relaxed/simple;
	bh=rXP/wkCJoZ1Yx9UXVm9r9ViNuyEcwsXGMWGdz1ZNWpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCXxNfWoipwx/9gN0ZFNqw0rG68NI+l1vA5qph4Ghnkj2lYWbBhHm5fLbw/dNyxNC8XXVh/F7kCHRytIj93VnMhtKk6GUIBrRYpN7iWaGYVWBZqPNgMOxTXMpfikm0zbJ9RczaqzMv0MpcGeVNhhiBzAfH1mVIsFjazls1RIdgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBovRQ001897;
	Tue, 28 May 2024 12:24:59 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DLawBadWNUHFq5PEKvHB4rQrF42+ruaC+pOapintNQKw=3D;_b=3DNGymxLym?=
 =?UTF-8?Q?bMOrgjP4Dk27XRg2XHzcPLDXlIQp9LQXosH6Yj8C9LuOfjbE4oe6jFEbPpsd_Ss?=
 =?UTF-8?Q?erNA1AL9dgW1z+2iimzCAQMrRaikrJ1rZ/0WLIypNL4cC6iZlxySb1izNiWRqjm?=
 =?UTF-8?Q?oQY_DpJfBapLH2Bm4DIfOrxNfyI69d3gohSXwo2DNfyAJAgbaEV2vDtjqcgGuDu?=
 =?UTF-8?Q?l3rm2wMnc_XtPaJKm1fFFckYiEtyw785lcNVCxsD+iNkYpk0ahJBtGzL+gkyY0U?=
 =?UTF-8?Q?7/G5o4nNNuvQJPI_15kD482zfcYG+QptGQVHWcOTQTIz22cx7QhchVJt24hG8xg?=
 =?UTF-8?Q?5V1k5dVgqttz1f3Fg63u+_NQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g446y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBtuCG037212;
	Tue, 28 May 2024 12:24:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc535a0bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 12:24:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SCNlJb022297;
	Tue, 28 May 2024 12:24:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-70.vpn.oracle.com [10.175.164.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc5359yey-9;
	Tue, 28 May 2024 12:24:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 8/9] libbpf,bpf: share BTF relocate-related code with kernel
Date: Tue, 28 May 2024 13:24:07 +0100
Message-Id: <20240528122408.3154936-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528122408.3154936-1-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280093
X-Proofpoint-GUID: m2sgTELIL7DYieb0dIEfAUiJM9XOnHBV
X-Proofpoint-ORIG-GUID: m2sgTELIL7DYieb0dIEfAUiJM9XOnHBV

Share relocation implementation with the kernel.  As part of this,
we also need the type/string visitation functions so add them to a
btf_common.c file that also gets shared with the kernel. Relocation
code in kernel and userspace is identical save for the impementation
of the reparenting of split BTF to the relocated base BTF and
retrieval of BTF header from "struct btf"; these small functions
need separate user-space and kernel implementations.

One other wrinkle on the kernel side is we have to map .BTF.ids in
modules as they were generated with the type ids used at BTF encoding
time. btf_relocate() optionally returns an array mapping from old BTF
ids to relocated ids, so we use that to fix up these references where
needed for kfuncs.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/btf.h          |  45 ++++++++++
 kernel/bpf/Makefile          |  10 ++-
 kernel/bpf/btf.c             | 168 +++++++++++++++++++++++++----------
 tools/lib/bpf/Build          |   2 +-
 tools/lib/bpf/btf.c          | 130 ---------------------------
 tools/lib/bpf/btf_iter.c     | 143 +++++++++++++++++++++++++++++
 tools/lib/bpf/btf_relocate.c |  23 +++++
 7 files changed, 344 insertions(+), 177 deletions(-)
 create mode 100644 tools/lib/bpf/btf_iter.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..21cb33ba62b3 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -140,6 +140,7 @@ extern const struct file_operations btf_fops;
 const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
+const struct btf_header *btf_header(const struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
 struct btf *btf_get_by_fd(int fd);
 int btf_get_info_by_fd(const struct btf *btf,
@@ -212,8 +213,10 @@ int btf_get_fd_by_id(u32 id);
 u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
+bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+struct btf *btf_base_btf(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
@@ -339,6 +342,11 @@ static inline u8 btf_int_offset(const struct btf_type *t)
 	return BTF_INT_OFFSET(*(u32 *)(t + 1));
 }
 
+static inline __u8 btf_int_bits(const struct btf_type *t)
+{
+	return BTF_INT_BITS(*(__u32 *)(t + 1));
+}
+
 static inline bool btf_type_is_scalar(const struct btf_type *t)
 {
 	return btf_type_is_int(t) || btf_type_is_enum(t);
@@ -478,6 +486,11 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
 	return (struct btf_param *)(t + 1);
 }
 
+static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
+{
+	return (struct btf_decl_tag *)(t + 1);
+}
+
 static inline int btf_id_cmp_func(const void *a, const void *b)
 {
 	const int *pa = a, *pb = b;
@@ -515,9 +528,17 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
 }
 #endif
 
+typedef int (*type_id_visit_fn)(__u32 *type_id, void *ctx);
+typedef int (*str_off_visit_fn)(__u32 *str_off, void *ctx);
+
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
+void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
+int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx);
+int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit, void *ctx);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
+const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
@@ -543,6 +564,30 @@ static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 {
 	return NULL;
 }
+
+static inline void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
+{
+	return;
+}
+
+static inline int btf_relocate(void *log, struct btf *btf, const struct btf *base_btf,
+			       __u32 **map_ids)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit,
+					  void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int btf_type_visit_str_offs(struct btf_type *t, str_off_visit_fn visit,
+					  void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline const char *btf_name_by_offset(const struct btf *btf,
 					     u32 offset)
 {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7eb9ad3a3ae6..d9d148992fbf 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -50,5 +50,13 @@ endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
 
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
-$(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
+
+obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
+
+obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
+
+# Some source files are common to libbpf.
+vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
+
+$(obj)/%.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..6715de908581 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -274,6 +274,7 @@ struct btf {
 	u32 start_str_off; /* first string offset (0 for base BTF) */
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
+	__u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF ids */
 };
 
 enum verifier_phase {
@@ -530,6 +531,11 @@ static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 	       btf_type_is_var(t) || btf_type_is_typedef(t);
 }
 
+bool btf_is_vmlinux(const struct btf *btf)
+{
+	return btf->kernel_btf && !btf->base_btf;
+}
+
 u32 btf_nr_types(const struct btf *btf)
 {
 	u32 total = 0;
@@ -772,7 +778,7 @@ static bool __btf_name_char_ok(char c, bool first)
 	return true;
 }
 
-static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
+const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 {
 	while (offset < btf->start_str_off)
 		btf = btf->base_btf;
@@ -1735,7 +1741,12 @@ static void btf_free(struct btf *btf)
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
-	kvfree(btf->data);
+	/* vmlinux does not allocate btf->data, it simply points it at
+	 * __start_BTF.
+	 */
+	if (!btf_is_vmlinux(btf))
+		kvfree(btf->data);
+	kvfree(btf->base_id_map);
 	kfree(btf);
 }
 
@@ -1764,6 +1775,23 @@ void btf_put(struct btf *btf)
 	}
 }
 
+struct btf *btf_base_btf(const struct btf *btf)
+{
+	return btf->base_btf;
+}
+
+const struct btf_header *btf_header(const struct btf *btf)
+{
+	return &btf->hdr;
+}
+
+void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
+{
+	btf->base_btf = (struct btf *)base_btf;
+	btf->start_id = btf_nr_types(base_btf);
+	btf->start_str_off = base_btf->hdr.str_len;
+}
+
 static int env_resolve_init(struct btf_verifier_env *env)
 {
 	struct btf *btf = env->btf;
@@ -5982,23 +6010,15 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
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
@@ -6006,10 +6026,10 @@ struct btf *btf_parse_vmlinux(void)
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
@@ -6029,20 +6049,11 @@ struct btf *btf_parse_vmlinux(void)
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
@@ -6050,19 +6061,61 @@ struct btf *btf_parse_vmlinux(void)
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
+	if (IS_ERR(btf))
+		goto err_out;
+
+	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
+	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
+	err = btf_alloc_id(btf);
+	if (err) {
+		btf_free(btf);
+		btf = ERR_PTR(err);
+	}
+err_out:
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
+static __u32 btf_relocate_id(const struct btf *btf, __u32 id)
 {
+	if (!btf->base_btf || !btf->base_id_map)
+		return id;
+	return btf->base_id_map[id];
+}
+
+static struct btf *btf_parse_module(const char *module_name, const void *data,
+				    unsigned int data_size, void *base_data,
+				    unsigned int base_data_size)
+{
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
@@ -6072,6 +6125,16 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
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
@@ -6111,12 +6174,22 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
 	if (err)
 		goto errout;
 
+	if (base_btf != vmlinux_btf) {
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map);
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
@@ -7669,7 +7742,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
+		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+				       mod->btf_base_data, mod->btf_base_data_size);
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
@@ -7993,7 +8067,7 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	bool add_filter = !!kset->filter;
 	struct btf_kfunc_set_tab *tab;
 	struct btf_id_set8 *set;
-	u32 set_cnt;
+	u32 set_cnt, i;
 	int ret;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX) {
@@ -8039,21 +8113,15 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
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
 
@@ -8083,11 +8151,14 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 
 	/* Concatenate the two sets */
 	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	/* Now that the set is copied, update with relocated BTF ids */
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
+
 	set->cnt += add_set->cnt;
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
 
-do_add_filter:
 	if (add_filter) {
 		hook_filter = &tab->hook_filters[hook];
 		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
@@ -8207,7 +8278,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 		return PTR_ERR(btf);
 
 	for (i = 0; i < kset->set->cnt; i++) {
-		ret = btf_check_kfunc_protos(btf, kset->set->pairs[i].id,
+		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
 					     kset->set->pairs[i].flags);
 		if (ret)
 			goto err_out;
@@ -8306,7 +8377,7 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 {
 	struct btf_id_dtor_kfunc_tab *tab;
 	struct btf *btf;
-	u32 tab_cnt;
+	u32 tab_cnt, i;
 	int ret;
 
 	btf = btf_get_module_btf(owner);
@@ -8357,6 +8428,13 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	btf->dtor_kfunc_tab = tab;
 
 	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]));
+
+	/* remap BTF ids based on BTF relocation (if any) */
+	for (i = tab_cnt; i < tab_cnt + add_cnt; i++) {
+		tab->dtors[i].btf_id = btf_relocate_id(btf, tab->dtors[i].btf_id);
+		tab->dtors[i].kfunc_btf_id = btf_relocate_id(btf, tab->dtors[i].kfunc_btf_id);
+	}
+
 	tab->cnt += add_cnt;
 
 	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 336da6844d42..e2cd558ca0b4 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o btf_relocate.o
+	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b57f74eedda0..6c3c17bb6ca7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5060,136 +5060,6 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
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
diff --git a/tools/lib/bpf/btf_iter.c b/tools/lib/bpf/btf_iter.c
new file mode 100644
index 000000000000..47d615dee8c5
--- /dev/null
+++ b/tools/lib/bpf/btf_iter.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2021 Facebook */
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+#define btf_var_secinfos(t)	(struct btf_var_secinfo *)btf_type_var_secinfo(t)
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
index f2e91cdfb5cc..3245c5fd0c75 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -5,11 +5,34 @@
 #define _GNU_SOURCE
 #endif
 
+#ifdef __KERNEL__
+#include <linux/bpf.h>
+#include <linux/bsearch.h>
+#include <linux/btf.h>
+#include <linux/sort.h>
+#include <linux/string.h>
+#include <linux/bpf_verifier.h>
+
+#define btf_type_by_id				(struct btf_type *)btf_type_by_id
+#define btf__type_cnt				btf_nr_types
+#define btf__base_btf				btf_base_btf
+#define btf__name_by_offset			btf_name_by_offset
+#define btf__str_by_offset			btf_str_by_offset
+#define btf_kflag				btf_type_kflag
+
+#define calloc(nmemb, sz)			kvcalloc(nmemb, sz, GFP_KERNEL | __GFP_NOWARN)
+#define free(ptr)				kvfree(ptr)
+#define qsort(base, num, sz, cmp)		sort(base, num, sz, cmp, NULL)
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
 
 struct btf_relocate {
-- 
2.31.1


