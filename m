Return-Path: <bpf+bounces-7949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322477EF31
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 04:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531511C20EF5
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 02:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194D638;
	Thu, 17 Aug 2023 02:51:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848D36A
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 02:51:29 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BF26AA
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:51:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5656a5c6721so3869666a12.1
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692240688; x=1692845488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TD6mNxeyw+U1f9pkCyXqwGO/txSI845aPMGT3hSQf0=;
        b=jizqnOxjdEbUD5086Ckpc7OSvC4Rk9TkWmZE7lpEUUGVhg+QcTTlPi9anyttQVFXd2
         +sDEHFe2C/NC2V6iRyU+EQZXreN8vAXEZ8Etz+T/FUws0cd6VUk0yIlS7A3lCYHPCA+Y
         YdIt/IHzdQcsfP4Nx8JLC8RqbG2m7srUR8jw9BZyK2VJXbKm/UjmNkKumZ4qQNaOuamg
         ZSiuR1IzvO6h3FpsnKHreFP3JcWyY+8ixLtKbz40IDLZRZq5tkqx6dnRcKqcYZrst10e
         v776ZLIytHkGoJRWQiXHvK/qkCVpdNwGWO60juMTlgV3tkqk4WuN1pBfA8t4vM9ZuNS8
         Zfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692240688; x=1692845488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TD6mNxeyw+U1f9pkCyXqwGO/txSI845aPMGT3hSQf0=;
        b=AJcpdyH6byEZ8y1qijJ3i5R9iMb+FsMkQc9UfgUE9NWp6Gxy//jPkZkAj0sIOCzXfk
         yxqwphClBX4ANoFgGIrf0Z4Usgl8BoFmNLRBqqyUhvfgNFwLK7y3DDM0mSDvsiZJkmt+
         SyzeMgvm2jn+q8FPySfgkiTDsE6mce2gccOL9N2Yoi06v4LB4LE5rNkkPRaxXYT3VcrQ
         N593fpbrk1p6Cc0uEt4Ed8KPnRPITboeYm57ATCUJ63zxAsJW7g6lA8sPV7Wy8G8mGxl
         eB8rivXcbPSPX95Hu5B2B4tg7TkNOXZ0i9jE2S+rFO4AOHWYOw2TBh4RiYsdGDFtD8XJ
         9JaA==
X-Gm-Message-State: AOJu0YyjgGVT/R6WceI7BADO1iuOHg/xR/opZQQu171iGpcw0ld3pDlZ
	xmlDsaGBfXkq6mItzA4sXw82cZ3JaMNZR5LCZXs3Yw==
X-Google-Smtp-Source: AGHT+IHfb0/3FQbkhCSWRAodHC02wS+x8X5xLd/zAGU4Lf/Hcv1saB6KyDx5K03DjGqOSi9A5G1DFQ==
X-Received: by 2002:a05:6a20:8f07:b0:13d:bd0e:33d9 with SMTP id b7-20020a056a208f0700b0013dbd0e33d9mr4945857pzk.47.1692240687678;
        Wed, 16 Aug 2023 19:51:27 -0700 (PDT)
Received: from [10.255.89.48] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id j15-20020aa78d0f000000b00687dde8ae5dsm11692252pfe.154.2023.08.16.19.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 19:51:27 -0700 (PDT)
Message-ID: <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
Date: Thu, 17 Aug 2023 10:51:19 +0800
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
 Andrii Nakryiko <andrii@kernel.org>, muchun.song@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com,
 Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/8/17 10:07, Alexei Starovoitov 写道:
> On Thu, Aug 10, 2023 at 1:13 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>   static int oom_evaluate_task(struct task_struct *task, void *arg)
>>   {
>>          struct oom_control *oc = arg;
>> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>>          if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>>                  goto next;
>>
>> +       /*
>> +        * If task is allocating a lot of memory and has been marked to be
>> +        * killed first if it triggers an oom, then select it.
>> +        */
>> +       if (oom_task_origin(task)) {
>> +               points = LONG_MAX;
>> +               goto select;
>> +       }
>> +
>> +       switch (bpf_oom_evaluate_task(task, oc)) {
>> +       case BPF_EVAL_ABORT:
>> +               goto abort; /* abort search process */
>> +       case BPF_EVAL_NEXT:
>> +               goto next; /* ignore the task */
>> +       case BPF_EVAL_SELECT:
>> +               goto select; /* select the task */
>> +       default:
>> +               break; /* No BPF policy */
>> +       }
>> +
> 
> I think forcing bpf prog to look at every task is going to be limiting
> long term.
> It's more flexible to invoke bpf prog from out_of_memory()
> and if it doesn't choose a task then fallback to select_bad_process().
> I believe that's what Roman was proposing.
> bpf can choose to iterate memcg or it might have some side knowledge
> that there are processes that can be set as oc->chosen right away,
> so it can skip the iteration.

IIUC, We may need some new bpf features if we want to iterating 
tasks/memcg in BPF, sush as:
bpf_for_each_task
bpf_for_each_memcg
bpf_for_each_task_in_memcg
...

It seems we have some work to do first in the BPF side.
Will these iterating features be useful in other BPF scenario except OOM 
Policy?

Thanks.

