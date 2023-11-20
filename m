Return-Path: <bpf+bounces-15358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339D7F1471
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEB7B218C6
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A11803B;
	Mon, 20 Nov 2023 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DE114
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:30:36 -0800 (PST)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3AKDUZJ5046314;
	Mon, 20 Nov 2023 22:30:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 20 Nov 2023 22:30:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3AKDRaAN045731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Nov 2023 22:30:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <34be5cd8-1fdd-4323-82a3-40f2e7d35db3@I-love.SAKURA.ne.jp>
Date: Mon, 20 Nov 2023 22:30:30 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] LSM: Add a LSM module which handles dynamically
 appendable LSM hooks.
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-security-module <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, renauld@google.com,
        Paolo Abeni <pabeni@redhat.com>
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
In-Reply-To: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

TOMOYO security module will use this functionality.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/lsm_hooks.h |   9 +
 security/Makefile         |   2 +-
 security/mod_lsm.c        | 321 ++++++++++++++++
 security/security.c       | 752 ++------------------------------------
 4 files changed, 359 insertions(+), 725 deletions(-)
 create mode 100644 security/mod_lsm.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4ba1aedc7901..2166ff6541aa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -137,4 +137,13 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+/* Definition of all modular callbacks. */
+struct security_hook_mappings {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
+	RET (*NAME)(__VA_ARGS__);
+#include <linux/lsm_hook_defs.h>
+} /* __randomize_layout is useless here, for this is a "const __initdata" struct. */;
+
+extern int mod_lsm_add_hooks(const struct security_hook_mappings *maps);
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Makefile b/security/Makefile
index 18121f8f85cd..a611350e9da4 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -10,7 +10,7 @@ obj-y					+= commoncap.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o mod_lsm.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/mod_lsm.c b/security/mod_lsm.c
new file mode 100644
index 000000000000..074a73326fc7
--- /dev/null
+++ b/security/mod_lsm.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/lsm_hooks.h>
+
+extern int mod_lsm_add_hooks(const struct security_hook_mappings *maps);
+
+/* List of registered modular callbacks. */
+static struct {
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
+#include <linux/lsm_hook_defs.h>
+} mod_lsm_dynamic_hooks;
+
+#define LSM_RET_DEFAULT(NAME) (NAME##_default)
+#define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
+#define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
+	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
+
+#define call_void_hook(FUNC, ...)				\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &mod_lsm_dynamic_hooks.FUNC, list) \
+			P->hook.FUNC(__VA_ARGS__);		\
+	} while (0)
+
+#define call_int_hook(FUNC, IRC, ...) ({			\
+	int RC = IRC;						\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &mod_lsm_dynamic_hooks.FUNC, list) { \
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			if (RC != 0)				\
+				break;				\
+		}						\
+	} while (0);						\
+	RC;							\
+})
+
+#include <linux/lsm_hook_args.h>
+#define LSM_PLAIN_INT_HOOK(RET, DEFAULT, NAME, ...)			\
+	static int mod_lsm_##NAME(__VA_ARGS__)				\
+	{								\
+		struct security_hook_list *P;				\
+									\
+		hlist_for_each_entry(P, &mod_lsm_dynamic_hooks.NAME, list) { \
+			int RC = P->hook.NAME(LSM_CALL_ARGS_##NAME);	\
+									\
+			if (RC != DEFAULT)				\
+				return RC;				\
+		}							\
+		return DEFAULT;						\
+	}
+#define LSM_CUSTOM_INT_HOOK LSM_PLAIN_INT_HOOK
+#define LSM_SPECIAL_INT_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME)
+#define LSM_PLAIN_VOID_HOOK(RET, DEFAULT, NAME, ...)			\
+	static void mod_lsm_##NAME(__VA_ARGS__)				\
+	{								\
+		struct security_hook_list *P;				\
+									\
+		hlist_for_each_entry(P, &mod_lsm_dynamic_hooks.NAME, list) \
+			P->hook.NAME(LSM_CALL_ARGS_##NAME);		\
+	}
+#define LSM_CUSTOM_VOID_HOOK(RET, DEFAULT, NAME, ...)
+#define LSM_SPECIAL_VOID_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
+#include <linux/lsm_hook_defs.h>
+
+static int mod_lsm_settime(const struct timespec64 *ts, const struct timezone *tz)
+{
+	return call_int_hook(settime, 0, ts, tz);
+}
+
+static int mod_lsm_vm_enough_memory(struct mm_struct *mm, long pages)
+{
+	struct security_hook_list *hp;
+	int cap_sys_admin = 1;
+	int rc;
+
+	hlist_for_each_entry(hp, &mod_lsm_dynamic_hooks.vm_enough_memory, list) {
+		rc = hp->hook.vm_enough_memory(mm, pages);
+		if (rc <= 0) {
+			cap_sys_admin = 0;
+			break;
+		}
+	}
+	return cap_sys_admin;
+}
+
+static int mod_lsm_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct security_hook_list *hp;
+	int trc;
+	int rc = -ENOPARAM;
+
+	hlist_for_each_entry(hp, &mod_lsm_dynamic_hooks.fs_context_parse_param, list) {
+		trc = hp->hook.fs_context_parse_param(fc, param);
+		if (trc == 0)
+			rc = 0;
+		else if (trc != -ENOPARAM)
+			return trc;
+	}
+	return rc;
+}
+
+static int mod_lsm_inode_init_security(struct inode *inode, struct inode *dir,
+				       const struct qstr *qstr, struct xattr *xattrs,
+				       int *xattr_count)
+{
+	struct security_hook_list *hp;
+	int ret = -EOPNOTSUPP;
+
+	hlist_for_each_entry(hp, &mod_lsm_dynamic_hooks.inode_init_security, list) {
+		ret = hp->hook.inode_init_security(inode, dir, qstr, xattrs, xattr_count);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+	}
+	return ret;
+}
+
+static void mod_lsm_inode_post_setxattr(struct dentry *dentry, const char *name, const void *value,
+					size_t size, int flags)
+{
+	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
+}
+
+static void mod_lsm_task_free(struct task_struct *task)
+{
+	call_void_hook(task_free, task);
+}
+
+static void mod_lsm_cred_free(struct cred *cred)
+{
+	call_void_hook(cred_free, cred);
+}
+
+static void mod_lsm_cred_transfer(struct cred *new, const struct cred *old)
+{
+	call_void_hook(cred_transfer, new, old);
+}
+
+static void mod_lsm_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	call_void_hook(cred_getsecid, c, secid);
+}
+
+static void mod_lsm_current_getsecid_subj(u32 *secid)
+{
+	call_void_hook(current_getsecid_subj, secid);
+}
+
+static void mod_lsm_task_getsecid_obj(struct task_struct *p, u32 *secid)
+{
+	call_void_hook(task_getsecid_obj, p, secid);
+}
+
+static int mod_lsm_task_prctl(int option, unsigned long arg2, unsigned long arg3,
+			      unsigned long arg4, unsigned long arg5)
+{
+	int thisrc;
+	int rc = LSM_RET_DEFAULT(task_prctl);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &mod_lsm_dynamic_hooks.task_prctl, list) {
+		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
+			rc = thisrc;
+			if (thisrc != 0)
+				break;
+		}
+	}
+	return rc;
+}
+
+static int mod_lsm_userns_create(const struct cred *cred)
+{
+	return call_int_hook(userns_create, 0, cred);
+}
+
+static void mod_lsm_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+{
+	call_void_hook(ipc_getsecid, ipcp, secid);
+}
+
+
+static void mod_lsm_d_instantiate(struct dentry *dentry, struct inode *inode)
+{
+	call_void_hook(d_instantiate, dentry, inode);
+}
+
+static int mod_lsm_getprocattr(struct task_struct *p, const char *name, char **value)
+{
+	/* Can't work because "lsm" argument is not available. */
+	return LSM_RET_DEFAULT(getprocattr);
+}
+
+static int mod_lsm_setprocattr(const char *name, void *value, size_t size)
+{
+	/* Can't work because "lsm" argument is not available. */
+	return LSM_RET_DEFAULT(setprocattr);
+}
+
+static void mod_lsm_release_secctx(char *secdata, u32 seclen)
+{
+	call_void_hook(release_secctx, secdata, seclen);
+}
+
+static void mod_lsm_inode_invalidate_secctx(struct inode *inode)
+{
+	call_void_hook(inode_invalidate_secctx, inode);
+}
+
+static int mod_lsm_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
+{
+	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+}
+
+#ifdef CONFIG_SECURITY_NETWORK
+static int mod_lsm_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	return call_int_hook(socket_sock_rcv_skb, 0, sk, skb);
+}
+
+static int mod_lsm_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
+					    sockptr_t optlen, unsigned int len)
+{
+	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock, optval, optlen, len);
+}
+
+static int mod_lsm_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+{
+	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb, secid);
+}
+
+static int mod_lsm_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
+{
+	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+}
+
+static void mod_lsm_sk_free_security(struct sock *sk)
+{
+	call_void_hook(sk_free_security, sk);
+}
+
+static void mod_lsm_sk_clone_security(const struct sock *sk, struct sock *newsk)
+{
+	call_void_hook(sk_clone_security, sk, newsk);
+}
+#endif
+
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+static int mod_lsm_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *xp,
+					     const struct flowi_common *flic)
+{
+	struct security_hook_list *hp;
+	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
+
+	hlist_for_each_entry(hp, &mod_lsm_dynamic_hooks.xfrm_state_pol_flow_match, list) {
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
+		break;
+	}
+	return rc;
+}
+#endif
+
+/* Initialize all built-in callbacks here. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) LSM_HOOK_INIT(NAME, mod_lsm_##NAME),
+static struct security_hook_list mod_lsm_builtin_hooks[] __ro_after_init = {
+#include <linux/lsm_hook_defs.h>
+};
+
+static int mod_lsm_enabled __ro_after_init = 1;
+static struct lsm_blob_sizes mod_lsm_blob_sizes __ro_after_init = { };
+
+static int __init mod_lsm_init(void)
+{
+	/* Initialize modular callbacks list. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) INIT_HLIST_HEAD(&mod_lsm_dynamic_hooks.NAME);
+#include <linux/lsm_hook_defs.h>
+	/* Register built-in callbacks. */
+	security_add_hooks(mod_lsm_builtin_hooks, ARRAY_SIZE(mod_lsm_builtin_hooks), "mod_lsm");
+	return 0;
+}
+
+DEFINE_LSM(mod_lsm) = {
+	.name = "mod_lsm",
+	.enabled = &mod_lsm_enabled,
+	.flags = 0,
+	.blobs = &mod_lsm_blob_sizes,
+	.init = mod_lsm_init,
+};
+
+/* The only exported function for registering modular callbacks. */
+int mod_lsm_add_hooks(const struct security_hook_mappings *maps)
+{
+	struct security_hook_list *entry;
+	int count = 0;
+
+	if (!mod_lsm_enabled) {
+		pr_info_once("Loadable LSM support is not enabled.\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Count how meny callbacks are implemented. */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) do { if (maps->NAME) count++; } while (0);
+#include <linux/lsm_hook_defs.h>
+	if (!count)
+		return -EINVAL;
+	/* Allocate memory for registering implemented callbacks. */
+	entry = kmalloc_array(count, sizeof(struct security_hook_list), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	/* Registering imdividual callbacks. */
+	count = 0;
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) do { if (maps->NAME) {	\
+			entry[count].hook.NAME = maps->NAME;		\
+			hlist_add_tail_rcu(&entry[count].list, &mod_lsm_dynamic_hooks.NAME); \
+			count++;					\
+		} } while (0);
+#include <linux/lsm_hook_defs.h>
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mod_lsm_add_hooks);
diff --git a/security/security.c b/security/security.c
index d35d50b218c6..b455bfa62afc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -746,9 +746,6 @@ static int lsm_superblock_alloc(struct super_block *sb)
 #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
 #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
 	static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
-#include <linux/lsm_hook_defs.h>
 
 /*
  * Hook list operation macros.
@@ -782,6 +779,34 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+#include <linux/lsm_hook_args.h>
+#define LSM_PLAIN_INT_HOOK(RET, DEFAULT, NAME, ...)			\
+	int security_##NAME(__VA_ARGS__)				\
+	{								\
+		struct security_hook_list *P;				\
+									\
+		hlist_for_each_entry(P, &security_hook_heads.NAME, list) { \
+			int RC = P->hook.NAME(LSM_CALL_ARGS_##NAME);	\
+									\
+			if (RC != DEFAULT)				\
+				return RC;				\
+		}							\
+		return DEFAULT;						\
+	}
+#define LSM_CUSTOM_INT_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME)
+#define LSM_SPECIAL_INT_HOOK(RET, DEFAULT, NAME, ...) DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME)
+#define LSM_PLAIN_VOID_HOOK(RET, DEFAULT, NAME, ...)			\
+	void security_##NAME(__VA_ARGS__)				\
+	{								\
+		struct security_hook_list *P;				\
+									\
+		hlist_for_each_entry(P, &security_hook_heads.NAME, list) \
+			P->hook.NAME(LSM_CALL_ARGS_##NAME);		\
+	}
+#define LSM_CUSTOM_VOID_HOOK(RET, DEFAULT, NAME, ...)
+#define LSM_SPECIAL_VOID_HOOK(RET, DEFAULT, NAME, ...)
+#include <linux/lsm_hook_defs.h>
+
 /* Security operations */
 
 /**
@@ -792,10 +817,6 @@ static int lsm_superblock_alloc(struct super_block *sb)
  *
  * Return: Return 0 if permission is granted.
  */
-int security_binder_set_context_mgr(const struct cred *mgr)
-{
-	return call_int_hook(binder_set_context_mgr, 0, mgr);
-}
 
 /**
  * security_binder_transaction() - Check if a binder transaction is allowed
@@ -806,11 +827,6 @@ int security_binder_set_context_mgr(const struct cred *mgr)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_binder_transaction(const struct cred *from,
-				const struct cred *to)
-{
-	return call_int_hook(binder_transaction, 0, from, to);
-}
 
 /**
  * security_binder_transfer_binder() - Check if a binder transfer is allowed
@@ -821,11 +837,6 @@ int security_binder_transaction(const struct cred *from,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_binder_transfer_binder(const struct cred *from,
-				    const struct cred *to)
-{
-	return call_int_hook(binder_transfer_binder, 0, from, to);
-}
 
 /**
  * security_binder_transfer_file() - Check if a binder file xfer is allowed
@@ -837,11 +848,6 @@ int security_binder_transfer_binder(const struct cred *from,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_binder_transfer_file(const struct cred *from,
-				  const struct cred *to, const struct file *file)
-{
-	return call_int_hook(binder_transfer_file, 0, from, to, file);
-}
 
 /**
  * security_ptrace_access_check() - Check if tracing is allowed
@@ -857,10 +863,6 @@ int security_binder_transfer_file(const struct cred *from,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
-{
-	return call_int_hook(ptrace_access_check, 0, child, mode);
-}
 
 /**
  * security_ptrace_traceme() - Check if tracing is allowed
@@ -872,10 +874,6 @@ int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ptrace_traceme(struct task_struct *parent)
-{
-	return call_int_hook(ptrace_traceme, 0, parent);
-}
 
 /**
  * security_capget() - Get the capability sets for a process
@@ -891,14 +889,6 @@ int security_ptrace_traceme(struct task_struct *parent)
  *
  * Return: Returns 0 if the capability sets were successfully obtained.
  */
-int security_capget(const struct task_struct *target,
-		    kernel_cap_t *effective,
-		    kernel_cap_t *inheritable,
-		    kernel_cap_t *permitted)
-{
-	return call_int_hook(capget, 0, target,
-			     effective, inheritable, permitted);
-}
 
 /**
  * security_capset() - Set the capability sets for a process
@@ -913,14 +903,6 @@ int security_capget(const struct task_struct *target,
  *
  * Return: Returns 0 and update @new if permission is granted.
  */
-int security_capset(struct cred *new, const struct cred *old,
-		    const kernel_cap_t *effective,
-		    const kernel_cap_t *inheritable,
-		    const kernel_cap_t *permitted)
-{
-	return call_int_hook(capset, 0, new, old,
-			     effective, inheritable, permitted);
-}
 
 /**
  * security_capable() - Check if a process has the necessary capability
@@ -935,13 +917,6 @@ int security_capset(struct cred *new, const struct cred *old,
  *
  * Return: Returns 0 if the capability is granted.
  */
-int security_capable(const struct cred *cred,
-		     struct user_namespace *ns,
-		     int cap,
-		     unsigned int opts)
-{
-	return call_int_hook(capable, 0, cred, ns, cap, opts);
-}
 
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
@@ -954,10 +929,6 @@ int security_capable(const struct cred *cred,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_quotactl(int cmds, int type, int id, const struct super_block *sb)
-{
-	return call_int_hook(quotactl, 0, cmds, type, id, sb);
-}
 
 /**
  * security_quota_on() - Check if QUOTAON is allowed for a dentry
@@ -967,10 +938,6 @@ int security_quotactl(int cmds, int type, int id, const struct super_block *sb)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_quota_on(struct dentry *dentry)
-{
-	return call_int_hook(quota_on, 0, dentry);
-}
 
 /**
  * security_syslog() - Check if accessing the kernel message ring is allowed
@@ -982,10 +949,6 @@ int security_quota_on(struct dentry *dentry)
  *
  * Return: Return 0 if permission is granted.
  */
-int security_syslog(int type)
-{
-	return call_int_hook(syslog, 0, type);
-}
 
 /**
  * security_settime64() - Check if changing the system time is allowed
@@ -1052,10 +1015,6 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
  *
  * Return: Returns 0 if the hook is successful and permission is granted.
  */
-int security_bprm_creds_for_exec(struct linux_binprm *bprm)
-{
-	return call_int_hook(bprm_creds_for_exec, 0, bprm);
-}
 
 /**
  * security_bprm_creds_from_file() - Update linux_binprm creds based on file
@@ -1076,10 +1035,6 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
  *
  * Return: Returns 0 if the hook is successful and permission is granted.
  */
-int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
-{
-	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
-}
 
 /**
  * security_bprm_check() - Mediate binary handler search
@@ -1115,10 +1070,6 @@ int security_bprm_check(struct linux_binprm *bprm)
  * open file descriptors to which access will no longer be granted when the
  * attributes are changed.  This is called immediately before commit_creds().
  */
-void security_bprm_committing_creds(const struct linux_binprm *bprm)
-{
-	call_void_hook(bprm_committing_creds, bprm);
-}
 
 /**
  * security_bprm_committed_creds() - Tidy up after cred install during exec()
@@ -1131,10 +1082,6 @@ void security_bprm_committing_creds(const struct linux_binprm *bprm)
  * process such as clearing out non-inheritable signal state.  This is called
  * immediately after commit_creds().
  */
-void security_bprm_committed_creds(const struct linux_binprm *bprm)
-{
-	call_void_hook(bprm_committed_creds, bprm);
-}
 
 /**
  * security_fs_context_submount() - Initialise fc->security
@@ -1145,10 +1092,6 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
  *
  * Return: Returns 0 on success or negative error code on failure.
  */
-int security_fs_context_submount(struct fs_context *fc, struct super_block *reference)
-{
-	return call_int_hook(fs_context_submount, 0, fc, reference);
-}
 
 /**
  * security_fs_context_dup() - Duplicate a fs_context LSM blob
@@ -1161,10 +1104,6 @@ int security_fs_context_submount(struct fs_context *fc, struct super_block *refe
  *
  * Return: Returns 0 on success or a negative error code on failure.
  */
-int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
-{
-	return call_int_hook(fs_context_dup, 0, fc, src_fc);
-}
 
 /**
  * security_fs_context_parse_param() - Configure a filesystem context
@@ -1225,10 +1164,6 @@ int security_sb_alloc(struct super_block *sb)
  * Release objects tied to a superblock (e.g. inodes).  @sb contains the
  * super_block structure being released.
  */
-void security_sb_delete(struct super_block *sb)
-{
-	call_void_hook(sb_delete, sb);
-}
 
 /**
  * security_sb_free() - Free a super_block LSM blob
@@ -1268,10 +1203,6 @@ EXPORT_SYMBOL(security_free_mnt_opts);
  *
  * Return: Returns 0 on success, negative values on failure.
  */
-int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
-{
-	return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
-}
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
 /**
@@ -1284,11 +1215,6 @@ EXPORT_SYMBOL(security_sb_eat_lsm_opts);
  *
  * Return: Returns 0 if options are compatible.
  */
-int security_sb_mnt_opts_compat(struct super_block *sb,
-				void *mnt_opts)
-{
-	return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
-}
 EXPORT_SYMBOL(security_sb_mnt_opts_compat);
 
 /**
@@ -1301,11 +1227,6 @@ EXPORT_SYMBOL(security_sb_mnt_opts_compat);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_remount(struct super_block *sb,
-			void *mnt_opts)
-{
-	return call_int_hook(sb_remount, 0, sb, mnt_opts);
-}
 EXPORT_SYMBOL(security_sb_remount);
 
 /**
@@ -1316,10 +1237,6 @@ EXPORT_SYMBOL(security_sb_remount);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_kern_mount(const struct super_block *sb)
-{
-	return call_int_hook(sb_kern_mount, 0, sb);
-}
 
 /**
  * security_sb_show_options() - Output the mount options for a superblock
@@ -1330,10 +1247,6 @@ int security_sb_kern_mount(const struct super_block *sb)
  *
  * Return: Returns 0 on success, negative values on failure.
  */
-int security_sb_show_options(struct seq_file *m, struct super_block *sb)
-{
-	return call_int_hook(sb_show_options, 0, m, sb);
-}
 
 /**
  * security_sb_statfs() - Check if accessing fs stats is allowed
@@ -1344,10 +1257,6 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_statfs(struct dentry *dentry)
-{
-	return call_int_hook(sb_statfs, 0, dentry);
-}
 
 /**
  * security_sb_mount() - Check permission for mounting a filesystem
@@ -1366,11 +1275,6 @@ int security_sb_statfs(struct dentry *dentry)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_mount(const char *dev_name, const struct path *path,
-		      const char *type, unsigned long flags, void *data)
-{
-	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
-}
 
 /**
  * security_sb_umount() - Check permission for unmounting a filesystem
@@ -1381,10 +1285,6 @@ int security_sb_mount(const char *dev_name, const struct path *path,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_umount(struct vfsmount *mnt, int flags)
-{
-	return call_int_hook(sb_umount, 0, mnt, flags);
-}
 
 /**
  * security_sb_pivotroot() - Check permissions for pivoting the rootfs
@@ -1395,11 +1295,6 @@ int security_sb_umount(struct vfsmount *mnt, int flags)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_pivotroot(const struct path *old_path,
-			  const struct path *new_path)
-{
-	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
-}
 
 /**
  * security_sb_set_mnt_opts() - Set the mount options for a filesystem
@@ -1434,14 +1329,6 @@ EXPORT_SYMBOL(security_sb_set_mnt_opts);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_sb_clone_mnt_opts(const struct super_block *oldsb,
-			       struct super_block *newsb,
-			       unsigned long kern_flags,
-			       unsigned long *set_kern_flags)
-{
-	return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
-			     kern_flags, set_kern_flags);
-}
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
 /**
@@ -1453,11 +1340,6 @@ EXPORT_SYMBOL(security_sb_clone_mnt_opts);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_move_mount(const struct path *from_path,
-			const struct path *to_path)
-{
-	return call_int_hook(move_mount, 0, from_path, to_path);
-}
 
 /**
  * security_path_notify() - Check if setting a watch is allowed
@@ -1470,11 +1352,6 @@ int security_move_mount(const struct path *from_path,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_path_notify(const struct path *path, u64 mask,
-			 unsigned int obj_type)
-{
-	return call_int_hook(path_notify, 0, path, mask, obj_type);
-}
 
 /**
  * security_inode_alloc() - Allocate an inode LSM blob
@@ -1545,26 +1422,6 @@ void security_inode_free(struct inode *inode)
  *
  * Return: Returns 0 on success, negative values on failure.
  */
-int security_dentry_init_security(struct dentry *dentry, int mode,
-				  const struct qstr *name,
-				  const char **xattr_name, void **ctx,
-				  u32 *ctxlen)
-{
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Only one module will provide a security context.
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
-			     list) {
-		rc = hp->hook.dentry_init_security(dentry, mode, name,
-						   xattr_name, ctx, ctxlen);
-		if (rc != LSM_RET_DEFAULT(dentry_init_security))
-			return rc;
-	}
-	return LSM_RET_DEFAULT(dentry_init_security);
-}
 EXPORT_SYMBOL(security_dentry_init_security);
 
 /**
@@ -1582,13 +1439,6 @@ EXPORT_SYMBOL(security_dentry_init_security);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_dentry_create_files_as(struct dentry *dentry, int mode,
-				    struct qstr *name,
-				    const struct cred *old, struct cred *new)
-{
-	return call_int_hook(dentry_create_files_as, 0, dentry, mode,
-			     name, old, new);
-}
 EXPORT_SYMBOL(security_dentry_create_files_as);
 
 /**
@@ -1683,13 +1533,6 @@ EXPORT_SYMBOL(security_inode_init_security);
  * Return: Returns 0 on success, -EACCES if the security module denies the
  * creation of this inode, or another -errno upon other errors.
  */
-int security_inode_init_security_anon(struct inode *inode,
-				      const struct qstr *name,
-				      const struct inode *context_inode)
-{
-	return call_int_hook(inode_init_security_anon, 0, inode, name,
-			     context_inode);
-}
 
 #ifdef CONFIG_SECURITY_PATH
 /**
@@ -1887,10 +1730,6 @@ int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_path_chroot(const struct path *path)
-{
-	return call_int_hook(path_chroot, 0, path);
-}
 #endif /* CONFIG_SECURITY_PATH */
 
 /**
@@ -2360,10 +2199,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
  *         security_inode_killpriv() does not need to be called, return >0 if
  *         security_inode_killpriv() does need to be called.
  */
-int security_inode_need_killpriv(struct dentry *dentry)
-{
-	return call_int_hook(inode_need_killpriv, 0, dentry);
-}
 
 /**
  * security_inode_killpriv() - The setuid bit is removed, update LSM state
@@ -2376,11 +2211,6 @@ int security_inode_need_killpriv(struct dentry *dentry)
  * Return: Return 0 on success.  If error is returned, then the operation
  *         causing setuid bit removal is failed.
  */
-int security_inode_killpriv(struct mnt_idmap *idmap,
-			    struct dentry *dentry)
-{
-	return call_int_hook(inode_killpriv, 0, idmap, dentry);
-}
 
 /**
  * security_inode_getsecurity() - Get the xattr security label of an inode
@@ -2484,10 +2314,6 @@ EXPORT_SYMBOL(security_inode_listsecurity);
  * Get the secid associated with the node.  In case of failure, @secid will be
  * set to zero.
  */
-void security_inode_getsecid(struct inode *inode, u32 *secid)
-{
-	call_void_hook(inode_getsecid, inode, secid);
-}
 
 /**
  * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
@@ -2501,10 +2327,6 @@ void security_inode_getsecid(struct inode *inode, u32 *secid)
  *
  * Return: Returns 0 on success or a negative error code on error.
  */
-int security_inode_copy_up(struct dentry *src, struct cred **new)
-{
-	return call_int_hook(inode_copy_up, 0, src, new);
-}
 EXPORT_SYMBOL(security_inode_copy_up);
 
 /**
@@ -2550,11 +2372,6 @@ EXPORT_SYMBOL(security_inode_copy_up_xattr);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_kernfs_init_security(struct kernfs_node *kn_dir,
-				  struct kernfs_node *kn)
-{
-	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
-}
 
 /**
  * security_file_permission() - Check file permissions
@@ -2639,10 +2456,6 @@ void security_file_free(struct file *file)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return call_int_hook(file_ioctl, 0, file, cmd, arg);
-}
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
@@ -2709,10 +2522,6 @@ int security_mmap_file(struct file *file, unsigned long prot,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_mmap_addr(unsigned long addr)
-{
-	return call_int_hook(mmap_addr, 0, addr);
-}
 
 /**
  * security_file_mprotect() - Check if changing memory protections is allowed
@@ -2745,10 +2554,6 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_lock(struct file *file, unsigned int cmd)
-{
-	return call_int_hook(file_lock, 0, file, cmd);
-}
 
 /**
  * security_file_fcntl() - Check if fcntl() op is allowed
@@ -2764,10 +2569,6 @@ int security_file_lock(struct file *file, unsigned int cmd)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	return call_int_hook(file_fcntl, 0, file, cmd, arg);
-}
 
 /**
  * security_file_set_fowner() - Set the file owner info in the LSM blob
@@ -2778,10 +2579,6 @@ int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
  *
  * Return: Returns 0 on success.
  */
-void security_file_set_fowner(struct file *file)
-{
-	call_void_hook(file_set_fowner, file);
-}
 
 /**
  * security_file_send_sigiotask() - Check if sending SIGIO/SIGURG is allowed
@@ -2797,11 +2594,6 @@ void security_file_set_fowner(struct file *file)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_send_sigiotask(struct task_struct *tsk,
-				 struct fown_struct *fown, int sig)
-{
-	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
-}
 
 /**
  * security_file_receive() - Check is receiving a file via IPC is allowed
@@ -2812,10 +2604,6 @@ int security_file_send_sigiotask(struct task_struct *tsk,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_receive(struct file *file)
-{
-	return call_int_hook(file_receive, 0, file);
-}
 
 /**
  * security_file_open() - Save open() time state for late use by the LSM
@@ -2847,10 +2635,6 @@ int security_file_open(struct file *file)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_file_truncate(struct file *file)
-{
-	return call_int_hook(file_truncate, 0, file);
-}
 
 /**
  * security_task_alloc() - Allocate a task's LSM blob
@@ -2992,10 +2776,6 @@ EXPORT_SYMBOL(security_cred_getsecid);
  *
  * Return: Returns 0 if successful.
  */
-int security_kernel_act_as(struct cred *new, u32 secid)
-{
-	return call_int_hook(kernel_act_as, 0, new, secid);
-}
 
 /**
  * security_kernel_create_files_as() - Set file creation context using an inode
@@ -3008,10 +2788,6 @@ int security_kernel_act_as(struct cred *new, u32 secid)
  *
  * Return: Returns 0 if successful.
  */
-int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-{
-	return call_int_hook(kernel_create_files_as, 0, new, inode);
-}
 
 /**
  * security_kernel_module_request() - Check is loading a module is allowed
@@ -3141,11 +2917,6 @@ EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
  *
  * Return: Returns 0 on success.
  */
-int security_task_fix_setuid(struct cred *new, const struct cred *old,
-			     int flags)
-{
-	return call_int_hook(task_fix_setuid, 0, new, old, flags);
-}
 
 /**
  * security_task_fix_setgid() - Update LSM with new group id attributes
@@ -3161,11 +2932,6 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
  *
  * Return: Returns 0 on success.
  */
-int security_task_fix_setgid(struct cred *new, const struct cred *old,
-			     int flags)
-{
-	return call_int_hook(task_fix_setgid, 0, new, old, flags);
-}
 
 /**
  * security_task_fix_setgroups() - Update LSM with new supplementary groups
@@ -3179,10 +2945,6 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
  *
  * Return: Returns 0 on success.
  */
-int security_task_fix_setgroups(struct cred *new, const struct cred *old)
-{
-	return call_int_hook(task_fix_setgroups, 0, new, old);
-}
 
 /**
  * security_task_setpgid() - Check if setting the pgid is allowed
@@ -3194,10 +2956,6 @@ int security_task_fix_setgroups(struct cred *new, const struct cred *old)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setpgid(struct task_struct *p, pid_t pgid)
-{
-	return call_int_hook(task_setpgid, 0, p, pgid);
-}
 
 /**
  * security_task_getpgid() - Check if getting the pgid is allowed
@@ -3208,10 +2966,6 @@ int security_task_setpgid(struct task_struct *p, pid_t pgid)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_getpgid(struct task_struct *p)
-{
-	return call_int_hook(task_getpgid, 0, p);
-}
 
 /**
  * security_task_getsid() - Check if getting the session id is allowed
@@ -3221,10 +2975,6 @@ int security_task_getpgid(struct task_struct *p)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_getsid(struct task_struct *p)
-{
-	return call_int_hook(task_getsid, 0, p);
-}
 
 /**
  * security_current_getsecid_subj() - Get the current task's subjective secid
@@ -3264,10 +3014,6 @@ EXPORT_SYMBOL(security_task_getsecid_obj);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setnice(struct task_struct *p, int nice)
-{
-	return call_int_hook(task_setnice, 0, p, nice);
-}
 
 /**
  * security_task_setioprio() - Check if setting a task's ioprio is allowed
@@ -3278,10 +3024,6 @@ int security_task_setnice(struct task_struct *p, int nice)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setioprio(struct task_struct *p, int ioprio)
-{
-	return call_int_hook(task_setioprio, 0, p, ioprio);
-}
 
 /**
  * security_task_getioprio() - Check if getting a task's ioprio is allowed
@@ -3291,10 +3033,6 @@ int security_task_setioprio(struct task_struct *p, int ioprio)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_getioprio(struct task_struct *p)
-{
-	return call_int_hook(task_getioprio, 0, p);
-}
 
 /**
  * security_task_prlimit() - Check if get/setting resources limits is allowed
@@ -3307,11 +3045,6 @@ int security_task_getioprio(struct task_struct *p)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
-			  unsigned int flags)
-{
-	return call_int_hook(task_prlimit, 0, cred, tcred, flags);
-}
 
 /**
  * security_task_setrlimit() - Check if setting a new rlimit value is allowed
@@ -3325,11 +3058,6 @@ int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setrlimit(struct task_struct *p, unsigned int resource,
-			    struct rlimit *new_rlim)
-{
-	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
-}
 
 /**
  * security_task_setscheduler() - Check if setting sched policy/param is allowed
@@ -3340,10 +3068,6 @@ int security_task_setrlimit(struct task_struct *p, unsigned int resource,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_setscheduler(struct task_struct *p)
-{
-	return call_int_hook(task_setscheduler, 0, p);
-}
 
 /**
  * security_task_getscheduler() - Check if getting scheduling info is allowed
@@ -3353,10 +3077,6 @@ int security_task_setscheduler(struct task_struct *p)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_getscheduler(struct task_struct *p)
-{
-	return call_int_hook(task_getscheduler, 0, p);
-}
 
 /**
  * security_task_movememory() - Check if moving memory is allowed
@@ -3366,10 +3086,6 @@ int security_task_getscheduler(struct task_struct *p)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_movememory(struct task_struct *p)
-{
-	return call_int_hook(task_movememory, 0, p);
-}
 
 /**
  * security_task_kill() - Check if sending a signal is allowed
@@ -3386,11 +3102,6 @@ int security_task_movememory(struct task_struct *p)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
-		       int sig, const struct cred *cred)
-{
-	return call_int_hook(task_kill, 0, p, info, sig, cred);
-}
 
 /**
  * security_task_prctl() - Check if a prctl op is allowed
@@ -3432,10 +3143,6 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
  * Set the security attributes for an inode based on an associated task's
  * security attributes, e.g. for /proc/pid inodes.
  */
-void security_task_to_inode(struct task_struct *p, struct inode *inode)
-{
-	call_void_hook(task_to_inode, p, inode);
-}
 
 /**
  * security_create_user_ns() - Check if creating a new userns is allowed
@@ -3459,10 +3166,6 @@ int security_create_user_ns(const struct cred *cred)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
-{
-	return call_int_hook(ipc_permission, 0, ipcp, flag);
-}
 
 /**
  * security_ipc_getsecid() - Get the sysv ipc object's secid
@@ -3557,10 +3260,6 @@ void security_msg_queue_free(struct kern_ipc_perm *msq)
  *
  * Return: Return 0 if permission is granted.
  */
-int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
-{
-	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
-}
 
 /**
  * security_msg_queue_msgctl() - Check if a msg queue operation is allowed
@@ -3572,10 +3271,6 @@ int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
-{
-	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
-}
 
 /**
  * security_msg_queue_msgsnd() - Check if sending a sysv ipc message is allowed
@@ -3588,11 +3283,6 @@ int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
-			      struct msg_msg *msg, int msqflg)
-{
-	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
-}
 
 /**
  * security_msg_queue_msgrcv() - Check if receiving a sysv ipc msg is allowed
@@ -3609,11 +3299,6 @@ int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
-			      struct task_struct *target, long type, int mode)
-{
-	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
-}
 
 /**
  * security_shm_alloc() - Allocate a sysv shm LSM blob
@@ -3661,10 +3346,6 @@ void security_shm_free(struct kern_ipc_perm *shp)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
-{
-	return call_int_hook(shm_associate, 0, shp, shmflg);
-}
 
 /**
  * security_shm_shmctl() - Check if a sysv shm operation is allowed
@@ -3676,10 +3357,6 @@ int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
  *
  * Return: Return 0 if permission is granted.
  */
-int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
-{
-	return call_int_hook(shm_shmctl, 0, shp, cmd);
-}
 
 /**
  * security_shm_shmat() - Check if a sysv shm attach operation is allowed
@@ -3693,11 +3370,6 @@ int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_shm_shmat(struct kern_ipc_perm *shp,
-		       char __user *shmaddr, int shmflg)
-{
-	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
-}
 
 /**
  * security_sem_alloc() - Allocate a sysv semaphore LSM blob
@@ -3744,10 +3416,6 @@ void security_sem_free(struct kern_ipc_perm *sma)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
-{
-	return call_int_hook(sem_associate, 0, sma, semflg);
-}
 
 /**
  * security_sem_semctl() - Check if a sysv semaphore operation is allowed
@@ -3759,10 +3427,6 @@ int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
-{
-	return call_int_hook(sem_semctl, 0, sma, cmd);
-}
 
 /**
  * security_sem_semop() - Check if a sysv semaphore operation is allowed
@@ -3776,11 +3440,6 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
-		       unsigned nsops, int alter)
-{
-	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
-}
 
 /**
  * security_d_instantiate() - Populate an inode's LSM state based on a dentry
@@ -3859,10 +3518,6 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
  * Return: Returns 0 if the information was successfully saved and message is
  *         allowed to be transmitted.
  */
-int security_netlink_send(struct sock *sk, struct sk_buff *skb)
-{
-	return call_int_hook(netlink_send, 0, sk, skb);
-}
 
 /**
  * security_ismaclabel() - Check is the named attribute is a MAC label
@@ -3872,10 +3527,6 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
  *
  * Return: Returns 1 if name is a MAC attribute otherwise returns 0.
  */
-int security_ismaclabel(const char *name)
-{
-	return call_int_hook(ismaclabel, 0, name);
-}
 EXPORT_SYMBOL(security_ismaclabel);
 
 /**
@@ -3891,23 +3542,6 @@ EXPORT_SYMBOL(security_ismaclabel);
  *
  * Return: Return 0 on success, error on failure.
  */
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
-{
-	struct security_hook_list *hp;
-	int rc;
-
-	/*
-	 * Currently, only one LSM can implement secid_to_secctx (i.e this
-	 * LSM hook is not "stackable").
-	 */
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
-	}
-
-	return LSM_RET_DEFAULT(secid_to_secctx);
-}
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 /**
@@ -3968,10 +3602,6 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
-{
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
-}
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 /**
@@ -3990,10 +3620,6 @@ EXPORT_SYMBOL(security_inode_notifysecctx);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-{
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
-}
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 /**
@@ -4024,12 +3650,6 @@ EXPORT_SYMBOL(security_inode_getsecctx);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_post_notification(const struct cred *w_cred,
-			       const struct cred *cred,
-			       struct watch_notification *n)
-{
-	return call_int_hook(post_notification, 0, w_cred, cred, n);
-}
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_KEY_NOTIFICATIONS
@@ -4042,10 +3662,6 @@ int security_post_notification(const struct cred *w_cred,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_watch_key(struct key *key)
-{
-	return call_int_hook(watch_key, 0, key);
-}
 #endif /* CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -4070,11 +3686,6 @@ int security_watch_key(struct key *key)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_stream_connect(struct sock *sock, struct sock *other,
-				 struct sock *newsk)
-{
-	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
-}
 EXPORT_SYMBOL(security_unix_stream_connect);
 
 /**
@@ -4097,10 +3708,6 @@ EXPORT_SYMBOL(security_unix_stream_connect);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_may_send(struct socket *sock,  struct socket *other)
-{
-	return call_int_hook(unix_may_send, 0, sock, other);
-}
 EXPORT_SYMBOL(security_unix_may_send);
 
 /**
@@ -4114,10 +3721,6 @@ EXPORT_SYMBOL(security_unix_may_send);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_create(int family, int type, int protocol, int kern)
-{
-	return call_int_hook(socket_create, 0, family, type, protocol, kern);
-}
 
 /**
  * security_socket_post_create() - Initialize a newly created socket
@@ -4137,12 +3740,6 @@ int security_socket_create(int family, int type, int protocol, int kern)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_post_create(struct socket *sock, int family,
-				int type, int protocol, int kern)
-{
-	return call_int_hook(socket_post_create, 0, sock, family, type,
-			     protocol, kern);
-}
 
 /**
  * security_socket_socketpair() - Check if creating a socketpair is allowed
@@ -4154,10 +3751,6 @@ int security_socket_post_create(struct socket *sock, int family,
  * Return: Returns 0 if permission is granted and the connection was
  *         established.
  */
-int security_socket_socketpair(struct socket *socka, struct socket *sockb)
-{
-	return call_int_hook(socket_socketpair, 0, socka, sockb);
-}
 EXPORT_SYMBOL(security_socket_socketpair);
 
 /**
@@ -4172,11 +3765,6 @@ EXPORT_SYMBOL(security_socket_socketpair);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_bind(struct socket *sock,
-			 struct sockaddr *address, int addrlen)
-{
-	return call_int_hook(socket_bind, 0, sock, address, addrlen);
-}
 
 /**
  * security_socket_connect() - Check if a socket connect operation is allowed
@@ -4189,11 +3777,6 @@ int security_socket_bind(struct socket *sock,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_connect(struct socket *sock,
-			    struct sockaddr *address, int addrlen)
-{
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
-}
 
 /**
  * security_socket_listen() - Check if a socket is allowed to listen
@@ -4204,10 +3787,6 @@ int security_socket_connect(struct socket *sock,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_listen(struct socket *sock, int backlog)
-{
-	return call_int_hook(socket_listen, 0, sock, backlog);
-}
 
 /**
  * security_socket_accept() - Check if a socket is allowed to accept connections
@@ -4220,10 +3799,6 @@ int security_socket_listen(struct socket *sock, int backlog)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_accept(struct socket *sock, struct socket *newsock)
-{
-	return call_int_hook(socket_accept, 0, sock, newsock);
-}
 
 /**
  * security_socket_sendmsg() - Check is sending a message is allowed
@@ -4235,10 +3810,6 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
-{
-	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
-}
 
 /**
  * security_socket_recvmsg() - Check if receiving a message is allowed
@@ -4251,11 +3822,6 @@ int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
-			    int size, int flags)
-{
-	return call_int_hook(socket_recvmsg, 0, sock, msg, size, flags);
-}
 
 /**
  * security_socket_getsockname() - Check if reading the socket addr is allowed
@@ -4266,10 +3832,6 @@ int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_getsockname(struct socket *sock)
-{
-	return call_int_hook(socket_getsockname, 0, sock);
-}
 
 /**
  * security_socket_getpeername() - Check if reading the peer's addr is allowed
@@ -4279,10 +3841,6 @@ int security_socket_getsockname(struct socket *sock)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_getpeername(struct socket *sock)
-{
-	return call_int_hook(socket_getpeername, 0, sock);
-}
 
 /**
  * security_socket_getsockopt() - Check if reading a socket option is allowed
@@ -4295,10 +3853,6 @@ int security_socket_getpeername(struct socket *sock)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_getsockopt(struct socket *sock, int level, int optname)
-{
-	return call_int_hook(socket_getsockopt, 0, sock, level, optname);
-}
 
 /**
  * security_socket_setsockopt() - Check if setting a socket option is allowed
@@ -4310,10 +3864,6 @@ int security_socket_getsockopt(struct socket *sock, int level, int optname)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_setsockopt(struct socket *sock, int level, int optname)
-{
-	return call_int_hook(socket_setsockopt, 0, sock, level, optname);
-}
 
 /**
  * security_socket_shutdown() - Checks if shutting down the socket is allowed
@@ -4325,10 +3875,6 @@ int security_socket_setsockopt(struct socket *sock, int level, int optname)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_shutdown(struct socket *sock, int how)
-{
-	return call_int_hook(socket_shutdown, 0, sock, how);
-}
 
 /**
  * security_sock_rcv_skb() - Check if an incoming network packet is allowed
@@ -4452,11 +3998,6 @@ EXPORT_SYMBOL(security_sk_classify_flow);
  *
  * Sets @flic's secid to @req's secid.
  */
-void security_req_classify_flow(const struct request_sock *req,
-				struct flowi_common *flic)
-{
-	call_void_hook(req_classify_flow, req, flic);
-}
 EXPORT_SYMBOL(security_req_classify_flow);
 
 /**
@@ -4467,10 +4008,6 @@ EXPORT_SYMBOL(security_req_classify_flow);
  * Sets @parent's inode secid to @sk's secid and update @sk with any necessary
  * LSM state from @parent.
  */
-void security_sock_graft(struct sock *sk, struct socket *parent)
-{
-	call_void_hook(sock_graft, sk, parent);
-}
 EXPORT_SYMBOL(security_sock_graft);
 
 /**
@@ -4483,11 +4020,6 @@ EXPORT_SYMBOL(security_sock_graft);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inet_conn_request(const struct sock *sk,
-			       struct sk_buff *skb, struct request_sock *req)
-{
-	return call_int_hook(inet_conn_request, 0, sk, skb, req);
-}
 EXPORT_SYMBOL(security_inet_conn_request);
 
 /**
@@ -4497,11 +4029,6 @@ EXPORT_SYMBOL(security_inet_conn_request);
  *
  * Set that LSM state of @sock using the LSM state from @req.
  */
-void security_inet_csk_clone(struct sock *newsk,
-			     const struct request_sock *req)
-{
-	call_void_hook(inet_csk_clone, newsk, req);
-}
 
 /**
  * security_inet_conn_established() - Update sock's LSM state with connection
@@ -4510,11 +4037,6 @@ void security_inet_csk_clone(struct sock *newsk,
  *
  * Update @sock's LSM state to represent a new connection from @skb.
  */
-void security_inet_conn_established(struct sock *sk,
-				    struct sk_buff *skb)
-{
-	call_void_hook(inet_conn_established, sk, skb);
-}
 EXPORT_SYMBOL(security_inet_conn_established);
 
 /**
@@ -4525,10 +4047,6 @@ EXPORT_SYMBOL(security_inet_conn_established);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_secmark_relabel_packet(u32 secid)
-{
-	return call_int_hook(secmark_relabel_packet, 0, secid);
-}
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
 /**
@@ -4536,10 +4054,6 @@ EXPORT_SYMBOL(security_secmark_relabel_packet);
  *
  * Tells the LSM to increment the number of secmark labeling rules loaded.
  */
-void security_secmark_refcount_inc(void)
-{
-	call_void_hook(secmark_refcount_inc);
-}
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
 /**
@@ -4547,10 +4061,6 @@ EXPORT_SYMBOL(security_secmark_refcount_inc);
  *
  * Tells the LSM to decrement the number of secmark labeling rules loaded.
  */
-void security_secmark_refcount_dec(void)
-{
-	call_void_hook(secmark_refcount_dec);
-}
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
 /**
@@ -4562,10 +4072,6 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
  *
  * Return: Returns a zero on success, negative values on failure.
  */
-int security_tun_dev_alloc_security(void **security)
-{
-	return call_int_hook(tun_dev_alloc_security, 0, security);
-}
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
 /**
@@ -4574,10 +4080,6 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
  *
  * This hook allows a module to free the security structure for a TUN device.
  */
-void security_tun_dev_free_security(void *security)
-{
-	call_void_hook(tun_dev_free_security, security);
-}
 EXPORT_SYMBOL(security_tun_dev_free_security);
 
 /**
@@ -4587,10 +4089,6 @@ EXPORT_SYMBOL(security_tun_dev_free_security);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_tun_dev_create(void)
-{
-	return call_int_hook(tun_dev_create, 0);
-}
 EXPORT_SYMBOL(security_tun_dev_create);
 
 /**
@@ -4601,10 +4099,6 @@ EXPORT_SYMBOL(security_tun_dev_create);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_tun_dev_attach_queue(void *security)
-{
-	return call_int_hook(tun_dev_attach_queue, 0, security);
-}
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
 /**
@@ -4617,10 +4111,6 @@ EXPORT_SYMBOL(security_tun_dev_attach_queue);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_tun_dev_attach(struct sock *sk, void *security)
-{
-	return call_int_hook(tun_dev_attach, 0, sk, security);
-}
 EXPORT_SYMBOL(security_tun_dev_attach);
 
 /**
@@ -4632,10 +4122,6 @@ EXPORT_SYMBOL(security_tun_dev_attach);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_tun_dev_open(void *security)
-{
-	return call_int_hook(tun_dev_open, 0, security);
-}
 EXPORT_SYMBOL(security_tun_dev_open);
 
 /**
@@ -4647,11 +4133,6 @@ EXPORT_SYMBOL(security_tun_dev_open);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_sctp_assoc_request(struct sctp_association *asoc,
-				struct sk_buff *skb)
-{
-	return call_int_hook(sctp_assoc_request, 0, asoc, skb);
-}
 EXPORT_SYMBOL(security_sctp_assoc_request);
 
 /**
@@ -4668,12 +4149,6 @@ EXPORT_SYMBOL(security_sctp_assoc_request);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_sctp_bind_connect(struct sock *sk, int optname,
-			       struct sockaddr *address, int addrlen)
-{
-	return call_int_hook(sctp_bind_connect, 0, sk, optname,
-			     address, addrlen);
-}
 EXPORT_SYMBOL(security_sctp_bind_connect);
 
 /**
@@ -4686,11 +4161,6 @@ EXPORT_SYMBOL(security_sctp_bind_connect);
  * socket) or when a socket is 'peeled off' e.g userspace calls
  * sctp_peeloff(3).
  */
-void security_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
-			    struct sock *newsk)
-{
-	call_void_hook(sctp_sk_clone, asoc, sk, newsk);
-}
 EXPORT_SYMBOL(security_sctp_sk_clone);
 
 /**
@@ -4703,11 +4173,6 @@ EXPORT_SYMBOL(security_sctp_sk_clone);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sctp_assoc_established(struct sctp_association *asoc,
-				    struct sk_buff *skb)
-{
-	return call_int_hook(sctp_assoc_established, 0, asoc, skb);
-}
 EXPORT_SYMBOL(security_sctp_assoc_established);
 
 /**
@@ -4722,10 +4187,6 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
  *
  * Return: Returns 0 on success or a negative error code on failure.
  */
