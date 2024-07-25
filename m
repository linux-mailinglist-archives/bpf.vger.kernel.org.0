Return-Path: <bpf+bounces-35595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDEB93B9D1
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E11E1F23E82
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77F2901;
	Thu, 25 Jul 2024 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUkgrEYD"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE123CB
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867595; cv=none; b=PreImbceFTkdGJqrSkN3P5KDjkqRapdCVnaavA9/MjJgodUPLhhrqiQEn98ZTnHOU6anMtcVXNRLuubX03TSSrKYVYqyr6eu4++CttezTUYeaI1lMmTEEzytlK1xpNrDISFwjWfwmfjhuWLYUPWMUPvDStd62cyWdgZ+GvFY9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867595; c=relaxed/simple;
	bh=ZtLiyxSKMb5P4riIoAMXhNKy3CtATILLYQLu02n68MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kve+5xrjFeypbFdEeR/3BLkBMU7FcdO/x/YPSY2QY1KMxf4t8r9oYupGpO4Ow2QwtTk3RA9V37YYL1EhPbTqgveMWB/QWKjGh7oWYhfYs03GS8udk1bhKZmLyU0IQsAQWj7NvPl/zwFOqPiLCfcWZOfssAlPDVHZedwfLi0mcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUkgrEYD; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721867590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZYRxJYlTl5TcpclwDh+0QBzN9UK/ckcG5I/pF9JewU=;
	b=nUkgrEYDP/yc/TLFbdbyvjDqRYKcgpdUlPflr8Gz710gTU9uAlT6GGvuIIAcFBjvmimQww
	5INNZ1p3G7btIDqcG95NoJaCmLfj2COFCRI4zn0jBM0cLhC5YdbeuhWsn3U6fx2PniCiAc
	nfTMWM01Q6DEQ00xAY2gRB1XCk/LCe0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	wutengda@huaweicloud.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Fix updating attached freplace prog to PROG_ARRAY map
Date: Thu, 25 Jul 2024 08:32:50 +0800
Message-ID: <20240725003251.37855-2-leon.hwang@linux.dev>
In-Reply-To: <20240725003251.37855-1-leon.hwang@linux.dev>
References: <20240725003251.37855-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed the following panic,
which was caused by updating attached freplace prog to PROG_ARRAY map.

But, it does not support updating attached freplace prog to PROG_ARRAY
map.

[309049.036402] BUG: kernel NULL pointer dereference, address: 0000000000000004
[309049.036419] #PF: supervisor read access in kernel mode
[309049.036426] #PF: error_code(0x0000) - not-present page
[309049.036432] PGD 0 P4D 0
[309049.036437] Oops: 0000 [#1] PREEMPT SMP NOPTI
[309049.036444] CPU: 2 PID: 788148 Comm: test_progs Not tainted 6.8.0-31-generic #31-Ubuntu
[309049.036465] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
[309049.036477] RIP: 0010:bpf_prog_map_compatible+0x2a/0x140
[309049.036488] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 fe 41 55 41 54 53 44 8b 6e 04 48 89 f3 41 83 fd 1c 75 0c 48 8b 46 38 48 8b 40 70 <44> 8b 68 04 f6 43 03 01 75 1c 48 8b 43 38 44 0f b6 a0 89 00 00 00
[309049.036505] RSP: 0018:ffffb2e080fd7ce0 EFLAGS: 00010246
[309049.036513] RAX: 0000000000000000 RBX: ffffb2e0807c1000 RCX: 0000000000000000
[309049.036521] RDX: 0000000000000000 RSI: ffffb2e0807c1000 RDI: ffff990290259e00
[309049.036528] RBP: ffffb2e080fd7d08 R08: 0000000000000000 R09: 0000000000000000
[309049.036536] R10: 0000000000000000 R11: 0000000000000000 R12: ffff990290259e00
[309049.036543] R13: 000000000000001c R14: ffff990290259e00 R15: ffff99028e29c400
[309049.036551] FS:  00007b82cbc28140(0000) GS:ffff9903b3f00000(0000) knlGS:0000000000000000
[309049.036559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[309049.036566] CR2: 0000000000000004 CR3: 0000000101286002 CR4: 00000000003706f0
[309049.036573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[309049.036581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[309049.036588] Call Trace:
[309049.036592]  <TASK>
[309049.036597]  ? show_regs+0x6d/0x80
[309049.036604]  ? __die+0x24/0x80
[309049.036619]  ? page_fault_oops+0x99/0x1b0
[309049.036628]  ? do_user_addr_fault+0x2ee/0x6b0
[309049.036634]  ? exc_page_fault+0x83/0x1b0
[309049.036641]  ? asm_exc_page_fault+0x27/0x30
[309049.036649]  ? bpf_prog_map_compatible+0x2a/0x140
[309049.036656]  prog_fd_array_get_ptr+0x2c/0x70
[309049.036664]  bpf_fd_array_map_update_elem+0x37/0x130
[309049.036671]  bpf_map_update_value+0x1d3/0x260
[309049.036677]  map_update_elem+0x1fa/0x360
[309049.036683]  __sys_bpf+0x54c/0xa10
[309049.036689]  __x64_sys_bpf+0x1a/0x30
[309049.036694]  x64_sys_call+0x1936/0x25c0
[309049.036700]  do_syscall_64+0x7f/0x180
[309049.036706]  ? do_syscall_64+0x8c/0x180
[309049.036712]  ? do_syscall_64+0x8c/0x180
[309049.036717]  ? irqentry_exit+0x43/0x50
[309049.036723]  ? common_interrupt+0x54/0xb0
[309049.036729]  entry_SYSCALL_64_after_hwframe+0x73/0x7b

Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
checking map compatibility"), freplace prog can be used as tail-callee
of its target prog.
And the commit 3aac1ead5eb6b76f ("bpf: Move prog->aux->linked_prog and
trampoline into bpf_link on attach") sets prog->aux->dst_prog as NULL
when attach freplace prog to its target.

Then, as for following example:

tailcall_freplace.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>
\#include "bpf_legacy.h"

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

__noinline int
subprog(struct __sk_buff *skb)
{
	volatile int ret = 1;

	count++;

	bpf_tail_call_static(skb, &jmp_table, 0);

	return ret;
}

SEC("freplace")
int entry(struct __sk_buff *skb)
{
	return subprog(skb);
}

char __license[] SEC("license") = "GPL";

tc_bpf2bpf.c:

// SPDX-License-Identifier: GPL-2.0

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>
\#include "bpf_legacy.h"

__noinline int
subprog(struct __sk_buff *skb)
{
	volatile int ret = 1;

	return ret;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	return subprog(skb);
}

char __license[] SEC("license") = "GPL";

And freplace entry prog's target is the tc subprog.

After loading, the freplace jmp_table's owner type is
BPF_PROG_TYPE_SCHED_CLS.

Next, after attaching freplace prog to tc subprog, its prog->aux->
dst_prog is NULL.

Next, when update freplace prog to jmp_table, bpf_prog_map_compatible()
returns false because resolve_prog_type() returns BPF_PROG_TYPE_EXT instead
of BPF_PROG_TYPE_SCHED_CLS.

With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_CLS to
support updating attached freplace prog to PROG_ARRY map for this
example.

Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf_verifier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cea15c81b8a8..387e034e73d0e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
-		prog->aux->dst_prog->type : prog->type;
+	return prog->type == BPF_PROG_TYPE_EXT ?
+		prog->aux->saved_dst_prog_type : prog->type;
 }
 
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
-- 
2.44.0


