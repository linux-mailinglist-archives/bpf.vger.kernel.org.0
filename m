Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355BE64E99F
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLPKlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiLPKlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:41:42 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CBD20195
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:41:40 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NYQY23YTWzJpN8;
        Fri, 16 Dec 2022 18:37:58 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 18:41:38 +0800
Subject: Re: [bpf-next 2/2] selftests/bpf: add test cases for htab map
To:     <xiangxia.m.yue@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yhs@meta.com>
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com>
 <20221214103857.69082-2-xiangxia.m.yue@gmail.com>
 <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <a0c44452-70b0-8b05-151f-932c3b9e2fb0@huawei.com>
Date:   Fri, 16 Dec 2022 18:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <73b9ef21-de67-e421-378a-1814ffbc263f@meta.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi,

On 12/16/2022 12:10 PM, Yonghong Song wrote:
>
>
> On 12/14/22 2:38 AM, xiangxia.m.yue@gmail.com wrote:
>> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>>
>> This testing show how to reproduce deadlock in special case.
Could you elaborate the commit message to show
>>
>> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Andrii Nakryiko <andrii@kernel.org>
>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Cc: KP Singh <kpsingh@kernel.org>
>> Cc: Stanislav Fomichev <sdf@google.com>
>> Cc: Hao Luo <haoluo@google.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Hou Tao <houtao1@huawei.com>
>> ---
>>   .../selftests/bpf/prog_tests/htab_deadlock.c  | 74 +++++++++++++++++++
>>   .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
>>   2 files changed, 104 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>> b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>> new file mode 100644
>> index 000000000000..7dce4c2fe4f5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 DiDi Global Inc. */
>> +#define _GNU_SOURCE
>> +#include <pthread.h>
>> +#include <sched.h>
>> +#include <test_progs.h>
>> +
>> +#include "htab_deadlock.skel.h"
>> +
>> +static int perf_event_open(void)
>> +{
>> +    struct perf_event_attr attr = {0};
>> +    int pfd;
>> +
>> +    /* create perf event */
>> +    attr.size = sizeof(attr);
>> +    attr.type = PERF_TYPE_HARDWARE;
>> +    attr.config = PERF_COUNT_HW_CPU_CYCLES;
>> +    attr.freq = 1;
>> +    attr.sample_freq = 1000;
>> +    pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1,
>> PERF_FLAG_FD_CLOEXEC);
>> +
>> +    return pfd >= 0 ? pfd : -errno;
>> +}
>> +
>> +void test_htab_deadlock(void)
>> +{
>> +    unsigned int val = 0, key = 20;
>> +    struct bpf_link *link = NULL;
>> +    struct htab_deadlock *skel;
>> +    cpu_set_t cpus;
>> +    int err;
>> +    int pfd;
>> +    int i;
>
> No need to have three lines for type 'int' variables. One line
> is enough to hold all three variables.
>
>> +
>> +    skel = htab_deadlock__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>> +        return;
>> +
>> +    err = htab_deadlock__attach(skel);
>> +    if (!ASSERT_OK(err, "skel_attach"))
>> +        goto clean_skel;
>> +
>> +    /* NMI events. */
>> +    pfd = perf_event_open();
>> +    if (pfd < 0) {
>> +        if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
>> +            printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>> +            test__skip();
>> +            goto clean_skel;
>> +        }
>> +        if (!ASSERT_GE(pfd, 0, "perf_event_open"))
>> +            goto clean_skel;
>> +    }
>> +
>> +    link = bpf_program__attach_perf_event(skel->progs.bpf_perf_event, pfd);
>> +    if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>> +        goto clean_pfd;
>> +
>> +    /* Pinned on CPU 0 */
>> +    CPU_ZERO(&cpus);
>> +    CPU_SET(0, &cpus);
>> +    pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
The test will run in process context, so use sched_setaffinity() will better
than _np API.
>> +
>> +    for (i = 0; i < 100000; i++)
>
> Please add some comments in the above loop to mention the test
> expects (hopefully) duriing one of bpf_map_update_elem(), one
> perf event might kick to trigger prog bpf_nmi_handle run.
>
>> +        bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
>> +                    &key, &val, BPF_ANY);
It would be better if we can check that bpf_nmi_handle is being called and the
return value of bpf_map_update_elem() in bpf_nmi_handle  is expected here.
>> +
>> +    bpf_link__destroy(link);
>> +clean_pfd:
>> +    close(pfd);
>> +clean_skel:
>> +    htab_deadlock__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c
>> b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>> new file mode 100644
>> index 000000000000..c4bd1567f882
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 DiDi Global Inc. */
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +    __uint(type, BPF_MAP_TYPE_HASH);
>> +    __uint(max_entries, 2);
>> +    __uint(map_flags, BPF_F_ZERO_SEED);
>> +    __uint(key_size, sizeof(unsigned int));
>> +    __uint(value_size, sizeof(unsigned int));
>> +} htab SEC(".maps");
>
> You can use
>     __type(key, unsigned int);
>     __type(value, unsigned int);
> This is more expressive.
>
>> +
>> +SEC("fentry/nmi_handle")
>> +int bpf_nmi_handle(struct pt_regs *regs)
>
> Do we need this fentry function? Can be just put
> bpf_map_update_elem() into bpf_perf_event program?
IIRC bpf_perf_event program will check bpf_prog_active, and
bpf_map_update_value() will increase it, so fentry is needed here.
>
> Also s390x and aarch64 failed the test due to none/incomplete trampoline
> support. See bpf ci https://github.com/kernel-patches/bpf/pull/4211.
> You need to add them in their corresponding deny list if this fentry
> bpf program is used.
>
>> +{
>> +    unsigned int val = 0, key = 4;
>> +
>> +    bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
>> +    return 0;
>> +}
>> +
>> +SEC("perf_event")
>> +int bpf_perf_event(struct pt_regs *regs)
>> +{
>> +    return 0;
>> +}
> .

