Return-Path: <bpf+bounces-70610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B210BC628B
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E2734E5DA4
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218B2D8393;
	Wed,  8 Oct 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJW5sgWU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FDF2BEC4A
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944975; cv=none; b=uJxbMWpH5W69ZHPb5STNgsW88riLz7v5FR42DlAmwVUZ6Eayp3Bz2B4kQqdOKVSalUD5hwpTh+DIk66Kq4s3StlFRFFmBMMmm3HVU9YCdgNb6zo3NOZMEO+RB0OJNbS7g5G/7PVLy1SjjlCxJ9mlrYBYXz9uwE4ECETSG2Wy/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944975; c=relaxed/simple;
	bh=LntbgurzJHwZ209/Cz4NgQEWW4p2x+mdxVEZ9LcHHYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUD1cH/PBPOMImr7d8HQx5FM1pCtzxoeEr0gDLigVkovI4Zjnt/MixbaaD5QiGtN22uB92ACYhGdhD3nOwsv8x4BtiuihXZt+L5qRKw46NdP8DLDd+X3q2gpQDfCWmYdidfpXyLc5/VTLs4OW0OPHJwhohNqYOHHl21BKOxXH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJW5sgWU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEXjp000636;
	Wed, 8 Oct 2025 17:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3Ci+s
	mo0BryjFTyMgSIj5hy4u+Kvlg+gV+EWt6Hp2XM=; b=cJW5sgWU5U2/e/9rKz+Ca
	073+3nKKhc09HSBLjAsXDHWTlbbjhLYCeuSr1lx/wO4SklbUawd+jwZszQyie2GR
	GEqKOpxjSyHK+dbcCdh5nnJf1ngNyWofMZSGLX/8GiHKpvE8yLIyhsaU1aMwW3QC
	Y9Aa0GLTeyE4JAFbjnlXcl7Hi5w3/OjAAEYMf5vVSePifsybQAHwx4l96XjYIfbS
	3P0U8FQMu0Lf9g08JC/XienMWxM07hYF4arYT+Xd8L0dj0lVylO//O5cMWFpsn+l
	jcQMUXcBJQauIFynXBPMg4vg9WV8cv+ELPPk+0itg06DQ26aZ8RReJDJxcAElxMd
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6br1cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDtpY037047;
	Wed, 8 Oct 2025 17:35:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFV6031138;
	Wed, 8 Oct 2025 17:35:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-13;
	Wed, 08 Oct 2025 17:35:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 12/15] kbuild, module, bpf: Support CONFIG_DEBUG_INFO_BTF_EXTRA=m
Date: Wed,  8 Oct 2025 18:35:08 +0100
Message-ID: <20251008173512.731801-13-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e6a0f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=iygoEYCf1bllB9vdARYA:9 cc=ntf
 awl=host:13625
X-Proofpoint-ORIG-GUID: 4rOZjFKzHmQaVdpEsnEFXoChGmAHuq9_
X-Proofpoint-GUID: 4rOZjFKzHmQaVdpEsnEFXoChGmAHuq9_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7OPPmGrVTxnk
 UVaGoTQ7fpA+Hhuz88swF2pXArz5HbBNLhEiqvSH9sE5CAVUlX7tcAuU4U2pkxmCAtBZHycodig
 pd8XGWhAurIFdRS0s0q3RkpogI6z9czkkzSHDm6MX9eTspsEXiKtUHu20QR7rMVhMMyhklPNLRn
 imBRG+G7ScGM3vuAwYBJN54Em08fNGq2oi5jCbSvHvSYFOD1dMRWy6sq0RiSolAVOpID3iJpG0P
 89ybUv66l1paiBrdlL4FistrEgmKBmh+GXr8jJehYyr0NzxDcbjXGwFbdA8I/iVY6rl3L0TYvUg
 tkrXsm4+jA//twGqDA9QWgo/p/bQLYq1uRPnusdPkEeMESce0xxikZq96zuENOqKKiaSBsTE15W
 DjbFfcf9QGmAB6Zle2gTph3I6i9nQ9jhwNBvMK/gCp4Od0DtSWk=

