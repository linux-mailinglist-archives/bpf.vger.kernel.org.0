Return-Path: <bpf+bounces-20896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EC4845026
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44351B22798
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE013BB50;
	Thu,  1 Feb 2024 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z89KRO/G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689B1EF15
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761286; cv=none; b=ZtIYRiniGAQZw+WAriwzKXvkxaDFtZAn9bRLOtHG6sMK86pT5UEXxu7TWpV0QJ67IL1v/fvWuRfil9suarC4TtT6ULl1nRR+wqJKaljUGEj9hJdGG+ZUQEnsP1heuUDLeNTadx104H7aHygrZUXjh5LkpMp9B7aW2GRsqmACjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761286; c=relaxed/simple;
	bh=W6f6MmNaMQ4brkjN81MYPDjeQ4XbWi6k+9bKkOT9ytQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJD2fqdWgjnEmdyoNXoKaBcT++SFTWqDysXJ2MxVu2dR2I39WWMS9ZW1/Pr4fm9BVEOskmDo44NvuLRPFK9iKL45TDY94gRyt+NfId3a0ijXL9Zu0hTs+kFI/7zeAX2bOg/e7jfQ9IZy54ncz1+hbwoSnoX3YiaDPqKOygHzwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z89KRO/G; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d073b54359so4412701fa.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761282; x=1707366082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cCmbC7PpeJvrJ88sWzeovZ1efioD+wJX0ZxsMhoJQs=;
        b=Z89KRO/GyBTwFzRPGBWRP2Q1bN9ZxydC0bVPr/ekZ3WaOkKWjKh/JzYlZsZctnMZy2
         WisG1yNBvmEBXKJfw9WE1QoHDgBHWEfMApJ6hiXoJuuvIMdmog85TlZ9mD8SAwOCf3ZX
         d34L9+kvZLlIFvmcKG138PfqOJWHyROWada/ZUWPD8iJBp3kIIc8WPvHm9SB+OFWMqKn
         EslVsbZSvRDn6bDQi34nxdrcXrBNoeOTHW4Yz7dmngEW7paVFx+0P9nNuK/vmFr9VJwK
         y3PHyAQ8Al5CawU4M8GTazYOC5of7nKQw1un1RG+vALj5W99rQpUkT9M7Br3UNRmMPop
         plXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761282; x=1707366082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cCmbC7PpeJvrJ88sWzeovZ1efioD+wJX0ZxsMhoJQs=;
        b=g3ocYfCVlgmZaQg/uxS0hizgJNukfnUEaV2JkQikJ87gYZjRN4TzAvhU39+ymCvaGv
         C8apyXPTX1KFiXXdKVDeEB++inNJGztR6L0HCbBUWc5PauZfNHADNHRzLboIHE9U86XC
         M6MvtRTgbrx/oW4mdDRdxL/26lXeCx10ZZhwxLAuJQRVOazUVlMkeyLIZ+TtUValNzAS
         TkuHETcSbiFYR+IJFmr1CQel/Uic7Qf9dHL8e8JQq5nOnHac5HS2M2c+9a/EiTcSPm6O
         4c8sWggkuvYtB6rDVTI9dnPs+GTX887TRILptQ/qQSr0gjwTxSV5+GNaUbzFKYkrQm7l
         BVyQ==
X-Gm-Message-State: AOJu0YyQxVxp013ZSW4nbZ61EyGdk+1TLaEL2zM9EFVi6DCneM1HXC0M
	TocdzTfaAvxe8u1unQha9fDCUSHVYtRWCUrpJ9I17b29QJda9sjhg9A+D7VA
X-Google-Smtp-Source: AGHT+IFLl36dXTnVDQe5feu1j4iZS9M1vZZAVY1YPH5qr3iXrwO5hLb+0XKRV1143rPliHDEXatcAw==
X-Received: by 2002:a05:651c:1242:b0:2cf:4e53:7c38 with SMTP id h2-20020a05651c124200b002cf4e537c38mr2266863ljh.22.1706761281756;
        Wed, 31 Jan 2024 20:21:21 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d754000000b0055efeee7722sm3658680eds.79.2024.01.31.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:21 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 07/14] bpf: Use hidden subprog trampoline for bpf_throw
