Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CB4E2BA9
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 16:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349914AbiCUPTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349907AbiCUPTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9EEDF0B
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 08:17:47 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KMdVj0RCFzfZ0h;
        Mon, 21 Mar 2022 23:16:13 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 23:17:44 +0800
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
Subject: [PATCH bpf-next v5 3/5] bpf, arm64: adjust the offset of str/ldr(immediate) to positive number
Date:   Mon, 21 Mar 2022 11:28:50 -0400
Message-ID: <20220321152852.2334294-4-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321152852.2334294-1-xukuohai@huawei.com>
References: <20220321152852.2334294-1-xukuohai@huawei.com>
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

The BPF STX/LDX instruction uses offset relative to the FP to address
stack space. Since the BPF_FP locates at the top of the frame, the offset
is usually a negative number. However, arm64 str/ldr immediate instruction
requires that offset be a positive number.  Therefore, this patch tries to
convert the offsets.

The method is to find the negative offset furthest from the FP firstly.
Then add it to the FP, calculate a bottom position, called FPB, and then
adjust the offsets in other STR/LDX instructions relative to FPB.

FPB is saved using the callee-saved register x27 of arm64 which is not
used yet.

Before adjusting the offset, the patch checks every instruction to ensure
that the FP does not change in run-time. If the FP may change, no offset
is adjusted.

For example, for the following bpftrace command:

  bpftrace -e 'kprobe:do_sys_open { printf("opening: %s\n", str(arg1)); }'

