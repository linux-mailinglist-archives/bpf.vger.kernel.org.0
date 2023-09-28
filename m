Return-Path: <bpf+bounces-11043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5347B1B0B
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 157E928202E
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07E37C8B;
	Thu, 28 Sep 2023 11:35:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CE746A
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:35:10 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4831C9C;
	Thu, 28 Sep 2023 04:35:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0ecb9a075so95857645ad.2;
        Thu, 28 Sep 2023 04:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695900908; x=1696505708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do7w7tLdLZYq87tTYSVbJTs9LRIPWKbq50o+PMHAD/A=;
        b=Kn41ndLgibta4RBkH7FR2BJRWaKd60AVnaJqEiJG9rjk19cJEd8iGihi1T2ULigZa2
         gGO/fe+wp5U3iUoGpvG0/yYrzwu4T6tP6DKGriEYzbCLSW6ChNrHGtAcpPTY5IwrFWij
         jwoA9wsdkAf56iEllafOAVNfTneblGLEanSYwGs7bdoB0s1mjSDuAd5lOpZLR9c81Nxv
         j0QcyPmSY7pbc9k5375ccCzs/4nB8+M7ag4F+pn0d8ZFM089fnOiuR405EgZBihaY+Nx
         KWKjqf4SZNQGjZl/TP2Iu4IQBx8GRPmfo4FMy2akuLPOxhkvksrKEgdIyNAabNwA+edG
         CfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695900908; x=1696505708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Do7w7tLdLZYq87tTYSVbJTs9LRIPWKbq50o+PMHAD/A=;
        b=HzqLwlWizJI0n5J+v0A+jFhdYni6YsWTzMNydwbpGR8TQllPaN3FxWQq3natOMicAO
         KvgvwwzIQqkedFATCKMYu0vX8o8bH91hSnMZH4HzHndkHUuCU5PrRqLkgzITTfD1PkB1
         Hn2SHPEpsRXxaJf/VgRUTXRGfL2Uv4dvjXyjY0tu5ZpqlFzzf3g9skmqo/R5X5elQljv
         AElXZn1fp+1KMvV2dHmZ43YF889XrKItH5JHbTstFwz21OUpUD9nC1mqu540boUecz1T
         VUlOdZ7Bm0n9G52a+KOAbtK6kRUzfDawgYitb4GETIt3gw2yUfXPwvT74gPyNlnBgkY/
         MmrQ==
X-Gm-Message-State: AOJu0YzxqDt7sf95DNQQBka+PaAlUkHe0+77mRfEc1lQcFAr+5mRTIPM
	7NnScMSXCuvKj5HDCHHRhM8=
X-Google-Smtp-Source: AGHT+IESWvZSp1ZQQ/0mfZe8eVa9L6ya4pwxx6H4atBI76ay+oPlkcNbam2H98Iy29SlWlI9fRQ6tw==
X-Received: by 2002:a17:902:7d92:b0:1c6:c41:af37 with SMTP id a18-20020a1709027d9200b001c60c41af37mr766523plm.68.1695900907543;
        Thu, 28 Sep 2023 04:35:07 -0700 (PDT)
Received: from [198.18.0.1] (211-21-201-12.hinet-ip.hinet.net. [211.21.201.12])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001c41e1e9ca7sm14736675plg.215.2023.09.28.04.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 04:35:07 -0700 (PDT)
Message-ID: <a40dffe9-08c3-9522-a3e3-2e02c0858bf2@gmail.com>
Date: Thu, 28 Sep 2023 19:35:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
To: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-5-zhouchuyi@bytedance.com>
 <5bb59039-4f3b-49b6-d440-3210d7a92754@oracle.com>
 <ae654476-5cc2-36ae-1047-eba196c9b38d@bytedance.com>
 <cb817ceb-3a26-844b-05fa-06394e4e025e@oracle.com>
 <aecf051c-6f56-b799-bbc9-148892b584b6@bytedance.com>
