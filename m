Return-Path: <bpf+bounces-20077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5C838C16
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 11:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA7A1F265F8
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67D5D737;
	Tue, 23 Jan 2024 10:32:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4015C8F5;
	Tue, 23 Jan 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005935; cv=none; b=j4yqNneCMP7+BQh1qWzojyZvxH4pOoEPx/jET0vj51xATF3pus3lfMQ7pdYq7QmYZYLo9PGN4YtOvS/GDb105eUb8HGBxs5IXiLUv4zkK5B/i2meM8lHo6vR6UxRcQ3Y8CDlZkiGkU7GGTJw214VKVwUr0xuN2YSO6fGNCw6FAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005935; c=relaxed/simple;
	bh=1B+0XeBZt6BNXLdTmwUPFZo9vm5DlNu7CRKkxa61WHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqdJd8vewivj17Uqu3aYkehKj0RJmESajHXlVj78WoI+TTvJY6EBGkNhQkp7878C6wg+tOQqgQoagPgIiyjsJDA71KRhM87OCebgvpJoju0cHiaLPrlJDRaWc+nHT1fvAxGeLprUsc9mb5I3FDuTzeLHMtEsssPDF1jfRJQBTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3LB27wyz4f3jpl;
	Tue, 23 Jan 2024 18:32:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9934E1A0281;
	Tue, 23 Jan 2024 18:32:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBHaQyfla9ldy79Bg--.53064S5;
	Tue, 23 Jan 2024 18:32:04 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next 3/3] riscv, bpf: Use bpf_prog_pack for RV64 bpf trampoline
Date: Tue, 23 Jan 2024 10:32:41 +0000
Message-Id: <20240123103241.2282122-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123103241.2282122-1-pulehui@huaweicloud.com>
References: <20240123103241.2282122-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHaQyfla9ldy79Bg--.53064S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8Zry7tr43Ar1rXF4ruFg_yoWrWF4kpF
	s3Gw1ak3ykXr15ta4kJr4UZF1ay3ykW3sxGr9xG3yxCFZ8Xr98GFyrKrWYvFWFkryj9r18
	AF4qvFn8u3WUJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUU
	UUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We used bpf_prog_pack to aggregate bpf programs into huge page to
relieve the iTLB pressure on the system. We can apply it to bpf
trampoline, as Song had been implemented it in core and x86 [0]. This
patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
and Puranjay have done a lot of work for bpf_prog_pack on RV64,
implementing this function will be easy. But one thing to mention is
that emit_call in RV64 will generate the maximum number of instructions
during dry run, but during real patching it may be optimized to 1
instruction due to distance. This is no problem as it does not overflow
the allocated RO image.

Link: https://lore.kernel.org/all/20231206224054.492250-1-song@kernel.org [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 59 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5c4e0ac389d0..903f724cd785 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -961,7 +961,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
 		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
-		im->ip_after_call = ctx->insns + ctx->ninsns;
+		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
 		emit(rv_nop(), ctx);
@@ -982,7 +982,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->insns + ctx->ninsns;
+		im->ip_epilogue = ctx->ro_insns + ctx->ninsns;
 		emit_imm(RV_REG_A0, (const s64)im, ctx);
 		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
 		if (ret)
@@ -1044,31 +1044,60 @@ int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_m
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
+void arch_protect_bpf_trampoline(void *image, unsigned int size)
+{
+}
+
+void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
+{
+}
+
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
+				void *ro_image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
 	int ret;
+	void *image, *tmp;
 	struct rv_jit_context ctx;
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
-		return ret;
+		goto out;
 
-	bpf_flush_icache(ctx.insns, ctx.insns + ctx.ninsns);
+	if (WARN_ON(size < ninsns_rvoff(ctx.ninsns))) {
+		ret = -E2BIG;
+		goto out;
+	}
 
-	return ninsns_rvoff(ret);
+	tmp = bpf_arch_text_copy(ro_image, image, size);
+	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		goto out;
+	}
+
+	bpf_flush_icache(ro_image, ro_image + size);
+out:
+	kvfree(image);
+	return ret < 0 ? ret : size;
 }
 
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
-- 
2.34.1


