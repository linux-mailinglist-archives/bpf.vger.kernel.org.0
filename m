Return-Path: <bpf+bounces-32013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D590612A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E96FB22186
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA71A269;
	Thu, 13 Jun 2024 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0mLJlEz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4ED168D0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242711; cv=none; b=eDv/H6ymQX4YVf+PbBJtOY07EAjaskS0kpGzgcxhLI2KhXRBgdMh1muipzG2m0YEUBBawTpNNCGXpDXUPUjGNTO8pxNMUGYy83ZK++dx55TLShPnSQCK0N/dG+Y3pjXSwzLC9/fiozXwHj3a1gDhIPLaB1h24rmh6uu3gK0SKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242711; c=relaxed/simple;
	bh=zgngmNcyOk//N6htq6R9dUV+AgfmK5lbqflXO/+aJgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCwqscmFVOfQISKrlO+T1YeSFn2tumRuIVsDNBr+Lu+OeLW9FQ4Mo5t+g8GFgXC2DGxtZbrQU3DFArrepmlW1thrDwnHwexA4lEU6kOSrHaNlhNnvmu29IwZJTxpMJHdv6SL0r+HNxqOp3DjDB+xDjOxl2g4arO1d9QqrbCFnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0mLJlEz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-681ad081695so354075a12.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 18:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242708; x=1718847508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njrV3v7woP1cH7iimvXxDwEswIq9Y84fcQp3rkMvhAU=;
        b=F0mLJlEzWN0U2O6++Jibrge5F07YQnnOZAzGEagaa9AEhiS0WweF42nLCErXROiDhU
         Ll+ovQglygS8HnSTgOcDLEPkc3090YUC7iqQTZ6NZZ/WGIwfM30pyLhegdb8Vewk7uia
         dYH/Fos6Th/n/XBT6xFsdoPliXyqhbxzxDr79/zEdTiD30Jzd0KwfPTsCCa5kHnExmsP
         YHPDAupZ0vyiXsiYLAIrVKtu+Oq/6OL0uSMbXKJkdo6ZU9Ee8vZIhhdjo9Sl/bXKL6Sk
         8zYAj+WkThm074xEtCU6Siu+Q5UZjLJcZNCnY/G2NmHZTXduWeChl0BsJBg+HkiTH9d2
         8mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242708; x=1718847508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njrV3v7woP1cH7iimvXxDwEswIq9Y84fcQp3rkMvhAU=;
        b=ZNP5yxdMqZUgIaT11Ie+rgE906qeAiV2uqKHiAHO2NWPC2Q+LUaO/mC+3am+dyuOad
         c1g/UFeaeOj6IZ8eH8CcQWA/1ATQwmMFaOxbWnmm9q98KsBoG8hYwkqeIEtdHM6FtNn5
         8YL5aEEzpAs+OFZ0yUnL+qo15i6TWGRPtNB0ugxE0Abi36z7295kMV3amlJ/wMYyJGUL
         +liSXzfDpNlXvwdsaXw37SEXJTMICUA2RNFqrEeMVaVdSaCFkvRIk8k6LfwQ8/W99zv2
         WyZf/m/3DD0C2A0VVydpnGg9eM1jRO+7avx8Xlbho1f5c0Qt8D1MO6gfWGwQamL7TApK
         wwFw==
X-Gm-Message-State: AOJu0YyvF0NMJb94KXzFMVp07CYhnVLh+1y3MYi5keO7kV/xMNeMkXhl
	SEPVKOOp3kpf2UFhlVt03Y5n8AgP9Dbe/7rXn4eizqwGviX/Lz+71fUaaQ==
X-Google-Smtp-Source: AGHT+IEkYyC3JUAYYRiuGqQifRu3/QcB8zMOBU3SpQjrtAAB1l5aww3T1ebNvcr5ZEk530cXSFgVag==
X-Received: by 2002:a05:6a20:6a0f:b0:1b5:d173:338c with SMTP id adf61e73a8af0-1b8a9b4ebb0mr4381133637.23.1718242707499;
        Wed, 12 Jun 2024 18:38:27 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:b914])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7602690sm2600317a91.28.2024.06.12.18.38.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 18:38:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 2/4] bpf: Track delta between "linked" registers.
