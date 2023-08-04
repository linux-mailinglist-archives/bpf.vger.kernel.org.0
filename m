Return-Path: <bpf+bounces-7060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E4770C83
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 01:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8690282752
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80622253C0;
	Fri,  4 Aug 2023 23:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51519253A8
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 23:56:07 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2977468C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 16:56:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bba2318546so23023975ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691193364; x=1691798164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RZScyr6FqT84Uy1x7BCeAs2NyW8I+cWRxFEgbAtAV8=;
        b=ICN5YUoCAY95VxcaMub5rJ7CJvH8L/C7epvVEtmvw1W3jwgRL7XmEBQAfoFw/2E7yp
         YKvUYekPZSJiKn8cjHcIlDjkibSpefhzAEjUmNh0xN0RwOs+Uxs15SJ2pXCsW58RTbPs
         Kk1I7xjURZSKw5CCvYDi6F79ckpjl5yXnq7R4hNL2L1SZjQJnlg6ZCMQbe6jVKDVssrn
         TStCEAIfm0RIv61Y8P5xCB2w1R8dzenkzpvZTPAzFfKZIg29JtK0x62VXOcLZYdluX82
         KaKl1kkFllDU9cyxXM/KbytB2ou//oGG5mE5QQIMqhpCCjmOLsC854V+eMglqB0Z00L5
         p+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691193364; x=1691798164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RZScyr6FqT84Uy1x7BCeAs2NyW8I+cWRxFEgbAtAV8=;
        b=LkuuGGo8caJYJI+VEdp6WSF54ozejqWC5LgjVb0b0uTI5gReq4fNFj2gY3DsAhNY4J
         //JmtWOMdvBVofg0Yy5sfNJ2GvJyL2VSkIb7FaUY6lKDs13e7f8fFuw92GriISiAWEfZ
         +B55U4cOb2WvskWCX0uztq90GEnn3RNXasXqcW3v3HDc9QC2cHldkFYQOzCZrBVpRLCF
         5FOhMJW4C05nD8MP0Hs7/OUnp0w3xRcTXnXyJCmqs5N1SD41sW2WP59SNmvYUW1Qh3HH
         guij7nyLruSsOl7xTyJxbAb/yrEghPXefWDAP0eGjEjlnVrNweRbhgVddpMFI2IvyYlw
         1JKQ==
X-Gm-Message-State: AOJu0Yx7nXnMdbXhNDaCkjZvfncCJ4ew4IBTyRlQDzSSZWX1X77xOeNS
	PP4+TxYX4y4ei386099+u/5Azg==
X-Google-Smtp-Source: AGHT+IECgyzL8b7yrw1XEljKWBZYRWDtA8hse2qjnPUm0s5ZrJZJdnhReJxdIz+0iP+1m1PpGFkwdQ==
X-Received: by 2002:a17:902:ced2:b0:1bc:6c8:cded with SMTP id d18-20020a170902ced200b001bc06c8cdedmr3657930plg.67.1691193364270;
        Fri, 04 Aug 2023 16:56:04 -0700 (PDT)
Received: from [10.254.69.31] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b00198d7b52eefsm2271370plg.257.2023.08.04.16.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 16:56:04 -0700 (PDT)
Message-ID: <fa736940-2840-efa7-11e5-493465788545@bytedance.com>
Date: Sat, 5 Aug 2023 07:55:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
To: Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <1719817f-6ae9-8f0b-5075-657cb4e80e20@oracle.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <1719817f-6ae9-8f0b-5075-657cb4e80e20@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/8/4 19:34, Alan Maguire 写道:
> On 04/08/2023 10:38, Chuyi Zhou wrote:
>> This patch adds a new hook bpf_select_task in oom_evaluate_task. It
> 
> bpf_select_task() feels like too generic a name - bpf_oom_select_task()
> might make the context clearer.
> 
> I'd also suggest adding a documentation patch for a new
> Documentation/bpf/oom.rst or whatever to describe how it is all supposed
> to work.Got it, I would add it in next version.
> 
>> takes oc and current iterating task as parameters and returns a result
>> indicating which one is selected by bpf program.
>>
>> Although bpf_select_task is used to bypass the default method, there are
>> some existing rules should be obeyed. Specifically, we skip these
>> "unkillable" tasks(e.g., kthread, MMF_OOM_SKIP, in_vfork()).So we do not
>> consider tasks with lowest score returned by oom_badness except it was
>> caused by OOM_SCORE_ADJ_MIN.
>>
>> If we attach a prog to the hook, the interface is enabled only when we have
>> successfully chosen at least one valid candidate in previous iteraion. This
>> is to avoid that we find nothing if bpf program rejects all tasks.
>>
> 
> I don't know anything about OOM mechanisms, so maybe it's just me, but I
> found this confusing. Relying on the previous iteration to control
> current iteration behaviour seems risky - even if BPF found a victim in
> iteration N, it's no guarantee it will in iteration N+1.
>
The current kernel's OOM actually works like this:

1. if we first find a valid candidate victim A in iteration N, we would 
record it in oc->chosen.

2. In iteration N + 1, N+2..., we just compare oc->chosen with the 
current iterating task. Suppose we think current task B is better than 
oc->chosen(A), we would set oc->chosen = B and we would not consider A 
anymore.

IIUC, most policy works like this. We just need to find the *most* 
suitable victim. Normally, if in current iteration we drop A and select 
B, we would not consider A anymore.

