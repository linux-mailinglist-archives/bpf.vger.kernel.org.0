Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85D4FAD14
	for <lists+bpf@lfdr.de>; Sun, 10 Apr 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiDJJpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Apr 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiDJJpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Apr 2022 05:45:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3335940E4F
        for <bpf@vger.kernel.org>; Sun, 10 Apr 2022 02:43:38 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kbn7c1l3LzgYQL;
        Sun, 10 Apr 2022 17:41:48 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 10 Apr 2022 17:43:35 +0800
Received: from k04.huawei.com (10.67.174.115) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 10 Apr 2022 17:43:35 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <bjorn@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <pulehui@huawei.com>
Subject: [PATCH bpf-next] riscv, bpf: Implement more atomic operations for RV64
Date:   Sun, 10 Apr 2022 18:12:46 +0800
Message-ID: <20220410101246.232875-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.115]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch implement more bpf atomic operations for RV64.
The added operations are shown below:

atomic[64]_[fetch_]add
atomic[64]_[fetch_]and
atomic[64]_[fetch_]or
atomic[64]_xchg
atomic[64]_cmpxchg

Since riscv specification does not provide AMO instruction for
CAS operation, we use lr/sc instruction for cmpxchg operation,
and AMO instructions for the rest ops. Tests "test_bpf.ko" and
"test_progs -t atomic" have passed, as well as "test_verifier"
with no new failure ceses.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  67 +++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 110 +++++++++++++++++++++++++-------
 2 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index f42d9cd3b..2a3715bf2 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -535,6 +535,43 @@ static inline u32 rv_amoadd_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
 	return rv_amo_insn(0, aq, rl, rs2, rs1, 2, rd, 0x2f);
 }
 
+static inline u32 rv_amoand_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0xc, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_amoor_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x8, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_amoxor_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x4, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_amoswap_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x1, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_lr_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x2, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_sc_w(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x3, aq, rl, rs2, rs1, 2, rd, 0x2f);
+}
+
+static inline u32 rv_fence(u8 pred, u8 succ)
+{
+	u16 imm11_0 = pred << 4 | succ;
+
+	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
+}
+
 /* RVC instrutions. */
 
 static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
@@ -753,6 +790,36 @@ static inline u32 rv_amoadd_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
 	return rv_amo_insn(0, aq, rl, rs2, rs1, 3, rd, 0x2f);
 }
 
+static inline u32 rv_amoand_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0xc, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
+static inline u32 rv_amoor_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x8, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
+static inline u32 rv_amoxor_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x4, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
+static inline u32 rv_amoswap_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x1, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
+static inline u32 rv_lr_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x2, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
+static inline u32 rv_sc_d(u8 rd, u8 rs2, u8 rs1, u8 aq, u8 rl)
+{
+	return rv_amo_insn(0x3, aq, rl, rs2, rs1, 3, rd, 0x2f);
+}
+
 /* RV64-only RVC instructions. */
 
 static inline u16 rvc_ld(u8 rd, u32 imm8, u8 rs1)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 0bcda99d1..00df3a8f9 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -455,6 +455,90 @@ static int emit_call(bool fixed, u64 addr, struct rv_jit_context *ctx)
 	return 0;
 }
 
+static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
+			struct rv_jit_context *ctx)
+{
+	u8 r0;
+	int jmp_offset;
+
+	if (off) {
+		if (is_12b_int(off)) {
+			emit_addi(RV_REG_T1, rd, off, ctx);
+		} else {
+			emit_imm(RV_REG_T1, off, ctx);
+			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+		}
+		rd = RV_REG_T1;
+	}
+
+	switch (imm) {
+	/* lock *(u32/u64 *)(dst_reg + off16) <op>= src_reg */
+	case BPF_ADD:
+		emit(is64 ? rv_amoadd_d(RV_REG_ZERO, rs, rd, 0, 0) :
+		     rv_amoadd_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		break;
+	case BPF_AND:
+		emit(is64 ? rv_amoand_d(RV_REG_ZERO, rs, rd, 0, 0) :
+		     rv_amoand_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		break;
+	case BPF_OR:
+		emit(is64 ? rv_amoor_d(RV_REG_ZERO, rs, rd, 0, 0) :
+		     rv_amoor_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		break;
+	case BPF_XOR:
+		emit(is64 ? rv_amoxor_d(RV_REG_ZERO, rs, rd, 0, 0) :
+		     rv_amoxor_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		break;
+	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
+	case BPF_ADD | BPF_FETCH:
+		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
+		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
+		if (!is64)
+			emit_zext_32(rs, ctx);
+		break;
+	case BPF_AND | BPF_FETCH:
+		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
+		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
+		if (!is64)
+			emit_zext_32(rs, ctx);
+		break;
+	case BPF_OR | BPF_FETCH:
+		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
+		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
+		if (!is64)
+			emit_zext_32(rs, ctx);
+		break;
+	case BPF_XOR | BPF_FETCH:
+		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
+		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
+		if (!is64)
+			emit_zext_32(rs, ctx);
+		break;
+	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
+	case BPF_XCHG:
+		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
+		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
+		if (!is64)
+			emit_zext_32(rs, ctx);
+		break;
+	/* r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg); */
+	case BPF_CMPXCHG:
+		r0 = bpf_to_rv_reg(BPF_REG_0, ctx);
+		emit(is64 ? rv_addi(RV_REG_T2, r0, 0) :
+		     rv_addiw(RV_REG_T2, r0, 0), ctx);
+		emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
+		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
+		jmp_offset = ninsns_rvoff(8);
+		emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
+		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 0) :
+		     rv_sc_w(RV_REG_T3, rs, rd, 0, 0), ctx);
+		jmp_offset = ninsns_rvoff(-6);
+		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
+		emit(rv_fence(0x3, 0x3), ctx);
+		break;
+	}
+}
+
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
 
@@ -1146,30 +1230,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (insn->imm != BPF_ADD) {
-			pr_err("bpf-jit: not supported: atomic operation %02x ***\n",
-			       insn->imm);
-			return -EINVAL;
-		}
-
-		/* atomic_add: lock *(u32 *)(dst + off) += src
-		 * atomic_add: lock *(u64 *)(dst + off) += src
-		 */
-
-		if (off) {
-			if (is_12b_int(off)) {
-				emit_addi(RV_REG_T1, rd, off, ctx);
-			} else {
-				emit_imm(RV_REG_T1, off, ctx);
-				emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-			}
-
-			rd = RV_REG_T1;
-		}
-
-		emit(BPF_SIZE(code) == BPF_W ?
-		     rv_amoadd_w(RV_REG_ZERO, rs, rd, 0, 0) :
-		     rv_amoadd_d(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		emit_atomic(rd, rs, off, imm,
+			    BPF_SIZE(code) == BPF_DW, ctx);
 		break;
 	default:
 		pr_err("bpf-jit: unknown opcode %02x\n", code);
-- 
2.25.1