Date: Wed, 12 Jun 2024 18:38:13 -0700
Message-Id: <20240613013815.953-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240613013815.953-1-alexei.starovoitov@gmail.com>
References: <20240613013815.953-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Compilers can generate the code
  r1 = r2
  r1 += 0x1
  if r2 < 1000 goto ...
  use knowledge of r2 range in subsequent r1 operations

So remember constant delta between r2 and r1 and update r1 after 'if' condition.

Unfortunately LLVM still uses this pattern for loops with 'can_loop' construct:
for (i = 0; i < 1000 && can_loop; i++)

The "undo" pass was introduced in LLVM
https://reviews.llvm.org/D121937
to prevent this optimization, but it cannot cover all cases.
Instead of fighting middle end optimizer in BPF backend teach the verifier
about this pattern.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  | 12 ++-
 kernel/bpf/log.c                              |  4 +-
 kernel/bpf/verifier.c                         | 95 ++++++++++++++++---
 .../testing/selftests/bpf/verifier/precise.c  | 22 ++---
 4 files changed, 109 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50aa87f8d77f..2b54e25d2364 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -73,7 +73,10 @@ enum bpf_iter_state {
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
-	/* Fixed part of pointer offset, pointer types only */
+	/*
+	 * Fixed part of pointer offset, pointer types only.
+	 * Or constant delta between "linked" scalars with the same ID.
+	 */
 	s32 off;
 	union {
 		/* valid when type == PTR_TO_PACKET */
@@ -167,6 +170,13 @@ struct bpf_reg_state {
 	 * Similarly to dynptrs, we use ID to track "belonging" of a reference
 	 * to a specific instance of bpf_iter.
 	 */
+	/*
+	 * Upper bit of ID is used to remember relationship between "linked"
+	 * registers. Example:
+	 * r1 = r2;    both will have r1->id == r2->id == N
+	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
+	 */
+#define BPF_ADD_CONST (1U << 31)
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
 	 * from a pointer-cast helper, bpf_sk_fullsock() and
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 4bd8f17a9f24..3f4ae92e549f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -708,7 +708,9 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 	verbose(env, "(");
 	if (reg->id)
-		verbose_a("id=%d", reg->id);
+		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
+	if (reg->id & BPF_ADD_CONST)
+		verbose(env, "%+d", reg->off);
 	if (reg->ref_obj_id)
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (type_is_non_owning_ref(reg->type))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20ac9cfd54dd..983bc4608adc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3991,7 +3991,7 @@ static bool idset_contains(struct bpf_idset *s, u32 id)
 	u32 i;
 
 	for (i = 0; i < s->count; ++i)
-		if (s->ids[i] == id)
+		if (s->ids[i] == (id & ~BPF_ADD_CONST))
 			return true;
 
 	return false;
@@ -4001,7 +4001,7 @@ static int idset_push(struct bpf_idset *s, u32 id)
 {
 	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
 		return -EFAULT;
-	s->ids[s->count++] = id;
+	s->ids[s->count++] = id & ~BPF_ADD_CONST;
 	return 0;
 }
 
@@ -4438,8 +4438,20 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
-	if (src_reg->type == SCALAR_VALUE && !src_reg->id &&
-	    !tnum_is_const(src_reg->var_off))
+	if (src_reg->type != SCALAR_VALUE)
+		return;
+
+	if (src_reg->id & BPF_ADD_CONST) {
+		/*
+		 * The verifier is processing rX = rY insn and
+		 * rY->id has special linked register already.
+		 * Cleared it, since multiple rX += const are not supported.
+		 */
+		src_reg->id = 0;
+		src_reg->off = 0;
+	}
+
+	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
 		/* Ensure that src_reg has a valid ID that will be copied to
 		 * dst_reg and then will be used by find_equal_scalars() to
 		 * propagate min/max range.
@@ -14034,6 +14046,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
@@ -14056,11 +14069,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
-	else
-		/* Make sure ID is cleared otherwise dst_reg min/max could be
-		 * incorrectly propagated into other registers by find_equal_scalars()
-		 */
-		dst_reg->id = 0;
+
 	if (BPF_SRC(insn->code) == BPF_X) {
 		src_reg = &regs[insn->src_reg];
 		if (src_reg->type != SCALAR_VALUE) {
@@ -14124,7 +14133,43 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EINVAL;
 	}
-	return adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
+	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
+	if (err)
+		return err;
+	/*
+	 * Compilers can generate the code
+	 * r1 = r2
+	 * r1 += 0x1
+	 * if r2 < 1000 goto ...
+	 * use r1 in memory access
+	 * So remember constant delta between r2 and r1 and update r1 after
+	 * 'if' condition.
+	 */
+	if (env->bpf_capable && BPF_OP(insn->code) == BPF_ADD &&
+	    dst_reg->id && is_reg_const(src_reg, alu32)) {
+		u64 val = reg_const_value(src_reg, alu32);
+
+		if ((dst_reg->id & BPF_ADD_CONST) ||
+		    /* prevent overflow in find_equal_scalars() later */
+		    val > (u32)S32_MAX) {
+			/*
+			 * If the register already went through rX += val
+			 * we cannot accumulate another val into rx->off.
+			 */
+			dst_reg->off = 0;
+			dst_reg->id = 0;
+		} else {
+			dst_reg->id |= BPF_ADD_CONST;
+			dst_reg->off = val;
+		}
+	} else {
+		/*
+		 * Make sure ID is cleared otherwise dst_reg min/max could be
+		 * incorrectly propagated into other registers by find_equal_scalars()
+		 */
+		dst_reg->id = 0;
+	}
+	return 0;
 }
 
 /* check validity of 32-bit and 64-bit arithmetic operations */
@@ -15096,12 +15141,36 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			       struct bpf_reg_state *known_reg)
 {
+	struct bpf_reg_state fake_reg;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type != SCALAR_VALUE || reg == known_reg)
+			continue;
+		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
+			continue;
+		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
+		    reg->off == known_reg->off) {
 			copy_register_state(reg, known_reg);
+		} else {
+			s32 saved_off = reg->off;
+
+			fake_reg.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
+
+			/* reg = known_reg; reg += delta */
+			copy_register_state(reg, known_reg);
+			/*
+			 * Must preserve off, id and add_const flag,
+			 * otherwise another find_equal_scalars() will be incorrect.
+			 */
+			reg->off = saved_off;
+
+			scalar32_min_max_add(reg, &fake_reg);
+			scalar_min_max_add(reg, &fake_reg);
+			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
+		}
 	}));
 }
 
