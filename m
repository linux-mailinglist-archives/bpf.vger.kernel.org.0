Return-Path: <bpf+bounces-40586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951B98A9A7
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF222840E9
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599B192D66;
	Mon, 30 Sep 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QADqJuYk"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B281E507
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713440; cv=none; b=DIlEbw+ijSXHTTSp2xgv8Vhg9tVbzM1/+IgbjOePvj3B6eY1dCVUOliF+jNZEqGBrKOxmKzUO9P+PrJtyuC4JoiItBpmI0ak8lCBsOuOiLwuDY/n8fMJKoQ64gXpCZlE4G4Eq2WX7N8oGEgUpDc+001hbFJ9SdxJdWcEPpYuCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713440; c=relaxed/simple;
	bh=HxwUapgWx6dlxpzg2/ixJ0Pu9RtpY2KlhcLlmbE4sBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cH5uTvLeb5qMOO5px90/I0uOij6rQahsD5FE5bOtVFALzUbtXbiW6jzBqfLmhIHiVlSRv1IzyHFdoyKI1q1qESP4ESU17F6ua/1GrimQTtMpEbbIQa29Obg+fFBcDeTdFMQ22Bpg8f6mabB+tng5XyXeeZdHecFq3KHTCuj1G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QADqJuYk; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3705be3-7923-4fd1-b938-f0a0531bcf79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727713435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GpnTAbavNJW2C+/A7ovQJWxZvjwaMCCHXe4hKQe1Gc=;
	b=QADqJuYk1qOysPfkhSQXLMo4vhwllKOXRh4qrH0/JjZpFGpRpmPf1Cp/sUcCXjZT952l3H
	nYEhTHiYtKqkWSyQ/pwTxP6GhyN6FluilQhP+elr4EwNDv9+3gcjlScsMSxVRHb58rHjhM
	I/ewN2iBOK7wU3BJJuvf3I50DCUgcaw=
Date: Mon, 30 Sep 2024 09:23:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Collect stack depth information
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234516.1770154-1-yonghong.song@linux.dev>
 <CAADnVQJ4XQLH_UDXEAARn+2vt5Ak179_vPX44D+8YewZhkkp0w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ4XQLH_UDXEAARn+2vt5Ak179_vPX44D+8YewZhkkp0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/30/24 7:42 AM, Alexei Starovoitov wrote:
> On Thu, Sep 26, 2024 at 4:45 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Private stack memory allocation is based on call subtrees. For example,
>>
>>    main_prog     // stack size 50
>>      subprog1    // stack size 50
>>        subprog2  // stack size 50
>>      subprog3    // stack size 50
>>
>> Overall allocation size should be 150 bytes (stacks from main_prog,
>> subprog1 and subprog2).
>>
>> To simplify jit, the root of subtrees is either the main prog
>> or any callback func. For example,
>>
>>    main_prog
>>      subprog1    // callback subprog10
>>        ...
>>          subprog10
>>            subprog11
> This is an odd example.
> We have MAX_CALL_FRAMES = 8
> So there cannot be more than 512 * 8 = 4k of stack.
>
>> In this case, two subtrees exist. One root is main_prog and the other
>> root is subprog10.
>>
>> The private stack is used only if
>>   - the subtree stack size is greater than 128 bytes and
>>     smaller than or equal to U16_MAX, and
> U16 limit looks odd too.
> Since we're not bumping MAX_CALL_FRAMES at the moment
> let's limit to 4k.

Make sense. Missed this. Will make the change.

