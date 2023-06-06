Return-Path: <bpf+bounces-1964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7A724F89
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F081C20BB7
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E78934471;
	Tue,  6 Jun 2023 22:24:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E302DBA3
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:24:41 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067A1717
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 15:24:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so2379216e87.1
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686090277; x=1688682277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj25ixC4c7OCF682TUW+4mCjObicWfGn9yfkLRQobHw=;
        b=dXPamjGgm+TmLlbhf7VptXOb6OloQTqY/hsnncM9Hc0fi0fZ0zwv9uWs8W8LsADHXP
         VBXAOX0GloCyvtx8XdR/smjd5HTFyFLofOOhU9Dbkr7PUQl1bnQPb+GYn+YNck5bsY+/
         GpgM3jFNFqLZLIwO2WJnyIx1h2PrZvYm2EiSjq5rYbocMOZC48hSTXx8V9Bx/5tHWAGo
         sNrSrT8jJEpLDK1z0UbMDQkYH0Qs1j6Ggs5puso9H73NVepUZ10Z92lbPEdmRPOz69ej
         PSXV7Bo4L/YV0DAT6DgAlOsOcgF1u97UBuCJVffAmXrkGGk+L0XER51MGv44Aj1C0swB
         uyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686090277; x=1688682277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj25ixC4c7OCF682TUW+4mCjObicWfGn9yfkLRQobHw=;
        b=cnU9cFRBtyyiaDIZHXF6EIFSJLCOm6zidh/B9/TqcxALSFHZ4qvv8UJRgwgDys6ph6
         wN3fstJiDqJFAzYfPGAlcRVvJtM9OyKfbfCy/9regnT8dAi0OhzhZlkPMj6OGSCzYUA1
         qDfdwBDgYaCCOwDo4MxH3dwnXrpm07eAkwUFH/op1N+LqrnKl0FwlI4yO+hVQjRnFCTN
         pbbS7SKy/DMtiTy32Huz67uDJ0HyCFcCRRFgt/KPOyuOssevZCgd2qSL+5/YcWcvlDHg
         aMQP5KwBnU4c0tDdMRbRh17ROWht6KEEUwR5S5QODQtL7OWO99GVqMJsH0veVD2s7IO3
         IHyw==
X-Gm-Message-State: AC+VfDw3c9wS5j7aGDwi0EIlj7FPMIVhxURnnVbpK4ysHEeet346Wkdz
	EWt8mkLOSnAZUy27rCtKmARzVv6Q43Q=
X-Google-Smtp-Source: ACHHUZ7Ntome7zSx98A5BBnmWhNNavV730mGkdC38sgKcf4cgGjBqZcOSFGAJNcdvRX2JnENar3qog==
X-Received: by 2002:ac2:48a8:0:b0:4f0:276:295b with SMTP id u8-20020ac248a8000000b004f00276295bmr1618800lfg.46.1686090277426;
        Tue, 06 Jun 2023 15:24:37 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r15-20020ac252af000000b004f3a79c9e0fsm1577487lfm.57.2023.06.06.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:24:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/4] bpf: use scalar ids in mark_chain_precision()
Date: Wed,  7 Jun 2023 01:24:08 +0300
Message-Id: <20230606222411.1820404-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606222411.1820404-1-eddyz87@gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c                         | 114 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 3 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ee4cc7471ed9..3f9856baa542 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -559,6 +559,11 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct reg_id_scratch {
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
+		struct reg_id_scratch precise_ids_scratch;
+	};
 	struct {
 		int *insn_state;
 		int *insn_stack;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d117deb03806..2aa60b73f1b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3779,6 +3779,96 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
+static inline bool reg_id_scratch_contains(struct reg_id_scratch *s, u32 id)
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
+static inline int reg_id_scratch_push(struct reg_id_scratch *s, u32 id)
+{
+	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
+		return -1;
+	s->ids[s->count++] = id;
+	WARN_ONCE(s->count > 64,
+		  "reg_id_scratch.count is unreasonably large (%d)", s->count);
+	return 0;
+}
+
+static inline void reg_id_scratch_reset(struct reg_id_scratch *s)
+{
+	s->count = 0;
+}
+
+/* Collect a set of IDs for all registers currently marked as precise in env->bt.
+ * Mark all registers with these IDs as precise.
+ */
+static void mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct reg_id_scratch *precise_ids = &env->precise_ids_scratch;
+	struct backtrack_state *bt = &env->bt;
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	DECLARE_BITMAP(mask, 64);
+	int i, fr;
+
+	reg_id_scratch_reset(precise_ids);
+
+	for (fr = bt->frame; fr >= 0; fr--) {
+		func = st->frame[fr];
+
+		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+		for_each_set_bit(i, mask, 32) {
+			reg = &func->regs[i];
+			if (!reg->id || reg->type != SCALAR_VALUE)
+				continue;
+			if (reg_id_scratch_push(precise_ids, reg->id))
+				return;
+		}
+
+		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
+		for_each_set_bit(i, mask, 64) {
+			if (i >= func->allocated_stack / BPF_REG_SIZE)
+				break;
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id || reg->type != SCALAR_VALUE)
+				continue;
+			if (reg_id_scratch_push(precise_ids, reg->id))
+				return;
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
+			if (!reg_id_scratch_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_reg(bt, fr, i);
+		}
+		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id)
+				continue;
+			if (!reg_id_scratch_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_slot(bt, fr, i);
+		}
+	}
+}
+
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -3910,6 +4000,30 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
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
+		mark_precise_scalar_ids(env, st);
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


