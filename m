Return-Path: <bpf+bounces-35015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73640935260
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C72281FDF
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B18B145B19;
	Thu, 18 Jul 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCg/AcZh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE082145321
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334255; cv=none; b=TmSworawoste0l7db4xHNW6kKUelmYAyRTbfMkJPZt8LBSEJy+ZLrR+csHE+sKk+jOExsRx/axv8NizjbMrwRxzC0jVCTxF6gEyse/hqH05hK8lAd9/73sF/NPfzQ3jZBe0heCwdvgtMfOvDvGmrWE3c7oV8VjlLQRjbcyoPEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334255; c=relaxed/simple;
	bh=M/Vxbsn2jBMYySvZq+3I8Rp018+k91g/xXxl2kceCd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iW4fClx5tmjV8+6FJZbq2KZaYHO+L2S+ESyx7yaWigFs6Jnb+/8eiGNKeHSGVwtqq1ueb7EuZIFsNhZLgcR0/G+/XHVYJjWjyxnrXzv3QrV2Y1VoYNfrxt2bXK3N6aMd4Xs3HQOhtnShH+4+vTWF7W5bNGanou/IvTL+2PzbFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCg/AcZh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75cda3719efso779732a12.3
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721334253; x=1721939053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g4Kh6NhQLuufVBCBnRm+DeKv/tv5GQ6cjN6FeAOY+s=;
        b=mCg/AcZhJ0zMMUZL42fpf0KbupnPo+/Rm+gH7Gh6ap2YOaser8382raUiZxOhfEIiG
         EFfcmuvHP07x1oLhl4g+ua96gt8qHiq0GBSpD40qpyRuMCHHlOjYecPHIAOIDMNu98wn
         OuAkT8bt8Pg5CqerxFQhpw0sxOoSaLLENx7MuBrw6fhW+84OSAF9ZQV43FTe3t6EV6IZ
         lPbV8t2cz7aEBCv38gMdM9LMByXXclhKnEwyMveQX6YEcf3UKPqmGSuTEU3B3oSmWpuJ
         +VJXDPFwsGx3uGrSrE1yT+aSd++l/eg8kWyfo6nUI/p6IpIFh4g18t95wZ57p5nNtyQS
         lTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334253; x=1721939053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g4Kh6NhQLuufVBCBnRm+DeKv/tv5GQ6cjN6FeAOY+s=;
        b=YqStMEaS/4p1sVMtmzgeJwZpHnuu0tNqMaYxrVvJ+JcW9eLFYABU0eXoaQMd4TnVeb
         eMMiN9cLInZ9dZZCrZo3f1zn6rONFNJuD4bcEXzroFkNTk5iuujIux1YjOSK8YLgVz1Y
         kQrTaD5vDC+Jj1CO1Wqb13h5fCGJV5xrGsheF+QrPVNWccheRzKItxFyGTC/vA4Xmv+S
         8FOL35AsSWMLQtufP0NkXOwGrJkbLQR9aOlFBxYbNNlQ3boV5+AGTv34/YQso8pBx2Ai
         UONT/uqlVhRcnbEKlJIuVjB3sm4Bbfrw4dhUhfGwe2SLA4vYCJjrFJlQdt12zMbKMnxJ
         KAdg==
X-Gm-Message-State: AOJu0YzkDoX2cIqb3LbWQ6J7jkgpzpS+Gvyob8FnG+RJT13KcqPNEHB/
	iSTErCCOlsOfQF1jQGjK+XrZMeitP2G6eqBvfVqtElikFFJXVCeuDLNtzu3C
X-Google-Smtp-Source: AGHT+IErYWH7zqkS0XIdlspsPzlEKnesllm2HF+SXYDjcpKKAYiE+r8UnXqgGS531sKwTr0TaQjIYQ==
X-Received: by 2002:a05:6a20:7f91:b0:1c2:88ad:b26d with SMTP id adf61e73a8af0-1c3fdd5a7d9mr5991997637.48.1721334252712;
        Thu, 18 Jul 2024 13:24:12 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc505basm96888235ad.270.2024.07.18.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sunhao.th@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 1/4] bpf: track equal scalars history on per-instruction level
