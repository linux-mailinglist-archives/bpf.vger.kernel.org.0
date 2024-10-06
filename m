Return-Path: <bpf+bounces-41065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E0991E57
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00AA1F21BDD
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09086176AAA;
	Sun,  6 Oct 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r/S2IXjd"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276C174ED0
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728219711; cv=none; b=J+JS3jlMBsrsJcaGr88PKiN22zyrgTtMmtGSMGDcB4Vu6b/2jf3nuuH32XNQbgNfN7/R36q2L/C1YnqMBTZagkt3Zkit7GTun6z+Vi6RAwSX2KMXOghSYpi6v54aOz2JZ38RN1jxSkJE1/1tHsOFQe4+tA9licnIyCQvRkBJf6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728219711; c=relaxed/simple;
	bh=4lgcTOFqZ5+aGgotydhee4Itj6fb3z6P2pN/ZWH/RLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVK0T8Ox0pfjdEeQ/eA4D+hvfuoBhTkh5LUOwoRbqUIiBvZoA3Evt/ZC5z1GKmSEv+dXJKBlvDjjUVVw8hUYNIDCypOth1yEn/XxhV7immGNe7bExjR0jpfHRFXA0lTU3sbfDk/GYgW6+jnbU4b/kOpzz7Lrx9P0W6yRH4wgzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r/S2IXjd; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728219707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTl6OPLdAeiscxIBQdWkr9PMpyYb/j2srkNi276xwLU=;
	b=r/S2IXjdz4CWwyHOHRTO41REJL4RCnKOAVx7Vf/YAcnBLWpo8HDx5+kM4xp/KQGLDBLcHd
	v7ZjfYhRvqA4zM60zMV/upqBIx9g1V7Bbs4GtVkpKXMUzL5riJIIuhVArYA+D8dJanDH8u
	A/ZmLhsRfOBHIQEBQQarf07W3WBWEQE=
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
Subject: [PATCH bpf-next v5 1/3] bpf: Prevent tailcall infinite loop caused by freplace
Date: Sun,  6 Oct 2024 21:01:27 +0800
Message-ID: <20241006130130.77125-2-leon.hwang@linux.dev>
In-Reply-To: <20241006130130.77125-1-leon.hwang@linux.dev>
References: <20241006130130.77125-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch prevents an infinite loop issue caused by combination of tailcall
and freplace.

For example:

tc_bpf2bpf.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>

__noinline
int subprog_tc(struct __sk_buff *skb)
{
	return skb->len * 2;
}

SEC("tc")
int entry_tc(struct __sk_buff *skb)
{
	return subprog_tc(skb);
}

char __license[] SEC("license") = "GPL";

tailcall_freplace.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

SEC("freplace")
int entry_freplace(struct __sk_buff *skb)
{
	count++;
	bpf_tail_call_static(skb, &jmp_table, 0);
	return count;
}

char __license[] SEC("license") = "GPL";

The attach target of entry_freplace is subprog_tc, and the tail callee
in entry_freplace is entry_tc.

Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
--tailcall-> entry_tc, because tail_call_cnt in entry_freplace will count
from zero for every time of entry_freplace execution. Kernel will panic,
like:

[   15.310490] BUG: TASK stack guard page was hit at (____ptrval____)
(stack is (____ptrval____)..(____ptrval____))
[   15.310490] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[   15.310490] CPU: 1 PID: 89 Comm: test_progs Tainted: G           OE
   6.10.0-rc6-g026dcdae8d3e-dirty #72
[   15.310490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Call Trace:
[   15.310490]  <#DF>
[   15.310490]  ? die+0x36/0x90
[   15.310490]  ? handle_stack_overflow+0x4d/0x60
[   15.310490]  ? exc_double_fault+0x117/0x1a0
[   15.310490]  ? asm_exc_double_fault+0x23/0x30
[   15.310490]  ? bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490]  </#DF>
[   15.310490]  <TASK>
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  ...
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  bpf_test_run+0x210/0x370
[   15.310490]  ? bpf_test_run+0x128/0x370
[   15.310490]  bpf_prog_test_run_skb+0x388/0x7a0
[   15.310490]  __sys_bpf+0xdbf/0x2c40
[   15.310490]  ? clockevents_program_event+0x52/0xf0
[   15.310490]  ? lock_release+0xbf/0x290
[   15.310490]  __x64_sys_bpf+0x1e/0x30
[   15.310490]  do_syscall_64+0x68/0x140
[   15.310490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   15.310490] RIP: 0033:0x7f133b52725d
[   15.310490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[   15.310490] RSP: 002b:00007ffddbc10258 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[   15.310490] RAX: ffffffffffffffda RBX: 00007ffddbc10828 RCX:
00007f133b52725d
[   15.310490] RDX: 0000000000000050 RSI: 00007ffddbc102a0 RDI:
000000000000000a
[   15.310490] RBP: 00007ffddbc10270 R08: 0000000000000000 R09:
00007ffddbc102a0
[   15.310490] R10: 0000000000000064 R11: 0000000000000206 R12:
0000000000000004
[   15.310490] R13: 0000000000000000 R14: 0000558ec4c24890 R15:
00007f133b6ed000
[   15.310490]  </TASK>
[   15.310490] Modules linked in: bpf_testmod(OE)
[   15.310490] ---[ end trace 0000000000000000 ]---
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Kernel panic - not syncing: Fatal exception in interrupt
[   15.310490] Kernel Offset: 0x30000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

This patch prevents this panic by preventing updating extended prog to
prog_array map and preventing extending a prog, which has been updated
to prog_array map, with freplace prog.

If a prog or its subprog has been extended by freplace prog, the prog
can not be updated to prog_array map.

If a prog has been updated to prog_array map, it or its subprog can not
be extended by freplace prog.

BTW, fix a minor code style issue by replacing 8 spaces with a tab.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h     | 21 ++++++++++++++++++++
 kernel/bpf/arraymap.c   | 23 +++++++++++++++++++++-
 kernel/bpf/core.c       |  1 +
 kernel/bpf/syscall.c    | 21 ++++++++++++++------
 kernel/bpf/trampoline.c | 43 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960f..73ee6e77a8ca7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1294,6 +1294,12 @@ bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
+int bpf_extension_link_prog(struct bpf_tramp_link *link,
+			    struct bpf_trampoline *tr,
+			    struct bpf_prog *tgt_prog);
+int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
+			      struct bpf_trampoline *tr,
+			      struct bpf_prog *tgt_prog);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
@@ -1383,6 +1389,18 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 {
 	return -ENOTSUPP;
 }
