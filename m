Return-Path: <bpf+bounces-10016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D45257A0479
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60777B20F25
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7A91F5E7;
	Thu, 14 Sep 2023 12:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C97241EE
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:50:32 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893D1FD9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:50:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fc1bbc94eso708380b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694695832; x=1695300632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2iriErYbn79qa7ewAKhiijBn0H2Aoadhjiaypxhtro=;
        b=k/6qQ1RTyt+Epd0NDlDVKTFlXSXMlXU8dCYox0nvjQgHA4EIVM8syYj1oZgobCmPH/
         qWOaT40gP57vmHnyrLHM5fDeatxhasUe6x7bw6XM7nRNrzGVFhoQTunhzFCN2cyOnDY4
         i26mNLbybJBrwaf4j+3nWlIWb1ShgXYYBCIQZ1eh74Lp8Jj5eUkFC2EYKG8KKMnMxc9C
         jIuib9Sn5mpXMc0Aab7IX9izrGy0OUGem7fRUefLVyNDa87KBTK6ma3xReVlNXQtiiNg
         PYtkH7rl0MQ8e9ZJftdOypxji7Z76H+KnWrS7IcHnx5XzbGO+tfqpNz6ZsGQVhkd9q2V
         4LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695832; x=1695300632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2iriErYbn79qa7ewAKhiijBn0H2Aoadhjiaypxhtro=;
        b=dXbdC5Sfa4abL4ivXGCXrC1ZltwdzbAR9Lp85uACzBF3H7X1FGBzIuhnew64G9k9pJ
         MohjFQTQZ5X/L/j+QE+Bpm6zH1MCZ2Qq1NAYj5tBnGR3tB/9pT7qcXc8N8FQRMFC7ayQ
         mBzNtHET5rennKWfw5Yajsd2BpXIzhYCWFx2Enjl3Vw1UnBCqZOoDScJO53nRXAD4zE6
         0CXNAIuRvvBtdS6raQWlQbaTkb5QIGXwXfA9UuXtb23pH+jXdzRxbhgiiZKzH5rmrzKi
         vS6A+yQsA7tqS0roemz+HwOJ9VymLZnqnlEBpuxyVijhlnOBtIbHXEPiL4zVOmB9lYu2
         eLPQ==
X-Gm-Message-State: AOJu0YyTfp2T49czsHXMnAL00xUNjf4py6zSRfvjcNdcExJMmFhqG24L
	6mVY2CkdMSuBgl3Z1kPNmxP2kg==
X-Google-Smtp-Source: AGHT+IGXKNqg9k2IBt7BhnX/pDOuKeUJatuzkUT9W8yp4wYF4dwEWXU7qLUn0mLCq1bZxdvyys4Xxw==
X-Received: by 2002:a05:6a00:21d5:b0:68a:5e5b:e450 with SMTP id t21-20020a056a0021d500b0068a5e5be450mr5676316pfj.26.1694695831781;
        Thu, 14 Sep 2023 05:50:31 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e23-20020a62aa17000000b0068fba4800cfsm1280445pff.56.2023.09.14.05.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 05:50:31 -0700 (PDT)
Message-ID: <89295904-3afa-4c8f-ccdb-1d78d9ad3024@bytedance.com>
Date: Thu, 14 Sep 2023 20:50:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [External] Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify
 OOM policies
To: Bixuan Cui <cuibixuan@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net> <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/9/14 20:02, Bixuan Cui 写道:
> 
> 
> 在 2023/8/15 4:51, Jonathan Corbet 写道:
>>>   /**
>>>    * dump_tasks - dump current memory state of all system tasks
>>>    * @oc: pointer to struct oom_control
>>> @@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control 
>>> *oc, struct task_struct *victim)
>>>   static void dump_header(struct oom_control *oc, struct task_struct *p)
>>>   {
>>> -    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
>>> oom_score_adj=%hd\n",
>>> -        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
>>> +    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
>>> policy_name=%s, oom_score_adj=%hd\n",
>>> +        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, 
>>> oc->policy_name,
>> ...and if the policy name is unterminated, this print will run off the
>> end of the structure.
>>
>> Am I missing something here?
> Perhaps it is inaccurate to use policy name in this way. For example, 
> some one use BPF_PROG(bpf_oom_evaluate_task, ...) but do not set the 
> policy name through bpf_set_policy_name. In this way, the result is 
> still policy name=default, which ultimately leads to error print in the 
> dump_header.
> I think a better way:
> 
> +static const char *const policy_select[] = {
> +    "OOM_DEFAULT";
> +    "BPF_ABORT",
> +    "BPF_NEXT",
> +    "BPF_SELECT",
> +};
> 
> struct oom_control {
> 
>       /* Used to print the constraint info. */
>       enum oom_constraint constraint;
> +
> +    /* Used to report the policy select. */
> +    int policy_select;
>   };
> 
> static int oom_evaluate_task(struct task_struct *task, void *arg)
> {
> ...
> 
> +    switch (bpf_oom_evaluate_task(task, oc)) {
> +    case BPF_EVAL_ABORT:
> +              oc->policy_select = BPF_EVAL_ABORT;
> +        goto abort; /* abort search process */
> +    case BPF_EVAL_NEXT:
> +              oc->policy_select = BPF_EVAL_NEXT;
> +        goto next; /* ignore the task */
> +    case BPF_EVAL_SELECT:
> +             oc->policy_select = BPF_EVAL_SELECT;
> +        goto select; /* select the task */
> +    default:
> +        break; /* No BPF policy */
> +    }
> 
>   static void dump_header(struct oom_control *oc, struct task_struct *p)
>   {
> -    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
> oom_score_adj=%hd\n",
> -        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
> +    pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
> policy_name=%s, oom_score_adj=%hd\n",
> +        current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, 
> policy_select[oc->policy_select],
>               current->signal->oom_score_adj);
> 
> 

The policy_name may be different from the previous OOM reporting, even 
though they are using the same policy.

> And all definitions of oc should be added
> struct oom_control oc = {
>       .select = NO_BPF_POLICY,
> }
> 
> Delete set_oom_policy_name, it makes no sense for users to set policy 
> names. :-)
> 

There can be multiple OOM policy in the system at the same time.

If we need to apply different OOM policies to different memcgs based on 
different scenarios, we can use this hook(set_oom_policy_name) to set 
name to identify which policy in invoked at that time.

Just some thoughts.

Thanks.

> Thanks
> Bixuan Cui
> 
> 
> 
> 
> 

