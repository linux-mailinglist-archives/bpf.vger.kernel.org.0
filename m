Return-Path: <bpf+bounces-8041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1F7804B5
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 05:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86788282302
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F429100D0;
	Fri, 18 Aug 2023 03:32:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF68BE2
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 03:32:10 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013EE3C24
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 20:31:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68879c7f5easo414961b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 20:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692329447; x=1692934247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGmVVVsqzwRWxRE6503FAnRSrIWd/bwYCLw204IJRkI=;
        b=d3KZf/LTftZ96BtzQJ7G5aMZvlBFyFZufZy8+97TTPZ51ULQXtMq7+opwQWnmmFtOB
         CkBqM+KhcVBVcBiB23aUe4zidvc6AD/hvufabpiZdT90ibSHL60mQsIRImfqeQKvOjsR
         492Q4crEEjhHyZpoSVCZFAsWNfMs8L21n1LMdPl4RV6WaextVP29f3SlrKVyXULJaUCm
         aZ9p+6uoLkT8RCnNw5EKP+DA4R9o4wgPEuEvqGSKJIJyDBWW7jXsSwOV28s8tqeDpjMb
         vhNEJpoRCceWDokCh+/7SllUK+aHLUZ5SsaJob7b5o1EkKjz6XGeDFuz1OsI9vEHOEUQ
         IJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692329447; x=1692934247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGmVVVsqzwRWxRE6503FAnRSrIWd/bwYCLw204IJRkI=;
        b=SBVaFrwlvwkGNq45DAHwV5H/MDmfRM0fJwXfLjw9CFWtijtGBAkLo15M2pa01fIFex
         CEtiZqmrkkQudUGGuul92yROOciK4jDuQs+r3nHIc4GdGruh0M0Y77Fps5AqylrA0WhA
         Uq2qFBry8SvOA7HLWnIT35qudLMb4rQNau7SLmoahVKk4yLqJB4L7KeDxzcbXsNSLKkV
         suwI0ZB35iNBwSgJmnsY2s3oqh+sygKQzQpyfG/agbddSztm5Wh2cgpiJN2OgIvJHMnr
         LJRyuUePcprokFWg/WpYpMnimp15vEKAJ/xxHY5e3GWMLgQp/I6FnVdEpB/gF1pEKqG1
         JSyA==
X-Gm-Message-State: AOJu0YyuLVpHNQ4PWL0vA0JgfTaTkyYadv4aeP5hVmYNPvqaYV7bsMpg
	q2iPIepQke8FknU2HKfDS0f8yA==
X-Google-Smtp-Source: AGHT+IFjvYdd1gHzy3Dm/9XxgsdE9J5GYxTWj/2+yaApFf7YiPL2XuxffQUZO/c7Y93aoEgllYbq4A==
X-Received: by 2002:a05:6a00:812:b0:687:5415:7282 with SMTP id m18-20020a056a00081200b0068754157282mr1520138pfk.23.1692329447618;
        Thu, 17 Aug 2023 20:30:47 -0700 (PDT)
Received: from [10.255.89.48] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm495696pfn.67.2023.08.17.20.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 20:30:47 -0700 (PDT)
Message-ID: <a24fc514-38dd-c4bb-322f-08a6f46767f4@bytedance.com>
Date: Fri, 18 Aug 2023 11:30:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com,
 Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
 <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
 <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,
在 2023/8/17 11:22, Alexei Starovoitov 写道:
> On Wed, Aug 16, 2023 at 7:51 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> Hello,
>>
>> 在 2023/8/17 10:07, Alexei Starovoitov 写道:
>>> On Thu, Aug 10, 2023 at 1:13 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>    static int oom_evaluate_task(struct task_struct *task, void *arg)
>>>>    {
>>>>           struct oom_control *oc = arg;
>>>> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>>>>           if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>>>>                   goto next;
>>>>
>>>> +       /*
>>>> +        * If task is allocating a lot of memory and has been marked to be
>>>> +        * killed first if it triggers an oom, then select it.
>>>> +        */
>>>> +       if (oom_task_origin(task)) {
>>>> +               points = LONG_MAX;
>>>> +               goto select;
>>>> +       }
>>>> +
>>>> +       switch (bpf_oom_evaluate_task(task, oc)) {
>>>> +       case BPF_EVAL_ABORT:
>>>> +               goto abort; /* abort search process */
>>>> +       case BPF_EVAL_NEXT:
>>>> +               goto next; /* ignore the task */
>>>> +       case BPF_EVAL_SELECT:
>>>> +               goto select; /* select the task */
>>>> +       default:
>>>> +               break; /* No BPF policy */
>>>> +       }
>>>> +
>>>
>>> I think forcing bpf prog to look at every task is going to be limiting
>>> long term.
>>> It's more flexible to invoke bpf prog from out_of_memory()
>>> and if it doesn't choose a task then fallback to select_bad_process().
>>> I believe that's what Roman was proposing.
>>> bpf can choose to iterate memcg or it might have some side knowledge
>>> that there are processes that can be set as oc->chosen right away,
>>> so it can skip the iteration.
>>
>> IIUC, We may need some new bpf features if we want to iterating
>> tasks/memcg in BPF, sush as:
>> bpf_for_each_task
>> bpf_for_each_memcg
>> bpf_for_each_task_in_memcg
>> ...
>>
>> It seems we have some work to do first in the BPF side.
>> Will these iterating features be useful in other BPF scenario except OOM
>> Policy?
> 
> Yes.
> Use open coded iterators though.
> Like example in
> https://lore.kernel.org/all/20230810183513.684836-4-davemarchevsky@fb.com/
> 
> bpf_for_each(task_vma, vma, task, 0) { ... }
> will safely iterate vma-s of the task.
> Similarly struct css_task_iter can be hidden inside bpf open coded iterator.
OK. I think the following APIs whould be useful and I am willing to 
start with these in another bpf-next RFC patchset:

1. bpf_for_each(task). Just like for_each_process(p) in kernel to 
itearing all tasks in the system with rcu_read_lock().

2. bpf_for_each(css_task, task, css). It works like 
css_task_iter_{start, next, end} and would be used to iterating 
tasks/threads under a css.

3. bpf_for_each(descendant_css, css, root_css, {PRE, POST}). It works 
like css_next_descendant_{pre, post} to iterating all descendant.

If you have better ideas or any advice, please let me know.
Thanks.

