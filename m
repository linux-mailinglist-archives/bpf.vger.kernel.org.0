Return-Path: <bpf+bounces-32797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7407D9131B9
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 05:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65BC1F235FC
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 03:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F84B9470;
	Sat, 22 Jun 2024 03:03:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D15664;
	Sat, 22 Jun 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719025388; cv=none; b=dHG9s//LBPou9B+g/EqjpSnSN1R4bQHmUzwN/QeDwBk6ktBnrbZb/1IUn/TuhX6RVHAgKWm9ElUt1fW4/+AlpMZOk42xIcsGQcjBN5YeSG5R3WOI1kPjZYDxS9bm3PIWxYEAH1A+tPlJ6AF8RIbjjXd24J0Y9C+Gsx7036kdGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719025388; c=relaxed/simple;
	bh=x8o8ceYz0P/vWBGHnDfUNkQfqmpuu1K+l84RPHurqAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKchL2Dz1yX7rfV5Q+uFui3usA9+KePCpA2s6E1d+4Y7u0iuq0jWY3sZc71hTy1ldDpMU8fJvKEwEMc9fiCrOXok/bC+4QlyY+HBdCzYkdpK88q3PTMk+5OUQ7dsphZS6183RwAra0IplxjgcFymFYuGkZthjT8FBcxjAf3IoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W5fDC3QVdz4f3l1Q;
	Sat, 22 Jun 2024 11:02:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 67AA11A016E;
	Sat, 22 Jun 2024 11:03:03 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgDXa63kPnZmMh5lAg--.15052S5;
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
Subject: [PATCH RESEND bpf-next v2 3/3] riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
Date: Sat, 22 Jun 2024 03:04:37 +0000
Message-Id: <20240622030437.3973492-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622030437.3973492-1-pulehui@huaweicloud.com>
References: <20240622030437.3973492-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXa63kPnZmMh5lAg--.15052S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8ZryUZw4rXryrJrykuFg_yoWrJr13pa
	n7Cw1akaykXr15ta4kJ3yUZF1ak3ykW343GF9xG3y8CFZ0vr98GryrK3yFvFWFkryFkr18
	AF4qvrn8u3WUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
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
index e6d690657f3e..351e1484205e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -957,7 +957,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
 		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
-		im->ip_after_call = ctx->insns + ctx->ninsns;
+		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
 		emit(rv_nop(), ctx);
@@ -978,7 +978,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->insns + ctx->ninsns;
+		im->ip_epilogue = ctx->ro_insns + ctx->ninsns;
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
 		if (ret)
@@ -1041,25 +1041,33 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
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
@@ -1069,8 +1077,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
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


