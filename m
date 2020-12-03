Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8AD2CDAC3
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbgLCQFM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387680AbgLCQFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:05:12 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65477C09424A
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:32 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id h68so1674434wme.5
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rQ5aZpFY6Pg/O0rx7Qe3LRIdXZHuAzMSl0kSyosK4jw=;
        b=aolwBRKb1Ahd6dJVwT5jjunBlBiNuEzWiWEVJjvvdZKdHX1NUw1CKIp1zItHSQ4/bR
         y5E+2Bf/0JrINRujSc7scrOuvVzLi+NOUR2TO/o6Siyuep+2/XEytq8///k+wDTlv+1q
         PZTvTFnizoD88nIUqRSXl7Mqh0myanIiWLokarjdEJk1Jwsifpk+u8IEyORHlGKkCTgA
         icZGeBWvT3z0GbVM/DpLZum0zKKG6rTzRB1lumPttCjS6x5K+ZOiudq0QWfKLFGctury
         0qW+fDE110cKpRjorrkDqOUVlfeeyh08PFL/8a0jp+KHvPPeovQsjUNBuVSWx/EA7lfS
         YRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rQ5aZpFY6Pg/O0rx7Qe3LRIdXZHuAzMSl0kSyosK4jw=;
        b=EB4B5THvsA2yu6PM3iaz07ev//TDpLW9XEv07t8yU/LX7kASd0a9ZaeZu0Ik1Piw7J
         z4Q3Pi0e6BjkLbqyEfvl3iOrkew3pGee+n+TYtQPOLSjSNQoH/hXZRsZgtzTdrOxk4XZ
         yzL52oa04wce/88j0D1pJI2pwaWgyN1CmFaCPUhmVZ3inW46ee5EaSZb1r6iIkXr9g/y
         h48BEcIcLQ/BYqxyYtutLnxtYkvYsb163ASr52EdO+iMPMaDMV4N5+Bx++7CIAjslPL3
         zr2/Dkj5knUTrLYXGi3p2JvPPCOeHdJ1h5bigJf5EYAjkHL0v6A/lNoJbzw8Urjsh0F2
         ao8Q==
X-Gm-Message-State: AOAM531PH7/QFG7h8qWA9yFzzmCdRk81jio5eZfheeisEM5MtkzdnPWJ
        l26OWEJPJOt4mYeq4UUcuTXpZqMP4ka9hNh8MNO6z8bYKhhOi6io6NCwEGkHXSRQB5WxNn2Z431
        MwCbfD6kW43pm+a8gPCL5L0DcLbTFqBRamEJv/t3pcl0g2m+AhJ4nrKVkhd8ArPI=
X-Google-Smtp-Source: ABdhPJy1qICjwyNsJnerw91e+uKX76VWe7VJLJ9bBqzMacrLONPebxz4DwbJ/gdj/kkJGkO7/phmRdWlAWoYVg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:f08e:: with SMTP id
 n14mr4415603wro.136.1607011410574; Thu, 03 Dec 2020 08:03:30 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:41 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-11-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 10/14] bpf: Add bitwise atomic instructions
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds instructions for

atomic[64]_[fetch_]and
atomic[64]_[fetch_]or
atomic[64]_[fetch_]xor

All these operations are isomorphic enough to implement with the same
verifier, interpreter, and x86 JIT code, hence being a single commit.

The main interesting thing here is that x86 doesn't directly support
the fetch_ version these operations, so we need to generate a CMPXCHG
loop in the JIT. This requires the use of two temporary registers,
IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.

