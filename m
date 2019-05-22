Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E543126A3D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfEVS4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 14:56:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbfEVS4G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 14:56:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so3443348wrq.12
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hs3aOXFP5cwZuVX8rZkOSW6so6CJzEV3XFJOjgmDQIk=;
        b=Ax6Ox1QYNHC9p5dbJuh8H/YSTJBU4yrQYgA/snfNCvRz35//eXfenA138UkZo48tTY
         nc0ocF5w3LIxkfsRuxCePjGZ3ztbNmyjQMYQslEj7fHDXXWxwndhQLfewGvbfGiFYrlB
         KDXBKCf8MSPybQ9kY189PpuGKCat1uaa/Il2gBfmlVxXHYWgYbbNlEQq4x3B6chm/t/P
         yB1mVega9FnLIKa1uu24J3hriHZgZuXaLGnnTT3Dzosh5tRki4K3jQbLi9URvocHkP7j
         PM+i+JAepT6grn8zDZE+CjYUtgPPrBe820Shf3hpsDSf2KEsgnITJoVmrGwGca5Hekrs
         uC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hs3aOXFP5cwZuVX8rZkOSW6so6CJzEV3XFJOjgmDQIk=;
        b=VwKzDDPd8i1s12UbY9IyO5NJIOhBdOLDSaJCsjgZhHO9MJJIqCEuwW1GZoz/PoZw/b
         mVpVYWImJtZ1oWz8VktVMpo2XdZyi/t3nGb4PtBA85CjCyp1fjniSSBRSrVSP6V48SXV
         Ye6WQ/IHTnzHXMZidT0C2sau9xqmePi3Nws8DOikMHbBY/beZdYaJ+T1IyDRzMhE/yy5
         oYEnoeoHhixA3TDdP2Xsirqj0RN+T4dt4KTJW4eCvvPnKedfCOMsAhXwKMMSziCjm72O
         t/BEAmdxXeX6DN9v+BpKlmWdMnoo/LFmGL7iBupN3Afh9UqFL3BLpH0N4ag2H7iH1eOI
         +wxA==
X-Gm-Message-State: APjAAAV/RqRQB36Isxtr0OSNE9ZkcDGrL7FGyCE4eI3eFT42OcyF8sw7
        GL1EZ78G5OoSLQialP7+MKQUwg==
X-Google-Smtp-Source: APXvYqzpEc6nEI9y3fyP3hSEUe8OueSvpOnRP/gioXN5p79XdOmw2okdI/qTSODDZV0YrrEg2ubP3A==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr12013116wrq.331.1558551363697;
        Wed, 22 May 2019 11:56:03 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t12sm16328801wro.2.2019.05.22.11.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 11:56:03 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v7 bpf-next 13/16] sparc: bpf: eliminate zero extension code-gen
Date:   Wed, 22 May 2019 19:55:09 +0100
Message-Id: <1558551312-17081-14-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
References: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
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