From: Charlley Green <charlleygreen.work@gmail.com>
In-Reply-To: <aecf051c-6f56-b799-bbc9-148892b584b6@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/8/16 22:34, Chuyi Zhou 写道:
> Hello,
>
> 在 2023/8/16 21:49, Alan Maguire 写道:
>> On 16/08/2023 13:31, Chuyi Zhou wrote:
>>> Hello,
>>>
>>> 在 2023/8/16 19:53, Alan Maguire 写道:
>>>> On 10/08/2023 09:13, Chuyi Zhou wrote:
>>>>> This patch adds a test which implements a priority-based policy 
>>>>> through
>>>>> bpf_oom_evaluate_task.
>>>>>
>>>>> The BPF program, oom_policy.c, compares the cgroup priority of two 
>>>>> tasks
>>>>> and select the lower one. The userspace program test_oom_policy.c
>>>>> maintains a priority map by using cgroup id as the keys and 
>>>>> priority as
>>>>> the values. We could protect certain cgroups from oom-killer by 
>>>>> setting
>>>>> higher priority.
>>>>>
>>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>>> ---
>>>>>    .../bpf/prog_tests/test_oom_policy.c          | 140 
>>>>> ++++++++++++++++++
>>>>>    .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
>>>>>    2 files changed, 244 insertions(+)
>>>>>    create mode 100644
>>>>> tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>>>>    create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c
>>>>>
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>>>> b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>>>> new file mode 100644
>>>>> index 000000000000..bea61ff22603
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>>>> @@ -0,0 +1,140 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +#define _GNU_SOURCE
>>>>> +
>>>>> +#include <stdio.h>
>>>>> +#include <fcntl.h>
>>>>> +#include <unistd.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <signal.h>
>>>>> +#include <sys/stat.h>
>>>>> +#include <test_progs.h>
>>>>> +#include <bpf/btf.h>
>>>>> +#include <bpf/bpf.h>
>>>>> +
>>>>> +#include "cgroup_helpers.h"
>>>>> +#include "oom_policy.skel.h"
>>>>> +
>>>>> +static int map_fd;
>>>>> +static int cg_nr;
>>>>> +struct {
>>>>> +    const char *path;
>>>>> +    int fd;
>>>>> +    unsigned long long id;
>>>>> +} cgs[] = {
>>>>> +    { "/cg1" },
>>>>> +    { "/cg2" },
>>>>> +};
>>>>> +
>>>>> +
>>>>> +static struct oom_policy *open_load_oom_policy_skel(void)
>>>>> +{
>>>>> +    struct oom_policy *skel;
>>>>> +    int err;
>>>>> +
>>>>> +    skel = oom_policy__open();
>>>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>>>> +        return NULL;
>>>>> +
>>>>> +    err = oom_policy__load(skel);
>>>>> +    if (!ASSERT_OK(err, "skel_load"))
>>>>> +        goto cleanup;
>>>>> +
>>>>> +    return skel;
>>>>> +
>>>>> +cleanup:
>>>>> +    oom_policy__destroy(skel);
>>>>> +    return NULL;
>>>>> +}
>>>>> +
>>>>> +static void run_memory_consume(unsigned long long consume_size, int
>>>>> idx)
>>>>> +{
>>>>> +    char *buf;
>>>>> +
>>>>> +    join_parent_cgroup(cgs[idx].path);
>>>>> +    buf = malloc(consume_size);
>>>>> +    memset(buf, 0, consume_size);
>>>>> +    sleep(2);
>>>>> +    exit(0);
>>>>> +}
>>>>> +
>>>>> +static int set_cgroup_prio(unsigned long long cg_id, int prio)
>>>>> +{
>>>>> +    int err;
>>>>> +
>>>>> +    err = bpf_map_update_elem(map_fd, &cg_id, &prio, BPF_ANY);
>>>>> +    ASSERT_EQ(err, 0, "update_map");
>>>>> +    return err;
>>>>> +}
>>>>> +
>>>>> +static int prepare_cgroup_environment(void)
>>>>> +{
>>>>> +    int err;
>>>>> +
>>>>> +    err = setup_cgroup_environment();
>>>>> +    if (err)
>>>>> +        goto clean_cg_env;
>>>>> +    for (int i = 0; i < cg_nr; i++) {
>>>>> +        err = cgs[i].fd = create_and_get_cgroup(cgs[i].path);
>>>>> +        if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>>>>> +            goto clean_cg_env;
>>>>> +        cgs[i].id = get_cgroup_id(cgs[i].path);
>>>>> +    }
>>>>> +    return 0;
>>>>> +clean_cg_env:
>>>>> +    cleanup_cgroup_environment();
>>>>> +    return err;
>>>>> +}
>>>>> +
>>>>> +void test_oom_policy(void)
>>>>> +{
>>>>> +    struct oom_policy *skel;
>>>>> +    struct bpf_link *link;
>>>>> +    int err;
>>>>> +    int victim_pid;
>>>>> +    unsigned long long victim_cg_id;
>>>>> +
>>>>> +    link = NULL;
>>>>> +    cg_nr = ARRAY_SIZE(cgs);
>>>>> +
>>>>> +    skel = open_load_oom_policy_skel();
>>>>> +    err = oom_policy__attach(skel);
>>>>> +    if (!ASSERT_OK(err, "oom_policy__attach"))
>>>>> +        goto cleanup;
>>>>> +
>>>>> +    map_fd = bpf_object__find_map_fd_by_name(skel->obj, "cg_map");
>>>>> +    if (!ASSERT_GE(map_fd, 0, "find map"))
>>>>> +        goto cleanup;
>>>>> +
>>>>> +    err = prepare_cgroup_environment();
>>>>> +    if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
>>>>> +        goto cleanup;
>>>>> +
>>>>> +    write_cgroup_file("/", "memory.max", "10M");
>>>>> +
>>>>> +    /*
>>>>> +     * Set higher priority to cg2 and lower to cg1, so we would 
>>>>> select
>>>>> +     * task under cg1 as victim.(see oom_policy.c)
>>>>> +     */
>>>>> +    set_cgroup_prio(cgs[0].id, 10);
>>>>> +    set_cgroup_prio(cgs[1].id, 50);
>>>>> +
>>>>> +    victim_cg_id = cgs[0].id;
>>>>> +    victim_pid = fork();
>>>>> +
>>>>> +    if (victim_pid == 0)
>>>>> +        run_memory_consume(1024 * 1024 * 4, 0);
>>>>> +
>>>>> +    if (fork() == 0)
>>>>> +        run_memory_consume(1024 * 1024 * 8, 1);
>>>>> +
>>>>> +    while (wait(NULL) > 0)
>>>>> +        ;
>>>>> +
>>>>> +    ASSERT_EQ(skel->bss->victim_pid, victim_pid, "victim_pid");
>>>>> +    ASSERT_EQ(skel->bss->victim_cg_id, victim_cg_id, "victim_cgid");
>>>>> +    ASSERT_EQ(skel->bss->failed_cnt, 1, "failed_cnt");
>>>>> +cleanup:
>>>>> +    bpf_link__destroy(link);
>>>>> +    oom_policy__destroy(skel);
>>>>> +    cleanup_cgroup_environment();
>>>>> +}
>>>>> diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c
>>>>> b/tools/testing/selftests/bpf/progs/oom_policy.c
>>>>> new file mode 100644
>>>>> index 000000000000..fc9efc93914e
>>>>> --- /dev/null
>>>>> +++ b/tools/testing/selftests/bpf/progs/oom_policy.c
>>>>> @@ -0,0 +1,104 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +#include <vmlinux.h>
>>>>> +#include <bpf/bpf_tracing.h>
>>>>> +#include <bpf/bpf_helpers.h>
>>>>> +
>>>>> +char _license[] SEC("license") = "GPL";
>>>>> +
>>>>> +struct {
>>>>> +    __uint(type, BPF_MAP_TYPE_HASH);
>>>>> +    __type(key, int);
>>>>> +    __type(value, int);
>>>>> +    __uint(max_entries, 24);
>>>>> +} cg_map SEC(".maps");
>>>>> +
>>>>> +unsigned int victim_pid;
>>>>> +u64 victim_cg_id;
>>>>> +int failed_cnt;
>>>>> +
>>>>> +#define    EOPNOTSUPP    95
>>>>> +
>>>>> +enum {
>>>>> +    NO_BPF_POLICY,
>>>>> +    BPF_EVAL_ABORT,
>>>>> +    BPF_EVAL_NEXT,
>>>>> +    BPF_EVAL_SELECT,
>>>>> +};
>>>>
>>>> When I built a kernel using this series and tried building the
>>>> associated test for that kernel I saw:
>>>>
>>>> progs/oom_policy.c:22:2: error: redefinition of enumerator
>>>> 'NO_BPF_POLICY'
>>>>           NO_BPF_POLICY,
>>>>           ^
>>>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75894:2: 
>>>>
>>>> note: previous definition is here
>>>>           NO_BPF_POLICY = 0,
>>>>           ^
>>>> progs/oom_policy.c:23:2: error: redefinition of enumerator
>>>> 'BPF_EVAL_ABORT'
>>>>           BPF_EVAL_ABORT,
>>>>           ^
>>>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75895:2: 
>>>>
>>>> note: previous definition is here
>>>>           BPF_EVAL_ABORT = 1,
>>>>           ^
>>>> progs/oom_policy.c:24:2: error: redefinition of enumerator
>>>> 'BPF_EVAL_NEXT'
>>>>           BPF_EVAL_NEXT,
>>>>           ^
>>>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75896:2: 
>>>>
>>>> note: previous definition is here
>>>>           BPF_EVAL_NEXT = 2,
>>>>           ^
>>>> progs/oom_policy.c:  CLNG-BPF [test_maps] tailcall_bpf2bpf4.bpf.o
>>>> 25:2: error: redefinition of enumerator 'BPF_EVAL_SELECT'
>>>>           BPF_EVAL_SELECT,
>>>>           ^
>>>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75897:2: 
>>>>
>>>> note: previous definition is here
>>>>           BPF_EVAL_SELECT = 3,
>>>>           ^
>>>> 4 errors generated.
>>>>
>>>>
>>>> So you shouldn't need the enum definition since it already makes it 
>>>> into
>>>> vmlinux.h.
>>>> OK. It seems my vmlinux.h doesn't contain these enum...
>>>> I also ran into test failures when I removed the above (and 
>>>> compilation
>>>> succeeded):
>>>>
>>>>
>>>> test_oom_policy:PASS:prepare cgroup env 0 nsec
>>>> (cgroup_helpers.c:130: errno: No such file or directory) Opening
>>>> /mnt/cgroup-test-work-dir23054//memory.max
>>>> set_cgroup_prio:PASS:update_map 0 nsec
>>>> set_cgroup_prio:PASS:update_map 0 nsec
>>>> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
>>>> expected 23058
>>>> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
>>>> expected 68
>>>> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
>>>> expected 1
>>>> #154     oom_policy:FAIL
>>>> Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
>>>>
>>>> So it seems that because my system was using the cgroupv1 memory
>>>> controller, it could not be used for v2 unless I rebooted with
>>>>
>>>> systemd.unified_cgroup_hierarchy=1
>>>>
>>>> ...on the boot commandline. It would be good to note any such
>>>> requirements for this test in the selftests/bpf/README.rst.
>>>> Might also be worth adding
>>>>
>>>> write_cgroup_file("", "cgroup.subtree_control", "+memory");
>>>>
>>>> ...to ensure the memory controller is enabled for the root cgroup.
>>>>
>>>> At that point the test still failed:
>>>>
>>>> set_cgroup_prio:PASS:update_map 0 nsec
>>>> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
>>>> expected 12649
>>>> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
>>>> expected 9583
>>>> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
>>>> expected 1
>>>> #154     oom_policy:FAIL
>>>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>>> Successfully unloaded bpf_testmod.ko.
>>>>
>>>>
>>> It seems that OOM is not invoked in your environment(you can check 
>>> it in
>>> demsg). If the memcg OOM is invoked by the test, we would record the
>>> *victim_pid* and *victim_cgid* and they would not be zero. I guess the
>>> reason is memory_control is not enabled in cgroup
>>> "/mnt/cgroup-test-work-dir23054/", because I see the error message:
>>> (cgroup_helpers.c:130: errno: No such file or directory) Opening
>>>> /mnt/cgroup-test-work-dir23054//memory.max
>>
>> Right, but after I set up unified cgroup hierarchy and rebooted, that
>> message disappeared and cgroup setup succeeded, _but_ the test still
>> failed with 0 victim_pid/cgid.  I see nothing OOM-related in dmesg, but
>> the toplevel cgroupv2 cgroup.controllers file contains:
>>
>> cpuset cpu io memory hugetlb pids rdma
>>
>
> Dose the toplevel cgroupv2's *cgroup.subtree_control* looks like that?
> /sys/fs/cgroup$ cat cgroup.subtree_control
>
>     cpuset cpu io memory hugetlb pids
>
> This prog test would mkdir a test cgroup dir under the toplevel's 
> cgroupv2 and rmdir after the test finishing. In my env, the test 
> cgroup path looks like:
>
> /sys/fs/cgroup/cgroup-test-work-dirxxx/
>
> This test would run in cgroup-test-work-dirxxx.
>
> If we want to enable memory controller in cgroup-test-work-dirxxx, we 
> should guarantee that /sys/fs/cgroup/cgroup.subtree_control contanins
> "memory".
>
>
>> Is there something else that needs to be done to enable OOM scanning?
>> I see the oom_reaper process:
>>
>> root          72       2  0 11:30 ?        00:00:00 [oom_reaper]
>>
>>
>> This test will need to pass BPF CI, so any assumptions about
>> configuration need to be ironed out. For example, I think you should
>> probably have
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> index bea61ff22603..54fdb8a59816 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> @@ -109,6 +109,7 @@ void test_oom_policy(void)
>>          if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
>>                  goto cleanup;
>>
>> +       write_cgroup_file("/", "cgroup.subtree_control", "+memory");
>>          write_cgroup_file("/", "memory.max", "10M");
>
> Yes, you are right. We do need something to guarantee that the memory 
> controller is enabled in cgroup-test-work-dir.
>     write_cgroup_file("/", "cgroup.subtree_control", "+memory");
> This code actually dose something like:
>
> echo "+memory" > 
> /sys/fs/cgroup/cgroup-test-work-dir/cgroup.subtree_control
>
> What we need actually is
> echo "+memory" > /sys/fs/cgroup/cgroup.subtree_control
>
> Thanks!
Hello!

