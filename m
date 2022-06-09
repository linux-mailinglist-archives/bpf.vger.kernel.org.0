Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4F5458D3
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbiFIXqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 19:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345637AbiFIXqg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 19:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417573D1D1;
        Thu,  9 Jun 2022 16:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A3AA62022;
        Thu,  9 Jun 2022 23:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E93C36B01;
        Thu,  9 Jun 2022 23:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654818393;
        bh=GQRb5utNPH5Z44nEBllhP4ze3hxP7caLjCPeYAMVHxI=;
        h=From:To:Cc:Subject:Date:From;
        b=idWrlHgmHEkPWVgacYPsauOXab/vl1BVDsNL34/WKGM0IsHmKJbB5+EmXf1gukYSN
         rKUWqYFRXFn3EcSTYmN35jH1+FNvzCaNASEXISAm7y5gcrPsR4FN+MUaDXlaQQepYl
         Rfcw9mMqwmO1Zt+iY8gbZ/TZ8/4Gj3LouVkXfRZhoIAPvB67/XWa9nz5gbVJOonkKk
         Py3k5b8Etnj17TKlCc41WO9OiTwlLrX54QS22uqGllHrOIq4XMrlTYukRKPZVxYGIw
         buN0pGmO9qM+zhhc6Nk/UdeQozOoCiKP/7exlBTfJyKMYA+CCIFitDbA7Il54kyyBc
         5oJ0Qf9dsFDKg==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
Date:   Thu,  9 Jun 2022 23:46:01 +0000
Message-Id: <20220609234601.2026362-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF LSM currently has a default implementation for each LSM hooks which
return a default value defined in include/linux/lsm_hook_defs.h. These
hooks should have no functional effect when there is no BPF program
loaded to implement the hook logic.

Some LSM hooks treat any return value of the hook as policy decision
which results in destructive side effects.

This issue and the effects were reported to me by Jann Horn:

For a system configured with CONFIG_BPF_LSM and the bpf lsm is enabled
(via lsm= or CONFIG_LSM) an unprivileged user can vandalize the system
by removing the security.capability xattrs from binaries, preventing
them from working normally:

$ getfattr -d -m- /bin/ping
getfattr: Removing leading '/' from absolute path names
security.capability=0sAQAAAgAgAAAAAAAAAAAAAAAAAAA=

$ setfattr -x security.capability /bin/ping
$ getfattr -d -m- /bin/ping
$ ping 1.2.3.4
$ ping google.com
$ echo $?
2

The above reproduces with:

cat /sys/kernel/security/lsm
capability,apparmor,bpf

But not with SELinux as SELinux does the required check in its LSM hook:

cat /sys/kernel/security/lsm
capability,selinux,bpf

In this case security_inode_removexattr() calls
call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name), which
expects a return value of 1 to mean "no LSM hooks hit" and 0 is
supposed to mean "the LSM decided to permit the access and checked
cap_inode_removexattr"

There are other security hooks that are similarly effected.

In order to reliably fix this issue and also allow LSM Hooks and BPF
programs which implement hook logic to choose to not make a decision
in certain conditions (e.g. when BPF programs are used for auditing),
introduce a special return value LSM_HOOK_NO_EFFECT which can be used
by the hook to indicate to the framework that it does not intend to
make a decision.

Fixes: 520b7aa00d8c ("bpf: lsm: Initialize the BPF LSM hooks")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hooks.h |  6 +++
 kernel/bpf/bpf_lsm.c      | 14 +++++--
 security/security.c       | 78 +++++++++++++++++++++++++++++----------
 3 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 91c8146649f5..fcf3c2c57127 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1576,6 +1576,12 @@
  *      thread (IORING_SETUP_SQPOLL).
  *
  */
+
+/*
+ * If an LSM hook choses to make no decision. i.e. it's only for auditing or
+ * a default hook like the BPF LSM hooks, it can return LSM_HOOK_NO_EFFECT.
+ */
+ #define LSM_HOOK_NO_EFFECT -INT_MAX
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c1351df9f7ee..52f2fc493c57 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -20,12 +20,18 @@
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
  */
