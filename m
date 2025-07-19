Return-Path: <bpf+bounces-63795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7CB0AEFB
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985C45859A4
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE8623A578;
	Sat, 19 Jul 2025 09:14:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8618238157;
	Sat, 19 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916468; cv=none; b=d/oBIZnLNN5J26oLqEgj3U7N7uzJRW9HgSu2MgLpOnlgXSXdnVzGsJx4lhJf8xjpAtIoanTTBMMh7NIaAoHH3p4WT7VdyY894d0eXJ7/JUwWcvz1YeVQaVk5SzC12wK0Nz5O/Fg9Zab0rReMSLcXChmpeN6ROVmTmS3Nb1sv19A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916468; c=relaxed/simple;
	bh=3WNVVMbICgtUBQ+2+m32VAxdQK3v7AO/RYBe6p2zlLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erA+KBHTgum+JRkz3lyUUtkTYDJqhulpmaRIOnx0d/UbpWM32tJrJqg3ySPogiKnlr3Fzryvg2rkxKVFwJ4n47H3+lsaCsM0FCD6jDK+7OLgY8sA/yZA/RQlZyE/p2FAZ0azNhsVsmlztCvN7m2mAuUOxh+ohHxtIdmj95Enl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw10llQzKHMqW;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA94C1A17E8;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S4;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 02/10] riscv, bpf: Extract emit_st() helper
Date: Sat, 19 Jul 2025 09:17:22 +0000
Message-Id: <20250719091730.2660197-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5ur15urWDKrW8CF1DGFg_yoW7Jr4rpw
	13K3yxu39aqr4Fva4kGF1UWw13AF4UCFsF9Fs3Jwn5Jw43Xr4rGF1UtrWSvFyUC34fZ3yr
	XF1DA3sFk3W7GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

There's a lot of redundant code related to store from immediate
operations, let's extract emit_st() to make code more compact.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 135 ++++++--------------------------
 1 file changed, 26 insertions(+), 109 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ba75ba179b26..5e354f686ea3 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -577,6 +577,24 @@ static void emit_stx_insn(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context
 	}
 }
 
+static int emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	emit_imm(RV_REG_T1, imm, ctx);
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		emit_stx_insn(rd, off, RV_REG_T1, size, ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T2, off, ctx);
+	emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
+	insns_start = ctx->ninsns;
+	emit_stx_insn(RV_REG_T2, 0, RV_REG_T1, size, ctx);
+	return ctx->ninsns - insns_start;
+}
+
 static int emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 {
 	int insns_start;
@@ -1870,128 +1888,27 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_B:
-		emit_imm(RV_REG_T1, imm, ctx);
-		if (is_12b_int(off)) {
-			emit(rv_sb(rd, off, RV_REG_T1), ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T2, off, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-		emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
-		break;
-
 	case BPF_ST | BPF_MEM | BPF_H:
-		emit_imm(RV_REG_T1, imm, ctx);
-		if (is_12b_int(off)) {
-			emit(rv_sh(rd, off, RV_REG_T1), ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T2, off, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-		emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
-		break;
 	case BPF_ST | BPF_MEM | BPF_W:
-		emit_imm(RV_REG_T1, imm, ctx);
-		if (is_12b_int(off)) {
-			emit_sw(rd, off, RV_REG_T1, ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T2, off, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-		emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
-		break;
 	case BPF_ST | BPF_MEM | BPF_DW:
-		emit_imm(RV_REG_T1, imm, ctx);
-		if (is_12b_int(off)) {
-			emit_sd(rd, off, RV_REG_T1, ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T2, off, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
-		break;
-
+	/* ST | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = imm */
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
 	{
-		int insn_len, insns_start;
-
-		emit_add(RV_REG_T3, rd, RV_REG_ARENA, ctx);
-		rd = RV_REG_T3;
-
-		/* Load imm to a register then store it */
-		emit_imm(RV_REG_T1, imm, ctx);
-
-		switch (BPF_SIZE(code)) {
-		case BPF_B:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit(rv_sb(rd, off, RV_REG_T1), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T2, off, ctx);
-			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_H:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit(rv_sh(rd, off, RV_REG_T1), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T2, off, ctx);
-			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_W:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit_sw(rd, off, RV_REG_T1, ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T2, off, ctx);
-			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_DW:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit_sd(rd, off, RV_REG_T1, ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
+		int insn_len;
 
-			emit_imm(RV_REG_T2, off, ctx);
-			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit_add(RV_REG_T3, rd, RV_REG_ARENA, ctx);
+			rd = RV_REG_T3;
 		}
 
-		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
-					    insn_len);
+		insn_len = emit_st(rd, off, imm, BPF_SIZE(code), ctx);
+
+		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER, insn_len);
 		if (ret)
 			return ret;
-
 		break;
 	}
 
-- 
2.34.1


