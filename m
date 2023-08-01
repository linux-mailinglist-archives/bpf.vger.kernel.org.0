Return-Path: <bpf+bounces-6598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A076BBB9
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2F82819D2
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4432359A;
	Tue,  1 Aug 2023 17:53:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910612CA5
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 17:53:39 +0000 (UTC)
Received: from out-68.mta1.migadu.com (out-68.mta1.migadu.com [IPv6:2001:41d0:203:375::44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37591BF9
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 10:53:37 -0700 (PDT)
Message-ID: <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690912415; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKIwQ6XjA3LqVwQdm3bk2uO/tWuHAceJkdWxu/HSYZI=;
	b=Ukf19d6T0inwp4GsUUcAc+z4MA61w0S/xyz7AcXmnxHSaM9+sJAuo4DaMv+yUxewSBlHFp
	K5H/orE6sWmtfHhAq0GipiFsU0yaaYEaRIE/Wn/uHk/z69yg9xbEmenOxj+kpXZpVU4CDs
	7YlhuvG6TQtbuJPCosT4Tz1IPeHKJTg=
Date: Tue, 1 Aug 2023 10:53:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230801142912.55078-1-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801142912.55078-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/1/23 7:29 AM, Yafang Shao wrote:
> Some statistic data is stored in percpu pointer but the kernel doesn't
> aggregate it into a single value, for example, the data in struct
> psi_group_cpu.
> 
> Currently, we can traverse percpu data using for_loop and bpf_per_cpu_ptr:
> 
>    for_loop(nr_cpus, callback_fn, callback_ctx, 0)
> 
> In the callback_fn, we retrieve the percpu pointer with bpf_per_cpu_ptr().
> The drawback is that 'nr_cpus' cannot be a variable; otherwise, it will be
> rejected by the verifier, hindering deployment, as servers may have
> different 'nr_cpus'. Using CONFIG_NR_CPUS is not ideal.
> 
> Alternatively, with the bpf_cpumask family, we can obtain a task's cpumask.
> However, it requires creating a bpf_cpumask, copying the cpumask from the
> task, and then parsing the CPU IDs from it, resulting in low efficiency.
> Introducing other kfuncs like bpf_cpumask_next might be necessary.
> 
> A new bpf helper, bpf_for_each_cpu, is introduced to conveniently traverse
> percpu data, covering all scenarios. It includes
> for_each_{possible, present, online}_cpu. The user can also traverse CPUs
> from a specific task, such as walking the CPUs of a cpuset cgroup when the
> task is in that cgroup.

The bpf subsystem has adopted kfunc approach. So there is no bpf helper
any more. You need to have a bpf_for_each_cpu kfunc instead.

But I am wondering whether we should use open coded iterator loops
    06accc8779c1  bpf: add support for open-coded iterator loops

In kernel, we have a global variable
    nr_cpu_ids (also in kernel/bpf/helpers.c)
which is used in numerous places for per cpu data struct access.

I am wondering whether we could have bpf code like
    int nr_cpu_ids __ksym;

    struct bpf_iter_num it;
    int i = 0;

    // nr_cpu_ids is special, we can give it a range [1, CONFIG_NR_CPUS].
    bpf_iter_num_new(&it, 1, nr_cpu_ids);
    while ((v = bpf_iter_num_next(&it))) {
           /* access cpu i data */
           i++;
    }
    bpf_iter_num_destroy(&it);

 From all existing open coded iterator loops, looks like
upper bound has to be a constant. We might need to extend support
to bounded scalar upper bound if not there.
> 
> In our use case, we utilize this new helper to traverse percpu psi data.
> This aids in understanding why CPU, Memory, and IO pressure data are high
> on a server or a container.
> 
> Due to the __percpu annotation, clang-14+ and pahole-1.23+ are required.
> 
> Yafang Shao (3):
>    bpf: Add bpf_for_each_cpu helper
>    cgroup, psi: Init root cgroup psi to psi_system
>    selftests/bpf: Add selftest for for_each_cpu
> 
>   include/linux/bpf.h                                |   1 +
>   include/linux/psi.h                                |   2 +-
>   include/uapi/linux/bpf.h                           |  32 +++++
>   kernel/bpf/bpf_iter.c                              |  72 +++++++++++
>   kernel/bpf/helpers.c                               |   2 +
>   kernel/bpf/verifier.c                              |  29 ++++-
>   kernel/cgroup/cgroup.c                             |   5 +-
>   tools/include/uapi/linux/bpf.h                     |  32 +++++
>   .../selftests/bpf/prog_tests/for_each_cpu.c        | 137 +++++++++++++++++++++
>   .../selftests/bpf/progs/test_for_each_cpu.c        |  63 ++++++++++
>   10 files changed, 372 insertions(+), 3 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each_cpu.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_for_each_cpu.c
> 

