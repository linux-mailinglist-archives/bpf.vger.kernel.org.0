Return-Path: <bpf+bounces-2521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0572E76F
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6942281216
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD33C08F;
	Tue, 13 Jun 2023 15:39:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91E23DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:39:05 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1E1A3
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f660e57123so4926558e87.3
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686670718; x=1689262718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+f1YylEi/UiPYEJr625R6AIrRZOAZNjSOTD485TQZc=;
        b=Yet38bHYCtjtDEIbkF2fTUudHgtM1Y0OJFhkgquv7nLrtU816d9wmOqdY7+Pu8lE/q
         eKcOEKwvvlHuPhv2G9Hyn29Hw87amMicz4AdoBlVg9C+pm09nvclcgIYtKuozywOXVDf
         vEFP45mpUlK84Wzu/qsB9+kGUn+Oc3eJ1JDsn+N9QYLhUKeQxMhGs2aYkLEW26Vhn7cK
         0e/bBBXoglpAvVcLCPLOJ/P4Goh+eTQ4R/evFcXUPr0KbDZtqOv+JOfnUjJJTJid2DxZ
         RuFzXJdG6TUtVJGL0ZStcMcgaY+ffI593ZGhdnIo1+NpxtAmyg9pxSgqh1CV/3FeiG9H
         IFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670718; x=1689262718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+f1YylEi/UiPYEJr625R6AIrRZOAZNjSOTD485TQZc=;
        b=eOoBijD4j+6aZ0+GxKUP50r3+oCH0rDL4ikkp+Mmnp2Bzc2ooGwaESNJIPtzbXVYHx
         E2FZjfwGIvNEJha68F7rW0TK67vHzIHC6t/9ZJLzNp6/UyW+zKFTg1mDhLSHxw0YYJu9
         DSEuY7qimn5x8+giwpwKGG4eDmKT0A4+K9+hrniUT6AO1OF7S2lCxpi4gCwtjDer5cFV
         hM8A5XriVhmkW1VorOib6l8+ciGfmHi4gzOUl9BrQUr/Qhy7pjAn5ZE+VU5LUnr7myb9
         UuI5c3SO9phc1Aki2fLQ8en8NcP7pG7mlNeCBi8R+P3+ALwaJ9K7+Fba8vKy3C+EUhjw
         iWnA==
X-Gm-Message-State: AC+VfDw+8P3oS+z+QPVjsMLuNgjB0LXjlHiVQwKbsJDBM7VQ/HZoxzQw
	HmlFW6OtVbuTetcg9Kx2KX1ktVMZv2jSDQ==
X-Google-Smtp-Source: ACHHUZ5ErtsR7B7fKdKB//Bpsv6zydpW2b+yeAREuetK+CL+UAVoyE7SZ/t+xkPF3QhY8AQVhNKsAA==
X-Received: by 2002:ac2:5b11:0:b0:4f1:dcd2:ab6d with SMTP id v17-20020ac25b11000000b004f1dcd2ab6dmr7213616lfn.28.1686670717608;
        Tue, 13 Jun 2023 08:38:37 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004f24db9248dsm1818576lff.141.2023.06.13.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:38:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v6 1/4] bpf: use scalar ids in mark_chain_precision()
Date: Tue, 13 Jun 2023 18:38:21 +0300
Message-Id: <20230613153824.3324830-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613153824.3324830-1-eddyz87@gmail.com>
References: <20230613153824.3324830-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change mark_chain_precision() to track precision in situations
like below:

    r2 = unknown value
    ...
  --- state #0 ---
    ...
    r1 = r2                 // r1 and r2 now share the same ID
    ...
  --- state #1 {r1.id = A, r2.id = A} ---
    ...
    if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
    ...
  --- state #2 {r1.id = A, r2.id = A} ---
    r3 = r10
    r3 += r1                // need to mark both r1 and r2

