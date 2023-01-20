Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968E6747DA
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjATAJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 19:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATAJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 19:09:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5344A25B3;
        Thu, 19 Jan 2023 16:09:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 422AC61CBE;
        Fri, 20 Jan 2023 00:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550FFC433EF;
        Fri, 20 Jan 2023 00:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674173339;
        bh=Wkh3s2bYpotYVb4Ma65Ndhl8R6YDKnjNCrmI6zW6fDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1IITasFA7h9gu3BzAPso5fg6gO6NKdGPi3CPHwLHauc3DC54AQPQ4NpPbffmnbcN
         F7fOpVyFxj8BoemDqCIkqQuP2XZ1MpUP5sFgVnoMm9H0m5e9GqXq+unepu9y/sHDTU
         Bss/GIQOp/EI01oOOmHFRVvVal6bBbvOrTUt/ZAoI6/3vU74I6f8kD2G9o04Ci2P6C
         0lk5XVMWJ5rD5oWuWF1eKoe0ZtQz+GHFcjTjh4LgCwMbtpM82TAdswSuze1s8oU48R
         gzpywUB4oXmkxaDycj4qRv0JbkUnRfSZfQNuVueqZBmZ8Mfo8zeuSTEy3cydR/nnSA
         T50IHkyvB1sFA==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RESEND bpf-next 4/4] bpf: Only enable BPF LSM hooks when an LSM program is attached
Date:   Fri, 20 Jan 2023 01:08:18 +0100
Message-Id: <20230120000818.1324170-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230120000818.1324170-1-kpsingh@kernel.org>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
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

BPF LSM hooks have side-effects (even when a default value is returned),
as some hooks end up behaving differently due to the very presence of
the hook.

The static keys guarding the BPF LSM hooks are disabled by default and
enabled only when a BPF program is attached implementing the hook
logic. This avoids the issue of the side-effects and also the minor
overhead associated with the empty callback.

security_file_ioctl:
   0xffffffff814f0e90 <+0>:	endbr64
   0xffffffff814f0e94 <+4>:	push   %rbp
   0xffffffff814f0e95 <+5>:	push   %r14
   0xffffffff814f0e97 <+7>:	push   %rbx
   0xffffffff814f0e98 <+8>:	mov    %rdx,%rbx
   0xffffffff814f0e9b <+11>:	mov    %esi,%ebp
   0xffffffff814f0e9d <+13>:	mov    %rdi,%r14

