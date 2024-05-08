Return-Path: <bpf+bounces-29142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C298B8C07AD
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388E81F230D3
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8F12F360;
	Wed,  8 May 2024 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHX37GqU"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411901BC40
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211285; cv=none; b=fOHefOEU80t7diQtF1NaGOXxE+mq/Xr/ndVUmkguVhKT/xQcQ1gvD+vJzqJDFVXUY0+zdPpYmojJJFqXLeT5vHIs9/8fSDxo4HMbi1DDOFG1ddWvwI4HxcNT4xXJHzEn4Sz1+kBzDHUpZfKWQzeRUWxHPl99u1MlQkUBZZY1pFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211285; c=relaxed/simple;
	bh=k8loCCR03sILU/1AjKhrn+b8TzThdqoqT7fZqTDoBU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8kanPyaERsL3KJnPrWb4/059vf0azf5NSzJTZxk0E0mon82s704iBStQI8wJ3bD2DQcC42eUDi76sEJNBmQ/n501CFIArteuo/EC0Yv+Nye6DOklIf4mwPtiW+ivU2ajHt29dCXbz5Dtmrq+a7gNm+oZ2el4Az5IOA9iqVNxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHX37GqU; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de29eee0-9a69-4f97-b77e-83294dc8ed6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715211281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfftXsYN+ssZWNnyTDurDkbKBgJ7bXu3W+ZGYbpmznU=;
	b=OHX37GqU+j//g77eSiNAmHx0lPS3OimzCC6rbS5g+U1LaGY5eQekZHUX0t4nKToRdOfCQI
	IhvWSPo+WWzVyTQ7mVohSt5qYy446Pm1K6x9h2KfETvFWMrr72kwqbyjvOFKGeUZxvLZzv
	giywQujYfpBW2I8pPHQp2IzOxe5uvso=
Date: Wed, 8 May 2024 16:34:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/6] selftests/bpf: test struct_ops with epoll
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240507055600.2382627-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
> Verify whether a user space program is informed through epoll with EPOLLHUP
> when a struct_ops object is detached.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 +++++
>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
>   .../bpf/prog_tests/test_struct_ops_module.c   | 57 +++++++++++++++++++
>   .../selftests/bpf/progs/struct_ops_detach.c   | 31 ++++++++++
>   4 files changed, 102 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index e24a18bfee14..c89a6414c69f 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -10,6 +10,7 @@
>   #include <linux/percpu-defs.h>
>   #include <linux/sysfs.h>
>   #include <linux/tracepoint.h>
> +#include <linux/workqueue.h>
>   #include "bpf_testmod.h"
>   #include "bpf_testmod_kfunc.h"
>   
> @@ -498,6 +499,9 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
>   {
>   }
>   
> +static DEFINE_MUTEX(detach_mutex);
> +static struct bpf_link *link_to_detach;
> +
>   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -577,11 +581,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>   	if (ops->test_2)
>   		ops->test_2(4, ops->data);
>   
> +	mutex_lock(&detach_mutex);
> +	if (!link_to_detach)
> +		link_to_detach = link;
> +	mutex_unlock(&detach_mutex);
> +
>   	return 0;
>   }
>   
>   static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
>   {
> +	mutex_lock(&detach_mutex);
> +	if (link == link_to_detach)
> +		link_to_detach = NULL;
> +	mutex_unlock(&detach_mutex);

The reg/unreg changes should belong to the next patch.

>   }
>   
>   static int bpf_testmod_test_1(void)
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> index ce5cd763561c..9f9b60880fd3 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -105,6 +105,7 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
>   void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
>   void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
>   void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
> +int bpf_dummy_do_link_detach(void) __ksym;

The kfunc is not added in this patch either.

>   
>   void bpf_kfunc_common_test(void) __ksym;
>   #endif /* _BPF_TESTMOD_KFUNC_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index bd39586abd5a..f39455b81664 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -2,8 +2,12 @@
>   /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>   #include <test_progs.h>
>   #include <time.h>
> +#include <network_helpers.h>

What is needed from network_herlpers.h?

> +
> +#include <sys/epoll.h>
>   
>   #include "struct_ops_module.skel.h"
> +#include "struct_ops_detach.skel.h"
>   
>   static void check_map_info(struct bpf_map_info *info)
>   {
> @@ -174,6 +178,57 @@ static void test_struct_ops_incompatible(void)
>   	struct_ops_module__destroy(skel);
>   }
>   
> +/* Detach a link from a user space program */
> +static void test_detach_link(void)
> +{
> +	struct epoll_event ev, events[2];
> +	struct struct_ops_detach *skel;
> +	struct bpf_link *link = NULL;
> +	int fd, epollfd = -1, nfds;
> +	int err;
> +
> +	skel = struct_ops_detach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_detach__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto cleanup;
> +
> +	fd = bpf_link__fd(link);
> +	if (!ASSERT_GE(fd, 0, "link_fd"))
> +		goto cleanup;
> +
> +	epollfd = epoll_create1(0);
> +	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
> +		goto cleanup;
> +
> +	ev.events = EPOLLHUP;
> +	ev.data.fd = fd;
> +	err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
> +	if (!ASSERT_OK(err, "epoll_ctl"))
> +		goto cleanup;
> +
> +	err = bpf_link__detach(link);
> +	if (!ASSERT_OK(err, "detach_link"))
> +		goto cleanup;
> +
> +	/* Wait for EPOLLHUP */
> +	nfds = epoll_wait(epollfd, events, 2, 500);
> +	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
> +		goto cleanup;
> +	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
> +		goto cleanup;
> +
> +cleanup:
> +	close(epollfd);

Better check epollfd since it is init to -1. There are cases that epollfd is -1 
here.

> +	bpf_link__destroy(link);
> +	struct_ops_detach__destroy(skel);
> +}
> +
>   void serial_test_struct_ops_module(void)
>   {
>   	if (test__start_subtest("test_struct_ops_load"))
> @@ -182,5 +237,7 @@ void serial_test_struct_ops_module(void)
>   		test_struct_ops_not_zeroed();
>   	if (test__start_subtest("test_struct_ops_incompatible"))
>   		test_struct_ops_incompatible();
> +	if (test__start_subtest("test_detach_link"))
> +		test_detach_link();
>   }
>   
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> new file mode 100644
> index 000000000000..aeb355b3bea3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"

The _kfunc.h should not be needed in this patch either.

> +
> +char _license[] SEC("license") = "GPL";
> +
> +int test_1_result = 0;
> +int test_2_result = 0;

Are these global vars tested? If not, can the test_1 and test_2 programs be 
removed? or some of them is not optional?

> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_1)
> +{
> +	test_1_result = 0xdeadbeef;
> +	return 0;
> +}
> +
> +SEC("struct_ops/test_2")
> +void BPF_PROG(test_2, int a, int b)
> +{
> +	test_2_result = a + b;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_do_detach = {
> +	.test_1 = (void *)test_1,
> +	.test_2 = (void *)test_2,
> +};


