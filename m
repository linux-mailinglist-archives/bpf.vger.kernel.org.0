Return-Path: <bpf+bounces-41582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2FC998A84
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EFB21694
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A8420DD2;
	Thu, 10 Oct 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e7omrTBz"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59A1C233D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570483; cv=none; b=c7i8mlQY0JqlFei62VtA0CEx4vxRF21NKw0X3k6tqRVfmwauggEVa9l3CMNZLA33glh277R+J2TfD8qCzFUWhe/CPjz2opeJAs7K9q69rDGsLB6ZMlm9dUPqNAX1R8/00B5OIJ621re0XdJY3k74n90WI7b/nj8eqozU9UbwXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570483; c=relaxed/simple;
	bh=UkDubUacXNheQxfa7Zmf6aIzCn9OGPPaFFk7SK5ZkXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZ8l772ge1evTYub3mwkZBOxCklo7aLGzJ6BwGiZkyXB3IlTM1iqZYGUMaedxLok9Me5mG3k3/gj0qDf95Pn98O6g5XsSE0NACpFwYgFB8VyMOYXBa+h+pub/13qsk/QCiNoS21YAKWgyUNrQa3uEIWBXum9mi9uoFz2Bp1PShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e7omrTBz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba378d8f-aaff-47e8-9830-19e592465d31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728570478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otEzmxtfAyLb/kgW0Gf1O+xuLDD2u3xcggLu8CVNS44=;
	b=e7omrTBzY1BIsqWpTt8VAnEOpTQwXylt3Z+S1eQgXpPgKTNH/1R4N58hth4MeLpKmsyxr+
	8G+hYtCKhKz0CX+6J0pN8FhOYu+fMU0LZRRdi4G1Hm2TiXpDF4CQDKzIxutKY/ydDJJYIk
	/BAiNyZeT2unNMuyR4qRbEzzqXwOIrY=
Date: Thu, 10 Oct 2024 22:27:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 eddyz87@gmail.com, iii@linux.ibm.com, kernel-patches-bot@fb.com,
 lkp@intel.com
References: <20241008161333.33469-1-leon.hwang@linux.dev>
 <20241008161333.33469-2-leon.hwang@linux.dev>
 <7ac49fa0-b1f1-4571-b95a-3ffd8f867735@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <7ac49fa0-b1f1-4571-b95a-3ffd8f867735@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/10 22:06, Xu Kuohai wrote:
