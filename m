Return-Path: <bpf+bounces-34319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F892C6E2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EA9B212B2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116328F5;
	Wed, 10 Jul 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSopmK2j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453EA32;
	Wed, 10 Jul 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569937; cv=none; b=MkWJXDa7cI1m0F8TfMF7FlM/R7xsJ9nbpAYHo2ipfjBCapvg8mPoSI2ZQWjWqKcgWtOizIkBaJ2+OmlB0wqX3y0PhuhFxSbI+k3iadnXSyWDJXxwvrzgD0m+O1rQBic6oJCZilF2BToSM4TSM4s3bDfXXYLElBiPTqUpMirBsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569937; c=relaxed/simple;
	bh=AAjHimze7D4rqRCj9W+LjTgLgqdJ+yB9uXDyl8i7xSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3ql533x8i9lBgMgAvPECuFEEo44nh3WK0IKGwU4m9dpjc5sJH2rP7fvI9c+h47O+LsfuAZAOnM2mnC2nUG3d0ibS4Ys1T1Ky/m8iDdJxWI4/2LzLeibYtupEfr6qYOdNhFWcuLbecunONdmEou/4TXRczwMZQgfr0rodP5aEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSopmK2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86380C4AF0C;
	Wed, 10 Jul 2024 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720569936;
	bh=AAjHimze7D4rqRCj9W+LjTgLgqdJ+yB9uXDyl8i7xSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSopmK2jXCcaTggNtXbUhepvDu5RzOGierFL7dBaqO2kJVQpMtcu7hK080Wu1W8XC
	 G13XxB1QlZYmTDYhH02Tri7z0Mm+70s17MRdiS0DT4NUJxCs/o5vGTATDGUkou7Dp5
	 INEOlZvyEjcIiraAH5zPvfhgYJ+T8vP4XPqjasesWNI80P0Vm3QGC5F9u/Naamvwmi
	 kTLBYcJZwZm5x3MBl8zomHih2Od20eY9y74p9g0OT7GYL50s/OFSJcxpztR8Wtzrm/
	 d5mM5OYe7+koGsMmo5GDn1uB8Xi6t0frZPg2dpIrsQwtxZARyfpSBxkjR4BD3K9BzV
	 00FksYhOVG0QQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	andrii@kernel.org,
	keescook@chromium.org,
	daniel@iogearbox.net,
	renauld@google.com,
	revest@chromium.org,
	song@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v14 3/3] security: Replace indirect LSM hook calls with static calls
Date: Wed, 10 Jul 2024 02:05:00 +0200
Message-ID: <20240710000500.208154-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240710000500.208154-1-kpsingh@kernel.org>
References: <20240710000500.208154-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LSM hooks are currently invoked from a linked list as indirect calls
which are invoked using retpolines as a mitigation for speculative
attacks (Branch History / Target injection) and add extra overhead which
is especially bad in kernel hot paths:

