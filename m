Return-Path: <bpf+bounces-9931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CF79ED40
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3965E1C20FE8
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD1200A8;
	Wed, 13 Sep 2023 15:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB251F92C;
	Wed, 13 Sep 2023 15:33:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A0CE;
	Wed, 13 Sep 2023 08:33:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rm4HJ5DXYz4f3l1t;
	Wed, 13 Sep 2023 23:33:48 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgAXIAVd1gFltNV8AQ--.25893S3;
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
Subject: [PATCH bpf-next 1/6] riscv, bpf: Unify 32-bit sign-extension to emit_sextw
Date: Wed, 13 Sep 2023 23:34:08 +0800
Message-Id: <20230913153413.1446068-2-pulehui@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgAXIAVd1gFltNV8AQ--.25893S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrWw45KFWxKrWUXFWxtFb_yoW8KFy7pa
	1jkrs3CrZ2qF4FqasrJFn7Wr45JF4YvF43KryfW398Jan2qFsrG3WFkw4YyFy5GFyrWayr
	ZFWjkr1fCa4vgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected

From: Pu Lehui <pulehui@huawei.com>

For code unification, add emit_sextw wrapper to unify all the 32-bit
sign-extension operations.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index d21c6c92a..03a6ecb43 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1084,6 +1084,11 @@ static inline void emit_subw(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
 		emit(rv_subw(rd, rs1, rs2), ctx);
 }
 
+static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
+{
+	emit_addiw(rd, rs, 0, ctx);
+}
+
 #endif /* __riscv_xlen == 64 */
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8423f4ddf..8b654c0cf 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -413,8 +413,8 @@ static void emit_zext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 
 static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 {
-	emit_addiw(RV_REG_T2, *rd, 0, ctx);
-	emit_addiw(RV_REG_T1, *rs, 0, ctx);
+	emit_sextw(RV_REG_T2, *rd, ctx);
+	emit_sextw(RV_REG_T1, *rs, ctx);
 	*rd = RV_REG_T2;
 	*rs = RV_REG_T1;
 }
@@ -429,7 +429,7 @@ static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
 
 static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
 {
-	emit_addiw(RV_REG_T2, *rd, 0, ctx);
+	emit_sextw(RV_REG_T2, *rd, ctx);
 	*rd = RV_REG_T2;
 }
 
@@ -1057,7 +1057,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_srai(rd, RV_REG_T1, 64 - insn->off, ctx);
 			break;
 		case 32:
-			emit_addiw(rd, rs, 0, ctx);
+			emit_sextw(rd, rs, ctx);
 			break;
 		}
 		if (!is64 && !aux->verifier_zext)
@@ -1457,7 +1457,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 * as t1 is used only in comparison against zero.
 		 */
 		if (!is64 && imm < 0)
-			emit_addiw(RV_REG_T1, RV_REG_T1, 0, ctx);
+			emit_sextw(RV_REG_T1, RV_REG_T1, ctx);
 		e = ctx->ninsns;
 		rvoff -= ninsns_rvoff(e - s);
 		emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
-- 
2.25.1