Change-Id: I340b10cecebea8cb8a52e3606010cde547a10ed4
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c  | 50 +++++++++++++++++++++++++++++-
 include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c            |  5 ++-
 kernel/bpf/disasm.c          | 21 ++++++++++---
 kernel/bpf/verifier.c        |  6 ++++
 tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
 6 files changed, 196 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7d29bc3bb4ff..4ab0f821326c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -824,6 +824,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	/* emit opcode */
 	switch (atomic_op) {
 	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
@@ -1306,8 +1310,52 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH)) {
+				u8 *branch_target;
+				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+
+				/*
+				 * Can't be implemented with a single x86 insn.
+				 * Need to do a CMPXCHG loop.
+				 */
+
+				/* Will need RAX as a CMPXCHG operand so save R0 */
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				branch_target = prog;
+				/* Load old value */
+				emit_ldx(&prog, BPF_SIZE(insn->code),
+					 BPF_REG_0, dst_reg, insn->off);
+				/*
+				 * Perform the (commutative) operation locally,
+				 * put the result in the AUX_REG.
+				 */
+				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
+				maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
+				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
+				      add_2reg(0xC0, AUX_REG, src_reg));
+				/* Attempt to swap in new value */
+				err = emit_atomic(&prog, BPF_CMPXCHG,
+						  dst_reg, AUX_REG, insn->off,
+						  BPF_SIZE(insn->code));
+				if (WARN_ON(err))
+					return err;
+				/*
+				 * ZF tells us whether we won the race. If it's
+				 * cleared we need to try again.
+				 */
+				EMIT2(X86_JNE, -(prog - branch_target) - 2);
+				/* Return the pre-modification value */
+				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+				/* Restore R0 after clobbering RAX */
+				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+				break;
+
+			}
+
 			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+						  insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6186280715ed..698f82897b0d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -280,6 +280,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic memory and, *(uint *)(dst_reg + off16) &= src_reg */
+
+#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND })
+
+/* Atomic memory and with fetch, src_reg = atomic_fetch_and(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND | BPF_FETCH })
+
+/* Atomic memory or, *(uint *)(dst_reg + off16) |= src_reg */
+
+#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR })
+
+/* Atomic memory or with fetch, src_reg = atomic_fetch_or(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR | BPF_FETCH })
+
+/* Atomic memory xor, *(uint *)(dst_reg + off16) ^= src_reg */
+
+#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR })
+
+/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 498d3f067be7..27eac4d5724c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1642,7 +1642,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	STX_ATOMIC_W:
 		switch (IMM) {
 		ATOMIC(BPF_ADD, add)
-
+		ATOMIC(BPF_AND, and)
+		ATOMIC(BPF_OR, or)
+		ATOMIC(BPF_XOR, xor)
+#undef ATOMIC
 		case BPF_XCHG:
 			if (BPF_SIZE(insn->code) == BPF_W)
 				SRC = (u32) atomic_xchg(
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 18357ea9a17d..0c7c1c31a57b 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -80,6 +80,13 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
+static const char *const bpf_atomic_alu_string[16] = {
+	[BPF_ADD >> 4]  = "add",
+	[BPF_AND >> 4]  = "and",
+	[BPF_OR >> 4]  = "or",
+	[BPF_XOR >> 4]  = "or",
+};
+
 static const char *const bpf_ldst_string[] = {
 	[BPF_W >> 3]  = "u32",
 	[BPF_H >> 3]  = "u16",
@@ -154,17 +161,23 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			 insn->imm == BPF_ADD) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
+			 (insn->imm == BPF_ADD || insn->imm == BPF_ADD ||
+			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
+				bpf_alu_string[BPF_OP(insn->imm) >> 4],
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == (BPF_ADD | BPF_FETCH)) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",
+			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
+			    insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH))) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s(*(%s *)(r%d %+d), r%d)\n",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ccf4315e54e7..dd30eb9a6c1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3606,6 +3606,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		break;
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index ea99bd17d003..b74febf83eb1 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -190,6 +190,66 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic memory and, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND })
+
+/* Atomic memory and with fetch, src_reg = atomic_fetch_and(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND | BPF_FETCH })
+
+/* Atomic memory or, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR })
+
+/* Atomic memory or with fetch, src_reg = atomic_fetch_or(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR | BPF_FETCH })
+
+/* Atomic memory xor, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR })
+
+/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
-- 
2.29.2.454.gaff20da3a2-goog

