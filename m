Return-Path: <bpf+bounces-13111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601507D4733
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 08:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CC928182A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FD10A29;
	Tue, 24 Oct 2023 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oAlcLFBg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C331C20
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 06:09:09 +0000 (UTC)
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943339D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 23:09:07 -0700 (PDT)
Message-ID: <c923dba3-f638-410f-ae65-0cfa1962a6f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698127743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYbk1W29z45SRHcbe10V2tzgOqlZ0BPG7GdMPraeCzw=;
	b=oAlcLFBga2no+HASV5/kogPUUGw9GNQfaYDyH/pkablmMxPc3LUlLvR7FDh2rziY5gJaI3
	WJ4AFpC5cxhZVLP66Akxb1OFQceIQdJjXWtAhLWyONf/j+vHtVRB8n3xukjpP/NHpHKZPx
	ZCB+h8UAj3I3z8UqU7WxLbaicdoEiss=
Date: Mon, 23 Oct 2023 23:08:54 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1f4f9308-26b4-4cc5-99eb-88851fe2f3f9@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/23/23 10:52 PM, Chuyi Zhou wrote:
> Hello,
>
> 在 2023/10/24 12:57, Alexei Starovoitov 写道:
>> On Mon, Oct 23, 2023 at 7:42 PM Chuyi Zhou <zhouchuyi@bytedance.com> 
>> wrote:
>>>
>>> The newly added open-coded css_task iter would try to hold the global
>>> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be 
>>> careful in
>>> where it allows to use this iter. The mainly concern is dead locking on
>>> css_set_lock. check_css_task_iter_allowlist() in verifier enforced 
>>> css_task
>>> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>>>
>>> This patch relax the allowlist for css_task iter. Any lsm and any iter
>>> (even non-sleepable) and any sleepable are safe since they would not 
>>> hold
>>> the css_set_lock before entering BPF progs context.
>>>
>>> This patch also fixes the misused BPF_TRACE_ITER in
>>> check_css_task_iter_allowlist which compared bpf_prog_type with
>>> bpf_attach_type.
>>>
>>> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator 
>>> kfuncs")
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>>   kernel/bpf/verifier.c                         | 21 
>>> ++++++++++++-------
>>>   .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index e9bc5d4a25a1..9f209adc4ccb 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -11088,18 +11088,23 @@ static int 
>>> process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>> &meta->arg_rbtree_root.field);
>>>   }
>>>
>>> +/*
>>> + * css_task iter allowlist is needed to avoid dead locking on 
>>> css_set_lock.
>>> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
>>> + * Any sleepable progs are also safe since 
>>> bpf_check_attach_target() enforce
>>> + * them can only be attached to some specific hook points.
>>> + */
>>>   static bool check_css_task_iter_allowlist(struct bpf_verifier_env 
>>> *env)
>>>   {
>>>          enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>
>>> -       switch (prog_type) {
>>> -       case BPF_PROG_TYPE_LSM:
>>> +       if (prog_type == BPF_PROG_TYPE_LSM)
>>>                  return true;
>>> -       case BPF_TRACE_ITER:
>>> -               return env->prog->aux->sleepable;
>>> -       default:
>>> -               return false;
>>> -       }
>>> +
>>> +       if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>> +               return true;
>>
>> I think the switch by prog_type has to stay.
>> Checking attach_type == BPF_TRACE_ITER without considering prog_type
>> is fragile. It likely works, but we don't do it anywhere else.
>> Let's stick to what is known to work.
>>
>
> IIUC, do you mean:
>
> static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
> {
>     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>
>      switch (prog_type) {
>      case BPF_PROG_TYPE_LSM:
>          return true;
>     case BPF_PROG_TYPE_TRACING:
>         if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>             return true;
>         return env->prog->aux->sleepable;


The above can be a fullthrough instead.


> default:
>         return env->prog->aux->sleepable;
>      }
> }
>
>>> -SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>>> -__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf 
>>> iter-s")
>>> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
>>> +__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter 
>>> and sleepable progs")
>>
>> Please add both. fentry that is rejected and fentry.s that is accepted.
>
> Sure.
>

