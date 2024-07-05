Return-Path: <bpf+bounces-33969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA1928E68
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956361C22163
	for <lists+bpf@lfdr.de>; Fri,  5 Jul 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640B1459FD;
	Fri,  5 Jul 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCVYd9he"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A81144D21
	for <bpf@vger.kernel.org>; Fri,  5 Jul 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213148; cv=none; b=VnbD9i0su3AUtj6OZuUg8tmsyCEPQi9jSnVjy39nQZneqZFKScEKWw3dB3pyK3D9vZ9lBVY3PKqObYi0jOBxaXQLi80Fe2DwdKNePmwgGuDua6RsfaDlYCe4ZP6HmGca/Itvd+N7821lQFMYCi0/9dEbLm7f0SlRENcZ9BJ6F5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213148; c=relaxed/simple;
	bh=P6uRfw9BCPxoxV2dw6YLfmdN8r3eKNpQ33XFA84dm0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKrGbMkLerhJYoWiZ0O6yC9tmApks+iXaqUTDYfsigq/Pp6rF/rO0ZVyvNlpSW6hjhS4WWJZd+VeC4yGSt/8j//xCo2GJdoxXNYoOHOw/ju1W+6EY1uRCuuiEqDPzkyAnhTDxV0taMTgoZBC4J9P+4Z7q1v7VpsutbTErUkEI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCVYd9he; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1faad2f1967so22322945ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720213146; x=1720817946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fozi5LiTuziQTjTNkaVxe3WHHJIci5TysCjJHjXxvC8=;
        b=MCVYd9herXHVTPHbbmOtlBwlUZlfo+EppwUXtNQrY/FaQKER1ZECz/erWJIoh85/gf
         BZOqcvOBj5pHX6wwArYEAEIoAZWKJ0vhpomRnpNhC475q5rTFir1P9zNpAAp7//2Yc6A
         fPhXpUabdmVjtR6rj1eSGm4ojitz/7xGC9S3NsRpVouHXVleIkmeis9qrO400AZRpF1I
         OSYFDHphXegfXkg+3HAsT4dksBRmdmjP3U4sb0LqCLn4y14i0gF8avFmtPChDNZ7jfsl
         2gY3CxTYmKyPXAPlP2iN8kWYktNBd5Fxhfzbg+uzYjXJAMjbiA0Dy0ChxbWXpdqR5Ct6
         110w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213146; x=1720817946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fozi5LiTuziQTjTNkaVxe3WHHJIci5TysCjJHjXxvC8=;
        b=RuqwZpJ9B4bzsvyhjydi4esOVmuBA/b0OVTKG+KStMQqCfBHUzKJ04VZN1HGWHIgNk
         H8z2lf2daPU4To/uGF1t+/oEVYCddeutXTHMvdoC0L41s8Mkxj+Y4+ok+V6lg4jLNHCC
         5om/X+EisiV+W+myAH2cOPDCwNEMi5su2Izc/ycD8V2kJtiQ/EzTiCAHqAIwV2MSRzvq
         LNLS47sw8y8c/L26TMSXnlK/FQon5pRngLvfrBA4Dfevsr1MZeS0hFUTXvmXUNkiZiJi
         KH5B3y5bfq5ZqBX206x9z+xr+l0XA81yASCry5hrrqpW8yBYf3wYEXZwsdCQEF8Ledy9
         sdxw==
X-Gm-Message-State: AOJu0Yx9QSZffRPHfMH4HV9oNDTOXjHOaMhmtgJEB9H8JtykfjrdQSz9
	va4dRnE9ljWUMhSzOsegeRRL34vSTF6haD1zomxDLF5ieTdAVq2prXeSVf5i
X-Google-Smtp-Source: AGHT+IE+OP90d/yRNnWZKOHu28nzz1h/wq1Plfr8V63BJJ8kW5UV1smz3e7Gh3WxG70hmmV3nWTezw==
X-Received: by 2002:a17:902:e745:b0:1f6:3580:65c9 with SMTP id d9443c01a7336-1fb370a0fc4mr74503605ad.26.1720213145694;
        Fri, 05 Jul 2024 13:59:05 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8c52sm144767705ad.112.2024.07.05.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 13:59:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history on per-instruction level
