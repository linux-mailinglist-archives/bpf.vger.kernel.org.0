Return-Path: <bpf+bounces-21404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E384CAE2
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 13:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F841C25D27
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925B76C64;
	Wed,  7 Feb 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdEfJklK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154076036;
	Wed,  7 Feb 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310172; cv=none; b=JBqR0kDwgmpIXTEjsUhOiYXLYW5nwz0mFjwXkezDKPcL25fcMt8qf1CnEMR+lvi2CRV9dNnqGcwVytrTvNMmFoGbkCLO0Pkwi5EokXYuMvcO2f59DUrX5EmVxvX0qycAszmgU666MNsEESSEgftFO1sUyVRQoWCdHR6SENfPulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310172; c=relaxed/simple;
	bh=KtDJkbYf/Lq6LPVQYTs27z2jfhXiCHzq9y502CuPEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov65oLOIvtpv4JJDtJ2/Qd0/6QYrJMTcuM2JbcSNJszTiUw8WPdzkUtX+lZ7b4mbA1BfBIPl8e2KpVq6j4s3pWaIelLpT1UNq771myYnDLgQm17J01Jcr+yGXlQTZblEFOX4h8+Tfbq4MuHjbqZz0Sh92/EpxCbAI4SluGLcdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdEfJklK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B93C43390;
	Wed,  7 Feb 2024 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707310171;
	bh=KtDJkbYf/Lq6LPVQYTs27z2jfhXiCHzq9y502CuPEy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdEfJklK6y/QWIfv2LHmv/el5Qwkf6QRAt0GeaNoReLPj+wySjD0VD8NB9TWJAP2k
	 aNA0s3o2EXH3LkN6arcAse9ewDRhs5Fd6h4embXiiYjBnhkwbTSel2rNwzNJwpBtKd
	 CWAmX7QFyLRrW6weUQIuqtrtcGdeuCb4kFnvvEND0JvB7jOqLuLE6oo75SnYONRUzR
	 SlAjG3tLU/QHCnnkJTu9ltmSEdWRpN7xFsERfQTEQ2Gocs4pfgvjUHGgYMJ+MMNKm/
	 0EvtCvuEhZWU5LcKJzaIKW1zOR1UDQRTjTYkrF2ycLrDyvHsVgc+Mdoe8qXUfK5EY4
	 cLGJ6ENeY2fdA==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	kpsingh@kernel.org
Subject: [PATCH v9 3/4] security: Replace indirect LSM hook calls with static calls
Date: Wed,  7 Feb 2024 13:49:17 +0100
Message-ID: <20240207124918.3498756-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207124918.3498756-1-kpsingh@kernel.org>
References: <20240207124918.3498756-1-kpsingh@kernel.org>
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

   0xffffffff814f034d <+45>:	call   0xffffffff81f742e0 <__x86_indirect_thunk_array+352>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
   0xffffffff818f0ca0 <+0>:	endbr64
   0xffffffff818f0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
   0xffffffff818f0ca9 <+9>:	push   %rbp
   0xffffffff818f0caa <+10>:	push   %r14
   0xffffffff818f0cac <+12>:	push   %rbx
   0xffffffff818f0cad <+13>:	mov    %rdx,%rbx
   0xffffffff818f0cb0 <+16>:	mov    %esi,%ebp
   0xffffffff818f0cb2 <+18>:	mov    %rdi,%r14
   0xffffffff818f0cb5 <+21>:	jmp    0xffffffff818f0cc7 <security_file_ioctl+39>
  				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Static key enabled for SELinux

   0xffffffff818f0cb7 <+23>:	jmp    0xffffffff818f0cde <security_file_ioctl+62>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   Static key enabled for BPF LSM. This is something that is changed to
   default to false to avoid the existing side effect issues of BPF LSM
   [1] in a subsequent patch.

   0xffffffff818f0cb9 <+25>:	xor    %eax,%eax
   0xffffffff818f0cbb <+27>:	xchg   %ax,%ax
   0xffffffff818f0cbd <+29>:	pop    %rbx
   0xffffffff818f0cbe <+30>:	pop    %r14
   0xffffffff818f0cc0 <+32>:	pop    %rbp
   0xffffffff818f0cc1 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
   0xffffffff818f0cc7 <+39>:	endbr64
   0xffffffff818f0ccb <+43>:	mov    %r14,%rdi
   0xffffffff818f0cce <+46>:	mov    %ebp,%esi
   0xffffffff818f0cd0 <+48>:	mov    %rbx,%rdx
   0xffffffff818f0cd3 <+51>:	call   0xffffffff81903230 <selinux_file_ioctl>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Direct call to SELinux.

   0xffffffff818f0cd8 <+56>:	test   %eax,%eax
   0xffffffff818f0cda <+58>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
   0xffffffff818f0cdc <+60>:	jmp    0xffffffff818f0cb7 <security_file_ioctl+23>
   0xffffffff818f0cde <+62>:	endbr64
   0xffffffff818f0ce2 <+66>:	mov    %r14,%rdi
   0xffffffff818f0ce5 <+69>:	mov    %ebp,%esi
   0xffffffff818f0ce7 <+71>:	mov    %rbx,%rdx
   0xffffffff818f0cea <+74>:	call   0xffffffff8141e220 <bpf_lsm_file_ioctl>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   Direct call to BPF LSM.

   0xffffffff818f0cef <+79>:	test   %eax,%eax
   0xffffffff818f0cf1 <+81>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
   0xffffffff818f0cf3 <+83>:	jmp    0xffffffff818f0cb9 <security_file_ioctl+25>
   0xffffffff818f0cf5 <+85>:	endbr64
   0xffffffff818f0cf9 <+89>:	mov    %r14,%rdi
   0xffffffff818f0cfc <+92>:	mov    %ebp,%esi
   0xffffffff818f0cfe <+94>:	mov    %rbx,%rdx
   0xffffffff818f0d01 <+97>:	pop    %rbx
   0xffffffff818f0d02 <+98>:	pop    %r14
   0xffffffff818f0d04 <+100>:	pop    %rbp
   0xffffffff818f0d05 <+101>:	ret
   0xffffffff818f0d06 <+102>:	int3
   0xffffffff818f0d07 <+103>:	int3
   0xffffffff818f0d08 <+104>:	int3
   0xffffffff818f0d09 <+105>:	int3

