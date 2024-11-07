Return-Path: <bpf+bounces-44252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058C9C0B1C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241061C2352A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890E216DED;
	Thu,  7 Nov 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIorGii7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911C216E11;
	Thu,  7 Nov 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996024; cv=none; b=mT4lGw0EMpxeLfoBnfCqb30lDqEH8ts8QkwEmTz4fA9uJw2AnLuhxbUrYVXLYtr7BmqyWNjdt/0ROE2LaJXPFdJ29+zHUl8Jw8jEDVUM0FE7eKIfx+4GM9ev9bKvsN6UjV6QRIm9UZGs0ZGU+d97EyRm/CWvNaxUn/k/yirZOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996024; c=relaxed/simple;
	bh=FHR30uhF6DB2gIDAdsPiv6Yh2i+bB/ZarNlpamdV/8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7LdgnaPYmYrzIyKMHKg4MGSB2J2kFuPFcOySsUeJgdrlb8S7M4V/pZWvgKkg+AwFtOV6jup6A5eqXFN4+UotgxqYTpUbqtVc6ZEDMWKrRn/SAKgwr7a9fBqqGbW9Ec+JqF+4+H/A0pgWA4Db1CrXQY3caj3SWEu8XuYo+0m18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIorGii7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCF1C4CECD;
	Thu,  7 Nov 2024 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730996024;
	bh=FHR30uhF6DB2gIDAdsPiv6Yh2i+bB/ZarNlpamdV/8U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iIorGii7VPFbRUVtUE5c5O3wF/9CYPC2R7Zhv6L1KDgv4fIqUVa1A5w0d26/HbeIE
	 Jf2O7i1mnX/JVQMR/wCvmYNwyOBatttLt+0/SGL9jC3kGD8Lbt1SMdTKGp6eLnlJ1m
	 AlLCJmTn4dPOwWfrSEYiT/dW1g6ANs/hpD6mpFsZaZvA2j2J3dZVnSjGE9WPCXP/w1
	 +iVUs74Zo0hFGkFW3hm0yF+t3y3Kct7iNpYh9EldCWFI17sXeVFxDLxQ+kAlWBNQUw
	 tMZ33tmI101nEF3e0lgTP9FIyUZL14kwM6hXujkI7qvO3yXSbxedwPp+/Vk+dhNMjw
	 DghCR1xtvWLbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C32DCCE04CE; Thu,  7 Nov 2024 08:13:43 -0800 (PST)
Date: Thu, 7 Nov 2024 08:13:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <4d034c81-34cd-480b-bab9-6645204fc713@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240903174603.3554182-1-andrii@kernel.org>
 <20240903174603.3554182-5-andrii@kernel.org>
 <20241106-transparent-athletic-ammonite-586af8@leitao>
 <CAEf4Bza3+WYN8dstn1v99yeh+G0cjAeRQy8d5GAbvvecLmbO0A@mail.gmail.com>
 <20241107-uncovered-swinging-bull-1e812e@leitao>
 <CAEf4BzanXs4yAexVXdAp-Q-0anmOVCYx+GObvaHPVDnXobkdSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzanXs4yAexVXdAp-Q-0anmOVCYx+GObvaHPVDnXobkdSA@mail.gmail.com>

