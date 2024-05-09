Return-Path: <bpf+bounces-29305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC38C1760
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24351C21BBF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE486136;
	Thu,  9 May 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ0I7lmB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A543285C56;
	Thu,  9 May 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285681; cv=none; b=WhvQOE3fZjMb/QY8y3nzFpv+55m5e8HU31lX7lMYPZAIhZVf95vSvtapCwpspYKNuvkr01sFInfcV+fmATiTT8vIM3/1MPJ4X0KhdYjcPN21307LwEs3dvwq0hdy98U+SF8n8fCwnNkDTDcWv8R0y3jv0M9lOYaAvD6qjA4N9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285681; c=relaxed/simple;
	bh=vBsvI+zRIXa0cHyPWrI6yMj/SgRO+A/tKlhrJSCZEA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHPP5S+eIUydngHEqAyaxqZpV6cQ3aZtvex+QXnVG8GrrsDC873fcc545gt8dosDJoOwo3oCEOwJGxiLqgOBu1WUj+jIOGdyKoEDX5wr2or3m3CrRVegCzGEr+qaTEz/JvJHt2JdrY2JcbicisKLX0U73gJYSUy4tE8BJIc82Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ0I7lmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E0DC3277B;
	Thu,  9 May 2024 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715285681;
	bh=vBsvI+zRIXa0cHyPWrI6yMj/SgRO+A/tKlhrJSCZEA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZ0I7lmB3ojelJTaPcYRmmC3VO6Kmm9s0sFXWXMNOeA6LkKdUBnRhHpcKxlj77muh
	 5Fy+4b7xrgjxJ4JO9V5r8CysPoyV9QlAHdFh6RjkCBX0KewpGnvCJL4zjSkFOhqtCb
	 KrsipEargc1WFdM7h8Wk3VQ/T/7ds7od4xmcWYuojrY7LC6mY19t1W5h+hFB9E1ZrR
	 85rwOb0eVn846HKZPmEljN7Y/Tjit3dUR0bWJR93FDFa3vjYe1gYztJaM0nWkvyWLq
	 zNIR2mH20PjoDk/GW5rJ4rMW4V/ZyPDKopzSF096fruHYdJ4LGe0wvf/i7fzUTByJz
	 WbbjmbjLTNxOQ==
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
Subject: [PATCH v11 5/5] bpf: Only enable BPF LSM hooks when an LSM program is attached
Date: Thu,  9 May 2024 22:14:21 +0200
Message-ID: <20240509201421.905965-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
In-Reply-To: <20240509201421.905965-1-kpsingh@kernel.org>
References: <20240509201421.905965-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF LSM hooks have side-effects (even when a default value's returned)
as some hooks end up behaving differently due to the very presence of
the hook.

The static keys guarding the BPF LSM hooks are disabled by default and
enabled only when a BPF program is attached implementing the hook
logic. This avoids the issue of the side-effects and also the minor
overhead associated with the empty callback.

security_file_ioctl:
   0xff...0e30 <+0>:	endbr64
   0xff...0e34 <+4>:	nopl   0x0(%rax,%rax,1)
   0xff...0e39 <+9>:	push   %rbp
   0xff...0e3a <+10>:	push   %r14
   0xff...0e3c <+12>:	push   %rbx
   0xff...0e3d <+13>:	mov    %rdx,%rbx
   0xff...0e40 <+16>:	mov    %esi,%ebp
   0xff...0e42 <+18>:	mov    %rdi,%r14
   0xff...0e45 <+21>:	jmp    0xff...0e57 <security_file_ioctl+39>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   Static key enabled for SELinux

   0xff...0e47 <+23>:	xchg   %ax,%ax
   			^^^^^^^^^^^^^^

   Static key disabled for BPF. This gets patched when a BPF LSM
   program is attached

   0xff...0e49 <+25>:	xor    %eax,%eax
   0xff...0e4b <+27>:	xchg   %ax,%ax
   0xff...0e4d <+29>:	pop    %rbx
   0xff...0e4e <+30>:	pop    %r14
   0xff...0e50 <+32>:	pop    %rbp
   0xff...0e51 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
   0xff...0e57 <+39>:	endbr64
   0xff...0e5b <+43>:	mov    %r14,%rdi
   0xff...0e5e <+46>:	mov    %ebp,%esi
   0xff...0e60 <+48>:	mov    %rbx,%rdx
   0xff...0e63 <+51>:	call   0xff...33c0 <selinux_file_ioctl>
   0xff...0e68 <+56>:	test   %eax,%eax
   0xff...0e6a <+58>:	jne    0xff...0e4d <security_file_ioctl+29>
   0xff...0e6c <+60>:	jmp    0xff...0e47 <security_file_ioctl+23>
   0xff...0e6e <+62>:	endbr64
   0xff...0e72 <+66>:	mov    %r14,%rdi
   0xff...0e75 <+69>:	mov    %ebp,%esi
   0xff...0e77 <+71>:	mov    %rbx,%rdx
   0xff...0e7a <+74>:	call   0xff...e3b0 <bpf_lsm_file_ioctl>
   0xff...0e7f <+79>:	test   %eax,%eax
   0xff...0e81 <+81>:	jne    0xff...0e4d <security_file_ioctl+29>
   0xff...0e83 <+83>:	jmp    0xff...0e49 <security_file_ioctl+25>
   0xff...0e85 <+85>:	endbr64
   0xff...0e89 <+89>:	mov    %r14,%rdi
   0xff...0e8c <+92>:	mov    %ebp,%esi
   0xff...0e8e <+94>:	mov    %rbx,%rdx
   0xff...0e91 <+97>:	pop    %rbx
   0xff...0e92 <+98>:	pop    %r14
   0xff...0e94 <+100>:	pop    %rbp
   0xff...0e95 <+101>:	ret

This patch enables this by providing a LSM_HOOK_INIT_TOGGLEABLE
variant which allows the LSMs to opt-in to toggleable hooks which can
be toggled on/off with security_toogle_hook.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
 kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
 security/bpf/hooks.c      |  2 +-
 security/security.c       | 37 +++++++++++++++++++++++++++++++++++-
 4 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5db244308c92..5c0918ed6b80 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -110,11 +110,14 @@ struct lsm_id {
  * @scalls: The beginning of the array of static calls assigned to this hook.
  * @hook: The callback for the hook.
  * @lsm: The name of the lsm that owns this hook.
+ * @default_state: The state of the LSM hook when initialized. If set to false,
+ * the static key guarding the hook will be set to disabled.
  */
 struct security_hook_list {
 	struct lsm_static_call	*scalls;
 	union security_list_options	hook;
 	const struct lsm_id		*lsmid;
+	bool				toggleable;
 } __randomize_layout;
 
 /*
@@ -164,7 +167,19 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 #define LSM_HOOK_INIT(NAME, HOOK)			\
 	{						\
 		.scalls = static_calls_table.NAME,	\
-		.hook = { .NAME = HOOK }		\
+		.hook = { .NAME = HOOK },		\
+		.toggleable = false			\
+	}
+
+/*
+ * Toggleable LSM hooks are enabled at runtime with
+ * security_toggle_hook and are initialized as inactive.
+ */
+#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)		\
+	{						\
+		.scalls = static_calls_table.NAME,	\
+		.hook = { .NAME = HOOK },		\
+		.toggleable = true			\
 	}
 
 extern char *lsm_names;
@@ -206,4 +221,17 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 extern int lsm_inode_alloc(struct inode *inode);
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
+#ifdef CONFIG_SECURITY
+
+int security_toggle_hook(void *addr, bool value);
+
+#else
+
+static inline int security_toggle_hook(void *addr, bool value)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_SECURITY */
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index db7599c59c78..5758c5681023 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -521,6 +521,21 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
+static int bpf_trampoline_toggle_lsm(struct bpf_trampoline *tr,
+				      enum bpf_tramp_prog_type kind)
+{
+	struct bpf_tramp_link *link;
+	bool found = false;
+
+	hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
+		if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
+			found  = true;
+			break;
+		}
+	}
+	return security_toggle_hook(tr->func.addr, found);
+}
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
@@ -560,11 +575,22 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
-	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
-	if (err) {
-		hlist_del_init(&link->tramp_hlist);
-		tr->progs_cnt[kind]--;
+
+	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
+		err = bpf_trampoline_toggle_lsm(tr, kind);
+		if (err)
+			goto cleanup;
 	}
