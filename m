Return-Path: <bpf+bounces-43857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37D9BA9AB
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8141F216B7
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B3EC4;
	Mon,  4 Nov 2024 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ty/vpJI9"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582B17C
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730678744; cv=none; b=YK9bxPwOel4VTMbkgJZPaJc55QtlCCFAbqna/8nYba49MsFa3IdnFHIreB0QWAsUj3uEcXibJMX8m5vgpM3rLay+NT4Es90m/0XMIuYneHumen51fZw4ObTkCPA/+KdpCHvr+mNew8SF5hzfQFipEK22Cljkw0xR1cH+UGsQ3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730678744; c=relaxed/simple;
	bh=IqiLC+dh1s9ydy88DjlK2UEaZYbf05Sugk9GbzcRgUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbtNTgGcpfPMiu3KwfhFOASSUYne6plyViUEc6nTSDiclG2a2hjdeJpW6/XqonsEyUDNVIUJskinSMfxYXBb+FwZqqlhpZxqBk/RaMIkCj0pKmxvjXuYPcBKC/TlVRWysW0dOtB1+mZ6lH7Lnn1vfr+ZCreodXu0uGFpexA9hyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ty/vpJI9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9bc96f9-5c65-4b25-b719-2fcb6e16c119@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730678739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuiBT+yVeb15XkEy6lyRUcs4L6/0IqFteLd3tfXscPM=;
	b=Ty/vpJI9EZSzDxycy179qiZ6QV48jQGn8pqEK533kmZ3Lu5bikH4U+wNt42Xf+b9wMGK0d
	vwB5JiSZ5/GqfDzJ6udCznkUBKgKlbnxG7d3sJLqk+fB+d2FtcLW8h7HmR9odrXfDi0dN1
	J6jJtw191RgmHGzxja4Qxy5M+qAORuo=
Date: Sun, 3 Nov 2024 16:05:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/9] bpf: Allow private stack to have each
 subprog having stack size of 512 bytes
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
 <20241101031000.2677657-1-yonghong.song@linux.dev>
 <CAADnVQL3ZrMPjt5exuvRD7_+fLvCzn_=3A9VXy7sbSFD2f09qA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQL3ZrMPjt5exuvRD7_+fLvCzn_=3A9VXy7sbSFD2f09qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/24 12:46 PM, Alexei Starovoitov wrote:
> On Thu, Oct 31, 2024 at 8:12 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With private stack support, each subprog can have stack with up to 512
>> bytes. The limit of 512 bytes per subprog is kept to avoid increasing
>> verifier complexity since greater than 512 bytes will cause big verifier
>> change and increase memory consumption and verification time.
>>
>> If private stack is supported and certain stack size threshold is reached,
>> that subprog will have its own private stack allocated.
>>
>> In this patch, some tracing programs are allowed to use private
>> stack since tracing prog may be triggered in the middle of some other
>> prog runs. The supported tracing programs already have recursion check
>> such that if the same prog is running on the same cpu again, the nested
>> prog run will be skipped. This ensures bpf prog private stack is not
>> over-written.
>>
>> Note that if any tail_call is called in the prog (including all subprogs),
>> then private stack is not used.
>>
>> Function bpf_enable_priv_stack() return values include NO_PRIV_STACK,
>> PRIV_STACK_ADAPTIVE, PRIV_STACK_ALWAYS and negative errors. The
>> NO_PRIV_STACK represents priv stack not enable, PRIV_STACK_ADAPTIVE for
>> priv stack enabled with some conditions (e.g. stack size threshold), and
>> PRIV_STACK_ALWAYS for priv stack always enabled. The negative error
>> represents a verification failure. The PRIV_STACK_ALWAYS and negative error
>> will be used by later struct_ops progs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h          |  1 +
>>   include/linux/bpf_verifier.h |  1 +
>>   include/linux/filter.h       |  1 +
>>   kernel/bpf/core.c            |  5 +++
>>   kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++----
>>   5 files changed, 75 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index c3ba4d475174..8db3c5d7404b 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1523,6 +1523,7 @@ struct bpf_prog_aux {
>>          bool exception_cb;
>>          bool exception_boundary;
>>          bool is_extended; /* true if extended by freplace program */
>> +       bool use_priv_stack;
>>          u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
>>          struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
>>          struct bpf_arena *arena;
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4513372c5bc8..bc28ce7996ac 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -668,6 +668,7 @@ struct bpf_subprog_info {
>>          bool args_cached: 1;
>>          /* true if bpf_fastcall stack region is used by functions that can't be inlined */
>>          bool keep_fastcall_stack: 1;
>> +       bool use_priv_stack: 1;
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
>> index 89b0a980d0f9..d3f4cbab97bc 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
>>
>>   #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>>
>> +#define BPF_PRIV_STACK_MIN_SIZE                64
>> +
>>   static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>>   static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>>   static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>> @@ -6015,6 +6017,40 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>>                                             strict);
>>   }
>>
>> +#define NO_PRIV_STACK          0
>> +#define PRIV_STACK_ADAPTIVE    1
>> +#define PRIV_STACK_ALWAYS      2
> Please use enum.

