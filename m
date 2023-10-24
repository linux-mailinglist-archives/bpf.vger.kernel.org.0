Return-Path: <bpf+bounces-13126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF37D4F14
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 13:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD3B20FA7
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F2266A6;
	Tue, 24 Oct 2023 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wi0L5tz3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E96111BE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:43:37 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317F6F9
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:43:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d11401516so2919859a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698147815; x=1698752615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx6+e52QOJqe1aSIsa3g3OkONu5iVau2uf9IkYFGUjA=;
        b=Wi0L5tz3dQ71hDmyp6qSunHuZ73qrEUSzTNKUcAfykFdF6vmAgpDcq1QcrFPmwUPGY
         ldvCNO1GCBpOUIa8p8u4HZb1L0gpNrRw7g//hW5HzyusPC4rpfYV0s/NOXhcdHPse1JM
         7t5mEiNTZR8Mzy5E28p77Cu8sjo60oK2Fweigu+uGDTlhvGGG+W6enUdyTXqFjCLFzw6
         0Z+sAUFaTbakq7cdbO0rX0VLV9tY4D8dP+md/ORO8WsR2P5tPzKX8okQsiMZ69JoaG/4
         y14eSNePCTL8GZUJl2WvSWXytEb15hjKWyaB4X9m3aSE9k9l0z/aWJceORqKN1tUqHlw
         qO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147815; x=1698752615;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dx6+e52QOJqe1aSIsa3g3OkONu5iVau2uf9IkYFGUjA=;
        b=NAPsd9tto9YjbCQDuHXDA5pJAPVYqEL0HvqAiKPQF0Z81J8flUumP8/Fe+NlYr6mH6
         6dIg0c5auS5b29RRofz4BDIssoxC6Ck44SinjwTRTNM2LBeM+FC/8CD7GxUTq2a4C1Tn
         ErS9T2Gm/hYrR9Vpz97CfrVSUN0ABtsV+l97IOZ3yXIp8kwXAnb9ZumvroT8DwuS/aAq
         Yq3c1EcVtvd+kPPoN3365aoAF7e6kJoPWV+vrKtk+50NAgTvU8ce4XsvHsWuIfcnx4aH
         3TmJ+lCQ3kb7ehasC3VnMAI5mejnbFJs0SQmMxf+XbCzP2hYEuouQll9OwgmD396EKxk
         d2kA==
X-Gm-Message-State: AOJu0Yz4E9LxQuX/97KBZCcyTZwKrk/gqXvlEUw/bvVNinYLWbBfrb4L
	HTMYSJaL6wiWx/xtbsStxOLCpw==
X-Google-Smtp-Source: AGHT+IGoupmxersp/C4v5plOXC3tU8i9bRpxEmmirhAhUGmdUWoSPIcPCvxrObXgsgCEfHEhB9et3A==
X-Received: by 2002:a05:6a20:c19d:b0:16b:aad0:effe with SMTP id bg29-20020a056a20c19d00b0016baad0effemr2131576pzb.62.1698147815609;
        Tue, 24 Oct 2023 04:43:35 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b001ab39cd875csm7240268plg.133.2023.10.24.04.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 04:43:35 -0700 (PDT)
Message-ID: <efa935f1-251c-4f4c-9f67-7d352514b611@bytedance.com>
Date: Tue, 24 Oct 2023 19:43:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: Yonghong Song <yonghong.song@linux.dev>,
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
In-Reply-To: <efa59538-cfc9-404c-9ecf-d04e49a4b82e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/24 14:23, Chuyi Zhou 写道:
> Hello,
> 
> 在 2023/10/24 14:08, Yonghong Song 写道:
>>
>> On 10/23/23 10:52 PM, Chuyi Zhou wrote:
>>> Hello,
>>>
>>> 在 2023/10/24 12:57, Alexei Starovoitov 写道:
>>>> On Mon, Oct 23, 2023 at 7:42 PM Chuyi Zhou <zhouchuyi@bytedance.com> 
>>>> wrote:
>>>>>
>>>>> The newly added open-coded css_task iter would try to hold the global
>>>>> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be 
>>>>> careful in
>>>>> where it allows to use this iter. The mainly concern is dead 
>>>>> locking on
>>>>> css_set_lock. check_css_task_iter_allowlist() in verifier enforced 
>>>>> css_task
>>>>> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>>>>>
>>>>> This patch relax the allowlist for css_task iter. Any lsm and any iter
>>>>> (even non-sleepable) and any sleepable are safe since they would 
>>>>> not hold
>>>>> the css_set_lock before entering BPF progs context.
>>>>>
>>>>> This patch also fixes the misused BPF_TRACE_ITER in
>>>>> check_css_task_iter_allowlist which compared bpf_prog_type with
>>>>> bpf_attach_type.
>>>>>
>>>>> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator 
>>>>> kfuncs")
>>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>>> ---
>>>>>   kernel/bpf/verifier.c                         | 21 
>>>>> ++++++++++++-------
>>>>>   .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>>>>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index e9bc5d4a25a1..9f209adc4ccb 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -11088,18 +11088,23 @@ static int 
>>>>> process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>>>> &meta->arg_rbtree_root.field);
>>>>>   }
>>>>>
>>>>> +/*
>>>>> + * css_task iter allowlist is needed to avoid dead locking on 
>>>>> css_set_lock.
>>>>> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
>>>>> + * Any sleepable progs are also safe since 
>>>>> bpf_check_attach_target() enforce
>>>>> + * them can only be attached to some specific hook points.
>>>>> + */
>>>>>   static bool check_css_task_iter_allowlist(struct bpf_verifier_env 
>>>>> *env)
>>>>>   {
>>>>>          enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>>>
>>>>> -       switch (prog_type) {
>>>>> -       case BPF_PROG_TYPE_LSM:
>>>>> +       if (prog_type == BPF_PROG_TYPE_LSM)
>>>>>                  return true;
>>>>> -       case BPF_TRACE_ITER:
>>>>> -               return env->prog->aux->sleepable;
>>>>> -       default:
>>>>> -               return false;
>>>>> -       }
>>>>> +
>>>>> +       if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>>>> +               return true;
>>>>
>>>> I think the switch by prog_type has to stay.
>>>> Checking attach_type == BPF_TRACE_ITER without considering prog_type
>>>> is fragile. It likely works, but we don't do it anywhere else.
>>>> Let's stick to what is known to work.
>>>>
>>>
>>> IIUC, do you mean:
>>>
>>> static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>>> {
>>>     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>
>>>      switch (prog_type) {
>>>      case BPF_PROG_TYPE_LSM:
>>>          return true;
>>>     case BPF_PROG_TYPE_TRACING:
>>>         if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>>             return true;
>>>         return env->prog->aux->sleepable;
>>
>>
>> The above can be a fullthrough instead.
>>
> 
> Sorry, what do you mean 'a fullthrough' ?
> Do you mean we can check env->prog->aux->sleepable first and then fall 
> back to check prog/attach type ?
> 

I see...

Sorry for the above noise. I noticed verifier.c uses 'fallthrough' to 
avoid the build warning, so we can:

static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
{
	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);

	switch (prog_type) {
	case BPF_PROG_TYPE_LSM:
		return true;
	case BPF_PROG_TYPE_TRACING:
		if (env->prog->expected_attach_type == BPF_TRACE_ITER)
			return true;
		fallthrough;
	default:
		return env->prog->aux->sleepable;
	}
}


