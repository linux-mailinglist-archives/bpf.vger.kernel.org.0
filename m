Return-Path: <bpf+bounces-42062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110C99F099
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148941F27969
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC71B3936;
	Tue, 15 Oct 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XvWfI/rX"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0A1CB9F5
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004551; cv=none; b=P7FFwd82mFqS6mUxDy9x/XVpkUlXz3U8JxfozmbsG20OrgfizvxEBrpacajgjRM+/aKGDMWvLNnHFL3cNwayG9A+FUK1jEEMyJ0oqlQyYmBtqft48y4Bs1CSpls/podvSmcT8QyKcZmeWHj6NPcoWitP9r8E/kBPrjnh8VyuzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004551; c=relaxed/simple;
	bh=AI5iDG8/oSZWTISouQVr5dOe2A6Ps5NKKxwuuG0ow5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBJ4I5NtcVXmxig2rvhs09gEUFEEII2iLkL47FmN3Ii99oSiGkJyXz3JH4l7YS0MVV5hPzlOmznS7kHHcOCzMd9fIm5pe2nqHHex/YHIDUcwXF7pXK9iiWClWZqBkfnN2l0bSaFPPJ4BdjTUnhqD+uSKawfE1jp8k9LUWjIn208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XvWfI/rX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729004542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4XJypsELEuBreM3jENIs3zOOqJw0Xomzh5IamblAs8=;
	b=XvWfI/rXpcH/aJk0Qr8nwbZeIdUk675ljGtURd6Dm+qXnR1EEZm6JnWG9jqY74tlvYjYhX
	CwH9S4VcueVRhWc9ORncAcD1AstYWuW0CpohZoou8YFY+cTfWiOhB9gJjp4GnX2/7IoHK8
	UBmbVEnFu1jaabNG53kdhhMjU9sZsnc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 1/2] bpf: Prevent tailcall infinite loop caused by freplace
Date: Tue, 15 Oct 2024 23:02:06 +0800
Message-ID: <20241015150207.70264-2-leon.hwang@linux.dev>
In-Reply-To: <20241015150207.70264-1-leon.hwang@linux.dev>
References: <20241015150207.70264-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is a potential infinite loop issue that can occur when using a
combination of tail calls and freplace.

In an upcoming selftest, the attach target for entry_freplace of
tailcall_freplace.c is subprog_tc of tc_bpf2bpf.c, while the tail call in
entry_freplace leads to entry_tc. This results in an infinite loop:

entry_tc -> subprog_tc -> entry_freplace --tailcall-> entry_tc.

The problem arises because the tail_call_cnt in entry_freplace resets to
zero each time entry_freplace is executed, causing the tail call mechanism
to never terminate, eventually leading to a kernel panic.

To fix this issue, the solution is twofold:

1. Prevent updating a program extended by an freplace program to a
   prog_array map.
2. Prevent extending a program that is already part of a prog_array map
   with an freplace program.

This ensures that:

* If a program or its subprogram has been extended by an freplace program,
  it can no longer be updated to a prog_array map.
* If a program has been added to a prog_array map, neither it nor its
  subprograms can be extended by an freplace program.

Moreover, an extension program should not be tailcalled. As such, return
-EINVAL if the program has a type of BPF_PROG_TYPE_EXT when adding it to a
prog_array map.

Additionally, fix a minor code style issue by replacing eight spaces with a
tab for proper formatting.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h     | 17 +++++++++++----
 kernel/bpf/arraymap.c   | 26 +++++++++++++++++++++--
 kernel/bpf/core.c       |  1 +
 kernel/bpf/syscall.c    |  7 +++---
 kernel/bpf/trampoline.c | 47 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 81 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960f..0c216e71cec76 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1292,8 +1292,12 @@ void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
+int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+			     struct bpf_trampoline *tr,
+			     struct bpf_prog *tgt_prog);
+int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+			       struct bpf_trampoline *tr,
+			       struct bpf_prog *tgt_prog);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
@@ -1374,12 +1378,14 @@ void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
 static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
-					   struct bpf_trampoline *tr)
+					   struct bpf_trampoline *tr,
+					   struct bpf_prog *tgt_prog)
 {
 	return -ENOTSUPP;
 }
 static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
-					     struct bpf_trampoline *tr)
+					     struct bpf_trampoline *tr,
+					     struct bpf_prog *tgt_prog)
 {
 	return -ENOTSUPP;
 }
@@ -1483,6 +1489,9 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool is_extended; /* true if extended by freplace program */
+	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
+	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 79660e3fca4c1..6cdbb4c33d31d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -947,22 +947,44 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
 	struct bpf_prog *prog = bpf_prog_get(fd);
+	bool is_extended;
 
 	if (IS_ERR(prog))
 		return prog;
 
