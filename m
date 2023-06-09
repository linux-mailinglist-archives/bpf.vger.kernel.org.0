Return-Path: <bpf+bounces-2264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC39372A510
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8284A2819A6
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43A1E533;
	Fri,  9 Jun 2023 21:01:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9551DDDC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 21:01:58 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E878273D
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 14:01:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1b1635661so25331961fa.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344514; x=1688936514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbS6SkDpvV3s0Gqc8j6BLQY+zrDbINEW02MqkPWGusA=;
        b=E3zY6eqLH885Zrcj9lPvRkOO5jCl/deK0o7QMIXBH436gAJiD77A2A2DbORez1CTjv
         sJrujub2n7/vD40Q+RGoXZM+rotkBfQv7oy/3TSUFLNFO1iZXmkvHEimkeu2cC8b0jxK
         9rXdTaKSyXVRM6buk/43I+JyF3WaTmaLXOKPc2ITlMER1Tb/DowL39NO4SBe4eCdu7Ut
         jg/qhlQF82CsQKKdr9DJbtUAkSDWD4Pdyi4Elq2/E5jurNtMdRFRYB60oi+o6QjNqGIh
         Z/bn2QdJWYKXR+sItZ2JkpCqpuTaZBJxR+V0gXsRATQh8xrneuwZuC8IqNvoqcfsDf5c
         a9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344514; x=1688936514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbS6SkDpvV3s0Gqc8j6BLQY+zrDbINEW02MqkPWGusA=;
        b=YjJNMcSj7derWiCdt1PbhMN+92vnotzO2rkpygKhq2nYtF1XmEcDwP3R4+F0aROD1t
         6zToKsPShJBgPzih1JbRa4Fn8l1LYw3u42kAzEDs5i7nOnwc6KzFca7vMQn6da9eMQvA
         LIfec69/T7Nd9txlA7292h6HonS9WYjZr9YZu7rDp/YJ79+cwOUldCDiovPlWhXtwNXG
         oUHH5rK11Vxz0lfu6AocrHoC7ykUTbrSUYHpUdzLLqPPwaoJgwXHA2a1jrertjmwGPyA
         9cHjOKVLGZlJSZSnDWQrp0KT0q9eeJq7826ugV6X8rHgwdFZAiHDbgkowjX1ZDkDhx7W
         UGOQ==
X-Gm-Message-State: AC+VfDxnXlnWKov1XE5Lq9N/8WpqShWIWCcg/I6SyBy9LLwrU1tfBZBP
	XEviWUGizlOdp2jECdEhR9AIzYliUbI=
X-Google-Smtp-Source: ACHHUZ4cFgIeHC1eb52ltgtIpsi+SrkmdbcE7AeBk+EHCwJrb7tbaWmXsZZc/8Xlj5aCORwjXAIdVA==
X-Received: by 2002:a2e:8606:0:b0:2b1:fdcc:14fb with SMTP id a6-20020a2e8606000000b002b1fdcc14fbmr1830890lji.43.1686344514523;
        Fri, 09 Jun 2023 14:01:54 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a2e9dc1000000b002a8bc2fb3cesm521732ljj.115.2023.06.09.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:01:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 1/4] bpf: use scalar ids in mark_chain_precision()
Date: Sat, 10 Jun 2023 00:01:40 +0300
Message-Id: <20230609210143.2625430-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609210143.2625430-1-eddyz87@gmail.com>
References: <20230609210143.2625430-1-eddyz87@gmail.com>
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
index ed79a93398f8..f719de396c61 100644
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
+		return -1;
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
+				return -1;
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
+				return -1;
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


