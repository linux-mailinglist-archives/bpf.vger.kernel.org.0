Return-Path: <bpf+bounces-19852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAC832260
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522E91C22555
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D34B1EA78;
	Thu, 18 Jan 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGZTSTqV"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA71EB36
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621584; cv=none; b=hkwHLvx2c+6eLZPEGNbhX2Qe1Obi85o8sA35SFUdjVZz3Hbzq7Y7O2KetPTOUFcKjEtfIcpl4UF/aKBymzQqJCX1T+9ZrRk6HF2STvWCUgMU8Pzii+Ov3SVTv45Xm4HRB5NThhrIw7ZPp6VyhOUcGUiH9Wt6tXLxKIpcfOZxFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621584; c=relaxed/simple;
	bh=Xl0h5L2fd25neAAROHrFTgoHIROMVMw/vprFzb05CwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqV+RtCkiF5mfdzttp6kdPK6zV6Su6HHp/VybG9WAHjX39y9JD05Ed8aXV34YYOh3AJzui9m2UkWEj3gmsnK99dtK2jtwEKLfKv+4j3G2qloakdZv/55lmroJfBd5B5EQojZ/ShJFbczvZ+WgKFUGI4ViZGLWOR4M7ta/WSCylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGZTSTqV; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e1e4aec-c33f-4d71-9add-5f15849f9075@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705621580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9OGzjQPgJu4t0WSdVN1Nr01hknLaU+f3FB7bQRkZeE=;
	b=iGZTSTqVWG4v+jEZKHP7doU12AA2XSfUmD1IoFrOV8kc9NTP6bjPbiltooSa2FHSBavZMf
	Gd1wYSG95rg5DqiHGLkDd8/QJXYaTkg7bqVRZsCQQ0kGjmXSpOZWyUG2sNp1QmLeoobjPA
	GH4IwF8USxGnpkvqvOsPzPINfWC9Iko=
Date: Thu, 18 Jan 2024 15:46:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add selftests for cpumask
 iter
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, tj@kernel.org
Cc: bpf@vger.kernel.org, lkp@intel.com
References: <20240117024823.4186-1-laoar.shao@gmail.com>
 <20240117024823.4186-4-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240117024823.4186-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/16/24 6:48 PM, Yafang Shao wrote:
> Within the BPF program, we leverage the cgroup iterator to iterate through
> percpu runqueue data, specifically the 'nr_running' metric. Subsequently
>   we expose this data to userspace by means of a sequence file.
>
> The CPU affinity for the cpumask is determined by the PID of a task:
>
> - PID of the init task (PID 1)
>    We typically don't set CPU affinity for init task and thus we can iterate
>    across all possible CPUs. However, in scenarios where you've set CPU
>    affinity for the init task, you should set the cpumask of your current
>    task to full-F. Then proceed to iterate through all possible CPUs using

Wat is full-F? It would be good if you can clarify in the commit message.

>    the current task.
> - PID of a task with defined CPU affinity
>    The aim here is to iterate through a specific cpumask. This scenario
>    aligns with tasks residing within a cpuset cgroup.
> - Invalid PID (e.g., PID -1)
>    No cpumask is available in this case.
>
> The result as follows,
>    #65/1    cpumask_iter/init_pid:OK
>    #65/2    cpumask_iter/invalid_pid:OK
>    #65/3    cpumask_iter/self_pid_one_cpu:OK
>    #65/4    cpumask_iter/self_pid_multi_cpus:OK
>    #65      cpumask_iter:OK
>    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>
> CONFIG_PSI=y is required for this testcase.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   tools/testing/selftests/bpf/config            |   1 +
>   .../selftests/bpf/prog_tests/cpumask_iter.c   | 134 ++++++++++++++++++
>   .../selftests/bpf/progs/cpumask_common.h      |   3 +
>   .../selftests/bpf/progs/test_cpumask_iter.c   |  56 ++++++++
>   4 files changed, 194 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_cpumask_iter.c
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index c125c441abc7..9c42568ed376 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -78,6 +78,7 @@ CONFIG_NF_CONNTRACK_MARK=y
>   CONFIG_NF_DEFRAG_IPV4=y
>   CONFIG_NF_DEFRAG_IPV6=y
>   CONFIG_NF_NAT=y
> +CONFIG_PSI=y
>   CONFIG_RC_CORE=y
>   CONFIG_SECURITY=y
>   CONFIG_SECURITYFS=y
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
> new file mode 100644
> index 000000000000..984d01d09d79
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask_iter.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "test_cpumask_iter.skel.h"
> +
> +static void verify_percpu_data(struct bpf_link *link, int nr_cpu_exp, int nr_running_exp)
> +{
> +	int iter_fd, len, item, nr_running, psi_running, nr_cpus;
> +	static char buf[128];

why static?

> +	size_t left;
> +	char *p;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "iter_fd"))
> +		return;
> +
> +	memset(buf, 0, sizeof(buf));
> +	left = ARRAY_SIZE(buf);
> +	p = buf;
> +	while ((len = read(iter_fd, p, left)) > 0) {
> +		p += len;
> +		left -= len;
> +	}
> +
> +	item = sscanf(buf, "nr_running %u nr_cpus %u psi_running %u\n",
> +		      &nr_running, &nr_cpus, &psi_running);
> +	if (nr_cpu_exp == -1) {
> +		ASSERT_EQ(item, -1, "seq_format");
> +		goto out;
> +	}
> +
> +	ASSERT_EQ(item, 3, "seq_format");
> +	ASSERT_GE(nr_running, nr_running_exp, "nr_running");
> +	ASSERT_GE(psi_running, nr_running_exp, "psi_running");
> +	ASSERT_EQ(nr_cpus, nr_cpu_exp, "nr_cpus");
> +
> +	/* read() after iter finishes should be ok. */
> +	if (len == 0)
> +		ASSERT_OK(read(iter_fd, buf, sizeof(buf)), "second_read");

The above 'if' statement is irrelevant to the main purpose of this test
and can be removed.

> +
> +out:
> +	close(iter_fd);
> +}
> +
> +void test_cpumask_iter(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	int nr_possible, cgrp_fd, pid, err, cnt, i;
> +	struct test_cpumask_iter *skel = NULL;

= NULL is not needed.

> +	union bpf_iter_link_info linfo;
> +	int cpu_ids[] = {1, 3, 4, 5};
> +	struct bpf_link *link;
> +	cpu_set_t set;
> +
> +	skel = test_cpumask_iter__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_for_each_cpu__open_and_load"))
> +		return;
> +
> +	if (setup_cgroup_environment())
> +		goto destroy;
> +
> +	/* Utilize the cgroup iter */
> +	cgrp_fd = get_root_cgroup();
> +	if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
> +		goto cleanup;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.cgroup.cgroup_fd = cgrp_fd;
> +	linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	link = bpf_program__attach_iter(skel->progs.cpu_cgroup, &opts);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		goto close_fd;
> +
> +	skel->bss->target_pid = 1;
> +	/* In case init task is set CPU affinity */
> +	err = sched_getaffinity(1, sizeof(set), &set);
> +	if (!ASSERT_OK(err, "setaffinity"))
> +		goto close_fd;

goto free_link.

> +
> +	cnt = CPU_COUNT(&set);
> +	nr_possible = bpf_num_possible_cpus();
> +	if (test__start_subtest("init_pid"))
> +		/* curent task is running. */
> +		verify_percpu_data(link, cnt, cnt == nr_possible ? 1 : 0);
[...]

