Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5A74D6257
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiCKNY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 08:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiCKNY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 08:24:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C541122F4F
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 05:23:52 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFRRP0jrnzBrTg;
        Fri, 11 Mar 2022 21:21:53 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 21:23:49 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH bpf-next] bpf, arm64: Optimize BPF store/load using str/ldr with immediate offset
Date:   Fri, 11 Mar 2022 08:35:19 -0500
Message-ID: <20220311133519.3681707-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current BPF store/load instruction is translated by the JIT into two
instructions. The first instruction moves the immediate offset into a
temporary register. The second instruction uses this temporary register
to do the real store/load.

In fact, arm64 supports addressing with immediate offsets. So This patch
introduces optimization that uses arm64 str/ldr instruction with immediate
offset when the offset fits.

Example of generated instuction for r2 = *(u64 *)(r1 + 0):

without optimization:
mov x10, 0
ldr x1, [x0, x10]

with optimization:
ldr x1, [x0, 0]

If the offset is negative, or is not aligned correctly, or exceeds max
value, rollback to the use of temporary register.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/include/asm/insn.h |  9 +++++
 arch/arm64/lib/insn.c         | 67 +++++++++++++++++++++++-------
 arch/arm64/net/bpf_jit.h      | 14 +++++++
 arch/arm64/net/bpf_jit_comp.c | 76 +++++++++++++++++------------------
 4 files changed, 113 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 0b6b31307e68..d507acfdf02d 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -200,6 +200,8 @@ enum aarch64_insn_size_type {
 enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_REG_OFFSET,
 	AARCH64_INSN_LDST_STORE_REG_OFFSET,
+	AARCH64_INSN_LDST_LOAD_IMM_OFFSET,
+	AARCH64_INSN_LDST_STORE_IMM_OFFSET,
 	AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
@@ -334,6 +336,7 @@ __AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
 __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
+__AARCH64_INSN_FUNCS(str_imm,	0x3FC00000, 0x39000000)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
 __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
@@ -341,6 +344,7 @@ __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
@@ -500,6 +504,11 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register offset,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
+				    enum aarch64_insn_register base,
+				    unsigned int imm,
+				    enum aarch64_insn_size_type size,
+				    enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 5e90887deec4..695d7368fadc 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -299,29 +299,24 @@ static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 	return insn;
 }
 
+static const u32 aarch64_insn_ldst_size[] = {
+	[AARCH64_INSN_SIZE_8] = 0,
+	[AARCH64_INSN_SIZE_16] = 1,
+	[AARCH64_INSN_SIZE_32] = 2,
+	[AARCH64_INSN_SIZE_64] = 3,
+};
+
 static u32 aarch64_insn_encode_ldst_size(enum aarch64_insn_size_type type,
 					 u32 insn)
 {
 	u32 size;
 
-	switch (type) {
-	case AARCH64_INSN_SIZE_8:
-		size = 0;
-		break;
-	case AARCH64_INSN_SIZE_16:
-		size = 1;
-		break;
-	case AARCH64_INSN_SIZE_32:
-		size = 2;
-		break;
-	case AARCH64_INSN_SIZE_64:
-		size = 3;
-		break;
-	default:
+	if (type < AARCH64_INSN_SIZE_8 || type > AARCH64_INSN_SIZE_64) {
 		pr_err("%s: unknown size encoding %d\n", __func__, type);
 		return AARCH64_BREAK_FAULT;
 	}
 
+	size = aarch64_insn_ldst_size[type];
 	insn &= ~GENMASK(31, 30);
 	insn |= size << 30;
 
@@ -504,6 +499,50 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 					    offset);
 }
 
