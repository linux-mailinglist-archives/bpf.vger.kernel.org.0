Return-Path: <bpf+bounces-13884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E917DEAFB
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBEE1C20EA0
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D081854;
	Thu,  2 Nov 2023 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FzeakQ6t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EF1849
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 02:53:25 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BF7101
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 19:53:08 -0700 (PDT)
Message-ID: <5102ba67-66b1-4751-a8b2-170888873746@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698893586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xhIdiZPbHGRqTCQJRfE2AxlC8Go7MvaywKBttFZr3E=;
	b=FzeakQ6tZxz+faxnvN7FWlrB6JmM6GRXDVl/l9GNDJF/Ttp+SX2KTkeOz1+K+aTszlJcC5
	q+kfLQPAegy9RSwDrvS/vg4ZjHTtwItxMnDtl51vUUUJZncQ7S0ftviqf91+xToXrNsC+y
	QlHFqeim9YlDD95iU9LKRgYzGmPiWy8=
Date: Wed, 1 Nov 2023 19:52:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add test for using
 css_task iter in sleepable progs
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231031050438.93297-1-zhouchuyi@bytedance.com>
 <20231031050438.93297-4-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231031050438.93297-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/30/23 10:04 PM, Chuyi Zhou wrote:
> This Patch add a test to prove css_task iter can be used in normal
> sleepable progs.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../testing/selftests/bpf/prog_tests/iters.c  |  1 +
>   .../selftests/bpf/progs/iters_css_task.c      | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
> index c2425791c923..bf84d4a1d9ae 100644
> --- a/tools/testing/selftests/bpf/prog_tests/iters.c
> +++ b/tools/testing/selftests/bpf/prog_tests/iters.c
> @@ -294,6 +294,7 @@ void test_iters(void)
>   	RUN_TESTS(iters_state_safety);
>   	RUN_TESTS(iters_looping);
>   	RUN_TESTS(iters);
> +	RUN_TESTS(iters_css_task);
>   
>   	if (env.has_testmod)
>   		RUN_TESTS(iters_testmod_seq);
> diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
> index 384ff806990f..e180aa1b1d52 100644
> --- a/tools/testing/selftests/bpf/progs/iters_css_task.c
> +++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
> @@ -89,3 +89,22 @@ int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
>   	bpf_cgroup_release(acquired);
>   	return 0;
>   }
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int BPF_PROG(iter_css_task_for_each_sleep)
> +{
> +	u64 cgrp_id = bpf_get_current_cgroup_id();
> +	struct cgroup *cgrp = bpf_cgroup_from_id(cgrp_id);
> +	struct cgroup_subsys_state *css;
> +	struct task_struct *task;
> +
> +	if (cgrp == NULL)
> +		return 0;
> +	css = &cgrp->self;
> +
> +	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
> +
> +	}
> +	bpf_cgroup_release(cgrp);
> +	return 0;
> +}

