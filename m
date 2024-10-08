Return-Path: <bpf+bounces-41265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24F995529
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA4286DDD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 16:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347BA1E1041;
	Tue,  8 Oct 2024 16:58:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE631DF964;
	Tue,  8 Oct 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406681; cv=none; b=pnpRzi0i38rmOVQYgbQZM76q2IhPp2M+XkLORZMZPc88JBMpLSYk92b8Q7Cx3AAMxZqYFcqqc4h/egV0RTOYKcNW6c5ZqnruwwQG14Y86mnWisFelugrChtsQ53mRsrX6VoRI4veOOYCxW7YPbzI4uwrHjNEcnYzxGaZEN+u+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406681; c=relaxed/simple;
	bh=X59DJW+OtGgKWLWosloDcJz8o4IgMFFhEe6CwNhc4dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QR6rtCoJtMk3X3l9BlKRVM4IEH/fTkDXwfNmc04TYldq6Di6g4Qs7hKF7wxuYZJaizSIcvrQKd3gqUheqVdf9H0Yo5swsePHFlp7ATsfLQSr0eLONW7HbBqG6rB5Si8f4EHOUd5WYFnJ0GGiAsB4jZVv+PiVvrrefW2XYXSz4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNMBf6XQYz9v7Hm;
	Wed,  9 Oct 2024 00:37:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 727D61401F0;
	Wed,  9 Oct 2024 00:57:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnlseAZAVng2B7Ag--.64194S2;
	Tue, 08 Oct 2024 17:57:43 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ebpqwerty472123@gmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/3] ima: Remove inode lock
Date: Tue,  8 Oct 2024 18:57:30 +0200
Message-Id: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDnlseAZAVng2B7Ag--.64194S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGry3tF13ZFyxXFWkCw1xXwb_yoW8JrW7Ko
	WSy3sxJrn8WrySyay8Ww1SyFW8u39xG3yfCrs5XFnrK3W2kryUX347W3W3JFW3Xr4rGr1q
	k3s7Jw4kJF9rJ3Wkn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBGcElPgLNgAAs9

From: Roberto Sassu <roberto.sassu@huawei.com>

Move out the mutex in the ima_iint_cache structure to a new structure
called ima_iint_cache_lock, so that a lock can be taken regardless of
whether or not inode integrity metadata are stored in the inode.

Introduce ima_inode_security() to simplify accessing the new structure in
the inode security blob.

Move the mutex initialization and annotation in the new function
ima_inode_alloc_security() and introduce ima_iint_lock() and
ima_iint_unlock() to respectively lock and unlock the mutex.

