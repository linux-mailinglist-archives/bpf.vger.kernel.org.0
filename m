Return-Path: <bpf+bounces-54281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D92A66DDE
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CE47AC61D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFA1F0987;
	Tue, 18 Mar 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tNvXHtG9"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFB1EF365
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285848; cv=none; b=ek6URAXFIy/PiSbmFRAqA89blzrVZc5nmfaK0kaiyTbK6X2FtnD11FVzUll78CovApdth3oXl2vYb8gFeGoSCphye/D5cLyQhSKRjiaW73aeF/sOCw3rphP12R27fKh1dq6HYbZFC/9mYHfG6wBELZsEmkkSuaAkaf3HnrsTcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285848; c=relaxed/simple;
	bh=3sKXbt2veEO0Ilp5mjKdqyBLvHn5kZShVET4djFK25Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZV4URrLG61mNhuxQ3P3iB0FqDlUVPH4rXFFw3an5Lk61De2B7hpQU2pvz271x8STjj6T/YhFRPeNnSqJD9SLvrgas+7jzAtxstS381W3c020ElzVGdB6fsnbGauCIpmIcQoCezm74W2aZ7dYIBkWhy0AfLNw1rJhE69M4T7haU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tNvXHtG9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea824188-cc71-42c7-9a02-355a82eca4c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742285843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOTHKCkOWPaPi8iEwq2RIBVx2qcCmeDRKg4tH12/WoQ=;
	b=tNvXHtG9KvIdCqTVghplks8850R/AYUKtKAps27ZTq6WtBlsEwEt26qNLt6YowjGck3f7j
	SEK/8ECYtljeaZ/UvsI3eIDQAHj9U891nrtFsFagOS7fdWGE/q27wNpXK95n1DbyVLFVmU
	9R1lpMtyDQsQ0bsJww1rDxak74a5bkk=
Date: Tue, 18 Mar 2025 08:17:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 1/4] bpf: add bpf_get_cpu_time_counter kfunc
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
 <20250317224932.1894918-2-vadfed@meta.com>
 <CAADnVQJE89E7pjGK0QzUyX-9oySH8s_YQDibR2Jwt1wP4aT2Tw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAADnVQJE89E7pjGK0QzUyX-9oySH8s_YQDibR2Jwt1wP4aT2Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 18/03/2025 00:23, Alexei Starovoitov wrote:
