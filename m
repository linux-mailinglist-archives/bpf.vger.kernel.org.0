Return-Path: <bpf+bounces-63797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473EDB0AF00
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38D71AA5FD3
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B823C4FD;
	Sat, 19 Jul 2025 09:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8483236453;
	Sat, 19 Jul 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752916470; cv=none; b=TF4Hr1lIx47/VemQlZIahz5rYh1QmtmJVCe0bOpkaeLwwE5ZpVhRUGmtnz6ntRMeLanuFKL7MAoS7TfroiS/B/yXIDZDzQA51lSwdZMQHiNxGxThz+pJgCGCoaHGbLMvySKYKdeHfHQOdsNwIWY6LMOFsiuCR/MJQlEUx9/CSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752916470; c=relaxed/simple;
	bh=VQaIG1E5aqH5q1i5jpHlzb6cE4SEB9iKdOS2AJ6e6K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpU1DxUpNMOt/wiw7yRr/FgQJv0ClhzPctwAKXB2XO0+EM9yM8bfuB+8U3zX7o0mZYH4qHwlgTDp3Ke/9ERr7pb9KihS4tYFp8ze98vS9TJPO0CrC1E49HIyNyEohdVGuQMUy/oIULJUkglJLC+K3648fbYqDvVAs9mFIVthVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bkgw13ynzzKHMqk;
	Sat, 19 Jul 2025 17:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 345C11A17E5;
	Sat, 19 Jul 2025 17:14:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHURLuYXtopCAYAw--.54295S9;
	Sat, 19 Jul 2025 17:14:23 +0800 (CST)
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
Subject: [PATCH bpf-next 07/10] riscv, bpf: Optimize cmpxchg insn with Zacas support
Date: Sat, 19 Jul 2025 09:17:27 +0000
Message-Id: <20250719091730.2660197-8-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHURLuYXtopCAYAw--.54295S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZr13Zry7Gw1xJFW7JFW8JFb_yoW5AFyrpF
	WSkwn3CayIqw17ZF9xJr4DWw1rJF4093W7KFnxG34rtF42qrZrG3WrKw4SyFy5X34UWryS
	gFWYkry3ua4xXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Optimize cmpxchg instruction with amocas.w and amocas.d
Zacas instructions.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        | 27 +++++++++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 18 ++----------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 2351fba5d3e7..0790f40b7e9d 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -1294,6 +1294,33 @@ static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
 	emit_mv(rd, RV_REG_T2, ctx);
 }
 
+static inline void emit_cmpxchg(u8 rd, u8 rs, u8 r0, bool is64, struct rv_jit_context *ctx)
+{
+	int jmp_offset;
+
+	if (rv_ext_enabled(ZACAS)) {
+		emit(is64 ? rvzacas_amocas_d(r0, rs, rd, 1, 1) :
+		     rvzacas_amocas_w(r0, rs, rd, 1, 1), ctx);
+		if (!is64)
+			emit_zextw(r0, r0, ctx);
+		return;
+	}
+
+	if (is64)
+		emit_mv(RV_REG_T2, r0, ctx);
+	else
+		emit_addiw(RV_REG_T2, r0, 0, ctx);
+	emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
+	     rv_lr_w(r0, 0, rd, 0, 0), ctx);
+	jmp_offset = ninsns_rvoff(8);
+	emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
+	emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 1) :
+	     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
+	jmp_offset = ninsns_rvoff(-6);
+	emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
+	emit_fence_rw_rw(ctx);
+}
+
 #endif /* __riscv_xlen == 64 */
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index a6a9fd9193e5..8e813809d305 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -599,10 +599,9 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
 static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 			   struct rv_jit_context *ctx)
 {
-	u8 r0, code = insn->code;
+	u8 code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
-	int jmp_offset;
 	bool is64;
 
 	if (BPF_SIZE(code) != BPF_W && BPF_SIZE(code) != BPF_DW) {
@@ -673,20 +672,7 @@ static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 		break;
 	/* r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg); */
 	case BPF_CMPXCHG:
-		r0 = bpf_to_rv_reg(BPF_REG_0, ctx);
-		if (is64)
-			emit_mv(RV_REG_T2, r0, ctx);
-		else
-			emit_addiw(RV_REG_T2, r0, 0, ctx);
-		emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
-		     rv_lr_w(r0, 0, rd, 0, 0), ctx);
-		jmp_offset = ninsns_rvoff(8);
-		emit(rv_bne(RV_REG_T2, r0, jmp_offset >> 1), ctx);
-		emit(is64 ? rv_sc_d(RV_REG_T3, rs, rd, 0, 1) :
-		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
-		jmp_offset = ninsns_rvoff(-6);
-		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
-		emit_fence_rw_rw(ctx);
+		emit_cmpxchg(rd, rs, regmap[BPF_REG_0], is64, ctx);
 		break;
 	default:
 		pr_err_once("bpf-jit: invalid atomic RMW opcode %02x\n", imm);
-- 
2.34.1