-int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
-{
-	return call_int_hook(mptcp_add_subflow, 0, sk, ssk);
-}
 
 #endif	/* CONFIG_SECURITY_NETWORK */
 
@@ -4740,10 +4201,6 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
-{
-	return call_int_hook(ib_pkey_access, 0, sec, subnet_prefix, pkey);
-}
 EXPORT_SYMBOL(security_ib_pkey_access);
 
 /**
@@ -4756,12 +4213,6 @@ EXPORT_SYMBOL(security_ib_pkey_access);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ib_endport_manage_subnet(void *sec,
-				      const char *dev_name, u8 port_num)
-{
-	return call_int_hook(ib_endport_manage_subnet, 0, sec,
-			     dev_name, port_num);
-}
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
 /**
@@ -4772,10 +4223,6 @@ EXPORT_SYMBOL(security_ib_endport_manage_subnet);
  *
  * Return: Returns 0 on success, non-zero on failure.
  */
-int security_ib_alloc_security(void **sec)
-{
-	return call_int_hook(ib_alloc_security, 0, sec);
-}
 EXPORT_SYMBOL(security_ib_alloc_security);
 
 /**
@@ -4784,10 +4231,6 @@ EXPORT_SYMBOL(security_ib_alloc_security);
  *
  * Deallocate an Infiniband security structure.
  */
