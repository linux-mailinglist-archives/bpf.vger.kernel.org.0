Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E965E96D
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjAEK5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 05:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjAEK5U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 05:57:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE650E7E
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 02:57:16 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nnjwf5ZkXzqTvk;
        Thu,  5 Jan 2023 18:52:34 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 5 Jan 2023 18:57:14 +0800
Subject: Re: [bpf-next v4 2/2] selftests/bpf: add test case for htab map
To:     <tong@infragraf.org>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230105092637.35069-1-tong@infragraf.org>
 <20230105092637.35069-2-tong@infragraf.org>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <a5c0ae06-774f-daa6-54f9-08054b6250f7@huawei.com>
Date:   Thu, 5 Jan 2023 18:56:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230105092637.35069-2-tong@infragraf.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/5/2023 5:26 PM, tong@infragraf.org wrote:
> From: Tonghao Zhang <tong@infragraf.org>
>
> This testing show how to reproduce deadlock in special case.
> We update htab map in Task and NMI context. Task can be interrupted by
> NMI, if the same map bucket was locked, there will be a deadlock.
>
> * map max_entries is 2.
> * NMI using key 4 and Task context using key 20.
> * so same bucket index but map_locked index is different.
>
> The selftest use perf to produce the NMI and fentry nmi_handle.
> Note that bpf_overflow_handler checks bpf_prog_active, but in bpf update
> map syscall increase this counter in bpf_disable_instrumentation.
> Then fentry nmi_handle and update hash map will reproduce the issue.
>
> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Hou Tao<houtao1@huawei.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../selftests/bpf/prog_tests/htab_deadlock.c  | 75 +++++++++++++++++++
>  .../selftests/bpf/progs/htab_deadlock.c       | 30 ++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_deadlock.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 99cc33c51eaa..42d98703f209 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -24,6 +24,7 @@ fexit_test                                       # fexit_attach unexpected error
>  get_func_args_test                               # get_func_args_test__attach unexpected error: -524 (errno 524) (trampoline)
>  get_func_ip_test                                 # get_func_ip_test__attach unexpected error: -524 (errno 524) (trampoline)
>  htab_update/reenter_update
> +htab_deadlock                                    # fentry failed: -524 (trampoline)
>  kfree_skb                                        # attach fentry unexpected error: -524 (trampoline)
>  kfunc_call/subprog                               # extern (var ksym) 'bpf_prog_active': not found in kernel BTF
>  kfunc_call/subprog_lskel                         # skel unexpected error: -2
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 3efe091255bf..ab11f71842a5 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -26,6 +26,7 @@ get_func_args_test	                 # trampoline
>  get_func_ip_test                         # get_func_ip_test__attach unexpected error: -524                             (trampoline)
>  get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
>  htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> +htab_deadlock                            # fentry failed: -524                                                         (trampoline)
>  jit_probe_mem                            # jit_probe_mem__open_and_load unexpected error: -524                         (kfunc)
>  kfree_skb                                # attach fentry unexpected error: -524                                        (trampoline)
>  kfunc_call                               # 'bpf_prog_active': not found in kernel BTF                                  (?)
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> new file mode 100644
> index 000000000000..137dce8f1346
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_deadlock.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <test_progs.h>
> +
> +#include "htab_deadlock.skel.h"
> +
> +static int perf_event_open(void)
> +{
> +	struct perf_event_attr attr = {0};
> +	int pfd;
> +
> +	/* create perf event on CPU 0 */
> +	attr.size = sizeof(attr);
> +	attr.type = PERF_TYPE_HARDWARE;
> +	attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +	attr.freq = 1;
> +	attr.sample_freq = 1000;
> +	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> +
> +	return pfd >= 0 ? pfd : -errno;
> +}
> +
> +void test_htab_deadlock(void)
> +{
> +	unsigned int val = 0, key = 20;
> +	struct bpf_link *link = NULL;
> +	struct htab_deadlock *skel;
> +	int err, i, pfd;
> +	cpu_set_t cpus;
> +
> +	skel = htab_deadlock__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	err = htab_deadlock__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto clean_skel;
> +
> +	/* NMI events. */
> +	pfd = perf_event_open();
> +	if (pfd < 0) {
> +		if (pfd == -ENOENT || pfd == -EOPNOTSUPP) {
> +			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
> +			test__skip();
> +			goto clean_skel;
> +		}
> +		if (!ASSERT_GE(pfd, 0, "perf_event_open"))
> +			goto clean_skel;
> +	}
> +
> +	link = bpf_program__attach_perf_event(skel->progs.bpf_empty, pfd);
> +	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
> +		goto clean_pfd;
> +
> +	/* Pinned on CPU 0 */
> +	CPU_ZERO(&cpus);
> +	CPU_SET(0, &cpus);
> +	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
> +
> +	/* update bpf map concurrently on CPU0 in NMI and Task context.
> +	 * there should be no kernel deadlock.
> +	 */
> +	for (i = 0; i < 100000; i++)
> +		bpf_map_update_elem(bpf_map__fd(skel->maps.htab),
> +				    &key, &val, BPF_ANY);
> +
> +	bpf_link__destroy(link);
> +clean_pfd:
> +	close(pfd);
> +clean_skel:
> +	htab_deadlock__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/htab_deadlock.c b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> new file mode 100644
> index 000000000000..dacd003b1ccb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_deadlock.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 DiDi Global Inc. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 2);
> +	__uint(map_flags, BPF_F_ZERO_SEED);
> +	__type(key, unsigned int);
> +	__type(value, unsigned int);
> +} htab SEC(".maps");
> +
> +SEC("fentry/perf_event_overflow")
> +int bpf_nmi_handle(struct pt_regs *regs)
> +{
> +	unsigned int val = 0, key = 4;
> +
> +	bpf_map_update_elem(&htab, &key, &val, BPF_ANY);
> +	return 0;
> +}
> +
> +SEC("perf_event")
> +int bpf_empty(struct pt_regs *regs)
> +{
> +	return 0;
> +}

