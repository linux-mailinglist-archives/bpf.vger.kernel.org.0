Return-Path: <bpf+bounces-35674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C793C9FD
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E91F21AF9
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0513D50E;
	Thu, 25 Jul 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MpgLJDGd"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A458222
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941105; cv=none; b=iH+zOc9QySYbmsFb95S4U4YhlrpJTYvgK+LoLt7tLf0caSQGkxTJ7EfGxJoCA+sW+E5R2cNgAgNuPbHqNQT/4f6821KAqYJhk1Nj20N4XQLziUe5Y5tWBtVAfbo9iR5bjmXFLaLwltZnLf0Cg16p1dhNM7ov39vizrteMkR551w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941105; c=relaxed/simple;
	bh=ITnDSYcU1nq0rMq15OJhAYqdkpW5wsxm2a5qiZYqbsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mI+xlLsJwifCMe5/GpaB33iUn6Zi9Huc32gE1DxxKXI+DYmwhIpekkU8mK1yguj9yCGuZRfBebQ01obbnO2ybGgeBCmLkpEl3KJL+uqIhDWkpPR1/3RaxkMkALK1s7WnTxbbNtg+rVjDpoDFHD+nTsNPmBRXGFLtaaEhKU9kjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MpgLJDGd; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <181a9753-717c-4eb4-b788-74468f68c0ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721941100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQqyhPBtaPJcsgGATt/tcTKERtDG9BTey0YKW6HJzfg=;
	b=MpgLJDGd2Ij7W+St5ktRQ+1rKqWgGJyxXhfiq4rfr8bK7iidYRIpi4QZTeknf7SxmkQVhU
	CZxPrAoHTxqyyiCpKl8h3WYI3CRPhaClwwXY03OfAjE17jdKsaR6+Vs+4ygvtsf1RKt1rl
	6HA7f0SIT8wLUKnw69rlx/FXK7fORbA=
Date: Thu, 25 Jul 2024 13:58:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix updating attached freplace prog to
 PROG_ARRAY map
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, eddyz87@gmail.com, wutengda@huaweicloud.com,
 kernel-patches-bot@fb.com
References: <20240725003251.37855-1-leon.hwang@linux.dev>
 <20240725003251.37855-2-leon.hwang@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240725003251.37855-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 5:32 PM, Leon Hwang wrote:
