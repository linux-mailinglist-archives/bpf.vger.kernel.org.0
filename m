Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B44294AB
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhJKQk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 12:40:57 -0400
Received: from foss.arm.com ([217.140.110.172]:38126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhJKQk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 12:40:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AEC7ED1;
        Mon, 11 Oct 2021 09:38:56 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459C33F66F;
        Mon, 11 Oct 2021 09:38:55 -0700 (PDT)
Date:   Mon, 11 Oct 2021 17:38:52 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <20211011163852.s4pq45rs2j3qhdwl@e107158-lin.cambridge.arm.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
 <YV3v3RkxOB6g/O+8@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV3v3RkxOB6g/O+8@carbon.lan>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roman

On 10/06/21 11:50, Roman Gushchin wrote:
> On Wed, Oct 06, 2021 at 05:39:49PM +0100, Qais Yousef wrote:
> > Hi Roman
> > 
> > On 09/16/21 09:24, Roman Gushchin wrote:
> > > There is a long history of distro people, system administrators, and
> > > application owners tuning the CFS settings in /proc/sys, which are now
> > > in debugfs. Looking at what these settings actually did, it ended up
> > > boiling down to changing the likelihood of task preemption, or
> > > disabling it by setting the wakeup_granularity_ns to more than half of
> > > the latency_ns. The other settings didn't really do much for
> > > performance.
> > > 
> > > In other words, some our workloads benefit by having long running tasks
> > > preempted by tasks handling short running requests, and some workloads
> > > that run only short term requests which benefit from never being preempted.
> > 
> > We had discussion about introducing latency-nice hint; but that discussion
> > didn't end up producing any new API. Your use case seem similar to Android's;
> > we want some tasks to run ASAP. There's an out of tree patch that puts these
> > tasks on an idle CPU (keep in mind energy aware scheduling in the context here)
> > which seem okay for its purpose. Having a more generic solution in mainline
> > would be nice.
> > 
> > https://lwn.net/Articles/820659/
> 
> Hello Qais!
> 
> Thank you for the link, I like it!
> 
> > 
> > > 
> > > This leads to a few observations and ideas:
> > > - Different workloads want different policies. Being able to configure
> > >   the policy per workload could be useful.
> > > - A workload that benefits from not being preempted itself could still
> > >   benefit from preempting (low priority) background system tasks.
> > 
> > You can put these tasks as SCHED_IDLE. There's a potential danger of starving
> > these tasks; but assuming they're background and there's idle time in the
> > system that should be fine.
> > 
> > https://lwn.net/Articles/805317/
> > 
> > That of course assuming you can classify these background tasks..
> > 
> > If you can do the classification, you can also use cpu.shares to reduce how
> > much cpu time they get. Or CFS bandwidth controller
> > 
> > https://lwn.net/Articles/844976/
> 
> The cfs cgroup controller is that it's getting quite expensive quickly with the
> increasing depth of the cgroup tree. This is why we had to disable it for some
> of our primary workloads.

I can understand that..

> 
> Still being able to control latencies on per-cgroup level is one of the goals
> of this patchset.
> 
> > 
> > I like Androd's model of classifying tasks. I think we need this classification
> > done by other non-android systems too.
> > 
> > > - It would be useful to quickly (and safely) experiment with different
> > >   policies in production, without having to shut down applications or reboot
> > >   systems, to determine what the policies for different workloads should be.
> > 
> > Userspace should have the knobs that allows them to tune that without reboot.
> > If you're doing kernel development; then it's part of the job spec I'd say :-)
> 
> The problem here occurs because there is no comprehensive way to test any
> scheduler change rather than run it on many machines (sometimes 1000's) running
> different production-alike workloads.
> 
> If I'm able to test an idea by loading a bpf program (and btw have some sort of
> safety guarantees: maybe the performance will be hurt, but at least no panics),
> it can speed up the development process significantly. The alternative is way
> more complex from the infrastructure's point of view: releasing a custom kernel,
> test it for safety, reboot certain machines to it, pin the kernel from being
> automatically updated etc.

This process is unavoidable IMO. Assuming you have these hooks in; as soon as
you require a new hook you'll be forced to have a custom kernel with that new
hook introduced. Which, in my view, no different than pushing a custom kernel
that forces the function of interest to be noinline. Right?

> 
> > 
> > I think one can still go with the workflow you suggest for development without
> > the hooks. You'd need to un-inline the function you're interested in; then you
> > can use kprobes to hook into it and force an early return. That should produce
> > the same effect, no?
> 
> Basically it's exactly what I'm suggesting. My patchset just provides a
> convenient way to define these hooks and some basic useful helper functions.

Convenient will be only true assuming you have a full comprehensive list of
hooks to never require adding a new one. As I highlighted above, this
convenience is limited to hooks that you added now.

Do people always want more hooks? Rhetorical question ;-)

