Return-Path: <bpf+bounces-7649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7D779F19
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B6E2810AB
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C741FCA;
	Sat, 12 Aug 2023 10:47:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07CC370
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 10:47:58 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F42712;
	Sat, 12 Aug 2023 03:47:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNHBh1Sp4z9yydw;
	Sat, 12 Aug 2023 18:36:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXC7scY9dkThi9AA--.8440S4;
	Sat, 12 Aug 2023 11:47:26 +0100 (CET)
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
Subject: [RFC][PATCH v2 02/13] integrity: Introduce a digest cache
Date: Sat, 12 Aug 2023 12:46:05 +0200
Message-Id: <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwBXC7scY9dkThi9AA--.8440S4
X-Coremail-Antispam: 1UD129KBjvAXoWfGFW8Xr13KFWUCFy8WF47XFb_yoW8CryDZo
	ZIva13Jw18WFy7uF4kCF17Za1Uuw4Fq34fAr4kXrWDZ3WSvFyUtasFkFs8JFy5Xr48Gr93
	Aw18X3yUJa1Utr93n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj46UrgACsG
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
	RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the digest cache, a structure holding a hash table of digests,
extracted from a digest list. Its pointer is stored in the iint of the
digest list the digest cache was created from (dig_owner field), and in
the iint of the inodes for which the digest cache is used (dig_user field).
The digest cache has also a reference count to track how many iints are
referencing it.

For simplicity, the digest cache is created only once, from the first read.
Further modifications of the digest lists, if they are ever allowed, are
ignored.

Introduce two methods to manage the digest cache: digest_cache_get() and
digest_cache_free(). The first creates and returns a digest cache created
from the digest list whose path is stored in the security.digest_list xattr
of the inode being measured/appraised.

The second is called at the time an iint is freed. When the digest cache
reference count reaches zero, the digest cache is also freed.

Each digest cache pointer in the iint is protected by the respective
mutex. Dig_owner_mutex ensures that the first caller of digest_cache_get()
creates and initializes dig_owner, and ensures that the other callers wait
until the creation and initialization is complete.

Dig_user_mutex serializes calls to digest_cache_get() by processes
accessing the same inode, and ensures that only the first assigns dig_user.

The digest cache also stores which IMA actions have been done to the
digest list, and is usable for the same actions done to an inode.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/xattr.h        |   3 +
 security/integrity/Kconfig        |  12 ++
 security/integrity/Makefile       |   1 +
 security/integrity/digest_cache.c | 317 ++++++++++++++++++++++++++++++
 security/integrity/digest_cache.h |  81 ++++++++
 security/integrity/iint.c         |  12 ++
 security/integrity/integrity.h    |   8 +
 7 files changed, 434 insertions(+)
 create mode 100644 security/integrity/digest_cache.c
 create mode 100644 security/integrity/digest_cache.h

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9..8a58cf4bce6 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -54,6 +54,9 @@
 #define XATTR_IMA_SUFFIX "ima"
 #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
 
+#define XATTR_DIGEST_LIST_SUFFIX "digest_list"
+#define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_SUFFIX
+
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index ec6e0d789da..df8a1f7e6e2 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -130,6 +130,18 @@ config INTEGRITY_AUDIT
 	  be enabled by specifying 'integrity_audit=1' on the kernel
 	  command line.
 