Date: Thu, 18 Jul 2024 13:23:53 -0700
Message-ID: <20240718202357.1746514-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718202357.1746514-1-eddyz87@gmail.com>
References: <20240718202357.1746514-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_verifier_state->jmp_history to track which registers were
updated by find_equal_scalars() (renamed to collect_linked_regs())
when conditional jump was verified. Use recorded information in
backtrack_insn() to propagate precision.

E.g. for the following program:

            while verifying instructions
  1: r1 = r0              |
  2: if r1 < 8  goto ...  | push r0,r1 as linked registers in jmp_history
  3: if r0 > 16 goto ...  | push r0,r1 as linked registers in jmp_history
  4: r2 = r10             |
  5: r2 += r0             v mark_chain_precision(r0)

            while doing mark_chain_precision(r0)
  5: r2 += r0             | mark r0 precise
  4: r2 = r10             |
  3: if r0 > 16 goto ...  | mark r0,r1 as precise
  2: if r1 < 8  goto ...  | mark r0,r1 as precise
  1: r1 = r0              v

Technically, do this as follows:
- Use 10 bits to identify each register that gains range because of
  sync_linked_regs():
  - 3 bits for frame number;
  - 6 bits for register or stack slot number;
  - 1 bit to indicate if register is spilled.
- Use u64 as a vector of 6 such records + 4 bits for vector length.
- Augment struct bpf_jmp_history_entry with a field 'linked_regs'
  representing such vector.
- When doing check_cond_jmp_op() remember up to 6 registers that
  gain range because of sync_linked_regs() in such a vector.
- Don't propagate range information and reset IDs for registers that
  don't fit in 6-value vector.
- Push a pair {instruction index, linked registers vector}
  to bpf_verifier_state->jmp_history.
- When doing backtrack_insn() check if any of recorded linked
  registers is currently marked precise, if so mark all linked
  registers as precise.

This also requires fixes for two test_verifier tests:
- precise: test 1
- precise: test 2

Both tests contain the following instruction sequence:

19: (bf) r2 = r9                      ; R2=scalar(id=3) R9=scalar(id=3)
20: (a5) if r2 < 0x8 goto pc+1        ; R2=scalar(id=3,umin=8)
21: (95) exit
22: (07) r2 += 1                      ; R2_w=scalar(id=3+1,...)
23: (bf) r1 = r10                     ; R1_w=fp0 R10=fp0
24: (07) r1 += -8                     ; R1_w=fp-8
25: (b7) r3 = 0                       ; R3_w=0
26: (85) call bpf_probe_read_kernel#113

