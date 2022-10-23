Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF28609609
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJWUOU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 16:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJWUOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 16:14:19 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BC650185
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:14:18 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id a5so5111257qkl.6
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdoN/6hxxUjH5hT1N6oqOFNJ0JqzF1hmrhS7+xUG4QA=;
        b=eo2aYBIoV8q7RX9w1I/SEVUiPZpidahsqMd35ynwzE4IAMWbI35WLLNWMw/Yw0BQHB
         WhBeng/qVkrB2/CVmng67vD81a2NiMm1cjstnF1bnT6/uHHgQBBZ5dmagSLArX5sn6ta
         yq0rOblnDia769xX3v92CL6rIml0bUqJLUYLw5cXG3cGsZRdzqAcEjqAOatUUj58e389
         cWszJ93LjV4yXSsASb4smkaYIFWokwILBzZ4mHennd8SE4nXH7ryYkr6GRXkqv+joPS1
         IeGi6XU11XaOuRMqMWq/dcdKXqrf4BePo/KaBQkt5Tq3o3HnUc5Cc8BktBb8+PUfPNi4
         yhRw==
X-Gm-Message-State: ACrzQf2kth2fYA4Ni3FVB+VZoyyh1f1Z8RKS19WBlZGLp9FwQZ62dXyh
        mlpIl0d8eZfSyO6iydYreIA=
X-Google-Smtp-Source: AMsMyM5DdwFcjYXux+mok6SlxlHDG16C/U0q7MQvQ4Ltjqy/rr5oh0ZmP8yqOZTR/gOqizEmMnTUCQ==
X-Received: by 2002:a05:620a:1512:b0:6ee:b258:51f1 with SMTP id i18-20020a05620a151200b006eeb25851f1mr20784498qkk.716.1666556057773;
        Sun, 23 Oct 2022 13:14:17 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006eef13ef4c8sm12362049qko.94.2022.10.23.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:14:15 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:14:10 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v4 6/7] selftests/bpf: Add selftests for new
 cgroup local storage
Message-ID: <Y1Wgkt6fnWlXuLYD@maniforge.dhcp.thefacebook.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180546.2863789-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023180546.2863789-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 11:05:46AM -0700, Yonghong Song wrote:
> Add two tests for new cgroup local storage, one to test bpf program helpers
> and user space map APIs, and the other to test recursive fentry
> triggering won't deadlock.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../bpf/prog_tests/cgrp_local_storage.c       | 92 +++++++++++++++++++
>  .../selftests/bpf/progs/cgrp_local_storage.c  | 88 ++++++++++++++++++
>  .../selftests/bpf/progs/cgrp_ls_recursion.c   | 70 ++++++++++++++
>  3 files changed, 250 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgrp_local_storage.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> new file mode 100644
> index 000000000000..7ee21d598195
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <test_progs.h>
> +#include "cgrp_local_storage.skel.h"
> +#include "cgrp_ls_recursion.skel.h"
> +
> +static void test_sys_enter_exit(int cgroup_fd)
> +{
> +	struct cgrp_local_storage *skel;
> +	long val1 = 1, val2 = 0;
> +	int err;
> +
> +	skel = cgrp_local_storage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	/* populate a value in cgrp_storage_2 */
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd, &val1, BPF_ANY);
> +	if (!ASSERT_OK(err, "map_update_elem"))
> +		goto out;
> +
> +	/* check value */
> +	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd, &val2);
> +	if (!ASSERT_OK(err, "map_lookup_elem"))
> +		goto out;
> +	if (!ASSERT_EQ(val2, 1, "map_lookup_elem, invalid val"))
> +		goto out;
> +
> +	/* delete value */
> +	err = bpf_map_delete_elem(bpf_map__fd(skel->maps.cgrp_storage_2), &cgroup_fd);
> +	if (!ASSERT_OK(err, "map_delete_elem"))
> +		goto out;
> +
> +	skel->bss->target_pid = syscall(SYS_gettid);
> +
> +	err = cgrp_local_storage__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto out;
> +
> +	syscall(SYS_gettid);
> +	syscall(SYS_gettid);
> +
> +	skel->bss->target_pid = 0;
> +
> +	/* 3x syscalls: 1x attach and 2x gettid */
> +	ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
> +	ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
> +	ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
> +out:
> +	cgrp_local_storage__destroy(skel);
> +}
> +
> +static void test_recursion(int cgroup_fd)
> +{
> +	struct cgrp_ls_recursion *skel;
> +	int err;
> +
> +	skel = cgrp_ls_recursion__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		return;
> +
> +	err = cgrp_ls_recursion__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto out;
> +
> +	/* trigger sys_enter, make sure it does not cause deadlock */
> +	syscall(SYS_gettid);
> +
> +out:
> +	cgrp_ls_recursion__destroy(skel);
> +}
> +
> +void test_cgrp_local_storage(void)
> +{
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup("/cgrp_local_storage");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /cgrp_local_storage"))
> +		return;
> +
> +	if (test__start_subtest("sys_enter_exit"))
> +		test_sys_enter_exit(cgroup_fd);
> +	if (test__start_subtest("recursion"))
> +		test_recursion(cgroup_fd);
> +
> +	close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_local_storage.c b/tools/testing/selftests/bpf/progs/cgrp_local_storage.c
> new file mode 100644
> index 000000000000..dee63d4c1512
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgrp_local_storage.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, long);
> +} cgrp_storage_1 SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, long);
> +} cgrp_storage_2 SEC(".maps");
> +
> +#define MAGIC_VALUE 0xabcd1234
> +
> +pid_t target_pid = 0;
> +int mismatch_cnt = 0;
> +int enter_cnt = 0;
> +int exit_cnt = 0;
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(on_enter, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task;
> +	long *ptr;
> +	int err;
> +
> +	task = bpf_get_current_task_btf();
> +	if (task->pid != target_pid)
> +		return 0;
> +
> +	/* populate value 0 */
> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return 0;
> +
> +	/* delete value 0 */
> +	err = bpf_cgrp_storage_delete(&cgrp_storage_1, task->cgroups->dfl_cgrp);
> +	if (err)
> +		return 0;
> +
> +	/* value is not available */
> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0, 0);
> +	if (ptr)
> +		return 0;
> +
> +	/* re-populate the value */
> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return 0;

