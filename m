Return-Path: <bpf+bounces-63800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D11B0AF07
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8363F7B41B5
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA662417C5;
	Sat, 19 Jul 2025 09:14:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31F23C514;
	Sat, 19 Jul 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916473; cv=none; b=O0bzDsAu2E9EZS2H9L4jc+KTjB88iOYvbYnN/bMpknGOQi3JhYoh6U2O98SZLve1STjw2qFg8iFBpKRNVV6HUlLCEBVS0jl1Q28hhfLe/dq1d2utl0rZ8yUWqqutV/ZOCdNgEAKe2snOvDdHq60F8s9TER2VsXufWaa3p9FpGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916473; c=relaxed/simple;
	bh=vNni13W8I3nUmnf2JmxS3wmm3XhS+407n5LxpFs8QlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SmdXKTr0sZHJjHVX2DAO98b3RA20ha99BCNfDysPik5sKnQPzxjzgK1FtSOCjJ7vX6e81vTQkSX97yD2Jx/FN5Co6lIj738ZkVx7LVZGbH93J7PqlAAjubxv5BwIEpsg5PCWZrnqG9MTz2aIYjtEMV0Kb279zplKKKW0guaoPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw15yS8zKHMrM;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 778A21A1882;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S11;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 09/10] riscv, bpf: Add support arena atomics for RV64
Date: Sat, 19 Jul 2025 09:17:29 +0000
Message-Id: <20250719091730.2660197-10-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S11
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW5ur17uFy7Xr43tr48Crg_yoWxXr48p3
	sY9wn3C3yvqw4FyFnrJr47W3W5AF48GrnFqF13A348Xa1aqrnxGFyjga1ayFW5X3y8Wr10
	gFs09a4Sk3W7CFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add arena atomics support for RMW atomics and load-acquire and
store-release instructions. Non-Zacas cmpxchg is implemented via loop,
which is not currently supported because it requires more complex
extable and loop logic.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |  2 ++
 arch/riscv/net/bpf_jit_comp64.c | 60 +++++++++++++++++++++++++++++++--
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index be2915444ce5..632ced07bca4 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1301,8 +1301,10 @@ static inline void emit_cmpxchg(u8 rd, u8 rs, u8 r0, bool is64, struct rv_jit_co
 	int jmp_offset;
 
 	if (rv_ext_enabled(ZACAS)) {
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rvzacas_amocas_d(r0, rs, rd, 1, 1) :
 		     rvzacas_amocas_w(r0, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(r0, r0, ctx);
 		return;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 56b592af53a6..549c3063c7f1 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -571,6 +571,11 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 	switch (imm) {
 	/* dst_reg = load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
+		if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
+			emit_add(RV_REG_T2, rs, RV_REG_ARENA, ctx);
+			rs = RV_REG_T2;
+		}
+
 		emit_ldx(rd, off, rs, BPF_SIZE(code), false, ctx);
 		emit_fence_r_rw(ctx);
 
@@ -582,6 +587,11 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
+		if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
+			emit_add(RV_REG_T2, rd, RV_REG_ARENA, ctx);
+			rd = RV_REG_T2;
+		}
+
 		emit_fence_rw_w(ctx);
 		emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
 		break;
@@ -599,13 +609,12 @@ static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 	u8 code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
-	bool is64;
+	bool is64 = BPF_SIZE(code) == BPF_DW;
 
 	if (BPF_SIZE(code) != BPF_W && BPF_SIZE(code) != BPF_DW) {
 		pr_err_once("bpf-jit: 1- and 2-byte RMW atomics are not supported\n");
 		return -EINVAL;
 	}
-	is64 = BPF_SIZE(code) == BPF_DW;
 
 	if (off) {
 		if (is_12b_int(off)) {
@@ -617,53 +626,76 @@ static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 		rd = RV_REG_T1;
 	}
 
+	if (BPF_MODE(code) == BPF_PROBE_ATOMIC) {
+		emit_add(RV_REG_T1, rd, RV_REG_ARENA, ctx);
+		rd = RV_REG_T1;
+	}
+
 	switch (imm) {
 	/* lock *(u32/u64 *)(dst_reg + off16) <op>= src_reg */
 	case BPF_ADD:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoadd_d(RV_REG_ZERO, rs, rd, 0, 0) :
 		     rv_amoadd_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		break;
 	case BPF_AND:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoand_d(RV_REG_ZERO, rs, rd, 0, 0) :
 		     rv_amoand_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		break;
 	case BPF_OR:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoor_d(RV_REG_ZERO, rs, rd, 0, 0) :
 		     rv_amoor_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		break;
 	case BPF_XOR:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoxor_d(RV_REG_ZERO, rs, rd, 0, 0) :
 		     rv_amoxor_w(RV_REG_ZERO, rs, rd, 0, 0), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		break;
 	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
 	case BPF_ADD | BPF_FETCH:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
 		     rv_amoadd_w(rs, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_AND | BPF_FETCH:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoand_d(rs, rs, rd, 1, 1) :
 		     rv_amoand_w(rs, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_OR | BPF_FETCH:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoor_d(rs, rs, rd, 1, 1) :
 		     rv_amoor_w(rs, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(rs, rs, ctx);
 		break;
 	case BPF_XOR | BPF_FETCH:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoxor_d(rs, rs, rd, 1, 1) :
 		     rv_amoxor_w(rs, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(rs, rs, ctx);
 		break;
 	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
 	case BPF_XCHG:
+		ctx->ex_insn_off = ctx->ninsns;
 		emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
 		     rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
+		ctx->ex_jmp_off = ctx->ninsns;
 		if (!is64)
 			emit_zextw(rs, rs, ctx);
 		break;
@@ -711,7 +743,8 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
@@ -1841,14 +1874,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			return ret;
 		break;
 
+	/* Atomics */
 	case BPF_STX | BPF_ATOMIC | BPF_B:
 	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 		if (bpf_atomic_is_load_store(insn))
 			ret = emit_atomic_ld_st(rd, rs, insn, ctx);
 		else
 			ret = emit_atomic_rmw(rd, rs, insn, ctx);
+
+		ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
 		if (ret)
 			return ret;
 		break;
@@ -1979,6 +2019,20 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	if (in_arena) {
+		switch (insn->code) {
+		case BPF_STX | BPF_ATOMIC | BPF_W:
+		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (insn->imm == BPF_CMPXCHG)
+				return rv_ext_enabled(ZACAS);
+		}
+	}
+
+	return true;
+}
+
 bool bpf_jit_supports_percpu_insn(void)
 {
 	return true;
-- 
2.34.1


