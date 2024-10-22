Return-Path: <bpf+bounces-42734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 300989A96F9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49DC285B6D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D294195F17;
	Tue, 22 Oct 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Of3C9/mM"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AD131BAF
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567282; cv=none; b=UeyTIjTsvHkNItdO8TGNljgxTHcUO9HwbmeyfOqiFyx9G7aOG8Ii3pyE6RQ7Z8yXDIaYbuPUjV5aOUSxWiLvE1da5g+JqOJyysNap+P7hZ/LS6LTnsCMO4EAVmtWGSV+lmKT7M9jPjHQqzLimtNlav+G1oxmszE1Ph7aJNqbnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567282; c=relaxed/simple;
	bh=8n+zyQ45l55Of4HWXzR7WzdM5OH9QFCB98opwBzxNes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5/r+A5d1GrNZ/V/vumDrzw59vnFviTyx3tknj6DpQsNSaMlNq9kJ1XZ3xHu6UhEc1JuTLuvm3QBSvgHmMC4G93jYRjvmx0yHO3ODZNld4wZQagaO2TY6yHHPTTgzV7vNqXinLRDsbfeTEPnQlZDtKwqGVzuwZ249j1mJiwdEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Of3C9/mM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729567273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZYMyrJF6a6f8holFnevJi16cd3nxZWvB8pkbarT3wo=;
	b=Of3C9/mMFaSORaZkoRrvj6PsqEXp6MRx/PTcC4NCQszEOiXFNh9X5Tg+eU6YmdXQECcXNc
	3AMJ59ZCw+XUaaP4D7ioae8TbJBDI4bj2d/6MaBFjIOL4EMds9DDxR4cA/TLrIoa3cF5vk
	Admt3WyoYXD5BMAhT2OyDwOcgrzawWg=
Date: Mon, 21 Oct 2024 20:21:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev>
 <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 6:18 PM, Alexei Starovoitov wrote:
