Return-Path: <bpf+bounces-7823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1177CF04
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673881C20CEE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4C9156D9;
	Tue, 15 Aug 2023 15:21:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755C156C2
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 15:21:13 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550D198B
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 08:21:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQFN20Sykz4f3tP1
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:21:06 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgDH68Pgl9tk7KrwAg--.42348S4;
	Tue, 15 Aug 2023 23:21:07 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yonghong Song <yhs@fb.com>,
	Zi Shen Lim <zlim.lnx@gmail.com>
Subject: [PATCH bpf-next 2/7] bpf, arm64: Support sign-extension load instructions
Date: Tue, 15 Aug 2023 11:41:53 -0400
Message-Id: <20230815154158.717901-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230815154158.717901-1-xukuohai@huaweicloud.com>
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDH68Pgl9tk7KrwAg--.42348S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWrCw48ZFW5tr4UWrWktFb_yoW7Ar1rpw
	1UJrWvywsrX3W7Wry8KFn2kF1Ykr48Xrs0grW5tw4rXFW2q34DWFsFqFW2vF1fKFZ5ZrW7
	GrWxZr1xC3y5XrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Xu Kuohai <xukuohai@huawei.com>

Add jit support for sign-extension load instructions.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit.h      |  6 +++++
 arch/arm64/net/bpf_jit_comp.c | 45 ++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index c2edadb8ec6a..086ffbad0eb5 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -59,10 +59,13 @@
 		AARCH64_INSN_LDST_##type##_REG_OFFSET)
 #define A64_STRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, STORE)
 #define A64_LDRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, LOAD)
+#define A64_LDRSB(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 8, SIGNED_LOAD)
 #define A64_STRH(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 16, STORE)
 #define A64_LDRH(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 16, LOAD)
+#define A64_LDRSH(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 16, SIGNED_LOAD)
 #define A64_STR32(Wt, Xn, Xm) A64_LS_REG(Wt, Xn, Xm, 32, STORE)
 #define A64_LDR32(Wt, Xn, Xm) A64_LS_REG(Wt, Xn, Xm, 32, LOAD)
+#define A64_LDRSW(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 32, SIGNED_LOAD)
 #define A64_STR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, STORE)
 #define A64_LDR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, LOAD)
 
@@ -73,10 +76,13 @@
 		AARCH64_INSN_LDST_##type##_IMM_OFFSET)
 #define A64_STRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, STORE)
 #define A64_LDRBI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 8, LOAD)
+#define A64_LDRSBI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 8, SIGNED_LOAD)
 #define A64_STRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, STORE)
 #define A64_LDRHI(Wt, Xn, imm)  A64_LS_IMM(Wt, Xn, imm, 16, LOAD)
+#define A64_LDRSHI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 16, SIGNED_LOAD)
 #define A64_STR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, STORE)
 #define A64_LDR32I(Wt, Xn, imm) A64_LS_IMM(Wt, Xn, imm, 32, LOAD)
+#define A64_LDRSWI(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 32, SIGNED_LOAD)
 #define A64_STR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, STORE)
 #define A64_LDR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, LOAD)
 
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ec2174838f2a..22f1b0d5fb3c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -715,7 +715,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		/* First pass */
 		return 0;
 
-	if (BPF_MODE(insn->code) != BPF_PROBE_MEM)
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
+		BPF_MODE(insn->code) != BPF_PROBE_MEMSX)
 		return 0;
 
 	if (!ctx->prog->aux->extable ||
@@ -779,6 +780,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	u8 dst_adj;
 	int off_adj;
 	int ret;
+	bool sign_extend;
 
 	switch (code) {
 	/* dst = src */
@@ -1122,7 +1124,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		return 1;
 	}
 
-	/* LDX: dst = *(size *)(src + off) */
+	/* LDX: dst = (u64)*(unsigned size *)(src + off) */
 	case BPF_LDX | BPF_MEM | BPF_W:
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_B:
@@ -1131,6 +1133,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+	/* LDXS: dst_reg = (s64)*(signed size *)(src_reg + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 		if (ctx->fpb_offset > 0 && src == fp) {
 			src_adj = fpb;
 			off_adj = off + ctx->fpb_offset;
@@ -1138,29 +1147,49 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			src_adj = src;
 			off_adj = off;
 		}
+		sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
+				BPF_MODE(insn->code) == BPF_PROBE_MEMSX);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
 			if (is_lsi_offset(off_adj, 2)) {
-				emit(A64_LDR32I(dst, src_adj, off_adj), ctx);
+				if (sign_extend)
+					emit(A64_LDRSWI(dst, src_adj, off_adj), ctx);
+				else
+					emit(A64_LDR32I(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_LDR32(dst, src, tmp), ctx);
+				if (sign_extend)
+					emit(A64_LDRSW(dst, src_adj, off_adj), ctx);
+				else
+					emit(A64_LDR32(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_H:
 			if (is_lsi_offset(off_adj, 1)) {
-				emit(A64_LDRHI(dst, src_adj, off_adj), ctx);
+				if (sign_extend)
+					emit(A64_LDRSHI(dst, src_adj, off_adj), ctx);
+				else
+					emit(A64_LDRHI(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_LDRH(dst, src, tmp), ctx);
+				if (sign_extend)
+					emit(A64_LDRSH(dst, src, tmp), ctx);
+				else
+					emit(A64_LDRH(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_B:
 			if (is_lsi_offset(off_adj, 0)) {
-				emit(A64_LDRBI(dst, src_adj, off_adj), ctx);
+				if (sign_extend)
+					emit(A64_LDRSBI(dst, src_adj, off_adj), ctx);
+				else
+					emit(A64_LDRBI(dst, src_adj, off_adj), ctx);
 			} else {
 				emit_a64_mov_i(1, tmp, off, ctx);
-				emit(A64_LDRB(dst, src, tmp), ctx);
+				if (sign_extend)
+					emit(A64_LDRSB(dst, src, tmp), ctx);
+				else
+					emit(A64_LDRB(dst, src, tmp), ctx);
 			}
 			break;
 		case BPF_DW:
-- 
2.30.2