Should we also add a global int err variable to this program that we set
any time we can't fetch an instance of the local storage, etc  and then
check in the user space test progs logic?

> +	__sync_fetch_and_add(&enter_cnt, 1);
> +	*ptr = MAGIC_VALUE + enter_cnt;
> +
> +	return 0;
> +}
> +
> +SEC("tp_btf/sys_exit")
> +int BPF_PROG(on_exit, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task;
> +	long *ptr;
> +
> +	task = bpf_get_current_task_btf();
> +	if (task->pid != target_pid)
> +		return 0;
> +
> +	ptr = bpf_cgrp_storage_get(&cgrp_storage_1, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return 0;
> +
> +	__sync_fetch_and_add(&exit_cnt, 1);
> +	if (*ptr != MAGIC_VALUE + exit_cnt)
> +		__sync_fetch_and_add(&mismatch_cnt, 1);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> new file mode 100644
> index 000000000000..a043d8fefdac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, long);
> +} map_a SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, long);
> +} map_b SEC(".maps");
> +
> +SEC("fentry/bpf_local_storage_lookup")
> +int BPF_PROG(on_lookup)
> +{
> +	struct task_struct *task = bpf_get_current_task_btf();
> +
> +	bpf_cgrp_storage_delete(&map_a, task->cgroups->dfl_cgrp);
> +	bpf_cgrp_storage_delete(&map_b, task->cgroups->dfl_cgrp);
> +	return 0;
> +}
> +
> +SEC("fentry/bpf_local_storage_update")
> +int BPF_PROG(on_update)
> +{
> +	struct task_struct *task = bpf_get_current_task_btf();
> +	long *ptr;
> +
> +	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		*ptr += 1;
> +
> +	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		*ptr += 1;
> +
> +	return 0;
> +}
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(on_enter, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task;
> +	long *ptr;
> +
> +	task = bpf_get_current_task_btf();
> +	ptr = bpf_cgrp_storage_get(&map_a, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		*ptr = 200;
> +
> +	ptr = bpf_cgrp_storage_get(&map_b, task->cgroups->dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (ptr)
> +		*ptr = 100;
> +	return 0;
> +}
> -- 
> 2.30.2
> 


Looks reasonable overall. Should we also include any negative tests,
like e.g. trying to invoke bpf_cgrp_storage_get() with a struct other
than a cgroup?


Thanks,
David
