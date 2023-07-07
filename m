Return-Path: <bpf+bounces-4467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA074B5FD
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87263281885
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D384171B1;
	Fri,  7 Jul 2023 17:47:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE5385;
	Fri,  7 Jul 2023 17:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33104C433C7;
	Fri,  7 Jul 2023 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688752032;
	bh=j8cv3Ab8aJLX683Gk1TI9inc0kDj9B4IeiHO/tV4PIo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OrDIl0yR1Ax2P/S1LyP7bIgJ44cpzygMsToHDkEor0JQ2fGgdEM0tVuedYXNtR4fn
	 UfrI8mY6ZPEZHBuhCyZvcPHeOpy/vDrbmh0ZHqnGSdHvsgoOrc6vyqnP660KKg2o1n
	 61VBat5wdDIsYVbi1SZxpPBlIOmMMpoAsmNexkacvwljBWlkDP181WRVaQ8vMqqShD
	 Fy0FxA/ghHgxeUGw+aboRdIRZnoBDXCh/fZl7dCGEAiDKNIIjT9eA1x4LMAwfGFqn7
	 xejbr83FlQSPOGY9OuO4INBoY6Ug8hb4ddoRJ6eOO92bFbMK+qeSkAaxkiLeMqf0an
	 SkHHu/6ibZeaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C15A5CE0073; Fri,  7 Jul 2023 10:47:11 -0700 (PDT)
Date: Fri, 7 Jul 2023 10:47:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
Message-ID: <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com>
 <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
 <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
 <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
 <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
 <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>

On Fri, Jul 07, 2023 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 9:37 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > On 7/7/2023 12:16 PM, Alexei Starovoitov wrote:
> > > On Thu, Jul 6, 2023 at 8:39 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >> Hi,
> > >>
> > >> On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
> > >>> On Thu, Jul 6, 2023 at 7:07 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >>>> Hi,
> > >>>>
> > >>>> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> > >>>>
> > SNIP
> > >>> and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is similar.
> > >> I think free_by_rcu_ttrace is different, because the reuse is only
> > >> possible after one tasks trace RCU grace period as shown below, and the
> > >> concurrent llist_del_first() must have been completed when the head is
> > >> reused and re-added into free_by_rcu_ttrace again.
> > >>
> > >> // c0->free_by_rcu_ttrace
> > >> A -> B -> C -> nil
> > >>
> > >> P1:
> > >> alloc_bulk()
> > >>     llist_del_first(&c->free_by_rcu_ttrace)
> > >>         entry = A
> > >>         next = B
> > >>
> > >> P2:
> > >> do_call_rcu_ttrace()
> > >>     // c->free_by_rcu_ttrace->first = NULL
> > >>     llist_del_all(&c->free_by_rcu_ttrace)
> > >>         move to c->waiting_for_gp_ttrace
> > >>
> > >> P1:
> > >> llist_del_first()
> > >>     return NULL
> > >>
> > >> // A is only reusable after one task trace RCU grace
> > >> // llist_del_first() must have been completed
> > > "must have been completed" ?
> > >
> > > I guess you're assuming that alloc_bulk() from irq_work
> > > is running within rcu_tasks_trace critical section,
> > > so __free_rcu_tasks_trace() callback will execute after
> > > irq work completed?
> > > I don't think that's the case.
> >
> > Yes. The following is my original thoughts. Correct me if I was wrong:
> >
> > 1. llist_del_first() must be running concurrently with llist_del_all().
> > If llist_del_first() runs after llist_del_all(), it will return NULL
> > directly.
> > 2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
> > elements in free_by_rcu_ttrace will not be freed back to slab.
> > 3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace period
> > to call __free_rcu_tasks_trace()
> > 4. llist_del_first() in running in an context with irq-disabled, so the
> > tasks trace RCU grace period will wait for the end of llist_del_first()
> >
> > It seems you thought step 4) is not true, right ?
> 
> Yes. I think so. For two reasons:
> 
> 1.
> I believe irq disabled region isn't considered equivalent
> to rcu_read_lock_trace() region.
> 
> Paul,
> could you clarify ?

You are correct, Alexei.  Unlike vanilla RCU, RCU Tasks Trace does not
count irq-disabled regions of code as readers.

But why not just put an rcu_read_lock_trace() and a matching
rcu_read_unlock_trace() within that irq-disabled region of code?

For completeness, if it were not for CONFIG_TASKS_TRACE_RCU_READ_MB,
Hou Tao would be correct from a strict current-implementation
viewpoint.  The reason is that, given the current implementation in
CONFIG_TASKS_TRACE_RCU_READ_MB=n kernels, a task must either block or
take an IPI in order for the grace-period machinery to realize that this
task is done with all prior readers.

However, we need to account for the possibility of IPI-free
implementations, for example, if the real-time guys decide to start
making heavy use of BPF sleepable programs.  They would then insist on
getting rid of those IPIs for CONFIG_PREEMPT_RT=y kernels.  At which
point, irq-disabled regions of code will absolutely not act as
RCU tasks trace readers.

Again, why not just put an rcu_read_lock_trace() and a matching
rcu_read_unlock_trace() within that irq-disabled region of code?

Or maybe there is a better workaround.

> 2.
> Even if 1 is incorrect, in RT llist_del_first() from alloc_bulk()
> runs "in a per-CPU thread in preemptible context."
> See irq_work_run_list.

Agreed, under RT, "interrupt handlers" often run in task context.

						Thanx, Paul