+config INTEGRITY_DIGEST_CACHE
+	bool "Enable the integrity digest cache"
+	depends on INTEGRITY
+	default n
+	help
+	   This option enables a cache of digests from a digest list, possibly
+	   authenticated with a signature.
+
+	   The digest cache can be used to make a TPM PCR predictable
+	   (by skipping the measurement of cached digests), or for appraisal
+	   with already available sources (e.g. RPM packages).
+
 source "security/integrity/ima/Kconfig"
 source "security/integrity/evm/Kconfig"
 
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index d0ffe37dc1d..0c175a567ac 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -11,6 +11,7 @@ integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
+integrity-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digest_cache.c b/security/integrity/digest_cache.c
new file mode 100644
index 00000000000..4201c68171a
--- /dev/null
+++ b/security/integrity/digest_cache.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019  IBM Corporation
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the integrity digest cache.
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
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+
+/**
+ * digest_cache_alloc - Allocate and initialize a new digest cache
+ * @path_str: Path of the digest list
+ * @digest_cache_mask: Actions done by IMA on the digest list
+ *
+ * This function allocates a new digest cache and initializes all fields of
+ * the digest_cache structure.
+ *
+ * Return: A digest_cache structure on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_alloc(char *path_str,
+					       u64 digest_cache_mask)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = kmalloc(sizeof(*digest_cache), GFP_KERNEL);
+	if (!digest_cache)
+		return digest_cache;
+
+	digest_cache->algo = HASH_ALGO__LAST;
+	digest_cache->path_str = path_str;
+	digest_cache->mask = digest_cache_mask;
+	digest_cache->slots = NULL;
+	digest_cache->num_slots = 0;
+	/*
+	 * One for dig_owner of the digest list iint, one for dig_user of the
+	 * iint of the inode for which the digest cache is used.
+	 */
+	atomic_set(&digest_cache->ref_count, 2);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_free - Free all memory occupied by a digest cache
+ * @digest_cache: Digest cache
+ *
+ * This function frees the digests associated to the digest cache and the
+ * digest cache itself.
+ */
+void digest_cache_free(struct digest_cache *digest_cache)
+{
+	struct digest_cache_entry *p;
+	struct hlist_node *q;
+	int digest_len, i;
+
+	if (!digest_cache)
+		return;
+
+	pr_debug("Free cache (ref count: %d), algo: %s, digest list: %s",
+		 atomic_read(&digest_cache->ref_count),
+		 hash_algo_name[digest_cache->algo], digest_cache->path_str);
+
+	if (!atomic_dec_and_test(&digest_cache->ref_count))
+		return;
+
+	digest_len = hash_digest_size[digest_cache->algo];
+
+	for (i = 0; i < digest_cache->num_slots; i++) {
+		hlist_for_each_entry_safe(p, q, &digest_cache->slots[i],
+					  hnext) {
+			hlist_del(&p->hnext);
+			pr_debug("Remove digest %s:%*phN from digest list %s\n",
+				 hash_algo_name[digest_cache->algo],
+				 digest_len, p->digest, digest_cache->path_str);
+			kfree(p);
+		}
+	}
+
+	pr_debug("Freed cache (ref count: %d), algo: %s, digest list: %s",
+		 atomic_read(&digest_cache->ref_count),
+		 hash_algo_name[digest_cache->algo], digest_cache->path_str);
+
+	kfree(digest_cache->path_str);
+	kfree(digest_cache->slots);
+	kfree(digest_cache);
+}
+
+/**
+ * digest_cache_parse_digest_list - Parse a digest list
+ * @digest_cache: Digest cache
+ * @digest_list_path: Path of the digest list
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function parses a digest list. First, it strips the module-style
+ * appended signature, if present. Then, it selects the parser to call from
+ * the beginning of the file name, which is expected to be in the format:
+ * <digest list format>-<digest list file name>.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
+					  struct path *digest_list_path,
+					  void *data, size_t data_len)
+{
+	const size_t marker_len = strlen(MODULE_SIG_STRING);
+	const struct module_signature *sig;
+	size_t sig_len;
+	const void *p;
+	int ret = -EINVAL;
+
+	/* From ima_modsig.c */
+	if (data_len <= marker_len + sizeof(*sig))
+		goto parse;
+
+	p = data + data_len - marker_len;
+	if (memcmp(p, MODULE_SIG_STRING, marker_len))
+		goto parse;
+
+	data_len -= marker_len;
+	sig = (const struct module_signature *)(p - sizeof(*sig));
+
+	sig_len = be32_to_cpu(sig->sig_len);
+	data_len -= sig_len + sizeof(*sig);
+parse:
+	pr_debug("Parsing %s, size: %ld\n", digest_cache->path_str, data_len);
+
+	return ret;
+}
+
+/**
+ * digest_cache_new - Create a new digest cache
+ * @dentry: Dentry of the file being measured/appraised
+ *
+ * This function retrieves the path of the digest list from the
+ * security.digest_list xattr of the file being measured/appraised. It then
+ * opens and parses the digest list, and finally instantiates a new digest
+ * cache.
+ *
+ * After read, the IMA actions done on the digest list are recorded in the
+ * digest cache. The use of the digest cache is allowed for measuring/appraising
+ * a file, only if the same action has been done on the digest list itself.
+ *
+ * The invoked parser will in turn set the digest algorithm, initialize the
+ * hash table and add the extracted digests to the digest cache.
+ *
+ * Return: A new digest cache on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_new(struct dentry *dentry)
+{
+	struct integrity_iint_cache *digest_list_iint;
+	struct digest_cache *digest_cache = NULL;
+	struct path digest_list_path;
+	char *path_str = NULL;
+	struct file *file;
+	void *data = NULL;
+	size_t data_len = 0;
+	struct inode *inode;
+	u64 digest_cache_mask = 0;
+	int ret;
+
+	ret = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, XATTR_NAME_DIGEST_LIST,
+				 &path_str, 0, GFP_NOFS);
+	if (ret <= 0) {
+		pr_debug("%s xattr not found in %s\n", XATTR_NAME_DIGEST_LIST,
+			 dentry->d_name.name);
+		return digest_cache;
+	}
+
+	pr_debug("Found %s xattr in %s, digest list: %s\n",
+		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, path_str);
+
+	ret = kern_path(path_str, 0, &digest_list_path);
+	if (ret < 0) {
+		pr_debug("Cannot open digest list %s\n", path_str);
+		goto out;
+	}
+
+	inode = d_backing_inode(digest_list_path.dentry);
+
+	digest_list_iint = integrity_inode_get(inode);
+	if (!digest_list_iint) {
+		pr_debug("Cannot get integrity metadata for digest list %s\n",
+			 path_str);
+		goto out_path;
+	}
+
+	if (digest_list_iint->dig_owner) {
+		pr_debug("Cache for digest list %s exists\n", path_str);
+		digest_cache = digest_list_iint->dig_owner;
+		atomic_inc(&digest_cache->ref_count);
+		goto out_path;
+	}
+
+	mutex_lock(&digest_list_iint->dig_owner_mutex);
+
+	if (digest_list_iint->dig_owner) {
+		pr_debug("Cache for digest list %s exists\n", path_str);
+		digest_cache = digest_list_iint->dig_owner;
+		atomic_inc(&digest_cache->ref_count);
+		goto out_unlock;
+	}
+
+	file = dentry_open(&digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Unable to open digest list %s\n", path_str);
+		goto out_unlock;
+	}
+
+	/* Write-lock the file to avoid getting outdated iint->flags. */
+	ret = deny_write_access(file);
+	if (ret < 0) {
+		pr_err("Unable to write-lock digest list %s", path_str);
+		goto out_fput;
+	}
+
+	ret = kernel_read_file(file, 0, &data, INT_MAX, NULL,
+			       READING_DIGEST_LIST);
+	if (ret < 0) {
+		pr_debug("Unable to read digest list %s\n", path_str);
+		goto out_allow;
+	}
+
+	if (digest_list_iint->flags & IMA_MEASURED)
+		digest_cache_mask |= DIGEST_CACHE_MEASURE;
+	if (digest_list_iint->flags & IMA_APPRAISED_SUBMASK)
+		digest_cache_mask |= DIGEST_CACHE_APPRAISE_CONTENT;
+
+	if (!digest_cache_mask) {
+		pr_debug("No actions done on digest list %s\n", path_str);
+		ret = -ENOENT;
+		goto out_vfree;
+	}
+
+	data_len = ret;
+
+	digest_cache = digest_cache_alloc(path_str, digest_cache_mask);
+	if (!digest_cache)
+		goto out_vfree;
+
+	/* Freed by digest_cache_free(). */
+	path_str = NULL;
+
+	/*
+	 * Digest list parsers must set the digest algorithm, initialize the
+	 * hash table and add the digests.
+	 */
+	ret = digest_cache_parse_digest_list(digest_cache, &digest_list_path,
+					     data, data_len);
+	if (ret < 0) {
+		pr_debug("Error parsing digest list %s, ret: %d\n",
+			 digest_cache->path_str, ret);
+		digest_cache_free(digest_cache);
+		digest_cache = NULL;
+		goto out_vfree;
+	}
+
+	digest_list_iint->dig_owner = digest_cache;
+
+	pr_debug("New cache (ref count: %d), algo: %s, digest list: %s, mask: %llu\n",
+		 atomic_read(&digest_cache->ref_count),
+		 hash_algo_name[digest_cache->algo], digest_cache->path_str,
+		 digest_cache->mask);
+out_vfree:
+	vfree(data);
+out_allow:
+	allow_write_access(file);
+out_fput:
+	fput(file);
+out_unlock:
+	mutex_unlock(&digest_list_iint->dig_owner_mutex);
+out_path:
+	path_put(&digest_list_path);
+out:
+	kfree(path_str);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_get - Obtain a digest cache and set it in the iint
+ * @dentry: Dentry of the file being measured/appraised
+ * @iint: Integrity inode cache of the file being measured/appraised
+ *
+ * Obtain a digest cache, and set it in the dig_user field of the passed iint,
+ * if not already done.
+ *
+ * Return: A digest cache on success, NULL otherwise.
+ */
+struct digest_cache *digest_cache_get(struct dentry *dentry,
+				      struct integrity_iint_cache *iint)
+{
+	if (iint->dig_user)
+		return iint->dig_user;
+
+	mutex_lock(&iint->dig_user_mutex);
+	if (!iint->dig_user)
+		iint->dig_user = digest_cache_new(dentry);
+	mutex_unlock(&iint->dig_user_mutex);
+
+	return iint->dig_user;
+}
diff --git a/security/integrity/digest_cache.h b/security/integrity/digest_cache.h
new file mode 100644
index 00000000000..ff88e8593c6
--- /dev/null
+++ b/security/integrity/digest_cache.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of the integrity digest cache.
+ */
+
+#ifndef _DIGEST_CACHE_H
+#define _DIGEST_CACHE_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <crypto/hash_info.h>
+
+/* Depth if elements were uniformly distributed in the hash table slots. */
+#define DIGEST_CACHE_HTABLE_DEPTH 30
+
+/* There is no explicit concept of metadata measurement in IMA. */
+#define DIGEST_CACHE_MEASURE   0x01
+#define DIGEST_CACHE_APPRAISE_CONTENT  0x02
+
+struct integrity_iint_cache;
+
+/**
+ * struct digest_cache - Digest cache
+ * @slots: Hash table slots
+ * @num_slots: Number of slots
+ * @ref_count: Number of references to the digest cache
+ * @algo: Algorithm of digests stored in the cache
+ * @path_str: Path of the digest list the cache was created from
+ * @mask: For which IMA actions and purpose the digest cache can be used
+ *
+ * This structure represents a cache of digests extracted from a file, to be
+ * primarily used for IMA measurement and appraisal.
+ */
+struct digest_cache {
+	struct hlist_head *slots;
+	unsigned int num_slots;
+	atomic_t ref_count;
+	enum hash_algo algo;
+	char *path_str;
+	u64 mask;
+};
+
+/**
+ * struct digest_cache_entry - Entry of a digest cache
+ * @hnext: Pointer to the next element in the collision list
+ * @digest: Stored digest
+ *
+ * This structure represents an entry of a digest cache, storing a digest.
+ */
+struct digest_cache_entry {
+	struct hlist_node hnext;
+	u8 digest[];
+} __packed;
+
+static inline unsigned int digest_cache_hash_key(u8 *digest,
+						 unsigned int num_slots)
+{
+	return (digest[0] | digest[1] << 8) % num_slots;
+}
+
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+void digest_cache_free(struct digest_cache *digest_cache);
+struct digest_cache *digest_cache_get(struct dentry *dentry,
+				      struct integrity_iint_cache *iint);
+#else
+static inline void digest_cache_free(struct digest_cache *digest_cache)
+{
+}
+
+static inline struct digest_cache *
+digest_cache_get(struct dentry *dentry, struct integrity_iint_cache *iint)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
+#endif /* _DIGEST_CACHE_H */
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index a462df827de..68ec73172e3 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -80,6 +80,12 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	digest_cache_free(iint->dig_owner);
+	digest_cache_free(iint->dig_user);
+	iint->dig_owner = NULL;
+	iint->dig_user = NULL;
+#endif
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -165,6 +171,12 @@ static void init_once(void *foo)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	mutex_init(&iint->mutex);
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	iint->dig_owner = NULL;
+	iint->dig_user = NULL;
+	mutex_init(&iint->dig_owner_mutex);
+	mutex_init(&iint->dig_user_mutex);
+#endif
 }
 
 static int __init integrity_iintcache_init(void)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bd..0192f81c67f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -19,6 +19,8 @@
 #include <linux/key.h>
 #include <linux/audit.h>
 
+#include "digest_cache.h"
+
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
 #define IMA_MEASURED		0x00000002
@@ -171,6 +173,12 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	struct digest_cache *dig_owner;		/* created from this inode */
+	struct mutex dig_owner_mutex;		/* protects dig_owner */
+	struct digest_cache *dig_user;		/* user of the digest cache */
+	struct mutex dig_user_mutex;		/* protects dig_user */
+#endif
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.34.1


