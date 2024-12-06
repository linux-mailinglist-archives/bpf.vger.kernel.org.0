Return-Path: <bpf+bounces-46284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B202E9E7534
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D291885AA4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6920DD62;
	Fri,  6 Dec 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdkz9xZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681E20D50E
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501461; cv=none; b=LDwO62D51SxC0RKSzgb8UG9MKXP3+Eg3e/DR98jyQjJuQ+Zllu5vySK2X3ju3Y4akENMt15OWZpvWr8ar+lHyGu25CaBhYQGBzSZSXJ9hiX8zZ8lMAfqBWvuOwAmrkz1FVOv6EUyaIDqXDUp+ASL4h5vQiwYKNHSHTZPcF1xbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501461; c=relaxed/simple;
	bh=IV4WwrNiULRwAafUxmJqzO84gg9SB0SzgoMo6BwtuIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC1T5dYV1sQUTtXRUfSt69dUv2x/Y9Dj68ZcxwWQjltDVrhDJZ/myr5pkGLjm/IrVJ7hoJxHyVGuD0Cs+8NBS9gRd7G6Y2zStJC3fR0gGUbTBKrBcyDPeBBPow8Y35X0lcF/qjvwIs04/o4oxnfSoCGBqIodc18dqY9YNwVJJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdkz9xZe; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434aabd688fso14988475e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501457; x=1734106257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QCSBnVm04PkHslLUEhSA4GXN/6Jz6KNydKP3UpMZQM=;
        b=Sdkz9xZeROJDdaDBzjA9JdziOGY/k+83Bd2Kle3WxKokqfiVJ+x+CtNR/kk03YWx5T
         +RZYV2gO90Be3S0XmFxcgWoQa4usiuHR1ulU71ewVMggu6sHYL90UKAW36WdwFpe0zSl
         1Y/DIKcrl7bk7H6dJXW0wTkQGfkWRbKaIg2Hol9JTb9mnLzPU1sUPm/V61BngbTtTLUu
         kWxtSm6osDn4KZdo0Czo0pxfkqUt4vAtkuGiMQamDdXYmVPdutqv9fwyHTzum8Ex3tfa
         ugocnoUXrxMm8LH3uzpFI6Su8qZEL9VKbPjnAjBN+Cy/4nQBzg9iUBeWlMiktf1bk1sK
         9IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501457; x=1734106257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QCSBnVm04PkHslLUEhSA4GXN/6Jz6KNydKP3UpMZQM=;
        b=GtB8oK5eS1cd9SHyIybhiSXDparplfntLsT/ls25jRRI/Lw+ArX4rk1kQvnBYhwkCj
         md23ULUdrWK1lfVIrLYJAwzH2K//XfTXhZwWWIIhqUVB0br6XeMPHpDlyDlZtnIBri3x
         TT1V0cn+Z4VvnfFoGgv+JIh1rzYg/vPTH62ZITWlMH8i1M1yg8/NWSmFMFEQbZ2Og0Dq
         yD0kxSemI9RSh4KiO8f1GDUfa2tCN+aw+N+xnAxbwr5aEq0sfkQ0/Wl4SHY2IT8S8gP3
         JUnkDAiAfnCcWtBvrqI/iZs3c0EFFy2WMoZu3NRlzZMo9+BFn/OrZcmntLZdVFf2olJu
         wnrw==
X-Gm-Message-State: AOJu0YzP41roYo8SCoM63fstNYIivKkYCuXiQAgnw+hBDprgNTZ0Zys7
	HSr8nQc/56aBTt+sbgN9TFuUI4EUPHBAiidLzZpmgHIKKngvAiJC4C6zY3TOzvU=
