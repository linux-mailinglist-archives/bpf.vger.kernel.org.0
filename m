Return-Path: <bpf+bounces-2312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D372AA18
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9758281A4C
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E63BA47;
	Sat, 10 Jun 2023 07:58:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71279A950
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 07:58:46 +0000 (UTC)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9703CC;
	Sat, 10 Jun 2023 00:58:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QdVRy47bVz9y5YV;
	Sat, 10 Jun 2023 15:48:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBH0AsGLYRklC8oAw--.4566S3;
	Sat, 10 Jun 2023 08:58:20 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	kpsingh@kernel.org,
	keescook@chromium.org,
	nicolas.bouchinet@clip-os.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for inode_init_security hook
Date: Sat, 10 Jun 2023 09:57:35 +0200
Message-Id: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
References: <20230610075738.3273764-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwBH0AsGLYRklC8oAw--.4566S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr1DWw4kZFyUuF4xJr1xAFb_yoW8GF1fuo
	WxJwnrXr40gr13GrWYgFn7JFZrZayfWr4fJr1Yvr4UAa4ay34DCw13Ja15Xa13XryrKr10
	q3srAay8XFW2qF98n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYJ7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj45+YgABsj
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Roberto Sassu <roberto.sassu@huawei.com>

Currently, the LSM infrastructure supports only one LSM providing an xattr
and EVM calculating the HMAC on that xattr, plus other inode metadata.

Allow all LSMs to provide one or multiple xattrs, by extending the security
blob reservation mechanism. Introduce the new lbs_xattr_count field of the
lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
needs, and the LSM infrastructure knows how many xattr slots it should
allocate.

Modify the inode_init_security hook definition, by passing the full
xattr array allocated in security_inode_init_security(), and the current
number of xattr slots in that array filled by LSMs. The first parameter
would allow EVM to access and calculate the HMAC on xattrs supplied by
other LSMs, the second to not leave gaps in the xattr array, when an LSM
requested but did not provide xattrs (e.g. if it is not initialized).

Introduce lsm_get_xattr_slot(), which LSMs can call as many times as the
number specified in the lbs_xattr_count field of the lsm_blob_sizes
structure. During each call, lsm_get_xattr_slot() increments the number of
filled xattrs, so that at the next invocation it returns the next xattr
slot to fill.

Cleanup security_inode_init_security(). Unify the !initxattrs and
initxattrs case by simply not allocating the new_xattrs array in the
former. Update the documentation to reflect the changes, and fix the
description of the xattr name, as it is not allocated anymore.

Adapt both SELinux and Smack to use the new definition of the
inode_init_security hook, and to call lsm_get_xattr_slot() to obtain and
fill the reserved slots in the xattr array.

Move the xattr->name assignment after the xattr->value one, so that it is
done only in case of successful memory allocation.

Finally, change the default return value of the inode_init_security hook
from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
conventions.

Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hook_defs.h |  6 +--
 include/linux/lsm_hooks.h     | 20 ++++++++++
 security/security.c           | 71 +++++++++++++++++++++++------------
 security/selinux/hooks.c      | 17 +++++----
 security/smack/smack_lsm.c    | 25 ++++++------
 5 files changed, 92 insertions(+), 47 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e..a1896f90089 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -111,9 +111,9 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, const char **name,
-	 void **value, size_t *len)
+LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
+	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
+	 int *xattr_count)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ab2b2fafa4a..dcb5e5b5eb1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,7 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/xattr.h>
 
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
@@ -63,8 +64,27 @@ struct lsm_blob_sizes {
 	int	lbs_ipc;
 	int	lbs_msg_msg;
 	int	lbs_task;
+	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
 };
 
+/**
+ * lsm_get_xattr_slot - Return the next available slot and increment the index
+ * @xattrs: array storing LSM-provided xattrs
+ * @xattr_count: number of already stored xattrs (updated)
+ *
+ * Retrieve the first available slot in the @xattrs array to fill with an xattr,
+ * and increment @xattr_count.
+ *
+ * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
+ */
+static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
+					       int *xattr_count)
+{
+	if (unlikely(!xattrs))
+		return NULL;
+	return &xattrs[(*xattr_count)++];
+}
+
 /*
  * LSM_RET_VOID is used as the default value in LSM_HOOK definitions for void
  * LSM hooks (in include/linux/lsm_hook_defs.h).
diff --git a/security/security.c b/security/security.c
index ee4f1cc4902..d5ef7df1ce4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -31,8 +31,6 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 
-#define MAX_LSM_EVM_XATTR	2
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -212,6 +210,8 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
 }
 
 /* Prepare LSM for initialization. */
@@ -378,6 +378,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -1591,11 +1592,15 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
  * created inode and set up the incore security field for the new inode.  This
  * hook is called by the fs code as part of the inode creation transaction and
  * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
