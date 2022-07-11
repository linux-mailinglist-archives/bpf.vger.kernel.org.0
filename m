Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E355EB3F
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiF1Rnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiF1Rna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B195FFD
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:18 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id w191-20020a6382c8000000b0040c9dc669ccso6907642pgd.16
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d+3sdoUjcoYy8DBqdhikc0c+RrP2PqriDP+upgGmWb4=;
        b=LDwPEwOrugC54Ej0yweTOLh8bJX7XzdW/lcnnkOuFrhZFpxPh1baRMep10x67K1GdZ
         xTbWBkccTb6Z3h1A/Gz5eC6k94mlgSY/X//h4QEKmDHfiz5sLVMvseI/LMr830wO890A
         Npo+DTTe1eYrAeAZ1Jix3DNhArJ/n3B9sMdnHd7ZoRZ/sZD/zBFJtVrQtwk1rIFy6Vq5
         uAGoIR9Ju6usZyJ5vGFcJEhWAfJ8/SiZezHn1cIK3WZwaZk11GmE/qMj8bvy0ShBJNWA
         003QeYSjsuyzJ+UY7835DTkOFWm8838nf9JqPZC/rl2OwfcG5RuY/ARxvqS7CooNYNwB
         JEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d+3sdoUjcoYy8DBqdhikc0c+RrP2PqriDP+upgGmWb4=;
        b=dQw97eaM8qhz4c9r7XobXfhvP1nibQkvho7Db7WCRvcVEHVXU0S+fqFQJmb37xLuiQ
         2GhyDOikEnmWzVfn+JTD6TnOshbKNT0UpgBtsJt8oFe86wPFL20ZFyBQLXghoooDnYcl
         TlIKVFdy49ix4caXbPnwALmYSbfiU2FtiiuwLez6yADL7rPpOLetZK/KXuPSTseUKZME
         MUlQE33sv9z+DKX/rNt+nQStk3NKM/RgQHv3b1FSAUKSNGfFyqo0IuipEXy0Hi1E2Owi
         lAWcn2tlUOZ4N8jmsjkFgd/PZvKAXEAmbjoG9SF9J5SafXD4BlmfEzNmzCLht0Ou+6kC
         22AA==
X-Gm-Message-State: AJIora8aLjggcKo6Xk9IN/KXIg9JV5pM2GpgYZdw9iUDBmg8QM+rrrqm
        qNpTUTFV9bUXCdEQsxUbGLLHDgQIKsQvPpdcZmbEe0D36BMhaDSJxNWapvmnbR87vevpiky/8w0
        d7n9yknZ9+jRVRKKSqxG8ELhg0X60p8z1jgxbGJmkW1P72CYnvw==
X-Google-Smtp-Source: AGRyM1v8ntwFwNjj4yWTnmFTXXFtUDkVq+OGIo4bequFqGRN2U7bQmy80D27aTjZ0UrFdEJ5wO/LaIA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:4ed3:0:b0:525:5a10:d5ac with SMTP id
 c202-20020a624ed3000000b005255a10d5acmr4714534pfb.65.1656438197445; Tue, 28
 Jun 2022 10:43:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:04 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-2-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 01/11] bpf: add bpf_func_t and trampoline helpers
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'll be adding lsm cgroup specific helpers that grab
trampoline mutex.

No functional changes.

Reviewed-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h     | 11 ++++---
 kernel/bpf/trampoline.c | 63 +++++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d05e1495a06e..d547be9db75f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -56,6 +56,8 @@ typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 					struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
+typedef unsigned int (*bpf_func_t)(const void *,
+				   const struct bpf_insn *);
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -879,8 +881,7 @@ struct bpf_dispatcher {
 static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
-	unsigned int (*bpf_func)(const void *,
-				 const struct bpf_insn *))
+	bpf_func_t bpf_func)
 {
 	return bpf_func(ctx, insnsi);
 }
@@ -909,8 +910,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		unsigned int (*bpf_func)(const void *,			\
-					 const struct bpf_insn *))	\
+		bpf_func_t bpf_func)					\
 	{								\
 		return bpf_func(ctx, insnsi);				\
 	}								\
@@ -921,8 +921,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	unsigned int bpf_dispatcher_##name##_func(			\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		unsigned int (*bpf_func)(const void *,			\
-					 const struct bpf_insn *));	\
+		bpf_func_t bpf_func);					\
 	extern struct bpf_dispatcher bpf_dispatcher_##name;
 #define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
 #define BPF_DISPATCHER_PTR(name) (&bpf_dispatcher_##name)
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 93c7675f0c9e..5466e15be61f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -410,7 +410,7 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
@@ -418,44 +418,33 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
-	mutex_lock(&tr->mutex);
-	if (tr->extension_prog) {
+	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
 		 * cannot overwrite extension prog either.
 		 */
-		err = -EBUSY;
-		goto out;
-	}
+		return -EBUSY;
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		cnt += tr->progs_cnt[i];
 
 	if (kind == BPF_TRAMP_REPLACE) {
 		/* Cannot attach extension if fentry/fexit are in use. */
-		if (cnt) {
-			err = -EBUSY;
-			goto out;
-		}
+		if (cnt)
+			return -EBUSY;
 		tr->extension_prog = link->link.prog;
-		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					 link->link.prog->bpf_func);
-		goto out;
-	}
-	if (cnt >= BPF_MAX_TRAMP_LINKS) {
-		err = -E2BIG;
-		goto out;
+		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
+					  link->link.prog->bpf_func);
 	}
-	if (!hlist_unhashed(&link->tramp_hlist)) {
+	if (cnt >= BPF_MAX_TRAMP_LINKS)
+		return -E2BIG;
+	if (!hlist_unhashed(&link->tramp_hlist))
 		/* prog already linked */
-		err = -EBUSY;
-		goto out;
-	}
+		return -EBUSY;
 	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
 		if (link_exiting->link.prog != link->link.prog)
 			continue;
 		/* prog already linked */
-		err = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
@@ -465,30 +454,44 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 		hlist_del_init(&link->tramp_hlist);
 		tr->progs_cnt[kind]--;
 	}
-out:
+	return err;
+}
+
+int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+{
+	int err;
+
+	mutex_lock(&tr->mutex);
+	err = __bpf_trampoline_link_prog(link, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-/* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
-	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
-		goto out;
+		return err;
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	err = bpf_trampoline_update(tr);
-out:
+	return bpf_trampoline_update(tr);
+}
+
+/* bpf_trampoline_unlink_prog() should never fail. */
+int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+{
+	int err;
+
+	mutex_lock(&tr->mutex);
+	err = __bpf_trampoline_unlink_prog(link, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

