Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EDC4DB5C0
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350101AbiCPQQX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiCPQQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:16:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7597BC2F
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:15:05 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJZx85nNvz1GCV9;
        Thu, 17 Mar 2022 00:10:04 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 00:15:02 +0800
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
Subject: [PATCH -next v3 2/4] bpf, arm64: Optimize BPF store/load using str/ldr with immediate offset
Date:   Wed, 16 Mar 2022 12:26:19 -0400
Message-ID: <20220316162621.3842604-3-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316162621.3842604-1-xukuohai@huawei.com>
References: <20220316162621.3842604-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 arch/arm64/net/bpf_jit.h      |  14 ++++
 arch/arm64/net/bpf_jit_comp.c | 128 ++++++++++++++++++++++++++++++----
 2 files changed, 127 insertions(+), 15 deletions(-)

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
index e850c69e128c..e56274ce001a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -191,6 +191,47 @@ static bool is_addsub_imm(u32 imm)
 	return !(imm & ~0xfff) || !(imm & ~0xfff000);
 }
 
+/*
+ * There are 3 types of AArch64 LDR/STR (immediate) instruction:
+ * Post-index, Pre-index, Unsigned offset.
+ *
+ * For BPF ldr/str, the "unsigned offset" type is sufficient.
+ *
+ * "Unsigned offset" type LDR(immediate) format:
+ *
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |x x|1 1 1 0 0 1 0 1|         imm12         |    Rn   |    Rt   |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * scale
+ *
+ * "Unsigned offset" type STR(immediate) format:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |x x|1 1 1 0 0 1 0 0|         imm12         |    Rn   |    Rt   |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * scale
+ *
+ * The offset is calculated from imm12 and scale in the following way:
+ *
+ * offset = (u64)imm12 << scale
+ */
+static noinline bool is_lsi_offset(s16 offset, int scale)
+{
+	if (offset < 0)
+		return false;
+
+	if (offset > (0xFFF << scale))
+		return false;
+
+	if (offset & ((1 << scale) - 1))
+		return false;
+
+	return true;
+}
+
 /* Tail call offset to jump into */
 #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
 #define PROLOGUE_OFFSET 8
@@ -971,19 +1012,38 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
-		emit_a64_mov_i(1, tmp, off, ctx);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			emit(A64_LDR32(dst, src, tmp), ctx);
+			if (is_lsi_offset(off, 2)) {
+				emit(A64_LDR32I(dst, src, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_LDR32(dst, src, tmp), ctx);
+			}
 			break;
 		case BPF_H:
-			emit(A64_LDRH(dst, src, tmp), ctx);
+			if (is_lsi_offset(off, 1)) {
+				emit(A64_LDRHI(dst, src, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_LDRH(dst, src, tmp), ctx);
+			}
 			break;
 		case BPF_B:
-			emit(A64_LDRB(dst, src, tmp), ctx);
+			if (is_lsi_offset(off, 0)) {
+				emit(A64_LDRBI(dst, src, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_LDRB(dst, src, tmp), ctx);
+			}
 			break;
 		case BPF_DW:
-			emit(A64_LDR64(dst, src, tmp), ctx);
+			if (is_lsi_offset(off, 3)) {
+				emit(A64_LDR64I(dst, src, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_LDR64(dst, src, tmp), ctx);
+			}
 			break;
 		}
 
@@ -1011,20 +1071,39 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
 		/* Load imm to a register then store it */
-		emit_a64_mov_i(1, tmp2, off, ctx);
 		emit_a64_mov_i(1, tmp, imm, ctx);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			emit(A64_STR32(tmp, dst, tmp2), ctx);
+			if (is_lsi_offset(off, 2)) {
+				emit(A64_STR32I(tmp, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp2, off, ctx);
+				emit(A64_STR32(tmp, dst, tmp2), ctx);
+			}
 			break;
 		case BPF_H:
-			emit(A64_STRH(tmp, dst, tmp2), ctx);
+			if (is_lsi_offset(off, 1)) {
+				emit(A64_STRHI(tmp, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp2, off, ctx);
+				emit(A64_STRH(tmp, dst, tmp2), ctx);
+			}
 			break;
 		case BPF_B:
-			emit(A64_STRB(tmp, dst, tmp2), ctx);
+			if (is_lsi_offset(off, 0)) {
+				emit(A64_STRBI(tmp, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp2, off, ctx);
+				emit(A64_STRB(tmp, dst, tmp2), ctx);
+			}
 			break;
 		case BPF_DW:
-			emit(A64_STR64(tmp, dst, tmp2), ctx);
+			if (is_lsi_offset(off, 3)) {
+				emit(A64_STR64I(tmp, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp2, off, ctx);
+				emit(A64_STR64(tmp, dst, tmp2), ctx);
+			}
 			break;
 		}
 		break;
@@ -1034,19 +1113,38 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
-		emit_a64_mov_i(1, tmp, off, ctx);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			emit(A64_STR32(src, dst, tmp), ctx);
+			if (is_lsi_offset(off, 2)) {
+				emit(A64_STR32I(src, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_STR32(src, dst, tmp), ctx);
+			}
 			break;
 		case BPF_H:
-			emit(A64_STRH(src, dst, tmp), ctx);
+			if (is_lsi_offset(off, 1)) {
+				emit(A64_STRHI(src, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_STRH(src, dst, tmp), ctx);
+			}
 			break;
 		case BPF_B:
-			emit(A64_STRB(src, dst, tmp), ctx);
+			if (is_lsi_offset(off, 0)) {
+				emit(A64_STRBI(src, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_STRB(src, dst, tmp), ctx);
+			}
 			break;
 		case BPF_DW:
-			emit(A64_STR64(src, dst, tmp), ctx);
+			if (is_lsi_offset(off, 3)) {
+				emit(A64_STR64I(src, dst, off), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp, off, ctx);
+				emit(A64_STR64(src, dst, tmp), ctx);
+			}
 			break;
 		}
 		break;
-- 
2.30.2

