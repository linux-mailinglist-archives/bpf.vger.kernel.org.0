Return-Path: <bpf+bounces-26459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6C8A03F1
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 01:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9491C21A2F
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473DD36B08;
	Wed, 10 Apr 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHNuHzs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C08138E;
	Wed, 10 Apr 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791322; cv=none; b=tJQi0mhYzkEBDXgOsy4lqkzXtekv+AK/eEJP+xfIGJILZzzDKwr3rIZdRZ0nQdi/trM7g8I95DH3Xh6KtgcDFmhE3KynS6dfFGQwYoRbWoO2LVMD6GVumE+bsU/Vi+aatiRACJky36MG8y2hOS0LBZg4mhQZmEPZxt+JgtqomqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791322; c=relaxed/simple;
	bh=vZjbMD6Jt287ODnsZPSuTjU7DsqVXUkB99DDCx9Tfrg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m9j8l9V2H1zGgCHQC3R5o0Pdt/CyBhvgDC5z8frKKoHBuWGfBVNCGRxZbDhb7p/4DBcXGq4xgDFSmYOZUqU8fE8mHsRQa7o2efOsJEHOOkd79F4ZhQzogbD9MrIr+4IFzg8dXAruzzXy7hCNQJZzd5WJWilZWPQ6peGiGXKAt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHNuHzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB274C433C7;
	Wed, 10 Apr 2024 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712791322;
	bh=vZjbMD6Jt287ODnsZPSuTjU7DsqVXUkB99DDCx9Tfrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbHNuHzs8+ZKHxrg1xfuZ5COlcBxcxARniCXIPFp6Q4EZRxWJuwxe9/7ndRzpfblU
	 To42eYEt+GeoNiMWxDCUG7+7IKGRTYk+KPpxTSDTanV9dZ0N1fehrb7jHTLgxn7Fry
	 rhZSwIwRf2EqBZ0LBdrzZaOKWIS5c9mxP7dLyQCNvo+gtwBNNrmHoM/bGtbsbONN7n
	 UH8XMmDxO3wdqFs4YP2GnX0h1ieR4Ne6gJKOaT24773nEla4CACSNBiHHuT7WzPns2
	 MuOK6ItgEaIURhf7Mw9Tr+uvqbQ93qeKykTkk4VaVovQsjR2AovHWtAmmsdhkIw5XZ
	 gnUKnqD0kHeUQ==
Date: Thu, 11 Apr 2024 08:21:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jonthan Haslam <jonathan.haslam@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 linux-trace-kernel@vger.kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
 rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
Message-Id: <20240411082156.6613cf4dc03129ea1183ab88@kernel.org>
In-Reply-To: <lcc6lnkbfnyr6yjvybckevhzaafvh7jmpse6tnviq5bjar3y6z@yvz6cuzjzrky>
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
	<20240325120323.ec3248d330b2755e73a6571e@kernel.org>
	<CAEf4BzZS_QCsSY0oGY_3pGveGfXKK_TkVURyNq=UQXVXSqi2Fw@mail.gmail.com>
	<20240327084245.a890ae12e579f0be1902ae4a@kernel.org>
	<54jakntmdyedadce7yrf6kljcjapbwyoqqt26dnllrqvs3pg7x@itra4a2ikgqw>
	<20240328091841.ce9cc613db375536de843cfb@kernel.org>
	<CAEf4BzYCJWXAzdV3q5ex+8hj5ZFCnu5CT=w8eDbZCGqm+CGYOQ@mail.gmail.com>
	<CAEf4BzbSvMa2+hdTifMKTsNiOL6X=P7eor4LpPKfHM=Y9-71fw@mail.gmail.com>
	<20240330093631.72273967ba818cb16aeb58b6@kernel.org>
	<lcc6lnkbfnyr6yjvybckevhzaafvh7jmpse6tnviq5bjar3y6z@yvz6cuzjzrky>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:38:11 +0100
Jonthan Haslam <jonathan.haslam@gmail.com> wrote:

> Hi Masami,
> 
> > > > Which is why I was asking to land this patch as is, as it relieves the
> > > > scalability pains in production and is easy to backport to old
> > > > kernels. And then we can work on batched APIs and switch to per-CPU rw
> > > > semaphore.
> > 
> > OK, then I'll push this to for-next at this moment.
> > Please share if you have a good idea for the batch interface which can be
> > backported. I guess it should involve updating userspace changes too.
> 
> Did you (or anyone else) need anything more from me on this one so that it
> can be pushed? I provided some benchmark numbers but happy to provide
> anything else that may be required.

Yeah, if you can update with the result, it looks better to me.
Or, can I update the description?

Thank you,