-void security_ib_free_security(void *sec)
-{
-	call_void_hook(ib_free_security, sec);
-}
 EXPORT_SYMBOL(security_ib_free_security);
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 
@@ -4803,12 +4246,6 @@ EXPORT_SYMBOL(security_ib_free_security);
  *
  * Return:  Return 0 if operation was successful.
  */
-int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
-			       struct xfrm_user_sec_ctx *sec_ctx,
-			       gfp_t gfp)
-{
-	return call_int_hook(xfrm_policy_alloc_security, 0, ctxp, sec_ctx, gfp);
-}
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 /**
@@ -4821,11 +4258,6 @@ EXPORT_SYMBOL(security_xfrm_policy_alloc);
  *
  * Return: Return 0 if operation was successful.
  */
-int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
-			       struct xfrm_sec_ctx **new_ctxp)
-{
-	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
-}
 
 /**
  * security_xfrm_policy_free() - Free a xfrm security context
@@ -4833,10 +4265,6 @@ int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
  *
  * Free LSM resources associated with @ctx.
  */
-void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
-{
-	call_void_hook(xfrm_policy_free_security, ctx);
-}
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
 /**
@@ -4847,10 +4275,6 @@ EXPORT_SYMBOL(security_xfrm_policy_free);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
-{
-	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
-}
 
 /**
  * security_xfrm_state_alloc() - Allocate a xfrm state LSM blob
@@ -4863,11 +4287,6 @@ int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
  *
  * Return: Return 0 if operation was successful.
  */