> The commit f7866c3587337731 ("bpf: Fix null pointer dereference in
> resolve_prog_type() for BPF_PROG_TYPE_EXT") fixed the following panic,
> which was caused by updating attached freplace prog to PROG_ARRAY map.

I am confused here. You mentioned that commit f7866c3587337731
fixed the panic below. But looking at commit message:
   https://lore.kernel.org/bpf/20240711145819.254178-2-wutengda@huaweicloud.com
it does not seem the case.

>
> But, it does not support updating attached freplace prog to PROG_ARRAY
> map.

This seems true since this patch itself intends fixing this issue.

>
> [309049.036402] BUG: kernel NULL pointer dereference, address: 0000000000000004
> [309049.036419] #PF: supervisor read access in kernel mode
> [309049.036426] #PF: error_code(0x0000) - not-present page
> [309049.036432] PGD 0 P4D 0
> [309049.036437] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [309049.036444] CPU: 2 PID: 788148 Comm: test_progs Not tainted 6.8.0-31-generic #31-Ubuntu
> [309049.036465] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
> [309049.036477] RIP: 0010:bpf_prog_map_compatible+0x2a/0x140
> [309049.036488] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 fe 41 55 41 54 53 44 8b 6e 04 48 89 f3 41 83 fd 1c 75 0c 48 8b 46 38 48 8b 40 70 <44> 8b 68 04 f6 43 03 01 75 1c 48 8b 43 38 44 0f b6 a0 89 00 00 00
> [309049.036505] RSP: 0018:ffffb2e080fd7ce0 EFLAGS: 00010246
> [309049.036513] RAX: 0000000000000000 RBX: ffffb2e0807c1000 RCX: 0000000000000000
> [309049.036521] RDX: 0000000000000000 RSI: ffffb2e0807c1000 RDI: ffff990290259e00
> [309049.036528] RBP: ffffb2e080fd7d08 R08: 0000000000000000 R09: 0000000000000000
> [309049.036536] R10: 0000000000000000 R11: 0000000000000000 R12: ffff990290259e00
> [309049.036543] R13: 000000000000001c R14: ffff990290259e00 R15: ffff99028e29c400
> [309049.036551] FS:  00007b82cbc28140(0000) GS:ffff9903b3f00000(0000) knlGS:0000000000000000
> [309049.036559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [309049.036566] CR2: 0000000000000004 CR3: 0000000101286002 CR4: 00000000003706f0
> [309049.036573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [309049.036581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [309049.036588] Call Trace:
> [309049.036592]  <TASK>
> [309049.036597]  ? show_regs+0x6d/0x80
> [309049.036604]  ? __die+0x24/0x80
> [309049.036619]  ? page_fault_oops+0x99/0x1b0
> [309049.036628]  ? do_user_addr_fault+0x2ee/0x6b0
> [309049.036634]  ? exc_page_fault+0x83/0x1b0
> [309049.036641]  ? asm_exc_page_fault+0x27/0x30
> [309049.036649]  ? bpf_prog_map_compatible+0x2a/0x140
> [309049.036656]  prog_fd_array_get_ptr+0x2c/0x70
> [309049.036664]  bpf_fd_array_map_update_elem+0x37/0x130
> [309049.036671]  bpf_map_update_value+0x1d3/0x260
> [309049.036677]  map_update_elem+0x1fa/0x360
> [309049.036683]  __sys_bpf+0x54c/0xa10
> [309049.036689]  __x64_sys_bpf+0x1a/0x30
> [309049.036694]  x64_sys_call+0x1936/0x25c0
> [309049.036700]  do_syscall_64+0x7f/0x180
> [309049.036706]  ? do_syscall_64+0x8c/0x180
> [309049.036712]  ? do_syscall_64+0x8c/0x180
> [309049.036717]  ? irqentry_exit+0x43/0x50
> [309049.036723]  ? common_interrupt+0x54/0xb0
> [309049.036729]  entry_SYSCALL_64_after_hwframe+0x73/0x7b

I actually tried your selftest (patch 2/2) without patch 1/1, I got the
following error:

All error logs:
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
test_tailcall_freplace:PASS:open fr_skel 0 nsec
test_tailcall_freplace:PASS:open tc_skel 0 nsec
test_tailcall_freplace:PASS:tc_skel entry prog_id 0 nsec
test_tailcall_freplace:PASS:set_attach_target 0 nsec
test_tailcall_freplace:PASS:load fr_skel 0 nsec
test_tailcall_freplace:PASS:attach_freplace 0 nsec
test_tailcall_freplace:PASS:fr_skel entry prog_fd 0 nsec
test_tailcall_freplace:PASS:fr_skel jmp_table map_fd 0 nsec
test_tailcall_freplace:FAIL:update jmp_table unexpected error: -22 (errno 22)
#328/25  tailcalls/tailcall_freplace:FAIL
#328     tailcalls:FAIL

I didn't see kernel panic.

>
> Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
> checking map compatibility"), freplace prog can be used as tail-callee
> of its target prog.

the tailcall target can be a freplace prog.

> And the commit 3aac1ead5eb6b76f ("bpf: Move prog->aux->linked_prog and
> trampoline into bpf_link on attach") sets prog->aux->dst_prog as NULL
> when attach freplace prog to its target.

when attach -> after attaching

>
> Then, as for following example:
>
> tailcall_freplace.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> \#include "bpf_legacy.h"
>
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> int count = 0;
>
> __noinline int
> subprog(struct __sk_buff *skb)
> {
> 	volatile int ret = 1;
>
> 	count++;
>
> 	bpf_tail_call_static(skb, &jmp_table, 0);
>
> 	return ret;
> }

This subprog is not needed and could be misleading,
just inline subprog into entry prog, it should be okay.

>
> SEC("freplace")
> int entry(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
>
> char __license[] SEC("license") = "GPL";
>
> tc_bpf2bpf.c:
>
> // SPDX-License-Identifier: GPL-2.0
>
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> \#include "bpf_legacy.h"
>
> __noinline int
> subprog(struct __sk_buff *skb)
> {
> 	volatile int ret = 1;
>
> 	return ret;
> }
>
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
>
> char __license[] SEC("license") = "GPL";
>
> And freplace entry prog's target is the tc subprog.
>
> After loading, the freplace jmp_table's owner type is
> BPF_PROG_TYPE_SCHED_CLS.
>
> Next, after attaching freplace prog to tc subprog, its prog->aux->
> dst_prog is NULL.
>
> Next, when update freplace prog to jmp_table, bpf_prog_map_compatible()
> returns false because resolve_prog_type() returns BPF_PROG_TYPE_EXT instead
> of BPF_PROG_TYPE_SCHED_CLS.
>
> With this patch, resolve_prog_type() returns BPF_PROG_TYPE_SCHED_CLS to
> support updating attached freplace prog to PROG_ARRY map for this
> example.
>
> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   include/linux/bpf_verifier.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cea15c81b8a8..387e034e73d0e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
>   /* only use after check_attach_btf_id() */
>   static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>   {
> -	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
> -		prog->aux->dst_prog->type : prog->type;
> +	return prog->type == BPF_PROG_TYPE_EXT ?
> +		prog->aux->saved_dst_prog_type : prog->type;

If prog->aux->dst_prog is NULL, is it possible that prog->aux->saved_dst_prog_type
(0, corresponding to BPF_PROG_TYPE_UNSPEC) could be returned? Do we need to do
	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
		prog->aux->saved_dst_prog_type : prog->type;

Maybe I missed something here?

>   }
>   
>   static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)