@@ -16730,6 +16799,10 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		}
 		if (!rold->precise && exact == NOT_EXACT)
 			return true;
+		if ((rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
+			return false;
+		if ((rold->id & BPF_ADD_CONST) && (rold->off != rcur->off))
+			return false;
 		/* Why check_ids() for scalar registers?
 		 *
 		 * Consider the following BPF code:
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 0a9293a57211..90643ccc221d 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -39,12 +39,12 @@
 	.result = VERBOSE_ACCEPT,
 	.errstr =
 	"mark_precise: frame0: last_idx 26 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
+	mark_precise: frame0: regs=r2,r9 stack= before 25\
+	mark_precise: frame0: regs=r2,r9 stack= before 24\
+	mark_precise: frame0: regs=r2,r9 stack= before 23\
+	mark_precise: frame0: regs=r2,r9 stack= before 22\
+	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
@@ -100,11 +100,11 @@
 	.errstr =
 	"26: (85) call bpf_probe_read_kernel#113\
 	mark_precise: frame0: last_idx 26 first_idx 22\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: parent state regs=r2 stack=:\
+	mark_precise: frame0: regs=r2,r9 stack= before 25\
+	mark_precise: frame0: regs=r2,r9 stack= before 24\
+	mark_precise: frame0: regs=r2,r9 stack= before 23\
+	mark_precise: frame0: regs=r2,r9 stack= before 22\
+	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs=r2,r9 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
-- 
2.43.0


