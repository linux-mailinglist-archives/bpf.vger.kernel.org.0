Return-Path: <bpf+bounces-43860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E79BAA01
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 01:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A99280D71
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C486AA1;
	Mon,  4 Nov 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1wPZI56"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B00524F
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730680524; cv=none; b=k1R0IiuJ8KPZpx3qtKUg4Aa3Pr/ZilOvannbxeVZVPjJE7+FulptHFYblWqn4m5KxQ0eaxpeZ3luRqAiTsmVjnQza1+sVAwHBVad/QhURfGy4yHmHSD90V6TkQC3/AV0Oa5wzG7Y0b8J/VYH7X+mIYc+qveD0XiHaOt5ctMS71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730680524; c=relaxed/simple;
	bh=4DCw4cCvLg44CzzSRfs6bJBP+YxnarbL4hO+hcJKcKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaJChRciEYuOKKryPTJVTaz4NU6EPua2lm3rCxQvljRBJ7ZiPEpjsIeFlh8kLmM9ZyaTzolk6v++vcQE9ahKLmLUUD1NoQ9dY48FYFjPu1HsPKRyYjHU/FKj+DgYC3ngPPrmNlD/ezJaq/8wyadkfA3hPOM7Az26AV5yMriE9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1wPZI56; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38e53f06-0ea3-46f8-8875-52ff5ba6c0ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730680519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQF9xKnpJux9P9+pCetXdpGd2uq6DTyge/wgcDDmc58=;
	b=M1wPZI56yKWnc2epcVq87iDPjW8gb9L1w78y37ABWrfKdMb20Yij9B9Ul6FwxJJddwEdZT
	nWgnBDzvlRpwhKv+LKUEPY4kRT3z6t7bHqzSU78HEm/zLaCXsEXnXN1yAvhTYCgtwIqCmz
	rMgJSqDBQnPxTpwpd5Kwy2YW6sN8Ntw=
Date: Sun, 3 Nov 2024 16:35:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 8/9] bpf: Support private stack for struct_ops
 progs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
 <20241101031032.2680930-1-yonghong.song@linux.dev>
 <CAADnVQKFG0x=3s=rK2uv19svnBdsegwsjcv7QESet-L8g3e7YA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKFG0x=3s=rK2uv19svnBdsegwsjcv7QESet-L8g3e7YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/1/24 1:13 PM, Alexei Starovoitov wrote:
> On Thu, Oct 31, 2024 at 8:10 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> For struct_ops progs, whether a particular prog will use private stack
>> or not (prog->aux->use_priv_stack) will be set before actual insn-level
>> verification for that prog. One particular implementation is to
>> piggyback on struct_ops->check_member(). The next patch will have an
>> example for this. The struct_ops->check_member() will set
>> prog->aux->use_priv_stack to be true which enables private stack
>> usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.
>>
>> If use_priv_stack is true for a particular struct_ops prog, bpf
>> trampoline will need to do recursion checks (one level at this point)
>> to avoid stack overwrite. A field (recursion_skipped()) is added to
>> bpf_prog_aux structure such that if bpf_prog->aux->recursion_skipped
>> is set by the struct_ops subsystem, the function will be called
>> to terminate the prog run, collect related info, etc.
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h          |  1 +
>>   include/linux/bpf_verifier.h |  1 +
>>   kernel/bpf/trampoline.c      |  4 ++++
>>   kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++++++----
>>   4 files changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8a3ea7440a4a..7a34108c6974 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1528,6 +1528,7 @@ struct bpf_prog_aux {
>>          u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
>>          struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
>>          struct bpf_arena *arena;
>> +       void (*recursion_skipped)(struct bpf_prog *prog); /* callback if recursion is skipped */
> The name doesn't fit.
> The recursion wasn't skipped.
> It's the execution of the program that was skipped.
> 'recursion_detected' or 'recursion_disallowed' would be a better name.

I will use recursion_detected().

>
>>          /* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>>          const struct btf_type *attach_func_proto;
>>          /* function name for valid attach_btf_id */
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index bc28ce7996ac..ff0fba935f89 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -889,6 +889,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>>          case BPF_PROG_TYPE_TRACING:
>>                  return prog->expected_attach_type != BPF_TRACE_ITER;
>>          case BPF_PROG_TYPE_STRUCT_OPS:
>> +               return prog->aux->use_priv_stack;
>>          case BPF_PROG_TYPE_LSM:
>>                  return false;
>>          default:
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index 9f36c049f4c2..a84e60efbf89 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -899,6 +899,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
>>
>>          if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>>                  bpf_prog_inc_misses_counter(prog);
>> +               if (prog->aux->recursion_skipped)
>> +                       prog->aux->recursion_skipped(prog);
>>                  return 0;
>>          }
>>          return bpf_prog_start_time();
>> @@ -975,6 +977,8 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
>>
>>          if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>>                  bpf_prog_inc_misses_counter(prog);
>> +               if (prog->aux->recursion_skipped)
>> +                       prog->aux->recursion_skipped(prog);
>>                  return 0;
>>          }
>>          return bpf_prog_start_time();
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 30e74db6a85f..865191c5d21b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6023,17 +6023,31 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
>>
>>   static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
>>   {
>> +       bool force_priv_stack = env->prog->aux->use_priv_stack;
>>          struct bpf_subprog_info *si;
>> +       int ret;
>> +
>> +       if (!bpf_jit_supports_private_stack()) {
>> +               if (force_priv_stack) {
>> +                       verbose(env, "Private stack not supported by jit\n");
>> +                       return -EACCES;
>> +               }
> This logic would fit better in the patch 2.
> Less code churn and the whole approach is easier to understand.
>
> I don't like this inband signaling.
> Now I see why you had that weird <0 check in patch 2 :(
> This is ugly.
> May be it should be a separate bool request_priv_stack:1
> that struct_ops callback will set and it will clean up
> this logic.

I can add this logic to function check_struct_ops_btf_id(),
which is struct_ops preparation for verification. This
will ensure in bpf_enable_priv_stack(), if
!bpf_jit_supports_private_stack(), it is guaranteed to
return NO_PRIV_STACK.

>
>> -       if (!bpf_jit_supports_private_stack())
>>                  return NO_PRIV_STACK;
>> +       }
>>
>> +       ret = PRIV_STACK_ADAPTIVE;
>>          switch (env->prog->type) {
>>          case BPF_PROG_TYPE_KPROBE:
>>          case BPF_PROG_TYPE_TRACEPOINT:
>>          case BPF_PROG_TYPE_PERF_EVENT:
>>          case BPF_PROG_TYPE_RAW_TRACEPOINT:
>>                  break;
>> +       case BPF_PROG_TYPE_STRUCT_OPS:
>> +               if (!force_priv_stack)
>> +                       return NO_PRIV_STACK;
>> +               ret = PRIV_STACK_ALWAYS;
>> +               break;
>>          case BPF_PROG_TYPE_TRACING:
>>                  if (env->prog->expected_attach_type != BPF_TRACE_ITER)
>>                          break;
>> @@ -6044,11 +6058,18 @@ static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
>>
>>          si = env->subprog_info;
>>          for (int i = 0; i < env->subprog_cnt; i++) {
>> -               if (si[i].has_tail_call)
>> +               if (si[i].has_tail_call) {
>> +                       if (ret == PRIV_STACK_ALWAYS) {
>> +                               verbose(env,
>> +                                       "Private stack not supported due to tail call presence\n");
>> +                               return -EACCES;
>> +                       }
>> +
>>                          return NO_PRIV_STACK;
>> +               }
>>          }
>>
>> -       return PRIV_STACK_ADAPTIVE;
>> +       return ret;
>>   }
>>
[...]


