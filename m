Return-Path: <bpf+bounces-19540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88E82D9D1
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C73D281462
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C5175B5;
	Mon, 15 Jan 2024 13:12:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C0171BA;
	Mon, 15 Jan 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDCGZ0mJPz4f3jHy;
	Mon, 15 Jan 2024 21:12:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 364FC1A0B60;
	Mon, 15 Jan 2024 21:12:08 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgBnu20iL6VlSeWtAw--.15591S5;
	Mon, 15 Jan 2024 21:12:07 +0800 (CST)
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
Subject: [PATCH RESEND bpf-next v3 3/6] riscv, bpf: Simplify sext and zext logics in branch instructions
Date: Mon, 15 Jan 2024 13:12:32 +0000
Message-Id: <20240115131235.2914289-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnu20iL6VlSeWtAw--.15591S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUArWUGFWfZFWUKr47CFg_yoWrXFyDpF
	1xKws3CFZ2qF4FqFyDtF1qgr15Cr40yF9rtrn3G398Jay0vrn7W3Wjkw4Fyry5X34xuw43
	ZF4qyr17W3WjgrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbMq2tUU
	UUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

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


