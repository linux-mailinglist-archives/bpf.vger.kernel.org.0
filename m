Return-Path: <bpf+bounces-45054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9C9D06A5
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FEB1F21FE8
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818851DDA34;
	Sun, 17 Nov 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzXXHMYB"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744DDDD2
	for <bpf@vger.kernel.org>; Sun, 17 Nov 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731880738; cv=none; b=L+tTIvZlNUWu3809jiZmT7MlutGMVjET9HioMXn6miFQ5ACfihpKg0GHmg+Nz9HngNS9f9a/X8YLRr4eRIcrHKivAw7bGP4jCJA3o9z+7sOAxmQNW+8Id9tvpzh1RNsCpoagMQgzX/7hZSwmYY1D/cCsnl/Y+yUtQ4CbmQXoABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731880738; c=relaxed/simple;
	bh=cszhJIUYl3vFP7bDRlL9dEojBN0hajm8C03/2p4j8D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7/hm25ys3423HczkYvS/YHVh7u/sqUPwtYIYw76Tck3kZ3xlpispBeudeSQR/J6i3MAEeT197OMaejKsq1ARPAzZKQuA5Yn9qOBw9nkt0XmZljKDQMpwlzRznocvJQUG9tht7EwMzOGmDjWDTbK/h5f/W+dVcL7XT36ec1NuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzXXHMYB; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f3ee70a-c930-4842-9bb2-96bf982ad70e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731880733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaBl7sFEK0q9CQ1P84vYgy6eSIO+RQniyziMunai/Cc=;
	b=hzXXHMYBWJHTJgOd8jAkQ9zIZ/NaNn8di2ift6XtKtnjoqup5x0Wr/j0PvlN9LwBgs4KCr
	l01BfPy9zwVM0vzzDi+4Bt8yL7ACtXdeZ/DC4EebefnBiI10bUW6qdR9esHTE5u4E7q1CU
	gjg6j2C8yZWAuUVBmejldNkA91IeVJ0=
Date: Sun, 17 Nov 2024 13:58:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/4] bpf: add bpf_get_cpu_cycles kfunc
Content-Language: en-GB
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: x86@kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, Mykola Lysenko <mykolal@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Thomas Gleixner <tglx@linutronix.de>
References: <20241115194841.2108634-1-vadfed@meta.com>
 <20241115194841.2108634-2-vadfed@meta.com>
 <c6eb8ab6-2db4-40dc-9ce5-3f0985c93f58@linux.dev>
 <cd72d9eb-bdcd-4316-9987-9fd412151a82@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cd72d9eb-bdcd-4316-9987-9fd412151a82@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/17/24 10:11 AM, Vadim Fedorenko wrote:
> On 15/11/2024 21:54, Yonghong Song wrote:
>>
>>
>> On 11/15/24 11:48 AM, Vadim Fedorenko wrote:
>>> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
>>> it into rdtsc ordered call. Other architectures will get JIT
>>> implementation too if supported. The fallback is to
>>> __arch_get_hw_counter().
>>>
>>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>
>> LGTM with a small nit below.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> @Yonghong The changes to align to vdso call bring this patch to the
> state when the kernel fails to compile with CONFIG_PARAVIRT_CLOCK or
> CONFIG_HYPERV_TIMER enabled. This happens because on x86 there is
> special way to grab cpu cycle counter in PARAVIRT mode. The paravirt
> memory structure is hidden for kernel and linked for vDSO only using
> arch/x86/entry/vdso/vdso-layout.lds.S. But in anycase both
> vread_pvclock() and vread_hvclock() end up doing rdtsc_ordered().
> I believe we can have constant clock_mode for x86 equal to
> VDSO_CLOCKMODE_TSC given we have JIT for x86 ready.

What you described is correct. For x86, we have

