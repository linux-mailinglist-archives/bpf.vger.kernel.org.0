Return-Path: <bpf+bounces-73782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69944C38F79
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 04:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F431896C34
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB92BE7A6;
	Thu,  6 Nov 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SeDLriDY"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1B8F7D
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399743; cv=none; b=TQ/HXxJnofmkj95VhK1Vy5Y6N3QKbVSzX0k+OLEtQhrGfjbad6va8M5xBU3CnS47MgzmdnRpmZAplFaIea17/jDyKYs0NktIf0HW0870o/3Dj/7Q12c4nTW/Ox8lpLdNOEhWBhKm0kRU8TbsLftjInwhv4RF1D59Zc4N7OpmSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399743; c=relaxed/simple;
	bh=0BQCa8hNbb+t+69Php3hIWt0TTjc1rlkRaAJl3nb2Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc/0PG7rOiNZMcOQjEgFZqia0psW/Yi+SS/7tewa/dD3OyUZKwyeqTwyC8vOccVX1dXuMjwrdQKiIWh9k+zqNA6tXtZp3cz2cUarMYE5U0HB1RvDzmJgpN6BQyHcxhPzQOukW3SOny3fOpqWlUONvCNaTlmmkmClgLSd2kZkVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SeDLriDY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7f085be-3819-46f3-9424-58da25e1891e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762399729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eInA+5LVUWWEAY2CBzLg/Er8itb5rM/VWoopvhS2+LQ=;
	b=SeDLriDYBEb/CHGZEqZsOfHJnj8Vxz/lEX+hHD3yRx6DzDp2eREpKcU93JHAlqUzg3RCEF
	m5nl4Dw5QwMx+dnT92L7206Imu9RB002G5W+H+EWohryEXJBgjn3r00gzerdDRuopV3tVy
	iW4kU7vTgoSYZX5KX93hePfleMb9bb8=
Date: Thu, 6 Nov 2025 11:28:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] perf: Refactor get_perf_callchain
To: Yonghong Song <yonghong.song@linux.dev>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251028162502.3418817-1-chen.dylane@linux.dev>
 <20251028162502.3418817-2-chen.dylane@linux.dev>
 <c686a971-1483-42c0-8199-376d4d4b3875@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <c686a971-1483-42c0-8199-376d4d4b3875@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/6 04:45, Yonghong Song 写道:
> 
> 
> On 10/28/25 9:25 AM, Tao Chen wrote:
>>  From BPF stack map, we want to use our own buffers to avoid
>> unnecessary copy and ensure that the buffer will not be
>> overwritten by other preemptive tasks. Peter suggested
>> provide more flexible stack-sampling APIs, which can be used
>> in BPF, and we can still use the perf callchain entry with
>> the help of these APIs. The next patch will modify the BPF part.
>>
>> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/perf_event.h | 11 +++++-
>>   kernel/bpf/stackmap.c      |  4 +-
>>   kernel/events/callchain.c  | 75 ++++++++++++++++++++++++--------------
>>   kernel/events/core.c       |  2 +-
>>   4 files changed, 61 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index fd1d91017b9..14a382cad1d 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>>       u32                nr;
>>       short                contexts;
>>       bool                contexts_maxed;
>> +    bool                add_mark;
>>   };
>>   typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
>> @@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, 
>> perf_callchain_entry);
>>   extern void perf_callchain_user(struct perf_callchain_entry_ctx 
>> *entry, struct pt_regs *regs);
>>   extern void perf_callchain_kernel(struct perf_callchain_entry_ctx 
>> *entry, struct pt_regs *regs);
>> +
>> +extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx 
>> *ctx,
>> +                      struct perf_callchain_entry *entry,
>> +                      u32 max_stack, bool add_mark);
>> +
>> +extern void __get_perf_callchain_kernel(struct 
>> perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
>> +extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx 
>> *ctx, struct pt_regs *regs);
>> +
>>   extern struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -           u32 max_stack, bool crosstask, bool add_mark);
>> +           u32 max_stack, bool crosstask);
>>   extern int get_callchain_buffers(int max_stack);
>>   extern void put_callchain_buffers(void);
>>   extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4d53cdd1374..e28b35c7e0b 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, 
>> regs, struct bpf_map *, map,
>>           max_depth = sysctl_perf_event_max_stack;
>>       trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                   false, false);
>> +                   false);
> 
> This is not a refactor. Here, the add_mark parameter is removed. The 
> 'add_mark'
> value here is expected to be false, but later get_perf_callchain(...) 
> has 'add_mark'
> is true in __init_perf_callchain_ctx().
> 