X-Gm-Gg: ASbGnctbbde42De3R4RB23ivFXmlZVvXc4QIXFF/PThISkAWn+NovvGgCp1VAK7Fmqr
	H4DuZdlUBi0x6qcrUzbpS01gXQaGYxYsOXrlMiQWMORA2+rheY5Xv7bPJoGxxgam0iBoj2MdXcg
	AQoM+X4g/93KtHDxIg12kGAPWeLlmS4ugXutnxssv0X5NR02byrbEUW9gtRm+6K8ILpsCyj1gxK
	J8Q0He2BfAbk9znZoftmUfj/E+6RH4xRZlKYQhdmdB5bBbGIiV0/uP1PzJpFEe2rKVtB0YE46HH
X-Google-Smtp-Source: AGHT+IH2EJmzcqZVEAJs8KUH/YfLMsZtdxJ/9LLtNONmuNbDyDLa3dX8yUy6JM14O3RvfBv7CcdNiA==
X-Received: by 2002:a5d:47a1:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-3862b38ee31mr2963517f8f.32.1733501457071;
        Fri, 06 Dec 2024 08:10:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c12a4sm98835635e9.30.2024.12.06.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:10:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Manu Bretelle <chantra@meta.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf v3 1/3] bpf: Suppress warning for non-zero off raw_tp arg NULL check
Date: Fri,  6 Dec 2024 08:10:51 -0800
Message-ID: <20241206161053.809580-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206161053.809580-1-memxor@gmail.com>
References: <20241206161053.809580-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5690; h=from:subject; bh=IV4WwrNiULRwAafUxmJqzO84gg9SB0SzgoMo6BwtuIo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUyEsZEvhHrWlFA7R4CIKwPl3JsSKUHl5RWWRnefz yL7w3KCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1MhLAAKCRBM4MiGSL8RyvBjEA ChlnpjgfqlHbB7/TUvwidMU537roUQfafTURY2SozCoTdqZi9LgUtooox7tlg0ciV4fx1yTp/D0wqJ FPhV3KG1IaVTNkrezYgaIeaGCq/1rxllzR4pG/hhb97yC2pZHmwGDJAimsfYYe0TKwMBPJ3W8b5htH obig7smNNCDhlRh3fQvh4p2UdjBZE7ARqIliA+ERC/ReagKU+EEMAwdoJPRnIeuKVuykkUjbt4Y77q gg9kKdlVlnBKouQSaNhv27IeD+DXIdyTpEEZdEaj8TOLNY6JnV2/7y4TgJqe3OPxMLxaRXhv9YdZel sAgxhg5trOpdG3IFgt3o59PKoZGIals4I8HISmmi/3z2XtBpVCURDt6j390Uz9QmyMjjZBleCjcDRC mBHb34hTgwREk0u6F0QvC1N8G4lvqwqSjNYvTA4HMGDfRa2/AKyNOl5OpLVjIxhcjFCm7Pz28PmA8b tJ318gSb2+gSuE0c1nFWSqcyMWv7sk5Ld35nuXZ0bDwg0aOHjFiYOq7xpv47auur0eGRwx3A7yqfdR IgGeoejER4In9AztAhsOsZ2k/GuJCRuZiuNVhk3NODkSbvyr+zAVjgb/K0rCeqv91owK1KKbpCjv7a 6LXrbkopRRCZK3/xkKoVmhGx4NKn21POMZo/geg8Tx4jb/hh7WMl0XTFMNQQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The fixed commit began marking raw_tp arguments as PTR_MAYBE_NULL to
avoid dead code elimination in the verifier, since raw_tp arguments
may actually be NULL at runtime. However, to preserve compatibility,
it simulated the raw_tp accesses as if the NULL marking was not present.

One of the behaviors permitted by this simulation is offset modification
for NULL pointers. Typically, this pattern is rejected by the verifier,
and users make workarounds to prevent the compiler from producing such
patterns. However, now that it is allowed, when the compiler emits such
code, the offset modification is allowed and a PTR_MAYBE_NULL raw_tp arg
with non-zero off can be formed.

The failing example program had the following pseudo-code:

