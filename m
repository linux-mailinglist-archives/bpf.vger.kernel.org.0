Return-Path: <bpf+bounces-16447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB29A80135A
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2041C212E5
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6BB4D5B3;
	Fri,  1 Dec 2023 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is/pl4ds"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D313D980
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 19:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89245C433C7;
	Fri,  1 Dec 2023 19:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701457663;
	bh=EM7HTbzw0pmNhI8+B8k0Q5TYTzioW+/rAe7ui/sa3D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=is/pl4dskqmAYprRj07iG8+HB7S58XurMvzAZBlBf4wjgZEYyHS+JkxavSjqdd8JZ
	 ULXiSdigpoVLN4WMxvTLreTQ5evnxRunlZ3F48c4K9vk4RkG8lbW3PZqe/11Q4tubv
	 WzWtl8UYNeaXsO5SuN/9SZX0PWZRqn9FfEu1dEPSZRYacviifN1MadMs1cBg3t/fFD
	 UM/2ZgTzHT8ohrMvFQ1hyOKptgzDkhu6uA4yPAsaIwIsXp8W+7ROd3Op6c/bQxIW+b
	 g67SObrzUQG5fNPsR3rCWbOelzBIBHoSdWWM5sVe6E+a0fLu/oo+w9E5Q0dZjDt+mn
	 K/COgqraxFriQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v6 bpf-next 6/7] bpf: Use arch_bpf_trampoline_size
Date: Fri,  1 Dec 2023 11:06:53 -0800
Message-Id: <20231201190654.1233153-7-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201190654.1233153-1-song@kernel.org>
References: <20231201190654.1233153-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of blindly allocating PAGE_SIZE for each trampoline, check the size
of the trampoline with arch_bpf_trampoline_size(). This size is saved in
bpf_tramp_image->size, and used for modmem charge/uncharge. The fallback
arch_alloc_bpf_trampoline() still allocates a whole page because we need to
use set_memory_* to protect the memory.

struct_ops trampoline still uses a whole page for multiple trampolines.

With this size check at caller (regular trampoline and struct_ops
trampoline), remove arch_bpf_trampoline_size() from
arch_prepare_bpf_trampoline() in archs.

Also, update bpf_image_ksym_add() to handle symbol of different sizes.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com> # on riscv
---
 arch/arm64/net/bpf_jit_comp.c   |  7 -----
 arch/riscv/net/bpf_jit_comp64.c |  7 -----
 include/linux/bpf.h             |  3 +-
 kernel/bpf/bpf_struct_ops.c     |  7 +++++
 kernel/bpf/dispatcher.c         |  2 +-
 kernel/bpf/trampoline.c         | 55 ++++++++++++++++++++-------------
 6 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6671253b7ed..8955da5c47cf 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2079,13 +2079,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
-	if (ret < 0)
-		return ret;
-
-	if (ret > ((long)image_end - (long)image))
-		return -EFBIG;
-
 	jit_fill_hole(image, (unsigned int)(image_end - image));
 	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 35747fafde57..58dc64dd94a8 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1052,13 +1052,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	int ret;
 	struct rv_jit_context ctx;
 
-	ret = arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);
-	if (ret < 0)
-		return ret;
-
-	if (ret > (long)image_end - (long)image)
-		return -EFBIG;
-
 	ctx.ninsns = 0;
 	/*
 	 * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to write the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 93f6bc382f8e..5a6b101bea0c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1126,6 +1126,7 @@ enum bpf_tramp_prog_type {
 
 struct bpf_tramp_image {
 	void *image;
+	int size;
 	struct bpf_ksym ksym;
 	struct percpu_ref pcref;
 	void *ip_after_call;
@@ -1310,7 +1311,7 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 				struct bpf_prog *to);
 /* Called only from JIT-enabled code, so there's no need for stubs. */
