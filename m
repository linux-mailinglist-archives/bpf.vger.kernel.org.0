Return-Path: <bpf+bounces-13645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF20A7DC372
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3005AB20D93
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981036C;
	Tue, 31 Oct 2023 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHnhkc35"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB3362
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 00:14:35 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A39B3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 17:14:33 -0700 (PDT)
Message-ID: <ee860d67-4e62-452b-bcfb-66c3a1b0c802@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698711271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kop3YU72ZWeLXrFFlj38Wcp2BT7i2sfdnRxISQs9euA=;
	b=DHnhkc359jotLY0OBHTtxvs5lJWlDusq3FVn1Yf4bHRlNRhYVI11wfJVG+o0PpnEMK8EZM
	TUSusr3uP33Z0AhMPEB31XHa1vMU3Z0VR/F/U+NJzUJQ+HiZTFZGJaP0/4Vq/SOqmAoUYB
	QEwIE6394JuzkOkqrv3sjVrqax7ky2I=
Date: Mon, 30 Oct 2023 17:14:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add tests for css_task
 iter combining with cgroup iter
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
 <20231025075914.30979-3-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231025075914.30979-3-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/25/23 12:59 AM, Chuyi Zhou wrote:
> This patch adds a test which demonstrates how css_task iter can be combined
> with cgroup iter and it won't cause deadlock, though cgroup iter is not
> sleepable.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Ack with a few nits below:

Acked-by: Yonghong Song <yonghong.song@linux.dev>


> ---
>   .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
>   .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
>   2 files changed, 74 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> index e02feb5fae97..3679687a6927 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> @@ -4,6 +4,7 @@
>   #include <test_progs.h>
>   #include <bpf/libbpf.h>
>   #include <bpf/btf.h>
> +#include "iters_css_task.skel.h"
>   #include "cgroup_iter.skel.h"
>   #include "cgroup_helpers.h"
>   
> @@ -263,6 +264,35 @@ static void test_walk_dead_self_only(struct cgroup_iter *skel)
>   	close(cgrp_fd);
>   }
>   
> +static void test_walk_self_only_css_task(void)
> +{
> +	struct iters_css_task *skel = NULL;

'= NULL' is unnecessary.

> +	int err;
> +
> +	skel = iters_css_task__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.cgroup_id_printer, true);
> +
> +	err = iters_css_task__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	err = join_cgroup(cg_path[CHILD2]);
> +	if (!ASSERT_OK(err, "join_cgroup"))
> +		goto cleanup;
> +
> +	skel->bss->target_pid = getpid();
> +	snprintf(expected_output, sizeof(expected_output),
> +		PROLOGUE "%8llu\n" EPILOGUE, cg_id[CHILD2]);
> +	read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[CHILD2],
> +		BPF_CGROUP_ITER_SELF_ONLY, "test_walk_self_only_css_task");
> +	ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
> +cleanup:
> +	iters_css_task__destroy(skel);
> +}
> +
>   void test_cgroup_iter(void)
>   {
>   	struct cgroup_iter *skel = NULL;
> @@ -293,6 +323,9 @@ void test_cgroup_iter(void)
>   		test_walk_self_only(skel);
>   	if (test__start_subtest("cgroup_iter__dead_self_only"))
>   		test_walk_dead_self_only(skel);
> +	if (test__start_subtest("cgroup_iter__self_only_css_task"))
> +		test_walk_self_only_css_task();
> +
>   out:
>   	cgroup_iter__destroy(skel);
>   	cleanup_cgroups();
> diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
> index 5089ce384a1c..0974e6f44328 100644
> --- a/tools/testing/selftests/bpf/progs/iters_css_task.c
> +++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
> @@ -10,6 +10,7 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> +struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
>   struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
>   void bpf_cgroup_release(struct cgroup *p) __ksym;
>   
> @@ -45,3 +46,43 @@ int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
>   
>   	return -EPERM;
>   }
> +
> +static inline u64 cgroup_id(struct cgroup *cgrp)
> +{
> +	return cgrp->kn->id;
> +}
> +
> +SEC("?iter/cgroup")
> +int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct cgroup *cgrp, *acquired;
> +	struct cgroup_subsys_state *css;
> +	struct task_struct *task;
> +
> +	cgrp = ctx->cgroup;
> +
> +	/* epilogue */
> +	if (cgrp == NULL) {
> +		BPF_SEQ_PRINTF(seq, "epilogue\n");
> +		return 0;
> +	}
> +
> +	/* prologue */
> +	if (ctx->meta->seq_num == 0)
> +		BPF_SEQ_PRINTF(seq, "prologue\n");
> +
> +	BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
> +
> +	acquired = bpf_cgroup_from_id(cgroup_id(cgrp));

cgroup_id(cgrp) needs only one call.

> +	if (!acquired)
> +		return 0;
> +	css = &acquired->self;
> +	css_task_cnt = 0;
> +	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
> +		if (task->pid == target_pid)
> +			css_task_cnt++;
> +	}
> +	bpf_cgroup_release(acquired);
> +	return 0;
> +}

