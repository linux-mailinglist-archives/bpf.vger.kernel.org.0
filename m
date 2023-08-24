Return-Path: <bpf+bounces-8437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD27864E6
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0368D1C20B6C
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF856FA9;
	Thu, 24 Aug 2023 01:45:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD695669;
	Thu, 24 Aug 2023 01:45:59 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D910E5;
	Wed, 23 Aug 2023 18:45:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RWQsB0JWtz4f3nxT;
	Thu, 24 Aug 2023 09:45:50 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgB3TaBNtuZk2HbCBQ--.33536S7;
	Thu, 24 Aug 2023 09:45:53 +0800 (CST)
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
Subject: [PATCH bpf-next v2 5/7] riscv, bpf: Support signed div/mod insns
Date: Thu, 24 Aug 2023 09:49:59 +0000
Message-Id: <20230824095001.3408573-6-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB3TaBNtuZk2HbCBQ--.33536S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWrtF1DZFWxuw15Gr4rXwb_yoW5KF4fpr
	9Ykrn3Z3yjqr4fJr9rJF4xXas5Arn2gwnFvF13KFWUtanFqrWDGrWfKw4fA3sxXrWfWa4D
	WFWY9r90k39Fyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
	wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
	IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
	JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Add support signed div/mod instructions for RV64.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        | 20 ++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index a52a3dda18c3..d21c6c92a683 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -431,11 +431,21 @@ static inline u32 rv_mulhu(u8 rd, u8 rs1, u8 rs2)
 	return rv_r_insn(1, rs2, rs1, 3, rd, 0x33);
 }
 
+static inline u32 rv_div(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(1, rs2, rs1, 4, rd, 0x33);
+}
+
 static inline u32 rv_divu(u8 rd, u8 rs1, u8 rs2)
 {
 	return rv_r_insn(1, rs2, rs1, 5, rd, 0x33);
 }
 
+static inline u32 rv_rem(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(1, rs2, rs1, 6, rd, 0x33);
+}
+
 static inline u32 rv_remu(u8 rd, u8 rs1, u8 rs2)
 {
 	return rv_r_insn(1, rs2, rs1, 7, rd, 0x33);
@@ -776,11 +786,21 @@ static inline u32 rv_mulw(u8 rd, u8 rs1, u8 rs2)
 	return rv_r_insn(1, rs2, rs1, 0, rd, 0x3b);
 }
 
+static inline u32 rv_divw(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(1, rs2, rs1, 4, rd, 0x3b);
+}
+
 static inline u32 rv_divuw(u8 rd, u8 rs1, u8 rs2)
 {
 	return rv_r_insn(1, rs2, rs1, 5, rd, 0x3b);
 }
 
+static inline u32 rv_remw(u8 rd, u8 rs1, u8 rs2)
+{
+	return rv_r_insn(1, rs2, rs1, 6, rd, 0x3b);
+}
+
 static inline u32 rv_remuw(u8 rd, u8 rs1, u8 rs2)
 {
 	return rv_r_insn(1, rs2, rs1, 7, rd, 0x3b);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 076619f4aa82..ba4535ac194f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1107,13 +1107,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
+		if (off)
+			emit(is64 ? rv_div(rd, rd, rs) : rv_divw(rd, rd, rs), ctx);
+		else
+			emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
+		if (off)
+			emit(is64 ? rv_rem(rd, rd, rs) : rv_remw(rd, rd, rs), ctx);
+		else
+			emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
@@ -1284,16 +1290,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
-		emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
-		     rv_divuw(rd, rd, RV_REG_T1), ctx);
+		if (off)
+			emit(is64 ? rv_div(rd, rd, RV_REG_T1) :
+			     rv_divw(rd, rd, RV_REG_T1), ctx);
+		else
+			emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
+			     rv_divuw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 		emit_imm(RV_REG_T1, imm, ctx);
-		emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
-		     rv_remuw(rd, rd, RV_REG_T1), ctx);
+		if (off)
+			emit(is64 ? rv_rem(rd, rd, RV_REG_T1) :
+			     rv_remw(rd, rd, RV_REG_T1), ctx);
+		else
+			emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
+			     rv_remuw(rd, rd, RV_REG_T1), ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
-- 
2.39.2


