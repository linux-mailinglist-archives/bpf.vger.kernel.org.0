Return-Path: <bpf+bounces-31627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBE7900EF5
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 02:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1C283FC3
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAD28FA;
	Sat,  8 Jun 2024 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRAv0IYW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD48480
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807501; cv=none; b=ct9EA69i5tdSZrQ8mhC0SPDtibelBHpLBDwO01Wv9n2phZISOn45tRYmTZn07djaGKZ9so8UTQFagcGyGfO54TnR3pEGXT8MIUyFwCQ1pqcWOzdaJheyfk6HUlmjzBQdXyYa+gvr4MQSSRVT+BN5kFDEGWME37WxnbhI9FCUay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807501; c=relaxed/simple;
	bh=yEsXy2y7qkBPSOE5CsRjLKHfWK1kE7+Mntnbd+XSngE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtCC2cZABMgaUyw+/Y7lp1aRkMkc/he2Y8O+pjfZItnfWqqKUtklbbemhU3y6AScjiiIWRHf8E+jlY+cV+L+IkCKLMnRXGSIQzM+Vmr3CoO/ULHsBpCZsCNJ922/DELPIgDykXkKlHjtVWIngGJRt6Bd/ojOWFZuWuE5NGilHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRAv0IYW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7024791a950so2578992b3a.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2024 17:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807498; x=1718412298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZf0EHgmdIf50Bl79ZsaN7cmxd5qvbl03RzkcK+MKME=;
        b=ZRAv0IYW+b8U7soshouUT6TUJL52KhiRkLyboV9Vxe++iBcsebdX6TP8l63knx5oP9
         a0T/hXdGSCf1CDkAewHBplRdh+nm9L6SmBwoNd4xo06HXvSbF5hITyU1MMB05uI0nqQW
         CTEr5MnGbOJRcL2Qn7yHRq8YJOguRkDFkb6Ec/pi3UO9flLcaCxmVb6BQdWO11h1VV4I
         VVepRbYu5gOAVe4tUGtojymk3rxxU6w1Z0YB79vgOOTMjKLue/Cx7wDEIC0wiP2jCuQK
         dbBwV6MPaOgrkpJubuREyXwsl3D2QeCbDxhrETGKQC70twx6SlYetn7ZEQacuFJXxypl
         8dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807498; x=1718412298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZf0EHgmdIf50Bl79ZsaN7cmxd5qvbl03RzkcK+MKME=;
        b=oPC7v6ZEjUAtqEOaZRakBbWo1UB8rp/etsRb/b7ZR/OmB72jZ8UH2mkKBGDSMYIOwb
         i15KEbhVrevXEaRXWOgOOKSL3rzSA4FkBCh9h/uL453GdLJawGHEqWtf3jps0Uuxy0dc
         0XmW+daaoQmwChprD0XEziM7f9DCJA3jQUCE02Vc7RO98PgJbiKPIYbdyZwej+mGlA4h
         6S1RVXHIiRGgAsl7JbVtQ/NP7Sqo8M79nYUYQ25wj+AzE2TWQStrOmM4v1tfxo38erat
         T2nyRvLG3Lk6ANLDAY++wIlth5Rhxr0ZG/3yb0L7qgl7ZicM75l2XMzuy84VdTt0JyWr
         /fMw==
X-Gm-Message-State: AOJu0Yxeexq7a11HxTDjTuKag2CjKWtWOz3bURuNtifMfQZSvFA3jCIO
	4UPOOypwluDpi3SKM7KMoNHuwYeI2YlV0WdkIFIGIc8UaOquYE78coe1xA==
X-Google-Smtp-Source: AGHT+IFNrHftsOqsx5aHm88tz42ZX/hMrE1+7T6NoXaRyavsdBXndb7YcsfeJAskteKnV0tqlJsdyQ==
X-Received: by 2002:a05:6a20:7354:b0:1b2:b137:f864 with SMTP id adf61e73a8af0-1b2e6c469b2mr5920176637.7.1717807497930;
        Fri, 07 Jun 2024 17:44:57 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:81a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de276061e3sm3261755a12.80.2024.06.07.17.44.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jun 2024 17:44:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/4] bpf: Track delta between "linked" registers.
Date: Fri,  7 Jun 2024 17:44:44 -0700
Message-Id: <20240608004446.54199-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
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
 include/linux/bpf_verifier.h | 12 ++++-
 kernel/bpf/log.c             |  4 +-
 kernel/bpf/verifier.c        | 90 ++++++++++++++++++++++++++++++++----
 3 files changed, 95 insertions(+), 11 deletions(-)

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
index 81a3d2ced78d..e282625995fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
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
@@ -14026,6 +14038,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
@@ -14048,11 +14061,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
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
@@ -14116,7 +14125,40 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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
+	if (BPF_OP(insn->code) == BPF_ADD && dst_reg->id && is_reg_const(src_reg, alu32)) {
+		u64 val = reg_const_value(src_reg, alu32);
+
+		if ((dst_reg->id & BPF_ADD_CONST) || val > (u32)S32_MAX) {
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
@@ -15088,13 +15130,43 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
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
+		if ((reg->id & BPF_ADD_CONST) == (known_reg->id & BPF_ADD_CONST)) {
 			copy_register_state(reg, known_reg);
+		} else if ((reg->id & BPF_ADD_CONST) && reg->off) {
+			/* reg = known_reg; reg += const */
+			copy_register_state(reg, known_reg);
+
+			fake_reg.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_reg, reg->off);
+			scalar32_min_max_add(reg, &fake_reg);
+			scalar_min_max_add(reg, &fake_reg);
+			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
+			reg->off = 0;
+			reg->id &= ~BPF_ADD_CONST;
+		} else if ((known_reg->id & BPF_ADD_CONST) && known_reg->off) {
+			/* reg = known_reg; reg -= const' */
+			copy_register_state(reg, known_reg);
+
+			fake_reg.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_reg, known_reg->off);
+			scalar32_min_max_sub(reg, &fake_reg);
+			scalar_min_max_sub(reg, &fake_reg);
+			reg->var_off = tnum_sub(reg->var_off, fake_reg.var_off);
+		}
 	}));
+	if (known_reg->id & BPF_ADD_CONST) {
+		known_reg->id = 0;
+		known_reg->off = 0;
+	}
 }
 
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
-- 
2.43.0


