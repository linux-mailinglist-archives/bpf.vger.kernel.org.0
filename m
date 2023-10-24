Return-Path: <bpf+bounces-13137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5857D564D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BE51F228CA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F937169;
	Tue, 24 Oct 2023 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5n/qwIw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B53715D
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:28:22 +0000 (UTC)
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AED170C
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 08:28:16 -0700 (PDT)
Message-ID: <08210eba-d1e4-49b7-b058-9eb317a7153a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698161290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kd227r0f0qnYCQNPI0ZU1VYBgrDImayIiLMtZA00ea0=;
	b=J5n/qwIw08H8vsBRugekgJXm+vDXfNhLlAn3KJni/kT/8Nkj3/9ilUTCboFuy5mG+eAYwJ
	dw1HLEXdnd3hoW2LUoBlCTr0wjBuFPxcZQzRnwjHbtWg1DbP8zdcewJGNAU5svGKlLua8W
	vmfLq4h8+B9PJPMta7iic67GMOwBo+M=
Date: Tue, 24 Oct 2023 08:28:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231024024240.42790-1-zhouchuyi@bytedance.com>
 <20231024024240.42790-2-zhouchuyi@bytedance.com>
 <CAADnVQJRhyn4Xpd5f0_iJp7F2iZrs_qp+E0DZPNc3aKc0SGzCQ@mail.gmail.com>
 <1f4f9308-26b4-4cc5-99eb-88851fe2f3f9@bytedance.com>
 <c923dba3-f638-410f-ae65-0cfa1962a6f2@linux.dev>
 <efa59538-cfc9-404c-9ecf-d04e49a4b82e@bytedance.com>
 <efa935f1-251c-4f4c-9f67-7d352514b611@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <efa935f1-251c-4f4c-9f67-7d352514b611@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/24/23 4:43 AM, Chuyi Zhou wrote:
>
>
> 在 2023/10/24 14:23, Chuyi Zhou 写道:
>> Hello,
>>
>> 在 2023/10/24 14:08, Yonghong Song 写道:
>>>
>>> On 10/23/23 10:52 PM, Chuyi Zhou wrote:
>>>> Hello,
>>>>
>>>> 在 2023/10/24 12:57, Alexei Starovoitov 写道:
>>>>> On Mon, Oct 23, 2023 at 7:42 PM Chuyi Zhou 
>>>>> <zhouchuyi@bytedance.com> wrote:
>>>>>>
>>>>>> The newly added open-coded css_task iter would try to hold the 
>>>>>> global
>>>>>> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be 
>>>>>> careful in
>>>>>> where it allows to use this iter. The mainly concern is dead 
>>>>>> locking on
>>>>>> css_set_lock. check_css_task_iter_allowlist() in verifier 
>>>>>> enforced css_task
>>>>>> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>>>>>>
>>>>>> This patch relax the allowlist for css_task iter. Any lsm and any 
>>>>>> iter
>>>>>> (even non-sleepable) and any sleepable are safe since they would 
>>>>>> not hold
>>>>>> the css_set_lock before entering BPF progs context.
>>>>>>
>>>>>> This patch also fixes the misused BPF_TRACE_ITER in
>>>>>> check_css_task_iter_allowlist which compared bpf_prog_type with
>>>>>> bpf_attach_type.
>>>>>>
>>>>>> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded 
>>>>>> iterator kfuncs")
>>>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>>>> ---
>>>>>>   kernel/bpf/verifier.c                         | 21 
>>>>>> ++++++++++++-------
>>>>>>   .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>>>>>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>>> index e9bc5d4a25a1..9f209adc4ccb 100644
>>>>>> --- a/kernel/bpf/verifier.c
>>>>>> +++ b/kernel/bpf/verifier.c
>>>>>> @@ -11088,18 +11088,23 @@ static int 
>>>>>> process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>>>>> &meta->arg_rbtree_root.field);
>>>>>>   }
>>>>>>
>>>>>> +/*
>>>>>> + * css_task iter allowlist is needed to avoid dead locking on 
>>>>>> css_set_lock.
>>>>>> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
>>>>>> + * Any sleepable progs are also safe since 
>>>>>> bpf_check_attach_target() enforce
>>>>>> + * them can only be attached to some specific hook points.
>>>>>> + */
>>>>>>   static bool check_css_task_iter_allowlist(struct 
>>>>>> bpf_verifier_env *env)
>>>>>>   {
>>>>>>          enum bpf_prog_type prog_type = 
>>>>>> resolve_prog_type(env->prog);
>>>>>>
>>>>>> -       switch (prog_type) {
>>>>>> -       case BPF_PROG_TYPE_LSM:
>>>>>> +       if (prog_type == BPF_PROG_TYPE_LSM)
>>>>>>                  return true;
>>>>>> -       case BPF_TRACE_ITER:
>>>>>> -               return env->prog->aux->sleepable;
>>>>>> -       default:
>>>>>> -               return false;
>>>>>> -       }
>>>>>> +
>>>>>> +       if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>>>>> +               return true;
>>>>>
>>>>> I think the switch by prog_type has to stay.
>>>>> Checking attach_type == BPF_TRACE_ITER without considering prog_type
>>>>> is fragile. It likely works, but we don't do it anywhere else.
>>>>> Let's stick to what is known to work.
>>>>>
>>>>
>>>> IIUC, do you mean:
>>>>
>>>> static bool check_css_task_iter_allowlist(struct bpf_verifier_env 
>>>> *env)
>>>> {
>>>>     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>>
>>>>      switch (prog_type) {
>>>>      case BPF_PROG_TYPE_LSM:
>>>>          return true;
>>>>     case BPF_PROG_TYPE_TRACING:
>>>>         if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>>>             return true;
>>>>         return env->prog->aux->sleepable;
>>>
>>>
>>> The above can be a fullthrough instead.
>>>
>>
>> Sorry, what do you mean 'a fullthrough' ?
>> Do you mean we can check env->prog->aux->sleepable first and then 
>> fall back to check prog/attach type ?
>>
>
> I see...
>
> Sorry for the above noise. I noticed verifier.c uses 'fallthrough' to 
> avoid the build warning, so we can:
>
> static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
> {
>     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>
>     switch (prog_type) {
>     case BPF_PROG_TYPE_LSM:
>         return true;
>     case BPF_PROG_TYPE_TRACING:
>         if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>             return true;
>         fallthrough;
>     default:
>         return env->prog->aux->sleepable;
>     }
> }


The above LGTM.


