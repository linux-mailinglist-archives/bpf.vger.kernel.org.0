Return-Path: <bpf+bounces-22203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A43858EAE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD3282DA3
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703B1DFE1;
	Sat, 17 Feb 2024 10:24:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D281E;
	Sat, 17 Feb 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165462; cv=none; b=B5KKg1JED7k/GMm2WoR4sI+n4eokVsSxnbUYyM6/6HGHd6kZ0jFGEJtEJJCXEMDd6Zj5XG4t0mykuCRFjbK2ztSKc372mhC8x6uFkWalL3A8vNGuqMT60JzNEpmrerGZIQ5v7tz7fg01/2YVE1do+tLhJgZqG0ysMUDV6TiYzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165462; c=relaxed/simple;
	bh=Mz+g/1CVM2PJP2Uq812BuwnoZ/L5UEO66m09oWnr1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQvBrvQrcHcfdKG+B11wOFv56JfwN/roY/yA1i+GU2GinoUBe/TyC3VERDWNcQibMqvK63GVPMQltX7591HPV7/7tMM+HT8PsSowWU9TeFL41COtYrE/0M4b0q+7T1GC8av+Z07R00+hk45f1TJstcKMwjJ1XsyVh7VJqSTrJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TcPzb6CXPz9v73;
	Sat, 17 Feb 2024 11:24:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6KspJ0V2-DIb; Sat, 17 Feb 2024 11:24:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TcPzb5FtVz9v6y;
	Sat, 17 Feb 2024 11:24:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A5B908B76E;
	Sat, 17 Feb 2024 11:24:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rrFoO8lLqJVF; Sat, 17 Feb 2024 11:24:11 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.2])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EB7E8B763;
	Sat, 17 Feb 2024 11:24:10 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
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
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: [PATCH bpf-next] bpf: Check return from set_memory_rox() and friends
Date: Sat, 17 Feb 2024 11:24:07 +0100
Message-ID: <63322c8e8454de9b240583de58cd730bc97bb789.1708165016.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708165448; l=6853; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Mz+g/1CVM2PJP2Uq812BuwnoZ/L5UEO66m09oWnr1QU=; b=YEQ3YCkk7J/1zGFK/ZSlyru0s4KexlE0XcLFVWKXeuTKMVK6q0ZK4DS5AuxlH0/h+hGSMoxRU O7BYxxTK8QeAcyh9SKokVb9ivVqn208+RoHx3eOdpBoZRkSdtyz6u2w
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

arch_protect_bpf_trampoline() and alloc_new_pack() call
set_memory_rox() which can fail, leading to unprotected memory.

Take into account return from set_memory_XX() functions and add
__must_check flag to arch_protect_bpf_trampoline().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/x86/net/bpf_jit_comp.c    |  6 ++++--
 include/linux/bpf.h            |  4 ++--
 kernel/bpf/bpf_struct_ops.c    |  9 +++++++--
 kernel/bpf/core.c              | 25 +++++++++++++++++++------
 kernel/bpf/trampoline.c        | 18 ++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c |  4 +++-
 6 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 919f647c740f..db05e0ba9f68 100644
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
index e30100597d0a..169847ed1f8d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1112,8 +1112,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
index 02068bd0e4d9..7638a735f48f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -522,7 +522,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
@@ -531,7 +533,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
index ea6843be2616..23ce17da3bf7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -898,23 +898,30 @@ static LIST_HEAD(pack_list);
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
 	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	err = set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	if (err)
+		goto out_free;
 	return pack;
+
+out_free:
+	bpf_jit_free_exec(pack->ptr);
+out:
+	kfree(pack);
+	return NULL;
 }
 
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
@@ -929,9 +936,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
+			int err;
+
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
+			err = set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
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
index 8906f7bdf4a9..6d49a00fba4d 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -129,7 +129,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
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


