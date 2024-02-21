Return-Path: <bpf+bounces-22403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAF85E02F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC19B265B1
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493167FBA9;
	Wed, 21 Feb 2024 14:46:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1477FBA2;
	Wed, 21 Feb 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526762; cv=none; b=WZGvrP5YHxX5MYzVv3q3F2JIttoCDaT2IHCQX2uXq+NYocbIhqxEz3mC9OkzeyvL9Qem6DEcRI0xI9ojkfhAkNBuF0anCf8Ou8uU8SIxyQ510Jx2Z3O4CjVwGOUNF5Ab938ep94G6AGcZSbSNdYYVNGuEKPIygh7PCoAoRd0HSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526762; c=relaxed/simple;
	bh=px5R6j4CfBD6L+NyH1bzxUD/SxQ6vZa1DBOK9wlHvDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUpHSKMjWVeXNbEA9U0abFJh8TIOPXnDsAKqXNk2JstyOf58zfuOztGDnc2mGDh4s5bbi6fQtIwwY9F95o7JRKHhQGVricCXgRQHcdjYkszFQ6qRbh843+jqi1k+WuDs1gooH0HM2XqJapAnpa2unugskMIQsmqrbGtj2IywGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tfzbg5LQ0z9txb;
	Wed, 21 Feb 2024 15:45:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hANmYnw3DOMc; Wed, 21 Feb 2024 15:45:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tfzbg4Rs7z9tFS;
	Wed, 21 Feb 2024 15:45:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DED38B76D;
	Wed, 21 Feb 2024 15:45:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4ZYUsQVw3Cpp; Wed, 21 Feb 2024 15:45:51 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 398788B768;
	Wed, 21 Feb 2024 15:45:51 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH bpf-next v2] bpf: Check return from set_memory_rox() and friends
Date: Wed, 21 Feb 2024 15:45:19 +0100
Message-ID: <883c5a268483a89ab13ed630210328a926f16e5b.1708526584.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708526720; l=7152; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=px5R6j4CfBD6L+NyH1bzxUD/SxQ6vZa1DBOK9wlHvDM=; b=5fyB6RbnqOSvhWk+nkpg1uqyuXjHfBWovHDcw9RzvTxBWVm802UGzWAm2DpZ2bZ9CHAAOxwGW 8Y4dIkxnweyCBz/O5h2TCcoI8fqwp689VQh4Vjvlh2ppNALjSkFKCaR
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

arch_protect_bpf_trampoline() and alloc_new_pack() call
set_memory_rox() which can fail, leading to unprotected memory.

Take into account return from set_memory_XX() functions and add
__must_check flag to arch_protect_bpf_trampoline().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v2:
- Move list_add_tail(&pack->list, &pack_list) at the end of alloc_new_pack()
- Split 2 lines that are reported longer than 80 chars by BPF patchwork's checkpatch report.
---
 arch/x86/net/bpf_jit_comp.c    |  6 ++++--
 include/linux/bpf.h            |  4 ++--
 kernel/bpf/bpf_struct_ops.c    |  9 +++++++--
 kernel/bpf/core.c              | 29 ++++++++++++++++++++++-------
 kernel/bpf/trampoline.c        | 18 ++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c |  4 +++-
 6 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..128c8ec9164e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2780,12 +2780,14 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
-void arch_protect_bpf_trampoline(void *image, unsigned int size)
+int arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
+	return 0;
 }
 
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
+int arch_unprotect_bpf_trampoline(void *image, unsigned int size)
 {
+	return 0;
 }
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b86bd15a051d..bb2723c264df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1116,8 +1116,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				void *func_addr);
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
-void arch_protect_bpf_trampoline(void *image, unsigned int size);
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size);
+int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
+int arch_unprotect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr);
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0decd862dfe0..d920afb0dd60 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -488,7 +488,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			if (err)
 				goto reset_unlock;
 		}
-		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+		err = arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+		if (err)
+			goto reset_unlock;
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -497,7 +499,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+	err = arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+	if (err)
+		goto reset_unlock;
+
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c49619ef55d0..eb2256ba6daf 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -898,23 +898,31 @@ static LIST_HEAD(pack_list);
 static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
+	int err;
 
 	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
 	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
-	if (!pack->ptr) {
-		kfree(pack);
-		return NULL;
-	}
+	if (!pack->ptr)
+		goto out;
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
-	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	err = set_memory_rox((unsigned long)pack->ptr,
+			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	if (err)
+		goto out_free;
+	list_add_tail(&pack->list, &pack_list);
 	return pack;
+
+out_free:
+	bpf_jit_free_exec(pack->ptr);
+out:
+	kfree(pack);
+	return NULL;
 }
 
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
@@ -929,9 +937,16 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
+			int err;
+
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
+			err = set_memory_rox((unsigned long)ptr,
+					     size / PAGE_SIZE);
+			if (err) {
+				bpf_jit_free_exec(ptr);
+				ptr = NULL;
+			}
 		}
 		goto out;
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d382f5ebe06c..6e64ac9083b6 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -456,7 +456,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out_free;
 
-	arch_protect_bpf_trampoline(im->image, im->size);
+	err = arch_protect_bpf_trampoline(im->image, im->size);
+	if (err)
+		goto out_free;
 
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
@@ -1072,17 +1074,21 @@ void __weak arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_jit_free_exec(image);
 }
 
-void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
+int __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
 	WARN_ON_ONCE(size > PAGE_SIZE);
-	set_memory_rox((long)image, 1);
+	return set_memory_rox((long)image, 1);
 }
 
-void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
+int __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
 {
+	int err;
 	WARN_ON_ONCE(size > PAGE_SIZE);
-	set_memory_nx((long)image, 1);
-	set_memory_rw((long)image, 1);
+
+	err = set_memory_nx((long)image, 1);
+	if (err)
+		return err;
+	return set_memory_rw((long)image, 1);
 }
 
 int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 02de71719aed..2aaecd8931fc 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -137,7 +137,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err < 0)
 		goto out;
 
-	arch_protect_bpf_trampoline(image, PAGE_SIZE);
+	err = arch_protect_bpf_trampoline(image, PAGE_SIZE);
+	if (err)
+		goto out;
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
-- 
2.43.0