Finally, expand the critical region in process_measurement() guarded by
iint->mutex up to where the inode was locked, use only one iint lock in
__ima_inode_hash(), since the mutex is now in the inode security blob, and
replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h      | 26 ++++++++---
 security/integrity/ima/ima_api.c  |  4 +-
 security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
 security/integrity/ima/ima_main.c | 39 +++++++---------
 4 files changed, 104 insertions(+), 42 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3c323ca213d4..6474a15b584a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,7 +182,6 @@ struct ima_kexec_hdr {
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
-	struct mutex mutex;	/* protects: version, flags, digest */
 	struct integrity_inode_attributes real_inode;
 	unsigned long flags;
 	unsigned long measured_pcrs;
@@ -195,35 +194,48 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+struct ima_iint_cache_lock {
+	struct mutex mutex;	/* protects: version, flags, digest */
+	struct ima_iint_cache *iint;
+};
+
 extern struct lsm_blob_sizes ima_blob_sizes;
 
+static inline struct ima_iint_cache_lock *ima_inode_security(void *i_security)
+{
+	return i_security + ima_blob_sizes.lbs_inode;
+}
+
 static inline struct ima_iint_cache *
 ima_inode_get_iint(const struct inode *inode)
 {
-	struct ima_iint_cache **iint_sec;
+	struct ima_iint_cache_lock *iint_lock;
 
 	if (unlikely(!inode->i_security))
 		return NULL;
 
-	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
-	return *iint_sec;
+	iint_lock = ima_inode_security(inode->i_security);
+	return iint_lock->iint;
 }
 
 static inline void ima_inode_set_iint(const struct inode *inode,
 				      struct ima_iint_cache *iint)
 {
-	struct ima_iint_cache **iint_sec;
+	struct ima_iint_cache_lock *iint_lock;
 
 	if (unlikely(!inode->i_security))
 		return;
 
-	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
-	*iint_sec = iint;
+	iint_lock = ima_inode_security(inode->i_security);
+	iint_lock->iint = iint;
 }
 
 struct ima_iint_cache *ima_iint_find(struct inode *inode);
 struct ima_iint_cache *ima_inode_get(struct inode *inode);
+int ima_inode_alloc_security(struct inode *inode);
 void ima_inode_free_rcu(void *inode_security);
+void ima_iint_lock(struct inode *inode);
+void ima_iint_unlock(struct inode *inode);
 void __init ima_iintcache_init(void);
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 984e861f6e33..37c2a228f0e1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -234,7 +234,7 @@ static bool ima_get_verity_digest(struct ima_iint_cache *iint,
  * Calculate the file hash, if it doesn't already exist,
  * storing the measurement and i_version in the iint.
  *
- * Must be called with iint->mutex held.
+ * Must be called with iint mutex held.
  *
  * Return 0 on success, error code otherwise
  */
@@ -343,7 +343,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
  *	- the inode was previously flushed as well as the iint info,
  *	  containing the hashing info.
  *
- * Must be called with iint->mutex held.
+ * Must be called with iint mutex held.
  */
 void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..c176fd0faae7 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -40,18 +40,18 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
  */
-static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
-					     struct inode *inode)
+static inline void ima_iint_lock_lockdep_annotate(struct mutex *mutex,
+						  struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
+	static struct lock_class_key ima_iint_lock_mutex_key[IMA_MAX_NESTING];
 
 	int depth = inode->i_sb->s_stack_depth;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class(mutex, &ima_iint_lock_mutex_key[depth]);
 #endif
 }
 
@@ -68,14 +68,11 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
-	mutex_init(&iint->mutex);
-	ima_iint_lockdep_annotate(iint, inode);
 }
 
 static void ima_iint_free(struct ima_iint_cache *iint)
 {
 	kfree(iint->ima_hash);
-	mutex_destroy(&iint->mutex);
 	kmem_cache_free(ima_iint_cache, iint);
 }
 
@@ -108,6 +105,26 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
 	return iint;
 }
 
+/**
+ * ima_inode_alloc_security - Called to init an inode
+ * @inode: Pointer to the inode
+ *
+ * Initialize and annotate the mutex in the ima_iint_cache_lock structure.
+ *
+ * Return: Zero.
+ */
+int ima_inode_alloc_security(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
+
+	mutex_init(&iint_lock->mutex);
+	ima_iint_lock_lockdep_annotate(&iint_lock->mutex, inode);
+
+	return 0;
+}
+
 /**
  * ima_inode_free_rcu - Called to free an inode via a RCU callback
  * @inode_security: The inode->i_security pointer
@@ -116,11 +133,49 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
  */
 void ima_inode_free_rcu(void *inode_security)
 {
-	struct ima_iint_cache **iint_p = inode_security + ima_blob_sizes.lbs_inode;
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode_security);
+
+	mutex_destroy(&iint_lock->mutex);
+
+	/* iint_lock->iint should be NULL if !IS_IMA(inode) */
+	if (iint_lock->iint)
+		ima_iint_free(iint_lock->iint);
+}
+
+/**
+ * ima_iint_lock - Lock integrity metadata
+ * @inode: Pointer to the inode
+ *
+ * Lock integrity metadata.
+ */
+void ima_iint_lock(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
+
+	/* Only inodes with i_security are processed by IMA. */
+	if (iint_lock)
+		mutex_lock(&iint_lock->mutex);
+}
+
+/**
+ * ima_iint_unlock - Unlock integrity metadata
+ * @inode: Pointer to the inode
+ *
+ * Unlock integrity metadata.
+ */
+void ima_iint_unlock(struct inode *inode)
+{
+	struct ima_iint_cache_lock *iint_lock;
+
+	iint_lock = ima_inode_security(inode->i_security);
 
-	/* *iint_p should be NULL if !IS_IMA(inode) */
-	if (*iint_p)
-		ima_iint_free(*iint_p);
+	/* Only inodes with i_security are processed by IMA. */
+	if (iint_lock)
+		mutex_unlock(&iint_lock->mutex);
 }
 
 static void ima_iint_init_once(void *foo)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..7852212c43ce 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -163,7 +163,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (!(mode & FMODE_WRITE))
 		return;
 
