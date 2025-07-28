Return-Path: <bpf+bounces-64569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE24B1450B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C7A1AA0B44
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBA233735;
	Mon, 28 Jul 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMbltTOx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC0D27E;
	Mon, 28 Jul 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746806; cv=none; b=hvXIdjDes3x43sQIfVzNXZ7Vb/l7yNetOzjCEPc6ZNtU7jJOvLFXosjINK8eGdO9ZMgFd8s3z3bOm0Q8obrLvKcqEOjM8ea1ctlssWE21hIHiNP6vqMAEiX3LJsHxfbE7ObttIlseL1oi3rFcNCTFCkjzSg3YiEbvSYPH+xnRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746806; c=relaxed/simple;
	bh=0FnPYo5/wk60MCrkVcHV8SfvxdhIefY2gSPs4N0QSxY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m9OK7nzT+V032pW7MWgtede66hokCjTit5AIIyC21ad/Q90icqx1fpa4lOREPSWZfVXBD+iMBwo25thIOtl0JRH+YeLCwhSNrVPjyAqqsvWdqohMx1j3sv6XXYkSCHziG9OJRnh8Qfirr9vhdFMzqxp1KlZEvL5lG8LY6C36Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMbltTOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA69C4CEE7;
	Mon, 28 Jul 2025 23:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746806;
	bh=0FnPYo5/wk60MCrkVcHV8SfvxdhIefY2gSPs4N0QSxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RMbltTOxR411c2mwbHxAJfesEU3iiRJQm9vJmGev+vfOxRoNyABPYs448LdwNzl9U
	 HVYnBsNpO5ltJoT1Zk60A/AmjHjVMo+v8fxUTj1Wxlke5u7iDMdhFjZ2BlQl3D91W+
	 kzEX9R8ecyZXucMRg28msriC9ghEB5LsB1aSY4lKfKRCtwhl4Dro1WjEN499I2tt4Q
	 S91Z1JCn7evEGsXjVSMVzFXRXGq9GqmxoBUF1mglO8OdnlImuAFpwXrCqGqFRS1wJq
	 kvqB8mMpDBup2X8Ats69PTXs9qYuyp2NMQZvSl/gzADujXAbGEzYhJ6jaBhxvPQAsa
	 clTRbFka7NRnQ==
Date: Tue, 29 Jul 2025 08:53:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/4] fprobe: use rhashtable for
 fprobe_ip_table
Message-Id: <20250729085323.b2685e50c394eabd2f0d43e5@kernel.org>
In-Reply-To: <CADxym3b=-tGOVqnoPeDb0q3EZZ-DMjkM0fiaSS6=Q+y07azYMg@mail.gmail.com>
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
	<20250728213502.df49c01629de5fe9b6f15632@kernel.org>
	<CADxym3b=-tGOVqnoPeDb0q3EZZ-DMjkM0fiaSS6=Q+y07azYMg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 22:26:27 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> On Mon, Jul 28, 2025 at 8:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Menglong,
> >
> > What are the updates from v1? Just adding RFC?
> 
> No, the V1 uses rhashtable, which is wrong, and makes the
> function address unique in the hash table.
> 
> And in the V2, I use rhltable instead, which supports duplicate
> keys.

Ah, thanks for the explanation!

> 
> Sorry that I forgot to add the changelog :/

Yeah, the changelog helps us to review the differences.

Thanks,

> 
> >
> > Thanks,
> >
> > On Mon, 28 Jul 2025 15:22:49 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > > For now, the budget of the hash table that is used for fprobe_ip_table is
> > > fixed, which is 256, and can cause huge overhead when the hooked functions
> > > is a huge quantity.
> > >
> > > In this series, we use rhltable for fprobe_ip_table to reduce the
> > > overhead.
> > >
> > > Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> > > will hook all the kernel functions during the testing. Before this series,
> > > the performance is:
> > >   usermode-count :  875.380 ± 0.366M/s
> > >   kernel-count   :  435.924 ± 0.461M/s
> > >   syscall-count  :   31.004 ± 0.017M/s
> > >   fentry         :  134.076 ± 1.752M/s
> > >   fexit          :   68.319 ± 0.055M/s
> > >   fmodret        :   71.530 ± 0.032M/s
> > >   rawtp          :  202.751 ± 0.138M/s
> > >   tp             :   79.562 ± 0.084M/s
> > >   kprobe         :   55.587 ± 0.028M/s
> > >   kprobe-multi   :   56.481 ± 0.043M/s
> > >   kprobe-multi-all:    6.283 ± 0.005M/s << look this
> > >   kretprobe      :   22.378 ± 0.028M/s
> > >   kretprobe-multi:   28.205 ± 0.025M/s
> > >
> > > With this series, the performance is:
> > >   usermode-count :  902.387 ± 0.762M/s
> > >   kernel-count   :  427.356 ± 0.368M/s
> > >   syscall-count  :   30.830 ± 0.016M/s
> > >   fentry         :  135.554 ± 0.064M/s
> > >   fexit          :   68.317 ± 0.218M/s
> > >   fmodret        :   70.633 ± 0.275M/s
> > >   rawtp          :  193.404 ± 0.346M/s
> > >   tp             :   80.236 ± 0.068M/s
> > >   kprobe         :   55.200 ± 0.359M/s
> > >   kprobe-multi   :   54.304 ± 0.092M/s
> > >   kprobe-multi-all:   54.487 ± 0.035M/s << look this
> > >   kretprobe      :   22.381 ± 0.075M/s
> > >   kretprobe-multi:   27.926 ± 0.034M/s
> > >
> > > The benchmark of "kprobe-multi-all" increase from 6.283M/s to 54.487M/s.
> > >
> > > The locking is not handled properly in the first patch. In the
> > > fprobe_entry, we should use RCU when we access the rhlist_head. However,
> > > we can't use RCU for __fprobe_handler, as it can sleep. In the origin
> > > logic, it seems that the usage of hlist_for_each_entry_from_rcu() is not
> > > protected by rcu_read_lock neither, isn't it? I don't know how to handle
> > > this part ;(
> > >
> > > Menglong Dong (4):
> > >   fprobe: use rhltable for fprobe_ip_table
> > >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> > >   selftests/bpf: skip recursive functions for kprobe_multi
> > >   selftests/bpf: add benchmark testing for kprobe-multi-all
> > >
> > >  include/linux/fprobe.h                        |   2 +-
> > >  kernel/trace/fprobe.c                         | 141 ++++++-----
> > >  tools/testing/selftests/bpf/bench.c           |   2 +
> > >  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
> > >  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
> > >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> > >  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
> > >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> > >  8 files changed, 348 insertions(+), 282 deletions(-)
> > >
> > > --
> > > 2.50.1
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