will do.

>
>> +
>> +static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
>> +{
>> +       struct bpf_subprog_info *si;
>> +
>> +       if (!bpf_jit_supports_private_stack())
>> +               return NO_PRIV_STACK;
>> +
>> +       switch (env->prog->type) {
>> +       case BPF_PROG_TYPE_KPROBE:
>> +       case BPF_PROG_TYPE_TRACEPOINT:
>> +       case BPF_PROG_TYPE_PERF_EVENT:
>> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
>> +               break;
>> +       case BPF_PROG_TYPE_TRACING:
>> +               if (env->prog->expected_attach_type != BPF_TRACE_ITER)
>> +                       break;
>> +               fallthrough;
>> +       default:
>> +               return NO_PRIV_STACK;
>> +       }
> Probably worth adding:
> if (!bpf_prog_check_recur(env->prog))
>     return NO_PRIV_STACK;
>
> and remove case BPF_PROG_TYPE_TRACING entry
> with comment that bpf_prog_check_recur() checks all prog types
> that use bpf trampoline while kprobe/tp/raw_tp don't use trampoline
> hence checked explicitly.

Yes. I can do this. But to use bpf_prog_check_recur() effective,
I need to make the following change:

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..ad887c68d3e1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -889,9 +889,8 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
                 return prog->expected_attach_type != BPF_TRACE_ITER;
         case BPF_PROG_TYPE_STRUCT_OPS:
         case BPF_PROG_TYPE_LSM:
-               return false;
         default:
-               return true;
+               return false;
         }
  }

So it return true *ONLY* if the trampoline recursion detection is implemented
for specific prog types.

With that, the ultimiate bpf_enable_priv_stack() func (after the whole patch set)
will look like:

static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
{
         if (!bpf_jit_supports_private_stack())
                 return NO_PRIV_STACK;
         
         /* bpf_prog_check_recur() checks all prog types that use bpf trampoline
          * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
          * explicitly.
          */
         switch (prog->type) {
         case BPF_PROG_TYPE_KPROBE:
         case BPF_PROG_TYPE_TRACEPOINT:
         case BPF_PROG_TYPE_PERF_EVENT:
         case BPF_PROG_TYPE_RAW_TRACEPOINT:
                 return PRIV_STACK_ADAPTIVE;
         default:
                 break;
         }
         
         if (!bpf_prog_check_recur(prog))
                 return NO_PRIV_STACK;
         
         if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
                 return PRIV_STACK_ALWAYS;
         
         return PRIV_STACK_ADAPTIVE;
}