Date: Thu,  1 Feb 2024 04:21:02 +0000
Message-Id: <20240201042109.1150490-8-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9267; i=memxor@gmail.com; h=from:subject; bh=W6f6MmNaMQ4brkjN81MYPDjeQ4XbWi6k+9bKkOT9ytQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwOPIXJJ5Pvyg5Rn414zDGYd6lVBAbcLB0aI 9PO5o0QNw2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDgAKCRBM4MiGSL8R ygVQD/9P5T42bULV9be2trljRF/kueo/0S6Vx4zW0CjjkYUk28qkIg9FfnzXf92i0M35vfeuke0 b3tnhPNddx8aSM3DPE6eIczVrg/HMsVQevA3C6XUmQPr8v173lD01O4geZqSWbNsHG9Tz9721NV wpgrDkpAsetoXAVD8+eYFVv1YueZ46LBZI1T8M/CcG9s8Wm3zJiUhKifTgRNAOepmlA2U+lPaZF kQxMgTid2Wn9YcSSwYF3dtf5YTly7HJTWwC19RYXZ2PdEaGJonrPV8I5b8EEEyI081iAgfjaaqu Tz5BaG7jc65TNJc/krwMBRP4d99LYHIQ7fnqYaZzF2oLAHLrJYARVpMfryPgPDnyG2oNgwMyw/3 m2hFoUdhuNhUezwv7X1VLWtJ4M/MQiYaaAD7aavRkcvVQftHShe1sowHzlxzEOBW7Zryq43epTo fJpbLYwcXcmrb3Tv0AvLSVcnGXCSvt6usbqSonggNA1UvvsUZI8/51guCka+yNJnpHJ8UKpEoXg 3HVMxUSi41ROtbOQX+sMi3s9WYBPJnL+diAVyrOFjpDAFHNbLy1Q+3tPDgXVNJBL570SNDt/8pX 0fPVvMXNxBUCwaW8xPycAmiXfs5TPZdnn5XJTqKSqp4gqLQvGM0KjUF7Cc9jrPREDERsa6nXxdJ LuWt89G1cXTe/lA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When we perform a bpf_throw kfunc call, callee saved registers in BPF
calling convention (R6-R9) may end up getting saved and clobbered by
bpf_throw. Typically, the kernel will restore the registers before
returning back to the BPF program, but in case of bpf_throw, the
function will never return. Therefore, any acquired resources sitting in
these registers will end up getting destroyed if not saved on the
stack, without any cleanup happening for them.

Also, when in a BPF call chain, caller frames may have held acquired
resources in R6-R9 and called their subprogs, which may have spilled
these on their stack frame to reuse these registers before entering the
bpf_throw kfunc. Thus, we also need to locate and free these callee
saved registers for each frame.

It is thus necessary to save these registers somewhere before we call
into the bpf_throw kfunc. Instead of adding spills everywhere bpf_throw
is called, we can use a new hidden subprog that saves R6-R9 on the stack
and then calls into bpf_throw. This way, all of the bpf_throw call sites
can be turned into call instructions for this subprog, and the hidden
subprog in turn will save the callee-saved registers before calling into
the bpf_throw kfunc.

In this way, when unwinding the stack, we can locate the callee saved
registers on the hidden subprog stack frame and perform their cleanup.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c  | 24 ++++++++--------
 include/linux/bpf.h          |  5 ++++
 include/linux/bpf_verifier.h |  3 +-
 kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++++++++--
 4 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..87692d983ffd 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -640,9 +640,10 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
 
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_prog->aux->bpf_throw_tramp) {
 		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
+		if (bpf_prog->aux->exception_boundary)
+			pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
 	}
