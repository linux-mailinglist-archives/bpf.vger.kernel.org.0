Return-Path: <bpf+bounces-32798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737639131BB
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 05:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722EB1C21212
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 03:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06729D534;
	Sat, 22 Jun 2024 03:03:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B179FE;
	Sat, 22 Jun 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719025388; cv=none; b=HCLpZvllRtRb0hy0qNcuGBMxD1yWDLRFRnFctQ4eAo3mbxQiGs41hMxc66/VHvdJKZUv7J2AS3cdPYSx5mBT5HjLqYYPEerK4iy/yH0chg8aX0il2NydNY103W1PY+SbP/TwhB+k5rXXMrCYOLfCkNtJVQqlDH02tMCWMCi52lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719025388; c=relaxed/simple;
	bh=fx8wPIIrukno4LmQEJsZottYW1nWiLjXjYT9gRocgW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8FtK7dMAEiuDw6+tOqwjlYRMm4UGBWAmcEN6x0clFrP18vQyJFdxC83jzO5lLZNByKLwX4BY+42pUrNFv+zGcmYr6DlGG+IitUo8EmGJt2+Fc+9A9UquJpyBr/q6N9dPyWnpiQD8ptq4J3768+chk9yOR4r7DuyVmZheetzJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5fDJ2cHkz4f3jM1;
	Sat, 22 Jun 2024 11:02:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4C9B61A0170;
	Sat, 22 Jun 2024 11:03:03 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgDXa63kPnZmMh5lAg--.15052S4;
	Sat, 22 Jun 2024 11:03:03 +0800 (CST)
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
Subject: [PATCH RESEND bpf-next v2 2/3] riscv, bpf: Fix out-of-bounds issue when preparing trampoline image
Date: Sat, 22 Jun 2024 03:04:36 +0000
Message-Id: <20240622030437.3973492-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622030437.3973492-1-pulehui@huaweicloud.com>
References: <20240622030437.3973492-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXa63kPnZmMh5lAg--.15052S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47ZF18Kw1kAr43XF1UZFb_yoW5Ar4kpF
	48Cw15ur4kXr1Sk34kJw4UXr1a9aykZ3sruFZ8GrZxAayYqrZxGr1rtw4ayFWFkr95uF4r
	JF4q9Fn8u3WDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We get the size of the trampoline image during the dry run phase and
allocate memory based on that size. The allocated image will then be
populated with instructions during the real patch phase. But after
commit 26ef208c209a ("bpf: Use arch_bpf_trampoline_size"), the `im`
argument is inconsistent in the dry run and real patch phase. This may
cause emit_imm in RV64 to generate a different number of instructions
when generating the 'im' address, potentially causing out-of-bounds
issues. Let's emit the maximum number of instructions for the "im"
address during dry run to fix this problem.

Fixes: 26ef208c209a ("bpf: Use arch_bpf_trampoline_size")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index d5cebb0b0afe..e6d690657f3e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -16,6 +16,8 @@
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
+/* imm that allows emit_imm to emit max count insns */
+#define RV_MAX_COUNT_IMM 0x7FFF7FF7FF7FF7FF
 
 #define RV_REG_TCC RV_REG_A6
 #define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
@@ -916,7 +918,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		orig_call += RV_FENTRY_NINSNS * 4;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_imm(RV_REG_A0, (const s64)im, ctx);
+		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
 		if (ret)
 			return ret;
@@ -977,7 +979,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->insns + ctx->ninsns;
-		emit_imm(RV_REG_A0, (const s64)im, ctx);
+		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
 		if (ret)
 			goto out;
@@ -1046,6 +1048,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 {
 	int ret;
 	struct rv_jit_context ctx;
+	u32 size = image_end - image;
 
 	ctx.ninsns = 0;
 	/*
@@ -1059,11 +1062,16 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	ctx.ro_insns = image;
 	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	bpf_flush_icache(ctx.insns, ctx.insns + ctx.ninsns);
+	if (WARN_ON(size < ninsns_rvoff(ctx.ninsns))) {
+		ret = -E2BIG;
+		goto out;
+	}
 
-	return ninsns_rvoff(ret);
+	bpf_flush_icache(image, image_end);
+out:
+	return ret < 0 ? ret : size;
 }
 
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
-- 
2.34.1


