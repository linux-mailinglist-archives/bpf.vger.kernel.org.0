Return-Path: <bpf+bounces-63798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF170B0AF04
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B05F586D92
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238E23F291;
	Sat, 19 Jul 2025 09:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8547237708;
	Sat, 19 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916472; cv=none; b=ZpPaX/Iasxqhe557lZVUlOqqljqzJYG4D+fpGqJflBzKoAhBYvv9AMy7Ywmlcn8nUPwNJ4yM3mIYPlnQ6rhQPsCAcGoWA23v99OHSUlP29IELuLfYvE2umD727ym8Dfiwanu4lMFTORSbNmqqOhkTmptOfWo5ALQiNJogbPtb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916472; c=relaxed/simple;
	bh=ldyNXA+rCDvmBoWrzwmt2PIlgRv4Lkfs6ymbN2zfK68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QeHB1HGX8m3zGR3nRTurbyTw9Kv9QTheRX/qlqKIAVgP4ZOSeLkEVjLA8t4AdgeVSqj25B5mFk5n9bfS5XGxhxUM7skt3zFxhV6GeD27ivY/xDzeucL/hdlnCQvfAsAVNBKkQmiofLHyTbhW+ojT61EwpHWrSCc8aGRBdW1Gp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw11d1WzKHMqT;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D703F1A10D2;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S5;
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
Subject: [PATCH bpf-next 03/10] riscv, bpf: Extract emit_ldx() helper
Date: Sat, 19 Jul 2025 09:17:23 +0000
Message-Id: <20250719091730.2660197-4-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyUAFyruF48tF1DXry5urg_yoW7AF4xpr
	y3Gw1xC39Yqr4Fva4DtF4DWr4ayr4UK3ZrKrZYgw4rtF1SqrW3GF15KF4S9Fyrury8Xr1r
	GFWjyFy3Cay7trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

There's a lot of redundant code related to load into register
operations, let's extract emit_ldx() to make code more compact.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 143 ++++++++------------------------
 1 file changed, 35 insertions(+), 108 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5e354f686ea3..a6a9fd9193e5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -473,90 +473,24 @@ static inline void emit_kcfi(u32 hash, struct rv_jit_context *ctx)
 		emit(hash, ctx);
 }
 
-static int emit_load_8(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+static void emit_ldx_insn(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
+			  struct rv_jit_context *ctx)
 {
-	int insns_start;
-
-	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
-		if (sign_ext)
-			emit(rv_lb(rd, off, rs), ctx);
-		else
-			emit(rv_lbu(rd, off, rs), ctx);
-		return ctx->ninsns - insns_start;
-	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-	insns_start = ctx->ninsns;
-	if (sign_ext)
-		emit(rv_lb(rd, 0, RV_REG_T1), ctx);
-	else
-		emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
-	return ctx->ninsns - insns_start;
-}
-
-static int emit_load_16(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
-{
-	int insns_start;
-
-	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
-		if (sign_ext)
-			emit(rv_lh(rd, off, rs), ctx);
-		else
-			emit(rv_lhu(rd, off, rs), ctx);
-		return ctx->ninsns - insns_start;
-	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-	insns_start = ctx->ninsns;
-	if (sign_ext)
-		emit(rv_lh(rd, 0, RV_REG_T1), ctx);
-	else
-		emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
-	return ctx->ninsns - insns_start;
-}
-
-static int emit_load_32(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
-{
-	int insns_start;
-
-	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
-		if (sign_ext)
-			emit(rv_lw(rd, off, rs), ctx);
-		else
-			emit(rv_lwu(rd, off, rs), ctx);
-		return ctx->ninsns - insns_start;
-	}
-
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-	insns_start = ctx->ninsns;
-	if (sign_ext)
-		emit(rv_lw(rd, 0, RV_REG_T1), ctx);
-	else
-		emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
-	return ctx->ninsns - insns_start;
-}
-
-static int emit_load_64(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
-{
-	int insns_start;
-
-	if (is_12b_int(off)) {
-		insns_start = ctx->ninsns;
+	switch (size) {
+	case BPF_B:
+		emit(sign_ext ? rv_lb(rd, off, rs) : rv_lbu(rd, off, rs), ctx);
+		break;
+	case BPF_H:
+		emit(sign_ext ? rv_lh(rd, off, rs) : rv_lhu(rd, off, rs), ctx);
+		break;
+	case BPF_W:
+		emit(sign_ext ? rv_lw(rd, off, rs) : rv_lwu(rd, off, rs), ctx);
+		break;
+	case BPF_DW:
 		emit_ld(rd, off, rs, ctx);
-		return ctx->ninsns - insns_start;
+		break;
 	}
 
-	emit_imm(RV_REG_T1, off, ctx);
-	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-	insns_start = ctx->ninsns;
-	emit_ld(rd, 0, RV_REG_T1, ctx);
-	return ctx->ninsns - insns_start;
 }
 
 static void emit_stx_insn(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
@@ -577,6 +511,24 @@ static void emit_stx_insn(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context
 	}
 }
 
+static int emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
+		    struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		emit_ldx_insn(rd, off, rs, size, sign_ext, ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start = ctx->ninsns;
+	emit_ldx_insn(rd, 0, RV_REG_T1, size, sign_ext, ctx);
+	return ctx->ninsns - insns_start;
+}
+
 static int emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
 {
 	int insns_start;
@@ -622,20 +574,7 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 	switch (imm) {
 	/* dst_reg = load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
-		switch (BPF_SIZE(code)) {
-		case BPF_B:
-			emit_load_8(false, rd, off, rs, ctx);
-			break;
-		case BPF_H:
-			emit_load_16(false, rd, off, rs, ctx);
-			break;
-		case BPF_W:
-			emit_load_32(false, rd, off, rs, ctx);
-			break;
-		case BPF_DW:
-			emit_load_64(false, rd, off, rs, ctx);
-			break;
-		}
+		emit_ldx(rd, off, rs, BPF_SIZE(code), false, ctx);
 		emit_fence_r_rw(ctx);
 
 		/* If our next insn is a redundant zext, return 1 to tell
@@ -1859,20 +1798,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			rs = RV_REG_T2;
 		}
 
-		switch (BPF_SIZE(code)) {
-		case BPF_B:
-			insn_len = emit_load_8(sign_ext, rd, off, rs, ctx);
-			break;
-		case BPF_H:
-			insn_len = emit_load_16(sign_ext, rd, off, rs, ctx);
-			break;
-		case BPF_W:
-			insn_len = emit_load_32(sign_ext, rd, off, rs, ctx);
-			break;
-		case BPF_DW:
-			insn_len = emit_load_64(sign_ext, rd, off, rs, ctx);
-			break;
-		}
+		insn_len = emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
 
 		ret = add_exception_handler(insn, ctx, rd, insn_len);
 		if (ret)
@@ -1882,6 +1808,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			return 1;
 		break;
 	}
+
 	/* speculation barrier */
 	case BPF_ST | BPF_NOSPEC:
 		break;
-- 
2.34.1