> On Mon, Mar 17, 2025 at 3:50 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> New kfunc to return ARCH-specific timecounter. The main reason to
>> implement this kfunc is to avoid extra overhead of benchmark
>> measurements, which are usually done by a pair of bpf_ktime_get_ns()
>> at the beginnig and at the end of the code block under benchmark.
>> When fully JITed this function doesn't implement conversion to the
>> monotonic clock and saves some CPU cycles by receiving timecounter
>> values in single-digit amount of instructions. The delta values can be
>> translated into nanoseconds using kfunc introduced in the next patch.
>> For x86 BPF JIT converts this kfunc into rdtsc ordered call. Other
>> architectures will get JIT implementation too if supported. The fallback
>> is to get CLOCK_MONOTONIC_RAW value in ns.
>>
>> JIT version of the function uses "LFENCE; RDTSC" variant because it
>> doesn't care about cookie value returned by "RDTSCP" and it doesn't want
>> to trash RCX value. LFENCE option provides the same ordering guarantee as
>> RDTSCP variant.
>>
>> The simplest use-case is added in 4th patch, where we calculate the time
>> spent by bpf_get_ns_current_pid_tgid() kfunc. More complex example is to
>> use session cookie to store timecounter value at kprobe/uprobe using
>> kprobe.session/uprobe.session, and calculate the difference at
>> kretprobe/uretprobe.
>>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c   | 47 +++++++++++++++++++++++++++++++++++
>>   arch/x86/net/bpf_jit_comp32.c | 33 ++++++++++++++++++++++++
>>   include/linux/bpf.h           |  3 +++
>>   include/linux/filter.h        |  1 +
>>   kernel/bpf/core.c             | 11 ++++++++
>>   kernel/bpf/helpers.c          |  6 +++++
>>   kernel/bpf/verifier.c         | 41 +++++++++++++++++++++++++-----
>>   7 files changed, 136 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d3491cc0898b..92cd5945d630 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -15,6 +15,7 @@
>>   #include <asm/ftrace.h>
>>   #include <asm/set_memory.h>
>>   #include <asm/nospec-branch.h>
>> +#include <asm/timer.h>
>>   #include <asm/text-patching.h>
>>   #include <asm/unwind.h>
>>   #include <asm/cfi.h>
>> @@ -2254,6 +2255,40 @@ st:                      if (is_imm8(insn->off))
>>                  case BPF_JMP | BPF_CALL: {
>>                          u8 *ip = image + addrs[i - 1];
>>
>> +                       if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +                           IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> 
> why?
> 
> It's true that JIT can be compiled in even when there is no sys_bpf,
> but why gate this?

Both bpf_get_cpu_time_counter() and bpf_cpu_time_counter_to_ns() are
defined in helpers.c which is compiled only when CONFIG_BPF_SYSCALL is
enabled. Otherwise these symbols are absent and compilation fails.
See kernel test bot report:
https://lore.kernel.org/bpf/202503131640.opwmXIvU-lkp@intel.com/

>> +                           imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +                           cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +                           using_native_sched_clock() && sched_clock_stable()) {
>> +                               /* The default implementation of this kfunc uses
>> +                                * ktime_get_raw_ns() which effectively is implemented as
>> +                                * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip
>> +                                * masking part because we assume it's not needed in BPF
>> +                                * use case (two measurements close in time).
>> +                                * Original code for rdtsc_ordered() uses sequence:
>> +                                * 'rdtsc; nop; nop; nop' to patch it into
>> +                                * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
>> +                                * JIT uses 'lfence; rdtsc' variant because BPF program
>> +                                * doesn't care about cookie provided by rdtscp in RCX.
>> +                                * Save RDX because RDTSC will use EDX:EAX to return u64
>> +                                */
>> +                               emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
>> +                               if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>> +                                       EMIT_LFENCE();
>> +                               EMIT2(0x0F, 0x31);
>> +
>> +                               /* shl RDX, 32 */
>> +                               maybe_emit_1mod(&prog, BPF_REG_3, true);
>> +                               EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
>> +                               /* or RAX, RDX */
>> +                               maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
>> +                               EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
>> +                               /* restore RDX from R11 */
>> +                               emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
>> +
>> +                               break;
>> +                       }
>> +
>>                          func = (u8 *) __bpf_call_base + imm32;
>>                          if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>>                                  LOAD_TAIL_CALL_CNT_PTR(stack_depth);
>> @@ -3865,3 +3900,15 @@ bool bpf_jit_supports_timed_may_goto(void)
>>   {
>>          return true;
>>   }
>> +
>> +/* x86-64 JIT can inline kfunc */
>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>> +{
>> +       if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>> +               return false;
> 
> This is certainly unnecessary.
> Only the verifier calls this bpf_jit_inlines_kfunc_call() helper.
 >
>> +       if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +           cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +           using_native_sched_clock() && sched_clock_stable())
> 
> The duplication of the check is ugly.
> Call this helper from an earlier bit ?
> if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>      bpf_jit_inlines_kfunc_call(imm32))
> ?

LGTM, I'll adjust it

