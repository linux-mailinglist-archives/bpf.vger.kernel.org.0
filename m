Return-Path: <bpf+bounces-39807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC3977BBD
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F7928780E
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A901D6C6D;
	Fri, 13 Sep 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZu28WzE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB51D6C56
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217980; cv=none; b=BZn3OS4n6D/ceBSMS5zR4qNUuix0Euc3t8HymQfWJMLDuLViPgv9NrqiR9SIOQpqyIygHJXGMiWiIuo/lhCUOgWkflFtn22xELdCdaPqHPD8dU27xL3cmctz0IczdeQ1CbPruROibXDQkyLhZd1qNzAH64ATjogljNF1CCN0Rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217980; c=relaxed/simple;
	bh=ROxwTYSbJpgVJXYiRtwEYeFoFaiRZDcceqBT+kcqYCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=txmNc3NApijNgp7L4UruhvoJGQKrD94zLlkGoFr6fkipm1nWm/xt+dJxGoPyZDlgxbssuaD9foBLZVmuJYIpfAZuluJwDYxH4kvTsOwRJId3xJ1T8FVkwQwNbG4/kiy0RD9WPOyBZlI1LillKYLWZdNqH6cw9gzoldzZKVYWqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZu28WzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8F8C4CEC0;
	Fri, 13 Sep 2024 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726217979;
	bh=ROxwTYSbJpgVJXYiRtwEYeFoFaiRZDcceqBT+kcqYCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZu28WzE5wmx7B6QxEWVNkfgIyz2lV31DQHGrQbwM/ug3E4WIT4of46PScMl/SDZJ
	 89Hrp72QhoiRO/Xb4nMpJKX3titAWLwy4lvmCfv5Y28tq4UYxgxCiDO5yMbL3nxrLY
	 odfP8kXWEgt//qIrK1Ei86KMP+nPb76IJ+Z8Gp/tnQUYvt3kwcmTXh0pWjjOZ0Wgic
	 qfcGNTRrr+NQgGqLbk0ve1/b1HBEw74P/iv4TeV2m7AXhjdhaJR9eITKTwe5eE3qhf
	 pHx1Bj8w6Zw/9raQaGWGUUqve9PRR9CqsDZpqaeM41OY1C2TYXPxhEVY0srE+gFAia
	 qqn6eH2SLT5mg==
Date: Fri, 13 Sep 2024 17:59:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>, Jiri
 Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240913175935.bb0892ab1e6052efc12c6423@kernel.org>
In-Reply-To: <CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
	<CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
	<20240913085402.9e5b2c506a8973b099679d04@kernel.org>
	<CAEf4BzZEoNHgcLDPTPQ=yyQTZtEZoVrGbBbeTf3vqe_wcpS6EA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 12 Sep 2024 18:55:40 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Sep 12, 2024 at 4:54 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 12 Sep 2024 11:41:17 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > + BPF ML
> > >
> > > On Thu, Sep 12, 2024 at 8:35 AM <bot+bpf-ci@kernel.org> wrote:
> > > >
> > > > Dear patch submitter,
> > > >
> > > > CI has tested the following submission:
> > > > Status:     FAILURE
> > > > Name:       [v14,00/19] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
> > > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=889822&state=*
> > > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10833792984
> > > >
> > > > Failed jobs:
> > > > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061791397
> > > > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061791836
> > > > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061757062
> > > > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10833792984/job/30061757809
> > > >
> > > > First test_progs failure (test_progs-aarch64-gcc):
> > > > #132 kprobe_multi_testmod_test
> > > > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > > > #132/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > > #132/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > >
> > >
> > > Seems like this selftest is still broken. Please let me know if you
> > > need help with building and running BPF selftests to reproduce this
> > > locally.
> >
> > Thanks, It will be helpful. Also I would like to know, is there any
> > debug mode (like print more debug logs)?
> 
> So first of all, the assumption is that you will build a most recent
> kernel with Kconfig values set from
> tools/testing/selftests/bpf/config, so make sure you  append that to
> your kernel config. Then build the kernel, BPF selftests' Makefile
> tries to find latest built kernel (according to KBUILD_OUTPUT/O/etc).
> 
> Now to building BPF selftests:
> 
> $ cd tools/testing/selftests/bpf
> $ make -j$(nproc)
> 
> You'll need decently recent Clang and a few dependent packages. At
> least elfutils-devel, libzstd-devel, but there might be a few more
> which I never can remember.
> 
> Once everything is built, you can run the failing test with
> 
> $ sudo ./test_progs -t kprobe_multi_testmod_test -v
> 
> The source code for user space part for that test is in
> prog_tests/kprobe_multi_testmod_test.c and BPF-side is in
> progs/kprobe_multi.c.

Thanks for the information!

> 
> Taking failing output from the test:
> 
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> 
> kretprobe_test3_result is a sort of identifier for a test condition,
> you can find a corresponding line in user space .c file grepping for
> that:
> 
> ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1,
> "kretprobe_test3_result");
> 
> Most probably the problem is in:
> 
> __u64 addr = bpf_get_func_ip(ctx);

Yeah, and as I replyed to another thread, the problem is
that the ftrace entry_ip is not symbol ip.

We have ftrace_call_adjust() arch function for reverse
direction (symbol ip to ftrace entry ip) but what we need
here is the reverse translate function (ftrace entry to symbol)

The easiest way is to use kallsyms to find it, but this is
a bit costful (but it just increase bsearch in several levels).
Other possible options are

 - Change bpf_kprobe_multi_addrs_cmp() to accept a range
   of address. [sym_addr, sym_addr + offset) returns true,
   bpf_kprobe_multi_cookie() can find the entry address.
   The offset depends on arch, but 16 is enough.

 - Change bpf_kprobe_multi_addrs_cmp() to call
   ftrace_call_adjust() before comparing. This may take a
   cost but find actual entry address.

 - (Cached method) when making link->addrs, make a link->adj_addrs
   array too, where adj_addrs[i] == ftrace_call_adjust(addrs[i]).

Let me try the 3rd one. It may consume more memory but the
fastest solution.

Thank you,

> 
> which is then checked as
> 
> if ((const void *) addr == &bpf_testmod_fentry_test3)
> 
> 
> With your patches this doesn't match anymore.

It actually enables the fprobe on those architectures, so
without my series, those test should be skipped.

Thank you,

> 
> 
> Hopefully the above gives you some pointers, let me know if you run
> into any problems.
> 
> >
> > Thank you,
> >
> > >
> > > >
> > > > Please note: this email is coming from an unmonitored mailbox. If you have
> > > > questions or feedback, please reach out to the Meta Kernel CI team at
> > > > kernel-ci@meta.com.
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