-void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym);
+void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym);
 void bpf_image_ksym_del(struct bpf_ksym *ksym);
 void bpf_ksym_add(struct bpf_ksym *ksym);
 void bpf_ksym_del(struct bpf_ksym *ksym);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e9e95879bce2..4d53c53fc5aa 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -355,6 +355,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 				      void *image, void *image_end)
 {
 	u32 flags;
+	int size;
 
 	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
 	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
@@ -362,6 +363,12 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	 * and it must be used alone.
 	 */
 	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
+
+	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	if (size < 0)
+		return size;
+	if (size > (unsigned long)image_end - (unsigned long)image)
+		return -E2BIG;
 	return arch_prepare_bpf_trampoline(NULL, image, image_end,
 					   model, flags, tlinks, NULL);
 }
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index 56760fc10e78..70fb82bf1637 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -154,7 +154,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 			d->image = NULL;
 			goto out;
 		}
-		bpf_image_ksym_add(d->image, &d->ksym);
+		bpf_image_ksym_add(d->image, PAGE_SIZE, &d->ksym);
 	}
 
 	prev_num_progs = d->num_progs;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b553cbd89e55..d382f5ebe06c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -115,10 +115,10 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
-void bpf_image_ksym_add(void *data, struct bpf_ksym *ksym)
+void bpf_image_ksym_add(void *data, unsigned int size, struct bpf_ksym *ksym)
 {
 	ksym->start = (unsigned long) data;
-	ksym->end = ksym->start + PAGE_SIZE;
+	ksym->end = ksym->start + size;
 	bpf_ksym_add(ksym);
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF, ksym->start,
 			   PAGE_SIZE, false, ksym->name);
@@ -254,8 +254,8 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
-	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
-	bpf_jit_uncharge_modmem(PAGE_SIZE);
+	arch_free_bpf_trampoline(im->image, im->size);
+	bpf_jit_uncharge_modmem(im->size);
 	percpu_ref_exit(&im->pcref);
 	kfree_rcu(im, rcu);
 }
@@ -349,7 +349,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
+static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
@@ -360,12 +360,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 	if (!im)
 		goto out;
 
-	err = bpf_jit_charge_modmem(PAGE_SIZE);
+	err = bpf_jit_charge_modmem(size);
 	if (err)
 		goto out_free_im;
+	im->size = size;
 
 	err = -ENOMEM;
-	im->image = image = arch_alloc_bpf_trampoline(PAGE_SIZE);
+	im->image = image = arch_alloc_bpf_trampoline(size);
 	if (!image)
 		goto out_uncharge;
 
@@ -376,13 +377,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 	ksym = &im->ksym;
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
 	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
-	bpf_image_ksym_add(image, ksym);
+	bpf_image_ksym_add(image, size, ksym);
 	return im;
 
 out_free_image:
-	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
+	arch_free_bpf_trampoline(im->image, im->size);
 out_uncharge:
-	bpf_jit_uncharge_modmem(PAGE_SIZE);
+	bpf_jit_uncharge_modmem(size);
 out_free_im:
 	kfree(im);
 out:
@@ -395,7 +396,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	struct bpf_tramp_links *tlinks;
 	u32 orig_flags = tr->flags;
 	bool ip_arg = false;
-	int err, total;
+	int err, total, size;
 
 	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
 	if (IS_ERR(tlinks))
@@ -408,12 +409,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key);
-	if (IS_ERR(im)) {
-		err = PTR_ERR(im);
-		goto out;
-	}
-
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
@@ -437,13 +432,31 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
 #endif
 
-	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
+	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
+					tlinks, tr->func.addr);
+	if (size < 0) {
+		err = size;
+		goto out;
+	}
+
+	if (size > PAGE_SIZE) {
+		err = -E2BIG;
+		goto out;
+	}
+
+	im = bpf_tramp_image_alloc(tr->key, size);
+	if (IS_ERR(im)) {
+		err = PTR_ERR(im);
+		goto out;
+	}
+
+	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
 		goto out_free;
 
-	arch_protect_bpf_trampoline(im->image, PAGE_SIZE);
+	arch_protect_bpf_trampoline(im->image, im->size);
 
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
@@ -463,8 +476,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->fops->func = NULL;
 		tr->fops->trampoline = 0;
 
-		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		arch_unprotect_bpf_trampoline(im->image, PAGE_SIZE);
+		/* free im memory and reallocate later */
+		bpf_tramp_image_free(im);
 		goto again;
 	}
 #endif
-- 
2.34.1


