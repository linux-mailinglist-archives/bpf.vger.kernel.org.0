Return-Path: <bpf+bounces-9934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509879ED4A
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0012281FF7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE3200D0;
	Wed, 13 Sep 2023 15:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF11F94C;
	Wed, 13 Sep 2023 15:33:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2893;
	Wed, 13 Sep 2023 08:33:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rm4HL06SNz4f3k6Y;
	Wed, 13 Sep 2023 23:33:50 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgAXIAVd1gFltNV8AQ--.25893S5;
	Wed, 13 Sep 2023 23:33:50 +0800 (CST)
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
	Luke Nelson <luke.r.nels@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 3/6] riscv, bpf: Simplify sext and zext logics in branch instructions
Date: Wed, 13 Sep 2023 23:34:10 +0800
Message-Id: <20230913153413.1446068-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913153413.1446068-1-pulehui@huaweicloud.com>
References: <20230913153413.1446068-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXIAVd1gFltNV8AQ--.25893S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUArW7Jr4fCry3uF4rXwb_yoWrWr4DpF
	1xKws3CFZ2qF4rtFyDJFnFqw15Cr48tF9rtrn3G398Jay0vr1kW3Wjkw4Fyry5G34fuw43
	XF4qyr1xW3Wj9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFfHUDUUU
	U
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected

From: Pu Lehui <pulehui@huawei.com>

There are many extension helpers in the current branch instructions, and
the implementation is a bit complicated. We simplify this logic through
two simple extension helpers with alternate register.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 82 +++++++++++++--------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 4a649e195..1728ce16d 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -141,6 +141,19 @@ static bool in_auipc_jalr_range(s64 val)
 		val < ((1L << 31) - (1L << 11));
 }
 
+/* Modify rd pointer to alternate reg to avoid corrupting orignal reg */
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
@@ -395,38 +408,6 @@ static void init_regs(u8 *rd, u8 *rs, const struct bpf_insn *insn,
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
@@ -1372,22 +1353,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
-
 			/* Adjust for extra insns */
 			rvoff -= ninsns_rvoff(e - s);
 		}
-
 		if (BPF_OP(code) == BPF_JSET) {
 			/* Adjust for and */
 			rvoff -= 4;
 			emit_and(RV_REG_T1, rd, rs, ctx);
-			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff,
-				    ctx);
+			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
 		} else {
 			emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
 		}
@@ -1416,21 +1397,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
-
 		/* Adjust for extra insns */
 		rvoff -= ninsns_rvoff(e - s);
 		emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
-- 
2.25.1