> On 10/9/2024 12:13 AM, Leon Hwang wrote:
>> This patch prevents an infinite loop issue caused by combination of
>> tailcall
>> and freplace.
>>
>> For example:
>>
>> tc_bpf2bpf.c:
>>
>> // SPDX-License-Identifier: GPL-2.0
>>
>> \#include <linux/bpf.h>
>> \#include <bpf/bpf_helpers.h>
>>
>> __noinline
>> int subprog_tc(struct __sk_buff *skb)
>> {
>>     return skb->len * 2;
>> }
>>
>> SEC("tc")
>> int entry_tc(struct __sk_buff *skb)
>> {
>>     return subprog_tc(skb);
>> }
>>
>> char __license[] SEC("license") = "GPL";
>>
>> tailcall_freplace.c:
>>
>> // SPDX-License-Identifier: GPL-2.0
>>
>> \#include <linux/bpf.h>
>> \#include <bpf/bpf_helpers.h>
>>
>> struct {
>>     __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>     __uint(max_entries, 1);
>>     __uint(key_size, sizeof(__u32));
>>     __uint(value_size, sizeof(__u32));
>> } jmp_table SEC(".maps");
>>
>> int count = 0;
>>
>> SEC("freplace")
>> int entry_freplace(struct __sk_buff *skb)
>> {
>>     count++;
>>     bpf_tail_call_static(skb, &jmp_table, 0);
>>     return count;
>> }
>>
>> char __license[] SEC("license") = "GPL";
>>
>> The attach target of entry_freplace is subprog_tc, and the tail callee
>> in entry_freplace is entry_tc.
>>
>> Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
>> --tailcall-> entry_tc, because tail_call_cnt in entry_freplace will count
>> from zero for every time of entry_freplace execution. Kernel will panic,
>> like:
>>
>> [   15.310490] BUG: TASK stack guard page was hit at (____ptrval____)
>> (stack is (____ptrval____)..(____ptrval____))
>> [   15.310490] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
>> [   15.310490] CPU: 1 PID: 89 Comm: test_progs Tainted: G           OE
>>     6.10.0-rc6-g026dcdae8d3e-dirty #72
>> [   15.310490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
>> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
>> [   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>> cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
>> fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
>> [   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
>> [   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
>> 0000000000008cb5
>> [   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
>> ffff9c98808b7e00
>> [   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
>> ffffb500c01af000
>> [   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
>> knlGS:0000000000000000
>> [   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
>> 00000000000006f0
>> [   15.310490] Call Trace:
>> [   15.310490]  <#DF>
>> [   15.310490]  ? die+0x36/0x90
>> [   15.310490]  ? handle_stack_overflow+0x4d/0x60
>> [   15.310490]  ? exc_double_fault+0x117/0x1a0
>> [   15.310490]  ? asm_exc_double_fault+0x23/0x30
>> [   15.310490]  ? bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
>> [   15.310490]  </#DF>
>> [   15.310490]  <TASK>
>> [   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
>> [   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
>> [   15.310490]  ...
>> [   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
>> [   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
>> [   15.310490]  bpf_test_run+0x210/0x370
>> [   15.310490]  ? bpf_test_run+0x128/0x370
>> [   15.310490]  bpf_prog_test_run_skb+0x388/0x7a0
>> [   15.310490]  __sys_bpf+0xdbf/0x2c40
>> [   15.310490]  ? clockevents_program_event+0x52/0xf0
>> [   15.310490]  ? lock_release+0xbf/0x290
>> [   15.310490]  __x64_sys_bpf+0x1e/0x30
>> [   15.310490]  do_syscall_64+0x68/0x140
>> [   15.310490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [   15.310490] RIP: 0033:0x7f133b52725d
>> [   15.310490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
>> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
>> [   15.310490] RSP: 002b:00007ffddbc10258 EFLAGS: 00000206 ORIG_RAX:
>> 0000000000000141
>> [   15.310490] RAX: ffffffffffffffda RBX: 00007ffddbc10828 RCX:
>> 00007f133b52725d
>> [   15.310490] RDX: 0000000000000050 RSI: 00007ffddbc102a0 RDI:
>> 000000000000000a
>> [   15.310490] RBP: 00007ffddbc10270 R08: 0000000000000000 R09:
>> 00007ffddbc102a0
>> [   15.310490] R10: 0000000000000064 R11: 0000000000000206 R12:
>> 0000000000000004
>> [   15.310490] R13: 0000000000000000 R14: 0000558ec4c24890 R15:
>> 00007f133b6ed000
>> [   15.310490]  </TASK>
>> [   15.310490] Modules linked in: bpf_testmod(OE)
>> [   15.310490] ---[ end trace 0000000000000000 ]---
>> [   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
>> [   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>> cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
>> fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
>> [   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
>> [   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
>> 0000000000008cb5
>> [   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
>> ffff9c98808b7e00
>> [   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
>> 0000000000000000
>> [   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
>> ffffb500c01af000
>> [   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
>> knlGS:0000000000000000
>> [   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
>> 00000000000006f0
>> [   15.310490] Kernel panic - not syncing: Fatal exception in interrupt
>> [   15.310490] Kernel Offset: 0x30000000 from 0xffffffff81000000
>> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>
>> This patch prevents this panic by preventing updating extended prog to
>> prog_array map and preventing extending a prog, which has been updated
>> to prog_array map, with freplace prog.
>>
>> If a prog or its subprog has been extended by freplace prog, the prog
>> can not be updated to prog_array map.
>>
>> If a prog has been updated to prog_array map, it or its subprog can not
>> be extended by freplace prog.
>>
>> BTW, fix a minor code style issue by replacing 8 spaces with a tab.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-
>> lkp@intel.com/
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>   include/linux/bpf.h     | 21 ++++++++++++++++++++
>>   kernel/bpf/arraymap.c   | 23 +++++++++++++++++++++-
>>   kernel/bpf/core.c       |  1 +
>>   kernel/bpf/syscall.c    | 21 ++++++++++++++------
>>   kernel/bpf/trampoline.c | 43 +++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 102 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 19d8ca8ac960f..213a68c59bdf7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1294,6 +1294,12 @@ bool __bpf_dynptr_is_rdonly(const struct
>> bpf_dynptr_kern *ptr);
>>   #ifdef CONFIG_BPF_JIT
>>   int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct
>> bpf_trampoline *tr);
>>   int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct
>> bpf_trampoline *tr);
>> +int bpf_extension_link_prog(struct bpf_tramp_link *link,
>> +                struct bpf_trampoline *tr,
>> +                struct bpf_prog *tgt_prog);
>> +int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
>> +                  struct bpf_trampoline *tr,
>> +                  struct bpf_prog *tgt_prog);
>>   struct bpf_trampoline *bpf_trampoline_get(u64 key,
>>                         struct bpf_attach_target_info *tgt_info);
>>   void bpf_trampoline_put(struct bpf_trampoline *tr);
>> @@ -1383,6 +1389,18 @@ static inline int
>> bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
>>   {
>>       return -ENOTSUPP;
>>   }
>> +static inline int bpf_extension_link_prog(struct bpf_tramp_link *link,
>> +                struct bpf_trampoline *tr,
>> +                struct bpf_prog *tgt_prog)
>> +{
>> +    return -ENOTSUPP;
>> +}
>> +static inline int bpf_extension_unlink_prog(struct bpf_tramp_link *link,
>> +                  struct bpf_trampoline *tr,
>> +                  struct bpf_prog *tgt_prog)
>> +{
>> +    return -ENOTSUPP;
>> +}
>>   static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
>>                               struct bpf_attach_target_info *tgt_info)
>>   {
>> @@ -1483,6 +1501,9 @@ struct bpf_prog_aux {
>>       bool xdp_has_frags;
>>       bool exception_cb;
>>       bool exception_boundary;
>> +    bool is_extended; /* true if extended by freplace program */
>> +    u64 prog_array_member_cnt; /* counts how many times as member of
>> prog_array */
>> +    struct mutex ext_mutex; /* mutex for is_extended and
>> prog_array_member_cnt */
>>       struct bpf_arena *arena;
>>       /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>>       const struct btf_type *attach_func_proto;
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 79660e3fca4c1..f9bd63a74eee7 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -947,6 +947,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map
>> *map,
>>                      struct file *map_file, int fd)
>>   {
>>       struct bpf_prog *prog = bpf_prog_get(fd);
>> +    bool is_extended;
>>         if (IS_ERR(prog))
>>           return prog;
>> @@ -956,13 +957,33 @@ static void *prog_fd_array_get_ptr(struct
>> bpf_map *map,
>>           return ERR_PTR(-EINVAL);
>>       }
>>   +    mutex_lock(&prog->aux->ext_mutex);
>> +    is_extended = prog->aux->is_extended;
>> +    if (!is_extended)
>> +        prog->aux->prog_array_member_cnt++;
>> +    mutex_unlock(&prog->aux->ext_mutex);
>> +    if (is_extended) {
>> +        /* Extended prog can not be tail callee. It's to prevent a
>> +         * potential infinite loop like:
>> +         * tail callee prog entry -> tail callee prog subprog ->
>> +         * freplace prog entry --tailcall-> tail callee prog entry.
>> +         */
>> +        bpf_prog_put(prog);
>> +        return ERR_PTR(-EBUSY);
>> +    }
> 
> Sorry for the delay.
> 
> IIUC, extension prog should not be tailcalled independently, so an error
> should also be returned if prog->type == BPF_PROG_TYPE_EXT
> 

I think it's OK that freplace prog tail calls itself, see patch #3.

Thanks,
Leon


