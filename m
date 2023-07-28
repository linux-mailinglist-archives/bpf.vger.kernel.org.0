Return-Path: <bpf+bounces-6150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363987661D0
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674E91C217BC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EB185E;
	Fri, 28 Jul 2023 02:34:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD110E6
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 02:34:48 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AE30DA
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76c7eb57c0bso14799885a.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690511686; x=1691116486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV2OpDFH9mfKiN5o/E3y0+fHFzEHfVifc7bcrvvmdpQ=;
        b=UCo6nPeWk10retrRAhiA6H/0n5V5NFnkQ751kF/vzVAogJRK/dpbvJ2g4b9H6IZCI2
         xro41pT6S1Whnx9E6Tej+DWrF9WguAIzzvVzwgrkryXtS0Dq4KDolRKNu8lQIn69uuYs
         WGDGNgzZRXaHPeESlqnZ1CfsZAXGtU8d/KrPmfXxE/nQHNkpH6tDCy5+ZWuuXrKJIZPW
         D1NZsW9BQN8miX6Rx9ZF3NAsi5bLvkme3Osc3Sijq6nUtED5JgLXQJtsA/5jkJYxIlLx
         9gJj07IG8b17oBr8Ojk3Ph2KRe2WzlKrkshjVsZiBd5EIvesEJr8cfeMLkxZWBUN/lNH
         /B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690511686; x=1691116486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iV2OpDFH9mfKiN5o/E3y0+fHFzEHfVifc7bcrvvmdpQ=;
        b=VVoXFBVSJ+iDhwa7R5eR371OYstbEK9PMyyfr9+kkLHG+qNpP2x1S/F4DKCfEQqQEu
         V3paV1lC7W1WjotKrU7nYX1sfe4g3mYHIK1ZmjbXpU9st2itEPqumWwzsdGQM/jTh1V3
         hAuiArS39tyaORky9zr3Fmhz8xph5N9Gw/goQRbRoUurJpsHYahDnX20XEB9RQoC8lHP
         kcZqBFJbb4AVxADjWdx5m5zls1lGUcxTDuEK7HSSLN/GunsvhoCguweIyCRkEdF8drjq
         Ncv+4lp2HQ7FNAyWxzFjgRW2AHyG20QjkfZK0dXETNU16u4SC2wHYnNfgMwM0FlYfLVl
         UcSw==
X-Gm-Message-State: ABy/qLaN8Pxljt1DQRk+G5ID8+7PATXtVZV9R7NsHveJ5q6k2QlB+vdU
	70/Rrkcuy5EWULw4HG++2NlKaw==
X-Google-Smtp-Source: APBJJlG4B7eb1CM0q5XNynOuTLstLOf606ewnMNnGA0lykt65q4xWGc03YqffuMWfSsD75HOGencBw==
X-Received: by 2002:a05:620a:2951:b0:768:efd:2685 with SMTP id n17-20020a05620a295100b007680efd2685mr1553377qkp.33.1690511686024;
        Thu, 27 Jul 2023 19:34:46 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a19c900b00267f7405a3csm1876445pjj.32.2023.07.27.19.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 19:34:45 -0700 (PDT)
Message-ID: <4555470c-ea4f-244b-ed40-9403df3f5e4f@bytedance.com>
Date: Fri, 28 Jul 2023 10:34:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [External] Re: [RFC PATCH 0/5] mm: Select victim memcg using
 BPF_OOM_POLICY
To: Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <7dbaabf9-c7c6-478b-0d07-b4ce0d7c116c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

在 2023/7/27 19:43, Alan Maguire 写道:
> On 27/07/2023 08:36, Chuyi Zhou wrote:
>> This patchset tries to add a new bpf prog type and use it to select
>> a victim memcg when global OOM is invoked. The mainly motivation is
>> the need to customizable OOM victim selection functionality so that
>> we can protect more important app from OOM killer.
>>
> 
> It's a nice use case, but at a high level, the approach pursued here
> is, as I understand it, discouraged for new BPF program development.
> Specifically, adding a new BPF program type with semantics like this
> is not preferred. Instead, can you look at using something like
> 
> - using "fmod_ret" instead of a new program type
> - use BPF kfuncs instead of helpers.
> - add selftests in tools/testing/selftests/bpf not samples.
> 
> There's some examples of how solutions have evolved from the traditional
> approach (adding a new program type, helpers etc) to using kfuncs etc on
> this list - for example HID-BPF and the BPF scheduler series - which
> should help orient you. There are presentations from Linux Plumbers 2022
> that walk through some of this too.
> 
> Judging by the sample program example, all you should need here is a way
> to override the return value of bpf_oom_set_policy() - a noinline
> function that by default returns a no-op. It can then be overridden by
> an "fmod_ret" BPF program.
> 
Indeed, I'll try to use kfuncs & fmod_ret.

Thanks for your advice.
--
Chuyi Zhou
> One thing you lose is cgroup specificity at BPF attach time, but you can
> always add predicates based on the cgroup to your BPF program if needed.
> 
> Alan
> 
>> Chuyi Zhou (5):
>>    bpf: Introduce BPF_PROG_TYPE_OOM_POLICY
>>    mm: Select victim memcg using bpf prog
>>    libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
>>    bpf: Add a new bpf helper to get cgroup ino
>>    bpf: Sample BPF program to set oom policy
>>
>>   include/linux/bpf_oom.h        |  22 ++++
>>   include/linux/bpf_types.h      |   2 +
>>   include/linux/memcontrol.h     |   6 ++
>>   include/uapi/linux/bpf.h       |  21 ++++
>>   kernel/bpf/core.c              |   1 +
>>   kernel/bpf/helpers.c           |  17 +++
>>   kernel/bpf/syscall.c           |  10 ++
>>   mm/memcontrol.c                |  50 +++++++++
>>   mm/oom_kill.c                  | 185 +++++++++++++++++++++++++++++++++
>>   samples/bpf/Makefile           |   3 +
>>   samples/bpf/oom_kern.c         |  42 ++++++++
>>   samples/bpf/oom_user.c         | 128 +++++++++++++++++++++++
>>   tools/bpf/bpftool/common.c     |   1 +
>>   tools/include/uapi/linux/bpf.h |  21 ++++
>>   tools/lib/bpf/libbpf.c         |   3 +
>>   tools/lib/bpf/libbpf_probes.c  |   2 +
>>   16 files changed, 514 insertions(+)
>>   create mode 100644 include/linux/bpf_oom.h
>>   create mode 100644 samples/bpf/oom_kern.c
>>   create mode 100644 samples/bpf/oom_user.c
>>

