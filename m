Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92556637D2
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 04:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjAJDZf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 22:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjAJDZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 22:25:35 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887B63A3
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 19:25:33 -0800 (PST)
Message-ID: <85737292-efbf-636c-99f1-39569cd215c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673321131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO2+weZAZRzG2H7ZkTEZhVDWHHp9gLCngGYuOE6dgJU=;
        b=RJ1Jb1k8Tb1PpwrlT94m1pgSNJpMMwKEX/ktecsapW71HP03zAy/G51yjUCSujH4k9FCPl
        LlrXPUUNTZtQ9mjLKpeGU58zlIeyCmOflqMFZ4G5NaGBKRlVdeyW2238Zd386qdA9yy7V/
        WWWxUTf6XlCuyEw9tOMWd7unbVMOfxc=
Date:   Mon, 9 Jan 2023 19:25:21 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v4 2/2] selftests/bpf: add test case for htab map
Content-Language: en-US
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        Manu Bretelle <chantra@meta.com>
References: <20230105092637.35069-1-tong@infragraf.org>
 <20230105092637.35069-2-tong@infragraf.org>
 <6bd49922-9d38-3bf9-47e8-3208adfd2f31@linux.dev>
 <AE6C6A22-4411-4109-93DD-164FA53DCBE0@infragraf.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <AE6C6A22-4411-4109-93DD-164FA53DCBE0@infragraf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/23 6:21 PM, Tonghao Zhang wrote:
> 
> 
>> On Jan 10, 2023, at 9:33 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/5/23 1:26 AM, tong@infragraf.org wrote:
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..137dce8f1346
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>>> @@ -0,0 +1,75 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#define _GNU_SOURCE
>>> +#include <pthread.h>
>>> +#include <sched.h>
>>> +#include <test_progs.h>
>>> +
>>> +#include "htab_deadlock.skel.h"
>>> +
>>> +static int perf_event_open(void)
>>> +{
>>> +	struct perf_event_attr attr = {0};
>>> +	int pfd;
>>> +
>>> +	/* create perf event on CPU 0 */
>>> +	attr.size = sizeof(attr);
>>> +	attr.type = PERF_TYPE_HARDWARE;
>>> +	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>> +	attr.freq = 1;
>>> +	attr.sample_freq = 1000;
>>> +	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>> +
>>> +	return pfd >= 0 ? pfd : -errno;
>>> +}
>>> +
>>> +void test_htab_deadlock(void)
>>> +{
>>> +	unsigned int val = 0, key = 20;
>>> +	struct bpf_link *link = NULL;
>>> +	struct htab_deadlock *skel;
>>> +	int err, i, pfd;
>>> +	cpu_set_t cpus;
>>> +
>>> +	skel = htab_deadlock__open_and_load();
>>> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>>> +		return;
>>> +
>>> +	err = htab_deadlock__attach(skel);
>>> +	if (!ASSERT_OK(err, "skel_attach"))
>>> +		goto clean_skel;
>>> +
>>> +	/* NMI events. */
>>> +	pfd = perf_event_open();
>>> +	if (pfd < 0) {
>>> +		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
>>> +			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>> +			test__skip();
>>
>> This test is a SKIP in bpf CI, so it won't be useful.
>> https://github.com/kernel-patches/bpf/actions/runs/3858084722/jobs/6579470256#step:6:5198
>>
>> Is there other way to test it or do you know what may be missing in vmtest.sh? Not sure if the cloud setup in CI blocks HW_CPU_CYCLES.  If it is, I also don't know a good way (Cc: Manu).
> Hi
> 
> Other test cases using PERF_COUNT_HW_CPU_CYCLES were skipped too. For example,
> send_signal
> find_vma
> get_stackid_cannot_attach

Got it. Thanks for checking.

>>
>>> +			goto clean_skel;
>>> +		}
>>> +		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
>>> +			goto clean_skel;
>>> +	}
>>> +
>>> +	link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
>>> +	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>>> +		goto clean_pfd;
>>> +
>>> +	/* Pinned on CPU 0 */
>>> +	CPU_ZERO(&cpus);
>>> +	CPU_SET(0, &cpus);
>>> +	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
>>> +
>>> +	/* update bpf map concurrently on CPU0 in NMI and Task context.
>>> +	 * there should be no kernel deadlock.
>>> +	 */
>>> +	for (i = 0; i < 100000; i++)
>>> +		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
>>> +				    &key, &val, BPF_ANY);
>>> +
>>> +	bpf_link__destroy(link);
>>> +clean_pfd:
>>> +	close(pfd);
>>> +clean_skel:
>>> +	htab_deadlock__destroy(skel);
>>> +}
>>> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> new file mode 100644
>>> index 000000000000..dacd003b1ccb
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2022 DiDi Global Inc. */
>>> +#include <linux/bpf.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct {
>>> +	__uint(type, BPF_MAP_TYPE_HASH);
>>> +	__uint(max_entries, 2);
>>> +	__uint(map_flags, BPF_F_ZERO_SEED);
>>> +	__type(key, unsigned int);
>>> +	__type(value, unsigned int);
>>> +} htab SEC(".maps");
>>> +
>>> +SEC("fentry/perf_event_overflow")
>>> +int bpf_nmi_handle(struct pt_regs *regs)
>>> +{
>>> +	unsigned int val = 0, key = 4;
>>> +
>>> +	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
>>
>> I ran it in my qemu setup which does not skip the test.  I got this splat though:
> This is a false alarm, not deadlock(this patch fix deadlock, only). I fix waring in other patch, please review
> https://patchwork.kernel.org/project/netdevbpf/patch/20230105112749.38421-1-tong@infragraf.org/

Yeah, I just saw this thread also. Please submit the warning fix together with 
this patch set since this test can trigger it.  They should be reviewed together.

>>
>> [   42.990306] ================================
>> [   42.990307] WARNING: inconsistent lock state
>> [   42.990310] 6.2.0-rc2-00304-gaf88a1bb9967 #409 Tainted: G           O
>> [   42.990313] --------------------------------
>> [   42.990315] inconsistent {INITIAL USE} -> {IN-NMI} usage.
>> [   42.990317] test_progs/1546 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> [   42.990322] ffff888101245768 (&htab->lockdep_key){....}-{2:2}, at: htab_map_update_elem+0x1e7/0x810
>> [   42.990340] {INITIAL USE} state was registered at:
>> [   42.990341]   lock_acquire+0x1e6/0x530
>> [   42.990351]   _raw_spin_lock_irqsave+0xb8/0x100
>> [   42.990362]   htab_map_update_elem+0x1e7/0x810
>> [   42.990365]   bpf_map_update_value+0x40d/0x4f0
>> [   42.990371]   map_update_elem+0x423/0x580
>> [   42.990375]   __sys_bpf+0x54e/0x670
>> [   42.990377]   __x64_sys_bpf+0x7c/0x90
>> [   42.990382]   do_syscall_64+0x43/0x90
>> [   42.990387]   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>
>> Please check.
>>
>>> +	return 0;
>>> +}
>>> +
>>> +SEC("perf_event")
>>> +int bpf_empty(struct pt_regs *regs)
>>> +{
>>
>> btw, from a quick look at __perf_event_overflow, I suspect doing the bpf_map_update_elem() here instead of the fentry/perf_event_overflow above can also reproduce the patch 1 issue?
> No
> bpf_overflow_handler will check the bpf_prog_active, if syscall increase it, bpf_overflow_handler will skip the bpf prog.

tbh, I am quite surprised the bpf_prog_active would be noisy enough to avoid 
this deadlock being reproduced easily. fwiw, I just tried doing map_update here 
and can reproduce it in the very first run.

> Fentry will not check the bpf_prog_active, and interrupt the task context. We have discussed that.

Sure. fentry is fine. The reason I was asking is to see if the test can be 
simplified and barring any future fentry blacklist.