+int bpf_extension_link_prog(struct bpf_tramp_link *link,
+			    struct bpf_trampoline *tr,
+			    struct bpf_prog *tgt_prog)
+{
+	return -ENOTSUPP;
+}
+int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
+			      struct bpf_trampoline *tr,
+			      struct bpf_prog *tgt_prog)
+{
+	return -ENOTSUPP;
+}
 static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
 							struct bpf_attach_target_info *tgt_info)
 {
@@ -1483,6 +1501,9 @@ struct bpf_prog_aux {
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
index 79660e3fca4c1..f9bd63a74eee7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -947,6 +947,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
 	struct bpf_prog *prog = bpf_prog_get(fd);
+	bool is_extended;
 
 	if (IS_ERR(prog))
 		return prog;
@@ -956,13 +957,33 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
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
index a8f1808a1ca54..4a5a44bbb5f50 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3212,15 +3212,21 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	struct bpf_prog *tgt_prog = tr_link->tgt_prog;
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
-						tr_link->trampoline));
+	if (link->prog->type == BPF_PROG_TYPE_EXT)
+		WARN_ON_ONCE(bpf_extension_unlink_prog(&tr_link->link,
+						       tr_link->trampoline,
+						       tgt_prog));
+	else
+		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
+							tr_link->trampoline));
 
 	bpf_trampoline_put(tr_link->trampoline);
 
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
-		bpf_prog_put(tr_link->tgt_prog);
+	if (tgt_prog)
+		bpf_prog_put(tgt_prog);
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3354,7 +3360,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 *   in prog->aux
 	 *
 	 * - if prog->aux->dst_trampoline is NULL, the program has already been
-         *   attached to a target and its initial target was cleared (below)
+	 *   attached to a target and its initial target was cleared (below)
 	 *
 	 * - if tgt_prog != NULL, the caller specified tgt_prog_fd +
 	 *   target_btf_id using the link_create API.
@@ -3429,7 +3435,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
-	err = bpf_trampoline_link_prog(&link->link, tr);
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		err = bpf_extension_link_prog(&link->link, tr, tgt_prog);
+	else
+		err = bpf_trampoline_link_prog(&link->link, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400d..b14f56046ad4e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -580,6 +580,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 	return err;
 }
 
+int bpf_extension_link_prog(struct bpf_tramp_link *link,
+			    struct bpf_trampoline *tr,
+			    struct bpf_prog *tgt_prog)
+{
+	struct bpf_prog_aux *aux = tgt_prog->aux;
+	int err;
+
+	mutex_lock(&aux->ext_mutex);
+	if (aux->prog_array_member_cnt) {
+		/* Program extensions can not extend target prog when the target
+		 * prog has been updated to any prog_array map as tail callee.
+		 * It's to prevent a potential infinite loop like:
+		 * tgt prog entry -> tgt prog subprog -> freplace prog entry
+		 * --tailcall-> tgt prog entry.
+		 */
+		err = -EBUSY;
+		goto out_unlock;
+	}
+
+	err = bpf_trampoline_link_prog(link, tr);
+	if (err)
+		goto out_unlock;
+
+	aux->is_extended = true;
+out_unlock:
+	mutex_unlock(&aux->ext_mutex);
+	return err;
+}
+
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
 {
 	enum bpf_tramp_prog_type kind;
@@ -609,6 +638,20 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 	return err;
 }
 
+int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
+			      struct bpf_trampoline *tr,
+			      struct bpf_prog *tgt_prog)
+{
+	struct bpf_prog_aux *aux = tgt_prog->aux;
+	int err;
+
+	mutex_lock(&aux->ext_mutex);
+	err = bpf_trampoline_unlink_prog(link, tr);
+	aux->is_extended = false;
+	mutex_unlock(&aux->ext_mutex);
+	return err;
+}
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
-- 
2.44.0


