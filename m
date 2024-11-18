Return-Path: <bpf+bounces-45107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9329D183C
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7951E1F2284F
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D591E1023;
	Mon, 18 Nov 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgY+VPmO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971441DFD90;
	Mon, 18 Nov 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954945; cv=none; b=e3+A+y7tjY0Nj9mEMDCAXgvkTLiRVJBzVoHk55d/17MsELQkZgmrZg/90YLQozVpAxyS6qn2+8djKAr6QVlGyykR3rQSzWW/atW2JOW/xO6j4fGL1Yaw8FAHpuaHAEm9Qivr7ih/I+xuhr9O/QvZyNy1QuJbOxwDf/O8UqqRN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954945; c=relaxed/simple;
	bh=J10+qtzOq0u5Tyf00UAPhHE+lr2XkJlRQct4kFIls4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUekMKLVQykyHaod/wb5TW4TdqirjSwrLhgtuEo16Zvt4XtaqLKTx+3cJjqEbu0R94xYdgWzI5dE5CCY48/E6+ROm/ciLSb79xQGROQBkvfaAIGw2hUCRBD7hZtuvCiqwNHuJLw/As3i3HHlH+qzo37pNBCbgQPPwSkDqFBYlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgY+VPmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943C9C4CECC;
	Mon, 18 Nov 2024 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954945;
	bh=J10+qtzOq0u5Tyf00UAPhHE+lr2XkJlRQct4kFIls4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgY+VPmOa8tNjb0F9PWaYywwwXt5OjGKyvLq3p1vNR+RIwqN+MEN963e603ESgfnB
	 p56tvxHPcl2IaF+Vvyi5GS+Kdql5vq7GZk06tU3V80+Sge+ANKS5qaC9fQwYX6cLO2
	 wtvNsLTjrBngMEPs6I1kW32Ati5ReYQBc/DAJpfUeIH6xwoM9dyG8ZZVR12/3ewzEA
	 U/6SKJuJiT7KUK84W1739uHftj4r3dTb8Smp/FkQ9ks3IdaXDwmvEn4fRbMmhbqCXX
	 UQ1zNXb8PJTjUOOq5YD7B2+CK9eMllTPU6z77JgmfxCeKkaLBPNVzDsBvZT7m2pzX1
	 Y651wyUCQn97g==
Date: Mon, 18 Nov 2024 10:35:43 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 0/4] perf lock contention: Symbolize locks using slab
 cache names
Message-ID: <ZzuI_08huDfK0Vvu@google.com>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <CAP-5=fWqE6bM=MVQy7P0tTSWW-ZBXY4in_bfQYFK-C4h6L-Ykw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWqE6bM=MVQy7P0tTSWW-ZBXY4in_bfQYFK-C4h6L-Ykw@mail.gmail.com>

On Mon, Nov 11, 2024 at 11:46:37AM -0800, Ian Rogers wrote:
> On Thu, Nov 7, 2024 at 10:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > This is to support symbolization of dynamic locks using slab
> > allocator's metadata.  The kernel support is in the bpf-next tree now.
> >
> > It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
> > kfunc to get the information from an address.  The feature detection is
> > done using BTF type info and it won't have any effect on old kernels.
> >
> > v2 changes)
> >
> >  * don't use libbpf_get_error()  (Andrii)
> >
> > v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-namhyung@kernel.org
> >
> > With this change, it can show locks in a slab object like below.  I
> > added "&" sign to distinguish them from global locks.
> 
> I know the & is intentional but I worry it could later complicate
> parsing of filters. Perhaps @ is a viable alternative. Other than
> that:
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks for the review!

I don't think it clashes with BPF sample filters which works on sample
data generated from a perf_event.  Technically this command doesn't use
perf_event and just attaches the BPF program to tracepoint directly.

Also sample filters don't use '&' symbol in the syntax as of now. :)

Thanks,
Namhyung

> 
> >     # perf lock con -abl sleep 1
> >      contended   total wait     max wait     avg wait            address   symbol
> >
> >              2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
> >              1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
> >              4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
> >              2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
> >              3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
> >              3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
> >              1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
> >              2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
> >              1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
> >              1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)
> >
> > The first two were from "task_struct" slab cache.  It happened to
> > match with the type name of object but there's no guarantee.  We need
> > to add type info to slab cache to resolve the lock inside the object.
> > Anyway, the third one has no dedicated slab cache and was allocated by
> > kmalloc.
> >
> > Those slab objects can be used to filter specific locks using -L or
> >  --lock-filter option.  (It needs quotes to avoid special handling in
> > the shell).
> >
> >     # perf lock con -ab -L '&task_struct' sleep 1
> >        contended   total wait     max wait     avg wait         type   caller
> >
> >                1     25.10 us     25.10 us     25.10 us        mutex   perf_event_exit_task+0x39
> >                1     21.60 us     21.60 us     21.60 us        mutex   futex_exit_release+0x21
> >                1      5.56 us      5.56 us      5.56 us        mutex   futex_exec_release+0x21
> >
> > The code is available at 'perf/lock-slab-v2' branch in my tree
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (4):
> >   perf lock contention: Add and use LCB_F_TYPE_MASK
> >   perf lock contention: Run BPF slab cache iterator
> >   perf lock contention: Resolve slab object name using BPF
> >   perf lock contention: Handle slab objects in -L/--lock-filter option
> >
> >  tools/perf/builtin-lock.c                     |  39 ++++-
> >  tools/perf/util/bpf_lock_contention.c         | 140 +++++++++++++++++-
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  |  70 ++++++++-
> >  tools/perf/util/bpf_skel/lock_data.h          |  15 +-
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
> >  tools/perf/util/lock-contention.h             |   2 +
> >  6 files changed, 267 insertions(+), 7 deletions(-)
> >
> > --
> > 2.47.0.277.g8800431eea-goog
> >