Allow module-based delivery of potentially large vmlinux .BTF.extra section;
section; also support visibility of BTF data in kernel, modules in
/sys/kernel/btf_extra.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/linux/bpf.h       |   1 +
 include/linux/btf.h       |   2 +
 include/linux/module.h    |   4 ++
 kernel/bpf/Makefile       |   1 +
 kernel/bpf/btf.c          | 114 +++++++++++++++++++++++++++-----------
 kernel/bpf/btf_extra.c    |  25 +++++++++
 kernel/bpf/sysfs_btf.c    |  21 ++++++-
 kernel/module/main.c      |   4 ++
 lib/Kconfig.debug         |   2 +-
 scripts/Makefile.btf      |   3 +-
 scripts/Makefile.modfinal |   5 ++
 scripts/link-vmlinux.sh   |   6 ++
 12 files changed, 154 insertions(+), 34 deletions(-)
 create mode 100644 kernel/bpf/btf_extra.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..7a15fc077642 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -63,6 +63,7 @@ struct inode;
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
+extern struct kobject *btf_extra_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
 extern bool bpf_global_ma_set;
 
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 65091c6aff4b..3684f6266b1c 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -621,6 +621,8 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
 int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx);
+struct bin_attribute *sysfs_btf_add(struct kobject *kobj, const char *name,
+				    void *data, size_t data_size);
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
 {
diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..c2fceaf392c5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -512,6 +512,10 @@ struct module {
 	unsigned int btf_base_data_size;
 	void *btf_data;
 	void *btf_base_data;
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_EXTRA)
+	unsigned int btf_extra_data_size;
+	void *btf_extra_data;
+#endif
 #endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7fd0badfacb1..08bf991560d7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+obj-$(CONFIG_DEBUG_INFO_BTF_EXTRA) += btf_extra.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 29cec549f119..749e04c679c6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8323,12 +8323,42 @@ enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
 };
 
+#if IS_ENABLED(CONFIG_SYSFS)
+struct bin_attribute *sysfs_btf_add(struct kobject *kobj, const char *name,
+				    void *data, size_t data_size)
+{
+	struct bin_attribute *attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	int err;
+
+	if (!attr)
+		return ERR_PTR(-ENOMEM);
+
+	sysfs_bin_attr_init(attr);
+	attr->attr.name = name;
+	attr->attr.mode = 0444;
+	attr->size = data_size;
+	attr->private = data;
+	attr->read = sysfs_bin_attr_simple_read;
+
+	err = sysfs_create_bin_file(kobj, attr);
+	if (err) {
+		pr_warn("failed to register module [%s] BTF in sysfs : %d\n", name, err);
+		kfree(attr);
+		return ERR_PTR(err);
+	}
+	return attr;
+}
+
+#endif
+
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 struct btf_module {
 	struct list_head list;
 	struct module *module;
 	struct btf *btf;
 	struct bin_attribute *sysfs_attr;
+	void *btf_extra_data;
+	struct bin_attribute *sysfs_extra_attr;
 	int flags;
 };
 
@@ -8342,12 +8372,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 {
 	struct btf_module *btf_mod, *tmp;
 	struct module *mod = module;
-	struct btf *btf;
+	struct bin_attribute *attr;
+	struct btf *btf = NULL;
 	int err = 0;
 
-	if (mod->btf_data_size == 0 ||
-	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
-	     op != MODULE_STATE_GOING))
+	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
+	     op != MODULE_STATE_GOING)
 		goto out;
 
 	switch (op) {
@@ -8357,8 +8387,10 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			err = -ENOMEM;
 			goto out;
 		}
-		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
-				       mod->btf_base_data, mod->btf_base_data_size);
+		if (mod->btf_data_size > 0) {
+			btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
+					       mod->btf_base_data, mod->btf_base_data_size);
+		}
 		if (IS_ERR(btf)) {
 			kfree(btf_mod);
 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
@@ -8370,7 +8402,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			}
 			goto out;
 		}
