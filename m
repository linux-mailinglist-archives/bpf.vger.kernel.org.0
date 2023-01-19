Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1DF674C0A
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjATFUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjATFTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC487DFAA;
        Thu, 19 Jan 2023 21:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A636AB82734;
        Thu, 19 Jan 2023 23:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEEAC433F1;
        Thu, 19 Jan 2023 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674169848;
        bh=PEIUFjWVbkdv9FwnERK5qaagyDYayJUl2lsdEAuFz2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRCEW43rrnPxV7lcFRI3nUwKUhMSlKdUpNc4IiTlEdsSVMfs/ZeASPVjXMnT05K2m
         j/VDgBIsJOf8EAhugh/AyodpRJkIQ3MIFVejOSTRN04W6fiLV+loZoIeLGs6sanMg7
         sGxCvsigcBmSDCFXwbHVvBN5m/kGymuEPGd12gwYVxDBjEVhRMenTsbtetx2UJn+h7
         VvDW43i3cQ39zfaEcRZ035kxzJOG8TkgxJ6/dxquEYZ6wnrMbUfSsVGkR3Cafozus1
         cg+Crczra+tOUe59SXZ4rXB6beHVKEXaYmMIOons4RIC8/nzm3mzCl3pl1E4iox4X8
         o0aLoDKl4hWYw==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 3/4] security: Replace indirect LSM hook calls with static calls
Date:   Fri, 20 Jan 2023 00:10:32 +0100
Message-Id: <20230119231033.1307221-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230119231033.1307221-1-kpsingh@kernel.org>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LSM hooks are currently invoked from a linked list as indirect calls
which are invoked using retpolines as a mitigation for speculative
attacks (Branch History / Target injection)  and add extra overhead which
is especially bad in kernel hot paths:

security_file_ioctl:
   0xffffffff814f0320 <+0>:	endbr64
   0xffffffff814f0324 <+4>:	push   %rbp
   0xffffffff814f0325 <+5>:	push   %r15
   0xffffffff814f0327 <+7>:	push   %r14
   0xffffffff814f0329 <+9>:	push   %rbx
   0xffffffff814f032a <+10>:	mov    %rdx,%rbx
   0xffffffff814f032d <+13>:	mov    %esi,%ebp
   0xffffffff814f032f <+15>:	mov    %rdi,%r14
   0xffffffff814f0332 <+18>:	mov    $0xffffffff834a7030,%r15
   0xffffffff814f0339 <+25>:	mov    (%r15),%r15
   0xffffffff814f033c <+28>:	test   %r15,%r15
   0xffffffff814f033f <+31>:	je     0xffffffff814f0358 <security_file_ioctl+56>
   0xffffffff814f0341 <+33>:	mov    0x18(%r15),%r11
   0xffffffff814f0345 <+37>:	mov    %r14,%rdi
   0xffffffff814f0348 <+40>:	mov    %ebp,%esi
   0xffffffff814f034a <+42>:	mov    %rbx,%rdx

>>> 0xffffffff814f034d <+45>:	call   0xffffffff81f742e0 <__x86_indirect_thunk_array+352>

    Indirect calls that use retpolines leading to overhead, not just due
    to extra instruction but also branch misses.

   0xffffffff814f0352 <+50>:	test   %eax,%eax
   0xffffffff814f0354 <+52>:	je     0xffffffff814f0339 <security_file_ioctl+25>
   0xffffffff814f0356 <+54>:	jmp    0xffffffff814f035a <security_file_ioctl+58>
   0xffffffff814f0358 <+56>:	xor    %eax,%eax
   0xffffffff814f035a <+58>:	pop    %rbx
   0xffffffff814f035b <+59>:	pop    %r14
   0xffffffff814f035d <+61>:	pop    %r15
   0xffffffff814f035f <+63>:	pop    %rbp
   0xffffffff814f0360 <+64>:	jmp    0xffffffff81f747c4 <__x86_return_thunk>

The indirect calls are not really needed as one knows the addresses of
enabled LSM callbacks at boot time and only the order can possibly
change at boot time with the lsm= kernel command line parameter.