At the beginning of the processing of each state, ensure that if a
register with a scalar ID is marked as precise, all registers sharing
this ID are also marked as precise.

This property would be used by a follow-up change in regsafe().

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |  10 +-
 kernel/bpf/verifier.c                         | 115 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5fe589e11ac8..73a98f6240fd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -559,6 +559,11 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct bpf_idset {
+	u32 count;
+	u32 ids[BPF_ID_MAP_SIZE];
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -590,7 +595,10 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
-	struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+	union {
+		struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+		struct bpf_idset idset_scratch;
+	};
 	struct {
 		int *insn_state;
 		int *insn_stack;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed79a93398f8..747d69b2eaa5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3787,6 +3787,96 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
+static bool idset_contains(struct bpf_idset *s, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < s->count; ++i)
+		if (s->ids[i] == id)
+			return true;
+
+	return false;
+}
+
+static int idset_push(struct bpf_idset *s, u32 id)
+{
+	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
+		return -EFAULT;
+	s->ids[s->count++] = id;
+	return 0;
+}
+
+static void idset_reset(struct bpf_idset *s)
+{
+	s->count = 0;
+}
+
+/* Collect a set of IDs for all registers currently marked as precise in env->bt.
+ * Mark all registers with these IDs as precise.
+ */
+static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_idset *precise_ids = &env->idset_scratch;
+	struct backtrack_state *bt = &env->bt;
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	DECLARE_BITMAP(mask, 64);
+	int i, fr;
+
+	idset_reset(precise_ids);
+
+	for (fr = bt->frame; fr >= 0; fr--) {
+		func = st->frame[fr];
+
+		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+		for_each_set_bit(i, mask, 32) {
+			reg = &func->regs[i];
+			if (!reg->id || reg->type != SCALAR_VALUE)
+				continue;
+			if (idset_push(precise_ids, reg->id))
+				return -EFAULT;
+		}
+
+		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
+		for_each_set_bit(i, mask, 64) {
+			if (i >= func->allocated_stack / BPF_REG_SIZE)
+				break;
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id)
+				continue;
+			if (idset_push(precise_ids, reg->id))
+				return -EFAULT;
+		}
+	}
+
+	for (fr = 0; fr <= st->curframe; ++fr) {
+		func = st->frame[fr];
+
+		for (i = BPF_REG_0; i < BPF_REG_10; ++i) {
+			reg = &func->regs[i];
+			if (!reg->id)
+				continue;
+			if (!idset_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_reg(bt, fr, i);
+		}
+		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id)
+				continue;
+			if (!idset_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_slot(bt, fr, i);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -3918,6 +4008,31 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bt->frame, last_idx, first_idx, subseq_idx);
 		}
 
+		/* If some register with scalar ID is marked as precise,
+		 * make sure that all registers sharing this ID are also precise.
+		 * This is needed to estimate effect of find_equal_scalars().
+		 * Do this at the last instruction of each state,
+		 * bpf_reg_state::id fields are valid for these instructions.
+		 *
+		 * Allows to track precision in situation like below:
+		 *
+		 *     r2 = unknown value
+		 *     ...
+		 *   --- state #0 ---
+		 *     ...
+		 *     r1 = r2                 // r1 and r2 now share the same ID
+		 *     ...
+		 *   --- state #1 {r1.id = A, r2.id = A} ---
+		 *     ...
+		 *     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
+		 *     ...
+		 *   --- state #2 {r1.id = A, r2.id = A} ---
+		 *     r3 = r10
+		 *     r3 += r1                // need to mark both r1 and r2
+		 */
+		if (mark_precise_scalar_ids(env, st))
+			return -EFAULT;
+
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index b8c0aae8e7ec..99272bb890da 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -46,7 +46,7 @@
 	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
-	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: regs=r0,r9 stack= before 15\
@@ -106,10 +106,10 @@
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
+	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
-	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: parent state regs= stack=:",
-- 
2.40.1


