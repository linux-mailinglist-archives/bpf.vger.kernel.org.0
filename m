Return-Path: <bpf+bounces-17314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5980B342
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC0128111F
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276679C1;
	Sat,  9 Dec 2023 08:28:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009610C9
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 00:28:13 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3B98SBW9009671;
	Sat, 9 Dec 2023 17:28:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 09 Dec 2023 17:28:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3B98S66N009631
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 9 Dec 2023 17:28:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <09e4992c-9def-41b5-a806-2978b3ae35c6@I-love.SAKURA.ne.jp>
Date: Sat, 9 Dec 2023 17:28:04 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: song@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH v3] LSM: Officially support appending LSM hooks after
 boot.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 20510f2f4e2d ("security: Convert LSM into a static interface") has
unexported register_security()/unregister_security(), with the reasoning
that the ability to unload an LSM module is not required by in-tree users
and potentially complicates the overall security architecture.

After that commit, many LSM modules have been proposed and some of them
have succeeded in becoming in-tree users. Also, Linux distributors started
enabling some of in-tree LSM modules in their distribution kernels.

But due to that commit, currently in order to officially use an LSM
module, that LSM module has to be built into vmlinux. And this limitation
has been a big barrier for allowing distribution kernel users to use LSM
modules which the organization who builds that distribution kernel cannot
afford supporting.

Therefore, as one of in-tree users, I've been asking for ability to append
LSM hooks from LKM-based LSMs (i.e. re-export register_security()) so that
distribution kernel users can use LSMs which the organization who builds
that distribution kernel cannot afford supporting.

Paul Moore believes that we don't need to support appending LSM hooks from
LKM-based LSMs because anyone who wants to use an LSM module can recompile
distributor kernels with that LSM enabled. But recompiling kernels is not
a viable option for regular developers/users [1]; the burden of
distributing rebuilt kernels is not acceptable for individual LSM authors
and majority of Linux users, and the risk of replacing known distributor's
prebuilt kernels with unknown individual's rebuilt kernels is not
acceptable for majority of distributor kernel users. If Endpoint Detection
and Response software (including Antivirus software) could not be used
without replacing distributor's prebuilt kernels, Linux would not have been
chosen as a platform. Being able to use whatever functionality using
prebuilt distribution kernel packages and prebuilt kernel-debuginfo
packages is the mandatory baseline. Therefore, in order to unofficially use
LSMs which are not built into vmlinux, I've been maintaining AKARI (which
is a pure LKM version of TOMOYO) as an LKM-based LSM which can run on
kernels between 2.6.0 and 6.6.

I was planning to propose ability to append LSM hooks from LKM-based LSMs
(i.e. re-export register_security()) so that distribution kernel users can
use LSMs which the organization who builds that distribution kernel cannot
afford supporting, after Casey Schaufler finishes his work for making it
possible to enable arbitrary LSM combinations. But before Casey's work
finishes, KP Singh started proposing "Reduce overhead of LSMs with static
calls" which will make AKARI more difficult to run because it removes
security_hook_heads. Therefore, reviving ability to officially append LSM
hooks from LKM-based LSMs became an urgent matter.

KP Singh suggested me to try eBPF programs because BPF LSM is enabled in
distributor's prebuilt kernels. But the result was that eBPF is too
restricted to emulate TOMOYO. Therefore, I still need ability to append
LSM hooks from LKM-based LSMs.

Since it seems that nobody has objection on not using an LSM module which
calls LSM hooks in the LKM-based LSMs [2], this version directly appended
the linked list into individual callbacks. KP Singh's "Reduce overhead of
LSMs with static calls" proposal will replace security_hook_heads with
array of static call slots, and mod_security_hook_heads will remain
untouched.

This patch implements only ability to add LSM modules after boot, for
as far as we know, we haven't heard of requests for reviving the ability
to remove LSM modules after boot.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://lkml.kernel.org/r/d759146e-5d74-4782-931b-adda33b125d4@I-love.SAKURA.ne.jp [1]
Link: https://lkml.kernel.org/r/93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp [2]
---
 include/linux/lsm_hooks.h |   9 +++
 security/security.c       | 134 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index dcb5e5b5eb13..de83740f81a5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -97,6 +97,7 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
  * care of the common case and reduces the amount of
  * text involved.
  */
+#ifndef MODULE
 #define LSM_HOOK_INIT(HEAD, HOOK) \
 	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
 
@@ -105,6 +106,14 @@ extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				const char *lsm);
+#else
+#define LSM_HOOK_INIT(HEAD, HOOK) \
+	{ .head = &mod_security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+
+extern struct security_hook_heads mod_security_hook_heads;
+extern int mod_security_add_hooks(struct security_hook_list *hooks, int count, const char *lsm);
+#endif
+
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..bd033cd5e89a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -74,6 +74,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 };
 
 struct security_hook_heads security_hook_heads __ro_after_init;
+static DEFINE_STATIC_KEY_FALSE_RO(mod_security_enabled);
+struct security_hook_heads mod_security_hook_heads;
+EXPORT_SYMBOL_GPL(mod_security_hook_heads);
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
@@ -407,6 +410,10 @@ int __init early_security_init(void)
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	INIT_HLIST_HEAD(&security_hook_heads.NAME);
 #include "linux/lsm_hook_defs.h"
+#undef LSM_HOOK
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	INIT_HLIST_HEAD(&mod_security_hook_heads.NAME);
+#include "linux/lsm_hook_defs.h"
 #undef LSM_HOOK
 
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
@@ -465,6 +472,13 @@ static int __init choose_lsm_order(char *str)
 }
 __setup("lsm=", choose_lsm_order);
 
