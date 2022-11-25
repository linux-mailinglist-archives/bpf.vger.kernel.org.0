Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE538638DF3
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKYP5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 10:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKYP5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 10:57:30 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0ED394;
        Fri, 25 Nov 2022 07:57:25 -0800 (PST)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D8761FF80C;
        Fri, 25 Nov 2022 15:57:16 +0000 (UTC)
Date:   Fri, 25 Nov 2022 16:57:15 +0100
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     linux-integrity@vger.kernel.org
Cc:     philippe.trebuchet@ssi.gouv.fr, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org,
        roberto.sassu@huaweicloud.com
Subject: [PATCH v5] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y4Dl2yjVRkJvBflq@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Fixes a NULL pointer dereference occurring in the
`evm_protected_xattr_common` function of the EVM LSM. The bug is
triggered if a `inode_init_security` hook returns 0 without initializing
the given `struct xattr` fields (which is the case of BPF) and if no
other LSM overrides thoses fields after. This also leads to memory
leaks.

The `call_int_hook_xattr` macro has been inlined into the
`security_inode_init_security` hook in order to check hooks return
values and skip ones who doesn't init `xattrs`.

Modify `evm_init_hmac` function to init the EVM hmac using every
entry of the given xattr array.

The `MAX_LSM_EVM_XATTR` value is now based on the security modules
compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
IMA/EVM security attributes.

Changes the default return value of the `inode_init_security` hook
definition to `-EOPNOTSUPP`.

Changes the hook documentation to match the behavior of the LSMs using
it (only xattr->value is initialised with kmalloc and thus is the only
one that should be kfreed by the caller).

Cc: roberto.sassu@huaweicloud.com
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
Changes since v4:
https://lore.kernel.org/linux-integrity/Y1lElHVQGT%2F1Pa6O@archlinux/
* Updated the `security_inode_init_security()` hook documentation.
* Moved the NULL pointer dereference check from `evm_protected_xattr_common()`
  inside the LSM hook calls loop of the `security_inode_init_security()`
  function (as suggested by Roberto Sassu).
* Fixes the error return conditions of the `hlist_for_each_entry()`
  loop in the `security_inode_init_security()` function (as suggested by Roberto Sassu).
* Fixes the `evm_xattr` pointer calculation before the `evm_inode_init_security()`
  call (as suggested by Roberto Sassu).

Changes since v3:
https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
* Fixes compilation error reported by the kernel test robot.

Changes since v2:
https://lore.kernel.org/linux-integrity/Y1K3bf+dtNnVe7DG@archlinux/
* The `evm_init_hmacs` has been merged with `evm_init_hmac`
  (as suggested by Mimi Zohar).
* The commit message has been updated to match the patch changes.

Changes since v1:
https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
* The `call_int_hook_xattr` macro has been inlined into the
  `security_inode_init_security` hook (as suggested by Paul Moor,
  Mickaël Salaün and Casey Schaufler).
* The MAX_LSM_EVM_XATTR value is processed based on compiled LSMs (as
  proposed by Casey Schaufler).
* Various typos and cosmetic changes has been fixed (as suggested by
  Mickaël Salaün)
* A MAX_LSM_EVM_XATTR test has been wrapped in a WARN_ON_ONCE macro (as
  suggested by Mickaël Salaün).
---
 include/linux/lsm_hook_defs.h       |  2 +-
 include/linux/lsm_hooks.h           |  6 ++---
 security/integrity/evm/evm.h        |  1 +
 security/integrity/evm/evm_crypto.c |  9 +++++--
 security/integrity/evm/evm_main.c   |  5 ++--
 security/security.c                 | 39 ++++++++++++++++++++++-------
 6 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ec119da1d89b4..0ba396f08c4f1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
+LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ec80b96c22e7..8a2762f7e75f5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -229,15 +229,15 @@
  *	This hook is called by the fs code as part of the inode creation
  *	transaction and provides for atomic labeling of the inode, unlike
  *	the post_create/mkdir/... hooks called by the VFS.  The hook function
- *	is expected to allocate the name and value via kmalloc, with the caller
- *	being responsible for calling kfree after using them.
+ *	is expected to allocate the value via kmalloc, with the caller
+ *	being responsible for calling kfree after using it.
  *	If the security module does not use security attributes or does
  *	not wish to put a security attribute on this particular inode,
  *	then it should return -EOPNOTSUPP to skip this processing.
  *	@inode contains the inode structure of the newly created inode.
  *	@dir contains the inode structure of the parent directory.
  *	@qstr contains the last path component of the new object
- *	@name will be set to the allocated name suffix (e.g. selinux).
+ *	@name will be set to a name suffix (e.g. selinux).
  *	@value will be set to the allocated attribute value.
  *	@len will be set to the length of the value.
  *	Returns 0 if @name and @value have been successfully set,
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f8b8c5004fc7c..6d9628ca7c246 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -61,5 +61,6 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
 		  char *hmac_val);
 int evm_init_secfs(void);
+int evm_protected_xattr(const char *req_xattr_name);
 
 #endif
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 708de9656bbd2..06639f3cfb383 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -385,7 +385,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	return rc;
 }
 
-int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
+int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattrs,
 		  char *hmac_val)
 {
 	struct shash_desc *desc;
@@ -396,7 +396,12 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		return PTR_ERR(desc);
 	}
 
-	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
+	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
+		if (evm_protected_xattr(lsm_xattrs[i].name))
+			crypto_shash_update(desc,
+					    lsm_xattrs[i].value,
+					    lsm_xattrs[i].value_len);
+	}
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 23d484e05e6f2..35a060a6124c5 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -305,7 +305,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
 	return found;
 }
 
-static int evm_protected_xattr(const char *req_xattr_name)
+int evm_protected_xattr(const char *req_xattr_name)
 {
 	return evm_protected_xattr_common(req_xattr_name, false);
 }
@@ -852,8 +852,7 @@ int evm_inode_init_security(struct inode *inode,
 	struct evm_xattr *xattr_data;
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattr->name))
+	if (!(evm_initialized & EVM_INIT_HMAC))
 		return 0;
 
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
diff --git a/security/security.c b/security/security.c
index 79d82cb6e4696..6cdd3fdc08fbc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,7 +30,11 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 
-#define MAX_LSM_EVM_XATTR	2
+#define MAX_LSM_EVM_XATTR                                \
+	((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
+	 (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	 (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
+	 (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -1093,9 +1097,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
+	int initialized_lsms = 0;
+	int ret = -EOPNOTSUPP;
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *hook_ptr;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1105,15 +1111,30 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				     dir, qstr, NULL, NULL, NULL);
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
+	hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security,
+			     list) {
+		ret = hook_ptr->hook.inode_init_security(inode, dir, qstr,
+				&lsm_xattr->name,
+				&lsm_xattr->value,
+				&lsm_xattr->value_len);
+		if (ret == -EOPNOTSUPP)
+			continue;
+		if (ret != 0)
+			goto out;
+		if (WARN_ON_ONCE(initialized_lsms >= MAX_LSM_EVM_XATTR ||
+						     !lsm_xattr->name ||
+						     !lsm_xattr->value)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		lsm_xattr++;
+		initialized_lsms++;
+	}
+	if (!initialized_lsms)
 		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+	evm_xattr = lsm_xattr;
+	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 	if (ret)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
-- 
2.38.1

