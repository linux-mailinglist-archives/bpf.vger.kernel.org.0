Return-Path: <bpf+bounces-40201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0997EC75
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707B9281FF2
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451F38394;
	Mon, 23 Sep 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlNPJgyi"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10294199938
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098862; cv=none; b=QSqQKgZllVIpBUGMYnjxsptBU/bViBPza0qk2ziLYTWua/SoZbCAGgHby4MAKQzCwR4iol7hpyyBkUMsVNWqgtkI/aOO86IlC7EGXIe/UO89yxxjjznQ2wTDaPJR8ismKNw0ZDNhO1PB0fiyJnKLxNA9Z6C7WK9dOJCCnA95Q38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098862; c=relaxed/simple;
	bh=H03Y+3Q9gwIjGogmqnyqYCqFi/ifXrQsnOsNj44Z5Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fq6w9R832b7ofGqn9zeBLxgLQJDlmLud42HW8QpG+k162yNAQ/bBDONQ9TXSGWw41C2bn6ypzDPis4Zq8VdqhbedjhtzJolby5pZSmehWORhQJkEaSFGU+Rw8wcoIHkvV5FJr5ji8m6FCuKNJZtqfcEXyLunklL3HfDeCU2YDhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlNPJgyi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727098857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gty8MxhVK2T8lJuisB+2PZbyIB9Dwu4AkmByBdtaBbk=;
	b=QlNPJgyiR0Ff6sigGTj/wahnsl4mCN98HNzyHEMM0+lB0/wwZpAmtOe2xsmCiimjnJ5BtS
	VAb4Kp38KDcq3arWptJUoMaBK9o6G3osSI/6CwsvY2aXMdXF/unHo+813JubhHmYzUbKIJ
	rnM12BmHHY3MzsLmNODszX/gyg3rGkY=
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
Subject: [PATCH bpf-next v3 1/4] bpf: Prevent updating extended prog to prog_array map
Date: Mon, 23 Sep 2024 21:40:41 +0800
Message-ID: <20240923134044.22388-2-leon.hwang@linux.dev>
In-Reply-To: <20240923134044.22388-1-leon.hwang@linux.dev>
References: <20240923134044.22388-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch prevents a potential infinite loop issue caused by combination
of tailcal and freplace partially.

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

tailcall_bpf2bpf_hierarchy_freplace.c:

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

static __noinline
int subprog_tail(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

SEC("freplace")
int entry_freplace(struct __sk_buff *skb)
{
	count++;
	subprog_tail(skb);
	subprog_tail(skb);
	return count;
}

char __license[] SEC("license") = "GPL";

The attach target of entry_freplace is subprog_tc, and the tail callee
in subprog_tail is entry_tc.

Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
-> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
entry_freplace will count from zero for every time of entry_freplace
execution. Kernel will panic:

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

This patch partially prevents this panic by preventing updating extended
prog to prog_array map.

If a prog or its subprog has been extended by freplace prog, the prog
can not be updated to prog_array map.

Alongside next patch, the panic will be prevented completely.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/arraymap.c | 7 ++++++-
 kernel/bpf/syscall.c  | 7 ++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0c3893c471711..048aa2625cbef 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1483,6 +1483,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool is_extended; /* true if extended by freplace program */
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 79660e3fca4c1..8d97bae98fa70 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -951,7 +951,12 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	if (IS_ERR(prog))
 		return prog;
 
-	if (!bpf_prog_map_compatible(map, prog)) {
+	if (!bpf_prog_map_compatible(map, prog) || prog->aux->is_extended) {
+		/* Extended prog can not be tail callee. It's to prevent a
+		 * potential infinite loop like:
+		 * tail callee prog entry -> tail callee prog subprog ->
+		 * freplace prog entry --tailcall-> tail callee prog entry.
+		 */
 		bpf_prog_put(prog);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a4117f6d7610..18b3f9216b050 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3292,8 +3292,11 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 	bpf_trampoline_put(tr_link->trampoline);
 
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
+		if (link->prog->type == BPF_PROG_TYPE_EXT)
+			tr_link->tgt_prog->aux->is_extended = false;
 		bpf_prog_put(tr_link->tgt_prog);
+	}
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3523,6 +3526,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (prog->aux->dst_trampoline && tr != prog->aux->dst_trampoline)
 		/* we allocated a new trampoline, so free the old one */
 		bpf_trampoline_put(prog->aux->dst_trampoline);
+	if (prog->type == BPF_PROG_TYPE_EXT)
+		tgt_prog->aux->is_extended = true;
 
 	prog->aux->dst_prog = NULL;
 	prog->aux->dst_trampoline = NULL;
-- 
2.44.0


