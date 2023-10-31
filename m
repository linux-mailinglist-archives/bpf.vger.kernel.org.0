Return-Path: <bpf+bounces-13646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E07DC380
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA80B20E2C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6E809;
	Tue, 31 Oct 2023 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wzs3zE+m"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634F7F2
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:20:17 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE468E
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:20:16 -0700 (PDT)
Message-ID: <c361ad7b-9c82-4ec2-ad39-86bdcdf9bd60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698711614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv2AEU+Oluvwf5eOUE12+8TE/PWIR4n/Gs7mzmHUJK4=;
	b=Wzs3zE+mCBqPDQdQD0HKZ8CRGxwMgD/UnE2X9uDQvX48YtD94lTYkFYovhbDGclwC8YAPd
	LogfNPn8UpfVsPdeYovpF4fbUfqvPoJ/KzUmSrgEkMON4HG2IblwLK8mKdSpEpx8Ot8wxr
	zt9/NPHVAKPytu4LmMnrgyhDPy9mPc4=
Date: Mon, 30 Oct 2023 17:20:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add test for using
 css_task iter in sleepable progs
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
 <20231025075914.30979-4-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025075914.30979-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 12:59 AM, Chuyi Zhou wrote:
> This Patch add a test to prove css_task iter can be used in normal
> sleepable progs.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>   .../selftests/bpf/progs/iters_task_failure.c  | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
> index 6b1588d70652..fe0b19e545d0 100644
> --- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
> +++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
> @@ -103,3 +103,22 @@ int BPF_PROG(iter_css_task_for_each)
>   	bpf_cgroup_release(cgrp);
>   	return 0;
>   }
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int BPF_PROG(iter_css_task_for_each_sleep)
> +{
> +	u64 cg_id = bpf_get_current_cgroup_id();
> +	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
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

Could you move this prog toiters_css_task.c and add a subtest in cgroup_iter.c? The file 
iters_task_failure.c intends for negative tests. This prog succeeds with 
loading.


