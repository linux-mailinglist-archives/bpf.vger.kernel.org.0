Return-Path: <bpf+bounces-16448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76980135B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8747B213E6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42F4D5B3;
	Fri,  1 Dec 2023 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4XNeyYE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C73D980
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 19:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9DAC433C7;
	Fri,  1 Dec 2023 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701457668;
	bh=bBlrf1SaGEuUs9M1bJFi0z6i+DdHeGroMBBsgutEsFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4XNeyYEoDXM+renUtyugF0CDBinAmSHLO5c20mv1dZv+EHDTCz7vc0WQpsyYHQ52
	 LzTSeTvmMZuzQJq2+bmKfO++A0CTqtV2/gQm0ON00srnXq7H0wK2xO97OGL02cAQvb
	 uI65plrdbeT3bJMlzIcRYZAXKeW9lO4cNcnm60o7wafOMATuktwuT57Nv7axdDSSDR
	 nesusF3aLo6uuYf94gXVVuPV9bMA66ErlW6gS/+Zlv4Cksrs7E4kMxzHJAhe9gv4i6
	 6QruIsp7wJOhL5A7HCpg0eHHvJ/WQQ4t2tK8Lu/yXodGgRwg7Djp72A+oBzD9Smic6
	 /Ob75ZYfAe56A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v6 bpf-next 7/7] x86, bpf: Use bpf_prog_pack for bpf trampoline
Date: Fri,  1 Dec 2023 11:06:54 -0800
Message-Id: <20231201190654.1233153-8-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201190654.1233153-1-song@kernel.org>
References: <20231201190654.1233153-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three major changes here:

1. Add arch_[alloc|free]_bpf_trampoline based on bpf_prog_pack;
2. Let arch_prepare_bpf_trampoline handle ROX input image, this requires
   arch_prepare_bpf_trampoline allocating a temporary RW buffer;
3. Update __arch_prepare_bpf_trampoline() to handle a RW buffer (rw_image)
   and a ROX buffer (image). This part is similar to the image/rw_image
   logic in bpf_int_jit_compile().

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 95 +++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 561530ef2cdb..e7c5309328bb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2198,7 +2198,8 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   int run_ctx_off, bool save_ret)
+			   int run_ctx_off, bool save_ret,
+			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
@@ -2226,7 +2227,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	else
 		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
+	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
@@ -2250,7 +2251,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_rsb_call(&prog, p->bpf_func, prog))
+	if (emit_rsb_call(&prog, p->bpf_func, image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
 
 	/*
@@ -2277,7 +2278,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
 	else
 		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
+	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
 
 	*pprog = prog;
@@ -2312,14 +2313,15 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret)
+		      int run_ctx_off, bool save_ret,
+		      void *image, void *rw_image)
 {
 	int i;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    run_ctx_off, save_ret))
+				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
 	*pprog = prog;
@@ -2328,7 +2330,8 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      int run_ctx_off, u8 **branches)
+			      int run_ctx_off, u8 **branches,
+			      void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
 	int i;
@@ -2339,7 +2342,8 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true))
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
+				    image, rw_image))
 			return -EINVAL;
 
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -2422,7 +2426,8 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
  * add rsp, 8                      // skip eth_type_trans's frame
  * ret                             // return to its caller
  */
-static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
+static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_image,
+					 void *rw_image_end, void *image,
 					 const struct btf_func_model *m, u32 flags,
 					 struct bpf_tramp_links *tlinks,
 					 void *func_addr)
@@ -2521,7 +2526,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 		orig_call += X86_PATCH_SIZE;
 	}
 
-	prog = image;
+	prog = rw_image;
 
 	EMIT_ENDBR();
 	/*
@@ -2563,7 +2568,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_enter,
+				  image + (prog - (u8 *)rw_image))) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2571,7 +2577,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 
 	if (fentry->nr_links)
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
 			return -EINVAL;
 
 	if (fmod_ret->nr_links) {
@@ -2581,7 +2587,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 			return -ENOMEM;
 
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       run_ctx_off, branches)) {
+				       run_ctx_off, branches, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2602,14 +2608,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 			EMIT2(0xff, 0xd3); /* call *rbx */
 		} else {
 			/* call original function */
-			if (emit_rsb_call(&prog, orig_call, prog)) {
+			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
 				ret = -EINVAL;
 				goto cleanup;
 			}
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-		im->ip_after_call = prog;
+		im->ip_after_call = image + (prog - (u8 *)rw_image);
 		memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 		prog += X86_PATCH_SIZE;
 	}
@@ -2625,12 +2631,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 		 * aligned address of do_fexit.
 		 */
 		for (i = 0; i < fmod_ret->nr_links; i++)
-			emit_cond_near_jump(&branches[i], prog, branches[i],
-					    X86_JNE);
+			emit_cond_near_jump(&branches[i], image + (prog - (u8 *)rw_image),
+					    image + (branches[i] - (u8 *)rw_image), X86_JNE);
 	}
 
 	if (fexit->nr_links)
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
+			       false, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2643,10 +2650,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 	 * restored to R0.
 	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = prog;
+		im->ip_epilogue = image + (prog - (u8 *)rw_image);
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_exit, image + (prog - (u8 *)rw_image))) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2665,25 +2672,61 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip our return address and return to parent */
 		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
-	emit_return(&prog, prog);
+	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
+	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
 		goto cleanup;
 	}
-	ret = prog - (u8 *)image + BPF_INSN_SAFETY;
+	ret = prog - (u8 *)rw_image + BPF_INSN_SAFETY;
 
 cleanup:
 	kfree(branches);
 	return ret;
 }
 
+void *arch_alloc_bpf_trampoline(unsigned int size)
+{
+	return bpf_prog_pack_alloc(size, jit_fill_hole);
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
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	return __arch_prepare_bpf_trampoline(im, image, image_end, m, flags, tlinks, func_addr);
+	void *rw_image, *tmp;
+	int ret;
+	u32 size = image_end - image;
+
+	rw_image = bpf_jit_alloc_exec(size);
+	if (!rw_image)
+		return -ENOMEM;
+
+	ret = __arch_prepare_bpf_trampoline(im, rw_image, rw_image + size, image, m,
+					    flags, tlinks, func_addr);
+	if (ret < 0)
+		goto out;
+
+	tmp = bpf_arch_text_copy(image, rw_image, size);
+	if (IS_ERR(tmp))
+		ret = PTR_ERR(tmp);
+out:
+	bpf_jit_free_exec(rw_image);
+	return ret;
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
@@ -2701,8 +2744,8 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	if (!image)
 		return -ENOMEM;
 
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, m, flags,
-					    tlinks, func_addr);
+	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
+					    m, flags, tlinks, func_addr);
 	bpf_jit_free_exec(image);
 	return ret;
 }
-- 
2.34.1


