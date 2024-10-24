Return-Path: <bpf+bounces-43047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DB9AE5C5
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21951F24E19
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FC1D89E3;
	Thu, 24 Oct 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nmfd9A5h"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A761D5AD3
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775486; cv=none; b=GWYqKf9K3cjEWxte/sLnbhKb5vEJwJN1qx34NAygj2SXXSs2JVh17/u4R1gbN9vqS14pcgkJNRsyBzhppo25f7rRSS/JeFue6sio68VEplum20PzIaMHqroX5nxrsu/dV0R5K6kZ2AgbEvoxhNkNKZZ88uoPMrC4tZUUwvtccN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775486; c=relaxed/simple;
	bh=5iLzVqfxwFKZBC92Uq0ScN+CKGobBXBJf+PUQzUDnks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lahhgXCfDj1wu8EVLQVThcJ+VFgwa+jp2aFbr/VTA1dY4EoJOL5mwcTIX8Hl98/4O9cKovlFgGELz4VrgyUVsqXU/QsoWSgIarh9WpXHXEeF2UPaGUFwpKdR7BXlc2vzgmDqk4RVp2y040i8Eno8EyAxk95eFW71DslfFx3L2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nmfd9A5h; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d7f00e6-8fab-4274-8121-620820b99f02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729775480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XejbVp6LKjXm930WnGTtSXhdCmw2yuDagrpxGnRFwxE=;
	b=Nmfd9A5hzL7/3jk3DolyPdp+D1RxIj8V2Xm3hPx5CuZJTnfT1XMcfMDWe6/PAogBL4jFs3
	8fCBFSf532ILccuL9m/riSzS04kYhUMB/Mr6DFySMKkGjAGomK5Xn+PZ1EsMuaZzDhNVaA
	z9xFJHDEcmHMogS7sFkZWeYMQugiYuA=
Date: Thu, 24 Oct 2024 14:11:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20241023210437.2266063-1-vadfed@meta.com>
 <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/10/2024 02:39, Alexei Starovoitov wrote:
