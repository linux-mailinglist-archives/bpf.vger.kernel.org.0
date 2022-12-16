Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EC64EE90
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiLPQIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiLPQHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 11:07:37 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22C19C
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 08:07:02 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p6DEg-000BUc-7j; Fri, 16 Dec 2022 17:06:58 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p6DEf-000XbE-RT; Fri, 16 Dec 2022 17:06:57 +0100
Subject: Re: [bpf-next v2 1/2] bpf: add runtime stats, max cost
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
 <553c4d32-aac1-f5d2-8f39-86cdca1af0d6@meta.com>
 <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <425c20bd-9e7e-4fc7-9050-7d9e9bfce972@iogearbox.net>
Date:   Fri, 16 Dec 2022 17:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAMDZJNW+c0JkgZ0XOtq674cjXeof+U0D54yd8JBzizuQioDt3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26752/Fri Dec 16 09:25:27 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/22 10:05 AM, Tonghao Zhang wrote:
> On Fri, Dec 16, 2022 at 1:40 PM Yonghong Song <yhs@meta.com> wrote:
>> On 12/14/22 8:32 PM, xiangxia.m.yue@gmail.com wrote:
>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>
>>> Now user can enable sysctl kernel.bpf_stats_enabled to fetch
>>> run_time_ns and run_cnt. It's easy to calculate the average value.
>>>
>>> In some case, the max cost for bpf prog invoked, are more useful:
>>> is there a burst sysload or high cpu usage. This patch introduce
>>> a update stats helper.
>>
>> I am not 100% sure about how this single max value will be useful
>> in general. A particular max_run_time_ns, if much bigger than average,
>> could be an outlier due to preemption/softirq etc.
>> What you really need might be a trend over time of the run_time
>> to capture the burst. You could do this by taking snapshot of
> Hi
> If the bpf prog is invoked frequently,  the run_time_ns/run_cnt may
> not be increased too much while
> there is a maxcost in bpf prog. The max cost value means there is at
> least one high cost in bpf prog.
> we should take care of the most cost of bpf prog. especially, much
> more than run_time_ns/run_cnt.

But then again, see Yonghong's comment with regards to outliers. I
think what you're probably rather asking for is something like tracking
p50/p90/p99 run_time_ns numbers over time to get a better picture. Not
sure how single max cost would help, really..

>> run_time_ns/run_cnt periodically and plot the trend of average
>> run_time_ns which might correlate with other system activity.
>> Maybe I missed some use cases for max_run_time_ns...
>>
>>>
>>> $ bpftool --json --pretty p s
>>>      ...
>>>      "run_max_cost_ns": 313367
>>>
>>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Hou Tao <houtao1@huawei.com>
>>> ---
>>> v2: fix build warning
>>> ---
>>>    include/linux/filter.h   | 29 ++++++++++++++++++++++-------
>>>    include/uapi/linux/bpf.h |  1 +
>>>    kernel/bpf/syscall.c     | 10 +++++++++-
>>>    kernel/bpf/trampoline.c  | 10 +---------
>>>    4 files changed, 33 insertions(+), 17 deletions(-)
>>>
>> [...]
> 
> 
> 