While this patch uses static_branch_unlikely indicating that an LSM hook
is likely to be not present, a subsequent makes it configurable. In most
cases this is still a better choice as even when an LSM with one hook is
added, empty slots are created for all LSM hooks (especially when many
LSMs that do not initialize most hooks are present on the system).

There are some hooks that don't use the call_int_hook and
call_void_hook. These hooks are updated to use a new macro called
security_for_each_hook where the lsm_callback is directly invoked as an
indirect call. Currently, there are no performance sensitive hooks that
use the security_for_each_hook macro. However, if, some performance
sensitive hooks are discovered, these can be updated to use static calls
with loop unrolling as well using a custom macro.

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

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hooks.h |  70 +++++++++--
 security/security.c       | 244 ++++++++++++++++++++++++--------------
 2 files changed, 216 insertions(+), 98 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a2ade0ffe9e7..ba63d8b54448 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -30,16 +30,63 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 #include <linux/xattr.h>
+#include <linux/static_call.h>
+#include <linux/unroll.h>
+#include <linux/jump_label.h>
+#include <linux/lsm_count.h>
+
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
 
 union security_list_options {
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
+ * @active: Enabled when the static call has an LSM hook associated.
+ */
+struct lsm_static_call {
+	struct static_call_key *key;
+	void *trampoline;
+	struct security_hook_list *hl;
+	/* this needs to be true or false based on what the key defaults to */
+	struct static_key_false *active;
+} __randomize_layout;
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
 
@@ -58,10 +105,14 @@ struct lsm_id {
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
@@ -110,10 +161,12 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
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
@@ -151,5 +204,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 		__aligned(sizeof(unsigned long))
 
 extern int lsm_inode_alloc(struct inode *inode);
+extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..e05d2157c95a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,6 +30,8 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <linux/static_call.h>
+#include <linux/jump_label.h>
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
@@ -91,7 +93,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-struct security_hook_heads security_hook_heads __ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
 static struct kmem_cache *lsm_file_cache;
@@ -110,6 +111,51 @@ static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
 static __initdata struct lsm_info **ordered_lsms;
 static __initdata struct lsm_info *exclusive;
 
+
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
+
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
@@ -170,7 +216,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	if (exists_ordered_lsm(lsm))
 		return;
 
-	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
 		return;
 
 	/* Enable this LSM, if it is not already set. */
@@ -349,6 +395,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
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
+					     hl->hook.lsm_callback);
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
 
@@ -428,11 +493,6 @@ int __init early_security_init(void)
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
@@ -560,7 +620,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsmid = lsmid;
-		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		lsm_static_call_init(&hooks[i]);
 	}
 
 	/*
@@ -846,29 +906,41 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
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
+#define call_void_hook(FUNC, ...)                                 \
+	do {                                                      \
+		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__); \
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
+#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
+do {									     \
+	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
+		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
+		if (R != 0)						     \
+			goto LABEL;					     \
+	}								     \
+} while (0);
+
+#define call_int_hook(FUNC, IRC, ...)					\
+({									\
+	__label__ out;							\
+	int RC = IRC;							\
+	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__);	\
+out:									\
+	RC;								\
 })
 
+#define lsm_for_each_hook(scall, NAME)					\
+	for (scall = static_calls_table.NAME;				\
+	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
+		if (static_key_enabled(&scall->active->key))
+
 /* Security operations */
 
 /**
@@ -1104,7 +1176,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int cap_sys_admin = 1;
 	int rc;
 
@@ -1115,8 +1187,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
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
@@ -1268,13 +1340,12 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
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
@@ -1637,19 +1708,19 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const char **xattr_name, void **ctx,
 				  u32 *ctxlen)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
-			     list) {
-		rc = hp->hook.dentry_init_security(dentry, mode, name,
+	lsm_for_each_hook(scall, dentry_init_security) {
+		rc = scall->hl->hook.dentry_init_security(dentry, mode, name,
 						   xattr_name, ctx, ctxlen);
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
 			return rc;
 	}
+
 	return LSM_RET_DEFAULT(dentry_init_security);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
@@ -1709,7 +1780,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
@@ -1727,9 +1798,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
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
@@ -2489,7 +2559,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -2497,9 +2567,8 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(idmap, inode, name, buffer,
-						alloc);
+	lsm_for_each_hook(scall, inode_getsecurity) {
+		rc = scall->hl->hook.inode_getsecurity(idmap, inode, name, buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
@@ -2524,7 +2593,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
 int security_inode_setsecurity(struct inode *inode, const char *name,
 			       const void *value, size_t size, int flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -2532,9 +2601,8 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
-		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-						flags);
+	lsm_for_each_hook(scall, inode_setsecurity) {
+		rc = scall->hl->hook.inode_setsecurity(inode, name, value, size, flags);
 		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
 			return rc;
 	}
@@ -2608,7 +2676,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
  */
 int security_inode_copy_up_xattr(const char *name)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
