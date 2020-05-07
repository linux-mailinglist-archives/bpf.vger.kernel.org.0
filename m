Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52BB1C7F9D
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 03:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgEGBFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgEGBFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 21:05:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF88EC061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 18:05:15 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so1361698pll.9
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkBqx/wfZEl+tIcjb11yTPyE7+YEVimiwOlUfbRN11I=;
        b=MzUALuxSHI8uGN17akBqWhBWPav29bHPkcPrh9x/umRUluVK6xacxj/WYMuj4bFTeU
         oJ1fRh/BHW0t2Jeon/fnKRHc/cQW2ER4sIw3Y4MGWVZ7ek3t93U/nViHmcIX0u7owbrf
         3jCE0UDtYtJ1nGos034cmOKd/G9S9ntSCYXYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkBqx/wfZEl+tIcjb11yTPyE7+YEVimiwOlUfbRN11I=;
        b=EBWJQUW75dTx1bZUs+Tk8Hnn6tx5ZrPbaJ/FbgWjtKMozSqJqzr4P8MY5dOUgFgxJJ
         CvoQTu669xxtBOKJbjq3tD1T6CSavk9+Vd19Y/faV/U0tq+JZHtkD/p51hf5IQuCoVIX
         yQAFX7dYBvBnFfMg1N8yuyANDgicrTQ+i+oMNmSoxcRvByFDRiRLNL84P57yvK3dRji/
         YcQ8faN+prVq7gN+ZwL1aGPpGUVETycILIF0F3PJvIgBFvR2DchE+v65hLEHc9DPIzLC
         Hw1PLg9RK8R3zv/MHwbjQA5OY/AEn6odjQmV1O2uw/U8SCo6Eqt/N2fxPwpj0TyFAm9g
         VuvA==
X-Gm-Message-State: AGi0PuZAjchIMMYQDTHmJrgvlMsSHxMN3CkDnmpGuziJniLcarPuZnRQ
        /dmFLGjDFyr2MkT6LNDexRz/ILOFf71Nqg==
X-Google-Smtp-Source: APiQypIW2OFc7mkJ2PHrB5uAFjiSFWcgygWE+H6N56zj0yYwwbVdI6tvI0GuaDtoalZ3e5F3kIqqzA==
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr13041525pjs.84.1588813515058;
        Wed, 06 May 2020 18:05:15 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id ev5sm6165250pjb.1.2020.05.06.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 18:05:14 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Enrico Weigelt <info@metux.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [RFC PATCH bpf-next 2/3] bpf, arm64: Optimize AND,OR,XOR,JSET BPF_K using arm64 logical immediates
Date:   Wed,  6 May 2020 18:05:02 -0700
Message-Id: <20200507010504.26352-3-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507010504.26352-1-luke.r.nels@gmail.com>
References: <20200507010504.26352-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current code for BPF_{AND,OR,XOR,JSET} BPF_K loads the immediate to
a temporary register before use.

This patch changes the code to avoid using a temporary register
when the BPF immediate is encodable using an arm64 logical immediate
instruction. If the encoding fails (due to the immediate not being
encodable), it falls back to using a temporary register.

Example of generated code for BPF_ALU32_IMM(BPF_AND, R0, 0x80000001):

without optimization:

  24: mov  w10, #0x8000ffff
  28: movk w10, #0x1
  2c: and  w7, w7, w10

with optimization:

  24: and  w7, w7, #0x80000001

Since the encoding process is quite complex, the JIT reuses existing
functionality in arch/arm64/kernel/insn.c for encoding logical immediates
rather than duplicate it in the JIT.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/arm64/net/bpf_jit.h      | 14 +++++++++++++
 arch/arm64/net/bpf_jit_comp.c | 37 +++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index eb73f9f72c46..f36a779949e6 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -189,4 +189,18 @@
 /* Rn & Rm; set condition flags */
 #define A64_TST(sf, Rn, Rm) A64_ANDS(sf, A64_ZR, Rn, Rm)
 
+/* Logical (immediate) */
+#define A64_LOGIC_IMM(sf, Rd, Rn, imm, type) ({ \
+	u64 imm64 = (sf) ? (u64)imm : (u64)(u32)imm; \
+	aarch64_insn_gen_logical_immediate(AARCH64_INSN_LOGIC_##type, \
+		A64_VARIANT(sf), Rn, Rd, imm64); \
+})
+/* Rd = Rn OP imm */
+#define A64_AND_I(sf, Rd, Rn, imm) A64_LOGIC_IMM(sf, Rd, Rn, imm, AND)
+#define A64_ORR_I(sf, Rd, Rn, imm) A64_LOGIC_IMM(sf, Rd, Rn, imm, ORR)
+#define A64_EOR_I(sf, Rd, Rn, imm) A64_LOGIC_IMM(sf, Rd, Rn, imm, EOR)
+#define A64_ANDS_I(sf, Rd, Rn, imm) A64_LOGIC_IMM(sf, Rd, Rn, imm, AND_SETFLAGS)
+/* Rn & imm; set condition flags */
+#define A64_TST_I(sf, Rn, imm) A64_ANDS_I(sf, A64_ZR, Rn, imm)
+
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cdc79de0c794..083e5d8a5e2c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -356,6 +356,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
 	u8 jmp_cond, reg;
 	s32 jmp_offset;
+	u32 a64_insn;
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -488,18 +489,33 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_AND(is64, dst, dst, tmp), ctx);
+		a64_insn = A64_AND_I(is64, dst, dst, imm);
+		if (a64_insn != AARCH64_BREAK_FAULT) {
+			emit(a64_insn, ctx);
+		} else {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit(A64_AND(is64, dst, dst, tmp), ctx);
+		}
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_ORR(is64, dst, dst, tmp), ctx);
+		a64_insn = A64_ORR_I(is64, dst, dst, imm);
+		if (a64_insn != AARCH64_BREAK_FAULT) {
+			emit(a64_insn, ctx);
+		} else {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit(A64_ORR(is64, dst, dst, tmp), ctx);
+		}
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_EOR(is64, dst, dst, tmp), ctx);
+		a64_insn = A64_EOR_I(is64, dst, dst, imm);
+		if (a64_insn != AARCH64_BREAK_FAULT) {
+			emit(a64_insn, ctx);
+		} else {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit(A64_EOR(is64, dst, dst, tmp), ctx);
+		}
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
@@ -628,8 +644,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		goto emit_cond_jmp;
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
-		emit_a64_mov_i(is64, tmp, imm, ctx);
-		emit(A64_TST(is64, dst, tmp), ctx);
+		a64_insn = A64_TST_I(is64, dst, imm);
+		if (a64_insn != AARCH64_BREAK_FAULT) {
+			emit(a64_insn, ctx);
+		} else {
+			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit(A64_TST(is64, dst, tmp), ctx);
+		}
 		goto emit_cond_jmp;
 	/* function call */
 	case BPF_JMP | BPF_CALL:
-- 
2.17.1

