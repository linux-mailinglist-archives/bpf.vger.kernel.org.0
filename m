Return-Path: <bpf+bounces-44074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324E9BD78F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BF1F22972
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61E215F48;
	Tue,  5 Nov 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="enGuFvZg"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC191E764B
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841987; cv=none; b=kbnnQhArNNstRB6CBhgpk26Tz31i8FqVPipbdIdbh5QaCChflFyFGxclKbIfoapTmHSjJmFZuecJv+KAHPBoO8uSV/tvo64dX25hCvoZJj0REjU9ZIHzms0wsVY1I2uekHruH+mvFwqAr43grJQdbxax/xBV1uAsh3gApNQ24wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841987; c=relaxed/simple;
	bh=nGO8UXE/fPO8ZIe6/YysgMEr/3M5HgGLL3kATjFDtqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axvUGldQiIidp6/P4/puO/2guBTToMnjVw9sKNP7YN8Zq7l8W7x9aRlpJ+GRwTyUQwZneXVE6d7ti/Ro6la1KAoMColJ3plhwQ4iYb8V0S3Qpb47/XAhfrT1IX511itVnLviv3FKez0P0ZY6yABY7YRurFa2Xv2UP/Jvz92tSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enGuFvZg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730841982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkvWl+gXWFVRUzF+WhKtdAw2kYUpomMZvBF7n6HCqXw=;
	b=enGuFvZgB0Wm7+xKSMsI0LGFw0ykKTMa8GuNasn62E94bzvV79vHInMku4+eaY/3FSLWhc
	0f1CKou7o0nXhkcaga9QkzqXWcJew61IkD2hFfvOP96D5/zlT7rkJ7wXBdyDyTX/+aVvuH
	zJa3lvOD0J7IAM4BKUn04b90xHi42+k=
Date: Tue, 5 Nov 2024 13:26:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev>
 <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
 <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/5/24 12:26 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 7:37 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/4/24 6:51 PM, Alexei Starovoitov wrote:
>>> On Mon, Nov 4, 2024 at 11:38 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> In previous patch, tracing progs are enabled for private stack since
>>>> recursion checking ensures there exists no nested same bpf prog run on
>>>> the same cpu.
>>>>
>>>> But it is still possible for nested bpf subprog run on the same cpu
>>>> if the same subprog is called in both main prog and async callback,
>>>> or in different async callbacks. For example,
>>>>     main_prog
>>>>      bpf_timer_set_callback(timer, timer_cb);
>>>>      call sub1
>>>>     sub1
>>>>      ...
>>>>     time_cb
>>>>      call sub1
>>>>
>>>> In the above case, nested subprog run for sub1 is possible with one in
>>>> process context and the other in softirq context. If this is the case,
>>>> the verifier will disable private stack for this bpf prog.
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    include/linux/bpf_verifier.h |  2 ++
>>>>    kernel/bpf/verifier.c        | 42 +++++++++++++++++++++++++++++++-----
>>>>    2 files changed, 39 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index 0622c11a7e19..e921589abc72 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -669,6 +669,8 @@ struct bpf_subprog_info {
>>>>           /* true if bpf_fastcall stack region is used by functions that can't be inlined */
>>>>           bool keep_fastcall_stack: 1;
>>>>           bool use_priv_stack: 1;
>>>> +       bool visited_with_priv_stack_accum: 1;
>>>> +       bool visited_with_priv_stack: 1;
>>>>
>>>>           u8 arg_cnt;
>>>>           struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 406195c433ea..e01b3f0fd314 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -6118,8 +6118,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>>>                                           idx, subprog_depth);
>>>>                                   return -EACCES;
>>>>                           }
>>>> -                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
>>>> +                       if (subprog_depth >= BPF_PRIV_STACK_MIN_SIZE) {
>>>>                                   subprog[idx].use_priv_stack = true;
>>>> +                               subprog[idx].visited_with_priv_stack = true;
>>>> +                       }
>>>> +               } else {
>>>> +                       subprog[idx].visited_with_priv_stack = true;
>>> See suggestion for patch 3.
>>> It's cleaner to rewrite with a single visited_with_priv_stack = true; statement.
>> Ack.
>>
>>>>                   }
>>>>           }
>>>>    continue_func:
>>>> @@ -6220,10 +6224,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>>>    static int check_max_stack_depth(struct bpf_verifier_env *env)
>>>>    {
>>>>           struct bpf_subprog_info *si = env->subprog_info;
>>>> +       enum priv_stack_mode orig_priv_stack_supported;
>>>>           enum priv_stack_mode priv_stack_supported;
>>>>           int ret, subtree_depth = 0, depth_frame;
>>>>
>>>>           priv_stack_supported = bpf_enable_priv_stack(env->prog);
>>>> +       orig_priv_stack_supported = priv_stack_supported;
>>>>
>>>>           if (priv_stack_supported != NO_PRIV_STACK) {
>>>>                   for (int i = 0; i < env->subprog_cnt; i++) {
>>>> @@ -6240,13 +6246,39 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>>>                                                               priv_stack_supported);
>>>>                           if (ret < 0)
>>>>                                   return ret;
>>>> +
>>>> +                       if (priv_stack_supported != NO_PRIV_STACK) {
>>>> +                               for (int j = 0; j < env->subprog_cnt; j++) {
>>>> +                                       if (si[j].visited_with_priv_stack_accum &&
>>>> +                                           si[j].visited_with_priv_stack) {
>>>> +                                               /* si[j] is visited by both main/async subprog
>>>> +                                                * and another async subprog.
>>>> +                                                */
>>>> +                                               priv_stack_supported = NO_PRIV_STACK;
>>>> +                                               break;
>>>> +                                       }
>>>> +                                       if (!si[j].visited_with_priv_stack_accum)
>>>> +                                               si[j].visited_with_priv_stack_accum =
>>>> +                                                       si[j].visited_with_priv_stack;
>>>> +                               }
>>>> +                       }
>>>> +                       if (priv_stack_supported != NO_PRIV_STACK) {
>>>> +                               for (int j = 0; j < env->subprog_cnt; j++)
>>>> +                                       si[j].visited_with_priv_stack = false;
>>>> +                       }
>>> I cannot understand what this algorithm is doing.
>>> What is the meaning of visited_with_priv_stack_accum ?
>> The following is an example to show how the algorithm works.
>> Let us say we have prog like
>>      main_prog0  si[0]
>>        sub1      si[1]
>>        sub2      si[2]
>>      async1      si[3]
>>        sub4      si[4]
>>        sub2      si[2]
>>      async2      si[5]
>>        sub4      si[4]
>>        sub5      si[6]
>>
>>
>> Total 9 subprograms.
>>
>> after iteration 1 (main_prog0)
>>      visited_with_priv_stack_accum: si[i] = false for i = 0 ... 9
>>      visited_with_priv_stack: si[0] = si[1] = si[2] = true, others false
>>
>>      for all i, visited_with_priv_stack_accum[i] and visited_with_priv_stack[i]
>>      is false, so main_prog0 can use priv stack.
>>
>>      visited_with_priv_stack_accum: si[0] = si[1] = si[2] = true; others false
>>      visited_with_priv_stack cleared with false.
>>
>> after iteration 2 (async1)
>>      visited_with_priv_stack_accum: si[0] = si[1] = si[2] = true; others false
>>      visited_with_priv_stack: si[2] = si[3] = si[4] = true, others false
>>
>>      Here, si[2] appears in both visited_with_priv_stack_accum and
>>      visited_with_priv_stack, so async1 cannot have priv stack.
>>
>>      In my algorithm, I flipped the whole thing to no_priv_stack, which is
>>      too conservative. We should just skip async1 and continues.
>>
>>      Let us say, we say async1 not having priv stack while main_prog0 has.
>>
>>      /* the same as end of iteration 1 */
>>      visited_with_priv_stack_accum: si[0] = si[1] = si[2] = true; others false
>>      visited_with_priv_stack cleared with false.
>>
>> after iteration 3 (async2)
>>      visited_with_priv_stack_accum: si[0] = si[1] = si[2] = true; others false
>>      visited_with_priv_stack: si[4] = si[5] = si[6] = true;
>>
>>      there are no conflict, so async2 can use private stack.
>>
>>
>> If we only have one bit in bpf_subprog_info, for a async tree,
>> if marking a subprog to be true and later we found there is a conflict in
>> async tree and we need make the whole async subprogs not eligible for priv stack,
>> then it will be hard to undo previous markings.
>>
>> So visited_with_priv_stack_accum is to accumulate "true" results from
>> main_prog/async's.
> I see. I think it works, but feels complicated.
> It feels it should be possible to do without extra flags. Like
> check_max_stack_depth_subprog() will know whether it was called
> to verify async_cb or not.
> So it's just a matter of adding single 'if' to it:
> if (subprog[idx].use_priv_stack && checking_async_cb)
>     /* reset to false due to potential recursion */
>     subprog[idx].use_priv_stack = false;
>
> check_max_stack_depth() starts with i==0,
> so reachable and eligible subprogs will be marked with use_priv_stack.
> Then check_max_stack_depth_subprog() will be called again
> to verify async. If it sees the mark it's a bad case.
> what am I missing?

First I think we still want to mark some subprogs in async tree
to use private stack, right? If this is the case, then let us see
the following examle:

main_prog:
    sub1: use_priv_stack = true
    sub2" use_priv_stack = true

async: /* calling sub1 twice */
    sub1
      <=== we do
             if (subprog[idx].use_priv_stack && checking_async_cb)
                 subprog[idx].use_priv_stack = false;
    sub1
      <=== here we have subprog[idx].use_priv_stack = false;
           we could mark use_priv_stack = true again here
           since logic didn't keep track of sub1 has been
           visited before.

To solve the above issue, we need one visited bit in bpf_subprog_info.
After finishing async tree, if for any subprog,
   visited_bit && subprog[idx].use_priv_stack
is true, we can mark subprog[idx].use_priv_stack = false

So one visited bit is enough.

More complicated case is two asyncs. For example:

main_prog:
   sub1
   sub2

async1:
   sub3

async2:
   sub3

If async1/sub3 and async2/sub3 can be nested, then we will
need two visited bits as I have above.
If async1/sub3 and async2/sub3 cannot be nested, then one
visited bit should be enough, since we can traverse
async1/async2 with 'visited' marking and then compare against
main prog.

So the question would be:
   1. Is it possible that two async call backs may nest with
      each other? I actually do not know the answer.
   2. Do we want to allow subprogs in async tree to use private
      stacks?