> On Wed, Oct 23, 2024 at 2:05 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>> it into rdtsc ordered call. Other architectures will get JIT
>> implementation too if supported. The fallback is to
>> __arch_get_hw_counter().
> 
> arch_get_hw_counter is a great idea.
> 
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c   | 23 +++++++++++++++++++++++
>>   arch/x86/net/bpf_jit_comp32.c | 11 +++++++++++
>>   kernel/bpf/helpers.c          |  7 +++++++
>>   kernel/bpf/verifier.c         | 11 +++++++++++
>>   4 files changed, 52 insertions(+)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa5..55595a0fa55b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2126,6 +2126,29 @@ st:                      if (is_imm8(insn->off))
>>                  case BPF_JMP | BPF_CALL: {
>>                          u8 *ip = image + addrs[i - 1];
>>
>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && !imm32) {
>> +                               if (insn->dst_reg == 1) {
>> +                                       struct cpuinfo_x86 *c = &cpu_data(get_boot_cpu_id());
>> +
>> +                                       /* Save RDX because RDTSC will use EDX:EAX to return u64 */
>> +                                       emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>> +                                       if (cpu_has(c, X86_FEATURE_LFENCE_RDTSC))
>> +                                               EMIT_LFENCE();
>> +                                       EMIT2(0x0F, 0x31);
>> +
>> +                                       /* shl RDX, 32 */
>> +                                       maybe_emit_1mod(&prog, BPF_REG_3, true);
>> +                                       EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>> +                                       /* or RAX, RDX */
>> +                                       maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>> +                                       EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>> +                                       /* restore RDX from R11 */
>> +                                       emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
> 
> This doesn't match
> static inline u64 __arch_get_hw_counter(s32 clock_mode,
>                                          const struct vdso_data *vd)
> {
>          if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
>                  return (u64)rdtsc_ordered() & S64_MAX;
> 
> - & is missing

& S64_MAX is only needed to early detect possible wrap-around of
timecounter in case of vDSO call for CLOCK_MONOTONIC_RAW/CLOCK_COARSE
which adds namespace time offset. TSC is reset during CPU reset and will
not overflow within 10 years according to "Intel 64 and IA-32
Architecture Software Developer's Manual,Vol 3B", so it doesn't really
matter if we mask the highest bit or not while accessing raw cycles
counter.

> - rdtsc vs rdtscp

rdtscp provides additional 32 bit of "signature value" atomically with
TSC value in ECX. This value is not really usable outside of domain
which set it previously while initialization. The kernel stores encoded
cpuid into IA32_TSC_AUX to provide it back to user-space application,
but at the same time ignores its value during read. The combination of
lfence and rdtsc will give us the same result (ordered read of TSC value
independent on the core) without trashing ECX value.

> but the later one is much slower (I was told).

It is slower on AMD CPUs for now, easily visible in perf traces under load.

> So maybe instead of arch_get_hw_counter() it should be modelled
> as JIT of sched_clock() ?

sched_clock() is much more complicated because it converts cycles
counter into ns, we don't actually need this conversion, let's stick
to arch_get_hw_counter().

> 
>> +
>> +                                       break;
>> +                               }
>> +                       }
>> +
>>                          func = (u8 *) __bpf_call_base + imm32;
>>                          if (tail_call_reachable) {
>>                                  LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
>> index de0f9e5f9f73..c36ff18a044b 100644
>> --- a/arch/x86/net/bpf_jit_comp32.c
>> +++ b/arch/x86/net/bpf_jit_comp32.c
>> @@ -2091,6 +2091,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>                          if (insn->src_reg == BPF_PSEUDO_CALL)
>>                                  goto notyet;
>>
>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && !imm32) {
>> +                               if (insn->dst_reg == 1) {
>> +                                       struct cpuinfo_x86 *c = &cpu_data(get_boot_cpu_id());
>> +
>> +                                       if (cpu_has(c, X86_FEATURE_LFENCE_RDTSC))
>> +                                               EMIT3(0x0F, 0xAE, 0xE8);
>> +                                       EMIT2(0x0F, 0x31);
>> +                                       break;
>> +                               }
>> +                       }
>> +
>>                          if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>                                  int err;
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 5c3fdb29c1b1..6624b2465484 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/btf_ids.h>
>>   #include <linux/bpf_mem_alloc.h>
>>   #include <linux/kasan.h>
>> +#include <asm/vdso/gettimeofday.h>
>>
>>   #include "../../lib/kstrtox.h"
>>
>> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
>>          return ret + 1;
>>   }
>>
>> +__bpf_kfunc int bpf_get_hw_counter(void)
>> +{
>> +       return __arch_get_hw_counter(1, NULL);
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3112,6 +3118,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>> +BTF_ID_FLAGS(func, bpf_get_hw_counter, KF_FASTCALL)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f514247ba8ba..5f0e4f91ce48 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11260,6 +11260,7 @@ enum special_kfunc_type {
>>          KF_bpf_iter_css_task_new,
>>          KF_bpf_session_cookie,
>>          KF_bpf_get_kmem_cache,
>> +       KF_bpf_get_hw_counter,
>>   };
>>
>>   BTF_SET_START(special_kfunc_set)
>> @@ -11326,6 +11327,7 @@ BTF_ID(func, bpf_session_cookie)
>>   BTF_ID_UNUSED
>>   #endif
>>   BTF_ID(func, bpf_get_kmem_cache)
>> +BTF_ID(func, bpf_get_hw_counter)
>>
>>   static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>>   {
>> @@ -20396,6 +20398,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                     desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>>                  insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>>                  *cnt = 1;
>> +       } else if (IS_ENABLED(CONFIG_X86) &&
> 
> It's better to introduce bpf_jit_inlines_kfunc_call()
> similar to bpf_jit_inlines_helper_call().

Yep, I thought about introducing it while adding more architectures, but
can do it from the beginning.

> 
>> +                  desc->func_id == special_kfunc_list[KF_bpf_get_hw_counter]) {
>> +               insn->imm = 0;
>> +               insn->code = BPF_JMP | BPF_CALL;
>> +               insn->src_reg = BPF_PSEUDO_KFUNC_CALL;
>> +               insn->dst_reg = 1; /* Implement enum for inlined fast calls */
> 
> Yes. Pls do it cleanly from the start.
> 
> Why rewrite though?
> Can JIT match the addr of bpf_get_hw_counter ?
> And no need to rewrite call insn ?

I was thinking about this way, just wasn't able to find easy examples of
matching function addresses in jit. I'll try to make it but it may add
some extra functions to the jit.


