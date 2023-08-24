Return-Path: <bpf+bounces-8432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30DE7864DC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203BA1C20D73
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30DA23B7;
	Thu, 24 Aug 2023 01:45:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6317EF;
	Thu, 24 Aug 2023 01:45:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FAE6A;
	Wed, 23 Aug 2023 18:45:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWQsC5sfYz4f3pFh;
	Thu, 24 Aug 2023 09:45:51 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgB3TaBNtuZk2HbCBQ--.33536S4;
	Thu, 24 Aug 2023 09:45:52 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 2/7] riscv, bpf: Support sign-extension load insns
Date: Thu, 24 Aug 2023 09:49:56 +0000
Message-Id: <20230824095001.3408573-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3TaBNtuZk2HbCBQ--.33536S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4fWrWkArW5Kr1UAw1xGrg_yoWrtr17pF
	W3Gw1fC39YqrWSqF9rtF17Wr45Ar48WFnFgrW3K3yFqF4IqrZxWFyUtw4aya45GryrXa48
	GFW2vryak3Z2grDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRKLvtUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Add Support sign-extension load instructions for RV64.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        | 10 +++++++
 arch/riscv/net/bpf_jit_comp64.c | 46 +++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 2717f5490428..a52a3dda18c3 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -501,6 +501,16 @@ static inline u32 rv_ble(u8 rs1, u8 rs2, u16 imm12_1)
 	return rv_bge(rs2, rs1, imm12_1);
 }
 
+static inline u32 rv_lb(u8 rd, u16 imm11_0, u8 rs1)
+{
+	return rv_i_insn(imm11_0, rs1, 0, rd, 0x03);
+}
+
+static inline u32 rv_lh(u8 rd, u16 imm11_0, u8 rs1)
+{
+	return rv_i_insn(imm11_0, rs1, 1, rd, 0x03);
+}
+
 static inline u32 rv_lw(u8 rd, u16 imm11_0, u8 rs1)
 {
 	return rv_i_insn(imm11_0, rs1, 2, rd, 0x03);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f2644e7ea6b5..fd36cb17101a 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -580,7 +580,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	unsigned long pc;
 	off_t offset;
 
-	if (!ctx->insns || !ctx->prog->aux->extable || BPF_MODE(insn->code) != BPF_PROBE_MEM)
+	if (!ctx->insns || !ctx->prog->aux->extable ||
+	    (BPF_MODE(insn->code) != BPF_PROBE_MEM && BPF_MODE(insn->code) != BPF_PROBE_MEMSX))
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
@@ -1486,7 +1487,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		return 1;
 	}
 
-	/* LDX: dst = *(size *)(src + off) */
+	/* LDX: dst = *(unsigned size *)(src + off) */
 	case BPF_LDX | BPF_MEM | BPF_B:
 	case BPF_LDX | BPF_MEM | BPF_H:
 	case BPF_LDX | BPF_MEM | BPF_W:
@@ -1495,14 +1496,28 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+	/* LDSX: dst = *(signed size *)(src + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 	{
 		int insn_len, insns_start;
+		bool sign_ext;
+
+		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
+			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
 
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
 			if (is_12b_int(off)) {
 				insns_start = ctx->ninsns;
-				emit(rv_lbu(rd, off, rs), ctx);
+				if (sign_ext)
+					emit(rv_lb(rd, off, rs), ctx);
+				else
+					emit(rv_lbu(rd, off, rs), ctx);
 				insn_len = ctx->ninsns - insns_start;
 				break;
 			}
@@ -1510,13 +1525,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, off, ctx);
 			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
 			insns_start = ctx->ninsns;
-			emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
+			if (sign_ext)
+				emit(rv_lb(rd, 0, RV_REG_T1), ctx);
+			else
+				emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
 			insn_len = ctx->ninsns - insns_start;
 			break;
 		case BPF_H:
 			if (is_12b_int(off)) {
 				insns_start = ctx->ninsns;
-				emit(rv_lhu(rd, off, rs), ctx);
+				if (sign_ext)
+					emit(rv_lh(rd, off, rs), ctx);
+				else
+					emit(rv_lhu(rd, off, rs), ctx);
 				insn_len = ctx->ninsns - insns_start;
 				break;
 			}
@@ -1524,13 +1545,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, off, ctx);
 			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
 			insns_start = ctx->ninsns;
-			emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
+			if (sign_ext)
+				emit(rv_lh(rd, 0, RV_REG_T1), ctx);
+			else
+				emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
 			insn_len = ctx->ninsns - insns_start;
 			break;
 		case BPF_W:
 			if (is_12b_int(off)) {
 				insns_start = ctx->ninsns;
-				emit(rv_lwu(rd, off, rs), ctx);
+				if (sign_ext)
+					emit(rv_lw(rd, off, rs), ctx);
+				else
+					emit(rv_lwu(rd, off, rs), ctx);
 				insn_len = ctx->ninsns - insns_start;
 				break;
 			}
@@ -1538,7 +1565,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, off, ctx);
 			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
 			insns_start = ctx->ninsns;
-			emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
+			if (sign_ext)
+				emit(rv_lw(rd, 0, RV_REG_T1), ctx);
+			else
+				emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
 			insn_len = ctx->ninsns - insns_start;
 			break;
 		case BPF_DW:
-- 
2.39.2