The call to bpf_probe_read_kernel() at (26) forces r2 to be precise.
Previously, this forced all registers with same id to become precise
immediately when mark_chain_precision() is called.
After this change, the precision is propagated to registers sharing
same id only when 'if' instruction is backtracked.
Hence verification log for both tests is changed:
regs=r2,r9 -> regs=r2 for instructions 25..20.

Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/verifier.c                         | 248 ++++++++++++++++--
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |  20 +-
 4 files changed, 242 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6503c85b10a3..731a0a4ac13c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -371,6 +371,10 @@ struct bpf_jmp_history_entry {
 	u32 prev_idx : 22;
 	/* special flags, e.g., whether insn is doing register stack spill/load */
 	u32 flags : 10;
+	/* additional registers that need precision tracking when this
+	 * jump is backtracked, vector of six 10-bit records
+	 */
+	u64 linked_regs;
 };
 
 /* Maximum number of register states that can exist at once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..5d44ab3cbb2f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3335,9 +3335,87 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+#define LR_FRAMENO_BITS	3
+#define LR_SPI_BITS	6
+#define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
+#define LR_SIZE_BITS	4
+#define LR_FRAMENO_MASK	((1ull << LR_FRAMENO_BITS) - 1)
+#define LR_SPI_MASK	((1ull << LR_SPI_BITS)     - 1)
+#define LR_SIZE_MASK	((1ull << LR_SIZE_BITS)    - 1)
+#define LR_SPI_OFF	LR_FRAMENO_BITS
+#define LR_IS_REG_OFF	(LR_SPI_BITS + LR_FRAMENO_BITS)
+#define LINKED_REGS_MAX	6
+
+struct linked_reg {
+	u8 frameno;
+	union {
+		u8 spi;
+		u8 regno;
+	};
+	bool is_reg;
+};
+
+struct linked_regs {
+	int cnt;
+	struct linked_reg entries[LINKED_REGS_MAX];
+};
+
+static struct linked_reg *linked_regs_push(struct linked_regs *s)
+{
+	if (s->cnt < LINKED_REGS_MAX)
+		return &s->entries[s->cnt++];
+
+	return NULL;
+}
+
+/* Use u64 as a vector of 6 10-bit values, use first 4-bits to track
+ * number of elements currently in stack.
+ * Pack one history entry for linked registers as 10 bits in the following format:
+ * - 3-bits frameno
+ * - 6-bits spi_or_reg
+ * - 1-bit  is_reg
+ */
+static u64 linked_regs_pack(struct linked_regs *s)
+{
+	u64 val = 0;
+	int i;
+
+	for (i = 0; i < s->cnt; ++i) {
+		struct linked_reg *e = &s->entries[i];
+		u64 tmp = 0;
+
+		tmp |= e->frameno;
+		tmp |= e->spi << LR_SPI_OFF;
+		tmp |= (e->is_reg ? 1 : 0) << LR_IS_REG_OFF;
+
+		val <<= LR_ENTRY_BITS;
+		val |= tmp;
+	}
+	val <<= LR_SIZE_BITS;
+	val |= s->cnt;
+	return val;
+}
+
+static void linked_regs_unpack(u64 val, struct linked_regs *s)
+{
+	int i;
+
+	s->cnt = val & LR_SIZE_MASK;
+	val >>= LR_SIZE_BITS;
+
+	for (i = 0; i < s->cnt; ++i) {
+		struct linked_reg *e = &s->entries[i];
+
+		e->frameno =  val & LR_FRAMENO_MASK;
+		e->spi     = (val >> LR_SPI_OFF) & LR_SPI_MASK;
+		e->is_reg  = (val >> LR_IS_REG_OFF) & 0x1;
+		val >>= LR_ENTRY_BITS;
+	}
+}
+
 /* for any branch, call, exit record the history of jmps in the given state */
 static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags)
+			    int insn_flags, u64 linked_regs)
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_jmp_history_entry *p;
@@ -3353,6 +3431,10 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
 			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
 		env->cur_hist_ent->flags |= insn_flags;
+		WARN_ONCE(env->cur_hist_ent->linked_regs != 0,
+			  "verifier insn history bug: insn_idx %d linked_regs != 0: %#llx\n",
+			  env->insn_idx, env->cur_hist_ent->linked_regs);
+		env->cur_hist_ent->linked_regs = linked_regs;
 		return 0;
 	}
 
@@ -3367,6 +3449,7 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 	p->idx = env->insn_idx;
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
+	p->linked_regs = linked_regs;
 	cur->jmp_history_cnt = cnt;
 	env->cur_hist_ent = p;
 
@@ -3532,6 +3615,11 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
 	return bt->reg_masks[bt->frame] & (1 << reg);
 }
 
+static inline bool bt_is_frame_reg_set(struct backtrack_state *bt, u32 frame, u32 reg)
+{
+	return bt->reg_masks[frame] & (1 << reg);
+}
+
 static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
 {
 	return bt->stack_masks[frame] & (1ull << slot);
@@ -3576,6 +3664,42 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 	}
 }
 
+/* If any register R in hist->linked_regs is marked as precise in bt,
+ * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_regs.
+ */
+static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
+{
+	struct linked_regs linked_regs;
+	bool some_precise = false;
+	int i;
+
+	if (!hist || hist->linked_regs == 0)
+		return;
+
+	linked_regs_unpack(hist->linked_regs, &linked_regs);
+	for (i = 0; i < linked_regs.cnt; ++i) {
+		struct linked_reg *e = &linked_regs.entries[i];
+
+		if ((e->is_reg && bt_is_frame_reg_set(bt, e->frameno, e->regno)) ||
+		    (!e->is_reg && bt_is_frame_slot_set(bt, e->frameno, e->spi))) {
+			some_precise = true;
+			break;
+		}
+	}
+
+	if (!some_precise)
+		return;
+
+	for (i = 0; i < linked_regs.cnt; ++i) {
+		struct linked_reg *e = &linked_regs.entries[i];
+
+		if (e->is_reg)
+			bt_set_frame_reg(bt, e->frameno, e->regno);
+		else
+			bt_set_frame_slot(bt, e->frameno, e->spi);
+	}
+}
+
 static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 
 /* For given verifier state backtrack_insn() is called from the last insn to
@@ -3615,6 +3739,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
 
+	/* If there is a history record that some registers gained range at this insn,
+	 * propagate precision marks to those registers, so that bt_is_reg_set()
+	 * accounts for these registers.
+	 */
+	bt_sync_linked_regs(bt, hist);
+
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (!bt_is_reg_set(bt, dreg))
 			return 0;