@@ -2616,9 +2684,8 @@ int security_inode_copy_up_xattr(const char *name)
 	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
 	 * any other error code in case of an error.
 	 */
-	hlist_for_each_entry(hp,
-			     &security_hook_heads.inode_copy_up_xattr, list) {
-		rc = hp->hook.inode_copy_up_xattr(name);
+	lsm_for_each_hook(scall, inode_copy_up_xattr) {
+		rc = scall->hl->hook.inode_copy_up_xattr(name);
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
 	}
@@ -3510,10 +3577,10 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
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
@@ -3919,7 +3986,7 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 size_t __user *size, u32 flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
 	size_t total = 0;
@@ -3957,13 +4024,13 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4012,7 +4079,7 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 			 size_t size, u32 flags)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	struct lsm_ctx *lctx;
 	int rc = LSM_RET_DEFAULT(setselfattr);
 
@@ -4033,9 +4100,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
 
@@ -4058,12 +4125,12 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
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
@@ -4082,12 +4149,12 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
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
@@ -4139,15 +4206,15 @@ EXPORT_SYMBOL(security_ismaclabel);
  */
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
+	lsm_for_each_hook(scall, secid_to_secctx) {
+		rc = scall->hl->hook.secid_to_secctx(secid, secdata, seclen);
 		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
 			return rc;
 	}
@@ -4255,14 +4322,14 @@ EXPORT_SYMBOL(security_inode_setsecctx);
  */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
-		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
+	lsm_for_each_hook(scall, inode_getsecctx) {
+		rc = scall->hl->hook.inode_getsecctx(inode, ctx, ctxlen);
 		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
 			return rc;
 	}
@@ -4624,15 +4691,14 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
-			     list) {
-		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+	lsm_for_each_hook(scall, socket_getpeersec_stream) {
+		rc = scall->hl->hook.socket_getpeersec_stream(sock, optval, optlen,
 						       len);
 		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
 			return rc;
@@ -4657,15 +4723,14 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc;
 
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
-			     list) {
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+	lsm_for_each_hook(scall, socket_getpeersec_dgram) {
+		rc = scall->hl->hook.socket_getpeersec_dgram(sock, skb, secid);
 		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
 			return rc;
 	}
@@ -5225,7 +5290,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
 {
-	struct security_hook_list *hp;
+	struct lsm_static_call *scall;
 	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
 
 	/*
@@ -5237,9 +5302,8 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
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
2.43.0.594.gd9cf4e227d-goog


