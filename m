Return-Path: <bpf+bounces-13179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D297D5E73
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D6D281C14
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4A3995A;
	Tue, 24 Oct 2023 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtEAmdhA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3D2D633
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 22:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C0C433C8;
	Tue, 24 Oct 2023 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187607;
	bh=TbILHzrMfIk5fui5vD+5CAbfY7IbdhXJrqhS63pN7HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtEAmdhAcMz0pCtPZdNxv5JkMtMhH/GAuxWJoBKZWHJm0oYxODMHBGGRQCvOxkQTT
	 0qdIpThZaOa5AOjvMi5fJ/4sLoYIWmv1mablJY2r2ljDki984ArELpFlI7xl2N3Iz6
	 EhFIqQmbqYVG4YBREAxeKcBYpmpWCjPToowXEk9MF17IxjUSwskIU+1Zc85uJpNDXp
	 nidFsDr9Qv5Vv/tsmNznJ6fzca/ANm/rtCGh2Ihfir8lEtlpFrJa7+06RUSdfZZdyt
	 IAxnK7sjWUSYwJgZIUqCIRVkguVPqpj772O0MhFi084FJ2acShj2gdd91BwIpUjDmW
	 3ilXPn+Q61Enw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	bjorn@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com,
	iii@linux.ibm.com,
	jolsa@kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 2/7] bpf: Adjust argument names of arch_prepare_bpf_trampoline()
Date: Tue, 24 Oct 2023 15:45:56 -0700
Message-Id: <20231024224601.2292927-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024224601.2292927-1-song@kernel.org>
References: <20231024224601.2292927-1-song@kernel.org>
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
index b4825d3cdb29..c03e8e071006 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1079,10 +1079,10 @@ struct bpf_tramp_run_ctx;
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


