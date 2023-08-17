Return-Path: <bpf+bounces-7978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4477F6A3
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3185E281F35
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0713AF0;
	Thu, 17 Aug 2023 12:45:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF32907
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 12:45:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3852D5F;
	Thu, 17 Aug 2023 05:45:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CF5471F37E;
	Thu, 17 Aug 2023 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692276303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Y4uutNGiyglnRVYZ37VgSZBIlCiWbTZw10bCsdh+U=;
	b=xTxo3ULy2cROATRxU5wfG33L5gtux5qLqGMrESLSQNdJuiaOwJwtHlPvUfSwJaXt/Gy/Jo
	SB5QhGiV1QqZ0YFe8g4vRTgTDSV9NxJdJ+8+Ty6T5xvSu5loJx2IPT/wcHlzPMPnbZ7do2
	8VqrnPqbqMGrMIh5inb31bZG62KV6m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692276303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X4Y4uutNGiyglnRVYZ37VgSZBIlCiWbTZw10bCsdh+U=;
	b=K6LaTvrG0F5YKE32ohyhD+hyxGKRy0AvHUKYHD7GCfBiOoaQrLLgIHlR4WR7y1btdkekmt
	H9t0axppz1JDU1DQ==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id B07DF2C146;
	Thu, 17 Aug 2023 12:45:00 +0000 (UTC)
Date: Thu, 17 Aug 2023 13:44:57 +0100
From: Mel Gorman <mgorman@suse.de>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <20230817124457.b5dca734zcixqctu@suse.de>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZMMH1WiYlipR0byf@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 02:12:05PM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Wed, Jul 26, 2023 at 11:17:52AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 21, 2023 at 08:37:41AM -1000, Tejun Heo wrote:
> > > We are comfortable with the current API. Everything we tried fit pretty
> > > well. It will continue to evolve but sched_ext now seems mature enough for
> > > initial inclusion. I suppose lack of response doesn't indicate tacit
> > > agreement from everyone, so what are you guys all thinking?
> > 
> > I'm still hating the whole thing with a passion.
> > 
> > As can be seen from the wide-spread SCHED_DEBUG abuse; people are, in
> > general, not interested in doing the right thing. They prod random
> > numbers (as in really, some are just completely insane) until their
> > workload improves and call it a day.
> 
> I think it'd be useful to add some details to what's going on in situations
> like above. This of course wouldn't apply directly to everyone but I suspect
> many will recognize at least some parts of it.
> 

I cannot speak for Peter but I've seen numerous cases of similar abuse.
While there is selection bias, in that I only see bugs about failures and
not stories about successes, I've yet to see an instance where debugfs
tunables were used correctly. This includes the "tuned" tool where,
depending on the circumstance, a symbolic name for the tuning set may
have the opposite effect to what is desired in a specific circumstance.
In almost all cases where I recommended a debug tuning for a user, it
was to workaround a scheduler bug in an old kernel that was then fixed
upstream. In many cases, the backport was not feasible as the risk for
other regressions was too substantial.

The reasons for the mistakes vary. Sometimes it was because there was a
complete misunderstanding of what the parameter did. Others it was because
the side-effects were not taken into account. While I cannot remember
specifically, I think there were a few instances where a tuning parameter
that used to work did not work the same way in a later kernel. In at least
one case, the "tuning" happened to help a benchmark (which had nothing to
do with their workload) because it caused starvation issues which happened
to produce good numbers.

> In many production setups, there are aspects of workload behaviors that are
> difficult to understand comprehensively. The workloads are often massively
> complex, constantly being developed by many people, and dynamically
> interacting with external entities. As with any sufficiently complex system,
> there are many emergent properties which are difficult to untangle
> completely.
> 

While this is true, the same is also true for some of the scheduler
paramters.