-#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
-noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
-{						\
-	return DEFAULT;				\
+#define DEFINE_LSM_HOOK_void(NAME, ...) \
+noinline void bpf_lsm_##NAME(__VA_ARGS__) {}
+
+#define DEFINE_LSM_HOOK_int(NAME, ...)	   \
+noinline int bpf_lsm_##NAME(__VA_ARGS__)   \
+{					   \
+	return LSM_HOOK_NO_EFFECT;	   \
 }
 
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	DEFINE_LSM_HOOK_##RET(NAME, __VA_ARGS__)
+
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
diff --git a/security/security.c b/security/security.c
index 188b8f782220..3c1b0b00c4a7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -734,11 +734,16 @@ static int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
+	int THISRC;						\
+								\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
+			THISRC = P->hook.FUNC(__VA_ARGS__);	\
+			if (THISRC == LSM_HOOK_NO_EFFECT)	\
+				continue;			\
+			RC = THISRC;				\
 			if (RC != 0)				\
 				break;				\
 		}						\
@@ -831,7 +836,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
-	int rc;
+	int rc, thisrc;
 
 	/*
 	 * The module will respond with a positive value if
@@ -841,7 +846,11 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * thinks it should not be set it won't.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
-		rc = hp->hook.vm_enough_memory(mm, pages);
+		thisrc = hp->hook.vm_enough_memory(mm, pages);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
+
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
@@ -895,6 +904,8 @@ int security_fs_context_parse_param(struct fs_context *fc,
 	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
 			     list) {
 		trc = hp->hook.fs_context_parse_param(fc, param);
+		if (trc == LSM_HOOK_NO_EFFECT)
+			continue;
 		if (trc == 0)
 			rc = 0;
 		else if (trc != -ENOPARAM)
@@ -1063,14 +1074,17 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 				  u32 *ctxlen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc, thisrc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
-		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
+		thisrc = hp->hook.dentry_init_security(dentry, mode, name,
+						       xattr_name, ctx, ctxlen);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
@@ -1430,7 +1444,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc, thisrc;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return LSM_RET_DEFAULT(inode_getsecurity);
@@ -1438,7 +1452,10 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+		thisrc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
@@ -1448,7 +1465,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc, thisrc;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return LSM_RET_DEFAULT(inode_setsecurity);
@@ -1456,8 +1473,11 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
-		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+		thisrc = hp->hook.inode_setsecurity(inode, name, value, size,
+						    flags);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
 		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
 			return rc;
 	}
@@ -1486,7 +1506,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
 int security_inode_copy_up_xattr(const char *name)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc, thisrc;
 
 	/*
 	 * The implementation can return 0 (accept the xattr), 1 (discard the
@@ -1495,7 +1515,10 @@ int security_inode_copy_up_xattr(const char *name)
 	 */
 	hlist_for_each_entry(hp,
 		&security_hook_heads.inode_copy_up_xattr, list) {
-		rc = hp->hook.inode_copy_up_xattr(name);
+		thisrc = hp->hook.inode_copy_up_xattr(name);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
 	}
@@ -1889,6 +1912,8 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
 			rc = thisrc;
 			if (thisrc != 0)
@@ -2055,11 +2080,16 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int rc;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
-		return hp->hook.getprocattr(p, name, value);
+		rc = hp->hook.getprocattr(p, name, value);
+		if (rc == LSM_HOOK_NO_EFFECT)
+			continue;
+		else
+			return rc;
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
@@ -2068,11 +2098,16 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	int rc;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
-		return hp->hook.setprocattr(name, value, size);
+		rc = hp->hook.setprocattr(name, value, size);
+		if (rc == LSM_HOOK_NO_EFFECT)
+			continue;
+		else
+			return rc;
 	}
 	return LSM_RET_DEFAULT(setprocattr);
 }
@@ -2091,14 +2126,17 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc, thisrc;
 
 	/*
 	 * Currently, only one LSM can implement secid_to_secctx (i.e this
 	 * LSM hook is not "stackable").
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+		thisrc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+		if (thisrc == LSM_HOOK_NO_EFFECT)
+			continue;
+		rc = thisrc;
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
 	}
@@ -2509,9 +2547,11 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
-		break;
+		if (rc == LSM_HOOK_NO_EFFECT)
+			continue;
+		return rc;
 	}
-	return rc;
+	return LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
 }
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
-- 
2.36.1.476.g0c4daa206d-goog