Hi Yonghong,

Thanks for your report, you are right. Maybe we should keep the 
get_perf_callchain parameters unchanged. I will change it in v5.

> Applying this patch only on top of bpf-next master branch, we will have the
> following crash:
> 
> [  457.730077] bpf_testmod: oh no, recursing into test_1, 
> recursion_misses 1
> [  460.221871] BUG: unable to handle page fault for address: 
> fffa3bfffffff000
> [  460.221912] #PF: supervisor read access in kernel mode
> [  460.221912] #PF: error_code(0x0000) - not-present page
> [  460.221912] PGD 1e0ef1067 P4D 1e0ef0067 PUD 1e0eef067 PMD 1e0eee067 
> PTE 0
> [  460.221912] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> [  460.221912] CPU: 2 UID: 0 PID: 2012 Comm: test_progs Tainted: 
> G        W  OE       6.18.0-rc4-gafe2e8
> [  460.221912] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  460.221912] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS rel-1.14.0-0-g155821a1990b-pr4
> [  460.221912] RIP: 0010:kasan_check_range+0x183/0x2c0
> [  460.221912] Code: 41 bf 08 00 00 00 41 29 ef 4d 01 fb 4d 29 de 4d 89 
> f4 4d 8d 6c 24 07 4d 85 e4 4d 0fd
> [  460.221912] RSP: 0018:ff110001193bfc78 EFLAGS: 00010206
> [  460.221912] RAX: ffd1ffffffd5b301 RBX: dffffc0000000001 RCX: 
> ffffffff819a2ecb
> [  460.221912] RDX: 0000000000000001 RSI: 00000000ffffffb0 RDI: 
> ffd1ffffffd5b360
> [  460.221912] RBP: 0000000000000004 R08: ffd20000ffd5b30f R09: 
> 1ffa40001ffab661
> [  460.221912] R10: dffffc0000000000 R11: fffa3bfffffab670 R12: 
> 000000001ffffff2
> [  460.221912] R13: 0000000003ff58cc R14: 0000000000053990 R15: 
> 0000000000000000
> [  460.221912] FS:  00007f358c6460c0(0000) GS:ff110002384b4000(0000) 
> knlGS:0000000000000000
> [  460.221912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  460.221912] CR2: fffa3bfffffff000 CR3: 000000011468c006 CR4: 
> 0000000000371ef0
> [  460.221912] Call Trace:
> [  460.221912]  <TASK>
> [  460.221912]  __asan_memset+0x22/0x50
> [  460.221912]  __bpf_get_stack+0x6eb/0x7a0
> [  460.221912]  ? bpf_perf_event_output_raw_tp+0x58c/0x6c0
> [  460.221912]  bpf_get_stack+0x1d/0x30
> [  460.221912]  bpf_get_stack_raw_tp+0x148/0x180
> [  460.221912]  bpf_prog_40e346a03dc2914c_bpf_prog1+0x169/0x1af
> [  460.221912]  bpf_trace_run2+0x1bc/0x350
> [  460.221912]  ? bpf_trace_run2+0x104/0x350
> [  460.221912]  ? trace_sys_enter+0x6b/0xf0
> [  460.221912]  __bpf_trace_sys_enter+0x38/0x60
> [  460.221912]  trace_sys_enter+0xa7/0xf0
> [  460.221912]  syscall_trace_enter+0xfc/0x160
> [  460.221912]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  460.221912]  do_syscall_64+0x5a/0xfa0
> [  460.221912]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  460.221912]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>>       if (unlikely(!trace))
>>           /* couldn't fetch the stack trace */
>> @@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, 
>> struct task_struct *task,
>>           trace = get_callchain_entry_for_task(task, max_depth);
>>       else
>>           trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                       crosstask, false);
>> +                       crosstask);
>>       if (unlikely(!trace) || trace->nr < skip) {
>>           if (may_fault)
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 808c0d7a31f..2c36e490625 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
>> @@ -216,13 +216,54 @@ static void 
>> fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
>>   #endif
>>   }
>> +void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
>> +                   struct perf_callchain_entry *entry,
>> +                   u32 max_stack, bool add_mark)
>> +
>> +{
>> +    ctx->entry        = entry;
>> +    ctx->max_stack        = max_stack;
>> +    ctx->nr            = entry->nr = 0;
>> +    ctx->contexts        = 0;
>> +    ctx->contexts_maxed    = false;
>> +    ctx->add_mark        = add_mark;
>> +}
>> +
>> +void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx 
>> *ctx, struct pt_regs *regs)
>> +{
>> +    if (user_mode(regs))
>> +        return;
>> +
>> +    if (ctx->add_mark)
>> +        perf_callchain_store_context(ctx, PERF_CONTEXT_KERNEL);
>> +    perf_callchain_kernel(ctx, regs);
>> +}
>> +
>> +void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, 
>> struct pt_regs *regs)
>> +{
>> +    int start_entry_idx;
>> +
>> +    if (!user_mode(regs)) {
>> +        if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
>> +            return;
>> +        regs = task_pt_regs(current);
>> +    }
>> +
>> +    if (ctx->add_mark)
>> +        perf_callchain_store_context(ctx, PERF_CONTEXT_USER);
>> +
>> +    start_entry_idx = ctx->nr;
>> +    perf_callchain_user(ctx, regs);
>> +    fixup_uretprobe_trampoline_entries(ctx->entry, start_entry_idx);
>> +}
>> +
>>   struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -           u32 max_stack, bool crosstask, bool add_mark)
>> +           u32 max_stack, bool crosstask)
>>   {
>>       struct perf_callchain_entry *entry;
>>       struct perf_callchain_entry_ctx ctx;
>> -    int rctx, start_entry_idx;
>> +    int rctx;
>>       /* crosstask is not supported for user stacks */
>>       if (crosstask && user && !kernel)
>> @@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool 
>> kernel, bool user,
>>       if (!entry)
>>           return NULL;
>> -    ctx.entry        = entry;
>> -    ctx.max_stack        = max_stack;
>> -    ctx.nr            = entry->nr = 0;
>> -    ctx.contexts        = 0;
>> -    ctx.contexts_maxed    = false;
>> +    __init_perf_callchain_ctx(&ctx, entry, max_stack, true);
>> -    if (kernel && !user_mode(regs)) {
>> -        if (add_mark)
>> -            perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
>> -        perf_callchain_kernel(&ctx, regs);
>> -    }
>> -
>> -    if (user && !crosstask) {
>> -        if (!user_mode(regs)) {
>> -            if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
>> -                goto exit_put;
>> -            regs = task_pt_regs(current);
>> -        }
>> +    if (kernel)
>> +        __get_perf_callchain_kernel(&ctx, regs);
>> -        if (add_mark)
>> -            perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>> -
>> -        start_entry_idx = entry->nr;
>> -        perf_callchain_user(&ctx, regs);
>> -        fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
>> -    }
>> +    if (user && !crosstask)
>> +        __get_perf_callchain_user(&ctx, regs);
>> -exit_put:
>>       put_callchain_entry(rctx);
>>       return entry;
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7541f6f85fc..eb0f110593d 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct 
>> pt_regs *regs)
>>           return &__empty_callchain;
>>       callchain = get_perf_callchain(regs, kernel, user,
>> -                       max_stack, crosstask, true);
>> +                       max_stack, crosstask);
>>       return callchain ?: &__empty_callchain;
>>   }
> 


-- 
Best Regards
Tao Chen