An array of static calls is defined per LSM hook and the static calls
are updated at boot time once the order has been determined.

A static key guards whether an LSM static call is enabled or not,
without this static key, for LSM hooks that return an int, the presence
of the hook that returns a default value can create side-effects which
has resulted in bugs [1].

With the hook now exposed as a static call, one can see that the
retpolines are no longer there and the LSM callbacks are invoked
directly:

security_file_ioctl:
   0xffffffff814f0dd0 <+0>:	endbr64
   0xffffffff814f0dd4 <+4>:	push   %rbp
   0xffffffff814f0dd5 <+5>:	push   %r14
   0xffffffff814f0dd7 <+7>:	push   %rbx
   0xffffffff814f0dd8 <+8>:	mov    %rdx,%rbx
   0xffffffff814f0ddb <+11>:	mov    %esi,%ebp
   0xffffffff814f0ddd <+13>:	mov    %rdi,%r14

>>> 0xffffffff814f0de0 <+16>:	jmp    0xffffffff814f0df1 <security_file_ioctl+33>

    Static key enabled for selinux_file_ioctl

>>> 0xffffffff814f0de2 <+18>:	jmp    0xffffffff814f0e08 <security_file_ioctl+56>

   Static key enabled for bpf_lsm_file_ioctl. This is something that is
   changed to default to false to avoid the existing side effect issues
   of BPF LSM [1]

   0xffffffff814f0de4 <+20>:	xor    %eax,%eax
   0xffffffff814f0de6 <+22>:	xchg   %ax,%ax
   0xffffffff814f0de8 <+24>:	pop    %rbx
   0xffffffff814f0de9 <+25>:	pop    %r14
   0xffffffff814f0deb <+27>:	pop    %rbp
   0xffffffff814f0dec <+28>:	jmp    0xffffffff81f767c4 <__x86_return_thunk>
   0xffffffff814f0df1 <+33>:	endbr64
   0xffffffff814f0df5 <+37>:	mov    %r14,%rdi
   0xffffffff814f0df8 <+40>:	mov    %ebp,%esi
   0xffffffff814f0dfa <+42>:	mov    %rbx,%rdx

>>>   0xffffffff814f0dfd <+45>:	call   0xffffffff814fe820 <selinux_file_ioctl>

   Direct call to SELinux.

   0xffffffff814f0e02 <+50>:	test   %eax,%eax
   0xffffffff814f0e04 <+52>:	jne    0xffffffff814f0de8 <security_file_ioctl+24>
   0xffffffff814f0e06 <+54>:	jmp    0xffffffff814f0de2 <security_file_ioctl+18>
   0xffffffff814f0e08 <+56>:	endbr64
   0xffffffff814f0e0c <+60>:	mov    %r14,%rdi
   0xffffffff814f0e0f <+63>:	mov    %ebp,%esi
   0xffffffff814f0e11 <+65>:	mov    %rbx,%rdx

>>>  0xffffffff814f0e14 <+68>:	call   0xffffffff8123b7d0 <bpf_lsm_file_ioctl>

   Direct call to bpf_lsm_file_ioctl

   0xffffffff814f0e19 <+73>:	test   %eax,%eax
   0xffffffff814f0e1b <+75>:	jne    0xffffffff814f0de8 <security_file_ioctl+24>
   0xffffffff814f0e1d <+77>:	jmp    0xffffffff814f0de4 <security_file_ioctl+20>
   0xffffffff814f0e1f <+79>:	endbr64
   0xffffffff814f0e23 <+83>:	mov    %r14,%rdi
   0xffffffff814f0e26 <+86>:	mov    %ebp,%esi
   0xffffffff814f0e28 <+88>:	mov    %rbx,%rdx
   0xffffffff814f0e2b <+91>:	pop    %rbx
   0xffffffff814f0e2c <+92>:	pop    %r14
   0xffffffff814f0e2e <+94>:	pop    %rbp
   0xffffffff814f0e2f <+95>:	ret
   0xffffffff814f0e30 <+96>:	int3
   0xffffffff814f0e31 <+97>:	int3
   0xffffffff814f0e32 <+98>:	int3
   0xffffffff814f0e33 <+99>:	int3

