Return-Path: <bpf+bounces-54285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C8A66ECB
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E0C3A629D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7475205AA5;
	Tue, 18 Mar 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZajTzRvX"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286E204C28
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287507; cv=none; b=bHekvPu9Perm53JkVsrexJEMbHjiH1ZCnhEOVKZKDF1oEOu5YvRICamNggc2bAlgcrLlXqv24DM5MkrSvnWWKn0y26bIaU7zSZjyf47qAk8axVQOZFrpGnABwIi+EOvW7UVITmQEH3D3yaZEaA+l5o+MNSLRguReNrCkwkBtmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287507; c=relaxed/simple;
	bh=ihnMB9YAv6W4/ZO/4Ibu8eER5w0QFJLlpgYXcU/dQZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2HECm9SU/nMHbDM/YvmAtnGwmiRq90CPXaU6PS1Wn7I5IzgF+gP4HqStfzYvX8LrTMA9oXsFFVgyKsXoVSfYIsg1+n6XQFZnv1kC3HwcCKovr+9gHLFnWs3P+q/WofaJddfm8munu7+wQ2voXcdI9/9jJOe274JdZlRztkVYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZajTzRvX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce3747ba-e363-4fca-97fc-af539b86d723@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742287498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQQzfq1dDur7PMg3Xa9mh7tHI7KLBBDYQc+vrdNfPKE=;
	b=ZajTzRvXwr3Tg1/eDcB8nAjimXSLGXxsAr1rAmU6uADsYNgtscW9M0C6oL2z+Y9ueXs3N3
	Sa2ZqZ9mHZYoJoFlzbPYwkfiIqx+/UI3ZOrMAQxSRXpmU/BL9RKXPqdTjo9ZE+w7twTyX9
	na6LQ4AMBvRMvP5TDu/43LCKQPwZLnU=
Date: Tue, 18 Mar 2025 08:44:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/4] bpf: add bpf_cpu_time_counter_to_ns
 helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yonghong Song <yonghong.song@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250317224932.1894918-1-vadfed@meta.com>
 <20250317224932.1894918-3-vadfed@meta.com>
 <CAADnVQLYT5SV+tS2ycLteBMYOc12C=X7iHZ=RjhyVzuY=6=8Uw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQLYT5SV+tS2ycLteBMYOc12C=X7iHZ=RjhyVzuY=6=8Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 18/03/2025 00:29, Alexei Starovoitov wrote:
> On Mon, Mar 17, 2025 at 3:50 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> The new helper should be used to convert deltas of values
>> received by bpf_get_cpu_time_counter() into nanoseconds. It is not
>> designed to do full conversion of time counter values to
>> CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
>> independent values, but rather to convert the difference of 2 close
>> enough values of CPU timestamp counter into nanoseconds.
>>
>> This function is JITted into just several instructions and adds as
>> low overhead as possible and perfectly suits benchmark use-cases.
>>
>> When the kfunc is not JITted it returns the value provided as argument
>> because the kfunc in previous patch will return values in nanoseconds.
>>
>> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c   | 28 +++++++++++++++++++++++++++-
>>   arch/x86/net/bpf_jit_comp32.c | 27 ++++++++++++++++++++++++++-
>>   include/linux/bpf.h           |  1 +
>>   kernel/bpf/helpers.c          |  6 ++++++
>>   4 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 92cd5945d630..3e4d45defe2f 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/filter.h>
>>   #include <linux/if_vlan.h>
>>   #include <linux/bpf.h>
>> +#include <linux/clocksource.h>
>>   #include <linux/memory.h>
>>   #include <linux/sort.h>
>>   #include <asm/extable.h>
>> @@ -2289,6 +2290,30 @@ st:                      if (is_imm8(insn->off))
>>                                  break;
>>                          }
>>
>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +                           IS_ENABLED(CONFIG_BPF_SYSCALL) &&
>> +                           imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
>> +                           cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +                           using_native_sched_clock() && sched_clock_stable()) {
> 
> And now this condition copy pasted 3 times ?!

Yeah, I'll factor it out

>> +                               struct cyc2ns_data data;
>> +                               u32 mult, shift;
>> +
>> +                               cyc2ns_read_begin(&data);
>> +                               mult = data.cyc2ns_mul;
>> +                               shift = data.cyc2ns_shift;
>> +                               cyc2ns_read_end();
> 
> This needs a big comment explaining why this math will be stable
> after JIT and for the lifetime of the prog.

It's more or less the same comment as for the JIT of
bpf_get_cpu_time_counter(). I'll add it.


>> +                               /* imul RAX, RDI, mult */
>> +                               maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
>> +                               EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
>> +                                           mult);
>> +
>> +                               /* shr RAX, shift (which is less than 64) */
>> +                               maybe_emit_1mod(&prog, BPF_REG_0, true);
>> +                               EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
>> +
>> +                               break;
>> +                       }
>> +
>>                          func = (u8 *) __bpf_call_base + imm32;
>>                          if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>>                                  LOAD_TAIL_CALL_CNT_PTR(stack_depth);
>> @@ -3906,7 +3931,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
>>   {
>>          if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>>                  return false;
>> -       if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +       if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
>> +           imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
>>              cpu_feature_enabled(X86_FEATURE_TSC) &&
>>              using_native_sched_clock() && sched_clock_stable())
>>                  return true;
>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
>> index 7f13509c66db..9791a3fb9d69 100644
>> --- a/arch/x86/net/bpf_jit_comp32.c
>> +++ b/arch/x86/net/bpf_jit_comp32.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/netdevice.h>
>>   #include <linux/filter.h>
>>   #include <linux/if_vlan.h>
>> +#include <linux/clocksource.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/set_memory.h>
>>   #include <asm/nospec-branch.h>
>> @@ -2115,6 +2116,29 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>                                          EMIT2(0x0F, 0x31);
>>                                          break;
>>                                  }
>> +                               if (IS_ENABLED(CONFIG_BPF_SYSCALL) &&
>> +                                   imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
>> +                                   cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +                                   using_native_sched_clock() && sched_clock_stable()) {
>> +                                       struct cyc2ns_data data;
>> +                                       u32 mult, shift;
>> +
>> +                                       cyc2ns_read_begin(&data);
>> +                                       mult = data.cyc2ns_mul;
>> +                                       shift = data.cyc2ns_shift;
>> +                                       cyc2ns_read_end();
> 
> same here.
> 
>> +
>> +                                       /* move parameter to BPF_REG_0 */
>> +                                       emit_ia32_mov_r64(true, bpf2ia32[BPF_REG_0],
>> +                                                         bpf2ia32[BPF_REG_1], true, true,
>> +                                                         &prog, bpf_prog->aux);
>> +                                       /* multiply parameter by mut */
>> +                                       emit_ia32_mul_i64(bpf2ia32[BPF_REG_0],
>> +                                                         mult, true, &prog);
> 
> How did you test this?
> It's far from obvious that this will match what mul_u64_u32_shr() does.
> And on a quick look I really doubt.

Well, I can re-write it op-by-op from mul_u64_u32_shr(), but it's more
or less the same given that mult and shift are not too big, which is
common for TSC coefficients.

> 
> The trouble of adding support for 32-bit JIT doesn't seem worth it.

Do you mean it's better to drop this JIT implementation?

> 
>> +                                       /* shift parameter by shift which is less than 64 */
>> +                                       emit_ia32_rsh_i64(bpf2ia32[BPF_REG_0],
>> +                                                         shift, true, &prog);
>> +                               }
>>
>>                                  err = emit_kfunc_call(bpf_prog,
>>                                                        image + addrs[i],
>> @@ -2648,7 +2672,8 @@ bool bpf_jit_inlines_kfunc_call(s32 imm)
>>   {
>>          if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>>                  return false;
>> -       if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +       if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
>> +           imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
>>              cpu_feature_enabled(X86_FEATURE_TSC) &&
>>              using_native_sched_clock() && sched_clock_stable())
>>                  return true;
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index a5e9b592d3e8..f45a704f06e3 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3389,6 +3389,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>>
>>   /* Inlined kfuncs */
>>   u64 bpf_get_cpu_time_counter(void);
>> +u64 bpf_cpu_time_counter_to_ns(u64 counter);
>>
>>   #if defined(CONFIG_NET)
>>   bool bpf_sock_common_is_valid_access(int off, int size,
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 43bf35a15f78..e5ed5ba4b4aa 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3198,6 +3198,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>>          return ktime_get_raw_fast_ns();
>>   }
>>
>> +__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 counter)
>> +{
>> +       return counter;
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3299,6 +3304,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_local_irq_save)
>>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
>>   BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
>> +BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> --
>> 2.47.1
>>