-int security_xfrm_state_alloc(struct xfrm_state *x,
-			      struct xfrm_user_sec_ctx *sec_ctx)
-{
-	return call_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
-}
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 /**
@@ -4882,11 +4301,6 @@ EXPORT_SYMBOL(security_xfrm_state_alloc);
  *
  * Return: Returns 0 if operation was successful.
  */
-int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				      struct xfrm_sec_ctx *polsec, u32 secid)
-{
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
-}
 
 /**
  * security_xfrm_state_delete() - Check if deleting a xfrm state is allowed
@@ -4896,10 +4310,6 @@ int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_xfrm_state_delete(struct xfrm_state *x)
-{
-	return call_int_hook(xfrm_state_delete_security, 0, x);
-}
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
 /**
@@ -4908,10 +4318,6 @@ EXPORT_SYMBOL(security_xfrm_state_delete);
  *
  * Deallocate x->security.
  */
-void security_xfrm_state_free(struct xfrm_state *x)
-{
-	call_void_hook(xfrm_state_free_security, x);
-}
 
 /**
  * security_xfrm_policy_lookup() - Check if using a xfrm policy is allowed
@@ -4925,10 +4331,6 @@ void security_xfrm_state_free(struct xfrm_state *x)
  * Return: Return 0 if permission is granted, -ESRCH otherwise, or -errno on
  *         other errors.
  */
