Return-Path: <bpf+bounces-4565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977174CB5D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 06:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8579280F51
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 04:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13E23AF;
	Mon, 10 Jul 2023 04:45:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E923A8;
	Mon, 10 Jul 2023 04:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE33C433C8;
	Mon, 10 Jul 2023 04:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688964327;
	bh=23Pfa5VQdzJCFB47DoTz0zuX9vR9F1OcJztYrLTuvkg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eLIlAPzdG0BYcspLLiI0DvQjTsF0yUIfXUx/MhiuWYS/gAnOM0df/yD6e1wmz5m15
	 7lAPpGfoDV5bMoQ99B65bzn8rUl9X7g0S//acODTz4KD8o4Mrv3fMslC7G8MYQflMZ
	 piNXRxKWCb21SzAs+vsA+LC1/VQrBbavV7lN3l8PkXMaPog48MkPjdQYjbSjZui0pz
	 dvL//A3ox/tQ87wlPmaoZ08gIaK7hpUfmXqi7s3Zl9GWbzWwSr9EYAp8ZuOFfHzEX6
	 NTv0hZ+Cd39qMPwS3gp6sq0lKXvoU0SjFOWdgoQQt3CoDMYVF27MF9ozb2fjPdgWMG
	 wQR63u1LgzKGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5190CE00A4; Sun,  9 Jul 2023 21:45:25 -0700 (PDT)
Date: Sun, 9 Jul 2023 21:45:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
Message-ID: <05074f73-9d84-41e8-8368-51311a794636@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com>
 <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com>
 <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
 <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
 <224322d6-28d3-f3b7-fcac-463e5329a082@huaweicloud.com>
 <CAADnVQL5O5uzy=sewNJ=NFSGV7JTb3ONHR=V2kWiT1YdN=ax8g@mail.gmail.com>
 <3f72c4e7-340f-4374-9ebe-f9bffd08c755@paulmck-laptop>
 <bdfc76dc-459a-7c23-bb23-854742fbd0c3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdfc76dc-459a-7c23-bb23-854742fbd0c3@huaweicloud.com>

On Sat, Jul 08, 2023 at 03:03:40PM +0800, Hou Tao wrote:
> Hi,
> 
> On 7/8/2023 1:47 AM, Paul E. McKenney wrote:
> > On Fri, Jul 07, 2023 at 09:11:22AM -0700, Alexei Starovoitov wrote:
> >> On Thu, Jul 6, 2023 at 9:37 PM Hou Tao <houtao@huaweicloud.com> wrote:
> SNIP
> >>> I guess you're assuming that alloc_bulk() from irq_work
> >>> is running within rcu_tasks_trace critical section,
> >>> so __free_rcu_tasks_trace() callback will execute after
> >>> irq work completed?
> >>> I don't think that's the case.
> >>> Yes. The following is my original thoughts. Correct me if I was wrong:
> >>>
> >>> 1. llist_del_first() must be running concurrently with llist_del_all().
> >>> If llist_del_first() runs after llist_del_all(), it will return NULL
> >>> directly.
> >>> 2. call_rcu_tasks_trace() must happen after llist_del_all(), else the
> >>> elements in free_by_rcu_ttrace will not be freed back to slab.
> >>> 3. call_rcu_tasks_trace() will wait for one tasks trace RCU grace period
> >>> to call __free_rcu_tasks_trace()
> >>> 4. llist_del_first() in running in an context with irq-disabled, so the
> >>> tasks trace RCU grace period will wait for the end of llist_del_first()
> >>>
> >>> It seems you thought step 4) is not true, right ?
> >> Yes. I think so. For two reasons:
> >>
> >> 1.
> >> I believe irq disabled region isn't considered equivalent
> >> to rcu_read_lock_trace() region.
> >>
> >> Paul,
> >> could you clarify ?
> > You are correct, Alexei.  Unlike vanilla RCU, RCU Tasks Trace does not
> > count irq-disabled regions of code as readers.
> 
> I see. But I still have one question: considering that in current
> implementation one Tasks Trace RCU grace period implies one vanilla RCU
> grace period (aka rcu_trace_implies_rcu_gp), so in my naive
> understanding of RCU, does that mean __free_rcu_tasks_trace() will be
> invoked after the expiration of current Task Trace RCU grace period,
> right ? And does it also mean __free_rcu_tasks_trace() will be invoked
> after the expiration of current vanilla RCU grace period, right ? If
> these two conditions above are true, does it mean
> __free_rcu_tasks_trace() will wait for the irq-disabled code reigion ?

First, good show digging into the code!

However, this is guaranteed only if rcu_trace_implies_rcu_gp(), which
right now happens to return the constant true.  In other words, that is
an accident of the current implementation.  To rely on this, you must
check the return value of rcu_trace_implies_rcu_gp() and then have some
alternative code that does not rely on that synchronize_rcu().

> > But why not just put an rcu_read_lock_trace() and a matching
> > rcu_read_unlock_trace() within that irq-disabled region of code?
> >
> > For completeness, if it were not for CONFIG_TASKS_TRACE_RCU_READ_MB,
> > Hou Tao would be correct from a strict current-implementation
> > viewpoint.  The reason is that, given the current implementation in
> > CONFIG_TASKS_TRACE_RCU_READ_MB=n kernels, a task must either block or
> > take an IPI in order for the grace-period machinery to realize that this
> > task is done with all prior readers.
> 
> Thanks for the detailed explanation.
> 
> > However, we need to account for the possibility of IPI-free
> > implementations, for example, if the real-time guys decide to start
> > making heavy use of BPF sleepable programs.  They would then insist on
> > getting rid of those IPIs for CONFIG_PREEMPT_RT=y kernels.  At which
> > point, irq-disabled regions of code will absolutely not act as
> > RCU tasks trace readers.
> >
> > Again, why not just put an rcu_read_lock_trace() and a matching
> > rcu_read_unlock_trace() within that irq-disabled region of code?
> >
> > Or maybe there is a better workaround.
> 
> Yes. I think we could use rcu_read_{lock,unlock}_trace to fix the ABA
> problem for free_by_rcu_ttrace.

That sounds good to me!

							Thanx, Paul

> >> 2.
> >> Even if 1 is incorrect, in RT llist_del_first() from alloc_bulk()
> >> runs "in a per-CPU thread in preemptible context."
> >> See irq_work_run_list.
> > Agreed, under RT, "interrupt handlers" often run in task context.
> 
> Yes, I missed that. I misread alloc_bulk(), and it seems it only does
> inc_active() for c->free_llist.
> > 						Thanx, Paul
> 