security_file_ioctl:
   0xff...0320 <+0>:	endbr64
   0xff...0324 <+4>:	push   %rbp
   0xff...0325 <+5>:	push   %r15
   0xff...0327 <+7>:	push   %r14
   0xff...0329 <+9>:	push   %rbx
   0xff...032a <+10>:	mov    %rdx,%rbx
   0xff...032d <+13>:	mov    %esi,%ebp
   0xff...032f <+15>:	mov    %rdi,%r14
   0xff...0332 <+18>:	mov    $0xff...7030,%r15
   0xff...0339 <+25>:	mov    (%r15),%r15
   0xff...033c <+28>:	test   %r15,%r15
   0xff...033f <+31>:	je     0xff...0358 <security_file_ioctl+56>
   0xff...0341 <+33>:	mov    0x18(%r15),%r11
   0xff...0345 <+37>:	mov    %r14,%rdi
   0xff...0348 <+40>:	mov    %ebp,%esi
   0xff...034a <+42>:	mov    %rbx,%rdx

   0xff...034d <+45>:	call   0xff...2e0 <__x86_indirect_thunk_array+352>
   			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    Indirect calls that use retpolines leading to overhead, not just due
    to extra instruction but also branch misses.

   0xff...0352 <+50>:	test   %eax,%eax
   0xff...0354 <+52>:	je     0xff...0339 <security_file_ioctl+25>
   0xff...0356 <+54>:	jmp    0xff...035a <security_file_ioctl+58>
   0xff...0358 <+56>:	xor    %eax,%eax
   0xff...035a <+58>:	pop    %rbx
   0xff...035b <+59>:	pop    %r14
   0xff...035d <+61>:	pop    %r15
   0xff...035f <+63>:	pop    %rbp
   0xff...0360 <+64>:	jmp    0xff...47c4 <__x86_return_thunk>

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
   0xff...0ca0 <+0>:	endbr64
   0xff...0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
   0xff...0ca9 <+9>:	push   %rbp
   0xff...0caa <+10>:	push   %r14
   0xff...0cac <+12>:	push   %rbx
   0xff...0cad <+13>:	mov    %rdx,%rbx
   0xff...0cb0 <+16>:	mov    %esi,%ebp
   0xff...0cb2 <+18>:	mov    %rdi,%r14
   0xff...0cb5 <+21>:	jmp    0xff...0cc7 <security_file_ioctl+39>
  			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Static key enabled for SELinux

   0xffffffff818f0cb7 <+23>:	jmp    0xff...0cde <security_file_ioctl+62>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   Static key enabled for BPF LSM. This is something that is changed to
   default to false to avoid the existing side effect issues of BPF LSM
   [1] in a subsequent patch.

   0xff...0cb9 <+25>:	xor    %eax,%eax
   0xff...0cbb <+27>:	xchg   %ax,%ax
   0xff...0cbd <+29>:	pop    %rbx
   0xff...0cbe <+30>:	pop    %r14
   0xff...0cc0 <+32>:	pop    %rbp
   0xff...0cc1 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
   0xff...0cc7 <+39>:	endbr64
   0xff...0ccb <+43>:	mov    %r14,%rdi
   0xff...0cce <+46>:	mov    %ebp,%esi
   0xff...0cd0 <+48>:	mov    %rbx,%rdx
   0xff...0cd3 <+51>:	call   0xff...3230 <selinux_file_ioctl>
   			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Direct call to SELinux.

   0xff...0cd8 <+56>:	test   %eax,%eax
   0xff...0cda <+58>:	jne    0xff...0cbd <security_file_ioctl+29>
   0xff...0cdc <+60>:	jmp    0xff...0cb7 <security_file_ioctl+23>
   0xff...0cde <+62>:	endbr64
   0xff...0ce2 <+66>:	mov    %r14,%rdi
   0xff...0ce5 <+69>:	mov    %ebp,%esi
   0xff...0ce7 <+71>:	mov    %rbx,%rdx
   0xff...0cea <+74>:	call   0xff...e220 <bpf_lsm_file_ioctl>
   			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Direct call to BPF LSM.

   0xff...0cef <+79>:	test   %eax,%eax
   0xff...0cf1 <+81>:	jne    0xff...0cbd <security_file_ioctl+29>
   0xff...0cf3 <+83>:	jmp    0xff...0cb9 <security_file_ioctl+25>
   0xff...0cf5 <+85>:	endbr64
   0xff...0cf9 <+89>:	mov    %r14,%rdi
   0xff...0cfc <+92>:	mov    %ebp,%esi
   0xff...0cfe <+94>:	mov    %rbx,%rdx
   0xff...0d01 <+97>:	pop    %rbx
   0xff...0d02 <+98>:	pop    %r14
   0xff...0d04 <+100>:	pop    %rbp
   0xff...0d05 <+101>:	ret
   0xff...0d06 <+102>:	int3
   0xff...0d07 <+103>:	int3
   0xff...0d08 <+104>:	int3
   0xff...0d09 <+105>:	int3

While this patch uses static_branch_unlikely indicating that an LSM hook
is likely to be not present. In most cases this is still a better choice
as even when an LSM with one hook is added, empty slots are created for
all LSM hooks (especially when many LSMs that do not initialize most
hooks are present on the system).

There are some hooks that don't use the call_int_hook or
call_void_hook. These hooks are updated to use a new macro called
lsm_for_each_hook where the lsm_callback is directly invoked as an
indirect call.

Below are results of the relevant Unixbench system benchmarks with BPF LSM
and SELinux enabled with default policies enabled with and without these
patches.

Benchmark                                               Delta(%): (+ is better)
===============================================================================
Execl Throughput                                             +1.9356
File Write 1024 bufsize 2000 maxblocks                       +6.5953
Pipe Throughput                                              +9.5499
Pipe-based Context Switching                                 +3.0209
Process Creation                                             +2.3246
Shell Scripts (1 concurrent)                                 +1.4975
System Call Overhead                                         +2.7815
System Benchmarks Index Score (Partial Only):                +3.4859

In the best case, some syscalls like eventfd_create benefitted to about ~10%.

