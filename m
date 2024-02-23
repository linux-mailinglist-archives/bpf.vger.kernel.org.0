Return-Path: <bpf+bounces-22553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30C8609BA
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 05:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF1D1C23FBF
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C510965;
	Fri, 23 Feb 2024 04:06:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC9B67F
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661190; cv=none; b=cQ8q7gibYwrZQ3Lv7mguBbqwMX14cWTvpRJtHE7KV1ePyLf5r+TtDQWUQ9eDOTsIeeRGuTrfRsK9eKI+L/QRp7LO1i1lobAMnfQWMACWC5Cq0WO2ZJCDgf1jKXM7Tddo5PMP2SDe75b+TvobM9mDj9Zy9dSAKSBUoXQ32/xHYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661190; c=relaxed/simple;
	bh=eB9ME1P6UaatBBoHMKbpgrJ5xTVYGqlJs7xDrsKhWvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ge+7B5Y6VrRag66biM1VbMerkuZt4aTSHV0zPVD2i2FIUoyGTryNQrIF+tc7BggYnq1AzCgyKiiE0cusrgsv+H18YS9RWscCCIe3RKTUnSIT8J2UMzttpMqB1WX3vaaQYzC/6wK6qxA4mTxy1z91XxOeO5sx9KPhRrvBxY9ATfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TgxGQ2DbSz1h0Qm;
	Fri, 23 Feb 2024 12:04:14 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A77F1402CE;
	Fri, 23 Feb 2024 12:06:24 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 23 Feb 2024 12:06:23 +0800
Message-ID: <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com>
Date: Fri, 23 Feb 2024 12:06:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Leon Hwang <hffilwlqm@gmail.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<maciej.fijalkowski@intel.com>, <jakub@cloudflare.com>, <iii@linux.ibm.com>,
	<hengqi.chen@gmail.com>, <kernel-patches-bot@fb.com>
References: <20240222085232.62483-1-hffilwlqm@gmail.com>
 <20240222085232.62483-2-hffilwlqm@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240222085232.62483-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/2/22 16:52, Leon Hwang wrote:
