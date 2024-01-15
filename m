Return-Path: <bpf+bounces-19528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF782D931
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2191F283A82
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206021643A;
	Mon, 15 Jan 2024 12:54:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABE1640B;
	Mon, 15 Jan 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDBsL5byRzWmh9;
	Mon, 15 Jan 2024 20:53:42 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id AB8F914051C;
	Mon, 15 Jan 2024 20:54:26 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 15 Jan 2024 20:53:57 +0800
From: Pu Lehui <pulehui@huawei.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke
 Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 3/6] riscv, bpf: Simplify sext and zext logics in branch instructions
Date: Mon, 15 Jan 2024 12:54:24 +0000
Message-ID: <20240115125427.2914015-4-pulehui@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115125427.2914015-1-pulehui@huawei.com>
References: <20240115125427.2914015-1-pulehui@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)

There are many extension helpers in the current branch instructions, and
the implementation is a bit complicated. We simplify this logic through
two simple extension helpers with alternate register.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 79 +++++++++++++--------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 20deb906e495..d90784674677 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -141,6 +141,19 @@ static bool in_auipc_jalr_range(s64 val)
 		val < ((1L << 31) - (1L << 11));
 }
 
+/* Modify rd pointer to alternate reg to avoid corrupting original reg */
+static void emit_sextw_alt(u8 *rd, u8 ra, struct rv_jit_context *ctx)
+{
+	emit_sextw(ra, *rd, ctx);
+	*rd = ra;
+}
+
+static void emit_zextw_alt(u8 *rd, u8 ra, struct rv_jit_context *ctx)
+{
+	emit_zextw(ra, *rd, ctx);
+	*rd = ra;
+}
+
 /* Emit fixed-length instructions for address */
 static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct rv_jit_context *ctx)
 {
@@ -399,38 +412,6 @@ static void init_regs(u8 *rd, u8 *rs, const struct bpf_insn *insn,
 		*rs = bpf_to_rv_reg(insn->src_reg, ctx);
 }
 
-static void emit_zext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
-{
-	emit_mv(RV_REG_T2, *rd, ctx);
-	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
-	emit_mv(RV_REG_T1, *rs, ctx);
-	emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
-	*rd = RV_REG_T2;
-	*rs = RV_REG_T1;
-}
-
-static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
-{
-	emit_sextw(RV_REG_T2, *rd, ctx);
-	emit_sextw(RV_REG_T1, *rs, ctx);
-	*rd = RV_REG_T2;
-	*rs = RV_REG_T1;
-}
-
-static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
-{
-	emit_mv(RV_REG_T2, *rd, ctx);
-	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
-	emit_zextw(RV_REG_T1, RV_REG_T2, ctx);
-	*rd = RV_REG_T2;
-}
-
-static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
-{
-	emit_sextw(RV_REG_T2, *rd, ctx);
-	*rd = RV_REG_T2;
-}
-
 static int emit_jump_and_link(u8 rd, s64 rvoff, bool fixed_addr,
 			      struct rv_jit_context *ctx)
 {
@@ -1418,10 +1399,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		rvoff = rv_offset(i, off, ctx);
 		if (!is64) {
 			s = ctx->ninsns;
-			if (is_signed_bpf_cond(BPF_OP(code)))
-				emit_sext_32_rd_rs(&rd, &rs, ctx);
-			else
-				emit_zext_32_rd_rs(&rd, &rs, ctx);
+			if (is_signed_bpf_cond(BPF_OP(code))) {
+				emit_sextw_alt(&rs, RV_REG_T1, ctx);
+				emit_sextw_alt(&rd, RV_REG_T2, ctx);
+			} else {
+				emit_zextw_alt(&rs, RV_REG_T1, ctx);
+				emit_zextw_alt(&rd, RV_REG_T2, ctx);
+			}
 			e = ctx->ninsns;
 
 			/* Adjust for extra insns */
@@ -1432,8 +1416,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			/* Adjust for and */
 			rvoff -= 4;
 			emit_and(RV_REG_T1, rd, rs, ctx);
-			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff,
-				    ctx);
+			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
 		} else {
 			emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
 		}
@@ -1462,18 +1445,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
 		s = ctx->ninsns;
-		if (imm) {
+		if (imm)
 			emit_imm(RV_REG_T1, imm, ctx);
-			rs = RV_REG_T1;
-		} else {
-			/* If imm is 0, simply use zero register. */
-			rs = RV_REG_ZERO;
-		}
+		rs = imm ? RV_REG_T1 : RV_REG_ZERO;
 		if (!is64) {
-			if (is_signed_bpf_cond(BPF_OP(code)))
-				emit_sext_32_rd(&rd, ctx);
-			else
-				emit_zext_32_rd_t1(&rd, ctx);
+			if (is_signed_bpf_cond(BPF_OP(code))) {
+				emit_sextw_alt(&rd, RV_REG_T2, ctx);
+				/* rs has been sign extended */
+			} else {
+				emit_zextw_alt(&rd, RV_REG_T2, ctx);
+				if (imm)
+					emit_zextw(rs, rs, ctx);
+			}
 		}
 		e = ctx->ninsns;
 
-- 
2.34.1