There are some hooks that don't use the call_int_hook and
call_void_hook. These hooks are updated to use a new macro called
security_for_each_hook where the lsm_callback is directly invoked as an
indirect call. Currently, there are no performance sensitive hooks that
use the security_for_each_hook macro. However, if, some performance
sensitive hooks are discovered, these can be updated to use
static calls with loop unrolling as well using a custom macro.

[1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hooks.h |  83 +++++++++++++--
 security/security.c       | 216 ++++++++++++++++++++++++--------------
 2 files changed, 211 insertions(+), 88 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5ba81f7367..c82d15a4ef50 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -28,6 +28,26 @@
 #include <linux/security.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
+#include <linux/static_call.h>
+#include <linux/unroll.h>
+#include <linux/jump_label.h>
+
+/* Include the generated MAX_LSM_COUNT */
+#include <generated/lsm_count.h>
+
+#define SECURITY_HOOK_ENABLED_KEY(HOOK, IDX) security_enabled_key_##HOOK##_##IDX
+
+/*
+ * Identifier for the LSM static calls.
+ * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
+ * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
+ */
+#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
+
+/*
+ * Call the macro M for each LSM hook MAX_LSM_COUNT times.
+ */
+#define LSM_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
 
 /**
  * union security_list_options - Linux Security Module hook function list
@@ -1657,21 +1677,48 @@ union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
 	#undef LSM_HOOK
+	void *lsm_callback;
 };
 
-struct security_hook_heads {
-	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
-	#include "lsm_hook_defs.h"
+/*
+ * @key: static call key as defined by STATIC_CALL_KEY
+ * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
+ * @hl: The security_hook_list as initialized by the owning LSM.
+ * @enabled_key: Enabled when the static call has an LSM hook associated.
+ */
+struct lsm_static_call {
+	struct static_call_key *key;
+	void *trampoline;
+	struct security_hook_list *hl;
+	struct static_key *enabled_key;
+};
+
+/*
+ * Table of the static calls for each LSM hook.
+ * Once the LSMs are initialized, their callbacks will be copied to these
+ * tables such that the calls are filled backwards (from last to first).
+ * This way, we can jump directly to the first used static call, and execute
+ * all of them after. This essentially makes the entry point
+ * dynamic to adapt the number of static calls to the number of callbacks.
+ */
+struct lsm_static_calls_table {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+		struct lsm_static_call NAME[MAX_LSM_COUNT];
+	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 } __randomize_layout;
 
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
+ *
+ * struct security_hook_list - Contents of a cacheable, mappable object.
+ * @scalls: The beginning of the array of static calls assigned to this hook.
+ * @hook: The callback for the hook.
+ * @lsm: The name of the lsm that owns this hook.
  */
 struct security_hook_list {
-	struct hlist_node		list;
-	struct hlist_head		*head;
+	struct lsm_static_call	*scalls;
 	union security_list_options	hook;
 	const char			*lsm;
 } __randomize_layout;
@@ -1701,10 +1748,12 @@ struct lsm_blob_sizes {
  * care of the common case and reduces the amount of
  * text involved.
  */
-#define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+#define LSM_HOOK_INIT(NAME, CALLBACK)			\
+	{						\
+		.scalls = static_calls_table.NAME,	\
+		.hook = { .NAME = CALLBACK }		\
+	}
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
@@ -1756,10 +1805,21 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 static inline void security_delete_hooks(struct security_hook_list *hooks,
 						int count)
 {
-	int i;
+	struct lsm_static_call *scalls;
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		scalls = hooks[i].scalls;
+		for (j = 0; j < MAX_LSM_COUNT; j++) {
+			if (scalls[j].hl != &hooks[i])
+				continue;
 
-	for (i = 0; i < count; i++)
-		hlist_del_rcu(&hooks[i].list);
+			static_key_disable(scalls[j].enabled_key);
+			__static_call_update(scalls[j].key,
+					     scalls[j].trampoline, NULL);
+			scalls[j].hl = NULL;
+		}
+	}
 }
 #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
@@ -1771,5 +1831,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern int lsm_inode_alloc(struct inode *inode);
+extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index d1571900a8c7..e54d5ba187d1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,8 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <linux/static_call.h>
+#include <linux/jump_label.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -74,7 +76,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
@@ -93,6 +94,43 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
 
+/*
+ * Define static calls and static keys for each LSM hook.
+ */
+
+#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
+	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
+				*((RET(*)(__VA_ARGS__))NULL));		\
+	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	LSM_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef DEFINE_LSM_STATIC_CALL
+
+/*
+ * Initialise a table of static calls for each LSM hook.
+ * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
+ * and a trampoline (STATIC_CALL_TRAMP) which are used to call
+ * __static_call_update when updating the static call.
+ */
+struct lsm_static_calls_table static_calls_table __lsm_ro_after_init = {
+#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
+	(struct lsm_static_call) {					\
+		.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
+		.trampoline = &STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM)),\
+		.enabled_key = &SECURITY_HOOK_ENABLED_KEY(NAME, NUM).key,\
+	},
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	.NAME = {							\
+		LSM_UNROLL(INIT_LSM_STATIC_CALL, NAME)			\
+	},
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef INIT_LSM_STATIC_CALL
+};
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -153,7 +191,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (exists_ordered_lsm(lsm))
 		return;
 