>
>> +
>> +       si = env->subprog_info;
>> +       for (int i = 0; i < env->subprog_cnt; i++) {
>> +               if (si[i].has_tail_call)
>> +                       return NO_PRIV_STACK;
>> +       }
>> +
>> +       return PRIV_STACK_ADAPTIVE;
>> +}
>> +
>>   static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>>   {
>>          if (env->prog->jit_requested)
>> @@ -6033,11 +6069,12 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
>>    * only needs a local stack of MAX_CALL_FRAMES to remember callsites
>>    */
>>   static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>> -                                        int *subtree_depth, int *depth_frame)
>> +                                        int *subtree_depth, int *depth_frame,
>> +                                        int priv_stack_supported)
>>   {
>>          struct bpf_subprog_info *subprog = env->subprog_info;
>>          struct bpf_insn *insn = env->prog->insnsi;
>> -       int depth = 0, frame = 0, i, subprog_end;
>> +       int depth = 0, frame = 0, i, subprog_end, subprog_depth;
>>          bool tail_call_reachable = false;
>>          int ret_insn[MAX_CALL_FRAMES];
>>          int ret_prog[MAX_CALL_FRAMES];
>> @@ -6070,11 +6107,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>                          depth);
>>                  return -EACCES;
>>          }
>> -       depth += round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       subprog_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       depth += subprog_depth;
>>          if (depth > MAX_BPF_STACK && !*subtree_depth) {
>>                  *subtree_depth = depth;
>>                  *depth_frame = frame + 1;
>>          }
>> +       if (priv_stack_supported != NO_PRIV_STACK) {
>> +               if (!subprog[idx].use_priv_stack) {
>> +                       if (subprog_depth > MAX_BPF_STACK) {
>> +                               verbose(env, "stack size of subprog %d is %d. Too large\n",
>> +                                       idx, subprog_depth);
>> +                               return -EACCES;
>> +                       }
>> +                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
>> +                               subprog[idx].use_priv_stack = true;
>> +               }
>> +       }
>>   continue_func:
>>          subprog_end = subprog[idx + 1].start;
>>          for (; i < subprog_end; i++) {
>> @@ -6174,19 +6223,29 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>   {
>>          struct bpf_subprog_info *si = env->subprog_info;
>>          int ret, subtree_depth = 0, depth_frame;
>> +       int priv_stack_supported;
>> +
>> +       priv_stack_supported = bpf_enable_priv_stack(env);
>> +       if (priv_stack_supported < 0)
>> +               return priv_stack_supported;
> if it was enum, the compiler would have warned that the above is meaningless.
>
>>          for (int i = 0; i < env->subprog_cnt; i++) {
>>                  if (!i || si[i].is_async_cb) {
>> -                       ret = check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_frame);
>> +                       ret = check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_frame,
>> +                                                           priv_stack_supported);
>>                          if (ret < 0)
>>                                  return ret;
>>                  }
>>          }
>> -       if (subtree_depth > MAX_BPF_STACK) {
>> -               verbose(env, "combined stack size of %d calls is %d. Too large\n",
>> -                       depth_frame, subtree_depth);
>> -               return -EACCES;
>> +       if (priv_stack_supported == NO_PRIV_STACK) {
>> +               if (subtree_depth > MAX_BPF_STACK) {
> no need for extra indent. Use:
> if (priv_stack_supported == NO_PRIV_STACK &&
>      subtree_depth > MAX_BPF_STACK) {

The reason is to accommodate future changes since there will be multiple if statements
inside 'priv_stack_supported == NO_PRIV_STACK' condition. But I agree that we do
not need extra indent here and I can do it in later patch when necessary.

>
>> +                       verbose(env, "combined stack size of %d calls is %d. Too large\n",
>> +                               depth_frame, subtree_depth);
>> +                       return -EACCES;
>> +               }
>>          }
>> +       if (si[0].use_priv_stack)
>> +               env->prog->aux->use_priv_stack = true;
>>          return 0;
>>   }
> pw-bot: cr

