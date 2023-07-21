Return-Path: <bpf+bounces-5630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA675CF8F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995961C217FC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74640200A0;
	Fri, 21 Jul 2023 16:35:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD431F953
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:35:43 +0000 (UTC)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DA43AB3;
	Fri, 21 Jul 2023 09:35:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6vwz6R8Bz9xFQP;
	Sat, 22 Jul 2023 00:22:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3hl1bs7pkcDDSBA--.22409S4;
	Fri, 21 Jul 2023 17:33:54 +0100 (CET)
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
Subject: [RFC][PATCH 02/12] integrity: Introduce a digest cache
Date: Fri, 21 Jul 2023 18:33:16 +0200
Message-Id: <20230721163326.4106089-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwC3hl1bs7pkcDDSBA--.22409S4
X-Coremail-Antispam: 1UD129KBjvAXoWfJw4xtF13AF1rCw4rCw1fXrb_yoW8Cryxto
	Zava17Jw18WFy3uF4kCF17Za1xuw4Fq34fAr4kXrWDZ3WfXFyUJasFkFn8JFy5Xr18Gr93
	Aw18Xw4UJFW8tr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUxeHqDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4zMlAAAsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a cache of digests extracted from a (possibly signed) digest
list. The cached digests can be used by IMA to skip the measurement
of known files (not on the default PCR), or to grant access to a file if
appraisal is in enforcing mode. In the future, it can also be used to
verify the integrity of file metadata with EVM.

The digest cache is a structure holding a hash table of digests, extracted
from a digest list. It is accessible by reading the digest list path from
the new security.digest_list xattr of the file being measured/appraised,
and by retrieving the digest cache pointer from the integrity metadata
associated to the digest list file.

The digest cache is usable only if the action being performed on an
accessed file has been done also on the digest list itself. The
DIGEST_CACHE_MEASURE and DIGEST_CACHE_APPRAISE_CONTENT flags, if set,
enable the usage of the digest cache respectively for measuring and
appraising file content.

Introduce the first three methods, get, put and free. The first two are
called by IMA, when it processes a file and an action should be done on it.
The last is called by the integrity code at the time the inode is freed,
causing the digest cache also to be freed.

The digest cache is guaranteed to be available throughout the IMA
processing of the current file, by acquiring and releasing a reference to
the path structure of the digest list file (so that the latter cannot be
suddenly freed, e.g. by deleting the file).

