Return-Path: <bpf+bounces-16443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334C801356
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E27928124F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1677A4D59D;
	Fri,  1 Dec 2023 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ve1d33"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F003D980
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1977FC433C8;
	Fri,  1 Dec 2023 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701457640;
	bh=Q40QRYjPQof0p04E8m+LvD3b6t3eZ0tMgw+7GYhOMQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3ve1d33enLT5gT9TuNzE4cyHp/dDRNqhzsCvCCK8kg35ugD47jxLBtjCypkRZll6
	 owaD+VEtAlPlD34m+qtEFSqct3HZmdPtTfADRP6OoroEhrELEDLRdij3XHL+NgAjkj
	 cThYBUq3k2ZopDqDI6/LKqpyRy7TrNPVAg80rh/tT9fTIKNqf/E5P/ygUHZAcSIMjv
	 1q4TVaV5jl6PhbEaWTR9Qf+K8yutmWdJHc8hV3iizvdOAvxdbQXL2SubaS8RF4QI9W
	 qFzDo93kb9qNPQLHAXqUW66aKjWXHmDkHZ1US4+UjWuK1+hpVizjoirwuS0tBqO0XC
	 lr6jrOMxTYHrw==
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
Subject: [PATCH v6 bpf-next 2/7] bpf: Adjust argument names of arch_prepare_bpf_trampoline()
Date: Fri,  1 Dec 2023 11:06:49 -0800
Message-Id: <20231201190654.1233153-3-song@kernel.org>
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

We are using "im" for "struct bpf_tramp_image" and "tr" for "struct
bpf_trampoline" in most of the code base. The only exception is the
prototype and fallback version of arch_prepare_bpf_trampoline(). Update
them to match the rest of the code base.

We mix "orig_call" and "func_addr" for the argument in different versions
of arch_prepare_bpf_trampoline(). s/orig_call/func_addr/g so they match.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 10 +++++-----
 include/linux/bpf.h           |  4 ++--
 kernel/bpf/trampoline.c       |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7d4af64e3982..d81b886ea4df 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1828,7 +1828,7 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
  *
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
-			      struct bpf_tramp_links *tlinks, void *orig_call,
+			      struct bpf_tramp_links *tlinks, void *func_addr,
 			      int nregs, u32 flags)
 {
 	int i;
@@ -1926,7 +1926,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* save ip address of the traced function */
-		emit_addr_mov_i64(A64_R(10), (const u64)orig_call, ctx);
+		emit_addr_mov_i64(A64_R(10), (const u64)func_addr, ctx);
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
 
@@ -2029,7 +2029,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
-				void *orig_call)
+				void *func_addr)
 {
 	int i, ret;
 	int nregs = m->nr_args;
@@ -2050,7 +2050,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 	if (ret < 0)
 		return ret;
 
@@ -2061,7 +2061,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	ctx.idx = 0;
 
 	jit_fill_hole(image, (unsigned int)(image_end - image));
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0)
 		ret = -EINVAL;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..2baa4a6f91d6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1083,10 +1083,10 @@ struct bpf_tramp_run_ctx;
  *      fexit = a set of program to run after original function
  */
 struct bpf_tramp_image;
-int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
+int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
-				void *orig_call);
+				void *func_addr);
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b..e114a1c7961e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1032,10 +1032,10 @@ bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog)
 }
 
 int __weak
-arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
+arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
 			    struct bpf_tramp_links *tlinks,
-			    void *orig_call)
+			    void *func_addr)
 {
 	return -ENOTSUPP;
 }
-- 
2.34.1


