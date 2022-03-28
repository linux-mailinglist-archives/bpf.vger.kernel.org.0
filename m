Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEB4E9EC6
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbiC1SSf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245137AbiC1SSb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 14:18:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3745AD2
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j5-20020a056902020500b00628ab64be30so11362439ybs.16
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O0chJyswoqz5hEiV7tZX8nzoXNWUpz/vL/DbXLlFR50=;
        b=crgCGuZmGISCmXdIAukpGi+z7BOg7HkS7nXfrmfJGBtxr1xTz3S+kqCH/5iSrZhKpv
         l803dCfBygumgeH52cyJToP/azUw+Vltrxxt8K8mr86iUp+LHhXrfd0KW1C3p46/xl3g
         8cHi0toP3cvNBUGHIqhyIzhSy7Be+VFl1ugbaS/9EUbp6GOj3k5QKCGL4ffxrpoQArpk
         fgUokgipQk/tPIBbg9GDq5SuM2wLKH9/0hDyaYxeJTeDtjjGYqFDA8cQ1ZIG3M4h4KuP
         hEFwirwde6cAvk7nZ/Ih2KHOSYWXP6ODHgJ0zqPt4irYcjVAyLCZ49QrpjDY40XTbdga
         1uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O0chJyswoqz5hEiV7tZX8nzoXNWUpz/vL/DbXLlFR50=;
        b=s5+p9M99nfb8wUvlt1oTRJe/TeKtES6KrMh2YGMGu0qwk69KNIKscRBf0I2/Ae8WzX
         F0AiEAx2rX0gLljbcrR83QrW1QW2oS5vgbV5w6sclRHCris3OouKASywBwOuyaJQph4c
         Fcf5YjMlDv9RJgkRVSmJ6CSW1THIM07DU8JPRHyIIuDDtwr7kETjBlOn2A9N4VRB489q
         5KPL375k9FOk1Y2hQA+P7G6663UTIue/unYoRwTmdqu2nNue3Cf7fYyawGh/WshYKw8c
         GyzT/zvejyu2HgjUhtT+2YghSWS+N+/ZNEEoKtiCUZY0hu7nxS9OxMWADdec3/xUtXKr
         v3wQ==
X-Gm-Message-State: AOAM530sgZfup6W3gpjvvGZSDaU5ZozuAM5Phm0Gi0xKwmeBZF0rR+RT
        5EYxKNeiuurZMg1BvLpncTbbVGQ=
X-Google-Smtp-Source: ABdhPJwQseQ9tfmWGl+mWbjIPteXT6rAye3+tWbPx+zJHDOu2HEs6E14FKGHa/jdf1TIkvBmgjnORck=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:a900:e0f6:cf98:d8c8])
 (user=sdf job=sendgmr) by 2002:a81:d542:0:b0:2e5:c060:a0ac with SMTP id
 l2-20020a81d542000000b002e5c060a0acmr26157122ywj.118.1648491409170; Mon, 28
 Mar 2022 11:16:49 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:16:38 -0700
In-Reply-To: <20220328181644.1748789-1-sdf@google.com>
Message-Id: <20220328181644.1748789-2-sdf@google.com>
Mime-Version: 1.0
References: <20220328181644.1748789-1-sdf@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH bpf-next 1/7] bpf: add bpf_func_t and trampoline helpers
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
 kernel/bpf/trampoline.c | 63 +++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..487aba40ce52 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -52,6 +52,8 @@ typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 					struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
+typedef unsigned int (*bpf_func_t)(const void *,
+				   const struct bpf_insn *);
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -798,8 +800,7 @@ struct bpf_dispatcher {
 static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
-	unsigned int (*bpf_func)(const void *,
-				 const struct bpf_insn *))
+	bpf_func_t bpf_func)
 {
 	return bpf_func(ctx, insnsi);
 }
@@ -827,8 +828,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
 	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		unsigned int (*bpf_func)(const void *,			\
-					 const struct bpf_insn *))	\
+		bpf_func_t bpf_func)					\
 	{								\
 		return bpf_func(ctx, insnsi);				\
 	}								\
@@ -839,8 +839,7 @@ int arch_prepare_bpf_dispatcher(void *image, s64 *funcs, int num_funcs);
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
index 0b41fa993825..5f40358a739e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -419,42 +419,34 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
+static int __bpf_trampoline_link_prog(struct bpf_prog *prog,
+				      struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	int err = 0;
 	int cnt;
 
 	kind = bpf_attach_type_to_tramp(prog);
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
+
 	cnt = tr->progs_cnt[BPF_TRAMP_FENTRY] + tr->progs_cnt[BPF_TRAMP_FEXIT];
 	if (kind == BPF_TRAMP_REPLACE) {
 		/* Cannot attach extension if fentry/fexit are in use. */
-		if (cnt) {
-			err = -EBUSY;
-			goto out;
-		}
+		if (cnt)
+			return -EBUSY;
 		tr->extension_prog = prog;
-		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					 prog->bpf_func);
-		goto out;
-	}
-	if (cnt >= BPF_MAX_TRAMP_PROGS) {
-		err = -E2BIG;
-		goto out;
+		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
+					  prog->bpf_func);
 	}
-	if (!hlist_unhashed(&prog->aux->tramp_hlist)) {
+	if (cnt >= BPF_MAX_TRAMP_PROGS)
+		return -E2BIG;
+	if (!hlist_unhashed(&prog->aux->tramp_hlist))
 		/* prog already linked */
-		err = -EBUSY;
-		goto out;
-	}
+		return -EBUSY;
 	hlist_add_head(&prog->aux->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
 	err = bpf_trampoline_update(tr);
@@ -462,30 +454,45 @@ int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
 		hlist_del_init(&prog->aux->tramp_hlist);
 		tr->progs_cnt[kind]--;
 	}
-out:
+	return err;
+}
+
+int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
+{
+	int err;
+
+	mutex_lock(&tr->mutex);
+	err = __bpf_trampoline_link_prog(prog, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-/* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_prog *prog,
+					struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
 
 	kind = bpf_attach_type_to_tramp(prog);
-	mutex_lock(&tr->mutex);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
-		goto out;
+		return err;
 	}
 	hlist_del_init(&prog->aux->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	err = bpf_trampoline_update(tr);
-out:
+	return bpf_trampoline_update(tr);
+}
+
+/* bpf_trampoline_unlink_prog() should never fail. */
+int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr)
+{
+	int err;
+
+	mutex_lock(&tr->mutex);
+	err = __bpf_trampoline_unlink_prog(prog, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
-- 
2.35.1.1021.g381101b075-goog

