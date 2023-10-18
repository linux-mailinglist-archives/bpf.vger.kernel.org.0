Return-Path: <bpf+bounces-12592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC657CE5D9
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C322F1C20D80
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E33FE50;
	Wed, 18 Oct 2023 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/ykYnRa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5AC14F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02575C433CA;
	Wed, 18 Oct 2023 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652287;
	bh=9jbmDJ4wjer9o4yKuvWWtDbhNe5WKETyqDdGZegZXXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/ykYnRaV7GgqSlvMa3HT6RX3XBnB4wxTqLaFXM6o9DR6gJaRKr21Vqn0/V/xJyvZ
	 g/FSlqccDPBwVR3lpGRnRAA/x7G/Qi8n7qJry2pn1U1/OVWc/jSPJLxH8raLuUxNZw
	 mUiLLrPOYw9r2rBmg4g1Xh1GMl0zAUKPloFq+qje8jqeGc5JaWsbTEAfYriMMdc4ho
	 CYL+OEKRukoEIk48c57V9jndjGWcwV82xuyDejTCqC+rdUVbezOtDFicky7IwmQKZo
	 JxeBzmBVucbvIqq1V+1Law64qkNhdc+UO0adILFGG60i7F1f2MM3hGBZ+eP+mCdSG6
	 6bN+GiNHDeZMg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
Date: Wed, 18 Oct 2023 11:03:34 -0700
Message-Id: <20231018180336.1696131-6-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018180336.1696131-1-song@kernel.org>
References: <20231018180336.1696131-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helper will be used to calculate the size of the trampoline before
allocating the memory.

arch_prepare_bpf_trampoline() for arm64 and riscv64 can use
arch_bpf_trampoline_size() to check the trampoline fits in the image.

OTOH, arch_prepare_bpf_trampoline() for s390 has to call the JIT process
twice, so it cannot use arch_bpf_trampoline_size().

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
---
 arch/arm64/net/bpf_jit_comp.c   | 56 ++++++++++++++++++++++++---------
 arch/riscv/net/bpf_jit_comp64.c | 22 ++++++++++---
 arch/s390/net/bpf_jit_comp.c    | 56 ++++++++++++++++++++-------------
 arch/x86/net/bpf_jit_comp.c     | 37 +++++++++++++++++++---
 include/linux/bpf.h             |  2 ++
 kernel/bpf/trampoline.c         |  6 ++++
 6 files changed, 133 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d81b886ea4df..a6671253b7ed 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2026,18 +2026,10 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	return ctx->idx;
 }
 
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
-				void *image_end, const struct btf_func_model *m,
-				u32 flags, struct bpf_tramp_links *tlinks,
-				void *func_addr)
+static int btf_func_model_nregs(const struct btf_func_model *m)
 {
-	int i, ret;
 	int nregs = m->nr_args;
-	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
-	struct jit_ctx ctx = {
-		.image = NULL,
-		.idx = 0,
-	};
+	int i;
 
 	/* extra registers needed for struct argument */
 	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
@@ -2046,19 +2038,53 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 			nregs += (m->arg_size[i] + 7) / 8 - 1;
 	}
 
+	return nregs;
+}
+
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct jit_ctx ctx = {
+		.image = NULL,
+		.idx = 0,
+	};
+	struct bpf_tramp_image im;
+	int nregs, ret;
+
+	nregs = btf_func_model_nregs(m);
 	/* the first 8 registers are used for arguments */
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
+	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
 	if (ret < 0)
 		return ret;
 
-	if (ret > max_insns)
-		return -EFBIG;
+	return ret < 0 ? ret : ret * AARCH64_INSN_SIZE;
+}
 
-	ctx.image = image;
-	ctx.idx = 0;
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
+				void *image_end, const struct btf_func_model *m,
+				u32 flags, struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	int ret, nregs;
+	struct jit_ctx ctx = {
+		.image = image,
+		.idx = 0,
+	};
+
+	nregs = btf_func_model_nregs(m);
+	/* the first 8 registers are used for arguments */
+	if (nregs > 8)
+		return -ENOTSUPP;
+
+	ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
+	if (ret < 0)
+		return ret;
+
+	if (ret > ((long)image_end - (long)image))
+		return -EFBIG;
 
 	jit_fill_hole(image, (unsigned int)(image_end - image));
 	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8581693e62d3..35747fafde57 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1029,6 +1029,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	return ret;
 }
 
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct bpf_tramp_image im;
+	struct rv_jit_context ctx;
+	int ret;
+
+	ctx.ninsns = 0;
+	ctx.insns = NULL;
+	ctx.ro_insns = NULL;
+	ret = __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, flags, &ctx);
+
+	return ret < 0 ? ret : ninsns_rvoff(ctx.ninsns);
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
@@ -1037,14 +1052,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	int ret;
 	struct rv_jit_context ctx;
 