> On Sun, Oct 20, 2024 at 12:14 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With private stack support, each subprog can have stack with up to 512
>> bytes. The limit of 512 bytes per subprog is kept to avoid increasing
>> verifier complexity since greater than 512 bytes will cause big verifier
>> change and increase memory consumption and verification time.
>>
>> If private stack is supported, for a bpf prog, esp. when it has
>> subprogs, private stack will be allocated for the main prog
>> and for each callback subprog. For example,
>>    main_prog
>>      subprog1
>>        calling helper
>>          subprog10 (callback func)
>>            subprog11
>>      subprog2
>>        calling helper
>>          subprog10 (callback func)
>>            subprog11
>>
>> Separate private allocations for main_prog and callback_fn subprog10
>> will make things easier since the helper function uses the kernel stack.
>>
>> In this patch, some tracing programs are allowed to use private
>> stack since tracing prog may be triggered in the middle of some other
>> prog runs. Additional subprog info is also collected for later to
>> allocate private stack for main prog and each callback functions.
>>
>> Note that if any tail_call is called in the prog (including all subprogs),
>> then private stack is not used.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h          |   1 +
>>   include/linux/bpf_verifier.h |   3 ++
>>   include/linux/filter.h       |   1 +
>>   kernel/bpf/core.c            |   5 ++
>>   kernel/bpf/verifier.c        | 100 ++++++++++++++++++++++++++++++-----
>>   5 files changed, 97 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 0c216e71cec7..6ad8ace7075a 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1490,6 +1490,7 @@ struct bpf_prog_aux {
>>          bool exception_cb;
>>          bool exception_boundary;
>>          bool is_extended; /* true if extended by freplace program */
>> +       bool priv_stack_eligible;
>>          u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
>>          struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
>>          struct bpf_arena *arena;
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4513372c5bc8..bcfe868e3801 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -659,6 +659,8 @@ struct bpf_subprog_info {
>>           * are used for bpf_fastcall spills and fills.
>>           */
>>          s16 fastcall_stack_off;
>> +       u16 subtree_stack_depth;
>> +       u16 subtree_top_idx;
>>          bool has_tail_call: 1;
>>          bool tail_call_reachable: 1;
>>          bool has_ld_abs: 1;
>> @@ -668,6 +670,7 @@ struct bpf_subprog_info {
>>          bool args_cached: 1;
>>          /* true if bpf_fastcall stack region is used by functions that can't be inlined */
>>          bool keep_fastcall_stack: 1;
>> +       bool priv_stack_eligible: 1;
>>
>>          u8 arg_cnt;
>>          struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 7d7578a8eac1..3a21947f2fd4 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1119,6 +1119,7 @@ bool bpf_jit_supports_exceptions(void);
>>   bool bpf_jit_supports_ptr_xchg(void);
>>   bool bpf_jit_supports_arena(void);
>>   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>> +bool bpf_jit_supports_private_stack(void);
>>   u64 bpf_arch_uaddress_limit(void);
>>   void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>>   bool bpf_helper_changes_pkt_data(void *func);
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 233ea78f8f1b..14d9288441f2 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -3045,6 +3045,11 @@ bool __weak bpf_jit_supports_exceptions(void)
>>          return false;
>>   }
>>
>> +bool __weak bpf_jit_supports_private_stack(void)
>> +{
>> +       return false;
>> +}
>> +
>>   void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
>>   {
>>   }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f514247ba8ba..45bea4066272 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
>>
>>   #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>>
>> +#define BPF_PRIV_STACK_MIN_SUBTREE_SIZE        128
>> +
>>   static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>>   static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>>   static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>> @@ -5982,6 +5984,41 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>>                                             strict);
>>   }
>>
>> +static bool bpf_enable_private_stack(struct bpf_verifier_env *env)
>> +{
>> +       if (!bpf_jit_supports_private_stack())
>> +               return false;
>> +
>> +       switch (env->prog->type) {
>> +       case BPF_PROG_TYPE_KPROBE:
>> +       case BPF_PROG_TYPE_TRACEPOINT:
>> +       case BPF_PROG_TYPE_PERF_EVENT:
>> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
>> +               return true;
>> +       case BPF_PROG_TYPE_TRACING:
>> +               if (env->prog->expected_attach_type != BPF_TRACE_ITER)
>> +                       return true;
>> +               fallthrough;
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>> +static bool is_priv_stack_supported(struct bpf_verifier_env *env)
>> +{
>> +       struct bpf_subprog_info *si = env->subprog_info;
>> +       bool has_tail_call = false;
>> +
>> +       for (int i = 0; i < env->subprog_cnt; i++) {
>> +               if (si[i].has_tail_call) {
>> +                       has_tail_call = true;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return !has_tail_call && bpf_enable_private_stack(env);
>> +}
>> +
>>   static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>>   {
>>          if (env->prog->jit_requested)
>> @@ -5999,16 +6036,21 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>>    * Since recursion is prevented by check_cfg() this algorithm
>>    * only needs a local stack of MAX_CALL_FRAMES to remember callsites
>>    */
>> -static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>> +static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>> +                                        bool check_priv_stack, bool priv_stack_supported)
>>   {
>>          struct bpf_subprog_info *subprog = env->subprog_info;
>>          struct bpf_insn *insn = env->prog->insnsi;
>>          int depth = 0, frame = 0, i, subprog_end;
>>          bool tail_call_reachable = false;
>> +       bool priv_stack_eligible = false;
>>          int ret_insn[MAX_CALL_FRAMES];
>>          int ret_prog[MAX_CALL_FRAMES];
>> -       int j;
>> +       int j, subprog_stack_depth;
>> +       int orig_idx = idx;
>>
>> +       if (check_priv_stack)
>> +               subprog[idx].subtree_top_idx = idx;
>>          i = subprog[idx].start;
>>   process_func:
>>          /* protect against potential stack overflow that might happen when
>> @@ -6030,18 +6072,33 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>           * tailcall will unwind the current stack frame but it will not get rid
>>           * of caller's stack as shown on the example above.
>>           */
>> -       if (idx && subprog[idx].has_tail_call && depth >= 256) {
>> +       if (!check_priv_stack && idx && subprog[idx].has_tail_call && depth >= 256) {
>>                  verbose(env,
>>                          "tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
>>                          depth);
>>                  return -EACCES;
>>          }
>> -       depth += round_up_stack_depth(env, subprog[idx].stack_depth);
>> -       if (depth > MAX_BPF_STACK) {
>> +       subprog_stack_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       depth += subprog_stack_depth;
>> +       if (!check_priv_stack && !priv_stack_supported && depth > MAX_BPF_STACK) {
>>                  verbose(env, "combined stack size of %d calls is %d. Too large\n",
>>                          frame + 1, depth);
>>                  return -EACCES;
>>          }
>> +       if (check_priv_stack) {
>> +               if (subprog_stack_depth > MAX_BPF_STACK) {
>> +                       verbose(env, "stack size of subprog %d is %d. Too large\n",
>> +                               idx, subprog_stack_depth);
>> +                       return -EACCES;
>> +               }
>> +
>> +               if (!priv_stack_eligible && depth >= BPF_PRIV_STACK_MIN_SUBTREE_SIZE) {
>> +                       subprog[orig_idx].priv_stack_eligible = true;
>> +                       env->prog->aux->priv_stack_eligible = priv_stack_eligible = true;
>> +               }
>> +               subprog[orig_idx].subtree_stack_depth =
>> +                       max_t(u16, subprog[orig_idx].subtree_stack_depth, depth);
>> +       }
>>   continue_func:
>>          subprog_end = subprog[idx + 1].start;
>>          for (; i < subprog_end; i++) {
>> @@ -6078,6 +6135,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>                  next_insn = i + insn[i].imm + 1;
>>                  sidx = find_subprog(env, next_insn);
>>                  if (sidx < 0) {
>> +                       /* It is possible that callback func has been removed as dead code after
>> +                        * instruction rewrites, e.g. bpf_loop with cnt 0.
>> +                        */
>> +                       if (check_priv_stack)
>> +                               continue;
>> +
> and this extra hack only because check_max_stack_depth() will
> be called the 2nd time ?
> Why call it twice at all ?
> Record everything in the first pass.

The individual stack size may increase between check_max_stack_depth() and jit.
So we have to go through second pass to compute precise subtree (prog + subprogs)
stack size, which is needed to allocate percpu private stack.

One thing we could do is to record the (sub)prog<->subprog relations in the first
pass and right before the jit do another pass to calculate subtree stack size.
I guess that is what you suggest?

>
>>                          WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
>>                                    next_insn);
>>                          return -EFAULT;
>> @@ -6097,8 +6160,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>                  }
>>                  i = next_insn;
>>                  idx = sidx;
>> +               if (check_priv_stack)
>> +                       subprog[idx].subtree_top_idx = orig_idx;
>>
>> -               if (subprog[idx].has_tail_call)
>> +               if (!check_priv_stack && subprog[idx].has_tail_call)
>>                          tail_call_reachable = true;
>>
>>                  frame++;
>> @@ -6122,7 +6187,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>                          }
>>                          subprog[ret_prog[j]].tail_call_reachable = true;
>>                  }
>> -       if (subprog[0].tail_call_reachable)
>> +       if (!check_priv_stack && subprog[0].tail_call_reachable)
>>                  env->prog->aux->tail_call_reachable = true;
>>
>>          /* end of for() loop means the last insn of the 'subprog'
>> @@ -6137,14 +6202,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
>>          goto continue_func;
>>   }
>>
>> -static int check_max_stack_depth(struct bpf_verifier_env *env)
>> +static int check_max_stack_depth(struct bpf_verifier_env *env, bool check_priv_stack,
>> +                                bool priv_stack_supported)
>>   {
>>          struct bpf_subprog_info *si = env->subprog_info;
>> +       bool check_subprog;
>>          int ret;
>>
>>          for (int i = 0; i < env->subprog_cnt; i++) {
>> -               if (!i || si[i].is_async_cb) {
>> -                       ret = check_max_stack_depth_subprog(env, i);
>> +               check_subprog = !i || (check_priv_stack ? si[i].is_cb : si[i].is_async_cb);
> why?
> This looks very suspicious.

This is to simplify jit. For example,
    main_prog   <=== main_prog_priv_stack_ptr
      subprog1  <=== there is a helper which has a callback_fn
                <=== for example bpf_for_each_map_elem

        callback_fn
          subprog2

In callback_fn, we cannot simplify do
    r9 += stack_size_for_callback_fn
since r9 may have been clobbered between subprog1 and callback_fn.
That is why currently I allocate private_stack separately for callback_fn.

Alternatively we could do
    callback_fn_priv_stack_ptr = main_prog_priv_stack_ptr + off
where off equals to (stack size tree main_prog+subprog1).
I can do this approach too with a little more information in prog->aux.
WDYT?

>
>> +               if (check_subprog) {
>> +                       ret = check_max_stack_depth_subprog(env, i, check_priv_stack,
>> +                                                           priv_stack_supported);
>>                          if (ret < 0)
>>                                  return ret;
>>                  }
>> @@ -22303,7 +22372,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>          struct bpf_verifier_env *env;
>>          int i, len, ret = -EINVAL, err;
>>          u32 log_true_size;
>> -       bool is_priv;
>> +       bool is_priv, priv_stack_supported = false;
>>
>>          /* no program is valid */
>>          if (ARRAY_SIZE(bpf_verifier_ops) == 0)
>> @@ -22430,8 +22499,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>          if (ret == 0)
>>                  ret = remove_fastcall_spills_fills(env);
>>
>> -       if (ret == 0)
>> -               ret = check_max_stack_depth(env);
>> +       if (ret == 0) {
>> +               priv_stack_supported = is_priv_stack_supported(env);
>> +               ret = check_max_stack_depth(env, false, priv_stack_supported);
>> +       }
>>
>>          /* instruction rewrites happen after this point */
>>          if (ret == 0)
>> @@ -22465,6 +22536,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>                                                                       : false;
>>          }
>>
>> +       if (ret == 0 && priv_stack_supported)
>> +               ret = check_max_stack_depth(env, true, true);
>> +
>>          if (ret == 0)
>>                  ret = fixup_call_args(env);
>>
>> --
>> 2.43.5
>>

