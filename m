Return-Path: <bpf+bounces-8526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A128787A5E
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE251C20F0F
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCE947A;
	Thu, 24 Aug 2023 21:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF378BFE
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 21:31:38 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4051BCC;
	Thu, 24 Aug 2023 14:31:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf55a81eeaso2961725ad.0;
        Thu, 24 Aug 2023 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692912695; x=1693517495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKAIs+2fNYvzmb5QzfCxzgV9RCkdRYZjfdnHg8daweY=;
        b=fo38qyB1Qvc4qozpJbxdtgWjgIg1Y9j2PwUk+xAYXqosIdQdytrupndiapK2ijXshF
         Ru/e9D9nASnNpAxlHSxOSGFiYRe81CcttRVYYg1Ch1sIANh+XNVJaIJVl4/MZZoFR3p+
         PFrHDU/L/vy/EUdPc/ujSeXSKb7Zhntt1YhBAWQYiK9CZUeio33QA/f0y7EwMdgEts7z
         QAsHKOSGqYEosa8raocEgcGhutgv2YlncSfw8MSIdfnVa07ysPHj7zWGL6ulhEstULLb
         DpbYlQlWtTZujsSK9RUei5zhJITu4Ti6A8gm2el43MQGMHdYjukQCQni519UMGvHOpgS
         y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912695; x=1693517495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKAIs+2fNYvzmb5QzfCxzgV9RCkdRYZjfdnHg8daweY=;
        b=gXXfWsPqS4qJ1kbgqk0NIO1vQx0KppOCnmJ+VxuIQvgZt9d5Qax32al0Yc71yczdDK
         ElIN7K9hxmEL2fAYjD77enRFwt4EVfQqFLQyH5NuPqYRoaFtNeRPD0lYEceHmg1a7wJg
         xtWZ1Ds+EdCfbUaqIvVg9hBGLE/yynZice3LluugkMgaBmnzXVohI2+/gBp14MKoDYkb
         YUCa9DDqedXT+uFRIqbZvFJdeTnhX3AI7ZQZiQ8tYD/gUL7xX3FFul9INHYtjEthKLLn
         uGBoGcRcL9J/UfsI9nsheT1mIfF+VPNkO6+KQO1Cme5oCRGW1MgM1a4oEvbZTdlKqCIg
         bLZg==
X-Gm-Message-State: AOJu0YyU5GNTbL97Zy2TBsTf89gwyqKInvedrxvI9urzcyRLzca6KGba
	iYkNuZUtiDGMV7VoELteFSM=
X-Google-Smtp-Source: AGHT+IGXo/YK0MBzNBfyufCPVywrVzpnFduCCLS7j02dSZT442YHnAAW7p31MF8o/Jx7hesL/lXf3A==
X-Received: by 2002:a17:903:2352:b0:1c0:9c20:b9b6 with SMTP id c18-20020a170903235200b001c09c20b9b6mr9976623plh.15.1692912694686;
        Thu, 24 Aug 2023 14:31:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f05])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902da8d00b001c09d6feeb6sm116796plx.165.2023.08.24.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 14:31:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 24 Aug 2023 11:31:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Mel Gorman <mgorman@suse.de>
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
Message-ID: <ZOfMNEoqt45Qmo00@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
 <ZMMH1WiYlipR0byf@slm.duckdns.org>
 <20230817124457.b5dca734zcixqctu@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817124457.b5dca734zcixqctu@suse.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Mel.

On Thu, Aug 17, 2023 at 01:44:57PM +0100, Mel Gorman wrote:
> > > As can be seen from the wide-spread SCHED_DEBUG abuse; people are, in
> > > general, not interested in doing the right thing. They prod random
> > > numbers (as in really, some are just completely insane) until their
> > > workload improves and call it a day.
> > 
> > I think it'd be useful to add some details to what's going on in situations
> > like above. This of course wouldn't apply directly to everyone but I suspect
> > many will recognize at least some parts of it.
> 
> I cannot speak for Peter but I've seen numerous cases of similar abuse.
> While there is selection bias, in that I only see bugs about failures and
> not stories about successes, I've yet to see an instance where debugfs
> tunables were used correctly. This includes the "tuned" tool where,
> depending on the circumstance, a symbolic name for the tuning set may
> have the opposite effect to what is desired in a specific circumstance.
> In almost all cases where I recommended a debug tuning for a user, it
> was to workaround a scheduler bug in an old kernel that was then fixed
> upstream. In many cases, the backport was not feasible as the risk for
> other regressions was too substantial.

