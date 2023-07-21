Return-Path: <bpf+bounces-5629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D875CF7B
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4161C217F4
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB61E532;
	Fri, 21 Jul 2023 16:35:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA0200A6
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:35:43 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109893AB2;
	Fri, 21 Jul 2023 09:35:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6vxG6K9Qz9xFQR;
	Sat, 22 Jul 2023 00:23:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S6;
	Fri, 21 Jul 2023 17:34:09 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 04/12] integrity/digest_cache: Iterate over digest lists in same dir
Date: Fri, 21 Jul 2023 18:33:18 +0200
Message-Id: <20230721163326.4106089-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
References: <20230721163326.4106089-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S6
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1UZFyUuF45JFW7XF15CFg_yoWxKF15pa
	9Ik3W5Kr48Z34fCws7AF4akF4Fg39YgF47Gw45uw15Aw4DZr1qv3WxCryUZry5Jr4Uua47
	tF4Ygr45Cr4DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4zMlQAAsn
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

One advantage of the digest cache is the ability of skipping measurements
of cached digests. That would allow to accumulate integrity measurements
on a PCR in a predictable way, since only the digest lists would be
measured.

However, since digest lists are accessed on demand, when a file belonging
to that repo is measured/appraised, it could happen due to parallel
execution that also digest lists are measured not in the same order.

Thus, eliminate this possibility by iterating over the directory containing
the digest lists and by reading all of them, to trigger a measurement.

Read digest lists are not parsed, to avoid too much memory pressure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/Makefile            |   3 +-
 security/integrity/digest_cache.h      |   5 +
 security/integrity/digest_cache_iter.c | 163 +++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/digest_cache_iter.c

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 0c175a567ac..c856ed10fba 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -11,7 +11,8 @@ integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
-integrity-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
+integrity-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o \
+					      digest_cache_iter.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digest_cache.h b/security/integrity/digest_cache.h
index 5e3997b2723..d8fd5ce47a7 100644
--- a/security/integrity/digest_cache.h
+++ b/security/integrity/digest_cache.h
@@ -69,6 +69,7 @@ int digest_cache_init_htable(struct digest_cache *digest_cache,
 int digest_cache_add(struct digest_cache *digest_cache, u8 *digest);
 int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
 			enum hash_algo algo, const char *pathname);
+void digest_cache_iter_dir(struct dentry *repo_dentry);
 #else
 static inline void digest_cache_free(struct digest_cache *digest_cache)
 {
@@ -104,5 +105,9 @@ static inline int digest_cache_lookup(struct digest_cache *digest_cache,
 	return -ENOENT;
 }
 
+static inline void digest_cache_iter_dir(struct dentry *repo_dentry)
+{
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
 #endif /* _DIGEST_CACHE_H */
diff --git a/security/integrity/digest_cache_iter.c b/security/integrity/digest_cache_iter.c
new file mode 100644
index 00000000000..f9c4675d383
--- /dev/null
+++ b/security/integrity/digest_cache_iter.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019  IBM Corporation
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement a digest list iterator.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/xattr.h>
+#include <linux/kernel_read_file.h>
+#include <linux/module_signature.h>
+
+#include "integrity.h"
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+#define pr_fmt(fmt) "DIGEST CACHE ITER: "fmt
+
+static bool iterated;
+/* Ensure there is only one iteration over digest lists, make others wait. */
+DEFINE_MUTEX(iterate_mutex);
+
+struct dir_entry {
+	struct list_head list;
+	char name[];
+} __packed;
+
+struct readdir_callback {
+	struct dir_context ctx;
+	struct list_head *head;
+};
+
+/**
+ * digest_cache_iter_digest_list - Callback func to get digest lists in a dir
+ * @__ctx: iterate_dir() context
+ * @name: Name of file in the accessed dir
+ * @namelen: String length of @name
+ * @offset: Current position in the directory stream (see man readdir)
+ * @ino: Inode number
+ * @d_type: File type
+ *
+ * This function stores the names of the files in the containing directory in
+ * a linked list. Those files will be opened to trigger a measurement.
+ *
+ * Return: True to continue processing, false to stop.
+ */
+static bool digest_cache_iter_digest_list(struct dir_context *__ctx,
+					  const char *name, int namelen,
+					  loff_t offset, u64 ino,
+					  unsigned int d_type)
+{
+	struct readdir_callback *ctx = container_of(__ctx, typeof(*ctx), ctx);
+	struct dir_entry *new_entry;
+
+	if (!strcmp(name, ".") || !strcmp(name, ".."))
+		return true;
+
+	if (d_type != DT_REG)
+		return true;
+
+	new_entry = kmalloc(sizeof(*new_entry) + namelen + 1, GFP_KERNEL);
+	if (!new_entry)
+		return true;
+
+	memcpy(new_entry->name, name, namelen);
+	new_entry->name[namelen] = '\0';
+	list_add(&new_entry->list, ctx->head);
+	return true;
+}
+
+/**
+ * digest_cache_iter_dir - Iterate over all files in the same digest list dir
+ * @digest_list_dentry: Digest list dentry
+ *
+ * This function iterates over all files in the directory containing the digest
+ * list provided as argument. It helps to measure digest lists in a
+ * deterministic order and make a TPM PCR predictable.
+ */
+void digest_cache_iter_dir(struct dentry *digest_list_dentry)
+{
+	struct file *dir_file;
+	struct readdir_callback buf = {
+		.ctx.actor = digest_cache_iter_digest_list,
+	};
+	struct dir_entry *p, *q;
+	struct file *file;
+	char *path_str = NULL;
+	void *data;
+	LIST_HEAD(head);
+	char *ptr;
+	int ret;
+
+	if (iterated)
+		return;
+
+	mutex_lock(&iterate_mutex);
+	if (iterated)
+		goto out;
+
+	iterated = true;
+
+	ret = vfs_getxattr_alloc(&nop_mnt_idmap, digest_list_dentry,
+				 XATTR_NAME_DIGEST_LIST, &path_str, 0,
+				 GFP_NOFS);
+	if (ret <= 0) {
+		pr_debug("%s xattr not found in %s\n", XATTR_NAME_DIGEST_LIST,
+			 digest_list_dentry->d_name.name);
+		goto out;
+	}
+
+	pr_debug("Found %s xattr in %s, digest list: %s\n",
+		 XATTR_NAME_DIGEST_LIST, digest_list_dentry->d_name.name,
+		 path_str);
+
+	ptr = strrchr(path_str, '/');
+	if (!ptr)
+		goto out;
+
+	*ptr = '\0';
+	dir_file = filp_open(path_str, O_RDONLY, 0);
+	*ptr = '/';
+
+	if (IS_ERR(dir_file)) {
+		pr_debug("Cannot access parent directory of repo %s\n",
+			 path_str);
+		goto out;
+	}
+
+	buf.head = &head;
+	iterate_dir(dir_file, &buf.ctx);
+	list_for_each_entry_safe(p, q, &head, list) {
+		pr_debug("Prereading digest list %s in %s\n", p->name,
+			 path_str);
+
+		file = file_open_root(&dir_file->f_path, p->name, O_RDONLY, 0);
+		if (IS_ERR(file))
+			continue;
+
+		data = NULL;
+
+		ret = kernel_read_file(file, 0, &data, INT_MAX, NULL,
+				       READING_DIGEST_LIST);
+		if (ret >= 0)
+			vfree(data);
+
+		fput(file);
+		list_del(&p->list);
+		kfree(p);
+	}
+
+	fput(dir_file);
+out:
+	mutex_unlock(&iterate_mutex);
+	kfree(path_str);
+}
-- 
2.34.1