> 
> > 
> > > - Only a few workloads are large and sensitive enough to merit their own
> > >   policy tweaks. CFS by itself should be good enough for everything else,
> > >   and we probably do not want policy tweaks to be a replacement for anything
> > >   CFS does.
> > > 
> > > This leads to BPF hooks, which have been successfully used in various
> > > kernel subsystems to provide a way for external code to (safely)
> > > change a few kernel decisions. BPF tooling makes this pretty easy to do,
> > > and the people deploying BPF scripts are already quite used to updating them
> > > for new kernel versions.
> > 
> > I am (very) wary of these hooks. Scheduler (in mobile at least) is an area that
> > gets heavily modified by vendors and OEMs. We try very hard to understand the
> > problems they face and get the right set of solutions in mainline. Which would
> > ultimately help towards the goal of having a single Generic kernel Image [1]
> > that gives you what you'd expect out of the platform without any need for
> > additional cherries on top.
> 
> Wouldn't it make your life easier had they provide a set of bpf programs instead
> of custom patches?

Not really.

Having consistent mainline behavior is important, and these customization
contribute to fragmentation and can throw off userspace developers who find
they have to do extra work on some platforms to get the desired outcome. They
will be easy to misuse. We want to see the patches and find ways to improve
mainline kernel instead.

That said, I can see the use case of being able to micro-optimize part of the
scheduler in a workload specific way. But then the way I see this support
happening (DISCLAIMER, personal opinion :-))

	1. The hooks have to be about replacing specific snippet, like Barry's
	   example where it's an area that is hard to find a generic solution
	   that doesn't have a drawback over a class of workloads.

	2. The set of bpf programs that modify it live in the kernel tree for
	   each hook added. Then we can reason about why the hook is there and
	   allow others to reap the benefit. Beside being able to re-evaluate
	   easily if the users still need that hook after a potential
	   improvement that could render it unnecessary.

	3. Out of tree bpf programs can only be loaded if special CONFIG option
	   is set so that production kernel can only load known ones that the
	   community knows and have reasoned about.

	4. Out of tree bpf programs will taint the kernel. A regression
	   reported with something funny loaded should be flagged as
	   potentially bogus.

IMHO this should tame the beast to something useful to address these situations
where the change required to improve one workload will harm others and it's
hard to come up with a good compromise. Then the hook as you suggest could help
implement that policy specifically for that platform/workload.

One can note that the behavior I suggest is similar to how modules work :)

> 
> > 
> > So my worry is that this will open the gate for these hooks to get more than
> > just micro-optimization done in a platform specific way. And that it will
> > discourage having the right discussion to fix real problems in the scheduler
> > because the easy path is to do whatever you want in userspace. I am not sure we
> > can control how these hooks are used.
> 
> I totally understand your worry. I think we need to find a right balance between
> allowing to implement custom policies and keeping the core functionality
> working well enough for everybody without a need to tweak anything.
> 
> It seems like an alternative to this "let's allow cfs customization via bpf"
> approach is to completely move the scheduler code into userspace/bpf, something
> that Google's ghOSt is aiming to do.

Why not ship a custom kernel instead then?

> 
> > 
> > The question is: why can't we fix any issues in the scheduler/make it better
> > and must have these hooks instead?
> 
> Of course, if it's possible to implement an idea in a form which is suitable
> for everybody and upstream it, this is the best outcome. The problem is that
> not every idea is like that. A bpf program can leverage a priori knowledge
> of a workload and its needs, something the generic scheduler code lacks
> by the definition.

Yep I see your point for certain aspects of the scheduler that are hard to tune
universally. We just need to be careful not to end up in a wild west or Anything
Can Happen Thursday situation :-)

Maybe the maintainers have a different opinion though.

Cheers

--
Qais Yousef