I'm sure there are ample examples of knobs being misused as with anything.
However, given that there are quite a few heuristics involved in making
scheduling decisions, which are inherently parameterized and have to make
trade-offs, claiming that the scheduler can do away with exposing these
parameters sounds impractically optimistic.

For example, migration_cost_ns determines the trade-off between cache
locality and work conservation. It materially impacts tail latencies,
maximum bandwidth, and power consumption. The optimal point doesn't just
depend on the hardware, the type of workload or its current load level but
also what matters to the specific use case of the given workload.

Also, while the default parameters are the results of many benchmarks and
years of experience, the kernel is used for all kinds of things and we are
always subject to exposure bias. Whoever is working on the code and/or
posting results gets to influence how the code is structured and these
parameters are determined. There's nothing wrong with that but it does point
to the fact that there are going to be sizable holes and biases in our
evaluations.

One may argue that problems like the above can be solved by the scheduler
being adaptive with the applications and admins providing enough hints on
the intents. Maybe that is possible but it certainly doesn't seem like we're
anywhere close. As an ideal, it may make sense but I'm skeptical it's
tracking reality.

> The reasons for the mistakes vary. Sometimes it was because there was a
> complete misunderstanding of what the parameter did. Others it was because
> the side-effects were not taken into account. While I cannot remember
> specifically, I think there were a few instances where a tuning parameter
> that used to work did not work the same way in a later kernel. In at least
> one case, the "tuning" happened to help a benchmark (which had nothing to
> do with their workload) because it caused starvation issues which happened
> to produce good numbers.

It is difficult to compare anecdotes with much objectivity but I'd like to
offer some counter-points.

What you're describing is very different from what I see. I often see
talented engineers working tirelessly to establish practical performance and
reliability metrics, constantly improve the tools to measure and run
experiments, and optimize their workloads and configuration accordingly.
People of course have different areas of expertise, differing levels of
insights and make mistakes which make for good stories, but I don't
recognize what you're describing as the prevalent case.

Both of us could be right. Different segments of the industry operate in
different manners and maybe more importantly interact in their specific
ways. Depending on one's exposure, I can imagine the general impression
being swayed one way or the other.

While we don't want to unnecessarily encourage users to shoot their feet, we
do want what's presented to userspace to be true to the technical and
practical reality. Otherwise, we run the risk of getting in the way of users
doing things. We don't have the perfect scheduler for all, or even most,
users. We do have a pretty good one with reasonable default behaviors and a
bunch of tunable parameters. What's presented to the world should match that
reality.

Speaking for Meta, these knobs really are critical. We see significant
bandwidth and latency gains (bandwidth usually few percents, larger tail
latency impacts) across multiple major workloads. We ate the operational
costs of moving our infra to using debugfs instead of sysctls (where
appropriate) because the capacity losses were untenable otherwise. While
this wasn't the end of the world, it was perplexing why this change was
made, as it could easily have broken just as many valid users as it might
block misuses. If something is needed, users will adapt to use the feature,
making such churn pointless. I suppose this is a reflection of how we
perceive the reality differently.

...
> > Scheduling, naturally, is one of the areas that people look into when trying
> > to optimize system performance. Vast majority of people don't know scheduler
> > code base well enough to hack on it. Even when they do, it's often not easy
> > to set up benchmarks in production environments and cycle through different
> > kernels. We (Meta) are a lot better now than a couple years ago, but even
> > now swapping kernels and ramping workloads back up can take a long time for
> > certain workloads.
> 
> But this complexity is not necessarily solved by introducing pluggable
> schedulers. The level of expertise required to hack on the scheduler or
> hack on a pluggable scheduler both require a solid understanding of
> scheduling in general and the ability to analyse what is going on.

I think there's some disconnect on how sched_ext can improve situations like
this. As this comes up again later, let's discuss there.

> > Given the circumstances, it's not surprising that people go for tunable
> > knobs when they're trying to find out whether changing scheduling behaviors
> > would improve performance for their workloads. That's often the only option
> > available and tuning the knobs frequently leads to some gains. Most people
> > aren't scheduling experts and the causal relationships between changes and
> > results may not be direct or intuitive. So, that's often where things end.
> > Given that nobody has found scheduling behavior which is optimal for every
> > workload and the SCHED_DEBUG knobs are what people can access, it is an
> > expected outcome.
> 
> And while those tuning options are used, usually by searching for a stock
> tuning guide for an arbitrary workload/platform and hoping for the best,
> it's often the case that any gain is co-incidental. Worse, I've seen far
> too many cases where there was no test for significance before/after to
> ensure the tuning parameter is actually helping. Worse again, I've seen
> tuning for some completely random workload and then hoping that this is
> somehow relevant to the target workload (spoiler: it almost never is).