r0 = 1024;
r1 = ...; // r1 = trusted_or_null_(id=1)
r3 = r1;  // r3 = trusted_or_null_(id=1) r1 = trusted_or_null_(id=1)
r3 += r0; // r3 = trusted_or_null_(id=1, off=1024)
if r1 == 0 goto pc+X;

At this point, while mark_ptr_or_null_reg will see PTR_MAYBE_NULL and
off == 0 for r1, it will notice non-zero off for r3, and the
WARN_ON_ONCE will fire, as the condition checks excluding register types
do not include raw_tp argument type.

This is a pattern produced by LLVM, therefore it is hard to suppress it
everywhere in BPF programs.

The right "generic" fix for this issue in general, will be permitting
offset modification for PTR_MAYBE_NULL pointers everywhere, and
enforcing that the instruction operand of a conditional jump has the
offset as zero. It's other copies may still have non-zero offset, and
that is fine. But this is more involved and will take longer to
integrate.

If a zero offset pointer is NULL checked, all copies can be marked
non-NULL, while checking non-zero offset PTR_MAYBE_NULL is a no-op.

For now, only make this change for raw_tp arguments, and table the
generic fix for later.

Dereferencing such pointers will still work as the fixed commit allowed
it for raw_tp args.

Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Manu Bretelle <chantra@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2fd35465d650..82f40d63ad7b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15340,7 +15340,8 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	return err;
 }
 
-static void mark_ptr_or_null_reg(struct bpf_func_state *state,
+static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
+				 struct bpf_func_state *state,
 				 struct bpf_reg_state *reg, u32 id,
 				 bool is_null)
 {
@@ -15357,7 +15358,9 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		 */
 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
 			return;
-		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type)) &&
+		if (!type_is_ptr_alloc_obj(reg->type) &&
+		    !type_is_non_owning_ref(reg->type) &&
+		    !mask_raw_tp_reg_cond(env, reg) &&
 		    WARN_ON_ONCE(reg->off))
 			return;
 
@@ -15390,11 +15393,12 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 /* The logic is similar to find_good_pkt_pointers(), both could eventually
  * be folded together at some point.
  */
-static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
+static void mark_ptr_or_null_regs(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *vstate, u32 regno,
 				  bool is_null)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs, *reg;
+	struct bpf_reg_state *regs = state->regs, *reg = &regs[regno];
 	u32 ref_obj_id = regs[regno].ref_obj_id;
 	u32 id = regs[regno].id;
 
@@ -15405,8 +15409,28 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
 
+	/* For raw_tp args, compiler can produce code of the following
+	 * pattern:
+	 * r3 = r1; // r1 = trusted_or_null_(id=1) r3 = trusted_or_null_(id=1)
+	 * r3 += 8; // r3 = trusted_or_null_(id=1,off=8)
+	 * if r1 == 0 goto pc+N; // r1 = trusted_(id=1)
+	 *
+	 * But we musn't remove the or_null mark from r3, as it won't be
+	 * NULL.
+	 *
+	 * Only do unmarking of everything sharing id if operand of NULL check
+	 * has off = 0.
+	 */
+	if (mask_raw_tp_reg_cond(env, reg) && reg->off) {
+		/* We don't reset reg->id back to 0, as it's unexpected
+		 * when PTR_MAYBE_NULL is set. Simply avoid performing
+		 * a walk for other registers with the same id.
+		 */
+		return;
+	}
+
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		mark_ptr_or_null_reg(state, reg, id, is_null);
+		mark_ptr_or_null_reg(env, state, reg, id, is_null);
 	}));
 }
 
@@ -15832,9 +15856,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-		mark_ptr_or_null_regs(this_branch, insn->dst_reg,
+		mark_ptr_or_null_regs(env, this_branch, insn->dst_reg,
 				      opcode == BPF_JNE);
-		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
+		mark_ptr_or_null_regs(env, other_branch, insn->dst_reg,
 				      opcode == BPF_JEQ);
 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
 					   this_branch, other_branch) &&
-- 
2.43.5


