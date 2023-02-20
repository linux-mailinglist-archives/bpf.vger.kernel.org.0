Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5C69C8D4
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBTKoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 05:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBTKoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 05:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B27DAA
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 02:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676889794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiGTXiOnDo3DDhZo5sp1H11rvplZauq21p2nGCYzBr0=;
        b=bls4pltgGfAMUF3mPppCjEKQuGQqBnykL6SxtY51riM5EdocyfDDUhXg83uZqMZKZY8Dg8
        yqucAgVFwDvc8TLuIm7gBd9HnxOkUuaSLuHIOgnhRnQE8snh3Z8/3wbC8+tyyXSHoZ7YUI
        PHmwVsg8IdNaR4NBYWGpx7ybHnqP4Uk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-joAYK53wOF6k5KEX7A_rFQ-1; Mon, 20 Feb 2023 05:43:09 -0500
X-MC-Unique: joAYK53wOF6k5KEX7A_rFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EF96811E6E;
        Mon, 20 Feb 2023 10:43:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F35C2166B26;
        Mon, 20 Feb 2023 10:43:05 +0000 (UTC)
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
Subject: [PATCH bpf-next v7 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 20 Feb 2023 11:42:52 +0100
Message-Id: <ea9d4a1d140a78b2216f41020375fda604107162.1676888953.git.vmalik@redhat.com>
In-Reply-To: <cover.1676888953.git.vmalik@redhat.com>
References: <cover.1676888953.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
 kernel/bpf/verifier.c    | 14 +++++++++++++-
 kernel/module/internal.h |  5 +++++
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4385418118f6..00066b4d5758 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1058,6 +1058,7 @@ struct bpf_trampoline {
 struct bpf_attach_target_info {
 	struct btf_func_model fmodel;
 	long tgt_addr;
+	struct module *tgt_mod;
 	const char *tgt_name;
 	const struct btf_type *tgt_type;
 };
@@ -1330,6 +1331,7 @@ struct bpf_prog_aux {
 	 * main prog always has linfo_idx == 0
 	 */
 	u32 linfo_idx;
+	struct module *mod;
 	u32 num_exentries;
 	struct exception_table_entry *extable;
 	union {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..32609b362cda 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2039,6 +2039,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	bpf_prog_kallsyms_del_all(prog);
 	btf_put(prog->aux->btf);
+	module_put(prog->aux->mod);
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
@@ -3085,6 +3086,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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
index 388245e8826e..6da830df3ea5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
+#include "../module/internal.h"
 
 #include "disasm.h"
 
@@ -16868,6 +16869,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	const char *tname;
 	struct btf *btf;
 	long addr = 0;
+	struct module *mod = NULL;
 
 	if (!btf_id) {
 		bpf_log(log, "Tracing programs must provide btf_id\n");
@@ -17041,7 +17043,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
@@ -17105,6 +17115,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	tgt_info->tgt_addr = addr;
 	tgt_info->tgt_name = tname;
 	tgt_info->tgt_type = t;
+	tgt_info->tgt_mod = mod;
 	return 0;
 }
 
@@ -17184,6 +17195,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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