static inline u64 __arch_get_hw_counter(s32 clock_mode,
                                         const struct vdso_data *vd)
{
         if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
                 return (u64)rdtsc_ordered() & S64_MAX;
         /*
          * For any memory-mapped vclock type, we need to make sure that gcc
          * doesn't cleverly hoist a load before the mode check.  Otherwise we
          * might end up touching the memory-mapped page even if the vclock in
          * question isn't enabled, which will segfault.  Hence the barriers.
          */
#ifdef CONFIG_PARAVIRT_CLOCK
         if (clock_mode == VDSO_CLOCKMODE_PVCLOCK) {
                 barrier();
                 return vread_pvclock();
         }
#endif
#ifdef CONFIG_HYPERV_TIMER
         if (clock_mode == VDSO_CLOCKMODE_HVCLOCK) {
                 barrier();
                 return vread_hvclock();
         }
#endif
         return U64_MAX;
}

Even if CONFIG_PARAVIRT_CLOCK and CONFIG_HYPERV_TIMER are enabled,
if clock_mode is constant 1 (== VDSO_CLOCKMODE_TSC), dead code
elimination will happen to remove vread_pvclock() and vread_hvclock()
so we are fine.

And actually the above PARAVIRT_CLOCK and HYPERV_TIMER are x86 specific.
Other arch's do not have such things.

s390 has the following implementation:

static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_data *vd)
{
         u64 adj, now;

         now = get_tod_clock();
         adj = vd->arch_data.tod_steering_end - now;
         if (unlikely((s64) adj > 0))
                 now += (vd->arch_data.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
         return now;
}

So I think __arch_get_hw_counter(1, vd) probably works.
But you need to double check that.

This makes us to do __arch_get_hw_counter(const_clock_mode, vd).
As you mentioned earlier, const_clock_mode = 1 is working for all
architectures. But please add a comment for that.

>
> Another way is to switch to use get_cycles() which is also defined for
> all architectures. But that will bring up another discussion whether we
> should use rdtsc_ordered in JIT, because on x86 get_cycles() ends up
> calling rdtsc() which has no LFENCE in assembly. If I remember correctly
> there was a question of maybe using simple rdtsc() in this patchset as
> ordered version might be slow on modern CPUs. We still can use shift
> and mult values for cycles2ns helper because we know that CS_RAW uses
> the same cpu cycles counter.

I think some previous discussion favors rdtsc_ordered to ensure counting
results are precise. So let us go with rdtsc_ordered.

One more thing, maybe we can replace asm/vdso/vsyscall.h to vdso/vsyscall.h
(from kernel/time/vsyscall.c)?


diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e89eff53c340..fb93f003ecf8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,7 +25,7 @@
  #include <linux/kasan.h>
  #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
  #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
+#include <vdso/vsyscall.h>
  #endif
  
  #include "../../lib/kstrtox.h"

>
> I'm up for any option, but let's just agree on how to proceed.
>
> Thanks.
>>
>>> ---
>>> v5 -> v6:
>>> * add comment about dropping S64_MAX manipulation in jitted
>>>    implementation of rdtsc_oredered (Alexey)
>>> * add comment about using 'lfence;rdtsc' variant (Alexey)
>>> * change the check in fixup_kfunc_call() (Eduard)
>>> * make __arch_get_hw_counter() call more aligned with vDSO
>>>    implementation (Yonghong)
>>> v4 -> v5:
>>> * use if instead of ifdef with IS_ENABLED
>>> v3 -> v4:
>>> * change name of the helper to bpf_get_cpu_cycles (Andrii)
>>> * Hide the helper behind CONFIG_GENERIC_GETTIMEOFDAY to avoid exposing
>>>    it on architectures which do not have vDSO functions and data
>>> * reduce the scope of check of inlined functions in verifier to only 2,
>>>    which are actually inlined.
>>> v2 -> v3:
>>> * change name of the helper to bpf_get_cpu_cycles_counter to explicitly
>>>    mention what counter it provides (Andrii)
>>> * move kfunc definition to bpf.h to use it in JIT.
>>> * introduce another kfunc to convert cycles into nanoseconds as more
>>>    meaningful time units for generic tracing use case (Andrii)
>>> v1 -> v2:
>>> * Fix incorrect function return value type to u64
>>> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>>>    mark_fastcall_pattern_for_call() to avoid clobbering in case of
>>>    running programs with no JIT (Eduard)
>>> * Avoid rewriting instruction and check function pointer directly
>>>    in JIT (Alexei)
>>> * Change includes to fix compile issues on non x86 architectures
>>> ---
>>>   arch/x86/net/bpf_jit_comp.c   | 39 +++++++++++++++++++++++++++++++++
>>>   arch/x86/net/bpf_jit_comp32.c | 14 ++++++++++++
>>>   include/linux/bpf.h           |  5 +++++
>>>   include/linux/filter.h        |  1 +
>>>   kernel/bpf/core.c             | 11 ++++++++++
>>>   kernel/bpf/helpers.c          | 21 ++++++++++++++++++
>>>   kernel/bpf/verifier.c         | 41 
>>> ++++++++++++++++++++++++++++++-----
>>>   7 files changed, 126 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index a43fc5af973d..107bd921f104 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -2185,6 +2185,37 @@ st:            if (is_imm8(insn->off))
>>>           case BPF_JMP | BPF_CALL: {
>>>               u8 *ip = image + addrs[i - 1];
>>> +            if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>>> +                imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>> +                /* The default implementation of this kfunc uses
>>> +                 * __arch_get_hw_counter() which is implemented as
>>> +                 * `(u64)rdtsc_ordered() & S64_MAX`. We skip masking
>>> +                 * part because we assume it's not needed in BPF
>>> +                 * use case (two measurements close in time).
>>> +                 * Original code for rdtsc_ordered() uses sequence:
>>> +                 * 'rdtsc; nop; nop; nop' to patch it into
>>> +                 * 'lfence; rdtsc' or 'rdtscp' depending on CPU 
>>> features.
>>> +                 * JIT uses 'lfence; rdtsc' variant because BPF 
>>> program
>>> +                 * doesn't care about cookie provided by rdtsp in RCX.
>>
>> rdtsp -> tdtscp?
>>
>>> +                 * Save RDX because RDTSC will use EDX:EAX to 
>>> return u64
>>> +                 */
>>> +                emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>>> +                if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>>> +                    EMIT_LFENCE();
>>> +                EMIT2(0x0F, 0x31);
>>> +
>>> +                /* shl RDX, 32 */
>>> +                maybe_emit_1mod(&prog, BPF_REG_3, true);
>>> +                EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>>> +                /* or RAX, RDX */
>>> +                maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>>> +                EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>>> +                /* restore RDX from R11 */
>>> +                emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
>>> +
>>> +                break;
>>> +            }
>>> +
>>>               func = (u8 *) __bpf_call_base + imm32;
>>>               if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>>>                   LOAD_TAIL_CALL_CNT_PTR(stack_depth);
>>> @@ -3791,3 +3822,11 @@ u64 bpf_arch_uaddress_limit(void)
>>>   {
>>>       return 0;
>>>   }
>>> +
>>> +/* x86-64 JIT can inline kfunc */
>>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>>> +{
>>> +    if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
>>> +        return true;
>>> +    return false;
>>> +}
>>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/ 
>>> bpf_jit_comp32.c
>>> index de0f9e5f9f73..e6097a371b69 100644
>>> --- a/arch/x86/net/bpf_jit_comp32.c
>>> +++ b/arch/x86/net/bpf_jit_comp32.c
>>> @@ -2094,6 +2094,13 @@ static int do_jit(struct bpf_prog *bpf_prog, 
>>> int *addrs, u8 *image,
>>>               if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>                   int err;
>>> +                if (imm32 == BPF_CALL_IMM(bpf_get_cpu_cycles)) {
>>> +                    if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>>> +                        EMIT3(0x0F, 0xAE, 0xE8);
>>> +                    EMIT2(0x0F, 0x31);
>>> +                    break;
>>> +                }
>>> +
>>>                   err = emit_kfunc_call(bpf_prog,
>>>                                 image + addrs[i],
>>>                                 insn, &prog);
>>> @@ -2621,3 +2628,10 @@ bool bpf_jit_supports_kfunc_call(void)
>>>   {
>>>       return true;
>>>   }
>>> +
>>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>>> +{
>>> +    if (imm == BPF_CALL_IMM(bpf_get_cpu_cycles))
>>> +        return true;
>>> +    return false;
>>> +}
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 3ace0d6227e3..43a5207a1591 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -3333,6 +3333,11 @@ void bpf_user_rnd_init_once(void);
>>>   u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>>>   u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>>> +/* Inlined kfuncs */
>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>> +u64 bpf_get_cpu_cycles(void);
>>> +#endif
>>> +
>>>   #if defined(CONFIG_NET)
>>>   bool bpf_sock_common_is_valid_access(int off, int size,
>>>                        enum bpf_access_type type,
>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>> index 3a21947f2fd4..9cf57233874f 100644
>>> --- a/include/linux/filter.h
>>> +++ b/include/linux/filter.h
>>> @@ -1111,6 +1111,7 @@ struct bpf_prog *bpf_int_jit_compile(struct 
>>> bpf_prog *prog);
>>>   void bpf_jit_compile(struct bpf_prog *prog);
>>>   bool bpf_jit_needs_zext(void);
>>>   bool bpf_jit_inlines_helper_call(s32 imm);
>>> +bool bpf_jit_inlines_kfunc_call(s32 imm);
>>>   bool bpf_jit_supports_subprog_tailcalls(void);
>>>   bool bpf_jit_supports_percpu_insn(void);
>>>   bool bpf_jit_supports_kfunc_call(void);
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 14d9288441f2..daa3ab458c8a 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -2965,6 +2965,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
>>>       return false;
>>>   }
>>> +/* Return true if the JIT inlines the call to the kfunc 
>>> corresponding to
>>> + * the imm.
>>> + *
>>> + * The verifier will not patch the insn->imm for the call to the 
>>> helper if
>>> + * this returns true.
>>> + */
>>> +bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>>   /* Return TRUE if the JIT backend supports mixing bpf2bpf and 
>>> tailcalls. */
>>>   bool __weak bpf_jit_supports_subprog_tailcalls(void)
>>>   {
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 751c150f9e1c..12d40537e57b 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -23,6 +23,10 @@
>>>   #include <linux/btf_ids.h>
>>>   #include <linux/bpf_mem_alloc.h>
>>>   #include <linux/kasan.h>
>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>> +#include <vdso/datapage.h>
>>> +#include <asm/vdso/vsyscall.h>
>>> +#endif
>>>   #include "../../lib/kstrtox.h"
>>> @@ -3057,6 +3061,20 @@ __bpf_kfunc int bpf_copy_from_user_str(void 
>>> *dst, u32 dst__sz, const void __user
>>>       return ret + 1;
>>>   }
>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>> +__bpf_kfunc u64 bpf_get_cpu_cycles(void)
>>> +{
>>> +    const struct vdso_data *vd = __arch_get_k_vdso_data();
>>> +
>>> +    vd = &vd[CS_RAW];
>>> +
>>> +    /* CS_RAW clock_mode translates to VDSO_CLOCKMODE_TSC on x86 and
>>> +     * to VDSO_CLOCKMODE_ARCHTIMER on aarch64/risc-v.
>>> +     */
>>> +    return __arch_get_hw_counter(vd->clock_mode, vd);
>>> +}
>>> +#endif
>>> +
>>>   __bpf_kfunc_end_defs();
>>>   BTF_KFUNCS_START(generic_btf_ids)
>>> @@ -3149,6 +3167,9 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache)
>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | 
>>> KF_SLEEPABLE)
>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | 
>>> KF_RET_NULL | KF_SLEEPABLE)
>>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | 
>>> KF_SLEEPABLE)
>>> +#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
>>> +BTF_ID_FLAGS(func, bpf_get_cpu_cycles, KF_FASTCALL)
>>> +#endif
>>>   BTF_KFUNCS_END(common_btf_ids)
>>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> [...]
>


