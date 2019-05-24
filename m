Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8282A134
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbfEXW1n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 18:27:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404482AbfEXW1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so11395519wrv.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hs3aOXFP5cwZuVX8rZkOSW6so6CJzEV3XFJOjgmDQIk=;
        b=O0MFbnlthZAe6XUWB6hFq2BBXANGh+qSqwGg7erWZj6bKt7/jj/m/Zng1b7rRk88I0
         smnFwO7W4zQY7K4OABMveAG+xANhSi4Ph1tEL0seCd7oo59ZXMO+GKEtQRIsboVyUdxk
         t+kOfRROG1d8j5g10TioNqajkdb46HqZ3uwEIj1s+nlB8SQSzMmif/xG+Hy8C4WjkUHF
         TAeVh8IAqt1plmbkWXHHyL/5CdidZ05v6uQyPLgWhWQrShZPVNphopX6BvPMdqc5QUeo
         8qtCtLDYXvBg9axxDMRPDYa8gOQJ+7LkJCCelzX84gBGe6P8/PsKGt52gPIHzIrRXMIL
         s7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hs3aOXFP5cwZuVX8rZkOSW6so6CJzEV3XFJOjgmDQIk=;
        b=TO/3thYgHn2fZtAx4Ivp/bDUlXUKvJOoF86kg+IMXPOu/Dz2v6KpuMug8/B1+PRqQI
         ctXLyy/njku0ZmAKHaPdCXFPIwhl7r6y8a3uq7s/EXPVeAcWn19y/JAr26Cm470is/s4
         ulT4cy/oWSHIrBMzxQYS1gSaeuuCG6D6jXr2XHY1pxLBf6hkP6+EvYBLUF4KB8+ZK5Eo
         ChmJvCESQo9AiU/puDR7WXCAV2vPgQWMJx2p2DROg3ZHrOhzD95cw/Bs0e2WJ31DzI0b
         mUO2akHkdKZQxOM9sovhnn/CGBmAz/OlDDvbybKNE04xaAVvqii+QD2ov9PqmDyYsbOS
         +iXg==
X-Gm-Message-State: APjAAAVXPqhrbtXcamg+fns8lQe+wmpPeULXXkLvcErPqEihdEg2AhfJ
        E4RTK/bgv1/6ID8DhkZACKkoDg==
X-Google-Smtp-Source: APXvYqwt8QmjwwnpgSzD7L8mrC/H9ie7BysN1cPsaMtQwJjWQteLD6ttf2UUQ+drAWOVlZqMqQax4g==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr9248149wru.273.1558736858647;
        Fri, 24 May 2019 15:27:38 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:38 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v9 bpf-next 14/17] sparc: bpf: eliminate zero extension code-gen
Date:   Fri, 24 May 2019 23:25:25 +0100
Message-Id: <1558736728-7229-15-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 65428e7..3364e2a 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -908,6 +908,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 		emit_alu3_K(SRL, src, 0, dst, ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		emit_reg_move(src, dst, ctx);
@@ -942,6 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_DIV | BPF_X:
 		emit_write_y(G0, ctx);
 		emit_alu(DIV, src, dst, ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit_alu(UDIVX, src, dst, ctx);
@@ -975,6 +979,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	case BPF_ALU | BPF_RSH | BPF_X:
 		emit_alu(SRL, src, dst, ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit_alu(SRLX, src, dst, ctx);
@@ -997,9 +1003,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		case 16:
 			emit_alu_K(SLL, dst, 16, ctx);
 			emit_alu_K(SRL, dst, 16, ctx);
+			if (insn_is_zext(&insn[1]))
+				return 1;
 			break;
 		case 32:
-			emit_alu_K(SRL, dst, 0, ctx);
+			if (!ctx->prog->aux->verifier_zext)
+				emit_alu_K(SRL, dst, 0, ctx);
 			break;
 		case 64:
 			/* nop */
@@ -1021,6 +1030,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_alu3_K(AND, dst, 0xff, dst, ctx);
 			emit_alu3_K(SLL, tmp, 8, tmp, ctx);
 			emit_alu(OR, tmp, dst, ctx);
+			if (insn_is_zext(&insn[1]))
+				return 1;
 			break;
 
 		case 32:
@@ -1037,6 +1048,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_alu3_K(AND, dst, 0xff, dst, ctx);	/* dst	= dst & 0xff */
 			emit_alu3_K(SLL, dst, 24, dst, ctx);	/* dst  = dst << 24 */
 			emit_alu(OR, tmp, dst, ctx);		/* dst  = dst | tmp */
+			if (insn_is_zext(&insn[1]))
+				return 1;
 			break;
 
 		case 64:
@@ -1050,6 +1063,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = imm */
 	case BPF_ALU | BPF_MOV | BPF_K:
 		emit_loadimm32(imm, dst, ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_loadimm_sext(imm, dst, ctx);
@@ -1132,6 +1147,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	case BPF_ALU | BPF_RSH | BPF_K:
 		emit_alu_K(SRL, dst, imm, ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_ALU64 | BPF_RSH | BPF_K:
 		emit_alu_K(SRLX, dst, imm, ctx);
@@ -1144,7 +1161,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	do_alu32_trunc:
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU &&
+		    !ctx->prog->aux->verifier_zext)
 			emit_alu_K(SRL, dst, 0, ctx);
 		break;
 
@@ -1265,6 +1283,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			rs2 = RS2(tmp);
 		}
 		emit(opcode | RS1(src) | rs2 | RD(dst), ctx);
+		if (opcode != LD64 && insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	}
 	/* ST: *(size *)(dst + off) = imm */
@@ -1432,6 +1452,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = 0x91d02005; /* ta 5 */
 }
 
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
 struct sparc64_jit_data {
 	struct bpf_binary_header *header;
 	u8 *image;
-- 
2.7.4