> 
> Thanks!
> 
> Jon.
> 
> > 
> > Thank you!
> > 
> > > >
> > > > So I hope you can reconsider and accept improvements in this patch,
> > > > while Jonathan will keep working on even better final solution.
> > > > Thanks!
> > > >
> > > > > I look forward to your formalized results :)
> > > > >
> > > 
> > > BTW, as part of BPF selftests, we have a multi-attach test for uprobes
> > > and USDTs, reporting attach/detach timings:
> > > $ sudo ./test_progs -v -t uprobe_multi_test/bench
> > > bpf_testmod.ko is already unloaded.
> > > Loading bpf_testmod.ko...
> > > Successfully loaded bpf_testmod.ko.
> > > test_bench_attach_uprobe:PASS:uprobe_multi_bench__open_and_load 0 nsec
> > > test_bench_attach_uprobe:PASS:uprobe_multi_bench__attach 0 nsec
> > > test_bench_attach_uprobe:PASS:uprobes_count 0 nsec
> > > test_bench_attach_uprobe: attached in   0.120s
> > > test_bench_attach_uprobe: detached in   0.092s
> > > #400/5   uprobe_multi_test/bench_uprobe:OK
> > > test_bench_attach_usdt:PASS:uprobe_multi__open 0 nsec
> > > test_bench_attach_usdt:PASS:bpf_program__attach_usdt 0 nsec
> > > test_bench_attach_usdt:PASS:usdt_count 0 nsec
> > > test_bench_attach_usdt: attached in   0.124s
> > > test_bench_attach_usdt: detached in   0.064s
> > > #400/6   uprobe_multi_test/bench_usdt:OK
> > > #400     uprobe_multi_test:OK
> > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > > Successfully unloaded bpf_testmod.ko.
> > > 
> > > So it should be easy for Jonathan to validate his changes with this.
> > > 
> > > > > Thank you,
> > > > >
> > > > > >
> > > > > > Jon.
> > > > > >
> > > > > > >
> > > > > > > Thank you,
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > BTW, how did you measure the overhead? I think spinlock overhead
> > > > > > > > > will depend on how much lock contention happens.
> > > > > > > > >
> > > > > > > > > Thank you,
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [0] https://docs.kernel.org/locking/spinlocks.html
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jonathan Haslam <jonathan.haslam@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  kernel/events/uprobes.c | 22 +++++++++++-----------
> > > > > > > > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > > > > > > > index 929e98c62965..42bf9b6e8bc0 100644
> > > > > > > > > > --- a/kernel/events/uprobes.c
> > > > > > > > > > +++ b/kernel/events/uprobes.c
> > > > > > > > > > @@ -39,7 +39,7 @@ static struct rb_root uprobes_tree = RB_ROOT;
> > > > > > > > > >   */
> > > > > > > > > >  #define no_uprobe_events()   RB_EMPTY_ROOT(&uprobes_tree)
> > > > > > > > > >
> > > > > > > > > > -static DEFINE_SPINLOCK(uprobes_treelock);    /* serialize rbtree access */
> > > > > > > > > > +static DEFINE_RWLOCK(uprobes_treelock);      /* serialize rbtree access */
> > > > > > > > > >
> > > > > > > > > >  #define UPROBES_HASH_SZ      13
> > > > > > > > > >  /* serialize uprobe->pending_list */
> > > > > > > > > > @@ -669,9 +669,9 @@ static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
> > > > > > > > > >  {
> > > > > > > > > >       struct uprobe *uprobe;
> > > > > > > > > >
> > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > >       uprobe = __find_uprobe(inode, offset);
> > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > >
> > > > > > > > > >       return uprobe;
> > > > > > > > > >  }
> > > > > > > > > > @@ -701,9 +701,9 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
> > > > > > > > > >  {
> > > > > > > > > >       struct uprobe *u;
> > > > > > > > > >
> > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > > >       u = __insert_uprobe(uprobe);
> > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > > >
> > > > > > > > > >       return u;
> > > > > > > > > >  }
> > > > > > > > > > @@ -935,9 +935,9 @@ static void delete_uprobe(struct uprobe *uprobe)
> > > > > > > > > >       if (WARN_ON(!uprobe_is_active(uprobe)))
> > > > > > > > > >               return;
> > > > > > > > > >
> > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > +     write_lock(&uprobes_treelock);
> > > > > > > > > >       rb_erase(&uprobe->rb_node, &uprobes_tree);
> > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > +     write_unlock(&uprobes_treelock);
> > > > > > > > > >       RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
> > > > > > > > > >       put_uprobe(uprobe);
> > > > > > > > > >  }
> > > > > > > > > > @@ -1298,7 +1298,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > > >
> > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > > >       if (n) {
> > > > > > > > > >               for (t = n; t; t = rb_prev(t)) {
> > > > > > > > > > @@ -1316,7 +1316,7 @@ static void build_probe_list(struct inode *inode,
> > > > > > > > > >                       get_uprobe(u);
> > > > > > > > > >               }
> > > > > > > > > >       }
> > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  /* @vma contains reference counter, not the probed instruction. */
> > > > > > > > > > @@ -1407,9 +1407,9 @@ vma_has_uprobes(struct vm_area_struct *vma, unsigned long start, unsigned long e
> > > > > > > > > >       min = vaddr_to_offset(vma, start);
> > > > > > > > > >       max = min + (end - start) - 1;
> > > > > > > > > >
> > > > > > > > > > -     spin_lock(&uprobes_treelock);
> > > > > > > > > > +     read_lock(&uprobes_treelock);
> > > > > > > > > >       n = find_node_in_range(inode, min, max);
> > > > > > > > > > -     spin_unlock(&uprobes_treelock);
> > > > > > > > > > +     read_unlock(&uprobes_treelock);
> > > > > > > > > >
> > > > > > > > > >       return !!n;
> > > > > > > > > >  }
> > > > > > > > > > --
> > > > > > > > > > 2.43.0
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

