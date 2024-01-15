Return-Path: <bpf+bounces-19527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D3282D928
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888A628309A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3638D15AF7;
	Mon, 15 Jan 2024 12:54:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969211CA0;
	Mon, 15 Jan 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDBs35F0pzWmh9;
	Mon, 15 Jan 2024 20:53:27 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EB5D14061B;
	Mon, 15 Jan 2024 20:54:11 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 15 Jan 2024 20:53:56 +0800
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
Subject: [PATCH bpf-next v3 2/6] riscv, bpf: Unify 32-bit zero-extension to emit_zextw
Date: Mon, 15 Jan 2024 12:54:23 +0000
Message-ID: <20240115125427.2914015-3-pulehui@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115125427.2914015-1-pulehui@huawei.com>
References: <20240115125427.2914015-1-pulehui@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)

For code unification, add emit_zextw wrapper to unify all the 32-bit
zero-extension operations.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        |  6 +++
 arch/riscv/net/bpf_jit_comp64.c | 80 +++++++++++++++------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index f9f8d86e762f..e30501b46f8f 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1092,6 +1092,12 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 	emit_addiw(rd, rs, 0, ctx);
 }
 
+static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	emit_slli(rd, rs, 32, ctx);
+	emit_srli(rd, rd, 32, ctx);
+}
+
 #endif /* __riscv_xlen == 64 */
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 73f8a0938ada..20deb906e495 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -326,12 +326,6 @@ static void emit_branch(u8 cond, u8 rd, u8 rs, int rvoff,
 	emit(rv_jalr(RV_REG_ZERO, RV_REG_T1, lower), ctx);
 }
 
-static void emit_zext_32(u8 reg, struct rv_jit_context *ctx)
-{
-	emit_slli(reg, reg, 32, ctx);
-	emit_srli(reg, reg, 32, ctx);
-}
-
 static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 {
 	int tc_ninsn, off, start_insn = ctx->ninsns;
@@ -346,7 +340,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	 */
 	tc_ninsn = insn ? ctx->offset[insn] - ctx->offset[insn - 1] :
 		   ctx->offset[0];
-	emit_zext_32(RV_REG_A2, ctx);
+	emit_zextw(RV_REG_A2, RV_REG_A2, ctx);
 
 	off = offsetof(struct bpf_array, map.max_entries);
 	if (is_12b_check(off, insn))
@@ -408,9 +402,9 @@ static void init_regs(u8 *rd, u8 *rs, const struct bpf_insn *insn,
 static void emit_zext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 {
 	emit_mv(RV_REG_T2, *rd, ctx);
-	emit_zext_32(RV_REG_T2, ctx);
+	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
 	emit_mv(RV_REG_T1, *rs, ctx);
-	emit_zext_32(RV_REG_T1, ctx);
+	emit_zextw(RV_REG_T1, RV_REG_T1, ctx);
 	*rd = RV_REG_T2;
 	*rs = RV_REG_T1;
 }
@@ -426,8 +420,8 @@ static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
 {
 	emit_mv(RV_REG_T2, *rd, ctx);
-	emit_zext_32(RV_REG_T2, ctx);
-	emit_zext_32(RV_REG_T1, ctx);
+	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
+	emit_zextw(RV_REG_T1, RV_REG_T2, ctx);
 	*rd = RV_REG_T2;
 }
 
@@ -519,32 +513,32 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
 		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
 		if (!is64)
-			emit_zext_32(rs, ctx);
+			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_AND | BPF_FETCH:
 		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
 		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
 		if (!is64)
-			emit_zext_32(rs, ctx);
+			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_OR | BPF_FETCH:
 		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
 		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
 		if (!is64)
-			emit_zext_32(rs, ctx);
+			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_XOR | BPF_FETCH:
 		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
 		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
 		if (!is64)
-			emit_zext_32(rs, ctx);
+			emit_zextw(rs, rs, ctx);
 		break;
 	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
 	case BPF_XCHG:
 		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
 		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
 		if (!is64)
-			emit_zext_32(rs, ctx);
+			emit_zextw(rs, rs, ctx);
 		break;
 	/* r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg); */
 	case BPF_CMPXCHG:
@@ -1090,7 +1084,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext */
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 			break;
 		}
 		switch (insn->off) {
@@ -1107,7 +1101,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = dst OP src */
@@ -1115,7 +1109,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_add(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
@@ -1125,31 +1119,31 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_subw(rd, rd, rs, ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit_and(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit_or(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit_xor(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1158,7 +1152,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		else
 			emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
@@ -1167,25 +1161,25 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		else
 			emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_X:
 	case BPF_ALU64 | BPF_LSH | BPF_X:
 		emit(is64 ? rv_sll(rd, rd, rs) : rv_sllw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_RSH | BPF_X:
 	case BPF_ALU64 | BPF_RSH | BPF_X:
 		emit(is64 ? rv_srl(rd, rd, rs) : rv_srlw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_ARSH | BPF_X:
 	case BPF_ALU64 | BPF_ARSH | BPF_X:
 		emit(is64 ? rv_sra(rd, rd, rs) : rv_sraw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = -dst */
@@ -1193,7 +1187,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_NEG:
 		emit_sub(rd, RV_REG_ZERO, rd, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = BSWAP##imm(dst) */
@@ -1205,7 +1199,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		case 32:
 			if (!aux->verifier_zext)
-				emit_zext_32(rd, ctx);
+				emit_zextw(rd, rd, ctx);
 			break;
 		case 64:
 			/* Do nothing */
@@ -1267,7 +1261,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_imm(rd, imm, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = dst OP imm */
@@ -1280,7 +1274,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_add(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
@@ -1291,7 +1285,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_sub(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
@@ -1302,7 +1296,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_and(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
@@ -1313,7 +1307,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_or(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
@@ -1324,7 +1318,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_xor(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
@@ -1332,7 +1326,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
 		     rv_mulw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
@@ -1344,7 +1338,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
 			     rv_divuw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
@@ -1356,14 +1350,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
 			     rv_remuw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_K:
 	case BPF_ALU64 | BPF_LSH | BPF_K:
 		emit_slli(rd, rd, imm, ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_RSH | BPF_K:
 	case BPF_ALU64 | BPF_RSH | BPF_K:
@@ -1373,7 +1367,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(rv_srliw(rd, rd, imm), ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_ARSH | BPF_K:
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
@@ -1383,7 +1377,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(rv_sraiw(rd, rd, imm), ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* JUMP off */
-- 
2.34.1