Date: Fri,  5 Jul 2024 13:58:48 -0700
Message-ID: <20240705205851.2635794-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705205851.2635794-1-eddyz87@gmail.com>
References: <20240705205851.2635794-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_verifier_state->jmp_history to track which registers were
updated by find_equal_scalars() when conditional jump was verified.
Use recorded information in backtrack_insn() to propagate precision.

E.g. for the following program:

            while verifying instructions
  r1 = r0              |
  if r1 < 8  goto ...  | push r0,r1 as equal_scalars in jmp_history
  if r0 > 16 goto ...  | push r0,r1 as equal_scalars in jmp_history
  r2 = r10             |
  r2 += r0             v mark_chain_precision(r0)

            while doing mark_chain_precision(r0)
  r1 = r0              ^
  if r1 < 8  goto ...  | mark r0,r1 as precise
  if r0 > 16 goto ...  | mark r0,r1 as precise
  r2 = r10             |
  r2 += r0             | mark r0 precise

Technically, achieve this as follows:
- Use 10 bits to identify each register that gains range because of
  find_equal_scalars():
  - 3 bits for frame number;
  - 6 bits for register or stack slot number;
  - 1 bit to indicate if register is spilled.
- Use u64 as a vector of 6 such records + 4 bits for vector length.
- Augment struct bpf_jmp_history_entry with field 'linked_regs'
  representing such vector.
- When doing check_cond_jmp_op() remember up to 6 registers that
  gain range because of find_equal_scalars() in such a vector.
- Don't propagate range information and reset IDs for registers that
  don't fit in 6-value vector.
- Push a pair {instruction index, equal scalars vector}
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
 kernel/bpf/verifier.c                         | 231 ++++++++++++++++--
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |  20 +-
 4 files changed, 232 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2b54e25d2364..da450552c278 100644
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
index e25ad5fb9115..ec493360607e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3335,9 +3335,87 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
 	return env->insn_aux_data[insn_idx].jmp_point;
 }
 
