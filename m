Return-Path: <bpf+bounces-11014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA17B10F7
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 04:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 954F71C20949
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6C5225;
	Thu, 28 Sep 2023 02:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83025A50
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 02:51:52 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB52C122
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 19:51:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690ba63891dso9661713b3a.2
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695869510; x=1696474310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxowYtqCHs25qaqAMSozKR4qYyXzSppOa5N6Ri1v7lw=;
        b=V/AUFgeVnMxiWuev+g71ntnlhTFnh3fmdxhsURsp9MlliZH9b+mw5RlLrtNLwON2iv
         66gIgOdN0dz8tROhDCmgTHnr2ZTfa5oeQehHAx04SgDDsw8DnYB4xTTxaWT3uToHS36H
         heApkcxDQeoLP1wXRjvKIF6hr9/x4PB4rT6AgP5f/vULA0ezpkXBmN4bzYVATSj5gyU9
         3PX6rLhjLOFxu4g46ee3lCky+XqCB6gSOK4Tw3por5lwc18cEHIcGCKbRwr7BgUjvmcW
         BNS4WsrEeyidcvA05+mAKFw8/gt5M0UsFx8pj045r28z06LBLiihxwT5K+lYdB4m5IiG
         6seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695869510; x=1696474310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZxowYtqCHs25qaqAMSozKR4qYyXzSppOa5N6Ri1v7lw=;
        b=YNB6cQqRgvj5iNBsMAEbMXVMiktL1yECvwMY6J6oskHSbUu3nenI5xY4/3hN96sVtW
         M16ExiRl4l3pxlTSTYq6FO70x5ZwP6+zVWxqOShxBHCz3ynif7+SmPPFqy2eXku2n6NX
         hmOM0SWZlbZIbRk6IVNC6pSEp6v0F3HG9UPCX/jz9DnAJxAo9VqC00p1tbO+iaEErDCu
         xU4+8p0vK+XCpQoGE7reEx3J/TQTBL29c253eVJ+jo7+SUEpRX9bD4Usjh+05mtq3jN6
         ZpwqmjYAE1TN3/G3Os0li1DjfJpRlzHtfouGNYwyQ6nxQol6w+NSZ7TrtAbW8nUmhUiz
         +92w==
X-Gm-Message-State: AOJu0YyzBLfe+CpAT5bKV/ZGZCCw3CoKOQ/M+UN/j4V9xdGsq3JJ+2rk
	v4h5/8TNUpzeFglrA1KnIG1ZuQ==
X-Google-Smtp-Source: AGHT+IGV6hbjpD+iwlxnv3egrK1x6PxftppEsP97nF7d/SVaEZe4d9dHDpT0zGQ0GKrkPxmq43gp3A==
X-Received: by 2002:a05:6a20:3d0f:b0:135:110c:c6e1 with SMTP id y15-20020a056a203d0f00b00135110cc6e1mr9636pzi.7.1695869509996;
        Wed, 27 Sep 2023 19:51:49 -0700 (PDT)
Received: from [10.255.173.165] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b0026801e06ac1sm13818445pjg.30.2023.09.27.19.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 19:51:49 -0700 (PDT)
Message-ID: <27b57638-48db-7082-2b53-93d84e423350@bytedance.com>
Date: Thu, 28 Sep 2023 10:51:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce css open-coded iterator
 kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-5-zhouchuyi@bytedance.com>
 <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/9/28 07:24, Andrii Nakryiko 写道:
