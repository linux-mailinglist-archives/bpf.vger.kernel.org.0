Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979201798CA
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgCDTTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42337 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDTTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id v11so1915067wrm.9
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PGaOZW00Y+kjCaz46PF9vGeuorJBPeOJrrhjosIqrs=;
        b=TlbxF/Y8AxCzAxnn22XDzvcXuhUeM1/b6yH5UynAHvCJW9FIFzH3hd+TjcP0P/Gho4
         Q3sYN6fZ5dlEZUn2jDKZFc5T/rDfR0lxiUmzy1Mmw3cVS+rSISjib0U72+SmzNcehePr
         OzSFoY1xTwSZ0lRca59B5XbCHf71FyJoC8hXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PGaOZW00Y+kjCaz46PF9vGeuorJBPeOJrrhjosIqrs=;
        b=aPUMGczfnj3WgMOkGexZ+YDOX4piscrCDxSWE6gIJZAQayvXSEbVA7wxkk4hfdVs/6
         UpZu90fGJiSof1LPgu1zGtiBA79RZAd6lNog6NvsGJpFGmuUPvFvVeAaVtRPskpd2rg7
         2en/Tljg/5+iYfEpqVBHHBUocn73KO60k5fpXSFd9GcVOpXhzlis2JMhHYhrP21tTmm4
         WHUfsdGQ+JOVzAhjMrI7ltwS+AF1Hg7aAGF5cesXzK6L3svsg/rFK/3pCd8MEjsfxFa4
         DQYC0HKZzU661sYTBSz1k0Xxg7nrAIkbi6t9a35Z12Sod3zD+ulGx86g5Kcnqy8SZ+c5
         rVvA==
X-Gm-Message-State: ANhLgQ08/f9+m6h+H+LLoWlz/kqNWPKPvUuqJmhRqqdGXBWfmxhKSbvX
        3gnCxjtt6FFgXMclJYE+M9uhlw==
X-Google-Smtp-Source: ADFU+vtAvRIivN5Lkpj0nqoQCBBNl1O6B3W0Hmunh2qV3neKjfANu3NBokl+7t89tt+Vi+UTrTmblQ==
X-Received: by 2002:a5d:6083:: with SMTP id w3mr5447132wrt.395.1583349539521;
        Wed, 04 Mar 2020 11:18:59 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:18:58 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 1/7] bpf: Refactor trampoline update code
Date:   Wed,  4 Mar 2020 20:18:47 +0100
Message-Id: <20200304191853.1529-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

As we need to introduce a third type of attachment for trampolines, the
flattened signature of arch_prepare_bpf_trampoline gets even more
complicated.

Refactor the prog and count argument to arch_prepare_bpf_trampoline to
use bpf_tramp_progs to simplify the addition and accounting for new
attachment types.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 31 ++++++++++---------
 include/linux/bpf.h         | 13 ++++++--
 kernel/bpf/bpf_struct_ops.c | 10 +++++-
 kernel/bpf/trampoline.c     | 62 +++++++++++++++++++++----------------
 4 files changed, 71 insertions(+), 45 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9ba08e9abc09..15c7d28bc05c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_prog **progs, int prog_cnt, int stack_size)
+		      struct bpf_tramp_progs *tp, int stack_size)
 {
 	u8 *prog = *pprog;
 	int cnt = 0, i;
 
-	for (i = 0; i < prog_cnt; i++) {
+	for (i = 0; i < tp->nr_progs; i++) {
 		if (emit_call(&prog, __bpf_prog_enter, prog))
 			return -EINVAL;
 		/* remember prog start time returned by __bpf_prog_enter */
@@ -1376,17 +1376,17 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		/* arg1: lea rdi, [rbp - stack_size] */
 		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 		/* arg2: progs[i]->insnsi for interpreter */
-		if (!progs[i]->jited)
+		if (!tp->progs[i]->jited)
 			emit_mov_imm64(&prog, BPF_REG_2,
-				       (long) progs[i]->insnsi >> 32,
-				       (u32) (long) progs[i]->insnsi);
+				       (long) tp->progs[i]->insnsi >> 32,
+				       (u32) (long) tp->progs[i]->insnsi);
 		/* call JITed bpf program or interpreter */
-		if (emit_call(&prog, progs[i]->bpf_func, prog))
+		if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
 			return -EINVAL;
 
 		/* arg1: mov rdi, progs[i] */
-		emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 32,
-			       (u32) (long) progs[i]);
+		emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] >> 32,
+			       (u32) (long) tp->progs[i]);
 		/* arg2: mov rsi, rbx <- start time in nsec */
 		emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 		if (emit_call(&prog, __bpf_prog_exit, prog))
@@ -1458,12 +1458,13 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
  */
 int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_prog **fentry_progs, int fentry_cnt,
-				struct bpf_prog **fexit_progs, int fexit_cnt,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
 	int cnt = 0, nr_args = m->nr_args;
 	int stack_size = nr_args * 8;
+	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
 	u8 *prog;
 
 	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
@@ -1492,12 +1493,12 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 
 	save_regs(m, &prog, nr_args, stack_size);
 
-	if (fentry_cnt)
-		if (invoke_bpf(m, &prog, fentry_progs, fentry_cnt, stack_size))
+	if (fentry->nr_progs)
+		if (invoke_bpf(m, &prog, fentry, stack_size))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (fentry_cnt)
+		if (fentry->nr_progs)
 			restore_regs(m, &prog, nr_args, stack_size);
 
 		/* call original function */
@@ -1507,8 +1508,8 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	}
 
