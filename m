Return-Path: <bpf+bounces-30003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554E18C9049
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD18A1F2255D
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAFD528;
	Sat, 18 May 2024 09:45:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A918199B8;
	Sat, 18 May 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716025508; cv=none; b=QNimxvZkTlquu3/Ct1y0znZOJRco2VXUoh+rK9kbh5XqDL5xdEW/1IpdXk9kOpNw80smCdAfSRZns1Oh82/FDSPQPXv6jkDc0LXZy5tiXQP9SR5VkOQrUI8glyb2hajmsMI5B1RpgRCSvpUOHz6QIj2b0vu2Yhfc8vHQWfibczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716025508; c=relaxed/simple;
	bh=C1yyLp4U8ssJ9oFrDA2iCC2PCTI+zhQfCkBDigIn3WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjkCBSEXN7+Qi0/f14whBz161kFZ5DeTCQhXYuFYjxyejqIyT+ZpmINNSYJJzLLp/8zwFCigjhhGL2JLFryzpkIK7dsXrBG1D3EMjHDVGovRcPrC93wcq/RzlD39IqDOEsXy5TIFhqliryZY5MJ2N9GQvWdtaPsvDmhzgFj9ap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VhJQt0kxrz4f3jdT;
	Sat, 18 May 2024 17:28:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DC4411A01B9;
	Sat, 18 May 2024 17:28:14 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBnwvWtdEhmbxE_NQ--.58131S5;
	Sat, 18 May 2024 17:28:14 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pu Lehui <pulehui@gmail.com>
Subject: [PATCH bpf-next v2 3/3] riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
Date: Sat, 18 May 2024 09:29:17 +0000
Message-Id: <20240518092917.2771703-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240518092917.2771703-1-pulehui@huaweicloud.com>
References: <20240518092917.2771703-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnwvWtdEhmbxE_NQ--.58131S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8ZryUur45WryfuF1kGrg_yoWrJr13pa
	1kCw1akaykXr13ta4kJ3yUZF1a93ykW343GFZxG3y8CFZ8ZrZ8GryrK3yFvFWFkryrCr18
	JF4qvrn8uF1UJa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We used bpf_prog_pack to aggregate bpf programs into huge page to
relieve the iTLB pressure on the system. We can apply it to bpf
trampoline, as Song had been implemented it in core and x86 [0]. This
patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
and Puranjay have done a lot of work for bpf_prog_pack on RV64,
implementing this function will be easy.

Link: https://lore.kernel.org/all/20231206224054.492250-1-song@kernel.org [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com> #riscv
---
 arch/riscv/net/bpf_jit_comp64.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 212b015e09b7..ea1b85aeb127 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -956,7 +956,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
 		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
-		im->ip_after_call = ctx->insns + ctx->ninsns;
+		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
 		emit(rv_nop(), ctx);
@@ -977,7 +977,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->insns + ctx->ninsns;
+		im->ip_epilogue = ctx->ro_insns + ctx->ninsns;
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
 		if (ret)
@@ -1040,25 +1040,33 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	return ret < 0 ? ret : ninsns_rvoff(ctx.ninsns);
 }
 
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
-				void *image_end, const struct btf_func_model *m,
+void *arch_alloc_bpf_trampoline(unsigned int size)
+{
+	return bpf_prog_pack_alloc(size, bpf_fill_ill_insns);
+}
+
+void arch_free_bpf_trampoline(void *image, unsigned int size)
+{
+	bpf_prog_pack_free(image, size);
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
+				void *ro_image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
 	int ret;
+	void *image, *res;
 	struct rv_jit_context ctx;
-	u32 size = image_end - image;
+	u32 size = ro_image_end - ro_image;
+
+	image = kvmalloc(size, GFP_KERNEL);
+	if (!image)
+		return -ENOMEM;
 
 	ctx.ninsns = 0;
-	/*
-	 * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to write the
-	 * JITed instructions and later copies it to a RX region (ctx.ro_insns).
-	 * It also uses ctx.ro_insns to calculate offsets for jumps etc. As the
-	 * trampoline image uses the same memory area for writing and execution,
-	 * both ctx.insns and ctx.ro_insns can be set to image.
-	 */
 	ctx.insns = image;
-	ctx.ro_insns = image;
+	ctx.ro_insns = ro_image;
 	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 	if (ret < 0)
 		goto out;
@@ -1068,8 +1076,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 		goto out;
 	}
 
-	bpf_flush_icache(image, image_end);
+	res = bpf_arch_text_copy(ro_image, image, size);
+	if (IS_ERR(res)) {
+		ret = PTR_ERR(res);
+		goto out;
+	}
+
+	bpf_flush_icache(ro_image, ro_image_end);
 out:
+	kvfree(image);
 	return ret < 0 ? ret : size;
 }
 
-- 
2.34.1