+static int __init enable_mod_security(char *str)
+{
+	static_branch_enable(&mod_security_enabled);
+	return 1;
+}
+__setup("lsm.modular", enable_mod_security);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
@@ -537,6 +551,23 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+int mod_security_add_hooks(struct security_hook_list *hooks, int count, const char *lsm)
+{
+	int i;
+
+	if (!static_branch_unlikely(&mod_security_enabled)) {
+		pr_info("Modular LSM support is not enabled.\n");
+		return -EINVAL;
+	}
+	pr_info("Registering modular LSM: %s\n", lsm);
+	for (i = 0; i < count; i++) {
+		hooks[i].lsm = lsm;
+		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mod_security_add_hooks);
+
 int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
 	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
@@ -769,6 +800,10 @@ static int lsm_superblock_alloc(struct super_block *sb)
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		if (static_branch_unlikely(&mod_security_enabled)) {			\
+			hlist_for_each_entry(P, &mod_security_hook_heads.FUNC, list) \
+				P->hook.FUNC(__VA_ARGS__);	\
+		}						\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
@@ -781,6 +816,13 @@ static int lsm_superblock_alloc(struct super_block *sb)
 			if (RC != 0)				\
 				break;				\
 		}						\
+		if (static_branch_unlikely(&mod_security_enabled)) {			\
+			hlist_for_each_entry(P, &mod_security_hook_heads.FUNC, list) { \
+				RC = P->hook.FUNC(__VA_ARGS__);	\
+				if (RC != 0)			\
+					break;			\
+			}					\
+		}						\
 	} while (0);						\
 	RC;							\
 })
@@ -1038,6 +1080,15 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+	if (static_branch_unlikely(&mod_security_enabled) && cap_sys_admin) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.vm_enough_memory, list) {
+			rc = hp->hook.vm_enough_memory(mm, pages);
+			if (rc <= 0) {
+				cap_sys_admin = 0;
+				break;
+			}
+		}
+	}
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -1196,6 +1247,15 @@ int security_fs_context_parse_param(struct fs_context *fc,
 		else if (trc != -ENOPARAM)
 			return trc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.fs_context_parse_param, list) {
+			trc = hp->hook.fs_context_parse_param(fc, param);
+			if (trc == 0)
+				rc = 0;
+			else if (trc != -ENOPARAM)
+				return trc;
+		}
+	}
 	return rc;
 }
 
@@ -1566,6 +1626,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.dentry_init_security, list) {
+			rc = hp->hook.dentry_init_security(dentry, mode, name,
+							   xattr_name, ctx, ctxlen);
+			if (rc != LSM_RET_DEFAULT(dentry_init_security))
+				return rc;
+		}
+	}
 	return LSM_RET_DEFAULT(dentry_init_security);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
@@ -1656,6 +1724,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		 * the remaining LSMs.
 		 */
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.inode_init_security, list) {
+			ret = hp->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+							   &xattr_count);
+			if (ret && ret != -EOPNOTSUPP)
+				goto out;
+		}
+	}
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
 	if (!xattr_count)
@@ -2419,6 +2495,13 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.inode_getsecurity, list) {
+			rc = hp->hook.inode_getsecurity(idmap, inode, name, buffer, alloc);
+			if (rc != LSM_RET_DEFAULT(inode_getsecurity))
+				return rc;
+		}
+	}
 	return LSM_RET_DEFAULT(inode_getsecurity);
 }
 
@@ -2454,6 +2537,13 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
 			return rc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.inode_setsecurity, list) {
+			rc = hp->hook.inode_setsecurity(inode, name, value, size, flags);
+			if (rc != LSM_RET_DEFAULT(inode_setsecurity))
+				return rc;
+		}
+	}
 	return LSM_RET_DEFAULT(inode_setsecurity);
 }
 
@@ -2538,6 +2628,13 @@ int security_inode_copy_up_xattr(const char *name)
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.inode_copy_up_xattr, list) {
+			rc = hp->hook.inode_copy_up_xattr(name);
+			if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
+				return rc;
+		}
+	}
 
 	return LSM_RET_DEFAULT(inode_copy_up_xattr);
 }
@@ -3424,6 +3521,16 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 				break;
 		}
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.task_prctl, list) {
+			thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+			if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
+				rc = thisrc;
+				if (thisrc != 0)
+					break;
+			}
+		}
+	}
 	return rc;
 }
 
@@ -3821,6 +3928,13 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.getprocattr, list) {
+			if (lsm != NULL && strcmp(lsm, hp->lsm))
+				continue;
+			return hp->hook.getprocattr(p, name, value);
+		}
+	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
@@ -3846,6 +3960,13 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.setprocattr, list) {
+			if (lsm != NULL && strcmp(lsm, hp->lsm))
+				continue;
+			return hp->hook.setprocattr(name, value, size);
+		}
+	}
 	return LSM_RET_DEFAULT(setprocattr);
 }
 
@@ -3908,6 +4029,13 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.secid_to_secctx, list) {
+			rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+			if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+				return rc;
+		}
+	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
 }
@@ -4964,6 +5092,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
 		break;
 	}
+	if (static_branch_unlikely(&mod_security_enabled)) {
+		hlist_for_each_entry(hp, &mod_security_hook_heads.xfrm_state_pol_flow_match, list) {
+			rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
+			break;
+		}
+	}
 	return rc;
 }
 
-- 
2.34.1