+#define ES_FRAMENO_BITS	3
+#define ES_SPI_BITS	6
+#define ES_ENTRY_BITS	(ES_SPI_BITS + ES_FRAMENO_BITS + 1)
+#define ES_SIZE_BITS	4
+#define ES_FRAMENO_MASK	((1ul << ES_FRAMENO_BITS) - 1)
+#define ES_SPI_MASK	((1ul << ES_SPI_BITS)     - 1)
+#define ES_SIZE_MASK	((1ul << ES_SIZE_BITS)    - 1)
+#define ES_SPI_OFF	ES_FRAMENO_BITS
+#define ES_IS_REG_OFF	(ES_SPI_BITS + ES_FRAMENO_BITS)
+#define LINKED_REGS_MAX	6
+
+struct reg_or_spill {
+	u8 frameno:3;
+	union {
+		u8 spi:6;
+		u8 regno:6;
+	};
+	bool is_reg:1;
+};
+
+struct linked_regs {
+	int cnt;
+	struct reg_or_spill entries[LINKED_REGS_MAX];
+};
+
+static struct reg_or_spill *linked_regs_push(struct linked_regs *s)
+{
+	if (s->cnt < LINKED_REGS_MAX)
+		return &s->entries[s->cnt++];
+
+	return NULL;
+}
+
+/* Use u64 as a vector of 6 10-bit values, use first 4-bits to track
+ * number of elements currently in stack.
+ * Pack one history entry for equal scalars as 10 bits in the following format:
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
+		struct reg_or_spill *e = &s->entries[i];
+		u64 tmp = 0;
+
+		tmp |= e->frameno;
+		tmp |= e->spi << ES_SPI_OFF;
+		tmp |= (e->is_reg ? 1 : 0) << ES_IS_REG_OFF;
+
+		val <<= ES_ENTRY_BITS;
+		val |= tmp;
+	}
+	val <<= ES_SIZE_BITS;
+	val |= s->cnt;
+	return val;
+}
+
+static void linked_regs_unpack(u64 val, struct linked_regs *s)
+{
+	int i;
+
+	s->cnt = val & ES_SIZE_MASK;
+	val >>= ES_SIZE_BITS;
+
+	for (i = 0; i < s->cnt; ++i) {
+		struct reg_or_spill *e = &s->entries[i];
+
+		e->frameno =  val & ES_FRAMENO_MASK;
+		e->spi     = (val >> ES_SPI_OFF) & ES_SPI_MASK;
+		e->is_reg  = (val >> ES_IS_REG_OFF) & 0x1;
+		val >>= ES_ENTRY_BITS;
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
+		struct reg_or_spill *e = &linked_regs.entries[i];
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
+		struct reg_or_spill *e = &linked_regs.entries[i];
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
@@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			bt_set_reg(bt, dreg);
 			bt_set_reg(bt, sreg);
+		} else if (BPF_SRC(insn->code) == BPF_K) {
 			 /* else dreg <cond> K
 			  * Only dreg still needs precision before
 			  * this insn, so for the K-based conditional
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
 
@@ -4624,7 +4759,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -4929,7 +5064,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -15154,14 +15289,66 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
-static void find_equal_scalars(struct bpf_verifier_state *vstate,
-			       struct bpf_reg_state *known_reg)
+static void __find_equal_scalars(struct linked_regs *reg_set, struct bpf_reg_state *reg,
+				 u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
+{
+	struct reg_or_spill *e;
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
+static void find_equal_scalars(struct bpf_verifier_state *vstate, u32 id,
+			       struct linked_regs *linked_regs)
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
+			__find_equal_scalars(linked_regs, reg, id, i, j, true);
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			__find_equal_scalars(linked_regs, reg, id, i, j, false);
+		}
+	}
+}
+
+/* For all R in linked_regs, copy known_reg range into R
+ * if R->id == known_reg->id.
+ */
+static void copy_known_reg(struct bpf_verifier_state *vstate, struct bpf_reg_state *known_reg,
+			   struct linked_regs *linked_regs)
 {
 	struct bpf_reg_state fake_reg;
-	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
+	struct reg_or_spill *e;
+	int i;
 
-	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
+	for (i = 0; i < linked_regs->cnt; ++i) {
+		e = &linked_regs->entries[i];
+		reg = e->is_reg ? &vstate->frame[e->frameno]->regs[e->regno]
+				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
 		if (reg->type != SCALAR_VALUE || reg == known_reg)
 			continue;
 		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
@@ -15187,7 +15374,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
 		}
-	}));
+	}
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
@@ -15198,6 +15385,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
+	struct linked_regs linked_regs = {};
 	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
 	bool is_jmp32;
@@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	/* Push scalar registers sharing same ID to jump history,
+	 * do this before creating 'other_branch', so that both
+	 * 'this_branch' and 'other_branch' share this history
+	 * if parent state is created.
+	 */
+	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
+		find_equal_scalars(this_branch, src_reg->id, &linked_regs);
+	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
+		find_equal_scalars(this_branch, dst_reg->id, &linked_regs);
+	if (linked_regs.cnt > 1) {
+		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		if (err)
+			return err;
+	}
+
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
 	if (!other_branch)
@@ -15336,13 +15539,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-		find_equal_scalars(this_branch, src_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+		copy_known_reg(this_branch, src_reg, &linked_regs);
+		copy_known_reg(other_branch, &other_branch_regs[insn->src_reg], &linked_regs);
 	}
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		find_equal_scalars(this_branch, dst_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
+		copy_known_reg(this_branch, dst_reg, &linked_regs);
+		copy_known_reg(other_branch, &other_branch_regs[insn->dst_reg], &linked_regs);
 	}
 
 	/* if one pointer register is compared to another pointer
@@ -17624,7 +17827,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0);
+				err = err ? : push_jmp_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17892,7 +18095,7 @@ static int do_check(struct bpf_verifier_env *env)
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


