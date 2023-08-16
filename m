Return-Path: <bpf+bounces-7893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C777F77E1AE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6E31C21089
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C48156D5;
	Wed, 16 Aug 2023 12:31:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B51772D
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 12:31:16 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6510C8
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 05:31:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26b4a9205e3so1894534a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692189072; x=1692793872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So4cE/EwPzWwkGHeDBYhVdRGKHVyJL5UQ3cn6SnvDco=;
        b=SLvAmL9QRt4Gu1zNHfL3L2btkogzuREP2Xh0AAFqxRolyJg6tVrJxRkkWVVHZGj1fQ
         Y/KvJ2SPD9QqD967GcWS9PWUQ9bF9zOPi7nHjX+GOX60ORE4LTuK2dtIcVZa1qnEsXAu
         dLF1jESghknHoN3HyGJJZMtKNUsi95hUUc7S1oe9UhOwvnyGU6wecLfObXYLnUYc9Wug
         5Ks1p0e38NwAQ2GpPAYKDPLHyF0NSFimCW2bNrYjBNEH09IqDET4C3REhO1pHPfPIr00
         SOww+Z4xRijs6OtZXd+k/pSa2FmNmVXICWtUzHfK5CRBuXnPTuA0Nptbi5AbVeAf7QGU
         Si4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189072; x=1692793872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=So4cE/EwPzWwkGHeDBYhVdRGKHVyJL5UQ3cn6SnvDco=;
        b=APO5cE7kRlwV6nqPOWJpOygsHXN1aRQphuI+xGUcTUsYg9jjd1uNgT+D+cc23qlT7f
         8EA27yWTyekT2hem8HAj+Yzf18hFAgu7vhap9fhnjVmyBDvFOw/ON0VlOclTv8QCE2gb
         0yobll8X2cEpU1K8KFcGoteW6uDoMISCnZb8kzvtNHzqFQLF+4hKCG4cnRF93dUJtecS
         d/QrfD/qj13yIYx+Yb5yt7ptRjklYp/OenSNXGug2onp0QcgF2MX5R9chkQxJ8d9O7ZO
         CLPrSCTHnrSELSFhw3Sc2ey/oV5EYrFCZG8dpKO8pJVeBcQm//s6t4SqFeaTL7MqLkKE
         teIg==
X-Gm-Message-State: AOJu0YwldSJ5B4XnVAmbW+z4Rr2hJsGi+H9tYav7SPU1oIYU+oPyAdYt
	uRtJ0lhJdvvJZtXx+J/+lzcpaQ==
X-Google-Smtp-Source: AGHT+IERO3Ln0lTmScqxHVGcLWbOGWsp6MYbctvBXJ8TaKn0Z4GP1goUtRoYLnCGFxXQ/bkVhsEDkw==
X-Received: by 2002:a17:90b:3007:b0:262:f579:41db with SMTP id hg7-20020a17090b300700b00262f57941dbmr1064731pjb.6.1692189072435;
        Wed, 16 Aug 2023 05:31:12 -0700 (PDT)
Received: from [10.255.177.31] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id gp22-20020a17090adf1600b00265a7145fe5sm13123137pjb.41.2023.08.16.05.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 05:31:12 -0700 (PDT)
Message-ID: <ae654476-5cc2-36ae-1047-eba196c9b38d@bytedance.com>
Date: Wed, 16 Aug 2023 20:31:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
To: Alan Maguire <alan.maguire@oracle.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-5-zhouchuyi@bytedance.com>
 <5bb59039-4f3b-49b6-d440-3210d7a92754@oracle.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <5bb59039-4f3b-49b6-d440-3210d7a92754@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/8/16 19:53, Alan Maguire 写道:
> On 10/08/2023 09:13, Chuyi Zhou wrote:
>> This patch adds a test which implements a priority-based policy through
>> bpf_oom_evaluate_task.
>>
>> The BPF program, oom_policy.c, compares the cgroup priority of two tasks
>> and select the lower one. The userspace program test_oom_policy.c
>> maintains a priority map by using cgroup id as the keys and priority as
>> the values. We could protect certain cgroups from oom-killer by setting
>> higher priority.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
>>   .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
>>   2 files changed, 244 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> new file mode 100644
>> index 000000000000..bea61ff22603
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#define _GNU_SOURCE
>> +
>> +#include <stdio.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <signal.h>
>> +#include <sys/stat.h>
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +#include <bpf/bpf.h>
>> +
>> +#include "cgroup_helpers.h"
>> +#include "oom_policy.skel.h"
>> +
>> +static int map_fd;
>> +static int cg_nr;
>> +struct {
>> +	const char *path;
>> +	int fd;
>> +	unsigned long long id;
>> +} cgs[] = {
>> +	{ "/cg1" },
>> +	{ "/cg2" },
>> +};
>> +
>> +
>> +static struct oom_policy *open_load_oom_policy_skel(void)
>> +{
>> +	struct oom_policy *skel;
>> +	int err;
>> +
>> +	skel = oom_policy__open();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +		return NULL;
>> +
>> +	err = oom_policy__load(skel);
>> +	if (!ASSERT_OK(err, "skel_load"))
>> +		goto cleanup;
>> +
>> +	return skel;
>> +
>> +cleanup:
>> +	oom_policy__destroy(skel);
>> +	return NULL;
>> +}
>> +
>> +static void run_memory_consume(unsigned long long consume_size, int idx)
>> +{
>> +	char *buf;
>> +
>> +	join_parent_cgroup(cgs[idx].path);
>> +	buf = malloc(consume_size);
>> +	memset(buf, 0, consume_size);
>> +	sleep(2);
>> +	exit(0);
>> +}
>> +
>> +static int set_cgroup_prio(unsigned long long cg_id, int prio)
>> +{
>> +	int err;
>> +
>> +	err = bpf_map_update_elem(map_fd, &cg_id, &prio, BPF_ANY);
>> +	ASSERT_EQ(err, 0, "update_map");
>> +	return err;
>> +}
>> +
>> +static int prepare_cgroup_environment(void)
>> +{
>> +	int err;
>> +
>> +	err = setup_cgroup_environment();
>> +	if (err)
>> +		goto clean_cg_env;
>> +	for (int i = 0; i < cg_nr; i++) {
>> +		err = cgs[i].fd = create_and_get_cgroup(cgs[i].path);
>> +		if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>> +			goto clean_cg_env;
>> +		cgs[i].id = get_cgroup_id(cgs[i].path);
>> +	}
>> +	return 0;
>> +clean_cg_env:
>> +	cleanup_cgroup_environment();
>> +	return err;
>> +}
>> +
>> +void test_oom_policy(void)
>> +{
>> +	struct oom_policy *skel;
>> +	struct bpf_link *link;
>> +	int err;
>> +	int victim_pid;
>> +	unsigned long long victim_cg_id;
>> +
>> +	link = NULL;
>> +	cg_nr = ARRAY_SIZE(cgs);
>> +
>> +	skel = open_load_oom_policy_skel();
>> +	err = oom_policy__attach(skel);
>> +	if (!ASSERT_OK(err, "oom_policy__attach"))
>> +		goto cleanup;
>> +
>> +	map_fd = bpf_object__find_map_fd_by_name(skel->obj, "cg_map");
>> +	if (!ASSERT_GE(map_fd, 0, "find map"))
>> +		goto cleanup;
>> +
>> +	err = prepare_cgroup_environment();
>> +	if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
>> +		goto cleanup;
>> +
>> +	write_cgroup_file("/", "memory.max", "10M");
>> +
>> +	/*
>> +	 * Set higher priority to cg2 and lower to cg1, so we would select
>> +	 * task under cg1 as victim.(see oom_policy.c)
>> +	 */
>> +	set_cgroup_prio(cgs[0].id, 10);
>> +	set_cgroup_prio(cgs[1].id, 50);
>> +
>> +	victim_cg_id = cgs[0].id;
>> +	victim_pid = fork();
>> +
>> +	if (victim_pid == 0)
>> +		run_memory_consume(1024 * 1024 * 4, 0);
>> +
>> +	if (fork() == 0)
>> +		run_memory_consume(1024 * 1024 * 8, 1);
>> +
>> +	while (wait(NULL) > 0)
>> +		;
>> +
>> +	ASSERT_EQ(skel->bss->victim_pid, victim_pid, "victim_pid");
>> +	ASSERT_EQ(skel->bss->victim_cg_id, victim_cg_id, "victim_cgid");
>> +	ASSERT_EQ(skel->bss->failed_cnt, 1, "failed_cnt");
>> +cleanup:
>> +	bpf_link__destroy(link);
>> +	oom_policy__destroy(skel);
>> +	cleanup_cgroup_environment();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c b/tools/testing/selftests/bpf/progs/oom_policy.c
>> new file mode 100644
>> index 000000000000..fc9efc93914e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/oom_policy.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_HASH);
>> +	__type(key, int);
>> +	__type(value, int);
>> +	__uint(max_entries, 24);
>> +} cg_map SEC(".maps");
>> +
>> +unsigned int victim_pid;
>> +u64 victim_cg_id;
>> +int failed_cnt;
>> +
>> +#define	EOPNOTSUPP	95
>> +
>> +enum {
>> +	NO_BPF_POLICY,
>> +	BPF_EVAL_ABORT,
>> +	BPF_EVAL_NEXT,
>> +	BPF_EVAL_SELECT,
>> +};
> 
> When I built a kernel using this series and tried building the
> associated test for that kernel I saw:
> 
> progs/oom_policy.c:22:2: error: redefinition of enumerator 'NO_BPF_POLICY'
>          NO_BPF_POLICY,
>          ^
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75894:2:
> note: previous definition is here
>          NO_BPF_POLICY = 0,
>          ^
> progs/oom_policy.c:23:2: error: redefinition of enumerator 'BPF_EVAL_ABORT'
>          BPF_EVAL_ABORT,
>          ^
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75895:2:
> note: previous definition is here
>          BPF_EVAL_ABORT = 1,
>          ^
> progs/oom_policy.c:24:2: error: redefinition of enumerator 'BPF_EVAL_NEXT'
>          BPF_EVAL_NEXT,
>          ^
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75896:2:
> note: previous definition is here
>          BPF_EVAL_NEXT = 2,
>          ^
> progs/oom_policy.c:  CLNG-BPF [test_maps] tailcall_bpf2bpf4.bpf.o
> 25:2: error: redefinition of enumerator 'BPF_EVAL_SELECT'
>          BPF_EVAL_SELECT,
>          ^
> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75897:2:
> note: previous definition is here
>          BPF_EVAL_SELECT = 3,
>          ^
> 4 errors generated.
> 
> 
> So you shouldn't need the enum definition since it already makes it into
> vmlinux.h.
> OK. It seems my vmlinux.h doesn't contain these enum...
> I also ran into test failures when I removed the above (and compilation
> succeeded):
> 
> 
> test_oom_policy:PASS:prepare cgroup env 0 nsec
> (cgroup_helpers.c:130: errno: No such file or directory) Opening
> /mnt/cgroup-test-work-dir23054//memory.max
> set_cgroup_prio:PASS:update_map 0 nsec
> set_cgroup_prio:PASS:update_map 0 nsec
> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
> expected 23058
> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
> expected 68
> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
> expected 1
> #154     oom_policy:FAIL
> Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
> 
> So it seems that because my system was using the cgroupv1 memory
> controller, it could not be used for v2 unless I rebooted with
> 
> systemd.unified_cgroup_hierarchy=1
> 
> ...on the boot commandline. It would be good to note any such
> requirements for this test in the selftests/bpf/README.rst.
> Might also be worth adding
> 
> write_cgroup_file("", "cgroup.subtree_control", "+memory");
> 
> ...to ensure the memory controller is enabled for the root cgroup.
> 
> At that point the test still failed:
> 
> set_cgroup_prio:PASS:update_map 0 nsec
> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
> expected 12649
> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
> expected 9583
> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
> expected 1
> #154     oom_policy:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> Successfully unloaded bpf_testmod.ko.
> 
> 
It seems that OOM is not invoked in your environment(you can check it in 
demsg). If the memcg OOM is invoked by the test, we would record the 
*victim_pid* and *victim_cgid* and they would not be zero. I guess the 
reason is memory_control is not enabled in cgroup 
"/mnt/cgroup-test-work-dir23054/", because I see the error message:
(cgroup_helpers.c:130: errno: No such file or directory) Opening
 > /mnt/cgroup-test-work-dir23054//memory.max

Thanks for your review and test!

> Are there other implicit assumptions about configuration that cause this
> test to fail perhaps?
> 
> Alan