-	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
 		return;
 
 	/* Enable this LSM, if it is not already set. */
@@ -318,6 +356,24 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
+static void __init lsm_static_call_init(struct security_hook_list *hl)
+{
+	struct lsm_static_call *scall = hl->scalls;
+	int i;
+
+	for (i = 0; i < MAX_LSM_COUNT; i++) {
+		/* Update the first static call that is not used yet */
+		if (!scall->hl) {
+			__static_call_update(scall->key, scall->trampoline, hl->hook.lsm_callback);
+			scall->hl = hl;
+			static_key_enable(scall->enabled_key);
+			return;
+		}
+		scall++;
+	}
+	panic("%s - No static call remaining to add LSM hook.\n", __func__);
+}
+
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
@@ -395,11 +451,6 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
-#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	INIT_HLIST_HEAD(&security_hook_heads.NAME);
-#include "linux/lsm_hook_defs.h"
-#undef LSM_HOOK
-
 	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
 		if (!lsm->enabled)
 			lsm->enabled = &lsm_enabled_true;
@@ -515,7 +566,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		lsm_static_call_init(&hooks[i]);
 	}
 
 	/*
@@ -753,28 +804,42 @@ static int lsm_superblock_alloc(struct super_block *sb)
  * call_int_hook:
  *	This is a hook that returns a value.
  */
+#define __CALL_STATIC_VOID(NUM, HOOK, ...)                                   \
+	if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
+		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);        \
+	}
 
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
+#define call_void_hook(FUNC, ...)                                 \
+	do {                                                      \
+		LSM_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__) \
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
-		}						\
-	} while (0);						\
-	RC;							\
-})
+#define __CALL_STATIC_INT(NUM, R, HOOK, ...)                                 \
+	if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
+		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
+		if (R != 0)                                                  \
+			goto out;                                            \
+	}
+
+#define call_int_hook(FUNC, IRC, ...)                                        \
+	({                                                                   \
+		__label__ out;                                               \
+		int RC = IRC;                                                \
+		do {                                                         \
+			LSM_UNROLL(__CALL_STATIC_INT, RC, FUNC, __VA_ARGS__) \
+									     \
+		} while (0);                                                 \
+out:                                                                         \
+		RC;                                                          \
+	})
+
+#define security_for_each_hook(scall, NAME, expression)                  \
+	for (scall = static_calls_table.NAME;                            \
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) { \
+		if (!static_key_enabled(scall->enabled_key))             \
+			continue;                                        \
+		(expression);                                            \
+	}
 
 /* Security operations */
 
@@ -859,7 +924,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -870,13 +935,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
-		rc = hp->hook.vm_enough_memory(mm, pages);
+	security_for_each_hook(scall, vm_enough_memory, ({
+		rc = scall->hl->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
 		}
-	}
+	}));
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -918,18 +983,17 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 int security_fs_context_parse_param(struct fs_context *fc,
 				    struct fs_parameter *param)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int trc;
 	int rc = -ENOPARAM;
 