-		err = btf_alloc_id(btf);
+		if (btf)
+			err = btf_alloc_id(btf);
 		if (err) {
 			btf_free(btf);
 			kfree(btf_mod);
@@ -8384,32 +8417,45 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
-		if (IS_ENABLED(CONFIG_SYSFS)) {
-			struct bin_attribute *attr;
-
-			attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-			if (!attr)
-				goto out;
-
-			sysfs_bin_attr_init(attr);
-			attr->attr.name = btf->name;
-			attr->attr.mode = 0444;
-			attr->size = btf->data_size;
-			attr->private = btf->data;
-			attr->read = sysfs_bin_attr_simple_read;
-
-			err = sysfs_create_bin_file(btf_kobj, attr);
-			if (err) {
-				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
-					mod->name, err);
-				kfree(attr);
-				err = 0;
+		if (IS_ENABLED(CONFIG_SYSFS) && btf) {
+			attr = sysfs_btf_add(btf_kobj, btf->name, btf->data, btf->data_size);
+			if (IS_ERR(attr)) {
+				err = PTR_ERR(attr);
 				goto out;
 			}
-
 			btf_mod->sysfs_attr = attr;
 		}
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_EXTRA)
+		if (mod->btf_extra_data_size > 0) {
+			const char *name = mod->name;
+			void *data;
 
+			/* vmlinux .BTF.extra is SHF_ALLOC; other modules
+			 * are not, so for them we need to kvmemdup() the data.
+			 */
+			if (strcmp(mod->name, "btf_extra") == 0) {
+				name = "vmlinux";
+				data = mod->btf_extra_data;
+			} else {
+				data = kvmemdup(mod->btf_extra_data, mod->btf_extra_data_size,
+						GFP_KERNEL | __GFP_NOWARN);
+				if (!data) {
+					err = -ENOMEM;
+					goto out;
+				}
+				btf_mod->btf_extra_data = data;
+			}
+			attr = sysfs_btf_add(btf_extra_kobj, name, data,
+					     mod->btf_extra_data_size);
+			if (IS_ERR(attr)) {
+				err = PTR_ERR(attr);
+				kfree(btf_mod->sysfs_attr);
+				kvfree(btf_mod->btf_extra_data);
+				goto out;
+			}
+			btf_mod->sysfs_extra_attr = attr;
+		}
+#endif
 		break;
 	case MODULE_STATE_LIVE:
 		mutex_lock(&btf_module_mutex);
@@ -8431,9 +8477,15 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			list_del(&btf_mod->list);
 			if (btf_mod->sysfs_attr)
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
-			purge_cand_cache(btf_mod->btf);
-			btf_put(btf_mod->btf);
-			kfree(btf_mod->sysfs_attr);
+			if (btf_mod->btf_extra_data)
+				kvfree(btf_mod->btf_extra_data);
+			if (btf_mod->sysfs_extra_attr)
+				sysfs_remove_bin_file(btf_extra_kobj, btf_mod->sysfs_extra_attr);
+			if (btf_mod->btf) {
+				purge_cand_cache(btf_mod->btf);
+				btf_put(btf_mod->btf);
+				kfree(btf_mod->sysfs_attr);
+			}
 			kfree(btf_mod);
 			break;
 		}