>>> 0xffffffff814f0ea0 <+16>:	jmp    0xffffffff814f0eb1 <security_file_ioctl+33>

   Static key enabled for SELinux

   0xffffffff814f0ea2 <+18>:	xchg   %ax,%ax

   Static key disabled for BPF. This gets patched to a jmp when a BPF
   LSM program is attached.

   0xffffffff814f0ea4 <+20>:	xor    %eax,%eax
   0xffffffff814f0ea6 <+22>:	xchg   %ax,%ax
   0xffffffff814f0ea8 <+24>:	pop    %rbx
   0xffffffff814f0ea9 <+25>:	pop    %r14
   0xffffffff814f0eab <+27>:	pop    %rbp
   0xffffffff814f0eac <+28>:	jmp    0xffffffff81f767c4 <__x86_return_thunk>
   0xffffffff814f0eb1 <+33>:	endbr64
   0xffffffff814f0eb5 <+37>:	mov    %r14,%rdi
   0xffffffff814f0eb8 <+40>:	mov    %ebp,%esi
   0xffffffff814f0eba <+42>:	mov    %rbx,%rdx
   0xffffffff814f0ebd <+45>:	call   0xffffffff814fe8e0 <selinux_file_ioctl>
   0xffffffff814f0ec2 <+50>:	test   %eax,%eax
   0xffffffff814f0ec4 <+52>:	jne    0xffffffff814f0ea8 <security_file_ioctl+24>
   0xffffffff814f0ec6 <+54>:	jmp    0xffffffff814f0ea2 <security_file_ioctl+18>
   0xffffffff814f0ec8 <+56>:	endbr64
   0xffffffff814f0ecc <+60>:	mov    %r14,%rdi
   0xffffffff814f0ecf <+63>:	mov    %ebp,%esi
   0xffffffff814f0ed1 <+65>:	mov    %rbx,%rdx
   0xffffffff814f0ed4 <+68>:	call   0xffffffff8123b890 <bpf_lsm_file_ioctl>
   0xffffffff814f0ed9 <+73>:	test   %eax,%eax
   0xffffffff814f0edb <+75>:	jne    0xffffffff814f0ea8 <security_file_ioctl+24>
   0xffffffff814f0edd <+77>:	jmp    0xffffffff814f0ea4 <security_file_ioctl+20>
   0xffffffff814f0edf <+79>:	endbr64
   0xffffffff814f0ee3 <+83>:	mov    %r14,%rdi
   0xffffffff814f0ee6 <+86>:	mov    %ebp,%esi
   0xffffffff814f0ee8 <+88>:	mov    %rbx,%rdx
   0xffffffff814f0eeb <+91>:	pop    %rbx
   0xffffffff814f0eec <+92>:	pop    %r14
   0xffffffff814f0eee <+94>:	pop    %rbp
   0xffffffff814f0eef <+95>:	ret
   0xffffffff814f0ef0 <+96>:	int3
   0xffffffff814f0ef1 <+97>:	int3
   0xffffffff814f0ef2 <+98>:	int3
   0xffffffff814f0ef3 <+99>:	int3

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h       |  1 +
 include/linux/bpf_lsm.h   |  1 +
 include/linux/lsm_hooks.h | 13 ++++++++++++-
 kernel/bpf/trampoline.c   | 29 +++++++++++++++++++++++++++--
 security/bpf/hooks.c      | 26 +++++++++++++++++++++++++-
 security/security.c       |  3 ++-
 6 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae7771c7d750..4008f4a00851 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1049,6 +1049,7 @@ struct bpf_attach_target_info {
 	long tgt_addr;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
+	bool is_lsm_target;
 };
 
 #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 1de7ece5d36d..cce615af93d5 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -29,6 +29,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 
 bool bpf_lsm_is_sleepable_hook(u32 btf_id);
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
+void bpf_lsm_toggle_hook(void *addr, bool value);
 
 static inline struct bpf_storage_blob *bpf_inode(
 	const struct inode *inode)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c82d15a4ef50..5e85d3340a07 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1716,11 +1716,14 @@ struct lsm_static_calls_table {
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
@@ -1751,7 +1754,15 @@ struct lsm_blob_sizes {
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
index d0ed7d6f5eec..9789ecf6f29c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -14,6 +14,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_lsm.h>
 #include <linux/delay.h>
+#include <linux/bpf_lsm.h>
 
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
@@ -536,7 +537,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
-	int err = 0;
+	int err = 0, num_lsm_progs = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -567,8 +568,14 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
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
@@ -591,8 +598,10 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
+	struct bpf_tramp_link *link_exiting;
 	enum bpf_tramp_prog_type kind;
-	int err;
+	bool lsm_link_found = false;
+	int err, num_lsm_progs = 0;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
 	if (kind == BPF_TRAMP_REPLACE) {
@@ -602,8 +611,24 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
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
index e5971fa74fd7..a39799e9f648 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -8,7 +8,7 @@
 
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
-	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
@@ -32,3 +32,27 @@ DEFINE_LSM(bpf) = {
 	.init = bpf_lsm_init,
 	.blobs = &bpf_lsm_blob_sizes
 };
+
+void bpf_lsm_toggle_hook(void *addr, bool value)
+{
+	struct security_hook_list *h;
+	struct lsm_static_call *scalls;
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
+
+			if (value)
+				static_key_enable(scalls[j].enabled_key);
+			else
+				static_key_disable(scalls[j].enabled_key);
+		}
+	}
+}
diff --git a/security/security.c b/security/security.c
index e54d5ba187d1..f74135349429 100644
--- a/security/security.c
+++ b/security/security.c
@@ -366,7 +366,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 		if (!scall->hl) {
 			__static_call_update(scall->key, scall->trampoline, hl->hook.lsm_callback);
 			scall->hl = hl;
-			static_key_enable(scall->enabled_key);
+			if (hl->default_state)
+				static_key_enable(scall->enabled_key);
 			return;
 		}
 		scall++;
-- 
2.39.0.246.g2a6d74b583-goog

