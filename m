Return-Path: <bpf+bounces-12590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1727CE5D6
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D9281C61
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40A3FE51;
	Wed, 18 Oct 2023 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6ASyag+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED1C14F
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F435C433C8;
	Wed, 18 Oct 2023 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697652282;
	bh=lHz9TZu3VuU5TaR89LClPTIDfFVATR/LTLVRDwqRnTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6ASyag+hsY8l6e/ug5IlcXK8U7jSaC7SGlD4pVWP9rvzKkp8a9BesK3oCuQODKMO
	 KWRnz3mqFUpHTVuQlCGTOiOYBo11957klBHxiLtCVp8C/3KlAoxSJS4JHZ4x9fi2h3
	 +8/SReFaTPB7oirSHtUCXB0MbwAVXG6yCcZ0+D/g28g8k2x9AMkru+L5QL9FsbKXG1
	 M1HZr50+2snAD9Wxh8n0RlCT1YPuzIYaC5+A55MU6r7OF20Hs7F3Et5ztG5lZFnaaX
	 QzBIGrTm3BEGt+j9n/T+6W+47FWmkCvoQbfKpFdLAcYfBDtlDfzn+yI/oM25f2ilVE
	 1sUJr3dMQEAuA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 bpf-next 3/7] bpf: Add helpers for trampoline image management
Date: Wed, 18 Oct 2023 11:03:32 -0700
Message-Id: <20231018180336.1696131-4-song@kernel.org>
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

As BPF trampoline of different archs moves from bpf_jit_[alloc|free]_exec()
to bpf_prog_pack_[alloc|free](), we need to use different _alloc, _free for
different archs during the transition. Add the following helpers for this
transition:

void *arch_alloc_bpf_trampoline(int size);
void arch_free_bpf_trampoline(void *image, int size);
void arch_protect_bpf_trampoline(void *image, int size);
void arch_unprotect_bpf_trampoline(void *image, int size);

The fallback version of these helpers require size <= PAGE_SIZE, but they
are only called with size == PAGE_SIZE. They will be called with size <
PAGE_SIZE when arch_bpf_trampoline_size() helper is introduced later.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
---
 include/linux/bpf.h            |  5 ++++
 kernel/bpf/bpf_struct_ops.c    | 12 ++++------
 kernel/bpf/trampoline.c        | 44 ++++++++++++++++++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c |  7 +++---
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e1359753bc71..0d392ad54304 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1083,6 +1083,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr);
+void *arch_alloc_bpf_trampoline(int size);
+void arch_free_bpf_trampoline(void *image, int size);
+void arch_protect_bpf_trampoline(void *image, int size);
+void arch_unprotect_bpf_trampoline(void *image, int size);
+
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 start,
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db6176fb64dc..e9e95879bce2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -515,7 +515,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			if (err)
 				goto reset_unlock;
 		}
-		set_memory_rox((long)st_map->image, 1);
+		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -524,7 +524,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	set_memory_rox((long)st_map->image, 1);
+	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -547,8 +547,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	set_memory_nx((long)st_map->image, 1);
-	set_memory_rw((long)st_map->image, 1);
+	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
 
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
@@ -616,7 +615,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
 	if (st_map->image) {
-		bpf_jit_free_exec(st_map->image);
+		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
@@ -691,7 +690,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(ret);
 	}
 
-	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
+	st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!st_map->image) {
 		/* __bpf_struct_ops_map_free() uses st_map->image as flag
 		 * for "charged or not". In this case, we need to unchange
@@ -711,7 +710,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	}
 
 	mutex_init(&st_map->lock);
-	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
 
 	return map;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e114a1c7961e..5509bdf98067 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -254,7 +254,7 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
 	bpf_image_ksym_del(&im->ksym);
-	bpf_jit_free_exec(im->image);
+	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
 	percpu_ref_exit(&im->pcref);
 	kfree_rcu(im, rcu);
@@ -365,10 +365,9 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 		goto out_free_im;
 
 	err = -ENOMEM;
-	im->image = image = bpf_jit_alloc_exec(PAGE_SIZE);
+	im->image = image = arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!image)
 		goto out_uncharge;
-	set_vm_flush_reset_perms(image);
 
 	err = percpu_ref_init(&im->pcref, __bpf_tramp_image_release, 0, GFP_KERNEL);
 	if (err)
@@ -381,7 +380,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
 	return im;
 
 out_free_image:
-	bpf_jit_free_exec(im->image);
+	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
 out_uncharge:
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
 out_free_im:
@@ -444,7 +443,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out_free;
 
-	set_memory_rox((long)im->image, 1);
+	arch_protect_bpf_trampoline(im->image, PAGE_SIZE);
 
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
@@ -465,8 +464,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->fops->trampoline = 0;
 
 		/* reset im->image memory attr for arch_prepare_bpf_trampoline */
-		set_memory_nx((long)im->image, 1);
-		set_memory_rw((long)im->image, 1);
+		arch_unprotect_bpf_trampoline(im->image, PAGE_SIZE);
 		goto again;
 	}
 #endif
@@ -1040,6 +1038,38 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
 	return -ENOTSUPP;
 }
 
+void * __weak arch_alloc_bpf_trampoline(int size)
+{
+	void *image;
+
+	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);
+	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	if (image)
+		set_vm_flush_reset_perms(image);
+	return image;
+}
+
+void __weak arch_free_bpf_trampoline(void *image, int size)
+{
+	/* bpf_jit_free_exec doesn't need "size", but
+	 * bpf_prog_pack_free() needs it.
+	 */
+	bpf_jit_free_exec(image);
+}
+
+void __weak arch_protect_bpf_trampoline(void *image, int size)
+{
+	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);
+	set_memory_rox((long)image, 1);
+}
+
+void __weak arch_unprotect_bpf_trampoline(void *image, int size)
+{
+	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);
+	set_memory_nx((long)image, 1);
+	set_memory_rw((long)image, 1);
+}
+
 static int __init init_trampolines(void)
 {
 	int i;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 5918d1b32e19..2748f9d77b18 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -101,12 +101,11 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 	}
 
-	image = bpf_jit_alloc_exec(PAGE_SIZE);
+	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!image) {
 		err = -ENOMEM;
 		goto out;
 	}
-	set_vm_flush_reset_perms(image);
 
 	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
@@ -124,7 +123,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err < 0)
 		goto out;
 
-	set_memory_rox((long)image, 1);
+	arch_protect_bpf_trampoline(image, PAGE_SIZE);
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
@@ -134,7 +133,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		err = -EFAULT;
 out:
 	kfree(args);
-	bpf_jit_free_exec(image);
+	arch_free_bpf_trampoline(image, PAGE_SIZE);
 	if (link)
 		bpf_link_put(&link->link);
 	kfree(tlinks);
-- 
2.34.1


