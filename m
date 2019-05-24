Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9AE2A13A
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404476AbfEXW1i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:27:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54692 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404460AbfEXW1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so10777421wml.4
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGy9vVwcf47uOzfAeIIrqS3ZrrEp99x8AnIzVOxK0w0=;
        b=UlCC1Ra4nkZrcise2iddtU/i/WbrV+MeQYDqv1lXe4pnUa29RSECbEAY6H9FXDixFV
         CTgPcMEk2zWHXqJbFazM0l/dBEUHxFbSMiNPDj3nJhgQtTPaV5Zy7kcmSgftXWtqxj2s
         V225Uj1yzUTQGjlRCP3i+CPCdMHxJePByjsxTUp0HSrHZ2OfWJ4Nsv8s3LOQ8vpGta/r
         EqRd1kii6liPMDCRnqg+RvsPcfArXVfu0wBYPot2I7NGACH7sD5RTLYJoXsW1dzrvq/w
         b3uxBy8noQYbk6AkT/WP3jrSTf/6ua4EQSAEmX+hg3Wr/+rDkKnKiUOpKzodc+JLRLVu
         qYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGy9vVwcf47uOzfAeIIrqS3ZrrEp99x8AnIzVOxK0w0=;
        b=PpxlkMAHANeNVrS8U2qel2M2vrag8SFs0k8oe9EVIcHr0KY+5PdbIO9NFuui+6k5Tn
         kqzMPb7CXN0GZHcOpChMp7EUVwvzXJ3fhgmrUmHI1Dlm347dPmmzI7C1LVnQUw8n7vwN
         +JBNfpzixVlVegi2LseAzNd/5krIr189HI/gV7P5MksHJ5bk/1XrkI3m0FBG1xt31KlF
         EXGwYtNs+Kc0ZP09TzuQ5N3AT2sKufmINHBVuzEAssEko4hF8bsMgPu390/YBWc6qxqn
         nL/IpuriNLPU4NcNv/T6rndwszZuyygEDLMZExWKuildxkB8vuc96nEQNYki/nksuipd
         Ckzw==
X-Gm-Message-State: APjAAAXMy0B+Zwnk+mrNV4dKEFKmOoIdzy1Gkd50f2m7Os5y5fqDyAtd
        8JzMIEO2bkBIpEIlC7BjSLISKw==
X-Google-Smtp-Source: APXvYqx58I9tys7IzzCX4EI1uTaYp0gHb3OLYdTvdaXZfJB16HIOdW/wpn+dz7AkenisSXncUXE8yA==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr1375096wmb.13.1558736854969;
        Fri, 24 May 2019 15:27:34 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:34 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v9 bpf-next 11/17] arm: bpf: eliminate zero extension code-gen
Date:   Fri, 24 May 2019 23:25:22 +0100
Message-Id: <1558736728-7229-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Shubham Bansal <illusionist.neo@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/arm/net/bpf_jit_32.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c8bfbbf..97a6b4b 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -736,7 +736,8 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 
 		/* ALU operation */
 		emit_alu_r(rd[1], rs, true, false, op, ctx);
-		emit_a32_mov_i(rd[0], 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(rd[0], 0, ctx);
 	}
 
 	arm_bpf_put_reg64(dst, rd, ctx);
@@ -758,8 +759,9 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  struct jit_ctx *ctx) {
 	if (!is64) {
 		emit_a32_mov_r(dst_lo, src_lo, ctx);
-		/* Zero out high 4 bytes */
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			/* Zero out high 4 bytes */
+			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else if (__LINUX_ARM_ARCH__ < 6 &&
 		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
@@ -1060,17 +1062,20 @@ static inline void emit_ldx_r(const s8 dst[], const s8 src,
 	case BPF_B:
 		/* Load a Byte */
 		emit(ARM_LDRB_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(rd[0], 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_H:
 		/* Load a HalfWord */
 		emit(ARM_LDRH_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(rd[0], 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_W:
 		/* Load a Word */
 		emit(ARM_LDR_I(rd[1], rm, off), ctx);
-		emit_a32_mov_i(rd[0], 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(rd[0], 0, ctx);
 		break;
 	case BPF_DW:
 		/* Load a Double Word */
@@ -1359,6 +1364,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		switch (BPF_SRC(code)) {
 		case BPF_X:
+			if (imm == 1) {
+				/* Special mov32 for zext */
+				emit_a32_mov_i(dst_hi, 0, ctx);
+				break;
+			}
 			emit_a32_mov_r64(is64, dst, src, ctx);
 			break;
 		case BPF_K:
@@ -1438,7 +1448,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code));
 		arm_bpf_put_reg32(dst_lo, rd_lo, ctx);
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1453,7 +1464,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			return -EINVAL;
 		if (imm)
 			emit_a32_alu_i(dst_lo, imm, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = dst << imm */
 	case BPF_ALU64 | BPF_LSH | BPF_K:
@@ -1488,7 +1500,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = ~dst */
 	case BPF_ALU | BPF_NEG:
 		emit_a32_alu_i(dst_lo, 0, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = ~dst (64 bit) */
 	case BPF_ALU64 | BPF_NEG:
@@ -1544,11 +1557,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 #else /* ARMv6+ */
 			emit(ARM_UXTH(rd[1], rd[1]), ctx);
 #endif
-			emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
+			if (!ctx->prog->aux->verifier_zext)
+				emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
 			break;
 		case 32:
 			/* zero-extend 32 bits into 64 bits */
-			emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
+			if (!ctx->prog->aux->verifier_zext)
+				emit(ARM_EOR_R(rd[0], rd[0], rd[0]), ctx);
 			break;
 		case 64:
 			/* nop */
@@ -1838,6 +1853,11 @@ void bpf_jit_compile(struct bpf_prog *prog)
 	/* Nothing to do here. We support Internal BPF. */
 }
 
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
-- 
2.7.4

