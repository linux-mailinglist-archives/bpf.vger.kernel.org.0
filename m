Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CED69F6AE
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBVOgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjBVOgt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 09:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2206B3B215
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677076547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gi85Y6SqFzVrrI5kSdLKJWoe4f/DXHvyU5OuD1/810U=;
        b=Fsl0jjWDbWbhlMpjjruiRH8aJk5RqYf8wMKI4AwOZQnjBNNYCLkb9hzBfzGfx+epMcYe68
        Y2olv1YT1TwTNsBvBdg7T6E0+dvFAtZYbvkAHbJlrPiiajfQDWeiv9HXT4UTbHycRBg0OQ
        +1OZXAa8uBS1ZDjsjuBdNGSLq6gwBaE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-QMOl7K90OUay1b_j9upLug-1; Wed, 22 Feb 2023 09:35:44 -0500
X-MC-Unique: QMOl7K90OUay1b_j9upLug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9C4788563D;
        Wed, 22 Feb 2023 14:35:37 +0000 (UTC)
Received: from dhcph048.fit.vutbr.com (unknown [10.45.225.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0ECD1415113;
        Wed, 22 Feb 2023 14:35:35 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v8 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Wed, 22 Feb 2023 15:35:28 +0100
Message-Id: <56870b3b449a20872dcff09541967a5a46284c0e.1677075137.git.vmalik@redhat.com>
In-Reply-To: <cover.1677075137.git.vmalik@redhat.com>
References: <cover.1677075137.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This resolves two problems with attachment of fentry/fexit/fmod_ret/lsm
to functions located in modules:

1. The verifier tries to find the address to attach to in kallsyms. This
   is always done by searching the entire kallsyms, not respecting the
   module in which the function is located. Such approach causes an
   incorrect attachment address to be computed if the function to attach
   to is shadowed by a function of the same name located earlier in
   kallsyms.

2. If the address to attach to is located in a module, the module
   reference is only acquired in register_fentry. If the module is
   unloaded between the place where the address is found
   (bpf_check_attach_target in the verifier) and register_fentry, it is
   possible that another module is loaded to the same address which may
   lead to potential errors.

Since the attachment must contain the BTF of the program to attach to,
we extract the module from it and search for the function address in the
correct module (resolving problem no. 1). Then, the module reference is
taken directly in bpf_check_attach_target and stored in the bpf program
(in bpf_prog_aux). The reference is only released when the program is
unloaded (resolving problem no. 2).

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/syscall.c     |  6 ++++++
 kernel/bpf/trampoline.c  | 27 ---------------------------
 kernel/bpf/verifier.c    | 18 +++++++++++++++++-
 kernel/module/internal.h |  5 +++++
 5 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520b238abd5a..ad3333088da5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1089,6 +1089,7 @@ struct bpf_trampoline {
 struct bpf_attach_target_info {
 	struct btf_func_model fmodel;
 	long tgt_addr;
+	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
 };
@@ -1361,6 +1362,7 @@ struct bpf_prog_aux {
 	 * main prog always has linfo_idx == 0
 	 */
 	u32 linfo_idx;
+	struct module *mod;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
 	union {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e3fcdc9836a6..3c9de31c892f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2049,6 +2049,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	bpf_prog_kallsyms_del_all(prog);
 	btf_put(prog->aux->btf);
+	module_put(prog->aux->mod);
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
@@ -3095,6 +3096,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		if (err)
 			goto out_unlock;
 
+		if (tgt_info.tgt_mod) {
+			module_put(prog->aux->mod);
+			prog->aux->mod = tgt_info.tgt_mod;
+		}
+
 		tr = bpf_trampoline_get(key, &tgt_info);
 		if (!tr) {
 			err = -ENOMEM;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..ebb20bf252c7 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -172,26 +172,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
-{
-	struct module *mod;
-	int err = 0;
-
-	preempt_disable();
-	mod = __module_text_address((unsigned long) tr->func.addr);
-	if (mod && !try_module_get(mod))
-		err = -ENOENT;
-	preempt_enable();
-	tr->mod = mod;
-	return err;
-}
-
-static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
-{
-	module_put(tr->mod);
-	tr->mod = NULL;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -202,8 +182,6 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
-	if (!ret)
-		bpf_trampoline_module_put(tr);
 	return ret;
 }
 
@@ -238,9 +216,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 		tr->func.ftrace_managed = true;
 	}
 
-	if (bpf_trampoline_module_get(tr))
-		return -ENOENT;
-
 	if (tr->func.ftrace_managed) {
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
 		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
@@ -248,8 +223,6 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
 
-	if (ret)
-		bpf_trampoline_module_put(tr);
 	return ret;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 272563a0b770..a6efdbd5d674 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
+#include "../module/internal.h"
 
 #include "disasm.h"
 
@@ -17278,6 +17279,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const char *tname;
 	struct btf *btf;
 	long addr = 0;
+	struct module *mod = NULL;
 
 	if (!btf_id) {
 		bpf_log(log, "Tracing programs must provide btf_id\n");
@@ -17451,8 +17453,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			else
 				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
-			addr = kallsyms_lookup_name(tname);
+			if (btf_is_module(btf)) {
+				mod = btf_try_get_module(btf);
+				if (mod)
+					addr = find_kallsyms_symbol_value(mod, tname);
+				else
+					addr = 0;
+			} else {
+				addr = kallsyms_lookup_name(tname);
+			}
 			if (!addr) {
+				module_put(mod);
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
 					tname);
@@ -17492,11 +17503,13 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				break;
 			}
 			if (ret) {
+				module_put(mod);
 				bpf_log(log, "%s is not sleepable\n", tname);
 				return ret;
 			}
 		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
 			if (tgt_prog) {
+				module_put(mod);
 				bpf_log(log, "can't modify return codes of BPF programs\n");
 				return -EINVAL;
 			}
@@ -17505,6 +17518,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    !check_attach_modify_return(addr, tname))
 				ret = 0;
 			if (ret) {
+				module_put(mod);
 				bpf_log(log, "%s() is not modifiable\n", tname);
 				return ret;
 			}
@@ -17515,6 +17529,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	tgt_info->tgt_addr = addr;
 	tgt_info->tgt_name = tname;
 	tgt_info->tgt_type = t;
+	tgt_info->tgt_mod = mod;
 	return 0;
 }
 
@@ -17594,6 +17609,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	/* store info about the attachment target that will be used later */
 	prog->aux->attach_func_proto = tgt_info.tgt_type;
 	prog->aux->attach_func_name = tgt_info.tgt_name;
+	prog->aux->mod = tgt_info.tgt_mod;
 
 	if (tgt_prog) {
 		prog->aux->saved_dst_prog_type = tgt_prog->type;
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2e2bf236f558..5cb103a46018 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -256,6 +256,11 @@ static inline bool sect_empty(const Elf_Shdr *sect)
 static inline void init_build_id(struct module *mod, const struct load_info *info) { }
 static inline void layout_symtab(struct module *mod, struct load_info *info) { }
 static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
+static inline unsigned long find_kallsyms_symbol_value(struct module *mod
+						       const char *name)
+{
+	return 0;
+}
 #endif /* CONFIG_KALLSYMS */
 
 #ifdef CONFIG_SYSFS
-- 
2.39.1

