Return-Path: <bpf+bounces-6396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6EF768B77
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1F1C20B21
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194DDA52;
	Mon, 31 Jul 2023 06:00:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B187F8
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 06:00:33 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8C10C
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:00:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb2468257fso23240875ad.0
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 23:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690783230; x=1691388030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em7nleQj8/QQEFVzlIkyFVMASePMWNKx3y98kE9uwNQ=;
        b=dldsRSCJQFwuK2l9ZcBL05envBRIJqkvMzjodoHk30Blc6IdlOTtICFtDkXghNf+iq
         mTX8zzlUratw+gEy6YMXrG/rUEs4lRn6y0gKYILeyPXHTm76YmWdwOxgNJW113Nat0SW
         zxiDlTBc1pwC88p5f0nsheAMdICqkY50WVKd8PzbqEi5JvIZUVTcGws+V4V08w9LLYeE
         ohgoz6ZhiS00Bqh/tc2D0GLrkgB4qdLc3PtGoM93/Mb9vc1flLMAQjfIvLOQC+Jzx4C/
         GN09XSbcyVDVRZD/cbbVZ797WQ0KiPWBeRUY+s7VUZ3EERfhZv32rNGAN8YAaOy7L3cf
         iwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690783230; x=1691388030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=em7nleQj8/QQEFVzlIkyFVMASePMWNKx3y98kE9uwNQ=;
        b=EpP4AnLpN9KZcPdbpIcjIze4uSp1yYzyz1GC5DcY+1Qr3q3xesTDGJ4i8I+Euvfm9k
         GThX8gr2wxmHdnCtEDtUkjypNK4YT/v9v8R113eR/F3zlDxEPUMO2v3+Kbgp+A20ln6N
         QwhPCiwzqkyxRFq5sVtYad1kVJbEh8ZH1wmsjXYuN5h0OmUUn/e9wSbi2E7eMM4aC0dT
         Nn25YOie/m6B3n7GGM3zbOWfZxvhUSuTh2OsnEbdpKPXOV4sayKxksP+1vOS5HNGD6x/
         1KMdg9POzSHo5kqDfGUCM7u+rhvSZn1+6kQ5+YXZ8zZUOeNbQTm8AErrUjUJotqD07+o
         0SKw==
X-Gm-Message-State: ABy/qLZ5TqRKZTnRA1qGBMff98XWnTxatREMAfgYX0IRrsEypKUfI1iK
	QGU6HA5k9pkyEafZ2VxZw6mMEpaYVdv3clsKO/DO9g==
X-Google-Smtp-Source: APBJJlHZZSc9dJ9qu9qrkt7dE6L7mX9gGRYbkNSq8qmUHZhR29HSUSu76jBuHxVR/SPTz+fXUzYZHQ==
X-Received: by 2002:a17:903:1246:b0:1bb:a367:a70 with SMTP id u6-20020a170903124600b001bba3670a70mr8836498plh.17.1690783230548;
        Sun, 30 Jul 2023 23:00:30 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001b9e9f191f2sm7558117plr.15.2023.07.30.23.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:00:30 -0700 (PDT)
Message-ID: <eb764131-6d2f-c088-5481-99d605a67349@bytedance.com>
Date: Mon, 31 Jul 2023 14:00:22 +0800
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
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZMKoAfGRgkl4rmtj@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Michal

在 2023/7/28 01:23, Michal Hocko 写道:
> On Thu 27-07-23 20:12:01, Chuyi Zhou wrote:
>>
>>
>> 在 2023/7/27 16:15, Michal Hocko 写道:
>>> On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
>>>> This patchset tries to add a new bpf prog type and use it to select
>>>> a victim memcg when global OOM is invoked. The mainly motivation is
>>>> the need to customizable OOM victim selection functionality so that
>>>> we can protect more important app from OOM killer.
>>>
>>> This is rather modest to give an idea how the whole thing is supposed to
>>> work. I have looked through patches very quickly but there is no overall
>>> design described anywhere either.
>>>
>>> Please could you give us a high level design description and reasoning
>>> why certain decisions have been made? e.g. why is this limited to the
>>> global oom sitation, why is the BPF program forced to operate on memcgs
>>> as entities etc...
>>> Also it would be very helpful to call out limitations of the BPF
>>> program, if there are any.
>>>
>>> Thanks!
>>
>> Hi,
>>
>> Thanks for your advice.
>>
>> The global/memcg OOM victim selection uses process as the base search
>> granularity. However, we can see a need for cgroup level protection and
>> there's been some discussion[1]. It seems reasonable to consider using memcg
>> as a search granularity in victim selection algorithm.
> 
> Yes, it can be reasonable for some policies but making it central to the
> design is very limiting.
> 
>> Besides, it seems pretty well fit for offloading policy decisions to a BPF
>> program, since BPF is scalable and flexible. That's why the new BPF
>> program operate on memcgs as entities.
> 
> I do not follow your line of argumentation here. The same could be
> argued for processes or beans.
> 
>> The idea is to let user choose which leaf in the memcg tree should be
>> selected as the victim. At the first layer, if we choose A, then it protects
>> the memcg under the B, C, and D subtrees.
>>
>>          root
>>       /   ｜ \  \
>>      A    B  C  D
>>     /\
>>    E F
>>
>>
>> Using the BPF prog, we are allowed to compare the OOM priority between
>> two siblings so that we can choose the best victim in each layer.
> 
> How is the priority defined and communicated to the userspace.
> 
>> For example:
>>
>> run_prog(B, C) -> choose B
>> run_prog(B, D) -> choose D
>> run_prog(A, D) -> choose A
>>
>> Once we select A as the victim in the first layer, the victim in next layer
>> would be selected among A's children. Finally, we select a leaf memcg as
>> victim.
> 
> This sounds like a very specific oom policy and that is fine. But the
> interface shouldn't be bound to any concepts like priorities let alone
> be bound to memcg based selection. Ideally the BPF program should get
> the oom_control as an input and either get a hook to kill process or if
> that is not possible then return an entity to kill (either process or
> set of processes).

Here are two interfaces I can think of. I was wondering if you could 
give me some feedback.

1. Add a new hook in select_bad_process(), we can attach it and return a 
set of pids or cgroup_ids which are pre-selected by user-defined policy, 
  suggested by Roman. Then we could use oom_evaluate_task to find a 
final victim among them. It's user-friendly and we can offload the OOM 
policy to userspace.

2. Add a new hook in oom_evaluate_task() and return a point to override 
the default oom_badness return-value. The simplest way to use this is to 
protect certain processes by setting the minimum score.

Of course if you have a better idea, please let me know.

Thanks!
---
Chuyi Zhou
> 
>> In our scenarios, the impact caused by global OOM's is much more common, so
>> we only considered global in this patchset. But it seems that the idea can
>> also be applied to memcg OOM.
> 
> The global and memcg OOMs shouldn't have a different interface. If a
> specific BPF program wants to implement a different policy for global
> vs. memcg OOM then be it but this should be a decision of the said
> program not an inherent limitation of the interface.
> 
>>
>> [1]https://lore.kernel.org/lkml/ZIgodGWoC%2FR07eak@dhcp22.suse.cz/
>>
>> Thanks!
>> -- 
>> Chuyi Zhou
> 