-	ctx.ninsns = 0;
-	ctx.insns = NULL;
-	ctx.ro_insns = NULL;
-	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
+	ret = arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);
 	if (ret < 0)
 		return ret;
 
-	if (ninsns_rvoff(ret) > (long)image_end - (long)image)
+	if (ret > (long)image_end - (long)image)
 		return -EFBIG;
 
 	ctx.ninsns = 0;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bf06b7283f0c..cc129617480a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2637,6 +2637,21 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	return 0;
 }
 
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *orig_call)
+{
+	struct bpf_tramp_image im;
+	struct bpf_tramp_jit tjit;
+	int ret;
+
+	memset(&tjit, 0, sizeof(tjit));
+
+	ret = __arch_prepare_bpf_trampoline(&im, &tjit, m, flags,
+					    tlinks, orig_call);
+
+	return ret < 0 ? ret : tjit.common.prg;
+}
+
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
@@ -2644,30 +2659,27 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 {
 	struct bpf_tramp_jit tjit;
 	int ret;
-	int i;
 
-	for (i = 0; i < 2; i++) {
-		if (i == 0) {
-			/* Compute offsets, check whether the code fits. */
-			memset(&tjit, 0, sizeof(tjit));
-		} else {
-			/* Generate the code. */
-			tjit.common.prg = 0;
-			tjit.common.prg_buf = image;
-		}
-		ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
-						    tlinks, func_addr);
-		if (ret < 0)
-			return ret;
-		if (tjit.common.prg > (char *)image_end - (char *)image)
-			/*
-			 * Use the same error code as for exceeding
-			 * BPF_MAX_TRAMP_LINKS.
-			 */
-			return -E2BIG;
-	}
+	/* Compute offsets, check whether the code fits. */
+	memset(&tjit, 0, sizeof(tjit));
+	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+					    tlinks, func_addr);
+
+	if (ret < 0)
+		return ret;
+	if (tjit.common.prg > (char *)image_end - (char *)image)
+		/*
+		 * Use the same error code as for exceeding
+		 * BPF_MAX_TRAMP_LINKS.
+		 */
+		return -E2BIG;
+
+	tjit.common.prg = 0;
+	tjit.common.prg_buf = image;
+	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
+					    tlinks, func_addr);
 
-	return tjit.common.prg;
+	return ret < 0 ? ret : tjit.common.prg;
 }
 
 bool bpf_jit_supports_subprog_tailcalls(void)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5f7528cac344..561530ef2cdb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2422,10 +2422,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
  * add rsp, 8                      // skip eth_type_trans's frame
  * ret                             // return to its caller
  */
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
-				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
-				void *func_addr)
+static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
+					 const struct btf_func_model *m, u32 flags,
+					 struct bpf_tramp_links *tlinks,
+					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
 	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
@@ -2678,6 +2678,35 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	return ret;
 }
 
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
+				const struct btf_func_model *m, u32 flags,
+				struct bpf_tramp_links *tlinks,
+				void *func_addr)
+{
+	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tlinks, func_addr);
+}
+
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	struct bpf_tramp_image im;
+	void *image;
+	int ret;
+
+	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
+	 * This will NOT cause fragmentation in direct map, as we do not
+	 * call set_memory_*() on this buffer.
+	 */
+	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	if (!image)
+		return -ENOMEM;
+
+	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
+					    tlinks, func_addr);
+	bpf_jit_free_exec(image);
+	return ret;
+}
+
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
 {
 	u8 *jg_reloc, *prog = *pprog;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d392ad54304..2ed65b764aab 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1087,6 +1087,8 @@ void *arch_alloc_bpf_trampoline(int size);
 void arch_free_bpf_trampoline(void *image, int size);
 void arch_protect_bpf_trampoline(void *image, int size);
 void arch_unprotect_bpf_trampoline(void *image, int size);
+int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+			     struct bpf_tramp_links *tlinks, void *func_addr);
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5509bdf98067..285c5b7c1ea4 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1070,6 +1070,12 @@ void __weak arch_unprotect_bpf_trampoline(void *image, int size)
 	set_memory_rw((long)image, 1);
 }
 
+int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
+				    struct bpf_tramp_links *tlinks, void *func_addr)
+{
+	return -ENOTSUPP;
+}
+
 static int __init init_trampolines(void)
 {
 	int i;
-- 
2.34.1


