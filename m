Return-Path: <bpf+bounces-10350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9107A584C
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 06:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143D61C20B5A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 04:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAD38BB6;
	Tue, 19 Sep 2023 03:58:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBB341B9;
	Tue, 19 Sep 2023 03:58:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5210F;
	Mon, 18 Sep 2023 20:58:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqSZC0bJ5z4f3n6F;
	Tue, 19 Sep 2023 11:58:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgBn_t1hHAll2JRXAw--.51929S8;
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
Subject: [PATCH bpf-next v2 6/6] riscv, bpf: Optimize bswap insns with Zbb support
Date: Tue, 19 Sep 2023 11:58:39 +0800
Message-Id: <20230919035839.3297328-7-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBn_t1hHAll2JRXAw--.51929S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyrtFWkurWUtr4UWFyDJrb_yoW7GFWfpa
	4fKr4ru3y8tr4ay34DG3Wqgw13GF1jyFnFvF1fJrZ5Xw4jv397G3WUtr4Fyry5G34fuay5
	WF1DGr9rK3WUKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pu Lehui <pulehui@huawei.com>

Optimize bswap instructions by rev8 Zbb instruction conbined with srli
instruction. And Optimize 16-bit zero-extension with Zbb support.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        | 67 +++++++++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 50 +-----------------------
 2 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 944bdd6e4..a04eed672 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1135,12 +1135,79 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 	emit_addiw(rd, rs, 0, ctx);
 }
 
+static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		emit(rvzbb_zexth(rd, rs), ctx);
+	} else {
+		emit_slli(rd, rs, 48, ctx);
+		emit_srli(rd, rd, 48, ctx);
+	}
+}
+
 static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
 {
 	emit_slli(rd, rs, 32, ctx);
 	emit_srli(rd, rd, 32, ctx);
 }
 
+static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
+{
+	if (rvzbb_enabled()) {
+		int bits = 64 - imm;
+
+		emit(rvzbb_rev8(rd, rd), ctx);
+		if (bits)
+			emit_srli(rd, rd, bits, ctx);
+	} else {
+		emit_li(RV_REG_T2, 0, ctx);
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+		if (imm == 16)
+			goto out_be;
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+		if (imm == 32)
+			goto out_be;
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
+		emit_srli(rd, rd, 8, ctx);
+out_be:
+		emit_andi(RV_REG_T1, rd, 0xff, ctx);
+		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
+
+		emit_mv(rd, RV_REG_T2, ctx);
+	}
+}
+
 #endif /* __riscv_xlen == 64 */
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f4ca6b787..35753b142 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1130,8 +1130,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 		switch (imm) {
 		case 16:
-			emit_slli(rd, rd, 48, ctx);
-			emit_srli(rd, rd, 48, ctx);
+			emit_zexth(rd, rd, ctx);
 			break;
 		case 32:
 			if (!aux->verifier_zext)
@@ -1142,54 +1141,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 		}
 		break;
-
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
 	case BPF_ALU64 | BPF_END | BPF_FROM_LE:
-		emit_li(RV_REG_T2, 0, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-		if (imm == 16)
-			goto out_be;
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-		if (imm == 32)
-			goto out_be;
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
-		emit_srli(rd, rd, 8, ctx);
-out_be:
-		emit_andi(RV_REG_T1, rd, 0xff, ctx);
-		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
-
-		emit_mv(rd, RV_REG_T2, ctx);
+		emit_bswap(rd, imm, ctx);
 		break;
 
 	/* dst = imm */
-- 
2.25.1