As before, the above doesn't agree with what I see at all. Even small
performance differences count for huge eventual impacts at scale for both
servers and personal devices including e.g. VR headsets. There are a lot of
smart engineers poring over scheduling traces and profiling outputs trying
to optimize things as much as they can with the tools they have available.

We could be looking at the two extreme ends of the user competence spectrum.
The incompetent end is more entertaining but emphasizing that too much can
lead to inflated evaluation of ourselves and underestimation of others,
which is a dangerous place to be. While I don't have statistical data to
prove which perception is correct, it may still be useful to imagine what
the reality would be like if it were to match what you're describing.

We both agree that there are evidences showing that users often try to and
actually tune the scheduler parameters. If the perception that most, if not
nearly all, of these cases are misguided and don't even achieve anything
were to be true, the wider industry would have to be filled mostly with
incompetence and cargo-culting. That's a very stark view of the world.

Wouldn't a more reasonable interpretation be that what's suggested is a real
and persistent need that many use-cases encounter and that the effectiveness
of the actions that people take follow some normal-like distribution? There
will be ample silliness at one tail end, clever feats of engineering at the
other, with most cases doing something which isn't quite optimal but not
completely stupid either.

...
> > One of the impediments when trying to connect these disparate data points
> > into something meaningful is the difficulty in experimentation. The trials
> > are confined to whatever combinations that can be achieved with SCHED_DEBUG
> > knobs which are both limiting and obscuring. I believe we're a lot more
> > likely to learn more about scheduling with sched_ext widely available than
> > without as it would allow easier and wider-in-scope experimentations.
> 
> An apparent assumption there is "the impact of sched debug tuning is
> too hard to understand but sched_ext and writing your own scheduler is
> easier". That's .... a big leap.

The followings are what I understood as your arguments from the earlier
paragraph on difficulties of working on the scheduler and the above one.
Please correct me if I got them wrong:

1. Understanding and working on the scheduler requires a high level of
   expertise.

2. Pluggable schedulers won't contribute to improving scheduling in general
   because most won't be able to work on it anyway.

3. Pluggable schedulers won't add much in terms of making understanding and
   working on schedulers easier. Specifically, understanding the scheduling
   behavior of a sched_ext scheduler would not be easier than understanding
   how to competently apply CFS debug knobs.