> 
>> +               return true;
>> +       return false;
>> +}
>> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
>> index de0f9e5f9f73..7f13509c66db 100644
>> --- a/arch/x86/net/bpf_jit_comp32.c
>> +++ b/arch/x86/net/bpf_jit_comp32.c
>> @@ -16,6 +16,7 @@
>>   #include <asm/set_memory.h>
>>   #include <asm/nospec-branch.h>
>>   #include <asm/asm-prototypes.h>
>> +#include <asm/timer.h>
>>   #include <linux/bpf.h>
>>
>>   /*
>> @@ -2094,6 +2095,27 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>                          if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>                                  int err;
>>
>> +                               if (IS_ENABLED(CONFIG_BPF_SYSCALL) &&
> 
> same.
> 
>> +                                   imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +                                   cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +                                   using_native_sched_clock() && sched_clock_stable()) {
>> +                                       /* The default implementation of this kfunc uses
>> +                                        * ktime_get_raw_ns() which effectively is implemented as
>> +                                        * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip
>> +                                        * masking part because we assume it's not needed in BPF
>> +                                        * use case (two measurements close in time).
>> +                                        * Original code for rdtsc_ordered() uses sequence:
>> +                                        * 'rdtsc; nop; nop; nop' to patch it into
>> +                                        * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
>> +                                        * JIT uses 'lfence; rdtsc' variant because BPF program
>> +                                        * doesn't care about cookie provided by rdtscp in ECX.
>> +                                        */
>> +                                       if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
>> +                                               EMIT3(0x0F, 0xAE, 0xE8);
>> +                                       EMIT2(0x0F, 0x31);
>> +                                       break;
>> +                               }
>> +
>>                                  err = emit_kfunc_call(bpf_prog,
>>                                                        image + addrs[i],
>>                                                        insn, &prog);
>> @@ -2621,3 +2643,14 @@ bool bpf_jit_supports_kfunc_call(void)
>>   {
>>          return true;
>>   }
>> +
>> +bool bpf_jit_inlines_kfunc_call(s32 imm)
>> +{
>> +       if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
>> +               return false;
>> +       if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
>> +           cpu_feature_enabled(X86_FEATURE_TSC) &&
>> +           using_native_sched_clock() && sched_clock_stable())
>> +               return true;
> 
> same issue.
> 
>> +       return false;
>> +}
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 0d7b70124d81..a5e9b592d3e8 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3387,6 +3387,9 @@ void bpf_user_rnd_init_once(void);
>>   u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>>   u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>>
>> +/* Inlined kfuncs */
>> +u64 bpf_get_cpu_time_counter(void);
>> +
>>   #if defined(CONFIG_NET)
>>   bool bpf_sock_common_is_valid_access(int off, int size,
>>                                       enum bpf_access_type type,
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 590476743f7a..2fbfa1bc3f49 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1128,6 +1128,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
>>   void bpf_jit_compile(struct bpf_prog *prog);
>>   bool bpf_jit_needs_zext(void);
>>   bool bpf_jit_inlines_helper_call(s32 imm);
>> +bool bpf_jit_inlines_kfunc_call(s32 imm);
>>   bool bpf_jit_supports_subprog_tailcalls(void);
>>   bool bpf_jit_supports_percpu_insn(void);
>>   bool bpf_jit_supports_kfunc_call(void);
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 62cb9557ad3b..1d811fc39eac 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -3035,6 +3035,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
>>          return false;
>>   }
>>
>> +/* Return true if the JIT inlines the call to the kfunc corresponding to
>> + * the imm.
>> + *
>> + * The verifier will not patch the insn->imm for the call to the helper if
>> + * this returns true.
>> + */
>> +bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
>> +{
>> +       return false;
>> +}
>> +
>>   /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
>>   bool __weak bpf_jit_supports_subprog_tailcalls(void)
>>   {
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 5449756ba102..43bf35a15f78 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3193,6 +3193,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>          local_irq_restore(*flags__irq_flag);
>>   }
>>
>> +__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
>> +{
>> +       return ktime_get_raw_fast_ns();
> 
> Why 'raw' ?
> Is it faster than 'mono' ?
> This needs a comment at least.

'raw' is the closest analogue to what is implemented in JIT. The access
time is the same as for 'mono', but the slope of 'raw' is not affected
by NTP adjustments, and with stable tsc it can provide less jitter in 
short term measurements.

> 
>> +}
>> +
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3293,6 +3298,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>>   BTF_ID_FLAGS(func, bpf_local_irq_save)
>>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
>> +BTF_ID_FLAGS(func, bpf_get_cpu_time_counter, KF_FASTCALL)
>>   BTF_KFUNCS_END(common_btf_ids)
>>
>>   static const struct btf_kfunc_id_set common_kfunc_set = {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3303a3605ee8..0c4ea977973c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -17035,6 +17035,24 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>>          }
>>   }
>>
>> +/* True if fixup_kfunc_call() replaces calls to kfunc number 'imm',
>> + * replacement patch is presumed to follow bpf_fastcall contract
>> + * (see mark_fastcall_pattern_for_call() below).
>> + */
>> +static bool verifier_inlines_kfunc_call(struct bpf_verifier_env *env, s32 imm)
>> +{
>> +       const struct bpf_kfunc_desc *desc = find_kfunc_desc(env->prog, imm, 0);
>> +
>> +       if (!env->prog->jit_requested)
>> +               return false;
> 
> This is a regression.
> Why disable verifier inlining when jit is off?
> 
>> +
>> +       if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>> +           desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast])
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>   struct call_summary {
>>          u8 num_params;
>>          bool is_void;
>> @@ -17077,7 +17095,10 @@ static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call
>>                          /* error would be reported later */
>>                          return false;
>>                  cs->num_params = btf_type_vlen(meta.func_proto);
>> -               cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
>> +               cs->fastcall = meta.kfunc_flags & KF_FASTCALL &&
>> +                              (verifier_inlines_kfunc_call(env, call->imm) ||
>> +                              (meta.btf == btf_vmlinux &&
>> +                              bpf_jit_inlines_kfunc_call(call->imm)));
>>                  cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
>>                  return true;
>>          }
>> @@ -21223,6 +21244,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                              struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>>   {
>>          const struct bpf_kfunc_desc *desc;
>> +       s32 imm = insn->imm;
>>
>>          if (!insn->imm) {
>>                  verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
>> @@ -21246,7 +21268,18 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                  insn->imm = BPF_CALL_IMM(desc->addr);
>>          if (insn->off)
>>                  return 0;
>> -       if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
>> +       if (verifier_inlines_kfunc_call(env, imm)) {
>> +               if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>> +                   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> 
> I really don't like this copy paste.
> Next trivial function that inlines as r0=r1
> would need to add itself in two places for no good reason.

OK, I'll keep this part untouched

> 
> pw-bot: cr