@@ -3844,7 +3974,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			bt_set_reg(bt, dreg);
 			bt_set_reg(bt, sreg);
-			 /* else dreg <cond> K
+		} else if (BPF_SRC(insn->code) == BPF_K) {
+			 /* dreg <cond> K
 			  * Only dreg still needs precision before
 			  * this insn, so for the K-based conditional
 			  * there is nothing new to be marked.
@@ -3862,6 +3993,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			/* to be analyzed */
 			return -ENOTSUPP;
 	}
+	/* Propagate precision marks to linked registers, to account for
+	 * registers marked as precise in this function.
+	 */
+	bt_sync_linked_regs(bt, hist);
 	return 0;
 }
 
@@ -4456,7 +4591,7 @@ static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 
 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
 		/* Ensure that src_reg has a valid ID that will be copied to
-		 * dst_reg and then will be used by find_equal_scalars() to
+		 * dst_reg and then will be used by sync_linked_regs() to
 		 * propagate min/max range.
 		 */
 		src_reg->id = ++env->id_gen;
@@ -4625,7 +4760,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -4930,7 +5065,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -14099,7 +14234,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		u64 val = reg_const_value(src_reg, alu32);
 
 		if ((dst_reg->id & BPF_ADD_CONST) ||
-		    /* prevent overflow in find_equal_scalars() later */
+		    /* prevent overflow in sync_linked_regs() later */
 		    val > (u32)S32_MAX) {
 			/*
 			 * If the register already went through rX += val
@@ -14114,7 +14249,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	} else {
 		/*
 		 * Make sure ID is cleared otherwise dst_reg min/max could be
-		 * incorrectly propagated into other registers by find_equal_scalars()
+		 * incorrectly propagated into other registers by sync_linked_regs()
 		 */
 		dst_reg->id = 0;
 	}
@@ -14264,7 +14399,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						copy_register_state(dst_reg, src_reg);
 						/* Make sure ID is cleared if src_reg is not in u32
 						 * range otherwise dst_reg min/max could be incorrectly
-						 * propagated into src_reg by find_equal_scalars()
+						 * propagated into src_reg by sync_linked_regs()
 						 */
 						if (!is_src_reg_u32)
 							dst_reg->id = 0;