Another important point is that, for simplicity, the digest cache is
created only once, from the first read. Further modifications of the digest
lists, if they are ever allowed, are ignored. The iint mutex is taken only
for assigning the digest cache pointer. Since the digest cache is not
modified afterwards, there is no need to lock after creation.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/xattr.h        |   3 +
 security/integrity/Kconfig        |  12 ++
 security/integrity/Makefile       |   1 +
 security/integrity/digest_cache.c | 300 ++++++++++++++++++++++++++++++
 security/integrity/digest_cache.h |  84 +++++++++
 security/integrity/iint.c         |   7 +
 security/integrity/ima/ima.h      |   1 -
 security/integrity/integrity.h    |   5 +
 8 files changed, 412 insertions(+), 1 deletion(-)
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
index 00000000000..66c2c4088e9
--- /dev/null
+++ b/security/integrity/digest_cache.c
@@ -0,0 +1,300 @@
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
+ *
+ * This function allocates a new digest cache and initializes all fields of
+ * the digest_cache structure.
+ *
+ * Return: A digest_cache structure on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_alloc(char *path_str)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = kmalloc(sizeof(*digest_cache), GFP_KERNEL);
+	if (!digest_cache)
+		return digest_cache;
+
+	digest_cache->algo = HASH_ALGO__LAST;
+	digest_cache->path_str = path_str;
+	digest_cache->mask = 0;
+	digest_cache->slots = NULL;
+	digest_cache->num_slots = 0;
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
+	pr_debug("Free cache, algo: %s, digest list: %s",
+		 hash_algo_name[digest_cache->algo],
+		 digest_cache->path_str);
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
+ * digest_cache_get - Get a digest cache
+ * @dentry_to_check: Dentry of the file being measured/appraised
+ * @digest_list_path: Path structure of the digest list
+ *
+ * This function retrieves the path of the digest list from the
+ * security.digest_list xattr of the file being measured/appraised. It then
+ * instantiates a new digest cache, and opens and parses the digest list.
+ *
+ * After read, the IMA actions done on the digest list are recorded in the
+ * digest cache. The use of the digest cache is allowed for measuring/appraising
+ * a file, only if the same action has been done on the digest list itself.
+ *
+ * The invoked parser will in turn set the digest algorithm, initialize the
+ * hash table and add the extracted digests to the digest cache.
+ *
+ * The caller is responsible to invoke digest_cache_put(), to release
+ * the reference of the path structure associated to the digest list.
+ *
+ * Return: A new digest cache on success, NULL on error.
+ */
+struct digest_cache *digest_cache_get(struct dentry *dentry_to_check,
+				      struct path *digest_list_path)
+{
+	struct integrity_iint_cache *digest_list_iint;
+	struct digest_cache *digest_cache = NULL;
+	char *path_str = NULL;
+	struct file *file;
+	void *data = NULL;
+	size_t data_len = 0;
+	struct inode *inode;
+	int ret;
+
+	ret = vfs_getxattr_alloc(&nop_mnt_idmap, dentry_to_check,
+				 XATTR_NAME_DIGEST_LIST, &path_str, 0,
+				 GFP_NOFS);
+	if (ret <= 0) {
+		pr_debug("%s xattr not found in %s\n", XATTR_NAME_DIGEST_LIST,
+			 dentry_to_check->d_name.name);
+		return digest_cache;
+	}
+
+	pr_debug("Found %s xattr in %s, digest list: %s\n",
+		 XATTR_NAME_DIGEST_LIST, dentry_to_check->d_name.name,
+		 path_str);
+
+	ret = kern_path(path_str, 0, digest_list_path);
+	if (ret < 0) {
+		pr_debug("Cannot open digest list %s\n", path_str);
+		goto out;
+	}
+
+	inode = d_backing_inode(digest_list_path->dentry);
+
+	digest_list_iint = integrity_inode_get(inode);
+	if (!digest_list_iint) {
+		pr_debug("Cannot get integrity metadata for digest list %s\n",
+			 path_str);
+		goto out_path;
+	}
+
+	if (digest_list_iint->digest_cache) {
+		pr_debug("Cache for digest list %s exists\n", path_str);
+		digest_cache = digest_list_iint->digest_cache;
+		goto out_path;
+	}
+
+	file = dentry_open(digest_list_path, O_RDONLY, &init_cred);
+	if (IS_ERR(file)) {
+		pr_debug("Unable to open digest list %s\n", path_str);
+		goto out_path;
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
+	data_len = ret;
+
+	digest_cache = digest_cache_alloc(path_str);
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
+	ret = digest_cache_parse_digest_list(digest_cache, digest_list_path,
+					     data, data_len);
+	if (ret < 0) {
+		pr_debug("Error parsing digest list %s, ret: %d\n",
+			 digest_cache->path_str, ret);
+		digest_cache_free(digest_cache);
+		digest_cache = NULL;
+		goto out_vfree;
+	}
+
+	/*
+	 * Add penalty only for concurrent add, otherwise don't take a lock.
+	 * In the worst case, the lock contenders waste time to create a
+	 * digest cache that is freed.
+	 */
+	mutex_lock(&digest_list_iint->mutex);
+	/* Someone came before us. */
+	if (digest_list_iint->digest_cache) {
+		pr_debug("Cache for digest list %s exists\n",
+			 digest_cache->path_str);
+		digest_cache_free(digest_cache);
+		digest_cache = digest_list_iint->digest_cache;
+		mutex_unlock(&digest_list_iint->mutex);
+		goto out_vfree;
+	}
+
+	digest_list_iint->digest_cache = digest_cache;
+	if (digest_list_iint->flags & IMA_MEASURED)
+		digest_cache->mask |= DIGEST_CACHE_MEASURE;
+	if (digest_list_iint->flags & IMA_APPRAISED_SUBMASK)
+		digest_cache->mask |= DIGEST_CACHE_APPRAISE_CONTENT;
+	mutex_unlock(&digest_list_iint->mutex);
+
+	pr_debug("Get cache, algo: %s, digest list: %s, mask: %d\n",
+		 hash_algo_name[digest_cache->algo], digest_cache->path_str,
+		 digest_cache->mask);
+out_vfree:
+	vfree(data);
+out_allow:
+	allow_write_access(file);
+out_fput:
+	fput(file);
+out_path:
+	if (!digest_cache)
+		path_put(digest_list_path);
+out:
+	kfree(path_str);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_put - Release a digest cache
+ * @digest_cache: Digest cache
+ * @digest_list_path: Path structure of the digest list
+ *
+ * This function releases the path structure of the digest list.
+ */
+void digest_cache_put(struct digest_cache *digest_cache,
+		      struct path *digest_list_path)
+{
+	if (!digest_cache)
+		return;
+
+	/* Pairs with kernel_path() in digest_cache_get(). */
+	path_put(digest_list_path);
+
+	pr_debug("Put cache, algo: %s, digest list: %s",
+		 hash_algo_name[digest_cache->algo], digest_cache->path_str);
+}
diff --git a/security/integrity/digest_cache.h b/security/integrity/digest_cache.h
new file mode 100644
index 00000000000..fa4a716df65
--- /dev/null
+++ b/security/integrity/digest_cache.h
@@ -0,0 +1,84 @@
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
+/**
+ * struct digest_cache - Digest cache
+ * @slots: Hash table slots
+ * @num_slots: Number of slots
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
+	enum hash_algo algo;
+	char *path_str;
+	u8 mask;
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
+				      struct path *digest_list_path);
+void digest_cache_put(struct digest_cache *digest_cache,
+		      struct path *digest_list_path);
+#else
+static inline void digest_cache_free(struct digest_cache *digest_cache)
+{
+}
+
+static inline struct digest_cache *
+digest_cache_get(struct dentry *dentry, struct path *digest_list_path)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void digest_cache_put(struct digest_cache *digest_cache,
+				    struct path *digest_list_path)
+{
+}
+
+#endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
+#endif /* _DIGEST_CACHE_H */
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index a462df827de..9a35ae1fb85 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -80,6 +80,10 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	digest_cache_free(iint->digest_cache);
+	iint->digest_cache = NULL;
+#endif
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -165,6 +169,9 @@ static void init_once(void *foo)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	mutex_init(&iint->mutex);
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	iint->digest_cache = NULL;
+#endif
 }
 
 static int __init integrity_iintcache_init(void)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3aef3d8fb57..859a94bcecb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -452,5 +452,4 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #else
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
-
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bd..bd3f9a27f0d 100644
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
@@ -171,6 +173,9 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+	struct digest_cache *digest_cache;
+#endif
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.34.1