>>From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
> 
>>From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> 
> How about:
> 
> 1. More than 1 subprograms are called in a bpf program.
> 2. The tailcalls in the subprograms call the bpf program.
> 
> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
> 
> Let's take a look into an example:
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
> static __noinline
> int subprog_tail(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> 	volatile int ret = 1;
> 
> 	count++;
> 	subprog_tail(skb); /* subprog call1 */
> 	subprog_tail(skb); /* subprog call2 */
> 
> 	return ret;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> And the entry bpf prog is populated to the 0th slot of jmp_table. Then,
> what happens when entry bpf prog runs? The CPU will be stalled because
> of too many tailcalls, e.g. the test_progs failed to run on aarch64 and
> s390x because of "rcu: INFO: rcu_sched self-detected stall on CPU".
> 
> So, if CPU does not stall because of too many tailcalls, how many
> tailcalls will be there for this case? And why MAX_TAIL_CALL_CNT limit
> does not work for this case?
> 
> Let's step into some running steps.
> 
> At the very first time when subprog_tail() is called, subprog_tail() does
> tailcall the entry bpf prog. Then, subprog_taill() is called at second time
> at the position subprog call1, and it tailcalls the entry bpf prog again.
> 
> Then, again and again. At the very first time when MAX_TAIL_CALL_CNT limit
> works, subprog_tail() has been called for 34 times at the position subprog
> call1. And at this time, the tail_call_cnt is 33 in subprog_tail().
> 
> Next, the 34th subprog_tail() returns to entry() because of
> MAX_TAIL_CALL_CNT limit.
> 
> In entry(), the 34th entry(), at the time after the 34th subprog_tail() at
> the position subprog call1 finishes and before the 1st subprog_tail() at
> the position subprog call2 calls in entry(), what's the value of
> tail_call_cnt in entry()? It's 33.
> 
> As we know, tail_all_cnt is pushed on the stack of entry(), and propagates
> to subprog_tail() by %rax from stack.
> 
> Then, at the time when subprog_tail() at the position subprog call2 is
> called for its first time, tail_call_cnt 33 propagates to subprog_tail()
> by %rax. And the tailcall in subprog_tail() is aborted because of
> tail_call_cnt >= MAX_TAIL_CALL_CNT too.
> 
> Then, subprog_tail() at the position subprog call2 ends, and the 34th
> entry() ends. And it returns to the 33rd subprog_tail() called from the
> position subprog call1. But wait, at this time, what's the value of
> tail_call_cnt under the stack of subprog_tail()? It's 33.
> 
> Then, in the 33rd entry(), at the time after the 33th subprog_tail() at
> the position subprog call1 finishes and before the 2nd subprog_tail() at
> the position subprog call2 calls, what's the value of tail_call_cnt
> in current entry()? It's *32*. Why not 33?
> 
> Before stepping into subprog_tail() at the position subprog call2 in 33rd
> entry(), like stopping the time machine, let's have a look at the stack
> memory:
> 
>    |  STACK  |
>    +---------+ RBP  <-- current rbp
>    |   ret   | STACK of 33rd entry()
>    |   tcc   | its value is 32
>    +---------+ RSP  <-- current rsp
>    |   rip   | STACK of 34rd entry()
>    |   rbp   | reuse the STACK of 33rd subprog_tail() at the position
>    |   ret   |                                        subprog call1
>    |   tcc   | its value is 33
>    +---------+ rsp
>    |   rip   | STACK of 1st subprog_tail() at the position subprog call2
>    |   rbp   |
>    |   tcc   | its value is 33
>    +---------+ rsp
> 
> Why not 33? It's because tail_call_cnt does not back-propagate from
> subprog_tail() to entry().
> 
> Then, while stepping into subprog_tail() at the position subprog call2 in
> 33rd entry():
> 
>    |  STACK  |
>    +---------+
>    |   ret   | STACK of 33rd entry()
>    |   tcc   | its value is 32
>    |   rip   |
>    |   rbp   |
>    +---------+ RBP  <-- current rbp
>    |   tcc   | its value is 32; STACK of subprog_tail() at the position
>    +---------+ RSP  <-- current rsp                        subprog call2
> 
> Then, while pausing after tailcalling in 2nd subprog_tail() at the position
> subprog call2:
> 
>    |  STACK  |
>    +---------+
>    |   ret   | STACK of 33rd entry()
>    |   tcc   | its value is 32
>    |   rip   |
>    |   rbp   |
>    +---------+ RBP  <-- current rbp
>    |   tcc   | its value is 33; STACK of subprog_tail() at the position
>    +---------+ RSP  <-- current rsp                        subprog call2
> 
> Note: what happens to tail_call_cnt:
> 	/*
> 	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
> 	 *	goto out;
> 	 */
> It's to check >= MAX_TAIL_CALL_CNT first and then increment tail_call_cnt.
> 
> So, current tailcall is allowed to run.
> 
> Then, entry() is tailcalled. And the stack memory status is:
> 
>    |  STACK  |
>    +---------+
>    |   ret   | STACK of 33rd entry()
>    |   tcc   | its value is 32
>    |   rip   |
>    |   rbp   |
>    +---------+ RBP  <-- current rbp
>    |   ret   | STACK of 35th entry(); reuse STACK of subprog_tail() at the
>    |   tcc   | its value is 33                   the position subprog call2
>    +---------+ RSP  <-- current rsp
> 
> So, the tailcalls in the 35th entry() will be aborted.
> 
> And, ..., again and again.  :(
> 
> And, I hope you have understood the reason why MAX_TAIL_CALL_CNT limit
> does not work for this case.
> 
> And, how many tailcalls are there for this case if CPU does not stall?
> 
>>From top-down view, does it look like hierarchy layer and layer?
> 
> I think it is a hierarchy layer model with 2+4+8+...+2**33 tailcalls. As a
> result, if CPU does not stall, there will be 2**34 - 2 = 17,179,869,182
> tailcalls. That's the guy making CPU stalled.
> 
> What about there are N subprog_tail() in entry()? If CPU does not stall
> because of too many tailcalls, there will be almost N**34 tailcalls.
> 
> As we learn about the issue, how does this patch resolve it?
> 
> In this patch, it uses PERCPU tail_call_cnt to store the temporary
> tail_call_cnt.
> 
> First, at the prologue of bpf prog, it initialise the PERCPU
> tail_call_cnt by setting current CPU's tail_call_cnt to 0.
> 
> Then, when a tailcall happens, it fetches and increments current CPU's
> tail_call_cnt, and compares to MAX_TAIL_CALL_CNT.
> 
> Additionally, in order to avoid touching other registers excluding %rax,
> it uses asm to handle PERCPU tail_call_cnt by %rax only.
> 
> As a result, the previous tailcall way can be removed totally, including
> 
> 1. "push rax" at prologue.
> 2. load tail_call_cnt to rax before calling function.
> 3. "pop rax" before jumping to tailcallee when tailcall.
> 4. "push rax" and load tail_call_cnt to rax at trampoline.
> 
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>   arch/x86/net/bpf_jit_comp.c | 128 ++++++++++++++++++++----------------
>   1 file changed, 71 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e1390d1e331b5..3d1498a13b04c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -18,6 +18,7 @@
>   #include <asm/text-patching.h>
>   #include <asm/unwind.h>
>   #include <asm/cfi.h>
> +#include <asm/percpu.h>
>   
>   static bool all_callee_regs_used[4] = {true, true, true, true};
>   
> @@ -259,7 +260,7 @@ struct jit_context {
>   /* Number of bytes emit_patch() needs to generate instructions */
>   #define X86_PATCH_SIZE		5
>   /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET	(14 + ENDBR_INSN_SIZE)
>   
>   static void push_r12(u8 **pprog)
>   {
> @@ -389,6 +390,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>   	*pprog = prog;
>   }
>   
> +static int emit_call(u8 **pprog, void *func, void *ip);
> +static __used void bpf_tail_call_cnt_prepare(void);
> +
>   /*
>    * Emit x86-64 prologue code for BPF program.
>    * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
> @@ -396,9 +400,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>    */
>   static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>   			  bool tail_call_reachable, bool is_subprog,
> -			  bool is_exception_cb)
> +			  bool is_exception_cb, u8 *ip)
>   {
> -	u8 *prog = *pprog;
> +	u8 *prog = *pprog, *start = *pprog;
>   
>   	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
>   	/* BPF trampoline can be made to work without these nops,
> @@ -407,13 +411,10 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>   	emit_nops(&prog, X86_PATCH_SIZE);
>   	if (!ebpf_from_cbpf) {
>   		if (tail_call_reachable && !is_subprog)
> -			/* When it's the entry of the whole tailcall context,
> -			 * zeroing rax means initialising tail_call_cnt.
> -			 */
> -			EMIT2(0x31, 0xC0); /* xor eax, eax */
> +			emit_call(&prog, bpf_tail_call_cnt_prepare,
> +				  ip + (prog - start));
>   		else
> -			/* Keep the same instruction layout. */
> -			EMIT2(0x66, 0x90); /* nop2 */
> +			emit_nops(&prog, X86_PATCH_SIZE);
>   	}
>   	/* Exception callback receives FP as third parameter */
>   	if (is_exception_cb) {
> @@ -438,8 +439,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>   	/* sub rsp, rounded_stack_depth */
>   	if (stack_depth)
>   		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
> -	if (tail_call_reachable)
> -		EMIT1(0x50);         /* push rax */
>   	*pprog = prog;
>   }
>   
> @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
>   	*pprog = prog;
>   }
>   
> +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);