oN tHU, nov 07, 2024 at 08:01:05AM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 7, 2024 at 3:35 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Andrii,
> >
> > On Wed, Nov 06, 2024 at 08:25:25AM -0800, Andrii Nakryiko wrote:
> > > On Wed, Nov 6, 2024 at 4:03 AM Breno Leitao <leitao@debian.org> wrote:
> > > > On Tue, Sep 03, 2024 at 10:45:59AM -0700, Andrii Nakryiko wrote:
> > > > > uprobe->register_rwsem is one of a few big bottlenecks to scalability of
> > > > > uprobes, so we need to get rid of it to improve uprobe performance and
> > > > > multi-CPU scalability.
> > > > >
> > > > > First, we turn uprobe's consumer list to a typical doubly-linked list
> > > > > and utilize existing RCU-aware helpers for traversing such lists, as
> > > > > well as adding and removing elements from it.
> > > > >
> > > > > For entry uprobes we already have SRCU protection active since before
> > > > > uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> > > > > won't go away from under us, but we add SRCU protection around consumer
> > > > > list traversal.
> > > >
> > > > I am seeing the following message in a kernel with RCU_PROVE_LOCKING:
> > > >
> > > >         kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> > > >
> > > > It seems the SRCU is not held, when coming from mmap_region ->
> > > > uprobe_mmap. Here is the message I got in my debug kernel. (sorry for
> > > > not decoding it, but, the stack trace is clear enough).
> > > >
> > > >          WARNING: suspicious RCU usage
> > > >            6.12.0-rc5-kbuilder-01152-gc688a96c432e #26 Tainted: G        W   E    N
> > > >            -----------------------------
> > > >            kernel/events/uprobes.c:938 RCU-list traversed without holding the required lock!!
> > > >
> > > > other info that might help us debug this:
> > > >
> > > > rcu_scheduler_active = 2, debug_locks = 1
> > > >            3 locks held by env/441330:
> > > >             #0: ffff00021c1bc508 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x84/0x1d0
> > > >             #1: ffff800089f3ab48 (&uprobes_mmap_mutex[i]){+.+.}-{3:3}, at: uprobe_mmap+0x20c/0x548
> > > >             #2: ffff0004e564c528 (&uprobe->consumer_rwsem){++++}-{3:3}, at: filter_chain+0x30/0xe8
> > > >
> > > > stack backtrace:
> > > >            CPU: 4 UID: 34133 PID: 441330 Comm: env Kdump: loaded Tainted: G        W   E    N 6.12.0-rc5-kbuilder-01152-gc688a96c432e #26
> > > >            Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
> > > >            Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22 07/03/2024
> > > >            Call trace:
> > > >             dump_backtrace+0x10c/0x198
> > > >             show_stack+0x24/0x38
> > > >             __dump_stack+0x28/0x38
> > > >             dump_stack_lvl+0x74/0xa8
> > > >             dump_stack+0x18/0x28
> > > >             lockdep_rcu_suspicious+0x178/0x2c8
> > > >             filter_chain+0xdc/0xe8
> > > >             uprobe_mmap+0x2e0/0x548
> > > >             mmap_region+0x510/0x988
> > > >             do_mmap+0x444/0x528
> > > >             vm_mmap_pgoff+0xf8/0x1d0
> > > >             ksys_mmap_pgoff+0x184/0x2d8
> > > >
> > > >
> > > > That said, it seems we want to hold the SRCU, before reaching the
> > > > filter_chain(). I hacked a bit, and adding the lock in uprobe_mmap()
> > > > solves the problem, but, I might be missing something, since I am not familiar
> > > > with this code.
> > > >
> > > > How does the following patch look like?
> > > >
> > > > commit 1bd7bcf03031ceca86fdddd8be2e5500497db29f
> > > > Author: Breno Leitao <leitao@debian.org>
> > > > Date:   Mon Nov 4 06:53:31 2024 -0800
> > > >
> > > >     uprobes: Get SRCU lock before traverseing the list
> > > >
> > > >     list_for_each_entry_srcu() is being called without holding the lock,
> > > >     which causes LOCKDEP (when enabled with RCU_PROVING) to complain such
> > > >     as:
> > > >
> > > >             kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> > > >
> > > >     Get the SRCU uprobes_srcu lock before calling filter_chain(), which
> > > >     needs to have the SRCU lock hold, since it is going to call
> > > >     list_for_each_entry_srcu().
> > > >
> > > >     Signed-off-by: Breno Leitao <leitao@debian.org>
> > > >     Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> > > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 4b52cb2ae6d62..cc9d4ddeea9a6 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -1391,6 +1391,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> > > >         struct list_head tmp_list;
> > > >         struct uprobe *uprobe, *u;
> > > >         struct inode *inode;
> > > > +       int srcu_idx;
> > > >
> > > >         if (no_uprobe_events())
> > > >                 return 0;
> > > > @@ -1409,6 +1410,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
> > > >
> > > >         mutex_lock(uprobes_mmap_hash(inode));
> > > >         build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_list);
> > > > +       srcu_idx = srcu_read_lock(&uprobes_srcu);
> > >
> > > Thanks for catching that (production testing FTW, right?!).
> >
> > Correct. I am running some hosts with RCU_PROVING and I am finding some
> > cases where RCU protected areas are touched without holding the RCU read
> > lock.
> >
> > > But I think you a) adding wrong RCU protection flavor (it has to be
> > > rcu_read_lock_trace()/rcu_read_unlock_trace(), see uprobe_apply() for
> > > an example) and b) I think this is the wrong place to add it. We
> > > should add it inside filter_chain(). filter_chain() is called from
> > > three places, only one of which is already RCU protected (that's the
> > > handler_chain() case). But there is also register_for_each_vma(),
> > > which needs RCU protection as well.
> >
> > Thanks for the guidance!
> >
> > My initial plan was to protect filter_chain(), but, handler_chain()
> > already has the lock. Is it OK to get into a critical section in a
> > nested form?
> >
> > The code will be something like:
> >
> > handle_swbp() {
> >         rcu_read_lock_trace();
> >         handler_chain() {
> >                 filter_chain() {
> >                         rcu_read_lock_trace();
> >                         list_for_each_entry_rcu()
> >                         rcu_read_lock_trace();
> >                 }
> >         }
> >         rcu_read_lock_trace();
> > }
> >
> > Is this nested locking fine?
> 
> Yes, it's totally fine to nest RCU lock regions.

As long as you don't nest them more than 255 deep in CONFIG_PREEMPT=n
kernels that also have CONFIG_PREEMPT_COUNT=y, or more than 2G deep in
CONFIG_PREEMPT=y kernels.  For a limited time only, in CONFIG_PREEMPT=n
kernels that also have CONFIG_PREEMPT_COUNT=n, you can nest as deeply
as you want.  ;-)

Sorry, couldn't resist...

							Thanx, Paul

