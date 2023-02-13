Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00CD694BF0
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 17:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjBMQBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 11:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjBMQB3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 11:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF11F5FC
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676304017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdvKR7VPYoqBgT/1LVRwrhfRYbIchyAo3VMsaTizChU=;
        b=VOuV1Wua157HAUtzlvqdXTSdiDUJXCSfVDhmuZ2ZjE1Z68E415n+FfwYT31r/nfTiyHURS
        FjsPQupYVdw4nh9aHH7BffsUkserExv4vutuVT2Bt9nPT3h9CdnnpANAFTkS38dcdnkAJX
        xoXiYRhT3m9AJrCLIS4oBqWLOVVO8hI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-0GRmLySsPDOOiDPrthrdQA-1; Mon, 13 Feb 2023 11:00:14 -0500
X-MC-Unique: 0GRmLySsPDOOiDPrthrdQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E68A85CBEC;
        Mon, 13 Feb 2023 16:00:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.33.37.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B1A62026D2C;
        Mon, 13 Feb 2023 16:00:07 +0000 (UTC)
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
Subject: [PATCH bpf-next v5 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
Date:   Mon, 13 Feb 2023 16:59:58 +0100
Message-Id: <14feaab32b06bd76b1689ade6f4709e246a77bbe.1676302508.git.vmalik@redhat.com>
In-Reply-To: <cover.1676302508.git.vmalik@redhat.com>
References: <cover.1676302508.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
taken directly in bpf_check_attach_target and it is later passed to the
trampoline in bpf_trampoline_get. The reference is only released in the
corresponding bpf_trampoline_put (resolving problem no. 2).

Since bpf_trampoline_get may be called multiple times, we make sure that
the reference is only acquired and released once. If an error occurs
between bpf_check_attach_target and bpf_trampoline_get, the module
reference (stored in tgt_info) must be released.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/syscall.c     |  2 ++
 kernel/bpf/trampoline.c  | 44 +++++++++++++++-------------------------
 kernel/bpf/verifier.c    | 27 +++++++++++++++++++++---
 kernel/module/internal.h |  5 +++++
 5 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4385418118f6..8619bac13721 100644
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..7072217ccffc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3087,6 +3087,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 
 		tr = bpf_trampoline_get(key, &tgt_info);
 		if (!tr) {
+			if (tgt_info.tgt_mod)
+				module_put(tgt_info.tgt_mod);
 			err = -ENOMEM;
 			goto out_unlock;
 		}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..e33c051592f0 100644
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
 
@@ -719,8 +692,11 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 
 	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
 	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
+	if (!tr) {
+		if (tgt_info.tgt_mod)
+			module_put(tgt_info.tgt_mod);
 		return  -ENOMEM;
+	}
 
 	mutex_lock(&tr->mutex);
 
@@ -800,6 +776,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 		return NULL;
 
 	mutex_lock(&tr->mutex);
+	if (tgt_info->tgt_mod) {
+		if (tr->mod)
+			/* we already have the module reference, release tgt_info reference */
+			module_put(tgt_info->tgt_mod);
+		else
+			/* take ownership of the module reference */
+			tr->mod = tgt_info->tgt_mod;
+	}
 	if (tr->func.addr)
 		goto out;
 
@@ -819,6 +803,10 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_lock(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
 		goto out;
+	if (tr->mod) {
+		module_put(tr->mod);
+		tr->mod = NULL;
+	}
 	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 388245e8826e..ae7ba40eb535 100644
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
@@ -17041,7 +17043,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			else
 				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
 		} else {
-			addr = kallsyms_lookup_name(tname);
+			if (btf_is_module(btf)) {
+				preempt_disable();
+				mod = btf_try_get_module(btf);
+				if (mod)
+					addr = find_kallsyms_symbol_value(mod, tname);
+				else
+					addr = 0;
+				preempt_enable();
+			} else {
+				addr = kallsyms_lookup_name(tname);
+			}
 			if (!addr) {
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
@@ -17103,6 +17115,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		break;
 	}
 	tgt_info->tgt_addr = addr;
+	tgt_info->tgt_mod = mod;
 	tgt_info->tgt_name = tname;
 	tgt_info->tgt_type = t;
 	return 0;
@@ -17201,17 +17214,25 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		ret = bpf_lsm_verify_prog(&env->log, prog);
-		if (ret < 0)
+		if (ret < 0) {
+			if (tgt_info.tgt_mod)
+				module_put(tgt_info.tgt_mod);
 			return ret;
+		}
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		if (tgt_info.tgt_mod)
+			module_put(tgt_info.tgt_mod);
 		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
+	if (!tr) {
+		if (tgt_info.tgt_mod)
+			module_put(tgt_info.tgt_mod);
 		return -ENOMEM;
+	}
 
 	prog->aux->dst_trampoline = tr;
 	return 0;
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