Hi Leon, the solution is really simplifies complexity. If I understand 
correctly, this TAIL_CALL_CNT becomes the system global wise, not the 
prog global wise, but before it was limiting the TCC of entry prog.

> +
> +static __used void bpf_tail_call_cnt_prepare(void)
> +{
> +	/* The following asm equals to
> +	 *
> +	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
> +	 *
> +	 * *tcc_ptr = 0;
> +	 *
> +	 * This asm must uses %rax only.
> +	 */
> +
> +	asm volatile (
> +	     "addq " __percpu_arg(0) ", %1\n\t"
> +	     "movl $0, (%%rax)\n\t"
> +	     :
> +	     : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
> +	);
> +}
> +
> +static __used u32 bpf_tail_call_cnt_fetch_and_inc(void)
> +{
> +	u32 tail_call_cnt;
> +
> +	/* The following asm equals to
> +	 *
> +	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
> +	 *
> +	 * (*tcc_ptr)++;
> +	 * tail_call_cnt = *tcc_ptr;
> +	 * tail_call_cnt--;
> +	 *
> +	 * This asm must uses %rax only.
> +	 */
> +
> +	asm volatile (
> +	     "addq " __percpu_arg(1) ", %2\n\t"
> +	     "incl (%%rax)\n\t"
> +	     "movl (%%rax), %0\n\t"
> +	     "decl %0\n\t"
> +	     : "=r" (tail_call_cnt)
> +	     : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
> +	);
> +
> +	return tail_call_cnt;
> +}
> +
>   /*
>    * Generate the following code:
>    *
> @@ -594,7 +641,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>   					u32 stack_depth, u8 *ip,
>   					struct jit_context *ctx)
>   {
> -	int tcc_off = -4 - round_up(stack_depth, 8);
>   	u8 *prog = *pprog, *start = *pprog;
>   	int offset;
>   
> @@ -615,17 +661,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>   	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>   	EMIT2(X86_JBE, offset);                   /* jbe out */
>   
> -	/*
> -	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
> +	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
>   	 *	goto out;
>   	 */
> -	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
> +	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip + (prog - start));
>   	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
>   
>   	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>   	EMIT2(X86_JAE, offset);                   /* jae out */
> -	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
> -	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
>   
>   	/* prog = array->ptrs[index]; */
>   	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
> @@ -647,7 +690,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>   		pop_callee_regs(&prog, callee_regs_used);
>   	}
>   
> -	EMIT1(0x58);                              /* pop rax */
>   	if (stack_depth)
>   		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
>   			    round_up(stack_depth, 8));
> @@ -675,21 +717,17 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>   				      bool *callee_regs_used, u32 stack_depth,
>   				      struct jit_context *ctx)
>   {
> -	int tcc_off = -4 - round_up(stack_depth, 8);
>   	u8 *prog = *pprog, *start = *pprog;
>   	int offset;
>   
> -	/*
> -	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
> +	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
>   	 *	goto out;
>   	 */
> -	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
> +	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip);
>   	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
>   
>   	offset = ctx->tail_call_direct_label - (prog + 2 - start);
>   	EMIT2(X86_JAE, offset);                       /* jae out */
> -	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
> -	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
>   
>   	poke->tailcall_bypass = ip + (prog - start);
>   	poke->adj_off = X86_TAIL_CALL_OFFSET;
> @@ -706,7 +744,6 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>   		pop_callee_regs(&prog, callee_regs_used);
>   	}
>   
> -	EMIT1(0x58);                                  /* pop rax */
>   	if (stack_depth)
>   		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
>   
> @@ -1133,10 +1170,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>   
>   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>   
> -/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> -#define RESTORE_TAIL_CALL_CNT(stack)				\
> -	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> -
>   static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>   		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>   {
> @@ -1160,7 +1193,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>   
>   	emit_prologue(&prog, bpf_prog->aux->stack_depth,
>   		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
> -		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
> +		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
> +		      image);
>   	/* Exception callback will clobber callee regs for its own use, and
>   	 * restore the original callee regs from main prog's stack frame.
>   	 */
> @@ -1752,17 +1786,12 @@ st:			if (is_imm8(insn->off))
>   		case BPF_JMP | BPF_CALL: {
>   			int offs;
>   
> +			if (!imm32)
> +				return -EINVAL;
> +
>   			func = (u8 *) __bpf_call_base + imm32;
> -			if (tail_call_reachable) {
> -				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
> -			} else {
> -				if (!imm32)
> -					return -EINVAL;
> -				offs = x86_call_depth_emit_accounting(&prog, func);
> -			}
> +			offs = x86_call_depth_emit_accounting(&prog, func);
> +
>   			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
>   				return -EINVAL;
>   			break;
> @@ -2550,7 +2579,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   	 *                     [ ...        ]
>   	 *                     [ stack_arg2 ]
>   	 * RBP - arg_stack_off [ stack_arg1 ]
> -	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
>   	 */
>   
>   	/* room for return value of orig_call or fentry prog */
> @@ -2622,8 +2650,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		/* sub rsp, stack_size */
>   		EMIT4(0x48, 0x83, 0xEC, stack_size);
>   	}
> -	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> -		EMIT1(0x50);		/* push rax */
>   	/* mov QWORD PTR [rbp - rbx_off], rbx */
>   	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>   
> @@ -2678,16 +2704,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   		restore_regs(m, &prog, regs_off);
>   		save_args(m, &prog, arg_stack_off, true);
>   
> -		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> -			/* Before calling the original function, restore the
> -			 * tail_call_cnt from stack to rax.
> -			 */
> -			RESTORE_TAIL_CALL_CNT(stack_size);
> -		}
> -
>   		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> -			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
> -			EMIT2(0xff, 0xd3); /* call *rbx */
> +			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> +			EMIT2(0xff, 0xd0); /* call *rax */
>   		} else {
>   			/* call original function */
>   			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
> @@ -2740,11 +2759,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>   			ret = -EINVAL;
>   			goto cleanup;
>   		}
> -	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> -		/* Before running the original function, restore the
> -		 * tail_call_cnt from stack to rax.
> -		 */
> -		RESTORE_TAIL_CALL_CNT(stack_size);
>   	}
>   
>   	/* restore return value of orig_call or fentry prog back into RAX */