I confirmed that I have the memory and other necessary options in
cgroup.subtree_control you mentioned.

cat /sys/fs/cgroup/cgroup.subtree_control

cpuset cpu io memory hugetlb pids rdma misc

I almost exactly reproduced the problem Alan encountered.

make => redefinition of enumerator XXX => delete the enum => start the
bpf selftest with "make run_tests"

In the end, three Fails also appeared, with victim_pid, victim_cgid, and
failed_cnt all being 0.

My environment:

- I installed the necessary software for bpf on Ubuntu 22.04.

- I downloaded "linux-source-6.2.0 - Linux kernel source for version
6.2.0 with Ubuntu patches" from apt source.

- I have applied your series of patches on this version of the kernel
source code.

- I compiled and installed this patched kernel and installed its
linux-tools

- Finally I reproduced the above error.

Could you please provide an exact environment in which your success can
be replicated?

Perhaps this requires a more precise environment, including

which version of the kernel source code your patch needs to be based on,

which distribution of operating system,

which necessary software needs to be installed,

and which features need to be enabled.

If you can help solve the problem, I would be very grateful!
>>
>>          /*
>>
>> ...to be safe, since
>>
>> https://docs.kernel.org/admin-guide/cgroup-v2.html#organizing-processes-and-threads 
>>
>>
>> ...says
>>
>> "No controller is enabled by default. Controllers can be enabled and
>> disabled by writing to the "cgroup.subtree_control" file:
>>
>> # echo "+cpu +memory -io" > cgroup.subtree_control
>>
>> "
>>
>> Are there any other aspects of configuration like that which might
>> explain why the test passes for you but fails for me?
>>
>> Alan
>
>

