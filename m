Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86477546B31
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiFJQ6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiFJQ6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 12:58:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60431376
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 09:58:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v127-20020a256185000000b0065cbe0f6999so23135564ybb.22
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Act5KFf04cq4PKBPIkiL9PndkyGSjHXudEO9oDVyp8=;
        b=I8fWVZMoNGNOE/JIXn835qEhaPI78vbK1Om5QONSJFQkn2yY4kd87HJkSi2yRK7LT7
         1cWE4482pc2tgHhPU8ZqBaM30qAsyqNNlRsncVYCTOCOlId+/lNaKYd1mCJg0k65kDj4
         O6HXAjVah0YL6zVvkTQ+dorf/jp+RZp46BUigdhrcBClDJFf8JQxZejui9aNbIteoyo1
         pK15lpzf+ZJLT86apGi8yDf481OCffhnuWBMJxio6tSOc16o2F4bjuiutak1nGudYSYI
         wFzGhij8f15ZwsUGTc0BAFLzJiTED0jYPl35zOf12M1qNrKKBxFghIi1Ybg+7dkD05IH
         5r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Act5KFf04cq4PKBPIkiL9PndkyGSjHXudEO9oDVyp8=;
        b=OtqPvx/1BFN/OGlvADPjRNzIkp/+oODkkZhAu8T/v0yMcbyruzFVq+tvuZX3NkZvP4
         nRVU2+OYgC78FZUvtpNnuzHg+sxIu9y6xqv6h8nOb+JKyJmmOgUl8COxO6AlaEXbjh8d
         62qeds161EwV9wH1A6aFSDam9ED+xqJziZ3qsiw/akhAY6RJG/4AqkMD9n/nOZV97ApW
         iELO/XDCAjfpaLLpQEHENelLIXkf+glYZyhhG5dHQ2dG+uayJ0wczYodFKGtW9GFlpUj
         f5sBrXVjUSwMpFRW6LrI1pac2GsqLZQxqNRdOfleVTuaDk+XNNq7lJZq8cNb9CJ5K1a2
         B50A==
X-Gm-Message-State: AOAM531sF7lXo8pAXwtVZcStXV7jjgXuzutFCTjYD+j0d1byGsdKdNC9
        fM4EIhWaVbCpOIPwHWpFMOpym+w=
X-Google-Smtp-Source: ABdhPJyo+KRRGhQLMHgYiuT84DB/ppKEzPvIbVooxu6oMq/2/hsNfhWA2tBrNa4EBRsUeGSTfnkJN2k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:3445:0:b0:664:3b67:144a with SMTP id
 b66-20020a253445000000b006643b67144amr7665405yba.526.1654880287404; Fri, 10
 Jun 2022 09:58:07 -0700 (PDT)
Date:   Fri, 10 Jun 2022 09:57:54 -0700
In-Reply-To: <20220610165803.2860154-1-sdf@google.com>
Message-Id: <20220610165803.2860154-2-sdf@google.com>
Mime-Version: 1.0
References: <20220610165803.2860154-1-sdf@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v9 01/10] bpf: add bpf_func_t and trampoline helpers
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
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

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h     | 11 ++++---
 kernel/bpf/trampoline.c | 63 +++++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8e6092d0ea95..b0af68b6297b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -53,6 +53,8 @@ typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 					struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
+typedef unsigned int (*bpf_func_t)(const void *,
+				   const struct bpf_insn *);
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -863,8 +865,7 @@ struct bpf_dispatcher {
 static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
-	unsigned int (*bpf_func)(const void *,
-				 const struct bpf_insn *))
+	bpf_func_t bpf_func)
 {
 	return bpf_func(ctx, insnsi);
 }
@@ -893,8 +894,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		unsigned int (*bpf_func)(const void *,			\
-					 const struct bpf_insn *))	\
+		bpf_func_t bpf_func)					\
 	{								\
 		return bpf_func(ctx, insnsi);				\
 	}								\
@@ -905,8 +905,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
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
2.36.1.476.g0c4daa206d-goog