+
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
+	if (err)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	hlist_del_init(&link->tramp_hlist);
+	tr->progs_cnt[kind]--;
 	return err;
 }
 
@@ -593,6 +619,12 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
+
+	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
+		err = bpf_trampoline_toggle_lsm(tr, kind);
+		WARN(err, "BUG: unable to toggle BPF LSM hook");
+	}
+
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 57b9ffd53c98..ba1c3a19fb12 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -9,7 +9,7 @@
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
diff --git a/security/security.c b/security/security.c
index 491b807a8a63..a89eb8fe302b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -407,7 +407,9 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 			__static_call_update(scall->key, scall->trampoline,
 					     hl->hook.lsm_func_addr);
 			scall->hl = hl;
-			static_branch_enable(scall->active);
+			/* Toggleable hooks are inactive by default */
+			if (!hl->toggleable)
+				static_branch_enable(scall->active);
 			return;
 		}
 		scall++;
@@ -885,6 +887,39 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 	return rc;
 }
 
+/**
+ * security_toggle_hook - Toggle the state of the LSM hook.
+ * @hook_addr: The address of the hook to be toggled.
+ * @state: Whether to enable for disable the hook.
+ *
+ * Returns 0 on success, -EINVAL if the address is not found.
+ */
+int security_toggle_hook(void *hook_addr, bool state)
+{
+	struct lsm_static_call *scalls = ((void *)&static_calls_table);
+	unsigned long num_entries =
+		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
+	int i;
+
+	for (i = 0; i < num_entries; i++) {
+		if (!scalls[i].hl->toggleable)
+			continue;
+
+		if (!scalls[i].hl)
+			continue;
+
+		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
+			continue;
+
+		if (state)
+			static_branch_enable(scalls[i].active);
+		else
+			static_branch_disable(scalls[i].active);
+		return 0;
+	}
+	return -EINVAL;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
-- 
2.45.0.118.g7fe29c98d7-goog