- * hooks called by the VFS.  The hook function is expected to allocate the name
- * and value via kmalloc, with the caller being responsible for calling kfree
- * after using them.  If the security module does not use security attributes
- * or does not wish to put a security attribute on this particular inode, then
- * it should return -EOPNOTSUPP to skip this processing.
+ * hooks called by the VFS.  The hook function is expected to populate the
+ * @xattrs array, by calling lsm_get_xattr_slot() to retrieve the slots
+ * reserved by the security module with the lbs_xattr_count field of the
+ * lsm_blob_sizes structure.  For each slot, the hook function should set ->name
+ * to the attribute name suffix (e.g. selinux), to allocate ->value (will be
+ * freed by the caller) and set it to the attribute value, to set ->value_len to
+ * the length of the value.  If the security module does not use security
+ * attributes or does not wish to put a security attribute on this particular
+ * inode, then it should return -EOPNOTSUPP to skip this processing.
  *
  * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
  * needed, or -ENOMEM on memory allocation failure.
@@ -1604,33 +1609,51 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *P;
+	struct xattr *new_xattrs = NULL;
+	int ret = -EOPNOTSUPP, xattr_count = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
-	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-			    &lsm_xattr->name,
-			    &lsm_xattr->value,
-			    &lsm_xattr->value_len);
-	if (ret)
+	if (!blob_sizes.lbs_xattr_count)
+		return 0;
+
+	if (initxattrs) {
+		/* Allocate +1 for EVM and +1 as terminator. */
+		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
+				     sizeof(*new_xattrs), GFP_NOFS);
+		if (!new_xattrs)
+			return -ENOMEM;
+	}
+
+	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
+			     list) {
+		ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+						  &xattr_count);
+		if (ret && ret != -EOPNOTSUPP)
+			goto out;
+		/*
+		 * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
+		 * means that the LSM is not willing to provide an xattr, not
+		 * that it wants to signal an error. Thus, continue to invoke
+		 * the remaining LSMs.
+		 */
+	}
+
+	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
+	if (!xattr_count)
 		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+	ret = evm_inode_init_security(inode, new_xattrs,
+				      &new_xattrs[xattr_count]);
 	if (ret)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
-		kfree(xattr->value);
+	for (; xattr_count > 0; xattr_count--)
+		kfree(new_xattrs[xattr_count - 1].value);
+	kfree(new_xattrs);
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79b4890e993..1d9fe7cdd01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,6 +104,8 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+#define SELINUX_INODE_INIT_XATTRS 1
+
 struct selinux_state selinux_state;
 
 /* SECMARK reference count */
@@ -2823,11 +2825,11 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       const char **name,
-				       void **value, size_t *len)
+				       struct xattr *xattrs, int *xattr_count)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
+	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	u32 newsid, clen;
 	int rc;
 	char *context;
@@ -2854,16 +2856,14 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	if (name)
-		*name = XATTR_SELINUX_SUFFIX;
-
-	if (value && len) {
+	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
 		if (rc)
 			return rc;
-		*value = context;
-		*len = clen;
+		xattr->value = context;
+		xattr->value_len = clen;
+		xattr->name = XATTR_SELINUX_SUFFIX;
 	}
 
 	return 0;
@@ -6776,6 +6776,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
+	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6e270cf3fd3..25ade3819af 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -52,6 +52,8 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
 
+#define SMACK_INODE_INIT_XATTRS 1
+
 #ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
@@ -923,27 +925,24 @@ static int smack_inode_alloc_security(struct inode *inode)
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @name: where to put the attribute name
- * @value: where to put the attribute value
- * @len: where to put the length of the attribute
+ * @xattrs: where to put the attributes
+ * @xattr_count: current number of LSM-provided xattrs (updated)
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
-				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len)
+				     const struct qstr *qstr,
+				     struct xattr *xattrs, int *xattr_count)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
+	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	int may;
 
-	if (name)
-		*name = XATTR_SMACK_SUFFIX;
-
-	if (value && len) {
+	if (xattr) {
 		/*
 		 * If equal, transmuting already occurred in
 		 * smack_dentry_create_files_as(). No need to check again.
@@ -975,11 +974,12 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
-		*value = kstrdup(isp->smk_known, GFP_NOFS);
-		if (*value == NULL)
+		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
+		if (!xattr->value)
 			return -ENOMEM;
 
-		*len = strlen(isp->smk_known);
+		xattr->value_len = strlen(isp->smk_known);
+		xattr->name = XATTR_SMACK_SUFFIX;
 	}
 
 	return 0;
@@ -4869,6 +4869,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_superblock = sizeof(struct superblock_smack),
+	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
-- 
2.25.1


