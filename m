Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0B65CDE3
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 08:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjADHvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 02:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjADHvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 02:51:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8315FFF
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 23:51:07 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nn1s555SpzJpvw;
        Wed,  4 Jan 2023 15:47:05 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 15:51:05 +0800
Subject: Re: [bpf-next v3 2/2] selftests/bpf: add test case for htab map
To:     Yonghong Song <yhs@meta.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20221219041551.69344-1-xiangxia.m.yue@gmail.com>
 <20221219041551.69344-2-xiangxia.m.yue@gmail.com>
 <c41daf29-43b4-8924-b5af-49f287ba8cdc@meta.com>
 <CAADnVQLE+M0xEK+L8Tu7fqsjFxNFdEyFvR4q3U1f1N1tomZ2bQ@mail.gmail.com>
 <ac540d41-4ac3-4d70-39e8-722e3fb360cd@meta.com>
 <CAMDZJNV_J-LmxxzX5DMGHQLm6WyYqG2GAMHb=WZvBG_y1rUOYg@mail.gmail.com>
 <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <dc658ded-719f-17bd-9166-e335a86150a6@huawei.com>
Date:   Wed, 4 Jan 2023 15:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <323005b1-67f6-9eec-46af-4952e133e1c4@meta.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 1/4/2023 3:09 PM, Yonghong Song wrote:
>
>
> On 1/2/23 6:40 PM, Tonghao Zhang wrote:
>>   a
>>
>> On Thu, Dec 29, 2022 at 2:29 PM Yonghong Song <yhs@meta.com> wrote:
>>>
>>>
>>>
>>> On 12/28/22 2:24 PM, Alexei Starovoitov wrote:
>>>> On Tue, Dec 27, 2022 at 8:43 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 12/18/22 8:15 PM, xiangxia.m.yue@gmail.com wrote:
>>>>>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>>>>>
>>>>>> This testing show how to reproduce deadlock in special case.
>>>>>> We update htab map in Task and NMI context. Task can be interrupted by
>>>>>> NMI, if the same map bucket was locked, there will be a deadlock.
>>>>>>
>>>>>> * map max_entries is 2.
>>>>>> * NMI using key 4 and Task context using key 20.
>>>>>> * so same bucket index but map_locked index is different.
>>>>>>
>>>>>> The selftest use perf to produce the NMI and fentry nmi_handle.
>>>>>> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
>>>>>> map syscall increase this counter in bpf_disable_instrumentation.
>>>>>> Then fentry nmi_handle and update hash map will reproduce the issue.
SNIP
>>>>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>> b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..d394f95e97c3
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>>>>> @@ -0,0 +1,32 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>>>>> +#include <linux/bpf.h>
>>>>>> +#include <bpf/bpf_helpers.h>
>>>>>> +#include <bpf/bpf_tracing.h>
>>>>>> +
>>>>>> +char _license[] SEC("license") = "GPL";
>>>>>> +
>>>>>> +struct {
>>>>>> +     __uint(type, BPF_MAP_TYPE_HASH);
>>>>>> +     __uint(max_entries, 2);
>>>>>> +     __uint(map_flags, BPF_F_ZERO_SEED);
>>>>>> +     __type(key, unsigned int);
>>>>>> +     __type(value, unsigned int);
>>>>>> +} htab SEC(".maps");
>>>>>> +
>>>>>> +/* nmi_handle on x86 platform. If changing keyword
>>>>>> + * "static" to "inline", this prog load failed. */
>>>>>> +SEC("fentry/nmi_handle")
>>>>>
>>>>> The above comment is not what I mean. In arch/x86/kernel/nmi.c,
>>>>> we have
>>>>>      static int nmi_handle(unsigned int type, struct pt_regs *regs)
>>>>>      {
>>>>>           ...
>>>>>      }
>>>>>      ...
>>>>>      static noinstr void default_do_nmi(struct pt_regs *regs)
>>>>>      {
>>>>>           ...
>>>>>           handled = nmi_handle(NMI_LOCAL, regs);
>>>>>           ...
>>>>>      }
>>>>>
>>>>> Since nmi_handle is a static function, it is possible that
>>>>> the function might be inlined in default_do_nmi by the
>>>>> compiler. If this happens, fentry/nmi_handle will not
>>>>> be triggered and the test will pass.
>>>>>
>>>>> So I suggest to change the comment to
>>>>>      nmi_handle() is a static function and might be
>>>>>      inlined into its caller. If this happens, the
>>>>>      test can still pass without previous kernel fix.
>>>>
>>>> It's worse than this.
>>>> fentry is buggy.
>>>> We shouldn't allow attaching fentry to:
>>>> NOKPROBE_SYMBOL(nmi_handle);
>>>
>>> Okay, I see. Looks we should prevent fentry from
>>> attaching any NOKPROBE_SYMBOL functions.
>>>
>>> BTW, I think fentry/nmi_handle can be replaced with
>>> tracepoint nmi/nmi_handler. it is more reliable
>> The tracepoint will not reproduce the deadlock(we have discussed v2).
>> If it's not easy to complete a test for this case, should we drop this
>> testcase patch? or fentry the nmi_handle and update the comments.
>
> could we use a softirq perf event (timer), e.g.,
>
>         struct perf_event_attr attr = {
>                 .sample_period = 1,
>                 .type = PERF_TYPE_SOFTWARE,
>                 .config = PERF_COUNT_SW_CPU_CLOCK,
>         };
>
> then you can attach function hrtimer_run_softirq (not tested) or
> similar functions?
The context will be a hard-irq context, right ? Because htab_lock_bucket() has
already disabled hard-irq on current CPU, so the dead-lock will be impossible.
>
> I suspect most (if not all) functions in nmi path cannot
> be kprobe'd.
It seems that perf_event_nmi_handler() is also nokprobe function. However I
think we could try its callees (e.g., x86_pmu_handle_irq or perf_event_overflow).
>
>>> and won't be impacted by potential NOKPROBE_SYMBOL
>>> issues.
>>
>>
>>
> .