-	if (!bpf_prog_map_compatible(map, prog)) {
+	if (prog->type == BPF_PROG_TYPE_EXT ||
+	    !bpf_prog_map_compatible(map, prog)) {
 		bpf_prog_put(prog);
 		return ERR_PTR(-EINVAL);
 	}
 
+	mutex_lock(&prog->aux->ext_mutex);
+	is_extended = prog->aux->is_extended;
+	if (!is_extended)
+		prog->aux->prog_array_member_cnt++;
+	mutex_unlock(&prog->aux->ext_mutex);
+	if (is_extended) {
+		/* Extended prog can not be tail callee. It's to prevent a
+		 * potential infinite loop like:
+		 * tail callee prog entry -> tail callee prog subprog ->
+		 * freplace prog entry --tailcall-> tail callee prog entry.
+		 */
+		bpf_prog_put(prog);
+		return ERR_PTR(-EBUSY);
+	}
+
 	return prog;
 }
 
 static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	struct bpf_prog *prog = ptr;
+
+	mutex_lock(&prog->aux->ext_mutex);
+	prog->aux->prog_array_member_cnt--;
+	mutex_unlock(&prog->aux->ext_mutex);
 	/* bpf_prog is freed after one RCU or tasks trace grace period */
-	bpf_prog_put(ptr);
+	bpf_prog_put(prog);
 }
 
 static u32 prog_fd_array_sys_lookup_elem(void *ptr)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5e77c58e06010..233ea78f8f1bd 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -131,6 +131,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	INIT_LIST_HEAD_RCU(&fp->aux->ksym_prefix.lnode);
 #endif
 	mutex_init(&fp->aux->used_maps_mutex);
+	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
 
 	return fp;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca54..4d04d4d9c1f30 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3214,7 +3214,8 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 		container_of(link, struct bpf_tracing_link, link.link);
 
 	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
-						tr_link->trampoline));
+						tr_link->trampoline,
+						tr_link->tgt_prog));
 
 	bpf_trampoline_put(tr_link->trampoline);
 
@@ -3354,7 +3355,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 *   in prog->aux
 	 *
 	 * - if prog->aux->dst_trampoline is NULL, the program has already been
-         *   attached to a target and its initial target was cleared (below)
+	 *   attached to a target and its initial target was cleared (below)
 	 *
 	 * - if tgt_prog != NULL, the caller specified tgt_prog_fd +
 	 *   target_btf_id using the link_create API.
@@ -3429,7 +3430,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
-	err = bpf_trampoline_link_prog(&link->link, tr);
+	err = bpf_trampoline_link_prog(&link->link, tr, tgt_prog);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400d..9f36c049f4c28 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -523,7 +523,27 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
+{
+	struct bpf_prog_aux *aux = tgt_prog->aux;
+
+	guard(mutex)(&aux->ext_mutex);
+	if (aux->prog_array_member_cnt)
+		/* Program extensions can not extend target prog when the target
+		 * prog has been updated to any prog_array map as tail callee.
+		 * It's to prevent a potential infinite loop like:
+		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
+		 * --tailcall-> tgt prog entry.
+		 */
+		return -EBUSY;
+
+	aux->is_extended = true;
+	return 0;
+}
+
+static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+				      struct bpf_trampoline *tr,
+				      struct bpf_prog *tgt_prog)
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
@@ -544,6 +564,9 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
+		err = bpf_freplace_check_tgt_prog(tgt_prog);
+		if (err)
+			return err;
 		tr->extension_prog = link->link.prog;
 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
@@ -570,17 +593,21 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 	return err;
 }
 
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+			     struct bpf_trampoline *tr,
+			     struct bpf_prog *tgt_prog)
 {
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(link, tr);
+	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+					struct bpf_trampoline *tr,
+					struct bpf_prog *tgt_prog)
 {
 	enum bpf_tramp_prog_type kind;
 	int err;
@@ -591,6 +618,8 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
 					 tr->extension_prog->bpf_func, NULL);
 		tr->extension_prog = NULL;
+		guard(mutex)(&tgt_prog->aux->ext_mutex);
+		tgt_prog->aux->is_extended = false;
 		return err;
 	}
 	hlist_del_init(&link->tramp_hlist);
@@ -599,12 +628,14 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+			       struct bpf_trampoline *tr,
+			       struct bpf_prog *tgt_prog)
 {
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_unlink_prog(link, tr);
+	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
@@ -619,7 +650,7 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
 	if (!shim_link->trampoline)
 		return;
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline));
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline, NULL));
 	bpf_trampoline_put(shim_link->trampoline);
 }
 
@@ -733,7 +764,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr);
+	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL);
 	if (err)
 		goto err;
 
-- 
2.44.0


