Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5526637D4
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 04:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjAJD3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 22:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAJD3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 22:29:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CDC1EEF9;
        Mon,  9 Jan 2023 19:29:09 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nrbps3lCnznVBX;
        Tue, 10 Jan 2023 11:27:33 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 11:29:06 +0800
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, Song Liu <song@kernel.org>,
        <bpf@vger.kernel.org>, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221118190109.1512674-1-namhyung@kernel.org>
 <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
 <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com>
 <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <6e4ec7a4-9ac9-417c-c11a-de59e72a6e42@huawei.com>
Date:   Tue, 10 Jan 2023 11:29:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Martin,

On 1/10/2023 5:22 AM, Martin KaFai Lau wrote:
> On 1/9/23 12:56 PM, Namhyung Kim wrote:
>> Hello,
>>
>> On Mon, Nov 21, 2022 at 9:33 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 11/18/22 11:01 AM, Namhyung Kim wrote:
>>>> We could fix the task local storage to use the safe BPF allocator,
>>>> but it takes time so let's change this until it happens actually.
>>>
>>> I also got another report on the kfree_rcu path.  I am also looking into this
>>> direction on using the BPF allocator.
>>
>> Any progress on this?  Are there any concerns about the change?
>
> Yep, I am working on it. It is not a direct replacement from kzalloc to
> bpf_mem_cache_alloc. eg. Some changes in the bpf mem allocator is needed to
> ensure the free list cannot be reused before the rcu grace period. There is a
> similar RFC patchset going into this direction that I am trying with.
>
> .
Do you mean "[RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc"
[0], right ? The main concern [1] for the proposal is the possibility of OOM
will increase when RCU tasks trace grace period is slow, because the immediate
reuse is disabled and the reuse is only possible after one RCU tasks trace grace
period. Using a memory cgroup and setting a hard-limit on the cgroup may reduce
the influence of the OOM problem, but it is not good enough. So do you have
other ways to mitigate the potential OOM problem ?

[0]: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
[1]:
https://lore.kernel.org/bpf/CAADnVQ+z-Y6Yv2i-icAUy=Uyh9yiN4S1AOrLd=K8mu32TXORkw@mail.gmail.com/
