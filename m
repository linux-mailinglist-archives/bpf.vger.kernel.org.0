Return-Path: <bpf+bounces-2686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD13732413
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 02:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07051C20EE6
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 00:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B162F;
	Fri, 16 Jun 2023 00:05:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12E626
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 00:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA2FC433CB;
	Fri, 16 Jun 2023 00:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686873902;
	bh=SRUUHvNU9VjkTuHjE3eV7qCSj9Zf5AcJHxpRvRhWpTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usRRsy7KX/8kIusvvMu1xTNiFam4CunVRwoXmOGgBu92KdUfwcfpj16vXYPR3IyS0
	 JmOyICqgqoOo+EZweQ0Gc68TdsHqXs77gqbHJ/qexPHyMaO20OuIKbEBmt3TD+UC06
	 BZgiKpkcGl9mzSj9WfZPmL6G1yx6m3X41xqaXQRxIHRerxx4hS1f0zdyyx2N4ezl6S
	 kNDehvaT2lQOLACVIh0sQsG8V+u1JPt5k554d7KbzhY6/Is0gaqGCoIc2dd/SERE1I
	 YIfNgpMmZxvFVu5+lFmFcluuDSGiFa+ZLPznR5eRHKMrbG+72Up6byJnNt22afrlmq
	 WXI7Lg1P4dk2g==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	jannh@google.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 4/5] bpf: Only enable BPF LSM hooks when an LSM program is attached
Date: Fri, 16 Jun 2023 02:04:40 +0200
Message-ID: <20230616000441.3677441-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230616000441.3677441-1-kpsingh@kernel.org>
References: <20230616000441.3677441-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF LSM hooks have side-effects (even when a default value is returned),
as some hooks end up behaving differently due to the very presence of
the hook.

The static keys guarding the BPF LSM hooks are disabled by default and
enabled only when a BPF program is attached implementing the hook
logic. This avoids the issue of the side-effects and also the minor
overhead associated with the empty callback.