Without this patch, jited code(fragment):

   0:   bti     c
   4:   stp     x29, x30, [sp, #-16]!
   8:   mov     x29, sp
   c:   stp     x19, x20, [sp, #-16]!
  10:   stp     x21, x22, [sp, #-16]!
  14:   stp     x25, x26, [sp, #-16]!
  18:   mov     x25, sp
  1c:   mov     x26, #0x0                       // #0
  20:   bti     j
  24:   sub     sp, sp, #0x90
  28:   add     x19, x0, #0x0
  2c:   mov     x0, #0x0                        // #0
  30:   mov     x10, #0xffffffffffffff78        // #-136
  34:   str     x0, [x25, x10]
  38:   mov     x10, #0xffffffffffffff80        // #-128
  3c:   str     x0, [x25, x10]
  40:   mov     x10, #0xffffffffffffff88        // #-120
  44:   str     x0, [x25, x10]
  48:   mov     x10, #0xffffffffffffff90        // #-112
  4c:   str     x0, [x25, x10]
  50:   mov     x10, #0xffffffffffffff98        // #-104
  54:   str     x0, [x25, x10]
  58:   mov     x10, #0xffffffffffffffa0        // #-96
  5c:   str     x0, [x25, x10]
  60:   mov     x10, #0xffffffffffffffa8        // #-88
  64:   str     x0, [x25, x10]
  68:   mov     x10, #0xffffffffffffffb0        // #-80
  6c:   str     x0, [x25, x10]
  70:   mov     x10, #0xffffffffffffffb8        // #-72
  74:   str     x0, [x25, x10]
  78:   mov     x10, #0xffffffffffffffc0        // #-64
  7c:   str     x0, [x25, x10]
  80:   mov     x10, #0xffffffffffffffc8        // #-56
  84:   str     x0, [x25, x10]
  88:   mov     x10, #0xffffffffffffffd0        // #-48
  8c:   str     x0, [x25, x10]
  90:   mov     x10, #0xffffffffffffffd8        // #-40
  94:   str     x0, [x25, x10]
  98:   mov     x10, #0xffffffffffffffe0        // #-32
  9c:   str     x0, [x25, x10]
  a0:   mov     x10, #0xffffffffffffffe8        // #-24
  a4:   str     x0, [x25, x10]
  a8:   mov     x10, #0xfffffffffffffff0        // #-16
  ac:   str     x0, [x25, x10]
  b0:   mov     x10, #0xfffffffffffffff8        // #-8
  b4:   str     x0, [x25, x10]
  b8:   mov     x10, #0x8                       // #8
  bc:   ldr     x2, [x19, x10]
  [...]

With this patch, jited code(fragment):

   0:   bti     c
   4:   stp     x29, x30, [sp, #-16]!
   8:   mov     x29, sp
   c:   stp     x19, x20, [sp, #-16]!
  10:   stp     x21, x22, [sp, #-16]!
  14:   stp     x25, x26, [sp, #-16]!
  18:   stp     x27, x28, [sp, #-16]!
  1c:   mov     x25, sp
  20:   sub     x27, x25, #0x88
  24:   mov     x26, #0x0                       // #0
  28:   bti     j
  2c:   sub     sp, sp, #0x90
  30:   add     x19, x0, #0x0
  34:   mov     x0, #0x0                        // #0
  38:   str     x0, [x27]
  3c:   str     x0, [x27, #8]
  40:   str     x0, [x27, #16]
  44:   str     x0, [x27, #24]
  48:   str     x0, [x27, #32]
  4c:   str     x0, [x27, #40]
  50:   str     x0, [x27, #48]
  54:   str     x0, [x27, #56]
  58:   str     x0, [x27, #64]
  5c:   str     x0, [x27, #72]
  60:   str     x0, [x27, #80]
  64:   str     x0, [x27, #88]
  68:   str     x0, [x27, #96]
  6c:   str     x0, [x27, #104]
  70:   str     x0, [x27, #112]
  74:   str     x0, [x27, #120]
  78:   str     x0, [x27, #128]
  7c:   ldr     x2, [x19, #8]
  [...]

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 165 ++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 06037607c04a..dacab86e0cdc 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -26,6 +26,7 @@
 #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
 #define TCALL_CNT (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
+#define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -63,6 +64,7 @@ static const int bpf2a64[] = {
 	[TCALL_CNT] = A64_R(26),
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
+	[FP_BOTTOM] = A64_R(27),
 };
 
 struct jit_ctx {
@@ -73,6 +75,7 @@ struct jit_ctx {
 	int exentry_idx;
 	__le32 *image;
 	u32 stack_size;
+	int fpb_offset;
 };
 
 static inline void emit(const u32 insn, struct jit_ctx *ctx)
@@ -218,7 +221,7 @@ static bool is_addsub_imm(u32 imm)
  *
  * offset = (u64)imm12 << scale
  */
-static bool is_lsi_offset(s16 offset, int scale)
+static bool is_lsi_offset(int offset, int scale)
 {
 	if (offset < 0)
 		return false;
@@ -234,9 +237,9 @@ static bool is_lsi_offset(s16 offset, int scale)
 
 /* Tail call offset to jump into */
 #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
-#define PROLOGUE_OFFSET 8
+#define PROLOGUE_OFFSET 9
 #else
-#define PROLOGUE_OFFSET 7
+#define PROLOGUE_OFFSET 8
 #endif
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
@@ -248,6 +251,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 tcc = bpf2a64[TCALL_CNT];
+	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const int idx0 = ctx->idx;
 	int cur_offset;
 
@@ -286,6 +290,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	emit(A64_PUSH(r6, r7, A64_SP), ctx);
 	emit(A64_PUSH(r8, r9, A64_SP), ctx);
 	emit(A64_PUSH(fp, tcc, A64_SP), ctx);
+	emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
 
 	/* Set up BPF prog stack base register */
 	emit(A64_MOV(1, fp, A64_SP), ctx);
@@ -306,6 +311,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 			emit(A64_BTI_J, ctx);
 	}
 
+	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
+
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
 
@@ -553,10 +560,13 @@ static void build_epilogue(struct jit_ctx *ctx)
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 fpb = bpf2a64[FP_BOTTOM];
 
 	/* We're done with BPF stack */
 	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
+	/* Restore x27 and x28 */
+	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
 	emit(A64_POP(fp, A64_R(26), A64_SP), ctx);
 
@@ -650,6 +660,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -658,6 +670,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
+	u8 src_adj;
+	u8 dst_adj;
+	int off_adj;
 	int ret;
 
 	switch (code) {
@@ -1012,34 +1027,41 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+		if (ctx->fpb_offset > 0 && src == fp) {
+			src_adj = fpb;
+			off_adj = off + ctx->fpb_offset;
+		} else {
+			src_adj = src;
+			off_adj = off;
+		}
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			if (is_lsi_offset(off, 2)) {
-				emit(A64_LDR32I(dst, src, off), ctx);
+			if (is_lsi_offset(off_adj, 2)) {
+				emit(A64_LDR32I(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_LDR32(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_H:
-			if (is_lsi_offset(off, 1)) {
-				emit(A64_LDRHI(dst, src, off), ctx);
+			if (is_lsi_offset(off_adj, 1)) {
+				emit(A64_LDRHI(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_LDRH(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_B:
-			if (is_lsi_offset(off, 0)) {
-				emit(A64_LDRBI(dst, src, off), ctx);
+			if (is_lsi_offset(off_adj, 0)) {
+				emit(A64_LDRBI(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_LDRB(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_DW:
-			if (is_lsi_offset(off, 3)) {
-				emit(A64_LDR64I(dst, src, off), ctx);
+			if (is_lsi_offset(off_adj, 3)) {
+				emit(A64_LDR64I(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_LDR64(dst, src, tmp), ctx);
@@ -1070,36 +1092,43 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
+		if (ctx->fpb_offset > 0 && dst == fp) {
+			dst_adj = fpb;
+			off_adj = off + ctx->fpb_offset;
+		} else {
+			dst_adj = dst;
+			off_adj = off;
+		}
 		/* Load imm to a register then store it */
 		emit_a64_mov_i(1, tmp, imm, ctx);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			if (is_lsi_offset(off, 2)) {
-				emit(A64_STR32I(tmp, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 2)) {
+				emit(A64_STR32I(tmp, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp2, off, ctx);
 				emit(A64_STR32(tmp, dst, tmp2), ctx);
 			}
 			break;
 		case BPF_H:
-			if (is_lsi_offset(off, 1)) {
-				emit(A64_STRHI(tmp, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 1)) {
+				emit(A64_STRHI(tmp, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp2, off, ctx);
 				emit(A64_STRH(tmp, dst, tmp2), ctx);
 			}
 			break;
 		case BPF_B:
-			if (is_lsi_offset(off, 0)) {
-				emit(A64_STRBI(tmp, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 0)) {
+				emit(A64_STRBI(tmp, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp2, off, ctx);
 				emit(A64_STRB(tmp, dst, tmp2), ctx);
 			}
 			break;
 		case BPF_DW:
-			if (is_lsi_offset(off, 3)) {
-				emit(A64_STR64I(tmp, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 3)) {
+				emit(A64_STR64I(tmp, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp2, off, ctx);
 				emit(A64_STR64(tmp, dst, tmp2), ctx);
@@ -1113,34 +1142,41 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
+		if (ctx->fpb_offset > 0 && dst == fp) {
+			dst_adj = fpb;
+			off_adj = off + ctx->fpb_offset;
+		} else {
+			dst_adj = dst;
+			off_adj = off;
+		}
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
-			if (is_lsi_offset(off, 2)) {
-				emit(A64_STR32I(src, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 2)) {
+				emit(A64_STR32I(src, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_STR32(src, dst, tmp), ctx);
 			}
 			break;
 		case BPF_H:
-			if (is_lsi_offset(off, 1)) {
-				emit(A64_STRHI(src, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 1)) {
+				emit(A64_STRHI(src, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_STRH(src, dst, tmp), ctx);
 			}
 			break;
 		case BPF_B:
-			if (is_lsi_offset(off, 0)) {
-				emit(A64_STRBI(src, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 0)) {
+				emit(A64_STRBI(src, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_STRB(src, dst, tmp), ctx);
 			}
 			break;
 		case BPF_DW:
-			if (is_lsi_offset(off, 3)) {
-				emit(A64_STR64I(src, dst, off), ctx);
+			if (is_lsi_offset(off_adj, 3)) {
+				emit(A64_STR64I(src, dst_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
 				emit(A64_STR64(src, dst, tmp), ctx);
@@ -1167,6 +1203,79 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	return 0;
 }
 
+/*
+ * Return 0 if FP may change at runtime, otherwise find the minimum negative
+ * offset to FP, converts it to positive number, and align down to 8 bytes.
+ */
+static int find_fpb_offset(struct bpf_prog *prog)
+{
+	int i;
+	int offset = 0;
+
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		const u8 class = BPF_CLASS(insn->code);
+		const u8 mode = BPF_MODE(insn->code);
+		const u8 src = insn->src_reg;
+		const u8 dst = insn->dst_reg;
+		const s32 imm = insn->imm;
+		const s16 off = insn->off;
+
+		switch (class) {
+		case BPF_STX:
+		case BPF_ST:
+			/* fp holds atomic operation result */
+			if (class == BPF_STX && mode == BPF_ATOMIC &&
+			    ((imm == BPF_XCHG ||
+			      imm == (BPF_FETCH | BPF_ADD) ||
+			      imm == (BPF_FETCH | BPF_AND) ||
+			      imm == (BPF_FETCH | BPF_XOR) ||
+			      imm == (BPF_FETCH | BPF_OR)) &&
+			     src == BPF_REG_FP))
+				return 0;
+
+			if (mode == BPF_MEM && dst == BPF_REG_FP &&
+			    off < offset)
+				offset = insn->off;
+			break;
+
+		case BPF_JMP32:
+		case BPF_JMP:
+			break;
+
+		case BPF_LDX:
+		case BPF_LD:
+			/* fp holds load result */
+			if (dst == BPF_REG_FP)
+				return 0;
+
+			if (class == BPF_LDX && mode == BPF_MEM &&
+			    src == BPF_REG_FP && off < offset)
+				offset = off;
+			break;
+
+		case BPF_ALU:
+		case BPF_ALU64:
+		default:
+			/* fp holds ALU result */
+			if (dst == BPF_REG_FP)
+				return 0;
+		}
+	}
+
+	if (offset < 0) {
+		/*
+		 * safely be converted to a positive 'int', since insn->off
+		 * is 's16'
+		 */
+		offset = -offset;
+		/* align down to 8 bytes */
+		offset = ALIGN_DOWN(offset, 8);
+	}
+
+	return offset;
+}
+
 static int build_body(struct jit_ctx *ctx, bool extra_pass)
 {
 	const struct bpf_prog *prog = ctx->prog;
@@ -1288,6 +1397,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
+	ctx.fpb_offset = find_fpb_offset(prog);
+
 	/*
 	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
 	 *
-- 
2.30.2