+u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
+				    enum aarch64_insn_register base,
+				    unsigned int imm,
+				    enum aarch64_insn_size_type size,
+				    enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+	u32 shift;
+
+	if (size < AARCH64_INSN_SIZE_8 || size > AARCH64_INSN_SIZE_64) {
+		pr_err("%s: unknown size encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	shift = aarch64_insn_ldst_size[size];
+	if (imm & ~(BIT(12 + shift) - BIT(shift))) {
+		pr_err("%s: invalid imm: %d\n", __func__, imm);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	imm >>= shift;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_IMM_OFFSET:
+		insn = aarch64_insn_get_ldr_imm_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_IMM_OFFSET:
+		insn = aarch64_insn_get_str_imm_value();
+		break;
+	default:
+		pr_err("%s: unknown load/store encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
+}
+
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index dd59b5ad8fe4..3920213244f0 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -66,6 +66,20 @@
 #define A64_STR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, STORE)
 #define A64_LDR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, LOAD)
 
+/* Load/store register (immediate offset) */
+#define A64_LS_IMM(Rt, Rn, imm, size, type) \
+	aarch64_insn_gen_load_store_imm(Rt, Rn, imm, \
+		AARCH64_INSN_SIZE_##size, \
+		AARCH64_INSN_LDST_##type##_IMM_OFFSET)
+#define A64_STRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, STORE)
+#define A64_LDRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, LOAD)
+#define A64_STRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, STORE)
+#define A64_LDRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, LOAD)
+#define A64_STR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, STORE)
+#define A64_LDR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, LOAD)
+#define A64_STR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, STORE)
+#define A64_LDR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, LOAD)
+
 /* Load/store register pair */
 #define A64_LS_PAIR(Rt, Rt2, Rn, offset, ls, type) \
 	aarch64_insn_gen_load_store_pair(Rt, Rt2, Rn, offset, \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e850c69e128c..027666ff00e8 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -971,20 +971,22 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
-		emit_a64_mov_i(1, tmp, off, ctx);
+
+#define BUILD_LDX_INSN(a, b, c) \
+case BPF_##a: \
+	if ((off & ((1 << c) - 1)) == 0 && off >= 0 && off <= (0xFFF << c)) { \
+	      emit(A64_LDR##b##I(dst, src, off), ctx); \
+	} else { \
+	      emit_a64_mov_i(1, tmp, off, ctx); \
+	      emit(A64_LDR##b(dst, src, tmp), ctx); \
+	} \
+	break;
+
 		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			emit(A64_LDR32(dst, src, tmp), ctx);
-			break;
-		case BPF_H:
-			emit(A64_LDRH(dst, src, tmp), ctx);
-			break;
-		case BPF_B:
-			emit(A64_LDRB(dst, src, tmp), ctx);
-			break;
-		case BPF_DW:
-			emit(A64_LDR64(dst, src, tmp), ctx);
-			break;
+		BUILD_LDX_INSN(W, 32, 2)
+		BUILD_LDX_INSN(H, H, 1)
+		BUILD_LDX_INSN(B, B, 0)
+		BUILD_LDX_INSN(DW, 64, 3)
 		}
 
 		ret = add_exception_handler(insn, ctx, dst);
@@ -1010,22 +1012,25 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
+
+#define __BUILD_STX_INSN(a, b, c, d, e) \
+	case BPF_##a: \
+		if ((off & ((1 << c) - 1)) == 0 && off >= 0 && off <= (0xFFF << c)) { \
+			emit(A64_STR##b##I(d, dst, off), ctx); \
+		} else { \
+			emit_a64_mov_i(1, e, off, ctx); \
+			emit(A64_STR##b(d, dst, e), ctx); \
+		} \
+		break;
+
+#define BUILD_ST_INSN(a, b, c) __BUILD_STX_INSN(a, b, c, tmp, tmp2)
 		/* Load imm to a register then store it */
-		emit_a64_mov_i(1, tmp2, off, ctx);
 		emit_a64_mov_i(1, tmp, imm, ctx);
 		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			emit(A64_STR32(tmp, dst, tmp2), ctx);
-			break;
-		case BPF_H:
-			emit(A64_STRH(tmp, dst, tmp2), ctx);
-			break;
-		case BPF_B:
-			emit(A64_STRB(tmp, dst, tmp2), ctx);
-			break;
-		case BPF_DW:
-			emit(A64_STR64(tmp, dst, tmp2), ctx);
-			break;
+		BUILD_ST_INSN(W, 32, 2)
+		BUILD_ST_INSN(H, H, 1)
+		BUILD_ST_INSN(B, B, 0)
+		BUILD_ST_INSN(DW, 64, 3)
 		}
 		break;
 
@@ -1034,20 +1039,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
-		emit_a64_mov_i(1, tmp, off, ctx);
+
+#define BUILD_STX_INSN(a, b, c) __BUILD_STX_INSN(a, b, c, src, tmp)
 		switch (BPF_SIZE(code)) {
-		case BPF_W:
-			emit(A64_STR32(src, dst, tmp), ctx);
-			break;
-		case BPF_H:
-			emit(A64_STRH(src, dst, tmp), ctx);
-			break;
-		case BPF_B:
-			emit(A64_STRB(src, dst, tmp), ctx);
-			break;
-		case BPF_DW:
-			emit(A64_STR64(src, dst, tmp), ctx);
-			break;
+		BUILD_STX_INSN(W, 32, 2)
+		BUILD_STX_INSN(H, H, 1)
+		BUILD_STX_INSN(B, B, 0)
+		BUILD_STX_INSN(DW, 64, 3)
 		}
 		break;
 
-- 
2.30.2