> On Mon, Sep 25, 2023 at 3:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css in open-coded iterator
>> style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
>> css_iter can be used to:
>>
>> 1) iterating a sepcific cgroup tree with pre/post/up order
>>
>> 2) iterating cgroup_subsystem in BPF Prog, like
>> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
>>
>> The API design is consistent with cgroup_iter. bpf_iter_css_new accepts
>> parameters defining iteration order and starting css. Here we also reuse
>> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
>> BPF_CGROUP_ITER_ANCESTORS_UP enums.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/cgroup_iter.c                      | 57 +++++++++++++++++++
>>   kernel/bpf/helpers.c                          |  3 +
>>   .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
>>   3 files changed, 66 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
>> index 810378f04fbc..ebc3d9471f52 100644
>> --- a/kernel/bpf/cgroup_iter.c
>> +++ b/kernel/bpf/cgroup_iter.c
>> @@ -294,3 +294,60 @@ static int __init bpf_cgroup_iter_init(void)
>>   }
>>
>>   late_initcall(bpf_cgroup_iter_init);
>> +
>> +struct bpf_iter_css {
>> +       __u64 __opaque[2];
>> +       __u32 __opaque_int[1];
>> +} __attribute__((aligned(8)));
>> +
> 
> same as before, __opaque[3] only
> 
> 
>> +struct bpf_iter_css_kern {
>> +       struct cgroup_subsys_state *start;
>> +       struct cgroup_subsys_state *pos;
>> +       int order;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
>> +               struct cgroup_subsys_state *start, enum bpf_cgroup_iter_order order)
> 
> Similarly, I wonder if we should go for a more generic "flags" argument?
> 
>> +{
>> +       struct bpf_iter_css_kern *kit = (void *)it;
> 
> empty line
> 
>> +       kit->start = NULL;
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) != sizeof(struct bpf_iter_css));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) != __alignof__(struct bpf_iter_css));
> 
> please move this up before kit->start assignment, and separate by empty lines
> 
>> +       switch (order) {
>> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
>> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
>> +       case BPF_CGROUP_ITER_ANCESTORS_UP:
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       kit->start = start;
>> +       kit->pos = NULL;
>> +       kit->order = order;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it)
>> +{
>> +       struct bpf_iter_css_kern *kit = (void *)it;
> 
> empty line
> 
>> +       if (!kit->start)
>> +               return NULL;
>> +
>> +       switch (kit->order) {
>> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
>> +               kit->pos = css_next_descendant_pre(kit->pos, kit->start);
>> +               break;
>> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
>> +               kit->pos = css_next_descendant_post(kit->pos, kit->start);
>> +               break;
>> +       default:
> 
> we know it's BPF_CGROUP_ITER_ANCESTORS_UP, so why not have that here explicitly?
> 
>> +               kit->pos = kit->pos ? kit->pos->parent : kit->start;
>> +       }
>> +
>> +       return kit->pos;
> 
> wouldn't this implementation never return the "start" css? is that intentional?
> 

Thanks for the review.

This implementation actually would return the "start" css.

1. BPF_CGROUP_ITER_DESCENDANTS_PRE:
1.1 when we first call next(), css_next_descendant_pre(NULL, kit->start) 
will return kit->start.
1.2 second call next(), css_next_descendant_pre(kit->start, kit->start) 
would return a first valid child under kit->start with pre-order
1.3 third call next, css_next_descendant_pre(last_valid_child, 
kit->start) would return the next valid child
...
util css_next_descendant_pre return a NULL pointer, which means we have 
visited all valid child including "start" css itself.

The above logic is equal to macro 'css_for_each_descendant_pre' in kernel.

Same, BPF_CGROUP_ITER_DESCENDANTS_POST is equal to macro 
'css_for_each_descendant_post' which would return 'start' css when we 
have visited all valid child.

2. BPF_CGROUP_ITER_ANCESTORS_UP
2.1 when we fisrt call next(), kit->pos is NULL, and we would return 
kit->start.


The selftest in patch7 whould check:
1. when we use BPF_CGROUP_ITER_DESCENDANTS_PRE to iterate a cgroup tree, 
the first cgroup we visted should be root('start') cgroup.
2. when we use BPF_CGROUP_ITER_DESCENDANTS_POST to iterate a cgroup 
tree, the last cgroup we visited should be root('start') cgroup.


Am I miss something important?


Thanks.




