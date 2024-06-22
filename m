Return-Path: <bpf+bounces-32795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AE913198
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 04:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C2EB241AC
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DED271;
	Sat, 22 Jun 2024 02:20:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593094A06;
	Sat, 22 Jun 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719022809; cv=none; b=fClcl2t0YzETnSv0CkR+5W9vLij3pUmYFMZPZA6vInm8sZCb+nE931lm6pmfu+49TKroaG9gaVKSuB+KMQaQ+Exzq8M+Cg6dQ3WONHtLTrdYqP9QuKD5TDP6Cq7HPtvjCQosWcnikbmfodtPRSlbumZ+gtxbzAN5Oi6WNWvquyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719022809; c=relaxed/simple;
	bh=eJ4SrxS5vfhc9FQOlixOFpSvCmF+zTFtmlTj3XCZllM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UILsWhCZSSAE576D4eXi34D6d6OGsIIcQxMu9QKvru7TR8I9HzTc7GybL1kIBwIEDDgUWNG2GtmRVofg6DX0uB9yQc+kVYuDQe9Y/BYkDQCYODE/a4QPCat8KVTao1HPXETrpH3tlw9PM5LeH+5QgMPUeTSCQ8dNacyR/P7rwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5dGS4Xlfz4f3kw6;
	Sat, 22 Jun 2024 10:19:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8FB151A0189;
	Sat, 22 Jun 2024 10:19:56 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgCnPK7INHZmmlBiAg--.22370S3;
	Sat, 22 Jun 2024 10:19:56 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH RESEND bpf-next v4 1/3] riscv, bpf: Add 12-argument support for RV64 bpf trampoline
Date: Sat, 22 Jun 2024 02:21:27 +0000
Message-Id: <20240622022129.3844473-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622022129.3844473-1-pulehui@huaweicloud.com>
References: <20240622022129.3844473-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnPK7INHZmmlBiAg--.22370S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar15Jw13Kr13Ww4xtF4UXFb_yoWxGw4Dp3
	WDKwsxAF9Yqa17Gayvga1UXF1aya1qv34akFW7Gas3uayYqryDGayFkF4jyry5GryrAw1f
	Ars0vFZ5K3W7CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This patch adds 12 function arguments support for riscv64 bpf
trampoline. The current bpf trampoline supports <= sizeof(u64) bytes
scalar arguments [0] and <= 16 bytes struct arguments [1]. Therefore, we
focus on the situation where scalars are at most XLEN bits and
aggregates whose total size does not exceed 2×XLEN bits in the riscv
calling convention [2].

Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6184 [0]
Link: https://elixir.bootlin.com/linux/v6.8/source/kernel/bpf/btf.c#L6769 [1]
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/draft-20230929-e5c800e661a53efe3c2678d71a306323b60eb13b/riscv-abi.pdf [2]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 66 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index d5cebb0b0afe..61c85d97c4fc 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -15,6 +15,7 @@
 #include <asm/percpu.h>
 #include "bpf_jit.h"
 
+#define RV_MAX_REG_ARGS 8
 #define RV_FENTRY_NINSNS 2
 
 #define RV_REG_TCC RV_REG_A6
@@ -690,26 +691,45 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	return ret;
 }
 
-static void store_args(int nregs, int args_off, struct rv_jit_context *ctx)
+static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
-		emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+	for (i = 0; i < nr_arg_slots; i++) {
+		if (i < RV_MAX_REG_ARGS) {
+			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
+		} else {
+			/* skip slots for T0 and FP of traced function */
+			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
+			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+		}
 		args_off -= 8;
 	}
 }
 
-static void restore_args(int nregs, int args_off, struct rv_jit_context *ctx)
+static void restore_args(int nr_reg_args, int args_off, struct rv_jit_context *ctx)
 {
 	int i;
 
-	for (i = 0; i < nregs; i++) {
+	for (i = 0; i < nr_reg_args; i++) {
 		emit_ld(RV_REG_A0 + i, -args_off, RV_REG_FP, ctx);
 		args_off -= 8;
 	}
 }
 
+static void restore_stack_args(int nr_stack_args, int args_off, int stk_arg_off,
+			       struct rv_jit_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < nr_stack_args; i++) {
+		emit_ld(RV_REG_T1, -(args_off - RV_MAX_REG_ARGS * 8), RV_REG_FP, ctx);
+		emit_sd(RV_REG_FP, -stk_arg_off, RV_REG_T1, ctx);
+		args_off -= 8;
+		stk_arg_off -= 8;
+	}
+}
+
 static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_off,
 			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
 {
@@ -782,8 +802,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 {
 	int i, ret, offset;
 	int *branches_off = NULL;
-	int stack_size = 0, nregs = m->nr_args;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
+	int stack_size = 0, nr_arg_slots = 0;
+	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -829,20 +849,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * FP - sreg_off    [ callee saved reg	]
 	 *
 	 *		    [ pads              ] pads for 16 bytes alignment
+	 *
+	 *		    [ stack_argN        ]
+	 *		    [ ...               ]
+	 * FP - stk_arg_off [ stack_arg1        ] BPF_TRAMP_F_CALL_ORIG
 	 */
 
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
-	/* extra regiters for struct arguments */
-	for (i = 0; i < m->nr_args; i++)
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nregs += round_up(m->arg_size[i], 8) / 8 - 1;
-
-	/* 8 arguments passed by registers */
-	if (nregs > 8)
+	if (m->nr_args > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
+	for (i = 0; i < m->nr_args; i++)
+		nr_arg_slots += round_up(m->arg_size[i], 8) / 8;
+
 	/* room of trampoline frame to store return address and frame pointer */
 	stack_size += 16;
 
@@ -852,7 +873,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		retval_off = stack_size;
 	}
 
-	stack_size += nregs * 8;
+	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
 	stack_size += 8;
@@ -869,8 +890,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 8;
 	sreg_off = stack_size;
 
+	if (nr_arg_slots - RV_MAX_REG_ARGS > 0)
+		stack_size += (nr_arg_slots - RV_MAX_REG_ARGS) * 8;
+
 	stack_size = round_up(stack_size, STACK_ALIGN);
 
+	/* room for args on stack must be at the top of stack */
+	stk_arg_off = stack_size;
+
 	if (!is_struct_ops) {
 		/* For the trampoline called from function entry,
 		 * the frame of traced function and the frame of
@@ -906,10 +933,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_sd(RV_REG_FP, -ip_off, RV_REG_T1, ctx);
 	}
 
-	emit_li(RV_REG_T1, nregs, ctx);
+	emit_li(RV_REG_T1, nr_arg_slots, ctx);
 	emit_sd(RV_REG_FP, -nregs_off, RV_REG_T1, ctx);
 
-	store_args(nregs, args_off, ctx);
+	store_args(nr_arg_slots, args_off, ctx);
 
 	/* skip to actual body of traced function */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
@@ -949,7 +976,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
+		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
 		ret = emit_call((const u64)orig_call, true, ctx);
 		if (ret)
 			goto out;
@@ -984,7 +1012,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(nregs, args_off, ctx);
+		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 
 	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
-- 
2.34.1


