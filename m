Return-Path: <bpf+bounces-7651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950B779F1B
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E0428106E
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260161FCA;
	Sat, 12 Aug 2023 10:48:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03569370
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:48:30 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97142D61;
	Sat, 12 Aug 2023 03:48:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNHC25m77z9yydv;
	Sat, 12 Aug 2023 18:36:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S6;
	Sat, 12 Aug 2023 11:47:45 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	jarkko@kernel.org,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 04/13] integrity/digest_cache: Prefetch digest lists in a directory
Date: Sat, 12 Aug 2023 12:46:07 +0200
Message-Id: <20230812104616.2190095-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1rCFy8tF4UJrW7ZrW8Zwb_yoWxuFW7pa
	9Ik3WUtr4rZw1fC397AF43CF4Fg39Ygr47Gw45uw1Yyw4DZr1jv3WxCryUZry5Jr4Uu3W7
	tF4UKr1UCr4DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5KVZQABsQ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Prefetch the digest lists in the same directory as the requested one, to
measure them in a deterministic way, and obtain a predictable PCR.

Prefetching does not imply parsing, so there won't be significant memory
consumption. However, since all PCR extend operations are done all at
the same time, this iteration is expected to introduce a noticeable delay
to the first file operation for which the digest cache is used.

This patch assumes for now that all digest lists are stored in the same
directory.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/Makefile            |   3 +-
 security/integrity/digest_cache.h      |   5 +
 security/integrity/digest_cache_iter.c | 160 +++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)
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
index 01cd70f9850..cd5c913cf7a 100644
--- a/security/integrity/digest_cache.h
+++ b/security/integrity/digest_cache.h
@@ -71,6 +71,7 @@ int digest_cache_init_htable(struct digest_cache *digest_cache,
 int digest_cache_add(struct digest_cache *digest_cache, u8 *digest);
 int digest_cache_lookup(struct digest_cache *digest_cache, u8 *digest,
 			enum hash_algo algo, const char *pathname);
+void digest_cache_iter_dir(struct dentry *repo_dentry);
 #else
 static inline void digest_cache_free(struct digest_cache *digest_cache)
 {
@@ -101,5 +102,9 @@ static inline int digest_cache_lookup(struct digest_cache *digest_cache,
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
index 00000000000..f7641e7b365
--- /dev/null
+++ b/security/integrity/digest_cache_iter.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement a digest list iterator.
+ */
+
+#include <linux/fs.h>
+#include <linux/xattr.h>
+#include <linux/vmalloc.h>
+#include <linux/kernel_read_file.h>
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
+	list_add_tail(&new_entry->list, ctx->head);
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
+	char *path_str = NULL, *dir_path_str = NULL;
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
+	dir_path_str = kstrndup(path_str, ptr - path_str, GFP_KERNEL);
+	if (!dir_path_str)
+		goto out;
+
+	dir_file = filp_open(dir_path_str, O_RDONLY, 0);
+
+	if (IS_ERR(dir_file)) {
+		pr_debug("Cannot access %s\n", dir_path_str);
+		goto out;
+	}
+
+	buf.head = &head;
+	iterate_dir(dir_file, &buf.ctx);
+	list_for_each_entry_safe(p, q, &head, list) {
+		pr_debug("Prefetching digest list %s/%s\n", dir_path_str,
+			 p->name);
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
+	kfree(dir_path_str);
+}
-- 
2.34.1