-int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
-{
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid);
-}
 
 /**
  * security_xfrm_state_pol_flow_match() - Check for a xfrm match
@@ -4973,10 +4375,6 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
  *
  * Return: Return 0 if all xfrms used have the same secid.
  */
-int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
-{
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
-}
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
@@ -5000,11 +4398,6 @@ EXPORT_SYMBOL(security_skb_classify_flow);
  *
  * Return: Return 0 if permission is granted, -ve error otherwise.
  */
-int security_key_alloc(struct key *key, const struct cred *cred,
-		       unsigned long flags)
-{
-	return call_int_hook(key_alloc, 0, key, cred, flags);
-}
 
 /**
  * security_key_free() - Free a kernel key LSM blob
@@ -5012,10 +4405,6 @@ int security_key_alloc(struct key *key, const struct cred *cred,
  *
  * Notification of destruction; free security data.
  */
-void security_key_free(struct key *key)
-{
-	call_void_hook(key_free, key);
-}
 
 /**
  * security_key_permission() - Check if a kernel key operation is allowed
@@ -5027,11 +4416,6 @@ void security_key_free(struct key *key)
  *
  * Return: Return 0 if permission is granted, -ve error otherwise.
  */
-int security_key_permission(key_ref_t key_ref, const struct cred *cred,
-			    enum key_need_perm need_perm)
-{
-	return call_int_hook(key_permission, 0, key_ref, cred, need_perm);
-}
 
 /**
  * security_key_getsecurity() - Get the key's security label
@@ -5066,10 +4450,6 @@ int security_key_getsecurity(struct key *key, char **buffer)
  * Return: Return 0 if @lsmrule has been successfully set, -EINVAL in case of
  *         an invalid rule.
  */
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
-{
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
-}
 
 /**
  * security_audit_rule_known() - Check if an audit rule contains LSM fields
@@ -5080,10 +4460,6 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
  *
  * Return: Returns 1 in case of relation found, 0 otherwise.
  */