Scheduling is a specialized area and possibly a more challenging one than
most. However, I don't think it's so much more difficult than others to the
point where wider participation is unrealistic. Here are some counterpoints
to the claim that not many people would be able to use or benefit from
pluggable schedulers (#1 and #2):

* Filesystems are difficult but people come up with new ideas and
  implementations all the time. If anything, we have too many, not too few.
  With all the problems that entails, this is a huge net benefit in the long
  term. That active experimentation and competition mean that there are many
  more and better options for filesystems now than there were 20 years ago.

* How a subsystem is structured and operated has a strong influence on how
  many would be active in the area. Scheduling is pretty exclusive. Even
  then, we constantly see attempts at implementing something new from
  different people. Even just the currently active full implementations
  include MuQSS, PDS, BMQ and TT and there are more focused efforts like the
  nest scheduler or BORE.

* Many application engineers have a very detailed understanding of how their
  application behaves, sometimes down to specific scheduling misbehaviors
  they want to address. Most wouldn't work on scheduler code directly but
  people who are more familiar with the scheduler can partner with them.
  Also, providing them more canned tools and space to explore would lead to
  discovery of useful strategies.

Writing a scheduler is difficult (#2 and #3). However, there are ways to
make these things easier, safer and more accessible. With sched_ext:

* Scheduler implementation can't crash the machine. There are multiple ways
  to safely revert to the default scheduler, and a watchdog exists which
  will boot the scheduler out if it’s failing to schedule tasks in a timely
  manner.

* The API is structured so that it's easier to write schedulers. One can get
  a basic vtime based scheduler going with a few tens of lines of code which
  can be good enough for personal or even some production use. It really
  doesn't take much to experiment in areas like CPU selection and ad-hoc
  soft-affinity.

* Iterating through implementations is as easy as changing-code, compiling
  and reloading. The worst that can happen to the machine is hanging due to
  some threads being forgotten or starved. You can easily restore with a
  sysrq or wait a bit until the watchdog kicks in and try again.

* People don't have to start from scratch. We can build up repertoire of
  examples, best practices and libraries to make it even easier.

Combined, I believe sched_ext significantly lowers the barrier of entry.

As for the argument that scheduling behavior won't be easier to understand
with sched_ext (#3), I wonder whether drawing parallels to a debugging
session would be useful.

When debugging a subtle and difficult bug caused by a combination of dynamic
behaviors, the ability to modify behaviors is critical. I want to know
what's happening and what happens if I change a part of the logic in
question. Less so with better visibility tools nowadays but debugging
sessions can be repeated iterations of adding [trace_]printk()'s and
eliminating possibilities by modifying code piecemeal.

Identifying and fixing lost performance due to suboptimal, complex
scheduling behaviors can have a lot of similarities. If you only have three
knobs you can twiddle, there's only so much you can learn. The configuration
space afforded by the knobs is unlikely to fully cover what you want to try.
However, if you can change and modulate every behavior safely and quickly,
you can learn a lot more a lot faster.

...
> > I'm sure some will behave in a way which isn't the most conducive to
> > collective improvement of the upstream kernel. That said, I don't see how
> > this will be noticeably worsened by inclusion of sched_ext. Most mobile
> > kernels and some production kernels in cloud environments already carry
> > significant custom modifications, and they're often addressing real problems
> > for their use cases.
> 
> Peter answered this
> 
> 	There is not a single doubt in my mind that if I were to merge this,
> 	there will be Enterprise software out there that will mandate its
> 	own BPF sched thing, or else it won't work.
> 
> While I have not seen this class of problem for scheduler in particular,
> I've deal with too many bugs that required out-of-tree components to be
> loaded and a requirement that the bug be fixed in that context.
> Scheduler bugs are already very tricky without adding opaque blobs.

This seems to stem from distro POV more than upstream (although not
completely). As this comes up again later, let's discuss there.

> > It'd be ideal if everyone had the commitment and bandwidth to try their best
> > to merge back their changes but it's also understandable why that can't
> > always be the case. Sometimes, it's too specific or underdeveloped. At other
> > times, time and resources just aren't there. We can incentivize and coerce
> > but that can be pushed only so far. However, we do have an a lot easier time
> > learning about what people are doing thanks to GPL which all sched_ext
> > programs would need to follow exactly like the rest of the kernel.
> 
> By this logic, you expect sched_ext usage to grow with special cases
> that may never be compatible with the core scheduler.

Prediction is always challenging but my gut feeling is that most users
wouldn't care to adopt custom schedulers. It just won't make meaningful
differences. In some quarters tho, custom schedulers may become more
popular. For example, it's already more prevalent to run custom schedulers
in gaming communities because their requirements aren't fully served by the
default scheduler. There also are use cases which require lower latency at
the cost of everything else or even ones which must implement specific
scheduling behavior incompatible with generic use such as ARINC 653 for
avionics.

Given how widely Linux is used these days, the fact that one size doesn't
fit all shouldn't be too surprising and I don't believe this necessarily
hampers the default scheduler. Code should be just as available as any
kernel modifications, and, when implementing the same logic, the builtin
scheduler would always have some advantages.

The hardware is changing really fast with increased core counts, more
complex cache topologies with core distances that weren't common before,
more and more dynamic clock scaling and heterogeneous CPUs. The use cases
keep becoming wider and more diverse too. The problem space is expanding
faster than what can be reasonably mapped out with a single strictly
controlled scheduler implementation. In the long term, I strongly believe
widening the field would benefit everyone including the users of the default
scheduler.

...
> > sched_ext isn't that invasive to the core code and its interactions with
> > other scheduling classes are very limited.
> 
> On the flip side, there are some layering violations between the fair
> scheduler and core so modifying those without breaking an arbitrary
> external scheduler may be problematic. Maintenance also isn't just code.

There's quite a bit of abstraction between the scheduler core API and the
API sched_ext exposes. The only part that needs to be maintained as core
code changes should be the sched_ext core, not the BPF scheduler
implementations.

> Dealing with regressions in scheduler or even just changes in hardware
> is already quite difficult, particularly as it's not always possible to
> get high quality data or reproduce the environment. That is orders of
> magnitude more difficult if an unknown scheduler is involved.

I don't quite follow. If any scheduling related issue is suspected, wouldn't
the first step of debugging be excluding that by switching the scheduler?
And if the problem goes away without the scheduler, the problem is for that
scheduler to solve, right? It may add some triaging overhead but I don't
quite understand how it would make things orders of magnitude more
difficult.

Maybe it's not the best analogy but the existence of btrfs doesn't make ext4
problems significantly more difficult to debug. With sched_ext, isolating
scheduling problems can even become easier in some cases as the schedulers
can be switched dynamically.

> There is also the possibility that running within containers becomes harder
> if different containers require different schedulers or a custom scheduler
> helps one container and hurts another.

This is definitely something we've been thinking about given how
containerized our environments are. Google's ghOSt scheduler has the concept
of enclaves where different schedulers can be used on different CPUs.
sched_ext didn't go that route mostly because this seemed like a problem
which can be solved at the BPF layer where the framework layer itself which
manages multiple active schedulers is implemented in BPF. This would have
the advantage of more flexibility - e.g. by allowing custom stealing
mechanism across partitions to improve work conservation.

While there are some existing examples in networking where this kind of BPF
program layering is used, it's likely that BPF would need more features to
properly support such layering for sched_ext. It is also possible that
supporting enclave equivalent at the sched_ext core layer like ghOSt will
eventually be chosen, which has a lot of pros too.

So, yeah, this is definitely an area of future development.

> > This would make changing
> > scheduling core API a bit more burdensome but they have been relatively
> > stable and both David and I would be on the hook if anything is in your way.
> > I don't see why this would significantly increase your maintenance burden.
> > It's a thing but it's a thing in its own corner.
> 
> I disagree about the maintenance burden. I think it's inevitable that some
> enterprise software will require it and are unwilling or unable to modify the
> upstream scheduler to meet their requirements. There may be even be incentive
> for them to use a custom scheduler to game benchmark comparisons and not
> contribute it back. Distributions would be faced with the stark choice of
> "disable sched_ext and hope some major software stack does not require it"
> or "try support arbitrary black box schedulers when regressions occur". Both
> choices are unpalatable and while this is not directly a maintenance issue
> upstream, it's an indirect one when dealing with regressions after a kernel
> version upgrade. The problems faced by distributions are not the same as
> those faced by Google or Meta because distributions have limited to no
> control over what software stack runs on the OS.

That is a very good point. It's probably useful to distinguish the impacts
on upstream, distros and the big users that have better control of software
stack which obviously includes the server side of Google and Meta but also
encompasses Android, ChromeOS, VR headsets, gaming devices and so on.

Upstream, we've already discussed. sched_ext shouldn't create huge problems
for big users as they can opt-in and out as they see fit. Especially if
you're already deploying a lot of BPF, much of the infrastructure and
institutional knowledge is already there.

Distros are in a harder spot as sched_ext may add a debug surface which is
unfamiliar and distros are often forced (or rather paid) to solve these
problems. However, it might be useful to take a step back and take a wider
view. Usually, things don't just have costs. They have benefits too.

I'm sure there are pathological cases, but if users and enterprise software
vendors want to use sched_ext, which will probably be a small subset, it's
likely that there are benefits that they see. They would do so because it
enables them to do things which weren't easily possible before. The
ecosystem is split differently on company boundaries but if big users like
Meta and Google find applications which can benefit from custom scheduling
(e.g. remote scheduling for VM-only CPUs), there probably are distro users
who can benefit in a similar fashion.

In principle, enabling customers to achieve more is the role that distros
play and are paid for. So, yes, this would add support cost, but that'd be
because the customers can do more, thus incentivizing them to use the
distro.

This isn't something special about sched_ext. Any kernel subsystem used in
production isn't free, but like any tool, one has to decide if the benefits
outweigh the costs. Meta is using btrfs and BPF heavily, so there are
substantial support costs for both. However, we happily pay them because the
benefits are far greater. For example, at this point, we wouldn't be able to
run our fleet without BPF because the capacity loss would be too drastic.

I'm sure distro users would see similar gains (e.g. w/ firewalls) and
request their distros to support BPF. If a distro chooses to support btrfs,
ext4 or BPF, the distro has to have the capability, and, in general, such
decisions should and would be mutually beneficial.

Thanks.

-- 
tejun

