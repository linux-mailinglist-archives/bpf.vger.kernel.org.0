Return-Path: <bpf+bounces-20078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E04E838C19
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 11:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8294B1C22A29
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD05D758;
	Tue, 23 Jan 2024 10:32:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB43A5D726;
	Tue, 23 Jan 2024 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005935; cv=none; b=NdilOVfF3lTrvmvhQ8j/WOzReZa7X2n7uUOV1C8ssxpGuOxz3iZ22nyj+CU1NZxCK7Luj5keTrLuKouAsAWCHu6VFgj7LtCCni5cmKBq/QZ0Z8b9mW4FtniZRlUjJW5auiDCJgdY4l3nL5JjCodUYyxo8fpoDDf3wcX9iu2n4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005935; c=relaxed/simple;
	bh=G9In0vM/aqjou2/dOIo7agePKxZp/ZaDwT7QY0FEzyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRv8qw/kCrSWp7ylqD3a+7IYZeZgKWAf3duIp0kVYu3cZYcvdoe2R+pksDDKorybkQDCQgj3Nxq1sovQWg0EXKInE+q+OnxRPTp0zLYEkfWuPi43po1FR9JOX7MDVUbZ/r0H0XBOZhBK7JegMa46GKpc4e+8Wbjx8J5CMCOkXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3LB1WHSz4f3jZG;
	Tue, 23 Jan 2024 18:32:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 84CDC1A0171;
	Tue, 23 Jan 2024 18:32:04 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgBHaQyfla9ldy79Bg--.53064S4;
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
Subject: [PATCH bpf-next 2/3] bpf: Keep im address consistent between dry run and real patching
Date: Tue, 23 Jan 2024 10:32:40 +0000
Message-Id: <20240123103241.2282122-3-pulehui@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHaQyfla9ldy79Bg--.53064S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww15ZrWDKr4DGFW3tw4rAFb_yoWftw1kpF
	1UAF13AF48XrWDXa4kJw48ZF4ava4kX3y7CFWUGrWFka90qr95JF1rK34SvrWFyrZ09F13
	AFs09rn0yF18u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In __arch_prepare_bpf_trampoline, we emit instructions to store the
address of im to register and then pass it to __bpf_tramp_enter and
__bpf_tramp_exit functions. Currently we use fake im in
arch_bpf_trampoline_size for the dry run, and then allocate new im for
the real patching. This is fine for architectures that use fixed
instructions to generate addresses. However, for architectures that use
dynamic instructions to generate addresses, this may make the front and
rear images inconsistent, leading to patching overflow. We can extract
the im allocation ahead of the dry run and pass the allocated im to
arch_bpf_trampoline_size, so that we can ensure that im is consistent in
dry run and real patching.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c   |  7 +++---
 arch/riscv/net/bpf_jit_comp64.c |  7 +++---
 arch/s390/net/bpf_jit_comp.c    |  7 +++---
 arch/x86/net/bpf_jit_comp.c     |  7 +++---
 include/linux/bpf.h             |  4 +--
 kernel/bpf/bpf_struct_ops.c     |  2 +-
 kernel/bpf/trampoline.c         | 43 ++++++++++++++++-----------------
 7 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8955da5c47cf..fad760f14a96 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2041,14 +2041,13 @@ static int btf_func_model_nregs(const struct btf_func_model *m)
 	return nregs;
 }
 
-int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr)
+int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+			     u32 flags, struct bpf_tramp_links *tlinks, void *func_addr)
 {
 	struct jit_ctx ctx = {
 		.image = NULL,
 		.idx = 0,
 	};
-	struct bpf_tramp_image im;
 	int nregs, ret;
 
 	nregs = btf_func_model_nregs(m);
@@ -2056,7 +2055,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	if (nregs > 8)
 		return -ENOTSUPP;
 
-	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, nregs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 719a97e7edb2..5c4e0ac389d0 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1030,17 +1030,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	return ret;
 }
 
-int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr)
+int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+			     u32 flags, struct bpf_tramp_links *tlinks, void *func_addr)
 {
-	struct bpf_tramp_image im;
 	struct rv_jit_context ctx;
 	int ret;
 
 	ctx.ninsns = 0;
 	ctx.insns = NULL;
 	ctx.ro_insns = NULL;
-	ret = __arch_prepare_bpf_trampoline(&im, m, tlinks, func_addr, flags, &ctx);
+	ret = __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr, flags, &ctx);
 
 	return ret < 0 ? ret : ninsns_rvoff(ctx.ninsns);
 }
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b418333bb086..adf289eee6cd 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2638,16 +2638,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	return 0;
 }
 