-int security_audit_rule_known(struct audit_krule *krule)
-{
-	return call_int_hook(audit_rule_known, 0, krule);
-}
 
 /**
  * security_audit_rule_free() - Free an LSM audit rule struct
@@ -5092,10 +4468,6 @@ int security_audit_rule_known(struct audit_krule *krule)
  * Deallocate the LSM audit rule structure previously allocated by
  * audit_rule_init().
  */
-void security_audit_rule_free(void *lsmrule)
-{
-	call_void_hook(audit_rule_free, lsmrule);
-}
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
@@ -5110,10 +4482,6 @@ void security_audit_rule_free(void *lsmrule)
  * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
  *         failure.
  */
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
-{
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
-}
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
@@ -5129,10 +4497,6 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
-{
-	return call_int_hook(bpf, 0, cmd, attr, size);
-}
 
 /**
  * security_bpf_map() - Check if access to a bpf map is allowed
@@ -5144,10 +4508,6 @@ int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_bpf_map(struct bpf_map *map, fmode_t fmode)
-{
-	return call_int_hook(bpf_map, 0, map, fmode);
-}
 
 /**
  * security_bpf_prog() - Check if access to a bpf program is allowed
@@ -5158,10 +4518,6 @@ int security_bpf_map(struct bpf_map *map, fmode_t fmode)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_bpf_prog(struct bpf_prog *prog)
-{
-	return call_int_hook(bpf_prog, 0, prog);
-}
 
 /**
  * security_bpf_map_alloc() - Allocate a bpf map LSM blob
@@ -5171,10 +4527,6 @@ int security_bpf_prog(struct bpf_prog *prog)
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_bpf_map_alloc(struct bpf_map *map)
-{
-	return call_int_hook(bpf_map_alloc_security, 0, map);
-}
 
 /**
  * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
@@ -5184,10 +4536,6 @@ int security_bpf_map_alloc(struct bpf_map *map)
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
-{
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
-}
 
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
@@ -5195,10 +4543,6 @@ int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
  *
  * Clean up the security information stored inside bpf map.
  */
