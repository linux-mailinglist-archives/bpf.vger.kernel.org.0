Return-Path: <bpf+bounces-9601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0A799813
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745C51C20A7D
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2C63DB;
	Sat,  9 Sep 2023 12:47:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E672919
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 12:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433A0C433C7;
	Sat,  9 Sep 2023 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694263624;
	bh=Typ1fCJOVn8M/gCwCZc/EOk6nMzOtvJcbDelCrrdFbk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=THdPuoa3O7Pt1t9CfP+cgJGJCK6ESEuoePwwLARzWp1DdxK6/L2I7/rwaR9TXnq+N
	 83DTsBwVSilbUkUz/cz5rDi8ILdWdu5ZHtqjV4FuORrS889Ta4VmzFGF+BnErAhIfC
	 6d/eMH0nJLCGvr4SSApnaTUxbxnmnJZJKhIQRXEAO7ryDlHuY608MMHn5emuRr5E3f
	 i/2t+9wCurEPFSHZHzDOs5dawXeoeiugWMUWlW0GrYNJV1G8wGT20xQC1oqOufHs7L
	 U6xaOYrTCb7FIa1CRUHaX5PpmB00dop/aEocOFEN7IYWgizMgtR9jGCEooUHMZ/KV0
	 /NU4+f7lvvUWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6C8ECE0BB0; Sat,  9 Sep 2023 05:47:03 -0700 (PDT)
Date: Sat, 9 Sep 2023 05:47:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Dave Marchevsky <davemarchevsky@meta.com>,
	David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Thaler <dthaler@microsoft.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: BPF memory model
Message-ID: <34f6b4f2-59c0-4748-9842-500ed91a904a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <CABk29Nva+c6oBZra6srWGcfxMEquOP30dReM-PgW_Wh+zKiBuQ@mail.gmail.com>
 <ZPubIZLXFuAsfN7a@slm.duckdns.org>
 <CAADnVQLkHQO_WjkdhmR3XAJOXY=QCGKAe6GFi8Q4YiOf5Dm+iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLkHQO_WjkdhmR3XAJOXY=QCGKAe6GFi8Q4YiOf5Dm+iw@mail.gmail.com>

On Fri, Sep 08, 2023 at 04:16:39PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 8, 2023 at 3:07 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Sep 08, 2023 at 01:26:11PM -0700, Josh Don wrote:
> > > I'm writing BPF programs for scheduling (ie. sched_ext), so these are
> > > getting invoked in hot paths and invoked concurrently across multiple
> > > cpus (for example, pick_next_task, enqueue_task, etc.). The kernel is
> > > responsible for relaying ground truth, userspace makes O(ms)
> > > scheduling decisions, and BPF makes O(us) scheduling decisions.
> > > BPF-BPF concurrency is possible with spinlocks and RMW, BPF-userspace
> > > can currently only really use RMW. My line of questioning is more
> > > forward looking, as I'm preemptively thinking of how to ensure
> > > kernel-like scheduling performance, since BPF spinlock or RMW is
> > > sometimes overkill :) I would think that barrier() and smp_mb() would
> > > probably be the minimum viable set (at least for x86) that people
> > > would find useful, but maybe others can chime in.
> >
> > My personal favorite set is store_release/load_acquire(). I have a hard time
> > thinking up cases which can't be covered by them and they're basically free
> > on x86.
> 
> First of all, Thanks Josh for highlighting this topic and
> gently nudging Paul to continue his work :)

I hereby consider myself nudged.  ;-)

> It's absolutely essential for BPF to have a well defined memory model.
> 
> It's necessary for fast sched-ext bpf progs and for HW offloads too.
> As a minimum we need to document it in Documentation/bpf/standardization/.

Ah, I see that in current mainline.

> It's much more challenging than it looks.
> Unlike traditional ISAs. We cannot say that memory consistency is
> similar to x86 or arm64 or riscv.
> bpf memory consistency cannot pick the lower common denominator either.
> bpf memory model most likely going to be pretty close to kernel memory model
> instead of HW or C.
> In parallel we can start adding new concurrency primitives.

My first thought would be to look at instruction-set.rst in that
directory, and project LKMM onto the concurrency primitives that
are currently defined there.  The advantage of this is "just enough
LKMM" at any given time, but it would also mean that memory-model.rst
(or whatever eventual bikesheded name) would need maintenance as new
concurrency primitives are added.  Which seems like the correct
approach, as opposed to attempting to define memory model concepts
for non-existent concurrency primitives.

Presumably, I also need to run this through the BPF standardization
process.

Or did you have something else in mind?

							Thanx, Paul

> Sounds like smp_load_acquire()/store_release should be the first pair.
> Here it's also more challenging than in the kernel.
> We cannot define bpf_smp_load_acquire() as a macro.
> It needs to be a new flavor of BPF_LDX instruction that JITs
> will convert into a proper sequence of insns.
> On x86-64 it will remain normal load,
> while on arm64 it will be LDAR instead of LDR and so on.
> 
> Some of the barriers we can implement as kfuncs since they're slow anyway.
> Some other barriers would need to be new instructions too.
> The design would need to take into account multiple architectures,
> gcc/llvm consideration, verifier complexity, and,
> of course, include bpf IETF standardization working group.