[1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hooks.h |  53 ++++++++--
 security/security.c       | 215 ++++++++++++++++++++++++++------------
 2 files changed, 195 insertions(+), 73 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index efd4a0655159..7d281a48da9d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -30,19 +30,47 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 #include <linux/xattr.h>
+#include <linux/static_call.h>
+#include <linux/unroll.h>
+#include <linux/jump_label.h>
+#include <linux/lsm_count.h>
 
 union security_list_options {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
 	#include "lsm_hook_defs.h"
 	#undef LSM_HOOK
+	void *lsm_func_addr;
 };
 
-struct security_hook_heads {
-	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
-	#include "lsm_hook_defs.h"
-	#undef LSM_HOOK
+/*
+ * @key: static call key as defined by STATIC_CALL_KEY
+ * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
+ * @hl: The security_hook_list as initialized by the owning LSM.
+ * @active: Enabled when the static call has an LSM hook associated.
+ */
+struct lsm_static_call {
+	struct static_call_key *key;
+	void *trampoline;
+	struct security_hook_list *hl;
+	/* this needs to be true or false based on what the key defaults to */
+	struct static_key_false *active;
 } __randomize_layout;
 
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
+	#undef LSM_HOOK
+} __packed __randomize_layout;
+
 /**
  * struct lsm_id - Identify a Linux Security Module.
  * @lsm: name of the LSM, must be approved by the LSM maintainers
@@ -58,10 +86,14 @@ struct lsm_id {
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
 	const struct lsm_id		*lsmid;
 } __randomize_layout;
@@ -111,10 +143,12 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
  * care of the common case and reduces the amount of
  * text involved.
  */
-#define LSM_HOOK_INIT(HEAD, HOOK) \
-	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
+#define LSM_HOOK_INIT(NAME, HOOK)			\
+	{						\
+		.scalls = static_calls_table.NAME,	\
+		.hook = { .NAME = HOOK }		\
+	}
 
-extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
@@ -152,5 +186,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__aligned(sizeof(unsigned long))
 
 extern int lsm_inode_alloc(struct inode *inode);
+extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 9c3fb2f60e2a..2fea313d72b3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
 #include <linux/overflow.h>
 #include <net/flow.h>
 #include <net/sock.h>
+#include <linux/static_call.h>
+#include <linux/jump_label.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -54,6 +56,25 @@
 	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
 
+#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
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
+#define LSM_LOOP_UNROLL(M, ...) 		\
+do {						\
+	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
+} while (0)
+
+#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
+
 /*
  * These are descriptions of the reasons that can be passed to the
  * security_locked_down() LSM hook. Placing this array here allows
@@ -93,7 +114,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-struct security_hook_heads security_hook_heads __ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
@@ -112,6 +132,49 @@ static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
 
+#ifdef CONFIG_HAVE_STATIC_CALL
+#define LSM_HOOK_TRAMP(NAME, NUM) \
+	&STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM))
+#else
+#define LSM_HOOK_TRAMP(NAME, NUM) NULL
+#endif
+
+/*
+ * Define static calls and static keys for each LSM hook.
+ */
+#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
+	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
+				*((RET(*)(__VA_ARGS__))NULL));		\
+	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
+
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
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
+struct lsm_static_calls_table static_calls_table __ro_after_init = {
+#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
+	(struct lsm_static_call) {					\
+		.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
+		.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
+		.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
+	},
+#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
+	.NAME = {							\
+		LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
+	},
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef INIT_LSM_STATIC_CALL
+};
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -172,7 +235,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (exists_ordered_lsm(lsm))
 		return;
 
-	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
 		return;
 
 	/* Enable this LSM, if it is not already set. */
@@ -352,6 +415,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
+			__static_call_update(scall->key, scall->trampoline,
+					     hl->hook.lsm_func_addr);
+			scall->hl = hl;
+			static_branch_enable(scall->active);
+			return;
+		}
+		scall++;
+	}
+	panic("%s - Ran out of static slots.\n", __func__);
+}
+
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
@@ -432,11 +514,6 @@ int __init early_security_init(void)
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
@@ -564,7 +641,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		lsm_static_call_init(&hooks[i]);
 	}
 
 	/*
@@ -856,29 +933,43 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
  * call_int_hook:
  *	This is a hook that returns a value.
  */
+#define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
+do {									     \
+	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
+		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
+	}								     \
+} while (0);
 
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
+#define call_void_hook(HOOK, ...)                                 \
+	do {                                                      \
+		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, HOOK, __VA_ARGS__); \
 	} while (0)
 
