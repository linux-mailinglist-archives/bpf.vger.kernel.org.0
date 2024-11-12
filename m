Return-Path: <bpf+bounces-44584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6F9C4D73
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 04:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA66DB22FD2
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B7207A14;
	Tue, 12 Nov 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qpfZD8i3"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E64C91
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382955; cv=none; b=oP4+wES+TgIOfOWu4Mha6lo3tBWzVpQ09QD1cHFQSeMRDqP2fJdHQ+21qxx3jL8a3F9pU1Gb1Fw/qLroteTR81+aFyLysk6vzxuY2a7/8VBDbLgqPtvWjVjqBZ4Cj/6TNEeuqjTGeB9Gvo3Kb3SKh5hgsZoBftdAydsgca5FEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382955; c=relaxed/simple;
	bh=nK8pAlDKsOI4aKedaafv9fjCooUAJkehymPkO2T/fvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSoA+YH9MD+znGNmcWDdD1TZ2LFObiD8LV9luFh+uGm9V4kUn1/f2tt8TkGJSKKGFqAFj1ZAz0V7KaZ/M9L8upFfDGZlNB7/asZj/ZSraMV8C8nlKXRzPM/0YODmpYbDawSU1BLd1n4kYK8iYlj0syfrXfHV09nDkuW+X3PGc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qpfZD8i3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1d65e54-76bf-4a52-8862-9691505e80e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731382950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeNynGkDooCmLONZTqPUGZ3RA8J/JyRNRJ5Dka4zVGQ=;
	b=qpfZD8i32fOm94ryHxD5six/cWavVmDKACOmT6uuW3XfbGBtK0xn/fGIQYjc1bwNTu+i+y
	dpX/v4MrBJPJbyo1UHN08x9psNW8Nmvun5JKLaOh9iC0Bb/NRabqHyl5Y+qMGP/C1Z+fqy
	J7o1l8h+nu8eUWHCd/qy0h/u5ZVHVTI=
Date: Mon, 11 Nov 2024 19:42:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 4/7] bpf, x86: Support private stack in jit
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241109025312.148539-1-yonghong.song@linux.dev>
 <20241109025332.150019-1-yonghong.song@linux.dev>
 <CAADnVQJ4OiJbVMU-xrQhokPoECh4v4fWf-N-0YMx0k=h12f8EQ@mail.gmail.com>
 <a339f24d-eeb3-4086-b2b4-914e4c41766a@linux.dev>
 <CAADnVQ+X29PzexOqHiKnT4w7w+X95WjH6RT=-UFGisr-xgapPA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+X29PzexOqHiKnT4w7w+X95WjH6RT=-UFGisr-xgapPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/11/24 5:29 PM, Alexei Starovoitov wrote:
> On Mon, Nov 11, 2024 at 3:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 11/9/24 12:14 PM, Alexei Starovoitov wrote:
>>> On Fri, Nov 8, 2024 at 6:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>           stack_depth = bpf_prog->aux->stack_depth;
>>>> +       if (bpf_prog->aux->priv_stack_ptr) {
>>>> +               priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + round_up(stack_depth, 16);
>>>> +               stack_depth = 0;
>>>> +       }
>>> ...
>>>
>>>> +       priv_stack_ptr = prog->aux->priv_stack_ptr;
>>>> +       if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
>>>> +               priv_stack_ptr = __alloc_percpu_gfp(prog->aux->stack_depth, 16, GFP_KERNEL);
>>> After applying I started to see crashes running test_progs -j like:
>>>
>>> [  173.465191] Oops: general protection fault, probably for
>>> non-canonical address 0xdffffc0000000af9: 0000 [#1] PREEMPT SMP KASAN
>>> [  173.466053] KASAN: probably user-memory-access in range
>>> [0x00000000000057c8-0x00000000000057cf]
>>> [  173.466053] RIP: 0010:dst_dev_put+0x1e/0x220
>>> [  173.466053] Call Trace:
>>> [  173.466053]  <IRQ>
>>> [  173.466053]  ? die_addr+0x40/0xa0
>>> [  173.466053]  ? exc_general_protection+0x138/0x1f0
>>> [  173.466053]  ? asm_exc_general_protection+0x26/0x30
>>> [  173.466053]  ? dst_dev_put+0x1e/0x220
>>> [  173.466053]  rt_fibinfo_free_cpus.part.0+0x8c/0x130
>>> [  173.466053]  fib_nh_common_release+0xd6/0x2a0
>>> [  173.466053]  free_fib_info_rcu+0x129/0x360
>>> [  173.466053]  ? rcu_core+0xa55/0x1340
>>> [  173.466053]  rcu_core+0xa55/0x1340
>>> [  173.466053]  ? rcutree_report_cpu_dead+0x380/0x380
>>> [  173.466053]  ? hrtimer_interrupt+0x319/0x7c0
>>> [  173.466053]  handle_softirqs+0x14c/0x4d0
>>>
>>> [   35.134115] Oops: general protection fault, probably for
>>> non-canonical address 0xe0000bfff101fbbc: 0000 [#1] PREEMPT SMP KASAN
>>> [   35.135089] KASAN: probably user-memory-access in range
>>> [0x00007fff880fdde0-0x00007fff880fdde7]
>>> [   35.135089] RIP: 0010:destroy_workqueue+0x4b4/0xa70
>>> [   35.135089] Call Trace:
>>> [   35.135089]  <TASK>
>>> [   35.135089]  ? die_addr+0x40/0xa0
>>> [   35.135089]  ? exc_general_protection+0x138/0x1f0
>>> [   35.135089]  ? asm_exc_general_protection+0x26/0x30
>>> [   35.135089]  ? destroy_workqueue+0x4b4/0xa70
>>> [   35.135089]  ? destroy_workqueue+0x592/0xa70
>>> [   35.135089]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
>>> [   35.135089]  ext4_put_super+0xff/0xd70
>>> [   35.135089]  generic_shutdown_super+0x148/0x4c0
>>> [   35.135089]  kill_block_super+0x3b/0x90
>>> [   35.135089]  ext4_kill_sb+0x65/0x90
>>>
>>> I think I see the bug... quoted it above...
>>>
>>> Please make sure you reproduce it first.
>> Indeed, to use the allocation size round_up(stack_depth, 16) for __alloc_percpu_gfp()
>> indeed fixed the problem.
>>
>> The following is additional change on top of this patch set to
>>     - fix the memory access bug as suggested by Alexei in the above
>>     - Add guard space for private stack, additional 16 bytes at the
>>       end of stack will be the guard space. The content is prepopulated
>>       and checked at per cpu private stack free site. If the content
>>       is not expected, a kernel message will emit.
>>     - Add kasan support for guard space.
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 55556a64f776..d796d419bb48 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1446,6 +1446,9 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
>>    #define LOAD_TAIL_CALL_CNT_PTR(stack)                          \
>>           __LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
>>
>> +#define PRIV_STACK_GUARD_SZ    16
>> +#define PRIV_STACK_GUARD_VAL   0xEB9F1234eb9f1234ULL
>> +
>>    static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>                     int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>    {
>> @@ -1462,10 +1465,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>           u8 *prog = temp;
>>           u32 stack_depth;
>>           int err;
>> +       // int stack_size;
>>
>>           stack_depth = bpf_prog->aux->stack_depth;
>>           if (bpf_prog->aux->priv_stack_ptr) {
>> -               priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + round_up(stack_depth, 16);
>> +               priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + round_up(stack_depth, 16) + PRIV_STACK_GUARD_SZ;
>>                   stack_depth = 0;
> Since priv stack is not really a stack there is no need to align it to 16
> and no need to round_up() either.
> let's drop these parts and it will simplify the code.
>
> Re: GUARD_SZ.
> I think it's better to guard top and bottom.
> 8 byte for each will do.

Make sense for both. I will align to 8 bytes.

>
>>           }
>>
>> @@ -1496,8 +1500,18 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>                   emit_mov_imm64(&prog, X86_REG_R12,
>>                                  arena_vm_start >> 32, (u32) arena_vm_start);
>>
>> -       if (priv_frame_ptr)
>> +       if (priv_frame_ptr) {
>> +#if 0
>> +               /* hack to emit and write some data to guard area */
>> +               emit_priv_frame_ptr(&prog, bpf_prog->aux->priv_stack_ptr);
>> +
>> +               /* See case BPF_ST | BPF_MEM | BPF_W */
>> +               EMIT2(0x41, 0xC7);
>> +               EMIT2(add_1reg(0x40, X86_REG_R9), 0);
>> +               EMIT(0xFFFFFFFF, bpf_size_to_x86_bytes(BPF_W));
>> +#endif
>>                   emit_priv_frame_ptr(&prog, priv_frame_ptr);
>> +       }
>>
>>           ilen = prog - temp;
>>           if (rw_image)
>> @@ -3383,11 +3397,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>           struct x64_jit_data *jit_data;
>>           int proglen, oldproglen = 0;
>>           struct jit_context ctx = {};
>> +       int priv_stack_size, cpu;
>>           bool tmp_blinded = false;
>>           bool extra_pass = false;
>>           bool padding = false;
>>           u8 *rw_image = NULL;
>>           u8 *image = NULL;
>> +       u64 *guard_ptr;
>>           int *addrs;
>>           int pass;
>>           int i;
>> @@ -3418,11 +3434,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>           }
>>           priv_stack_ptr = prog->aux->priv_stack_ptr;
>>           if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
>> -               priv_stack_ptr = __alloc_percpu_gfp(prog->aux->stack_depth, 16, GFP_KERNEL);
>> +               priv_stack_size = round_up(prog->aux->stack_depth, 16) + PRIV_STACK_GUARD_SZ;
>> +               priv_stack_ptr = __alloc_percpu_gfp(priv_stack_size, 16, GFP_KERNEL);
>>                   if (!priv_stack_ptr) {
>>                           prog = orig_prog;
>>                           goto out_priv_stack;
>>                   }
>> +               for_each_possible_cpu(cpu) {
>> +                       guard_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
>> +                       guard_ptr[0] = guard_ptr[1] = PRIV_STACK_GUARD_VAL;
>> +                       kasan_poison_vmalloc(guard_ptr, PRIV_STACK_GUARD_SZ);
> with top and bottom guards there will be two calls to poison.
>
> But did you check that percpu allocs come from the vmalloc region?
> Does kasan_poison_vmalloc() actually work or silently nop ?

I tried again. it is silent nop. So later when we add kasan for bpf progs,
we need to tackle this as well.

>
>> +               }
>>                   prog->aux->priv_stack_ptr = priv_stack_ptr;
>>           }
>>           addrs = jit_data->addrs;
>> @@ -3561,6 +3583,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>    out_addrs:
>>                   kvfree(addrs);
>>                   if (!image && priv_stack_ptr) {
>> +                       for_each_possible_cpu(cpu) {
>> +                               guard_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
>> +                               kasan_unpoison_vmalloc(guard_ptr, PRIV_STACK_GUARD_SZ, KASAN_VMALLOC_PROT_NORMAL);
>> +                       }
>>                           free_percpu(priv_stack_ptr);
>>                           prog->aux->priv_stack_ptr = NULL;
>>                   }
>> @@ -3603,6 +3629,9 @@ void bpf_jit_free(struct bpf_prog *prog)
>>           if (prog->jited) {
>>                   struct x64_jit_data *jit_data = prog->aux->jit_data;
>>                   struct bpf_binary_header *hdr;
>> +               void __percpu *priv_stack_ptr;
>> +               u64 *guard_ptr;
>> +               int cpu;
>>
>>                   /*
>>                    * If we fail the final pass of JIT (from jit_subprogs),
>> @@ -3618,7 +3647,21 @@ void bpf_jit_free(struct bpf_prog *prog)
>>                   prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
>>                   hdr = bpf_jit_binary_pack_hdr(prog);
>>                   bpf_jit_binary_pack_free(hdr, NULL);
>> -               free_percpu(prog->aux->priv_stack_ptr);
>> +
>> +               priv_stack_ptr = prog->aux->priv_stack_ptr;
>> +               if (priv_stack_ptr) {
>> +                       int stack_size;
>> +
>> +                       stack_size = round_up(prog->aux->stack_depth, 16) + PRIV_STACK_GUARD_SZ;
>> +                       for_each_possible_cpu(cpu) {
>> +                               guard_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
>> +                               kasan_unpoison_vmalloc(guard_ptr, PRIV_STACK_GUARD_SZ, KASAN_VMALLOC_PROT_NORMAL);
>> +                               if (guard_ptr[0] != PRIV_STACK_GUARD_VAL || guard_ptr[1] != PRIV_STACK_GUARD_VAL)
>> +                                       pr_err("Private stack Overflow happened for prog %sx\n", prog->aux->name);
>> +                       }
> Common helper is needed to check guards before free_percpu.

Ack.

>
>> +                       free_percpu(priv_stack_ptr);
>> +               }
>> +
>>                   WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>>           }
>>
>> This fixed the issue Alexei discovered.
>>
>> 16 bytes guard space is allocated since allocation is done with 16byte aligned
>> with multiple-16 size. If bpf program overflows the stack (change '#if 0' to '#if 1')
>> in the above change, we will see:
>>
>> [root@arch-fb-vm1 bpf]# ./test_progs -n 336
>> [   28.447390] bpf_testmod: loading out-of-tree module taints kernel.
>> [   28.448180] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>> #336/1   struct_ops_private_stack/private_stack:OK
>> #336/2   struct_ops_private_stack/private_stack_fail:OK
>> #336/3   struct_ops_private_stack/private_stack_recur:OK
>> #336     struct_ops_private_stack:OK
>> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>> [   28.737710] Private stack Overflow happened for prog Fx
>> [   28.739284] Private stack Overflow happened for prog Fx
>> [   28.968732] Private stack Overflow happened for prog Fx
>>
>> Here the func name is 'Fx' (representing the sub prog). We might need
>> to add more meaningful info (e.g. main prog name) to make message more
>> meaningful.
> Probably worth introducing a helper like:
>
> const char *bpf_get_prog_name(prog)
> {
>    if (fp->aux->ksym.prog)
>      return prog->aux->ksym.name;
>    return prog->aux->name;
> }

Looks good. Thanks for suggestion.

>
>
>> I added some changes related kasan. If I made a change to guard space in kernel (not in bpf prog),
>> the kasan can print out the error message properly. But unfortunately, in jit, there is no
>> kasan instrumentation so warning (with "#if 1" change) is not reported. One possibility is
>> if kernel config enables kasan, bpf jit could add kasan to jited binary. Not sure the
>> complexity and whether it is worthwhile or not since supposedly verifier should already
>> prevent overflow and we already have a guard check (Private stack overflow happened ...)
>> in jit.
> As a follow up we should teach JIT to emit calls __asan_loadN/storeN
> when processing LDX/STX.
> imo it's been long overdue.

I will fix the random crash issue and add guard support.
Will do followup for jit kasan support.


