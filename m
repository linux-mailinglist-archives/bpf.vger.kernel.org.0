Return-Path: <bpf+bounces-13696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B427DC6C9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68671C20AD9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09161D524;
	Tue, 31 Oct 2023 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t759mRqK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD2D297
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:59:12 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B41BB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:59:10 -0700 (PDT)
Message-ID: <ee0d2862-7bc8-76da-1eca-30b3c80858a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698735549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeYSbXm9AHXLIERC3BTSecLjMsQTfyG/SZvkSpx/uTA=;
	b=t759mRqKVo0GFovw4Xe4c4S5mer2Hk+hCnVjnGg4bqKK59HLwCVdnpLpq2BRaW1YAak5+M
	0mX8Ui0WSojbHBcliJLyr/BE4zKJv9uQ7O1z5/vFDFe8tWLBZUX+zIv5xcoMAGtsZLH0g1
	GYrYz0yyEc+FdNtnRXVSGg5Vs0VZkzg=
Date: Mon, 30 Oct 2023 23:59:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-11-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-11-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..3a00dc294583
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>
> +
> +#include "rcu_tasks_trace_gp.skel.h"
> +#include "struct_ops_module.skel.h"
> +
> +static void test_regular_load(void)
> +{
> +	struct struct_ops_module *skel;
> +	struct bpf_link *link;
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	int err;
> +
> +	skel = struct_ops_module__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +		return;
> +	err = struct_ops_module__load(skel);
> +	if (!ASSERT_OK(err, "struct_ops_module_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
> +
> +	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> +
> +	bpf_link__destroy(link);
> +
> +	struct_ops_module__destroy(skel);
> +}
> +
> +void serial_test_struct_ops_module(void)
> +{
> +	if (test__start_subtest("regular_load"))
> +		test_regular_load();

Could it also add some negative tests, e.g. missing 'struct 
bpf_struct_ops_common_value', reg() when the module is gone...etc.

[ ... ]

> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
> +static int kern_sync_rcu_tasks_trace(void)

With patch 4, is it still needed?

> +{
> +	struct rcu_tasks_trace_gp *rcu;
> +	time_t start;
> +	long gp_seq;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +
> +	rcu = rcu_tasks_trace_gp__open_and_load();
> +	if (IS_ERR(rcu))
> +		return -EFAULT;
> +	if (rcu_tasks_trace_gp__attach(rcu))
> +		return -EFAULT;
> +
> +	gp_seq = READ_ONCE(rcu->bss->gp_seq);
> +
> +	if (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
> +				   &opts))
> +		return -EFAULT;
> +	if (opts.retval != 0)
> +		return -EFAULT;
> +
> +	start = time(NULL);
> +	while ((start + 2) > time(NULL) &&
> +	       gp_seq == READ_ONCE(rcu->bss->gp_seq))
> +		sched_yield();
> +
> +	rcu_tasks_trace_gp__destroy(rcu);
> +
> +	return 0;
> +}
> +
>   /*
>    * Trigger synchronize_rcu() in kernel.
>    */
>   int kern_sync_rcu(void)
>   {
> +	if (kern_sync_rcu_tasks_trace())
> +		return -EFAULT;
>   	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>   }