-#define call_int_hook(FUNC, ...) ({				\
-	int RC = LSM_RET_DEFAULT(FUNC);				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != LSM_RET_DEFAULT(FUNC))	\
-				break;				\
-		}						\
-	} while (0);						\
-	RC;							\
+
+#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
+do {									     \
+	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
+		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
+		if (R != LSM_RET_DEFAULT(HOOK))				     \
+			goto LABEL;					     \
+	}								     \
+} while (0);
+
+#define call_int_hook(HOOK, ...)					\
+({									\
+	__label__ OUT;							\
+	int RC = LSM_RET_DEFAULT(HOOK);					\
+									\
+	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, HOOK, OUT, __VA_ARGS__);	\
+OUT:									\
+	RC;								\
 })
 
+#define lsm_for_each_hook(scall, NAME)					\
+	for (scall = static_calls_table.NAME;				\
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
+		if (static_key_enabled(&scall->active->key))
+
 /* Security operations */
 
 /**
@@ -1113,7 +1204,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -1124,8 +1215,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
-		rc = hp->hook.vm_enough_memory(mm, pages);
+	lsm_for_each_hook(scall, vm_enough_memory) {
+		rc = scall->hl->hook.vm_enough_memory(mm, pages);
 		if (rc <= 0) {
 			cap_sys_admin = 0;
 			break;
@@ -1272,13 +1363,12 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
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
+	lsm_for_each_hook(scall, fs_context_parse_param) {
+		trc = scall->hl->hook.fs_context_parse_param(fc, param);
 		if (trc == 0)
 			rc = 0;
 		else if (trc != -ENOPARAM)
@@ -1508,12 +1598,11 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 			     unsigned long kern_flags,
 			     unsigned long *set_kern_flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
 
-	hlist_for_each_entry(hp, &security_hook_heads.sb_set_mnt_opts,
-			     list) {
-		rc = hp->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
+	lsm_for_each_hook(scall, sb_set_mnt_opts) {
+		rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
 					      set_kern_flags);
 		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
 			break;
@@ -1708,7 +1797,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
@@ -1726,9 +1815,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 			return -ENOMEM;
 	}
 
-	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
-			     list) {
-		ret = hp->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+	lsm_for_each_hook(scall, inode_init_security) {
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
 						  &xattr_count);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
@@ -3560,10 +3648,10 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 {
 	int thisrc;
 	int rc = LSM_RET_DEFAULT(task_prctl);
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
-		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
+	lsm_for_each_hook(scall, task_prctl) {
+		thisrc = scall->hl->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != LSM_RET_DEFAULT(task_prctl)) {
 			rc = thisrc;
 			if (thisrc != 0)
@@ -3969,7 +4057,7 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 __user *size, u32 flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
 	u32 entrysize;
@@ -4007,13 +4095,13 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 	 * In the usual case gather all the data from the LSMs.
 	 * In the single case only get the data from the LSM specified.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
-		if (single && lctx.id != hp->lsmid->id)
+	lsm_for_each_hook(scall, getselfattr) {
+		if (single && lctx.id != scall->hl->lsmid->id)
 			continue;
 		entrysize = left;
 		if (base)
 			uctx = (struct lsm_ctx __user *)(base + total);
-		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
+		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
 		if (rc == -EOPNOTSUPP) {
 			rc = 0;
 			continue;
@@ -4062,7 +4150,7 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 u32 size, u32 flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct lsm_ctx *lctx;
 	int rc = LSM_RET_DEFAULT(setselfattr);
 	u64 required_len;
@@ -4085,9 +4173,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		goto free_out;
 	}
 
-	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
-		if ((hp->lsmid->id) == lctx->id) {
-			rc = hp->hook.setselfattr(attr, lctx, size, flags);
+	lsm_for_each_hook(scall, setselfattr)
+		if ((scall->hl->lsmid->id) == lctx->id) {
+			rc = scall->hl->hook.setselfattr(attr, lctx, size, flags);
 			break;
 		}
 
@@ -4110,12 +4198,12 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsmid != 0 && lsmid != hp->lsmid->id)
+	lsm_for_each_hook(scall, getprocattr) {
+		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
 			continue;
-		return hp->hook.getprocattr(p, name, value);
+		return scall->hl->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
@@ -4134,12 +4222,12 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
  */
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 
-	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsmid != 0 && lsmid != hp->lsmid->id)
+	lsm_for_each_hook(scall, setprocattr) {
+		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
 			continue;
-		return hp->hook.setprocattr(name, value, size);
+		return scall->hl->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
 }
@@ -5257,7 +5345,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
 
 	/*
@@ -5269,9 +5357,8 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-			     list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
+	lsm_for_each_hook(scall, xfrm_state_pol_flow_match) {
+		rc = scall->hl->hook.xfrm_state_pol_flow_match(x, xp, flic);
 		break;
 	}
 	return rc;
-- 
2.45.2.803.g4e1b14247a-goog


