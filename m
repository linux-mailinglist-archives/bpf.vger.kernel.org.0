Return-Path: <bpf+bounces-10351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2147A584E
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB671C20B84
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0DE38BC6;
	Tue, 19 Sep 2023 03:58:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44934CD9;
	Tue, 19 Sep 2023 03:58:35 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB97112;
	Mon, 18 Sep 2023 20:58:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqSZ82NSVz4f3l6v;
	Tue, 19 Sep 2023 11:58:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgBn_t1hHAll2JRXAw--.51929S4;
	Tue, 19 Sep 2023 11:58:28 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 2/6] riscv, bpf: Unify 32-bit zero-extension to emit_zextw
Date: Tue, 19 Sep 2023 11:58:35 +0800
Message-Id: <20230919035839.3297328-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919035839.3297328-1-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn_t1hHAll2JRXAw--.51929S4
X-Coremail-Antispam: 1UD129KBjvJXoWfJw43Jr15GF45WF45GryxAFb_yoWkXrWDpF
	yv9rs3C3yktF4FqF9rJFW7ur15AF10kryUtFy3G39Yqay2qr9xGF4Fk3WIk3y3Xr9xXF1F
	gF429ry293W8trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAGYLU
	UUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

For code unification, add emit_zextw wrapper to unify all the 32-bit
zero-extension operations.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  6 +++
 arch/riscv/net/bpf_jit_comp64.c | 80 +++++++++++++++------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 03a6ecb43..8e0ef4d08 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1089,6 +1089,12 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
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
index 8b654c0cf..4a649e195 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -322,12 +322,6 @@ static void emit_branch(u8 cond, u8 rd, u8 rs, int rvoff,
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
@@ -342,7 +336,7 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 	 */
 	tc_ninsn = insn ? ctx->offset[insn] - ctx->offset[insn - 1] :
 		   ctx->offset[0];
-	emit_zext_32(RV_REG_A2, ctx);
+	emit_zextw(RV_REG_A2, RV_REG_A2, ctx);
 
 	off = offsetof(struct bpf_array, map.max_entries);
 	if (is_12b_check(off, insn))
@@ -404,9 +398,9 @@ static void init_regs(u8 *rd, u8 *rs, const struct bpf_insn *insn,
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
@@ -422,8 +416,8 @@ static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
 {
 	emit_mv(RV_REG_T2, *rd, ctx);
-	emit_zext_32(RV_REG_T2, ctx);
-	emit_zext_32(RV_REG_T1, ctx);
+	emit_zextw(RV_REG_T2, RV_REG_T2, ctx);
+	emit_zextw(RV_REG_T1, RV_REG_T2, ctx);
 	*rd = RV_REG_T2;
 }
 
@@ -511,32 +505,32 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
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
@@ -1044,7 +1038,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (imm == 1) {
 			/* Special mov32 for zext */
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 			break;
 		}
 		switch (insn->off) {
@@ -1061,7 +1055,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = dst OP src */
@@ -1069,7 +1063,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 		emit_add(rd, rd, rs, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_X:
 	case BPF_ALU64 | BPF_SUB | BPF_X:
@@ -1079,31 +1073,31 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
@@ -1112,7 +1106,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		else
 			emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
@@ -1121,25 +1115,25 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
@@ -1147,7 +1141,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_NEG:
 		emit_sub(rd, RV_REG_ZERO, rd, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = BSWAP##imm(dst) */
@@ -1159,7 +1153,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		case 32:
 			if (!aux->verifier_zext)
-				emit_zext_32(rd, ctx);
+				emit_zextw(rd, rd, ctx);
 			break;
 		case 64:
 			/* Do nothing */
@@ -1221,7 +1215,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_imm(rd, imm, ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* dst = dst OP imm */
@@ -1234,7 +1228,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_add(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
 	case BPF_ALU64 | BPF_SUB | BPF_K:
@@ -1245,7 +1239,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_sub(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
@@ -1256,7 +1250,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_and(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
@@ -1267,7 +1261,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_or(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
@@ -1278,7 +1272,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_xor(rd, rd, RV_REG_T1, ctx);
 		}
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_MUL | BPF_K:
@@ -1286,7 +1280,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
 		     rv_mulw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
@@ -1298,7 +1292,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
 			     rv_divuw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
@@ -1310,14 +1304,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
@@ -1327,7 +1321,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(rv_srliw(rd, rd, imm), ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 	case BPF_ALU | BPF_ARSH | BPF_K:
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
@@ -1337,7 +1331,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(rv_sraiw(rd, rd, imm), ctx);
 
 		if (!is64 && !aux->verifier_zext)
-			emit_zext_32(rd, ctx);
+			emit_zextw(rd, rd, ctx);
 		break;
 
 	/* JUMP off */
-- 
2.25.1


