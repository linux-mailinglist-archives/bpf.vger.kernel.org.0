Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36162C6B28
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbgK0R6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732983AbgK0R6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:12 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63461C0613D1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id p18so3700185wro.9
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mZvHjAE2xe0rGoIORBV8EUbjbmRNvWQYKWvCzYEAY9I=;
        b=Jcv+0MqiazH0aK/8MJzRfSyVl6p/4WrnxQ1BydfAbL0drjK+I9i6e9XKme5KyBtQnm
         wNRtvwRlRLmaRFnf+3koDuPTjZVVhQ/Lj6Z16wDWHDMayyto1hR9vAQgBbHlPFAoswO8
         w8ireE+54mev5nvNzwqc8nNJ4/eTvH2eknSR26ErOHXx5Z4fwDZs1WCmQ6Q+dV/gEF2E
         FJjSIBN9HxWbJjy4aq7D/WrZwprS31r/q0Zv03F2er1YwCOfU5dL612XPKWik4AU7oAl
         I1DKGbYv6vwG7VbRoMcj3T8Asa7EXeBKUCUIztzj028pv8D5eP1WDKNw8otlGUQxN1iQ
         6rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mZvHjAE2xe0rGoIORBV8EUbjbmRNvWQYKWvCzYEAY9I=;
        b=eFcyKb5D/SyOZmlcQ8sOEeB8n95h4P1d8aCkpc6U+1PJIvklckbs+R6u+/stTDkX35
         xGX64ztilC9u6JNtuj00jH5xconQXgO3n0MLf44kITSnAnQ1YH6avW95hPxymRCbUgmj
         ZBWqqonAGKn5t5lSvHbG7L93UYj4HYg1v7ZwOxDXBX21FrFns39Q6UKi/l5HA0iK+/lM
         oIjLSyhDit62++q9KccCmb0cRDo7c+/vckA8JrkamFMAizqRyCWg17HvsiFN7NatTJqe
         tPUbesEjsYkK41q01YolbaPCJbt9lfnNf+PAOFO+vZnkwm5Vj4y9oogORlfpm8zvNGJK
         vCJg==
X-Gm-Message-State: AOAM531EdsOJJTVIEgtuOvUStee2LlUHeSPsyxIq52rbIaOOx0bAYCQj
        ilt39f5AZGWhRNqG/0ErH6piJSAV3T7hjYnPsySaL3gyzYwJ9UVAMOgkTiCWdvcBEEg09yh6Nuw
        to6UfGKWv1lOwH4G+RQmd0dAPOlQMVsqzkSw3y150vqCWLr+McHu+C2PoLTT5ALM=
X-Google-Smtp-Source: ABdhPJznJRx2Qfw3/bl6VBoodCw973ZRb6FFQigtE+w4qCijbg/ZHslsaZx5ZC6E2RiZ5ZQnSrBtN9+oVg2cnQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c1cc:: with SMTP id
 a12mr1857681wmj.0.1606499889154; Fri, 27 Nov 2020 09:58:09 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:35 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-11-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 10/13] bpf: Add instructions for atomic[64]_[fetch_]sub
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

Including only interpreter and x86 JIT support.

x86 doesn't provide an atomic exchange-and-subtract instruction that
could be used for BPF_SUB | BPF_FETCH, however we can just emit a NEG
followed by an XADD to get the same effect.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c  | 16 ++++++++++++++--
 include/linux/filter.h       | 20 ++++++++++++++++++++
 kernel/bpf/core.c            |  1 +
 kernel/bpf/disasm.c          | 16 ++++++++++++----
 kernel/bpf/verifier.c        |  2 ++
 tools/include/linux/filter.h | 20 ++++++++++++++++++++
 6 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7431b2937157..a8a9fab13fcf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -823,6 +823,7 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 
 	/* emit opcode */
 	switch (atomic_op) {
+	case BPF_SUB:
 	case BPF_ADD:
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
@@ -1306,8 +1307,19 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
-			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+			if (insn->imm == (BPF_SUB | BPF_FETCH)) {
+				/*
+				 * x86 doesn't have an XSUB insn, so we negate
+				 * and XADD instead.
+				 */
+				emit_neg(&prog, src_reg, BPF_SIZE(insn->code) == BPF_DW);
+				err = emit_atomic(&prog, BPF_ADD | BPF_FETCH,
+						  dst_reg, src_reg, insn->off,
+						  BPF_SIZE(insn->code));
+			} else {
+				err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
+						  insn->off, BPF_SIZE(insn->code));
+			}
 			if (err)
 				return err;
 			break;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6186280715ed..a20a3a536bf5 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic memory sub, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SUB })
+
+/* Atomic memory sub with fetch, src_reg = atomic_fetch_sub(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_SUB(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SUB | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 20a5351d1dc2..0f700464955f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1650,6 +1650,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	STX_ATOMIC_W:
 		switch (IMM) {
 		ATOMIC(BPF_ADD, add)
+		ATOMIC(BPF_SUB, sub)
 
 		case BPF_XCHG:
 			if (BPF_SIZE(insn->code) == BPF_W)
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3441ac54ac65..f33acffdeed0 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -80,6 +80,11 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
+const char *const bpf_atomic_alu_string[16] = {
+	[BPF_ADD >> 4]  = "add",
+	[BPF_SUB >> 4]  = "sub",
+};
+
 static const char *const bpf_ldst_string[] = {
 	[BPF_W >> 3]  = "u32",
 	[BPF_H >> 3]  = "u16",
@@ -154,17 +159,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			 insn->imm == BPF_ADD) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
+			 (insn->imm == BPF_ADD || insn->imm == BPF_SUB)) {
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
+			    insn->imm == (BPF_SUB | BPF_FETCH))) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s(*(%s *)(r%d %+d), r%d)\n",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8311cc114ec..dea9ad486ad1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3606,6 +3606,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_SUB:
+	case BPF_SUB | BPF_FETCH:
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		break;
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index ea99bd17d003..387eddaf11e5 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -190,6 +190,26 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic memory sub, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_SUB(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SUB })
+
+/* Atomic memory sub with fetch, src_reg = atomic_fetch_sub(*(dst_reg + off), src_reg); */
+
+#define BPF_ATOMIC_FETCH_SUB(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_SUB | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
-- 
2.29.2.454.gaff20da3a2-goog

