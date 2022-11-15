Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2086629203
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 07:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiKOGuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 01:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiKOGuL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 01:50:11 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8589D17045
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:50:09 -0800 (PST)
Message-ID: <7bd272c8-6e28-cdcd-6728-a78a71f6b0d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668495007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tu9Q59h3gwISQ6xJep1rERFJXm0UI6CBwa3P81GJ7dc=;
        b=mdE6Sra3d1ExbIMyrnklrESHf0lO0cMPGeuptPdN2ZiT9zBWHA2iJX+cCGQyQA69DURnCI
        PGOt98kwVDMLdI0kjdrJRuTiH+c/GIoMIoPuCdAbG1h1bSBzIZlnHAwursrS0qVJDWKhSR
        4xubhQUQygKUdGQ3Rhwzn78Yy68rEPs=
Date:   Mon, 14 Nov 2022 22:50:03 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 6/7] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20221111165734.2524596-1-yhs@fb.com>
 <20221111165805.2528458-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221111165805.2528458-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11/22 8:58 AM, Yonghong Song wrote:
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> new file mode 100644
> index 000000000000..c11b4f8f9a9d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_tracing_net.h"
> +#include "bpf_misc.h"
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
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, long);
> +} map_b SEC(".maps");
> +
> +__u32 user_data, key_serial, target_pid = 0;
> +__u64 flags, result = 0;
> +
> +struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
> +void bpf_key_put(struct bpf_key *key) __ksym;
> +void bpf_rcu_read_lock(void) __ksym;
> +void bpf_rcu_read_unlock(void) __ksym;
> +
> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int cgrp_succ(void *ctx)
> +{
> +	struct task_struct *task;
> +	struct css_set *cgroups;
> +	struct cgroup *dfl_cgrp;
> +	long init_val = 2;
> +	long *ptr;
> +
> +	task = bpf_get_current_task_btf();
> +	if (task->pid != target_pid)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	cgroups = task->cgroups;
> +	dfl_cgrp = cgroups->dfl_cgrp;
> +	bpf_rcu_read_unlock();

Outside of the rcu section, "cgroups" could have been gone.  Is it possible that 
"dfl_cgrp" could be gone together with "cgroups"?

> +	ptr = bpf_cgrp_storage_get(&map_a, dfl_cgrp, &init_val,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return 0;
> +	ptr = bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0, 0);
> +	if (!ptr)
> +		return 0;
> +	result = *ptr;
> +	return 0;
> +}
> +

[ ... ]

> +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> +int miss_unlock(void *ctx)
> +{
> +	struct task_struct *task;
> +	struct css_set *cgroups;
> +	struct cgroup *dfl_cgrp;
> +
> +	/* missing bpf_rcu_read_unlock() */
> +	bpf_rcu_read_lock();


> +	task = bpf_get_current_task_btf();
> +	bpf_rcu_read_lock();

One of the bpf_rcu_read_lock() needs to be removed.  Otherwise, I think the 
verifier will error on the nested rcu read lock first instead of testing the 
missing unlock case here.

> +	cgroups = task->cgroups;
> +	bpf_rcu_read_unlock();
> +	dfl_cgrp = cgroups->dfl_cgrp;
> +	(void)bpf_cgrp_storage_get(&map_a, dfl_cgrp, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	return 0;
> +}