@@ -15087,14 +15222,69 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
-static void find_equal_scalars(struct bpf_verifier_state *vstate,
-			       struct bpf_reg_state *known_reg)
+static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf_reg_state *reg,
+				  u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
+{
+	struct linked_reg *e;
+
+	if (reg->type != SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) != id)
+		return;
+
+	e = linked_regs_push(reg_set);
+	if (e) {
+		e->frameno = frameno;
+		e->is_reg = is_reg;
+		e->regno = spi_or_reg;
+	} else {
+		reg->id = 0;
+	}
+}
+
+/* For all R being scalar registers or spilled scalar registers
+ * in verifier state, save R in linked_regs if R->id == id.
+ * If there are too many Rs sharing same id, reset id for leftover Rs.
+ */
+static void collect_linked_regs(struct bpf_verifier_state *vstate, u32 id,
+				struct linked_regs *linked_regs)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	int i, j;
+
+	id = id & ~BPF_ADD_CONST;
+	for (i = vstate->curframe; i >= 0; i--) {
+		func = vstate->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			__collect_linked_regs(linked_regs, reg, id, i, j, true);
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			__collect_linked_regs(linked_regs, reg, id, i, j, false);
+		}
+	}
+
+	if (linked_regs->cnt == 1)
+		linked_regs->cnt = 0;
+}
+
+/* For all R in linked_regs, copy known_reg range into R
+ * if R->id == known_reg->id.
+ */
+static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_state *known_reg,
+			     struct linked_regs *linked_regs)
 {
 	struct bpf_reg_state fake_reg;
-	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
+	struct linked_reg *e;
+	int i;
 
-	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
+	for (i = 0; i < linked_regs->cnt; ++i) {
+		e = &linked_regs->entries[i];
+		reg = e->is_reg ? &vstate->frame[e->frameno]->regs[e->regno]
+				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
 		if (reg->type != SCALAR_VALUE || reg == known_reg)
 			continue;
 		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
@@ -15112,7 +15302,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			copy_register_state(reg, known_reg);
 			/*
 			 * Must preserve off, id and add_const flag,
-			 * otherwise another find_equal_scalars() will be incorrect.
+			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
 			reg->off = saved_off;
 
@@ -15120,7 +15310,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
 		}
-	}));
+	}
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
@@ -15131,6 +15321,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
+	struct linked_regs linked_regs = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
 	int pred = -1;
@@ -15245,6 +15436,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	/* Push scalar registers sharing same ID to jump history,
+	 * do this before creating 'other_branch', so that both
+	 * 'this_branch' and 'other_branch' share this history
+	 * if parent state is created.
+	 */
+	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
+		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
+	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
+		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
+	if (linked_regs.cnt > 0) {
+		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		if (err)
+			return err;
+	}
+
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
 	if (!other_branch)
@@ -15275,13 +15481,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-		find_equal_scalars(this_branch, src_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+		sync_linked_regs(this_branch, src_reg, &linked_regs);
+		sync_linked_regs(other_branch, &other_branch_regs[insn->src_reg], &linked_regs);
 	}
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		find_equal_scalars(this_branch, dst_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
+		sync_linked_regs(this_branch, dst_reg, &linked_regs);
+		sync_linked_regs(other_branch, &other_branch_regs[insn->dst_reg], &linked_regs);
 	}
 
 	/* if one pointer register is compared to another pointer
@@ -16770,7 +16976,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 *
 		 * First verification path is [1-6]:
 		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
-		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 * - at (5) r6 would be marked <= X, sync_linked_regs() would also mark
 		 *   r7 <= X, because r6 and r7 share same id.
 		 * Next verification path is [1-4, 6].
 		 *
@@ -17563,7 +17769,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0);
+				err = err ? : push_jmp_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17831,7 +18037,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0);
+			err = push_jmp_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 6a6fad625f7e..9d415f7ce599 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -278,7 +278,7 @@ __msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
-__msg("mark_precise: frame0: regs=r6 stack= before 10: (bf) r6 = r0")
+__msg("mark_precise: frame0: regs=r0,r6 stack= before 10: (bf) r6 = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
 /* State entering callback body popped from states stack */
 __msg("from 9 to 17: frame1:")
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 90643ccc221d..64d722199e8f 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -39,11 +39,11 @@
 	.result = VERBOSE_ACCEPT,
 	.errstr =
 	"mark_precise: frame0: last_idx 26 first_idx 20\
-	mark_precise: frame0: regs=r2,r9 stack= before 25\
-	mark_precise: frame0: regs=r2,r9 stack= before 24\
-	mark_precise: frame0: regs=r2,r9 stack= before 23\
-	mark_precise: frame0: regs=r2,r9 stack= before 22\
-	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: regs=r2 stack= before 25\
+	mark_precise: frame0: regs=r2 stack= before 24\
+	mark_precise: frame0: regs=r2 stack= before 23\
+	mark_precise: frame0: regs=r2 stack= before 22\
+	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
@@ -100,11 +100,11 @@
 	.errstr =
 	"26: (85) call bpf_probe_read_kernel#113\
 	mark_precise: frame0: last_idx 26 first_idx 22\
-	mark_precise: frame0: regs=r2,r9 stack= before 25\
-	mark_precise: frame0: regs=r2,r9 stack= before 24\
-	mark_precise: frame0: regs=r2,r9 stack= before 23\
-	mark_precise: frame0: regs=r2,r9 stack= before 22\
-	mark_precise: frame0: parent state regs=r2,r9 stack=:\
+	mark_precise: frame0: regs=r2 stack= before 25\
+	mark_precise: frame0: regs=r2 stack= before 24\
+	mark_precise: frame0: regs=r2 stack= before 23\
+	mark_precise: frame0: regs=r2 stack= before 22\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs=r2,r9 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
-- 
2.45.2