-void security_bpf_map_free(struct bpf_map *map)
-{
-	call_void_hook(bpf_map_free_security, map);
-}
 
 /**
  * security_bpf_prog_free() - Free a bpf program's LSM blob
@@ -5206,10 +4550,6 @@ void security_bpf_map_free(struct bpf_map *map)
  *
  * Clean up the security information stored inside bpf prog.
  */
-void security_bpf_prog_free(struct bpf_prog_aux *aux)
-{
-	call_void_hook(bpf_prog_free_security, aux);
-}
 #endif /* CONFIG_BPF_SYSCALL */
 
 /**
@@ -5221,10 +4561,6 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_locked_down(enum lockdown_reason what)
-{
-	return call_int_hook(locked_down, 0, what);
-}
 EXPORT_SYMBOL(security_locked_down);
 
 #ifdef CONFIG_PERF_EVENTS
@@ -5237,10 +4573,6 @@ EXPORT_SYMBOL(security_locked_down);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_perf_event_open(struct perf_event_attr *attr, int type)
-{
-	return call_int_hook(perf_event_open, 0, attr, type);
-}
 
 /**
  * security_perf_event_alloc() - Allocate a perf event LSM blob
@@ -5250,10 +4582,6 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_perf_event_alloc(struct perf_event *event)
-{
-	return call_int_hook(perf_event_alloc, 0, event);
-}
 
 /**
  * security_perf_event_free() - Free a perf event LSM blob
@@ -5261,10 +4589,6 @@ int security_perf_event_alloc(struct perf_event *event)
  *
  * Release (free) perf_event security info.
  */
