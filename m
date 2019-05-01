Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5761095B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2019 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfEAOoX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 May 2019 10:44:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53944 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfEAOoX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 May 2019 10:44:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so1682898wmf.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2019 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHRswnMie2qIvKUp9OR3AUMeAWaFYRfKVKlPZ+HXY1I=;
        b=AluMkeumN7L9LX6ypvmeQYwrVZL5/86/frVWoniJMSA/fWPL17V4Yo482gleQHALYD
         G4mn7o2MpHOqFyb2glXc62EBRQgbgY0sVx21gMj9JSJm68cuKFHSSuVP99jWFulULT8m
         NFk24bgVV0wFGWW+VZBDsh6bT4giDNqTiAoVbkrug59RdEuuvO4DmnDsaRZ6hwNowjjE
         dVCROq3yHWl0VCFbhYdrmdSSHN73TYmJSPklOP768/ki5Svr6OxH6PLH5uxrxOvhW7Hk
         ikE5Pst2nY95OsJftsmlL0b/nCYwelClsxAuCIIby7EGEXAPH3oxwHv/GQOAVMpuINE1
         gL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHRswnMie2qIvKUp9OR3AUMeAWaFYRfKVKlPZ+HXY1I=;
        b=EqAQ4xrvgFC8vMpehDXys4hE+k+UsVBA+XSavnv+WI6zV05/bQCNvxZKLS/ZCKmeRj
         2edzIXEmeXWhSP8Mw7e+cIOMWRtCR2eIIoIaFev7hIQtCRBDkF/3sIo9D55Q+MuN6j0/
         s8oc8mwczSgaOrpHr2WzosjXckoCH55LVk1kF5gNJG3LLrQ0rK4SaWNLKSqrNqJSTakw
         660eBqvaaVCajgmeHu65ml6IrguTMubGX5anbwmGRFAte2uRrqYgjHrDK4go6FGcg4dd
         iZmt6mGnkjSRXbAV4TGncHIWowD2SNr9UkrEJ1uTJMIXXFVHzkcqfpETo98ALfgWIxAb
         wM1A==
X-Gm-Message-State: APjAAAU32iPGkDaK710+Jwu3pEAQMzdXx1d6BXRVoAgBPfuvfoU5w1J/
        ye6szP+Ld0TZbjhx6/2JVAUbTw==
X-Google-Smtp-Source: APXvYqyXL2ZQv314veVc8A1GrF5UXETveuHA2pmBTeLhPYMd6cits9WFMH8k53WFQni/dcrAENLfoQ==
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr7249384wme.33.1556721861306;
        Wed, 01 May 2019 07:44:21 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g10sm36164976wrq.2.2019.05.01.07.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 07:44:20 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Shubham Bansal <illusionist.neo@gmail.com>
Subject: [PATCH v5 bpf-next 11/17] arm: bpf: eliminate zero extension code-gen
Date:   Wed,  1 May 2019 15:43:56 +0100
Message-Id: <1556721842-29836-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
References: <1556721842-29836-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Shubham Bansal <illusionist.neo@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/arm/net/bpf_jit_32.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c8bfbbf..a9f5639 100644
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
@@ -1352,6 +1357,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	switch (code) {
 	/* ALU operations */
 
+	/* explicit zero extension */
+	case BPF_ALU | BPF_ZEXT:
+		emit_a32_mov_i(dst_hi, 0, ctx);
+		break;
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU | BPF_MOV | BPF_X:
@@ -1438,7 +1447,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code));
 		arm_bpf_put_reg32(dst_lo, rd_lo, ctx);
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1453,7 +1463,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			return -EINVAL;
 		if (imm)
 			emit_a32_alu_i(dst_lo, imm, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = dst << imm */
 	case BPF_ALU64 | BPF_LSH | BPF_K:
@@ -1488,7 +1499,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = ~dst */
 	case BPF_ALU | BPF_NEG:
 		emit_a32_alu_i(dst_lo, 0, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (!ctx->prog->aux->verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = ~dst (64 bit) */
 	case BPF_ALU64 | BPF_NEG:
@@ -1838,6 +1850,11 @@ void bpf_jit_compile(struct bpf_prog *prog)
 	/* Nothing to do here. We support Internal BPF. */
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
-- 
2.7.4

