Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1633663959
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 07:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAJG3T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 01:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjAJG3S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 01:29:18 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400F395D1;
        Mon,  9 Jan 2023 22:29:17 -0800 (PST)
Message-ID: <5e8cc542-763b-9db2-55e4-fb59920bc145@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673332155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8r5fNA8nobsSLbYvyb9u+9ODco9RBnJ4ampTJzFDYfg=;
        b=JHAgrk/sFWXz8USqHZlbwdzL46r9Wd9A6x2MF7OL1T7YTsYT+8LdCAJ3NajtXxkvnm86Et
        jr9ZrWp18QEwhRVPxVQQButU0Jnnse1XSI5W/fibYryQHlmQ2fyTyB/FeRMvFBUP9MLjY6
        fTN71sWVP1dkLd2k91S4Q+uZPY7cPlo=
Date:   Mon, 9 Jan 2023 22:29:11 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
Content-Language: en-US
To:     Hou Tao <houtao1@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221118190109.1512674-1-namhyung@kernel.org>
 <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
 <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com>
 <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
 <6e4ec7a4-9ac9-417c-c11a-de59e72a6e42@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <6e4ec7a4-9ac9-417c-c11a-de59e72a6e42@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/23 7:29 PM, Hou Tao wrote:
> Hi Martin,
> 
> On 1/10/2023 5:22 AM, Martin KaFai Lau wrote:
>> On 1/9/23 12:56 PM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Mon, Nov 21, 2022 at 9:33 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 11/18/22 11:01 AM, Namhyung Kim wrote:
>>>>> We could fix the task local storage to use the safe BPF allocator,
>>>>> but it takes time so let's change this until it happens actually.
>>>>
>>>> I also got another report on the kfree_rcu path.  I am also looking into this
>>>> direction on using the BPF allocator.
>>>
>>> Any progress on this?  Are there any concerns about the change?
>>
>> Yep, I am working on it. It is not a direct replacement from kzalloc to
>> bpf_mem_cache_alloc. eg. Some changes in the bpf mem allocator is needed to
>> ensure the free list cannot be reused before the rcu grace period. There is a
>> similar RFC patchset going into this direction that I am trying with.
>>
>> .
> Do you mean "[RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc"
> [0], right ? 
Yes, that is the RFC patch I was referring :). I was planning to comment after 
looking at the patch in details. I have shared some of my quick thoughts in that 
thread for the local storage usages.

> The main concern [1] for the proposal is the possibility of OOM
> will increase when RCU tasks trace grace period is slow, because the immediate
> reuse is disabled and the reuse is only possible after one RCU tasks trace grace
> period. Using a memory cgroup and setting a hard-limit on the cgroup may reduce
> the influence of the OOM problem, but it is not good enough. So do you have
> other ways to mitigate the potential OOM problem ?
> 
> [0]: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
> [1]:
> https://lore.kernel.org/bpf/CAADnVQ+z-Y6Yv2i-icAUy=Uyh9yiN4S1AOrLd=K8mu32TXORkw@mail.gmail.com/

