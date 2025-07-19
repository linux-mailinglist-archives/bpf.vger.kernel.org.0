Return-Path: <bpf+bounces-63792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ADCB0AEF5
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3B1AA249E
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0187238D5A;
	Sat, 19 Jul 2025 09:14:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FB1EB5FE;
	Sat, 19 Jul 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916468; cv=none; b=P6wVuBkDTfE+Eo8cksScJUeKD+ChFqAVLUAlJaK6gNNG1+lLAwH+Ck7YVnGIkTR1HiXDWHzvnH89+LGD5pj5H/g6+wTR7KeT2muymCQwxdMIMpXIe5jDgD42u432eeVWkyveEFBWahHerlaMoZAgrJDmYSMSkX5Wc9G+wztHSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916468; c=relaxed/simple;
	bh=h76EDJR8yuwAZX1U7PnKnI/q12hdbfYF8gJ/fm5NiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUhmj9kUWZxcJbaKW/RNa5EArwSZCAZhvzxt4zFZLgJ1QvtnK/Bc7r1uW7g2aCfH/RkkqfwnUXFkwmaAyzYyvTjA7E2xu2M8gVcc0O6l0TjLwXSOLbBv+haCKXThL/BwQ+wZG9P1V4rYoBdbSshm2Jq+Dwqn/zLXI382nkHOW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw06YnLzYQvDm;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A0D961A018D;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S3;
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
Subject: [PATCH bpf-next 01/10] riscv, bpf: Extract emit_stx() helper
Date: Sat, 19 Jul 2025 09:17:21 +0000
Message-Id: <20250719091730.2660197-2-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWDJr4rJw48tF17JF4fZrb_yoWxXFyxpr
	y3trWru39aqw4Fya4DtFsrWw1ayr4jk3ZFgrs3Jwn2qw4aqr45GF18tFWSvFyYk34fXr1r
	GF4j9ry7Cas7JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

There's a lot of redundant code related to store from register
operations, let's extract emit_stx() to make code more compact.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 172 ++++++++------------------------
 1 file changed, 41 insertions(+), 131 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 10e01ff06312..ba75ba179b26 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -559,52 +559,39 @@ static int emit_load_64(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_cont
 	return ctx->ninsns - insns_start;
 }
 
-static void emit_store_8(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+static void emit_stx_insn(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 {
-	if (is_12b_int(off)) {
+	switch (size) {
+	case BPF_B:
 		emit(rv_sb(rd, off, rs), ctx);
-		return;
-	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-	emit(rv_sb(RV_REG_T1, 0, rs), ctx);
-}
-
-static void emit_store_16(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
-{
-	if (is_12b_int(off)) {
+		break;
+	case BPF_H:
 		emit(rv_sh(rd, off, rs), ctx);
-		return;
-	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-	emit(rv_sh(RV_REG_T1, 0, rs), ctx);
-}
-
-static void emit_store_32(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
-{
-	if (is_12b_int(off)) {
+		break;
+	case BPF_W:
 		emit_sw(rd, off, rs, ctx);
-		return;
+		break;
+	case BPF_DW:
+		emit_sd(rd, off, rs, ctx);
+		break;
 	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-	emit_sw(RV_REG_T1, 0, rs, ctx);
 }
 
-static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+static int emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
 {
+	int insns_start;
+
 	if (is_12b_int(off)) {
-		emit_sd(rd, off, rs, ctx);
-		return;
+		insns_start = ctx->ninsns;
+		emit_stx_insn(rd, off, rs, size, ctx);
+		return ctx->ninsns - insns_start;
 	}
 
 	emit_imm(RV_REG_T1, off, ctx);
 	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-	emit_sd(RV_REG_T1, 0, rs, ctx);
+	insns_start = ctx->ninsns;
+	emit_stx_insn(RV_REG_T1, 0, rs, size, ctx);
+	return ctx->ninsns - insns_start;
 }
 
 static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
@@ -642,20 +629,7 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
 		emit_fence_rw_w(ctx);
-		switch (BPF_SIZE(code)) {
-		case BPF_B:
-			emit_store_8(rd, off, rs, ctx);
-			break;
-		case BPF_H:
-			emit_store_16(rd, off, rs, ctx);
-			break;
-		case BPF_W:
-			emit_store_32(rd, off, rs, ctx);
-			break;
-		case BPF_DW:
-			emit_store_64(rd, off, rs, ctx);
-			break;
-		}
+		emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
 		break;
 	default:
 		pr_err_once("bpf-jit: invalid atomic load/store opcode %02x\n", imm);
@@ -2023,106 +1997,42 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	/* STX: *(size *)(dst + off) = src */
 	case BPF_STX | BPF_MEM | BPF_B:
-		emit_store_8(rd, off, rs, ctx);
-		break;
 	case BPF_STX | BPF_MEM | BPF_H:
-		emit_store_16(rd, off, rs, ctx);
-		break;
 	case BPF_STX | BPF_MEM | BPF_W:
-		emit_store_32(rd, off, rs, ctx);
-		break;
 	case BPF_STX | BPF_MEM | BPF_DW:
-		emit_store_64(rd, off, rs, ctx);
-		break;
-	case BPF_STX | BPF_ATOMIC | BPF_B:
-	case BPF_STX | BPF_ATOMIC | BPF_H:
-	case BPF_STX | BPF_ATOMIC | BPF_W:
-	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (bpf_atomic_is_load_store(insn))
-			ret = emit_atomic_ld_st(rd, rs, insn, ctx);
-		else
-			ret = emit_atomic_rmw(rd, rs, insn, ctx);
-		if (ret)
-			return ret;
-		break;
-
+	/* STX | PROBE_MEM32: *(size *)(dst + RV_REG_ARENA + off) = src */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
 	{
-		int insn_len, insns_start;
-
-		emit_add(RV_REG_T2, rd, RV_REG_ARENA, ctx);
-		rd = RV_REG_T2;
-
-		switch (BPF_SIZE(code)) {
-		case BPF_B:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit(rv_sb(rd, off, rs), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit(rv_sb(RV_REG_T1, 0, rs), ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_H:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit(rv_sh(rd, off, rs), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit(rv_sh(RV_REG_T1, 0, rs), ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_W:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit_sw(rd, off, rs, ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit_sw(RV_REG_T1, 0, rs, ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
-		case BPF_DW:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit_sd(rd, off, rs, ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
+		int insn_len;
 
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-			insns_start = ctx->ninsns;
-			emit_sd(RV_REG_T1, 0, rs, ctx);
-			insn_len = ctx->ninsns - insns_start;
-			break;
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit_add(RV_REG_T2, rd, RV_REG_ARENA, ctx);
+			rd = RV_REG_T2;
 		}
 
-		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
-					    insn_len);
+		insn_len = emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
+
+		ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER, insn_len);
 		if (ret)
 			return ret;
-
 		break;
 	}
 
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		if (bpf_atomic_is_load_store(insn))
+			ret = emit_atomic_ld_st(rd, rs, insn, ctx);
+		else
+			ret = emit_atomic_rmw(rd, rs, insn, ctx);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		pr_err("bpf-jit: unknown opcode %02x\n", code);
 		return -EINVAL;
-- 
2.34.1


