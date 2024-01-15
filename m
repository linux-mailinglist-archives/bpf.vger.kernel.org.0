Return-Path: <bpf+bounces-19537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3282D9CC
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B091C2174A
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE01757A;
	Mon, 15 Jan 2024 13:12:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2072171CD;
	Mon, 15 Jan 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDCGX1fPsz4f3kp6;
	Mon, 15 Jan 2024 21:12:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E1B091A0CBC;
	Mon, 15 Jan 2024 21:12:07 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgBnu20iL6VlSeWtAw--.15591S3;
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
Subject: [PATCH RESEND bpf-next v3 1/6] riscv, bpf: Unify 32-bit sign-extension to emit_sextw
Date: Mon, 15 Jan 2024 13:12:30 +0000
Message-Id: <20240115131235.2914289-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnu20iL6VlSeWtAw--.15591S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1xZrykCryrKw4xuFyrXrb_yoW5Jr4xpF
	45Krs3CrZ2qF4FqasrtFsrWr45GFsYvFW7KryfW398Ja1IqFsrG3WFkw4ayry5JFyrWa1r
	ZFWqkr12k3WvgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj3Ef7UUUUU=
	=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

For code unification, add emit_sextw wrapper to unify all the 32-bit
sign-extension operations.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
 arch/riscv/net/bpf_jit.h        |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index a5ce1ab76ece..f9f8d86e762f 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1087,6 +1087,11 @@ static inline void emit_subw(u8 rd, u8 rs1, u8 rs2, struct rv_jit_context *ctx)
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
index 58dc64dd94a8..73f8a0938ada 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -417,8 +417,8 @@ static void emit_zext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 
 static void emit_sext_32_rd_rs(u8 *rd, u8 *rs, struct rv_jit_context *ctx)
 {
-	emit_addiw(RV_REG_T2, *rd, 0, ctx);
-	emit_addiw(RV_REG_T1, *rs, 0, ctx);
+	emit_sextw(RV_REG_T2, *rd, ctx);
+	emit_sextw(RV_REG_T1, *rs, ctx);
 	*rd = RV_REG_T2;
 	*rs = RV_REG_T1;
 }
@@ -433,7 +433,7 @@ static void emit_zext_32_rd_t1(u8 *rd, struct rv_jit_context *ctx)
 
 static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
 {
-	emit_addiw(RV_REG_T2, *rd, 0, ctx);
+	emit_sextw(RV_REG_T2, *rd, ctx);
 	*rd = RV_REG_T2;
 }
 
@@ -1103,7 +1103,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_srai(rd, RV_REG_T1, 64 - insn->off, ctx);
 			break;
 		case 32:
-			emit_addiw(rd, rs, 0, ctx);
+			emit_sextw(rd, rs, ctx);
 			break;
 		}
 		if (!is64 && !aux->verifier_zext)
@@ -1503,7 +1503,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 * as t1 is used only in comparison against zero.
 		 */
 		if (!is64 && imm < 0)
-			emit_addiw(RV_REG_T1, RV_REG_T1, 0, ctx);
+			emit_sextw(RV_REG_T1, RV_REG_T1, ctx);
 		e = ctx->ninsns;
 		rvoff -= ninsns_rvoff(e - s);
 		emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
-- 
2.34.1


