Return-Path: <bpf+bounces-22477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4928D85EE4C
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F418428255F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54911C82;
	Thu, 22 Feb 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbq9OJLx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828D28EF
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563031; cv=none; b=vFG4UMjx5+EJEGVNjphe0lPUW4fNTdOdZy+JhPB/W8hd/ltTk7fI9SPqRT4SZX1x2jo3Do/RKKXohArlmO1g3mVker10QaP2/sHlGeOCNm40cHVNJxISi8wPHQKrYXSaLlNuMH4JQMKMII1BqtPuqD3lUZfHXCbYOnuzy/zVtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563031; c=relaxed/simple;
	bh=giGk+YWOjOMm7lj7SFnq2ZlMxbBOcgizsNChrkDC2qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/nKbrptGgpaOZlaADQuByoaurP/teP5JBboL+3s4Lb7AmRC9FbN8X3DIrLMLsFvlrxF3ykFZxjRlYhGaQ6usygL0QxRFD+f+jOxWnwaPVl88CbvgE46HdGamdFz0nF6LiTwGnL6ArKXDYDml85WAHlC2wLO+vN8QcVJPckiADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbq9OJLx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so58781061fa.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563027; x=1709167827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBhA5T/zsEAe6jZ1c9b7hpb8cI83Ga6aj5fC7T+/iqE=;
        b=Gbq9OJLxv9Il0ZDUg3aaeR+sGAM6BfAJJQUVoyDvLYrYZoqnK++sHB1KV3/y+xmP4d
         NaXjBbHCmue2ka7KA3O5ndA/Vl3cIDS5hZC6ESRpURV3bvNRPFC5vQR7CElBcftouwbR
         aFcQWigVrTgSkfAb/uykjgxDz/7iPZtZ/TMV9btyLFZonZgbqdyoEG/rp0dus6R+JU/c
         uCOFeQvU5Nlxp3HW2mwUSOAjOeneyLjTi2lOb9+fGnS69lk/WCUopqX6Ndd38RdHtw8D
         xMVaggjKTHNaAUawTv0vIsk0oQXG2R8SvcRsdQgLuv0KBczVmec8tu++D9GWz0Pi4HLQ
         +kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563027; x=1709167827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBhA5T/zsEAe6jZ1c9b7hpb8cI83Ga6aj5fC7T+/iqE=;
        b=evmLMVHQLc8pKdGxdQk1y0FIlUUMp3i0cfGujXnZXAZvqQHuE0G7nRYczwNwk2GLCP
         ZrHpg8ZG9WWxAzOiSB/4qs2Zf85LJd+UIfMK+C5UxPg6P4Kdxj8P+UG7McmDi+F+KfA+
         s7ZrDisGoC1oue1d+Imnx8B3nW0ANmM+bpYXjJ+od/ObNiTmJExNhYzCNoKBcOUxR23X
         +r1aotUpwf4jrrSsUfPeGVqY9w5ogLFRU1ichEdiXjY4QR2xAyDjGL9HPmxaaU6zKuZG
         iWlqit1HwtmqBIx0RRKc9y9BUt9UuOOZHKQVWfZWZ0F1ZW3l1lT/ZsLEsVC6OpozdTgy
         wgxA==
X-Gm-Message-State: AOJu0Yw1lLPr/tTjsEG0mMWPibckU0FP47fok8udHtP/IT6L8wuj7Uv0
	XFbzyOf4EC5O5lSMiAcoHCxAR9i7bZjqsd53IpS9TIocdrX+A5CQFn5Z/fxH
X-Google-Smtp-Source: AGHT+IHZpbxEJ64t7R+3ypoQwVEauVr7cPUeEYrzXbo5zG32XRkk51NecSXAt9R6wrqdT7Ngg0S2hg==
X-Received: by 2002:a2e:2e0a:0:b0:2d2:3a2b:7ad3 with SMTP id u10-20020a2e2e0a000000b002d23a2b7ad3mr8534930lju.26.1708563026715;
        Wed, 21 Feb 2024 16:50:26 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0041279ac13adsm2031992wmq.36.2024.02.21.16.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:50:26 -0800 (PST)
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
Subject: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on per-instruction level
Date: Thu, 22 Feb 2024 02:50:03 +0200
Message-ID: <20240222005005.31784-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222005005.31784-1-eddyz87@gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
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