-int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *orig_call)
+int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+			     u32 flags, struct bpf_tramp_links *tlinks, void *orig_call)
 {
-	struct bpf_tramp_image im;
 	struct bpf_tramp_jit tjit;
 	int ret;
 
 	memset(&tjit, 0, sizeof(tjit));
 
-	ret = __arch_prepare_bpf_trampoline(&im, &tjit, m, flags,
+	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
 					    tlinks, orig_call);
 
 	return ret < 0 ? ret : tjit.common.prg;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..fdef44913643 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2817,10 +2817,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	return ret;
 }
 
-int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr)
+int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+			     u32 flags, struct bpf_tramp_links *tlinks, void *func_addr)
 {
-	struct bpf_tramp_image im;
 	void *image;
 	int ret;
 
@@ -2835,7 +2834,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	if (!image)
 		return -ENOMEM;
 
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
+	ret = __arch_prepare_bpf_trampoline(im, image, image + PAGE_SIZE, image,
 					    m, flags, tlinks, func_addr);
 	bpf_jit_free_exec(image);
 	return ret;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 377857b232c6..d3a486e12b17 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1114,8 +1114,8 @@ void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
 void arch_protect_bpf_trampoline(void *image, unsigned int size);
 void arch_unprotect_bpf_trampoline(void *image, unsigned int size);
-int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr);
+int arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+			     u32 flags, struct bpf_tramp_links *tlinks, void *func_addr);
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e2e1bf3c69a3..8b3c6cc7ea94 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -363,7 +363,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	if (model->ret_size > 0)
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
-	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	size = arch_bpf_trampoline_size(NULL, model, flags, tlinks, NULL);
 	if (size < 0)
 		return size;
 	if (size > (unsigned long)image_end - (unsigned long)image)
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d382f5ebe06c..25621d97f3ca 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -349,20 +349,15 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
+static int bpf_tramp_image_alloc(struct bpf_tramp_image *im, u64 key, int size)
 {
-	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
 	void *image;
-	int err = -ENOMEM;
-
-	im = kzalloc(sizeof(*im), GFP_KERNEL);
-	if (!im)
-		goto out;
+	int err;
 
 	err = bpf_jit_charge_modmem(size);
 	if (err)
-		goto out_free_im;
+		goto out;
 	im->size = size;
 
 	err = -ENOMEM;
@@ -378,16 +373,14 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	INIT_LIST_HEAD_RCU(&ksym->lnode);
 	snprintf(ksym->name, KSYM_NAME_LEN, "bpf_trampoline_%llu", key);
 	bpf_image_ksym_add(image, size, ksym);
-	return im;
+	return 0;
 
 out_free_image:
 	arch_free_bpf_trampoline(im->image, im->size);
 out_uncharge:
 	bpf_jit_uncharge_modmem(size);
-out_free_im:
-	kfree(im);
 out:
-	return ERR_PTR(err);
+	return err;
 }
 
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
@@ -432,23 +425,27 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
 #endif
 
-	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
+	im = kzalloc(sizeof(*im), GFP_KERNEL);
+	if (!im) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	size = arch_bpf_trampoline_size(im, &tr->func.model, tr->flags,
 					tlinks, tr->func.addr);
 	if (size < 0) {
 		err = size;
-		goto out;
+		goto out_free_im;
 	}
 
 	if (size > PAGE_SIZE) {
 		err = -E2BIG;
-		goto out;
+		goto out_free_im;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, size);
-	if (IS_ERR(im)) {
-		err = PTR_ERR(im);
-		goto out;
-	}
+	err = bpf_tramp_image_alloc(im, tr->key, size);
+	if (err < 0)
+		goto out_free_im;
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tlinks,
@@ -496,6 +493,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 out_free:
 	bpf_tramp_image_free(im);
+out_free_im:
+	kfree_rcu(im, rcu);
 	goto out;
 }
 
@@ -1085,8 +1084,8 @@ void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
 	set_memory_rw((long)image, 1);
 }
 
-int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-				    struct bpf_tramp_links *tlinks, void *func_addr)
+int __weak arch_bpf_trampoline_size(struct bpf_tramp_image *im, const struct btf_func_model *m,
+				    u32 flags, struct bpf_tramp_links *tlinks, void *func_addr)
 {
 	return -ENOTSUPP;
 }
-- 
2.34.1