>
>>   - the prog type is kprobe, tracepoint, perf_event, raw_tracepoint
>>     and tracing, and
>>   - jit supports private stack, and
>>   - no tail call in the main prog and all subprogs
>>
>> The restriction of no tail call is due to the following two reasons:
>>   - to avoid potential large memory consumption. Currently maximum tail
>>     call count is MAX_TAIL_CALL_CNT=33. Considering private stack memory
>>     allocation is per-cpu based. It will be a very large memory consumption
>>     to support current MAX_TAIL_CALL_CNT.
>>   - if the tailcall in the callback function, it is not easy to pass
>>     the tail call cnt to the callback function and the tail call cnt
>>     is needed to find proper offset for private stack.
>> So to avoid complexity, private stack does not support tail call
>> for now.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h          |  3 +-
>>   include/linux/bpf_verifier.h |  3 ++
>>   kernel/bpf/verifier.c        | 81 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 86 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 62909fbe9e48..156b9516d9f6 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1566,7 +1566,8 @@ struct bpf_prog {
>>                                  call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
>>                                  call_get_func_ip:1, /* Do we call get_func_ip() */
>>                                  tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
>> -                               sleepable:1;    /* BPF program is sleepable */
>> +                               sleepable:1,    /* BPF program is sleepable */
>> +                               pstack_eligible:1; /* Candidate for private stacks */
> I'm struggling with this abbreviation.
> pstack is just too ambiguous.
> It means 'pointer stack' in perf.
> 'man pstack' means 'print stack of a process'.
> Let's use something more concrete.
>
> How about priv_stack ?
> And use it this way in all other names.
> Instead of:
> calc_private_stack_alloc_subprog
> do:
> calc_priv_stack_alloc_subprog

I am using pstack to make name shorter but it may
not convey the information. So agree let me use priv_stack then.

>
>>          enum bpf_prog_type      type;           /* Type of BPF program */
>>          enum bpf_attach_type    expected_attach_type; /* For some prog types */
>>          u32                     len;            /* Number of filter blocks */
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4513372c5bc8..63df10f4129e 100644
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
>> +       bool pstack_eligible:1;
>>
>>          u8 arg_cnt;
>>          struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 97700e32e085..69e17cb22037 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
>>
>>   #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
>>
>> +#define BPF_PSTACK_MIN_SUBTREE_SIZE    128
>> +
>>   static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>>   static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>>   static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>> @@ -6192,6 +6194,82 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>          return 0;
>>   }
>>
>> +static int calc_private_stack_alloc_subprog(struct bpf_verifier_env *env, int idx)
>> +{
>> +       struct bpf_subprog_info *subprog = env->subprog_info;
>> +       struct bpf_insn *insn = env->prog->insnsi;
>> +       int depth = 0, frame = 0, i, subprog_end;
>> +       int ret_insn[MAX_CALL_FRAMES];
>> +       int ret_prog[MAX_CALL_FRAMES];
>> +       int ps_eligible = 0;
>> +       int orig_idx = idx;
>> +
>> +       subprog[idx].subtree_top_idx = idx;
>> +       i = subprog[idx].start;
>> +
>> +process_func:
>> +       depth += round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       if (depth > U16_MAX)
>> +               return -EACCES;
>> +
>> +       if (!ps_eligible && depth >= BPF_PSTACK_MIN_SUBTREE_SIZE) {
>> +               subprog[orig_idx].pstack_eligible = true;
>> +               ps_eligible = true;
>> +       }
>> +       subprog[orig_idx].subtree_stack_depth =
>> +               max_t(u16, subprog[orig_idx].subtree_stack_depth, depth);
>> +
>> +continue_func:
>> +       subprog_end = subprog[idx + 1].start;
>> +       for (; i < subprog_end; i++) {
>> +               int next_insn, sidx;
>> +
>> +               if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>> +                       continue;
>> +               /* remember insn and function to return to */
>> +               ret_insn[frame] = i + 1;
>> +               ret_prog[frame] = idx;
>> +
>> +               /* find the callee */
>> +               next_insn = i + insn[i].imm + 1;
>> +               sidx = find_subprog(env, next_insn);
>> +               if (subprog[sidx].is_cb) {
>> +                       if (!bpf_pseudo_call(insn + i))
>> +                               continue;
>> +               }
>> +               i = next_insn;
>> +               idx = sidx;
>> +               subprog[idx].subtree_top_idx = orig_idx;
>> +
>> +               frame++;
>> +               goto process_func;
>> +       }
>> +       if (frame == 0)
>> +               return ps_eligible;
>> +       depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
>> +       frame--;
>> +       i = ret_insn[frame];
>> +       idx = ret_prog[frame];
>> +       goto continue_func;
>> +}
> This looks very similar to check_max_stack_depth_subprog()
> Can you share the code?

Yes. It does similar except it removed some codes from original
check_max_stack_depth_subprog(). I thought this is cleaner but
agree it does duplicate the code. Let me try to share at least
some codes with check_max_stack_depth_subprog().