Technically achieve this in following steps:
- Use 10 bits to identify each register that gains range because of
  find_equal_scalars():
  - 3 bits for frame number;
  - 6 bits for register or stack slot number;
  - 1 bit to indicate if register is spilled.
- Use u64 as a vector of 6 such records + 4 bits for vector length.
- Augment struct bpf_jmp_history_entry with field 'equal_scalars'
  representing such vector.
- When doing check_cond_jmp_op() for remember up to 6 registers that
  gain range because of find_equal_scalars() in such a vector.
- Don't propagate range information and reset IDs for registers that
  don't fit in 6-value vector.
- Push collected vector to bpf_verifier_state->jmp_history for
  instruction index of conditional jump.
- When doing backtrack_insn() for conditional jumps
  check if any of recorded equal scalars is currently marked precise,
  if so mark all equal recorded scalars as precise.

Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/verifier.c                         | 207 ++++++++++++++++--
 .../bpf/progs/verifier_subprog_precision.c    |   2 +-
 .../testing/selftests/bpf/verifier/precise.c  |   2 +-
 4 files changed, 195 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cbfb235984c8..26e32555711c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
 	u32 prev_idx : 22;
 	/* special flags, e.g., whether insn is doing register stack spill/load */
 	u32 flags : 10;
+	u64 equal_scalars;
 };
 
 /* Maximum number of register states that can exist at once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 759ef089b33c..b95b6842703c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3304,6 +3304,76 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
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
+
+/* Pack one history entry for equal scalars as 10 bits in the following format:
+ * - 3-bits frameno
+ * - 6-bits spi_or_reg
+ * - 1-bit  is_reg
+ */
+static u64 equal_scalars_pack(u32 frameno, u32 spi_or_reg, bool is_reg)
+{
+	u64 val = 0;
+
+	val |= frameno & ES_FRAMENO_MASK;
+	val |= (spi_or_reg & ES_SPI_MASK) << ES_SPI_OFF;
+	val |= (is_reg ? 1 : 0) << ES_IS_REG_OFF;
+	return val;
+}
+
+static void equal_scalars_unpack(u64 val, u32 *frameno, u32 *spi_or_reg, bool *is_reg)
+{
+	*frameno    =  val & ES_FRAMENO_MASK;
+	*spi_or_reg = (val >> ES_SPI_OFF) & ES_SPI_MASK;
+	*is_reg     = (val >> ES_IS_REG_OFF) & 0x1;
+}
+
+static u32 equal_scalars_size(u64 equal_scalars)
+{
+	return equal_scalars & ES_SIZE_MASK;
+}
+
+/* Use u64 as a stack of 6 10-bit values, use first 4-bits to track
+ * number of elements currently in stack.
+ */
+static bool equal_scalars_push(u64 *equal_scalars, u32 frameno, u32 spi_or_reg, bool is_reg)
+{
+	u32 num;
+
+	num = equal_scalars_size(*equal_scalars);
+	if (num == 6)
+		return false;
+	*equal_scalars >>= ES_SIZE_BITS;
+	*equal_scalars <<= ES_ENTRY_BITS;
+	*equal_scalars |= equal_scalars_pack(frameno, spi_or_reg, is_reg);
+	*equal_scalars <<= ES_SIZE_BITS;
+	*equal_scalars |= num + 1;
+	return true;
+}
+
+static bool equal_scalars_pop(u64 *equal_scalars, u32 *frameno, u32 *spi_or_reg, bool *is_reg)
+{
+	u32 num;
+
+	num = equal_scalars_size(*equal_scalars);
+	if (num == 0)
+		return false;
+	*equal_scalars >>= ES_SIZE_BITS;
+	equal_scalars_unpack(*equal_scalars, frameno, spi_or_reg, is_reg);
+	*equal_scalars >>= ES_ENTRY_BITS;
+	*equal_scalars <<= ES_SIZE_BITS;
+	*equal_scalars |= num - 1;
+	return true;
+}
+
 static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
 							u32 hist_end, int insn_idx)
 {
@@ -3314,7 +3384,7 @@ static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_stat
 
 /* for any branch, call, exit record the history of jmps in the given state */
 static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags)