-	mutex_lock(&iint->mutex);
+	ima_iint_lock(inode);
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
@@ -181,7 +181,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				ima_update_xattr(iint, file);
 		}
 	}
-	mutex_unlock(&iint->mutex);
+	ima_iint_unlock(inode);
 }
 
 /**
@@ -247,7 +247,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (action & IMA_FILE_APPRAISE)
 		func = FILE_CHECK;
 
-	inode_lock(inode);
+	ima_iint_lock(inode);
 
 	if (action) {
 		iint = ima_inode_get(inode);
@@ -259,15 +259,11 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
 					 &pathbuf, &pathname, filename);
 
-	inode_unlock(inode);
-
 	if (rc)
 		goto out;
 	if (!action)
 		goto out;
 
-	mutex_lock(&iint->mutex);
-
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
@@ -412,10 +408,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
-	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
 out:
+	ima_iint_unlock(inode);
 	if (pathbuf)
 		__putname(pathbuf);
 	if (must_appraise) {
@@ -580,18 +576,13 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 	struct ima_iint_cache *iint = NULL, tmp_iint;
 	int rc, hash_algo;
 
-	if (ima_policy_flag) {
+	ima_iint_lock(inode);
+
+	if (ima_policy_flag)
 		iint = ima_iint_find(inode);
-		if (iint)
-			mutex_lock(&iint->mutex);
-	}
 
 	if ((!iint || !(iint->flags & IMA_COLLECTED)) && file) {
-		if (iint)
-			mutex_unlock(&iint->mutex);
-
 		memset(&tmp_iint, 0, sizeof(tmp_iint));
-		mutex_init(&tmp_iint.mutex);
 
 		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
 					     ima_hash_algo, NULL);
@@ -600,22 +591,24 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			if (rc != -ENOMEM)
 				kfree(tmp_iint.ima_hash);
 
+			ima_iint_unlock(inode);
 			return -EOPNOTSUPP;
 		}
 
 		iint = &tmp_iint;
-		mutex_lock(&iint->mutex);
 	}
 
-	if (!iint)
+	if (!iint) {
+		ima_iint_unlock(inode);
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * ima_file_hash can be called when ima_collect_measurement has still
 	 * not been called, we might not always have a hash.
 	 */
 	if (!iint->ima_hash || !(iint->flags & IMA_COLLECTED)) {
-		mutex_unlock(&iint->mutex);
+		ima_iint_unlock(inode);
 		return -EOPNOTSUPP;
 	}
 
@@ -626,11 +619,12 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 		memcpy(buf, iint->ima_hash->digest, copied_size);
 	}
 	hash_algo = iint->ima_hash->algo;
-	mutex_unlock(&iint->mutex);
 
 	if (iint == &tmp_iint)
 		kfree(iint->ima_hash);
 
+	ima_iint_unlock(inode);
+
 	return hash_algo;
 }
 
@@ -1118,7 +1112,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
  * @kmod_name: kernel module name
  *
  * Avoid a verification loop where verifying the signature of the modprobe
- * binary requires executing modprobe itself. Since the modprobe iint->mutex
+ * binary requires executing modprobe itself. Since the modprobe iint mutex
  * is already held when the signature verification is performed, a deadlock
  * occurs as soon as modprobe is executed within the critical region, since
  * the same lock cannot be taken again.
@@ -1193,6 +1187,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
 #endif
+	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
 	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
 };
 
@@ -1210,7 +1205,7 @@ static int __init init_ima_lsm(void)
 }
 
 struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
-	.lbs_inode = sizeof(struct ima_iint_cache *),
+	.lbs_inode = sizeof(struct ima_iint_cache_lock),
 };
 
 DEFINE_LSM(ima) = {
-- 
2.34.1