-	hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
-			     list) {
-		trc = hp->hook.fs_context_parse_param(fc, param);
+	security_for_each_hook(scall, fs_context_parse_param, ({
+		trc = scall->hl->hook.fs_context_parse_param(fc, param);
 		if (trc == 0)
 			rc = 0;
 		else if (trc != -ENOPARAM)
 			return trc;
-	}
+	}));
 	return rc;
 }
 
@@ -1092,18 +1156,19 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const char **xattr_name, void **ctx,
 				  u32 *ctxlen)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
-		rc = hp->hook.dentry_init_security(dentry, mode, name,
+	security_for_each_hook(scall, dentry_init_security, ({
+		rc = scall->hl->hook.dentry_init_security(dentry, mode, name,
 						   xattr_name, ctx, ctxlen);
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
-	}
+	}));
+
 	return LSM_RET_DEFAULT(dentry_init_security);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
@@ -1502,7 +1567,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1510,17 +1575,17 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+	security_for_each_hook(scall, inode_getsecurity, ({
+		rc = scall->hl->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
-	}
+	}));
 	return LSM_RET_DEFAULT(inode_getsecurity);
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1528,12 +1593,11 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
-		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+	security_for_each_hook(scall, inode_setsecurity, ({
+		rc = scall->hl->hook.inode_setsecurity(inode, name, value, size, flags);
 		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
 			return rc;
-	}
+	}));
 	return LSM_RET_DEFAULT(inode_setsecurity);
 }
 
@@ -1558,7 +1622,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
 
 int security_inode_copy_up_xattr(const char *name)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
@@ -1566,12 +1630,11 @@ int security_inode_copy_up_xattr(const char *name)
 	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
 	 * any other error code incase of an error.
 	 */
-	hlist_for_each_entry(hp,
-		&security_hook_heads.inode_copy_up_xattr, list) {
-		rc = hp->hook.inode_copy_up_xattr(name);
+	security_for_each_hook(scall, inode_copy_up_xattr, ({
+		rc = scall->hl->hook.inode_copy_up_xattr(name);
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
-	}
+	}));
 
 	return LSM_RET_DEFAULT(inode_copy_up_xattr);
 }
@@ -1968,16 +2031,16 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 {
 	int thisrc;
 	int rc = LSM_RET_DEFAULT(task_prctl);
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
-		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+	security_for_each_hook(scall, task_prctl, ({
+		thisrc = scall->hl->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
 			rc = thisrc;
 			if (thisrc != 0)
 				break;
 		}
-	}
+	}));
 	return rc;
 }
 
@@ -2142,26 +2205,26 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getprocattr(struct task_struct *p, const char *lsm,
 			 const char *name, char **value)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+	security_for_each_hook(scall, getprocattr, ({
+		if (lsm != NULL && strcmp(lsm, scall->hl->lsm))
 			continue;
-		return hp->hook.getprocattr(p, name, value);
-	}
+		return scall->hl->hook.getprocattr(p, name, value);
+	}));
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+	security_for_each_hook(scall, setprocattr, ({
+		if (lsm != NULL && strcmp(lsm, scall->hl->lsm))
 			continue;
-		return hp->hook.setprocattr(name, value, size);
-	}
+		return scall->hl->hook.setprocattr(name, value, size);
+	}));
 	return LSM_RET_DEFAULT(setprocattr);
 }
 
@@ -2178,18 +2241,18 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Currently, only one LSM can implement secid_to_secctx (i.e this
 	 * LSM hook is not "stackable").
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
-		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
+	security_for_each_hook(scall, secid_to_secctx, ({
+		rc = scall->hl->hook.secid_to_secctx(secid, secdata, seclen);
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
-	}
+	}));
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
 }
@@ -2582,7 +2645,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
 
 	/*
@@ -2594,11 +2657,10 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
+	security_for_each_hook(scall, xfrm_state_pol_flow_match, ({
+		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
 		break;
-	}
+	}));
 	return rc;
 }
 
-- 
2.39.0.246.g2a6d74b583-goog