diff --git a/kernel/bpf/btf_extra.c b/kernel/bpf/btf_extra.c
new file mode 100644
index 000000000000..f50616801be9
--- /dev/null
+++ b/kernel/bpf/btf_extra.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+/*
+ * Provide extra kernel BTF information for use by BPF tools.
+ *
+ * Can be built as a module to support cases where vmlinux .BTF.extra
+ * section size in the vmlinux image is too much.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+static int __init btf_extra_init(void)
+{
+	return 0;
+}
+subsys_initcall(btf_extra_init);
+
+static void __exit btf_extra_exit(void)
+{
+}
+module_exit(btf_extra_exit);
+
+MODULE_DESCRIPTION("Extra BTF information");
+MODULE_LICENSE("GPL v2");
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 9cbe15ce3540..0298a0936b9f 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -49,7 +49,15 @@ static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
-struct kobject *btf_kobj;
+struct kobject *btf_kobj, *btf_extra_kobj;
+
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF_EXTRA)
+/* See scripts/link-vmlinux.sh, gen_btf() func for details */
+extern char __start_BTF_extra[];
+extern char __stop_BTF_extra[];
+
+struct bin_attribute *extra_attr;
+#endif
 
 static int __init btf_vmlinux_init(void)
 {
@@ -62,6 +70,17 @@ static int __init btf_vmlinux_init(void)
 	btf_kobj = kobject_create_and_add("btf", kernel_kobj);
 	if (!btf_kobj)
 		return -ENOMEM;
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_EXTRA)) {
+		btf_extra_kobj = kobject_create_and_add("btf_extra", kernel_kobj);
+		if (!btf_extra_kobj)
+			return -ENOMEM;
+#if IS_BUILTIN(CONFIG_DEBUG_INFO_BTF_EXTRA)
+		extra_attr = sysfs_btf_add(btf_extra_kobj, "vmlinux", __start_BTF_extra,
+					   __stop_BTF_extra - __start_BTF_extra);
+		if (IS_ERR(extra_attr))
+			return PTR_ERR(extra_attr);
+#endif
+	}
 
 	return sysfs_create_bin_file(btf_kobj, &bin_attr_btf_vmlinux);
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..0766f5e09020 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2648,6 +2648,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->btf_base_data = any_section_objs(info, ".BTF.base", 1,
 					      &mod->btf_base_data_size);
 #endif
+#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_EXTRA)
+	mod->btf_extra_data = any_section_objs(info, ".BTF.extra", 1,
+					       &mod->btf_extra_data_size);
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d8b713c94ea..8ddf921a4b0e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -434,7 +434,7 @@ config MODULE_ALLOW_BTF_MISMATCH
 	  it when a mismatch is found.
 
 config DEBUG_INFO_BTF_EXTRA
-	bool "Provide extra information about inline sites in BTF"
+	tristate "Provide extra information about inline sites in BTF"
 	default n
 	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE
 	help
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 5ca98446d8b5..791794b65d67 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -32,7 +32,7 @@ module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distil
 else
 ifneq ($(CONFIG_DEBUG_INFO_BTF_EXTRA),)
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=inline.extra
-btf-extra := y
+btf-extra := $(CONFIG_DEBUG_INFO_BTF_EXTRA)
 endif
 endif
 
@@ -43,3 +43,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 export PAHOLE_FLAGS := $(pahole-flags-y)
 export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
 export BTF_EXTRA := $(btf-extra)
+export VMLINUX_BTF_EXTRA := .tmp_vmlinux_btf_extra
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 542ba462ed3e..e522ae9090ea 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -34,10 +34,15 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
 
+btf_vmlinux_bin_o := .tmp_vmlinux1.btf.o
+
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ ! -f $(objtree)/vmlinux ]; then				\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	elif [ $@ == "kernel/bpf/btf_extra.ko" ]; then			\
+		${OBJCOPY} --add-section .BTF.extra=${VMLINUX_BTF_EXTRA} \
+			--set-section-flags .BTF.extra=alloc,readonly $@ ; \
 	else								\
 		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
 		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f88b356fe270..afda64aeed3d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -137,6 +137,12 @@ gen_btf()
 	fi
 	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
 
+	if [ "$BTF_EXTRA" = "m" ]; then
+		# vmlinux BTF extra will be delivered via the btf_extra.ko
+		# module; ensure it is not linked into vmlinux.
+		$OBJCOPY -O binary --only-section=.BTF.extra ${btf_data} ${VMLINUX_BTF_EXTRA}
+		$OBJCOPY --remove-section=.BTF.extra ${btf_data}
+	fi
 	btf_vmlinux_bin_o=${btf_data}
 }
 
-- 
2.39.3


