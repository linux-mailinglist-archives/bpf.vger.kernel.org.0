Return-Path: <bpf+bounces-10146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295577A1DBE
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BC11C20E5F
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F35101F6;
	Fri, 15 Sep 2023 11:57:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DDFDF43
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 11:57:56 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13E19BC
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 04:57:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so1850987b3a.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694779074; x=1695383874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+9LelNNuQQBY0BeTA1DgI1taOTB4NaXhHyNv+e8K0s=;
        b=UdQheZSZV9QfcEhsP8HuGQM/lnr/qgd9hFQM7J29BQg5IckDP02IrsCpp98t6heXXr
         Btq11mEajyqJt5JUjZSWxCeOlsldWvboxvyzdKL8vXw1cDQUTd/IrkkPLxQCgGNr+6E6
         2yaK63Iq+h4nwYaTVgwoIzBFeByy6Udm+X0AVqFSIKRFxj9GqYAMvZcqBdSvxelzn9P0
         aNHhS74NGuzjVZE/QxD1OktTuuemNSzY7GnA6hewTBpfe7hy26faaguZhizfI1nEVLT4
         yOB4Y/L9ZmGREUt7A1Wec4w0qT7JRBvjvH7B2Ft0BxFT9A/OQzEBDpVp59T2flFDYzCC
         R7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779074; x=1695383874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g+9LelNNuQQBY0BeTA1DgI1taOTB4NaXhHyNv+e8K0s=;
        b=JHnjoaKYgWfgIouR6+N0RCBxVyBzjmIxK47Hq2V+Qil+0G1FNSny+EqDM6snE4EOA2
         qCqqWPw/RoUY6n+ryrB1SBMVwkce71EtrKGpO8lCRqFc83uRIkMlMAE6cFS4cXZIvbvP
         VbuSrn/a49MapfzuJMnVukve1JpTlmsUIWebUQTTYV7mcETP/NSvawjwRaX3BXnIp0ZC
         u3vDCkgsPK8PD0zQW31YnchGvUK9A7FVwAcAwS7wsQrD5vXL6pOH+jSvgz7JgYlHog1n
         UhDvxqOcSUwKCx1BUv3QO0gmshARcoqKh6bJe4THKPnjpPyFgfvc8aTpNbzqQZ5okhkT
         Wk3Q==
X-Gm-Message-State: AOJu0Yxz/EQEdCLdX8YfIL/MNyaNObNQmydyt4LVBE0tfcmCqd+uWZsY
	+CJ2gaMPnIFBzCImzOjiZYoeig==
X-Google-Smtp-Source: AGHT+IHpk8bWpQprhMyTPYT2SM6uicyhDAOm12s2a+arWfDsnfqzDdu7cCkXBrt62xQ1Oc2vLDFcbw==
X-Received: by 2002:a05:6a00:c96:b0:690:28d0:b7b3 with SMTP id a22-20020a056a000c9600b0069028d0b7b3mr1607774pfv.13.1694779074048;
        Fri, 15 Sep 2023 04:57:54 -0700 (PDT)
Received: from [10.255.88.66] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0063f0068cf6csm2834552pfn.198.2023.09.15.04.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:57:53 -0700 (PDT)
Message-ID: <8f27e07e-e23c-af80-90eb-b1123e1f68cd@bytedance.com>
Date: Fri, 15 Sep 2023 19:57:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 4/6] bpf: Introduce css_descendant open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-5-zhouchuyi@bytedance.com>
 <CAEf4BzY4qabpk3SD-GA5n5++REcXCxTtA4ythsR9HKHtGi33xA@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzY4qabpk3SD-GA5n5++REcXCxTtA4ythsR9HKHtGi33xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

在 2023/9/15 07:26, Andrii Nakryiko 写道:
> On Tue, Sep 12, 2023 at 12:02 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This Patch adds kfuncs bpf_iter_css_{pre,post}_{new,next,destroy} which
>> allow creation and manipulation of struct bpf_iter_css in open-coded
>> iterator style. These kfuncs actually wrapps css_next_descendant_{pre,
>> post}. BPF programs can use these kfuncs through bpf_for_each macro for
>> iteration of all descendant css under a root css.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  8 +++++
>>   kernel/bpf/helpers.c           |  6 ++++
>>   kernel/bpf/task_iter.c         | 53 ++++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  8 +++++
>>   tools/lib/bpf/bpf_helpers.h    | 12 ++++++++
>>   5 files changed, 87 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index befa55b52e29..57760afc13d0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7326,4 +7326,12 @@ struct bpf_iter_process {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_css_pre {
>> +       __u64 __opaque[2];
>> +} __attribute__((aligned(8)));
>> +
>> +struct bpf_iter_css_post {
>> +       __u64 __opaque[2];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9b7d2c6f99d1..ca1f6404af9e 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2510,6 +2510,12 @@ BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_css_pre_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_css_pre_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_css_pre_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_css_post_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_css_post_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_css_post_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 9d1927dc3a06..8963fc779b87 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -880,6 +880,59 @@ __bpf_kfunc void bpf_iter_process_destroy(struct bpf_iter_process *it)
>>   {
>>   }
>>
>> +struct bpf_iter_css_kern {
>> +       struct cgroup_subsys_state *root;
>> +       struct cgroup_subsys_state *pos;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_pre_new(struct bpf_iter_css_pre *it,
>> +               struct cgroup_subsys_state *root)
> 
> similar to my comment on previous patches, please see
> kernel/bpf/cgroup_iter.c for iter/cgroup iterator program. Let's stay
> consistent. We have one iterator that accepts parameters defining
> iteration order and starting cgroup. Unless there are some technical
> reasons we can't follow similar approach with this open-coded iter,
> let's use the same approach. We can even reuse
> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
> BPF_CGROUP_ITER_ANCESTORS_UP enums.
> 

I know your concern. It would be nice if we keep consistent with 
kernel/bpf/cgroup_iter.c

But this patch actually want to support iterating css 
(cgroup_subsys_state) not cgroup (css is more low lever).
With css_iter we can do something like 
"for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre"
in BPF Progs which is hard for cgroup_iter. In the future we can use 
this iterator to plug some customizable policy in other resource control 
system.

BTW, what I did in RFC actually very similar with the approach of 
cgroup_iter. 
(https://lore.kernel.org/all/20230827072057.1591929-4-zhouchuyi@bytedance.com/).

Thanks.

