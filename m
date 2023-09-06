Return-Path: <bpf+bounces-9330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76D793CC5
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864561C20B34
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34FDDCD;
	Wed,  6 Sep 2023 12:37:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3810FC
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 12:37:07 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3E1724
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 05:37:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc0d39b52cso21943205ad.2
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694003824; x=1694608624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZoUjaIcUo1mllggo8PIlPzobJP22nNfvBp/20MZSjI=;
        b=Cw/91PW1lwj/vNshPfbXOLa/EIkKzjlXJW+WsGCv52xnoV041/BUgB8n7wlz/3jMOc
         JIR8qbzA2Gni1cmgnNd2xuDSaC1gE/xrxEKVjS5mXHcfSr1dtFfGLoWS70FwY6dZGnIJ
         amCgx6holaF+96JOrX16IwOqljC5xOaz7dkMWzOyY47bxUyOm8VBLTc0AS4YIw2u7cgM
         3No4kJtttbWT98q2a/sx+mGwG6oFstTzs/AvLuraozwetd0lcdTZu1zbVf30eVZPHTPX
         DwYdhfT0zAD8FCUn0VKG4Ji5Ny+etIFjkrS8zvF3Blp7jDDAljxHGMx9gyMRyD0o1wYi
         4DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003824; x=1694608624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZoUjaIcUo1mllggo8PIlPzobJP22nNfvBp/20MZSjI=;
        b=UYiygF/jX0qR7vfvVoLuKuACY7kEix3AJ/YS/itIklPhvHr4Mu0lGo6YPwrXq5qqd1
         GebdptgtqotZDojohSGJsqkF9bwaa5WnBW5tEGgCQtfed7le4vnuucC4jhQlxYsdtTuM
         AnORratl9vj4GPlC/aPMbBnoQTYAffCo43vldS+c/MVe/6NOugnUkc+da3nEJwqAI+6M
         1k+YmsmONgT2UZiUSdXDd0gdH6lw/rIRXLrE0mSjlG/gWRIOG4mVar23px/3MsfZXVgR
         8f1+5VHwmcH5PT/2eJ3+7GleGtZqNvEhTkA+MIkMNAF+uPW2/T8qf04SvA1JZkM04xCV
         32iQ==
X-Gm-Message-State: AOJu0YzjR0dg2+iJ4U5SalyhmH+NQziQbNLWJEoOllkHo3r9M0RCqrN6
	s/NxgowBB5YiD0b2+b3khULTZKp+U6h8RI4EujWy8g==
X-Google-Smtp-Source: AGHT+IEmhhT/rCH4yP0vhUdx8s06CFggy495YiJSJ8R1aF9No28AqQyo+0KokwU5GVyE/2rzpwdxxg==
X-Received: by 2002:a17:902:820d:b0:1bd:b8c8:98f8 with SMTP id x13-20020a170902820d00b001bdb8c898f8mr13558458pln.4.1694003824036;
        Wed, 06 Sep 2023 05:37:04 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001bba3a4888bsm11019687plq.102.2023.09.06.05.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:37:03 -0700 (PDT)
Message-ID: <c4791970-720e-7c1c-0e81-915dbcb23139@bytedance.com>
Date: Wed, 6 Sep 2023 20:36:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Introduce css_task open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
 <20230827072057.1591929-2-zhouchuyi@bytedance.com>
 <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQJpZRoOtC0JF7uub+vPY5JZusWmPyjOJQD=eTxUFWOr_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/9/6 03:02, Alexei Starovoitov 写道:
> On Sun, Aug 27, 2023 at 12:21 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This Patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css_task in open-coded
>> iterator style. These kfuncs actually wrapps
>> css_task_iter_{start,next,end}. BPF programs can use these kfuncs through
>> bpf_for_each macro for iteration of all tasks under a css.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 39 ++++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   tools/lib/bpf/bpf_helpers.h    |  7 ++++++
>>   5 files changed, 57 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 60a9d59beeab..2a6e9b99564b 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7195,4 +7195,8 @@ struct bpf_iter_num {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_css_task {
>> +       __u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9e80efa59a5d..cf113ad24837 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2455,6 +2455,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index c4ab9d6cdbe9..b1bdba40b684 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -823,6 +823,45 @@ const struct bpf_func_proto bpf_find_vma_proto = {
>>          .arg5_type      = ARG_ANYTHING,
>>   };
>>
>> +struct bpf_iter_css_task_kern {
>> +       struct css_task_iter *css_it;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>> +               struct cgroup_subsys_state *css, unsigned int flags)
>> +{
>> +       struct bpf_iter_css_task_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
>> +                                       __alignof__(struct bpf_iter_css_task));
>> +
>> +       kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
>> +       if (!kit->css_it)
>> +               return -ENOMEM;
>> +       css_task_iter_start(css, flags, kit->css_it);
> 
> Some of the flags are internal. Like CSS_TASK_ITER_SKIPPED.
> The kfunc should probably only allow CSS_TASK_ITER_PROCS |
> CSS_TASK_ITER_THREADED,
> and not CSS_TASK_ITER_THREADED alone.
> 
> Since they're #define-s it's not easy for bpf prog to use them.
> I think would be good to have a pre-patch that converts them to enum,
> so that bpf prog can take them from vmlinux.h.
> 
> 
> But the main issue of the patch that it adds this iter to common kfuncs.
> That's not safe, since css_task_iter_*() does spin_unlock_irq() which
> might screw up irq flags depending on the context where bpf prog is running.
> Can css_task_iter internals switch to irqsave/irqrestore?

Yes, I think so. Switching to irqsave/irqrestore is no harm.

> css_set_lock is also global, so the bpf side has to be careful in
> where it allows to use this iter.
> bpf_lsm hooks are safe, most of bpf iter-s are safe too.
> Future bpf-oom hooks are probably safe as well.
> We probably need an allowlist here.

What should we do if we want to make a allowlist?
Do you mean we need to check prog_type or attach_type when we call these 
kfuncs in BPF verifier? If so, we should add a new attach_type or 
prog_type for bpf-oom in the feature so we can know the current BPF 
program is hooking for OOM Policy.

