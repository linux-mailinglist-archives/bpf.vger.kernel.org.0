Return-Path: <bpf+bounces-6457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D0769C6C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC432815B4
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472A19BCF;
	Mon, 31 Jul 2023 16:27:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE19BA5
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 16:27:04 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D419B4
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 09:26:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ba97e4feso4693109b3a.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690820789; x=1691425589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/MiFfu9tPYeXVglZpwTrqc79/Tf0xFhn2mjwPUBe7Q=;
        b=E7/jZLcFy0BdDB40Wr58LQIa/9rCmKdwj/UrJY2MkPfj6deYx+QDtBk3jhgbGze2yM
         y9C1dEnGWtf8gaZjUtMrvzDe6pDtiK/NxixnkYTIO476utr1htUSH7qVFceloNeTtfE6
         65gt6xQvJKgfxt9579Q36DBNmA03D/K3uI60Aa2AbVv2RLhZgQHcjVwXYwLek5C/biHI
         0orUDFohnL88kCM/60bSpx6EEjDLquo41H/hnE0IEJqXb7HQgcDZdnKT06t2Z4RHU/aY
         CWmPqXn2mWBLFueSr2Mo1ExfWS0mXhi7aluYZafd2MnJaYeyc+3V4arnfljTybukHNUF
         wt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820789; x=1691425589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/MiFfu9tPYeXVglZpwTrqc79/Tf0xFhn2mjwPUBe7Q=;
        b=hG4ImyIXH5yzw3Ju1IusewfolKzT7xTYTgPU9GhZMmibp+WVJi5q78qKMn6uaeUeIy
         vAZxPuL3vyLJ4KaqruGVxg7QfZO0SkKEvLskkfaqNUbSRDVQF04TLcSt67mwYqGLOnUk
         h/od35PZdjPcnT5i558mLiexvYq3zP52XWYGuwP1TnrUKNreFVpfcW1bArfoCjYnxP/z
         vQYAUG1Xr1nzlHSQytkckXnpnn6VtLtz8aRV+luswtEMfhfPAGoZ7nbBqkMZ1jIm2TNx
         md44OHLv3hRePKo+QBUFzQCPsyB8GwydFXq6iy++NwrFfHdWMU14znK+UA+9edZlqqZe
         cqCQ==
X-Gm-Message-State: ABy/qLb/n7qTf557bpEcfDs78YtOeyGrNtVgcuaax3qSXgmmk7mriVDR
	yqc8Cg9MnF/zFjeagcLJM/8WZw==
X-Google-Smtp-Source: APBJJlEb6PcYfCBQUFDxYSUFiZCUjoXWcwiIHeWf+KwmzsVEnd4aufwT/5lKZCAxH/vxpzLd70p47w==
X-Received: by 2002:a05:6a21:3b45:b0:11d:4c79:90ee with SMTP id zy5-20020a056a213b4500b0011d4c7990eemr10462907pzb.25.1690820788769;
        Mon, 31 Jul 2023 09:26:28 -0700 (PDT)
Received: from ?IPV6:fd00:6868:6868:0:10c9:ffcf:8f4f:89dd? ([2409:8a28:68e:4550::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a656aa3000000b0055fd10306a2sm7595760pgu.75.2023.07.31.09.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:26:28 -0700 (PDT)
Message-ID: <f8f44103-afba-10ee-b14b-a8e60a7f33d8@bytedance.com>
Date: Tue, 1 Aug 2023 00:26:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
 robin.lu@bytedance.com, muchun.song@linux.dev, zhengqi.arch@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <7347aad5-f25c-6b76-9db5-9f1be3a9f303@bytedance.com>
 <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
 <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
 <ZMe17kOoHr/eYnVT@dhcp22.suse.cz>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMe17kOoHr/eYnVT@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/7/31 21:23, Michal Hocko 写道:
> On Mon 31-07-23 14:00:22, Chuyi Zhou wrote:
>> Hello, Michal
>>
>> 在 2023/7/28 01:23, Michal Hocko 写道:
> [...]
>>> This sounds like a very specific oom policy and that is fine. But the
>>> interface shouldn't be bound to any concepts like priorities let alone
>>> be bound to memcg based selection. Ideally the BPF program should get
>>> the oom_control as an input and either get a hook to kill process or if
>>> that is not possible then return an entity to kill (either process or
>>> set of processes).
>>
>> Here are two interfaces I can think of. I was wondering if you could give me
>> some feedback.
>>
>> 1. Add a new hook in select_bad_process(), we can attach it and return a set
>> of pids or cgroup_ids which are pre-selected by user-defined policy,
>> suggested by Roman. Then we could use oom_evaluate_task to find a final
>> victim among them. It's user-friendly and we can offload the OOM policy to
>> userspace.
>>
>> 2. Add a new hook in oom_evaluate_task() and return a point to override the
>> default oom_badness return-value. The simplest way to use this is to protect
>> certain processes by setting the minimum score.
>>
>> Of course if you have a better idea, please let me know.
> 
> Hooking into oom_evaluate_task seems the least disruptive to the
> existing oom killer implementation. I would start by planing with that
> and see whether useful oom policies could be defined this way. I am not
> sure what is the best way to communicate user input so that a BPF prgram
> can consume it though. The interface should be generic enough that it
> doesn't really pre-define any specific class of policies. Maybe we can
> add something completely opaque to each memcg/task? Does BPF
> infrastructure allow anything like that already?
> 

“Maybe we can add something completely opaque to each memcg/task?”
Sorry, I don't understand what you mean.

I think we probably don't need to expose too much to the user, the 
following might be sufficient:

noinline int bpf_get_score(struct oom_control *oc,
		struct task_struct *task);

static int oom_evaluate_task()
{
	...
	points = bpf_get_score(oc, task);
	if (!check_points_valid(points))
          	points = oom_badness(task, oc->totalpages);
	...
}

There are several reasons:

1. The implementation of use-defined OOM policy, such as iteration, 
sorting and other complex operations, is more suitable to be placed in 
the userspace rather than in the bpf program. It is more convenient to 
implement these operations in userspace in which the useful information 
(memory usage of each task and memcg, memory allocation speed, etc.) can 
also be captured. For example, oomd implements multiple policies[1] 
without kernel-space input.

2. Userspace apps, such as oomd, can import useful information into bpf 
program, e.g., through bpf_map, and update it periodically. For example, 
we can do the scoring directly in userspace and maintain a score hash, 
so that in the bpf program, we only need to look for the corresponding 
score of the process.

Userspace policy（oomd）
          bpf_map_update
          score_hash
       ------------------>  BPF program
                               look up score in
                                score_hash
                             ---------------> kernel space
Just some thoughts.
Thanks!

[1]https://github.com/facebookincubator/oomd/tree/main/src/oomd/plugins)