-void security_perf_event_free(struct perf_event *event)
-{
-	call_void_hook(perf_event_free, event);
-}
 
 /**
  * security_perf_event_read() - Check if reading a perf event label is allowed
@@ -5274,10 +4598,6 @@ void security_perf_event_free(struct perf_event *event)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_perf_event_read(struct perf_event *event)
-{
-	return call_int_hook(perf_event_read, 0, event);
-}
 
 /**
  * security_perf_event_write() - Check if writing a perf event label is allowed
@@ -5287,10 +4607,6 @@ int security_perf_event_read(struct perf_event *event)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_perf_event_write(struct perf_event *event)
-{
-	return call_int_hook(perf_event_write, 0, event);
-}
 #endif /* CONFIG_PERF_EVENTS */
 
 #ifdef CONFIG_IO_URING
@@ -5303,10 +4619,6 @@ int security_perf_event_write(struct perf_event *event)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_uring_override_creds(const struct cred *new)
-{
-	return call_int_hook(uring_override_creds, 0, new);
-}
 
 /**
  * security_uring_sqpoll() - Check if IORING_SETUP_SQPOLL is allowed
@@ -5316,10 +4628,6 @@ int security_uring_override_creds(const struct cred *new)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_uring_sqpoll(void)
-{
-	return call_int_hook(uring_sqpoll, 0);
-}
 
 /**
  * security_uring_cmd() - Check if a io_uring passthrough command is allowed
@@ -5329,8 +4637,4 @@ int security_uring_sqpoll(void)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_uring_cmd(struct io_uring_cmd *ioucmd)
-{
-	return call_int_hook(uring_cmd, 0, ioucmd);
-}
 #endif /* CONFIG_IO_URING */
-- 
2.34.1