> Add to that multiple generations of divergent hardware and most of the
> software stack coming from third parties (including kernel from application
> team's POV), people often and justifiably feel as if they're swimming in the
> sea of black boxes and emergent properties.
> 

Also true of the tuning parameters. In some cases, changes in hardware or
the software stack violate so many of the original assumptions that tuning
is not sufficient.

> Scheduling, naturally, is one of the areas that people look into when trying
> to optimize system performance. Vast majority of people don't know scheduler
> code base well enough to hack on it. Even when they do, it's often not easy
> to set up benchmarks in production environments and cycle through different
> kernels. We (Meta) are a lot better now than a couple years ago, but even
> now swapping kernels and ramping workloads back up can take a long time for
> certain workloads.
> 

But this complexity is not necessarily solved by introducing pluggable
schedulers. The level of expertise required to hack on the scheduler or
hack on a pluggable scheduler both require a solid understanding of
scheduling in general and the ability to analyse what is going on.

> Given the circumstances, it's not surprising that people go for tunable
> knobs when they're trying to find out whether changing scheduling behaviors
> would improve performance for their workloads. That's often the only option
> available and tuning the knobs frequently leads to some gains. Most people
> aren't scheduling experts and the causal relationships between changes and
> results may not be direct or intuitive. So, that's often where things end.
> Given that nobody has found scheduling behavior which is optimal for every
> workload and the SCHED_DEBUG knobs are what people can access, it is an
> expected outcome.
> 

And while those tuning options are used, usually by searching for a stock
tuning guide for an arbitrary workload/platform and hoping for the best,
it's often the case that any gain is co-incidental. Worse, I've seen far
too many cases where there was no test for significance before/after to
ensure the tuning parameter is actually helping. Worse again, I've seen
tuning for some completely random workload and then hoping that this is
somehow relevant to the target workload (spoiler: it almost never is).

> If a consistent pattern is repeated across multiple workloads, we can
> sometimes work back why tuning certain way makes sense and generalize that,
> which is to some degree how we ended up focusing on recent work-conservation
> related projects.
> 
> Maybe the situation is not ideal but I don't think it's people not being
> interested in doing the right thing. They are doing what they can within the
> confines of available mechanisms, expertise, and time & effort they can
> afford to invest.
> 
> One of the impediments when trying to connect these disparate data points
> into something meaningful is the difficulty in experimentation. The trials
> are confined to whatever combinations that can be achieved with SCHED_DEBUG
> knobs which are both limiting and obscuring. I believe we're a lot more
> likely to learn more about scheduling with sched_ext widely available than
> without as it would allow easier and wider-in-scope experimentations.
> 

An apparent assumption there is "the impact of sched debug tuning is
too hard to understand but sched_ext and writing your own scheduler is
easier". That's .... a big leap.

> > There is not a single doubt in my mind that if I were to merge this,
> > there will be Enterprise software out there that will mandate its own
> > BPF sched thing, or else it won't work.
> >
> > They will not care, they will not contribute, they might even pull a
> > RedHat and only share the code to customers.
> 
> I'm sure some will behave in a way which isn't the most conducive to
> collective improvement of the upstream kernel. That said, I don't see how
> this will be noticeably worsened by inclusion of sched_ext. Most mobile
> kernels and some production kernels in cloud environments already carry
> significant custom modifications, and they're often addressing real problems
> for their use cases.
> 

Peter answered this

	There is not a single doubt in my mind that if I were to merge this,
	there will be Enterprise software out there that will mandate its
	own BPF sched thing, or else it won't work.

While I have not seen this class of problem for scheduler in particular,
I've deal with too many bugs that required out-of-tree components to be
loaded and a requirement that the bug be fixed in that context.
Scheduler bugs are already very tricky without adding opaque blobs.

> It'd be ideal if everyone had the commitment and bandwidth to try their best
> to merge back their changes but it's also understandable why that can't
> always be the case. Sometimes, it's too specific or underdeveloped. At other
> times, time and resources just aren't there. We can incentivize and coerce
> but that can be pushed only so far. However, we do have an a lot easier time
> learning about what people are doing thanks to GPL which all sched_ext
> programs would need to follow exactly like the rest of the kernel.
> 

By this logic, you expect sched_ext usage to grow with special cases
that may never be compatible with the core scheduler.

> At least relatively speaking, scheduling doesn't seem like an area which is
> particularly starved for developer bandwidth although one can always hope
> for more.

There are a fair few active developers but I know my own backlog for
scheduler review is severe and I doubt it's just me. The focus is also
diffuse as scheduler has a lot of parts. There might be a lot of activity
in EAS for example at a point in time, but that's a specific use case.

> > <SNIP>
> > We all loose in that scenario. Not least me, because I get the
> > additional maintenance burden.
> 
> sched_ext isn't that invasive to the core code and its interactions with
> other scheduling classes are very limited.

On the flip side, there are some layering violations between the fair
scheduler and core so modifying those without breaking an arbitrary
external scheduler may be problematic. Maintenance also isn't just code.
Dealing with regressions in scheduler or even just changes in hardware
is already quite difficult, particularly as it's not always possible to
get high quality data or reproduce the environment. That is orders of
magnitude more difficult if an unknown scheduler is involved.

There is also the possibility that running within containers becomes harder
if different containers require different schedulers or a custom scheduler
helps one container and hurts another.

> This would make changing
> scheduling core API a bit more burdensome but they have been relatively
> stable and both David and I would be on the hook if anything is in your way.
> I don't see why this would significantly increase your maintenance burden.
> It's a thing but it's a thing in its own corner.
> 

I disagree about the maintenance burden. I think it's inevitable that some
enterprise software will require it and are unwilling or unable to modify the
upstream scheduler to meet their requirements. There may be even be incentive
for them to use a custom scheduler to game benchmark comparisons and not
contribute it back. Distributions would be faced with the stark choice of
"disable sched_ext and hope some major software stack does not require it"
or "try support arbitrary black box schedulers when regressions occur". Both
choices are unpalatable and while this is not directly a maintenance issue
upstream, it's an indirect one when dealing with regressions after a kernel
version upgrade. The problems faced by distributions are not the same as
those faced by Google or Meta because distributions have limited to no
control over what software stack runs on the OS.

While I don't have the authority to NAK a custom scheduler framework, I
am opposed to it conceptually because I suspect supporting it in the
field will be a nightmare.

-- 
Mel Gorman
SUSE Labs

