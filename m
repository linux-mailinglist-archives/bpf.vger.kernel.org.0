Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11C2C6B29
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbgK0R6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732984AbgK0R6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:13 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF553C0613D4
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:12 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b11so4134068qkk.10
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0hpUNgP6F8b8DKNGvFw/ePsro3vokMIuT28XL72HN2Y=;
        b=qtcSoh40Q/lucmLUCuIt/8x+xk6nZUMLcqpBc7ghemxX3vNaupJ0JKs0iP2uO2Yy0s
         Mba1YCSnu6s2vi0zFkdXwdrIvcQLvUyxBfqVZqseeM/lGLomMtFePWuuz+CEbHD9oQ12
         UKKQjkmgD0ZO9E+M/8veRCmGz16v9PBAp34h+sEp+Bc93cHPla53BoHii089PLambfH2
         3SyYoDP5BgmYPTxXX7fcGVEOTGVS0Y2as9otNOcAr8t8f7zYpWrcsWhsxvzcHzjrfyeW
         b982buRTB5dt6xX+nhcLAAULTDcw/R9AQg4CRoW+Asr3MozG0g2q4P7NIDEGsSwCz0r5
         vAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0hpUNgP6F8b8DKNGvFw/ePsro3vokMIuT28XL72HN2Y=;
        b=B0AIF+tavUINNTtvoR1h0XMQNCA0Cn8tNL4e+yRV0qDpioGYs6Vn7lqxf35AJbS57n
         Tm3vFS2d+vjwcnqtieBGRaUQniIs2HuQwh006X004r1xttQP8LWkM4nNm1i4eiD9Y2fp
         AwyasxksDI0dyniIbk1p9838rdZAXNH/kDfgXl1S8TBzZZYJQAScyz3SfkGsiLXYipVk
         MN3U9iuePvLnxWzsonsqChOFVvehoF6i8/rsrbrJhGcT74F+Nh6ifV7uHIUh7z1P4f5s
         hdfsAFgUD8y8BhT0RFdO99cOzxkmWMlR9O2TXYynqzUDh1W1oQdIiZH3NkmTECik/I/o
         5tcg==
X-Gm-Message-State: AOAM533Yjw8AWcxX+YYova5N3NMJ982tVVqauYNzD4QDNX1lY3ut0juY
        J6qPf6WfmBfwbdTFU2YCq3cH5/Ld6Sz/SmCDm5e1iSzx7EOEjaNSLL3gehkWL7tL1/VM/+EENtm
        THmG3UzrQp+ob/B5IoQO6QRM77Qx6YKEVXIuMCY/kO35hfvuv5RrQIn+CJYTXDVw=
X-Google-Smtp-Source: ABdhPJz52r9mkaXVmRVm2C75fNnzTIisQaRQ3trqlZfjAyMykvkK0XKpUHtijnQYsv5DRvZoEb99Yhb9QTbYyQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:4052:: with SMTP id
 r18mr9566252qvp.38.1606499891695; Fri, 27 Nov 2020 09:58:11 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:36 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-12-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 11/13] bpf: Add bitwise atomic instructions
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

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c  | 49 ++++++++++++++++++++++++++++-
 include/linux/filter.h       | 60 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c            |  5 ++-
 kernel/bpf/disasm.c          |  7 +++--
 kernel/bpf/verifier.c        |  6 ++++
 tools/include/linux/filter.h | 60 ++++++++++++++++++++++++++++++++++++
 6 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a8a9fab13fcf..46b977ee21c4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -823,8 +823,11 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 
 	/* emit opcode */
 	switch (atomic_op) {
-	case BPF_SUB:
 	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
@@ -1307,6 +1310,50 @@ st:			if (is_imm8(insn->off))
 
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
+				maybe_emit_rex(&prog, AUX_REG, src_reg, is64);
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
 			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
 				/*
 				 * x86 doesn't have an XSUB insn, so we negate
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a20a3a536bf5..cb5d865cce3c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -300,6 +300,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_SUB | BPF_FETCH })
 
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
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0f700464955f..d5f4b1f2c9fe 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1651,7 +1651,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		switch (IMM) {
 		ATOMIC(BPF_ADD, add)
 		ATOMIC(BPF_SUB, sub)
-
+		ATOMIC(BPF_AND, and)
+		ATOMIC(BPF_OR, or)
+		ATOMIC(BPF_XOR, xor)
+#undef ATOMIC
 		case BPF_XCHG:
 			if (BPF_SIZE(insn->code) == BPF_W)
 				SRC = (u32) atomic_xchg(
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index f33acffdeed0..4c861632efac 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -83,6 +83,7 @@ const char *const bpf_alu_string[16] = {
 const char *const bpf_atomic_alu_string[16] = {
 	[BPF_ADD >> 4]  = "add",
 	[BPF_SUB >> 4]  = "sub",
+	[BPF_AND >> 4]  = "and",
 };
 
 static const char *const bpf_ldst_string[] = {
@@ -159,7 +160,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			 (insn->imm == BPF_ADD || insn->imm == BPF_SUB)) {
+			 (insn->imm == BPF_ADD || insn->imm == BPF_SUB ||
+			  (insn->imm == BPF_AND))) {
 			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
@@ -168,7 +170,8 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
 			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
-			    insn->imm == (BPF_SUB | BPF_FETCH))) {
+			    insn->imm == (BPF_SUB | BPF_FETCH) ||
+			    insn->imm == (BPF_AND | BPF_FETCH))) {
 			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s(*(%s *)(r%d %+d), r%d)\n",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dea9ad486ad1..188f152a0c32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3608,6 +3608,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	case BPF_ADD | BPF_FETCH:
 	case BPF_SUB:
 	case BPF_SUB | BPF_FETCH:
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
index 387eddaf11e5..2a64149af056 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -210,6 +210,66 @@
 		.off   = OFF,					\
 		.imm   = BPF_SUB | BPF_FETCH })
 
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

