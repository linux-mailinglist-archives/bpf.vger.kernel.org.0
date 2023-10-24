Return-Path: <bpf+bounces-13112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F367D4763
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F4AB20F10
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60CF11C96;
	Tue, 24 Oct 2023 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZijASscz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10041FB5
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 06:23:34 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B919DD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 23:23:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-578b4997decso3027569a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698128612; x=1698733412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zGcUDBYgyumUWnGiVIqWPEZfYapzAa9WVJgQ08XWpc=;
        b=ZijASsczliytk0YzOjSFrWIlI8Ot2FZaEv7NyIogCJ0aYJFHc6QdSLSXhU8tMpFUF5
         wkxKAzamzqJUSCeI+dE31k56v+BN+h1WSGflX9iY0chfl83jJTDdeiXTTbbgcmIbwJmF
         HkFEMlDaREuPJCoQfS53qFGCNHEsht3lS4/DC5MoRuXtwGu/jA3U5Cyb4DMGFr2ORPhH
         ibg4FzjXe60MVKoC8kSDj80RJUdbVq3kPAZeBqLg4UqyiSejM7KHyxEM1Y5gwSMtTzMn
         BNnsGZVo5RoswLFkeH6c0VU9jfQMVrp/g5BbKr5HQ5i0UrRgWY6Y3/NMeiEQLgNjgEmG
         37VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698128612; x=1698733412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2zGcUDBYgyumUWnGiVIqWPEZfYapzAa9WVJgQ08XWpc=;
        b=j2fa9znfVsdSGj/lS0KtHS9H/fju0ZH4yW5vQj0T6r9vyFUMkbvKtQSTElS8/Otbu8
         80M1D/pqACEOa+RCfmjzcoRzI3sECTFmW1UXl6eYs6r5KXEnGG4xzUH5BHw3yfGkAcVk
         8KknOu0BJvWScFAh8tafGIHuW+CoQrmItEfpbo1DvANDe6mRQITcSMa7+RAf9xGuLIv2
         SCOzyq9/++WQ4WCEkA3w4DnYu+JlOi1N9jDa8S4dbo84MFtq+QI/nX9tEqx9HX2KEhAd
         eMvddjWut1eGdqfBgyiFkTwepW08su5Gk5lqExjSbjUcK7KKKaKcv7oKgm46f1oM4Owt
         3PUQ==
X-Gm-Message-State: AOJu0YxO5tdfnQUqlTqj5W+Ya7nkEjOHsa/EfLRSXzj8XdhSWGOXuyJV
	aquPZ+4M7dzSMkBbKk1z3haZxA==
X-Google-Smtp-Source: AGHT+IGj7TWsNV05drQHGIq9pDrkmLhJtrQ6nCsOleUSjCGjFl/3eJboeVTdE/2qb45UEGIpg2iaXw==
X-Received: by 2002:a05:6a20:4d92:b0:17b:2c56:70b8 with SMTP id gj18-20020a056a204d9200b0017b2c5670b8mr1458256pzb.22.1698128611743;
        Mon, 23 Oct 2023 23:23:31 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b0068bc6a75848sm7382770pfb.156.2023.10.23.23.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 23:23:31 -0700 (PDT)
Message-ID: <efa59538-cfc9-404c-9ecf-d04e49a4b82e@bytedance.com>
Date: Tue, 24 Oct 2023 14:23:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
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
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <c923dba3-f638-410f-ae65-0cfa1962a6f2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/10/24 14:08, Yonghong Song 写道:
> 
> On 10/23/23 10:52 PM, Chuyi Zhou wrote:
>> Hello,
>>
>> 在 2023/10/24 12:57, Alexei Starovoitov 写道:
>>> On Mon, Oct 23, 2023 at 7:42 PM Chuyi Zhou <zhouchuyi@bytedance.com> 
>>> wrote:
>>>>
>>>> The newly added open-coded css_task iter would try to hold the global
>>>> css_set_lock in bpf_iter_css_task_new, so the bpf side has to be 
>>>> careful in
>>>> where it allows to use this iter. The mainly concern is dead locking on
>>>> css_set_lock. check_css_task_iter_allowlist() in verifier enforced 
>>>> css_task
>>>> can only be used in bpf_lsm hooks and sleepable bpf_iter.
>>>>
>>>> This patch relax the allowlist for css_task iter. Any lsm and any iter
>>>> (even non-sleepable) and any sleepable are safe since they would not 
>>>> hold
>>>> the css_set_lock before entering BPF progs context.
>>>>
>>>> This patch also fixes the misused BPF_TRACE_ITER in
>>>> check_css_task_iter_allowlist which compared bpf_prog_type with
>>>> bpf_attach_type.
>>>>
>>>> Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator 
>>>> kfuncs")
>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>> ---
>>>>   kernel/bpf/verifier.c                         | 21 
>>>> ++++++++++++-------
>>>>   .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
>>>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index e9bc5d4a25a1..9f209adc4ccb 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -11088,18 +11088,23 @@ static int 
>>>> process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>>>> &meta->arg_rbtree_root.field);
>>>>   }
>>>>
>>>> +/*
>>>> + * css_task iter allowlist is needed to avoid dead locking on 
>>>> css_set_lock.
>>>> + * LSM hooks and iters (both sleepable and non-sleepable) are safe.
>>>> + * Any sleepable progs are also safe since 
>>>> bpf_check_attach_target() enforce
>>>> + * them can only be attached to some specific hook points.
>>>> + */
>>>>   static bool check_css_task_iter_allowlist(struct bpf_verifier_env 
>>>> *env)
>>>>   {
>>>>          enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>>>
>>>> -       switch (prog_type) {
>>>> -       case BPF_PROG_TYPE_LSM:
>>>> +       if (prog_type == BPF_PROG_TYPE_LSM)
>>>>                  return true;
>>>> -       case BPF_TRACE_ITER:
>>>> -               return env->prog->aux->sleepable;
>>>> -       default:
>>>> -               return false;
>>>> -       }
>>>> +
>>>> +       if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>>> +               return true;
>>>
>>> I think the switch by prog_type has to stay.
>>> Checking attach_type == BPF_TRACE_ITER without considering prog_type
>>> is fragile. It likely works, but we don't do it anywhere else.
>>> Let's stick to what is known to work.
>>>
>>
>> IIUC, do you mean:
>>
>> static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
>> {
>>     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
>>
>>      switch (prog_type) {
>>      case BPF_PROG_TYPE_LSM:
>>          return true;
>>     case BPF_PROG_TYPE_TRACING:
>>         if (env->prog->expected_attach_type == BPF_TRACE_ITER)
>>             return true;
>>         return env->prog->aux->sleepable;
> 
> 
> The above can be a fullthrough instead.
> 

Sorry, what do you mean 'a fullthrough' ?
Do you mean we can check env->prog->aux->sleepable first and then fall 
back to check prog/attach type ?