> Naively I would have thought the right answer here would be to honour
> the choice OOM would have made (in the absence of BPF execution) for
> cases where BPF did not select a victim. Is that sort of scheme
> workable? Does that make sense from the mm side, or would we actually
> want to fall back to
> 
> 	pr_warn("Out of memory and no killable processes...\n");
> 
> ...if BPF didn't select a process?
> 
My major concern was wether we should fully trust the correctness of BPF 
Progarm from user since some OOM may invoke kernel panic if we find 
nothing. Actually, the current non-BPF mechanism also is not guaranteed 
to find a chosen victim (If user set inappropriate oom_score_adj, we may 
find nothing).

It seems both you and Michal think here we should honour the default 
logic of OOM and do not add something additional to prevent BPF find 
nothing.

> The danger here seems to be that the current non-BPF mechanism seems to
> be guaranteed to find a chosen victim, but delegating to BPF is not. So
> what is the right behaviour for such cases from the mm perspective?
> 

> (One thing that would probably be worth doing from the BPF side would be
> to add a tracepoint to mark the scenario where nothing was chosen for
> OOM kill via BPF; this would allow BPF programs to catch the fact that
> their OOM selection mechanisms didn't work.)

Nice idea, maybe we could add this tracepoint when we finishing victim 
selection? In this way, we could easily catch the selection result in 
BPF programs even if we successfully find something.
> 
> Alan
> 
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   mm/oom_kill.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 50 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 612b5597d3af..aec4c55ed49a 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -18,6 +18,7 @@
>>    *  kernel subsystems and hints as to where to find out what things do.
>>    */
>>   
>> +#include <linux/bpf.h>
>>   #include <linux/oom.h>
>>   #include <linux/mm.h>
>>   #include <linux/err.h>
>> @@ -210,6 +211,16 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
>>   	if (!p)
>>   		return LONG_MIN;
>>   
>> +	/*
>> +	 * If task is allocating a lot of memory and has been marked to be
>> +	 * killed first if it triggers an oom, then set points to LONG_MAX.
>> +	 * It will be selected unless we keep oc->chosen through bpf interface.
>> +	 */
>> +	if (oom_task_origin(p)) {
>> +		task_unlock(p);
>> +		return LONG_MAX;
>> +	}
>> +
>>   	/*
>>   	 * Do not even consider tasks which are explicitly marked oom
>>   	 * unkillable or have been already oom reaped or the are in
>> @@ -305,8 +316,30 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
>>   	return CONSTRAINT_NONE;
>>   }
>>   
>> +enum bpf_select_ret {
>> +	BPF_SELECT_DISABLE,
>> +	BPF_SELECT_TASK,
>> +	BPF_SELECT_CHOSEN,
>> +};
>> +
>> +__weak noinline int bpf_select_task(struct oom_control *oc,
>> +				struct task_struct *task, long badness_points)
>> +{
>> +	return BPF_SELECT_DISABLE;
>> +}
>> +
>> +BTF_SET8_START(oom_bpf_fmodret_ids)
>> +BTF_ID_FLAGS(func, bpf_select_task)
>> +BTF_SET8_END(oom_bpf_fmodret_ids)
>> +
>> +static const struct btf_kfunc_id_set oom_bpf_fmodret_set = {
>> +	.owner = THIS_MODULE,
>> +	.set   = &oom_bpf_fmodret_ids,
>> +};
>> +
>>   static int oom_evaluate_task(struct task_struct *task, void *arg)
>>   {
>> +	enum bpf_select_ret bpf_ret = BPF_SELECT_DISABLE;
>>   	struct oom_control *oc = arg;
>>   	long points;
>>   
>> @@ -329,17 +362,23 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>>   		goto abort;
>>   	}
>>   
>> +	points = oom_badness(task, oc->totalpages);
>> +
>>   	/*
>> -	 * If task is allocating a lot of memory and has been marked to be
>> -	 * killed first if it triggers an oom, then select it.
>> +	 * Do not consider tasks with lowest score value except it was caused
>> +	 * by OOM_SCORE_ADJ_MIN. Give these tasks a chance to be selected by
>> +	 * bpf interface.
>>   	 */
>> -	if (oom_task_origin(task)) {
>> -		points = LONG_MAX;
>> +	if (points == LONG_MIN && task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN)
>> +		goto next;
>> +
>> +	if (oc->chosen)
>> +		bpf_ret = bpf_select_task(oc, task, points);
>> +
>> +	if (bpf_ret == BPF_SELECT_TASK)
>>   		goto select;
>> -	}
>>   
>> -	points = oom_badness(task, oc->totalpages);
>> -	if (points == LONG_MIN || points < oc->chosen_points)
>> +	if (bpf_ret == BPF_SELECT_CHOSEN || points == LONG_MIN || points < oc->chosen_points)
>>   		goto next;
>>   
>>   select:
>> @@ -732,10 +771,14 @@ static struct ctl_table vm_oom_kill_table[] = {
>>   
>>   static int __init oom_init(void)
>>   {
>> +	int err;
>>   	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
>>   #ifdef CONFIG_SYSCTL
>>   	register_sysctl_init("vm", vm_oom_kill_table);
>>   #endif
> 
> probably worth having #ifdef CONFIG_BPF or similar here..
I see. Thanks for your remind.
register_btf_fmodret_id_set is controled by CONFIG_BPF_SYSCALL. So maybe 
we can add #ifdef CONFIG_BPF_SYSCALL here.

Thanks for your advice, I'm very glad to follow your suggestions for the
next version of development.
> 
>> +	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
>> +	if (err)
>> +		pr_warn("error while registering oom fmodret entrypoints: %d", err);
>>   	return 0;
>>   }
>>   subsys_initcall(oom_init)