-	if (fexit_cnt)
-		if (invoke_bpf(m, &prog, fexit_progs, fexit_cnt, stack_size))
+	if (fexit->nr_progs)
+		if (invoke_bpf(m, &prog, fexit, stack_size))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f13c78c6f29d..98ec10b23dbb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -433,6 +433,16 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
 
+/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
+ * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
+ */
+#define BPF_MAX_TRAMP_PROGS 40
+
+struct bpf_tramp_progs {
+	struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
+	int nr_progs;
+};
+
 /* Different use cases for BPF trampoline:
  * 1. replace nop at the function entry (kprobe equivalent)
  *    flags = BPF_TRAMP_F_RESTORE_REGS
@@ -455,8 +465,7 @@ struct btf_func_model {
  */
 int arch_prepare_bpf_trampoline(void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_prog **fentry_progs, int fentry_cnt,
-				struct bpf_prog **fexit_progs, int fexit_cnt,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
 u64 notrace __bpf_prog_enter(void);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c498f0fffb40..ca5cc8cdb6eb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
+	struct bpf_tramp_progs *tprogs = NULL;
 	void *udata, *kdata;
 	int prog_fd, err = 0;
 	void *image;
@@ -343,6 +344,10 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (uvalue->state || refcount_read(&uvalue->refcnt))
 		return -EINVAL;
 
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs)
+		return -ENOMEM;
+
 	uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
 	kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
 
@@ -425,10 +430,12 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
+		tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
 		err = arch_prepare_bpf_trampoline(image,
 						  st_map->image + PAGE_SIZE,
 						  &st_ops->func_models[i], 0,
-						  &prog, 1, NULL, 0, NULL);
+						  tprogs, NULL);
 		if (err < 0)
 			goto reset_unlock;
 
@@ -469,6 +476,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
+	kfree(tprogs);
 	mutex_unlock(&st_map->lock);
 	return err;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 704fa787fec0..546198f6f307 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -190,40 +190,49 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return ret;
 }
 
-/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
- * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
- */
-#define BPF_MAX_TRAMP_PROGS 40
+static struct bpf_tramp_progs *
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total)
+{
+	const struct bpf_prog_aux *aux;
+	struct bpf_tramp_progs *tprogs;
+	struct bpf_prog **progs;
+	int kind;
+
+	*total = 0;
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs)
+		return ERR_PTR(-ENOMEM);
+
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
+		tprogs[kind].nr_progs = tr->progs_cnt[kind];
+		*total += tr->progs_cnt[kind];
+		progs = tprogs[kind].progs;
+
+		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist)
+			*progs++ = aux->prog;
+	}
+	return tprogs;
+}
 
 static int bpf_trampoline_update(struct bpf_trampoline *tr)
 {
 	void *old_image = tr->image + ((tr->selector + 1) & 1) * BPF_IMAGE_SIZE/2;
 	void *new_image = tr->image + (tr->selector & 1) * BPF_IMAGE_SIZE/2;
-	struct bpf_prog *progs_to_run[BPF_MAX_TRAMP_PROGS];
-	int fentry_cnt = tr->progs_cnt[BPF_TRAMP_FENTRY];
-	int fexit_cnt = tr->progs_cnt[BPF_TRAMP_FEXIT];
-	struct bpf_prog **progs, **fentry, **fexit;
+	struct bpf_tramp_progs *tprogs;
 	u32 flags = BPF_TRAMP_F_RESTORE_REGS;
-	struct bpf_prog_aux *aux;
-	int err;
+	int err, total;
 
-	if (fentry_cnt + fexit_cnt == 0) {
+	tprogs = bpf_trampoline_get_progs(tr, &total);
+	if (IS_ERR(tprogs))
+		return PTR_ERR(tprogs);
+
+	if (total == 0) {
 		err = unregister_fentry(tr, old_image);
 		tr->selector = 0;
 		goto out;
 	}
 
-	/* populate fentry progs */
-	fentry = progs = progs_to_run;
-	hlist_for_each_entry(aux, &tr->progs_hlist[BPF_TRAMP_FENTRY], tramp_hlist)
-		*progs++ = aux->prog;
-
-	/* populate fexit progs */
-	fexit = progs;
-	hlist_for_each_entry(aux, &tr->progs_hlist[BPF_TRAMP_FEXIT], tramp_hlist)
-		*progs++ = aux->prog;
-
-	if (fexit_cnt)
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs)
 		flags = BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_SKIP_FRAME;
 
 	/* Though the second half of trampoline page is unused a task could be
@@ -232,12 +241,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	 * preempted task. Hence wait for tasks to voluntarily schedule or go
 	 * to userspace.
 	 */
+
 	synchronize_rcu_tasks();
 
 	err = arch_prepare_bpf_trampoline(new_image, new_image + BPF_IMAGE_SIZE / 2,
-					  &tr->func.model, flags,
-					  fentry, fentry_cnt,
-					  fexit, fexit_cnt,
+					  &tr->func.model, flags, tprogs,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
@@ -252,6 +260,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 		goto out;
 	tr->selector++;
 out:
+	kfree(tprogs);
 	return err;
 }
 
@@ -409,8 +418,7 @@ void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start)
 int __weak
 arch_prepare_bpf_trampoline(void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
-			    struct bpf_prog **fentry_progs, int fentry_cnt,
-			    struct bpf_prog **fexit_progs, int fexit_cnt,
+			    struct bpf_tramp_progs *tprogs,
 			    void *orig_call)
 {
 	return -ENOTSUPP;
-- 
2.20.1