+			    int insn_flags, u64 equal_scalars)
 {
 	struct bpf_jmp_history_entry *p, *cur_hist_ent;
 	u32 cnt = cur->jmp_history_cnt;
@@ -3332,6 +3402,12 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
 			  env->insn_idx, cur_hist_ent->flags, insn_flags);
 		cur_hist_ent->flags |= insn_flags;
+		if (cur_hist_ent->equal_scalars != 0) {
+			verbose(env, "verifier bug: insn_idx %d equal_scalars != 0: %#llx\n",
+				env->insn_idx, cur_hist_ent->equal_scalars);
+			return -EFAULT;
+		}
+		cur_hist_ent->equal_scalars = equal_scalars;
 		return 0;
 	}
 
@@ -3346,6 +3422,7 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 	p->idx = env->insn_idx;
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
+	p->equal_scalars = equal_scalars;
 	cur->jmp_history_cnt = cnt;
 
 	return 0;
@@ -3502,6 +3579,11 @@ static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
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
@@ -3546,6 +3628,39 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 	}
 }
 
+/* If any register R in hist->equal_scalars is marked as precise in bt,
+ * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->equal_scalars.
+ */
+static void bt_set_equal_scalars(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
+{
+	bool is_reg, some_precise = false;
+	u64 equal_scalars;
+	u32 fr, spi;
+
+	if (!hist || hist->equal_scalars == 0)
+		return;
+
+	equal_scalars = hist->equal_scalars;
+	while (equal_scalars_pop(&equal_scalars, &fr, &spi, &is_reg)) {
+		if ((is_reg && bt_is_frame_reg_set(bt, fr, spi)) ||
+		    (!is_reg && bt_is_frame_slot_set(bt, fr, spi))) {
+			some_precise = true;
+			break;
+		}
+	}
+
+	if (!some_precise)
+		return;
+
+	equal_scalars = hist->equal_scalars;
+	while (equal_scalars_pop(&equal_scalars, &fr, &spi, &is_reg)) {
+		if (is_reg)
+			bt_set_frame_reg(bt, fr, spi);
+		else
+			bt_set_frame_slot(bt, fr, spi);
+	}
+}
+
 static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
 
 /* For given verifier state backtrack_insn() is called from the last insn to
@@ -3802,6 +3917,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			return 0;
 		} else if (BPF_SRC(insn->code) == BPF_X) {
+			bt_set_equal_scalars(bt, hist);
 			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
 				return 0;
 			/* dreg <cond> sreg
@@ -3812,6 +3928,9 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			bt_set_reg(bt, dreg);
 			bt_set_reg(bt, sreg);
+			bt_set_equal_scalars(bt, hist);
+		} else if (BPF_SRC(insn->code) == BPF_K) {
+			bt_set_equal_scalars(bt, hist);
 			 /* else dreg <cond> K
 			  * Only dreg still needs precision before
 			  * this insn, so for the K-based conditional
@@ -4579,7 +4698,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -4884,7 +5003,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags);
+		return push_jmp_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -14835,16 +14954,58 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 	return true;
 }
 
-static void find_equal_scalars(struct bpf_verifier_state *vstate,
-			       struct bpf_reg_state *known_reg)
+static void __find_equal_scalars(u64 *equal_scalars,
+				 struct bpf_reg_state *reg,
+				 u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
 {
-	struct bpf_func_state *state;
+	if (reg->type != SCALAR_VALUE || reg->id != id)
+		return;
+
+	if (!equal_scalars_push(equal_scalars, frameno, spi_or_reg, is_reg))
+		reg->id = 0;
+}
+
+/* For all R being scalar registers or spilled scalar registers
+ * in verifier state, save R in equal_scalars if R->id == id.
+ * If there are too many Rs sharing same id, reset id for leftover Rs.
+ */
+static void find_equal_scalars(struct bpf_verifier_state *vstate, u32 id, u64 *equal_scalars)
+{
+	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
+	int i, j;
 
-	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+	for (i = vstate->curframe; i >= 0; i--) {
+		func = vstate->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			__find_equal_scalars(equal_scalars, reg, id, i, j, true);
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			__find_equal_scalars(equal_scalars, reg, id, i, j, false);
+		}
+	}
+}
+
+/* For all R in equal_scalars, copy known_reg range into R
+ * if R->id == known_reg->id.
+ */
+static void copy_known_reg(struct bpf_verifier_state *vstate,
+			   struct bpf_reg_state *known_reg, u64 equal_scalars)
+{
+	struct bpf_reg_state *reg;
+	u32 fr, spi;
+	bool is_reg;
+
+	while (equal_scalars_pop(&equal_scalars, &fr, &spi, &is_reg)) {
+		reg = is_reg ? &vstate->frame[fr]->regs[spi]
+			     : &vstate->frame[fr]->stack[spi].spilled_ptr;
+		if (reg->id == known_reg->id)
 			copy_register_state(reg, known_reg);
-	}));
+	}
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
@@ -14857,6 +15018,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *eq_branch_regs;
 	struct bpf_reg_state fake_reg = {};
 	u8 opcode = BPF_OP(insn->code);