security_file_ioctl:
   0xffffffff818f0e30 <+0>:	endbr64
   0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
   0xffffffff818f0e39 <+9>:	push   %rbp
   0xffffffff818f0e3a <+10>:	push   %r14
   0xffffffff818f0e3c <+12>:	push   %rbx
   0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
   0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
   0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
   0xffffffff818f0e45 <+21>:	jmp    0xffffffff818f0e57 <security_file_ioctl+39>
   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   Static key enabled for SELinux

   0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
   				^^^^^^^^^^^^^^

   Static key disabled for BPF. This gets patched when a BPF LSM program
   is attached

   0xffffffff818f0e49 <+25>:	xor    %eax,%eax
   0xffffffff818f0e4b <+27>:	xchg   %ax,%ax
   0xffffffff818f0e4d <+29>:	pop    %rbx
   0xffffffff818f0e4e <+30>:	pop    %r14
   0xffffffff818f0e50 <+32>:	pop    %rbp
   0xffffffff818f0e51 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
   0xffffffff818f0e57 <+39>:	endbr64
   0xffffffff818f0e5b <+43>:	mov    %r14,%rdi
   0xffffffff818f0e5e <+46>:	mov    %ebp,%esi
   0xffffffff818f0e60 <+48>:	mov    %rbx,%rdx
   0xffffffff818f0e63 <+51>:	call   0xffffffff819033c0 <selinux_file_ioctl>
   0xffffffff818f0e68 <+56>:	test   %eax,%eax
   0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
   0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
   0xffffffff818f0e6e <+62>:	endbr64
   0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
   0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
   0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
   0xffffffff818f0e7a <+74>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
   0xffffffff818f0e7f <+79>:	test   %eax,%eax
   0xffffffff818f0e81 <+81>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
   0xffffffff818f0e83 <+83>:	jmp    0xffffffff818f0e49 <security_file_ioctl+25>
   0xffffffff818f0e85 <+85>:	endbr64
   0xffffffff818f0e89 <+89>:	mov    %r14,%rdi
   0xffffffff818f0e8c <+92>:	mov    %ebp,%esi
   0xffffffff818f0e8e <+94>:	mov    %rbx,%rdx
   0xffffffff818f0e91 <+97>:	pop    %rbx
   0xffffffff818f0e92 <+98>:	pop    %r14
   0xffffffff818f0e94 <+100>:	pop    %rbp
   0xffffffff818f0e95 <+101>:	ret

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h       |  1 +
 include/linux/bpf_lsm.h   |  5 +++++
 include/linux/lsm_hooks.h | 13 ++++++++++++-
 kernel/bpf/trampoline.c   | 29 +++++++++++++++++++++++++++--
 security/bpf/hooks.c      | 25 ++++++++++++++++++++++++-
 security/security.c       |  3 ++-
 6 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..d288b65836c4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1134,6 +1134,7 @@ struct bpf_attach_target_info {
 	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool is_lsm_target;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..5bbc31ac948c 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
+void bpf_lsm_toggle_hook(void *addr, bool value);
 
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
@@ -78,6 +79,10 @@ static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 {
 }
 
+static inline void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 069da0fa617a..96fa610ce443 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -96,11 +96,14 @@ struct lsm_static_calls_table {
  * @scalls: The beginning of the array of static calls assigned to this hook.
  * @hook: The callback for the hook.
  * @lsm: The name of the lsm that owns this hook.
+ * @default_state: The state of the LSM hook when initialized. If set to false,
+ * the static key guarding the hook will be set to disabled.
  */
 struct security_hook_list {
 	struct lsm_static_call	*scalls;
 	union security_list_options	hook;
 	const char			*lsm;
+	bool				default_state;
 } __randomize_layout;
 
 /*
@@ -131,7 +134,15 @@ struct lsm_blob_sizes {
 #define LSM_HOOK_INIT(NAME, CALLBACK)			\
 	{						\
 		.scalls = static_calls_table.NAME,	\
-		.hook = { .NAME = CALLBACK }		\
+		.hook = { .NAME = CALLBACK },		\
+		.default_state = true			\
+	}
+
+#define LSM_HOOK_INIT_DISABLED(NAME, CALLBACK)		\
+	{						\
+		.scalls = static_calls_table.NAME,	\
+		.hook = { .NAME = CALLBACK },		\
+		.default_state = false			\
 	}
 
 extern char *lsm_names;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d4873..5b17cd7aab30 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/bpf_lsm.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
-	int err = 0;
+	int err = 0, num_lsm_progs = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 			continue;
 		/* prog already linked */
 		return -EBUSY;
+
+		if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
+			num_lsm_progs++;
 	}
 
+	if (!num_lsm_progs && link->link.prog->type == BPF_PROG_TYPE_LSM)
+		bpf_lsm_toggle_hook(tr->func.addr, true);
+
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
@@ -569,8 +576,10 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
+	struct bpf_tramp_link *link_exiting;
 	enum bpf_tramp_prog_type kind;
-	int err;
+	bool lsm_link_found = false;
+	int err, num_lsm_progs = 0;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
 	if (kind == BPF_TRAMP_REPLACE) {
@@ -580,8 +589,24 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 		tr->extension_prog = NULL;
 		return err;
 	}
+
+	if (link->link.prog->type == BPF_PROG_TYPE_LSM) {
+		hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind],
+				     tramp_hlist) {
+			if (link_exiting->link.prog->type == BPF_PROG_TYPE_LSM)
+				num_lsm_progs++;
+
+			if (link_exiting->link.prog == link->link.prog)
+				lsm_link_found = true;
+		}
+	}
+
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
+
+	if (lsm_link_found && num_lsm_progs == 1)
+		bpf_lsm_toggle_hook(tr->func.addr, false);
+
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }
 
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index cfaf1d0e6a5f..1957244196d0 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -8,7 +8,7 @@
 
 static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
@@ -32,3 +32,26 @@ DEFINE_LSM(bpf) = {
 	.init = bpf_lsm_init,
 	.blobs = &bpf_lsm_blob_sizes
 };
+
+void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+	struct lsm_static_call *scalls;
+	struct security_hook_list *h;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
+		h = &bpf_lsm_hooks[i];
+		scalls = h->scalls;
+		if (h->hook.lsm_callback == addr)
+			continue;
+
+		for (j = 0; j < MAX_LSM_COUNT; j++) {
+			if (scalls[j].hl != h)
+				continue;
+			if (value)
+				static_branch_enable(scalls[j].active);
+			else
+				static_branch_disable(scalls[j].active);
+		}
+	}
+}
diff --git a/security/security.c b/security/security.c
index 9ae7c0ec5cac..4aec25949212 100644
--- a/security/security.c
+++ b/security/security.c
@@ -374,7 +374,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 			__static_call_update(scall->key, scall->trampoline,
 					     hl->hook.lsm_callback);
 			scall->hl = hl;
-			static_branch_enable(scall->active);
+			if (hl->default_state)
+				static_branch_enable(scall->active);
 			return;
 		}
 		scall++;
-- 
2.41.0.162.gfafddb0af9-goog