@@ -699,9 +700,10 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
-	if (bpf_prog->aux->exception_boundary) {
+	if (bpf_prog->aux->exception_boundary || bpf_prog->aux->bpf_throw_tramp) {
 		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
+		if (bpf_prog->aux->exception_boundary)
+			pop_r12(&prog);
 	} else {
 		pop_callee_regs(&prog, callee_regs_used);
 	}
@@ -1164,12 +1166,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
-	if (bpf_prog->aux->exception_boundary) {
-		/* We also need to save r12, which is not mapped to any BPF
-		 * register, as we throw after entry into the kernel, which may
-		 * overwrite r12.
-		 */
-		push_r12(&prog);
+	if (bpf_prog->aux->exception_boundary || bpf_prog->aux->bpf_throw_tramp) {
+		if (bpf_prog->aux->exception_boundary)
+			push_r12(&prog);
 		push_callee_regs(&prog, all_callee_regs_used);
 	} else {
 		push_callee_regs(&prog, callee_regs_used);
@@ -2031,9 +2030,10 @@ st:			if (is_imm8(insn->off))
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			if (bpf_prog->aux->exception_boundary) {
+			if (bpf_prog->aux->exception_boundary || bpf_prog->aux->bpf_throw_tramp) {
 				pop_callee_regs(&prog, all_callee_regs_used);
-				pop_r12(&prog);
+				if (bpf_prog->aux->exception_boundary)
+					pop_r12(&prog);
 			} else {
 				pop_callee_regs(&prog, callee_regs_used);
 			}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 463c8d22ad72..83cff18a1b66 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3369,6 +3369,11 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+static inline bool bpf_is_hidden_subprog(const struct bpf_prog *prog)
+{
+	return prog->aux->func_idx >= prog->aux->func_cnt;
+}
+
 struct bpf_frame_desc_reg_entry {
 	u32 type;
 	s16 spill_type;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0113a3a940e2..04e27fce33d6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -683,6 +683,7 @@ struct bpf_verifier_env {
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	int exception_callback_subprog;
+	int bpf_throw_tramp_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	/* Allow access to uninitialized stack memory. Writes with fixed offset are
@@ -699,7 +700,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
+	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 3]; /* max + 3 for the fake, exception, and bpf_throw_tramp subprogs */
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5b1db1db679..942243cba9f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19836,9 +19836,9 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	int cnt = env->subprog_cnt;
 	struct bpf_prog *prog;
 
-	/* We only reserve one slot for hidden subprogs in subprog_info. */
-	if (env->hidden_subprog_cnt) {
-		verbose(env, "verifier internal error: only one hidden subprog supported\n");
+	/* We only reserve two slots for hidden subprogs in subprog_info. */
+	if (env->hidden_subprog_cnt == 2) {
+		verbose(env, "verifier internal error: only two hidden subprogs supported\n");
 		return -EFAULT;
 	}
 	/* We're not patching any existing instruction, just appending the new
@@ -19892,6 +19892,42 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
+	if (env->seen_exception) {
+		struct bpf_insn patch[] = {
+			/* Use the correct insn_cnt here, as we want to append past the hidden subprog above. */
+			env->prog->insnsi[env->prog->len - 1],
+			/* Scratch R6-R9 so that the JIT spills them to the stack on entry. */
+			BPF_MOV64_IMM(BPF_REG_6, 0),
+			BPF_MOV64_IMM(BPF_REG_7, 0),
+			BPF_MOV64_IMM(BPF_REG_8, 0),
+			BPF_MOV64_IMM(BPF_REG_9, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, special_kfunc_list[KF_bpf_throw]),
+		};
+		const bool all_callee_regs_used[4] = {true, true, true, true};
+
+		ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
+		if (ret < 0)
+			return ret;
+		prog = env->prog;
+		insn = prog->insnsi;
+
+		env->bpf_throw_tramp_subprog = env->subprog_cnt - 1;
+		/* Ensure to mark callee_regs_used, so that we can collect any saved_regs if necessary. */
+		memcpy(env->subprog_info[env->bpf_throw_tramp_subprog].callee_regs_used, all_callee_regs_used, sizeof(all_callee_regs_used));
+		/* Certainly, we have seen a bpf_throw call in this program, as
+		 * seen_exception is true, therefore the bpf_kfunc_desc entry for it must
+		 * be populated and found here. We need to do the fixup now, otherwise
+		 * the loop over insn_cnt below won't see this kfunc call.
+		 */
+		ret = fixup_kfunc_call(env, &prog->insnsi[prog->len - 1], insn_buf, prog->len - 1, &cnt);
+		if (ret < 0)
+			return ret;
+		if (cnt != 0) {
+			verbose(env, "verifier internal error: unhandled patching for bpf_throw fixup in bpf_throw_tramp subprog\n");
+			return -EFAULT;
+		}
+	}
+
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
@@ -20012,6 +20048,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			/* All bpf_throw calls in this program must be patched to call the
+			 * bpf_throw_tramp subprog instead.  This ensures we correctly save
+			 * the R6-R9 before entry into kernel, and can clean them up if
+			 * needed.
+			 * Note: seen_exception must be set, otherwise no bpf_throw_tramp is
+			 * generated.
+			 */
+			if (env->seen_exception && is_bpf_throw_kfunc(insn)) {
+				*insn = BPF_CALL_REL(0);
+				insn->imm = (int)env->subprog_info[env->bpf_throw_tramp_subprog].start - (i + delta) - 1;
+				continue;
+			}
+
 			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
 				return ret;
-- 
2.40.1