+	u64 equal_scalars = 0;
 	bool is_jmp32;
 	int pred = -1;
 	int err;
@@ -14944,6 +15106,21 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	/* Push scalar registers sharing same ID to jump history,
+	 * do this before creating 'other_branch', so that both
+	 * 'this_branch' and 'other_branch' share this history
+	 * if parent state is created.
+	 */
+	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
+		find_equal_scalars(this_branch, src_reg->id, &equal_scalars);
+	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
+		find_equal_scalars(this_branch, dst_reg->id, &equal_scalars);
+	if (equal_scalars_size(equal_scalars) > 1) {
+		err = push_jmp_history(env, this_branch, 0, equal_scalars);
+		if (err)
+			return err;
+	}
+
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
 	if (!other_branch)
@@ -14968,13 +15145,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-		find_equal_scalars(this_branch, src_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->src_reg]);
+		copy_known_reg(this_branch, src_reg, equal_scalars);
+		copy_known_reg(other_branch, &other_branch_regs[insn->src_reg], equal_scalars);
 	}
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id &&
 	    !WARN_ON_ONCE(dst_reg->id != other_branch_regs[insn->dst_reg].id)) {
-		find_equal_scalars(this_branch, dst_reg);
-		find_equal_scalars(other_branch, &other_branch_regs[insn->dst_reg]);
+		copy_known_reg(this_branch, dst_reg, equal_scalars);
+		copy_known_reg(other_branch, &other_branch_regs[insn->dst_reg], equal_scalars);
 	}
 
 	/* if one pointer register is compared to another pointer
@@ -17213,7 +17390,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0);
+				err = err ? : push_jmp_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -17477,7 +17654,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0);
+			err = push_jmp_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 6f5d19665cf6..2c7261834149 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -191,7 +191,7 @@ __msg("mark_precise: frame0: last_idx 14 first_idx 9")
 __msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
 __msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
 __msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
-__msg("mark_precise: frame0: regs=r6 stack= before 10: (bf) r6 = r0")
+__msg("mark_precise: frame0: regs=r0,r6 stack= before 10: (bf) r6 = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
 /* State entering callback body popped from states stack */
 __msg("from 9 to 17: frame1:")
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 0a9293a57211..64d722199e8f 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -44,7 +44,7 @@
 	mark_precise: frame0: regs=r2 stack= before 23\
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
+	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
-- 
2.43.0


