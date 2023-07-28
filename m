Return-Path: <bpf+bounces-6111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA7766090
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B5B1C2169C
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FFECC;
	Fri, 28 Jul 2023 00:12:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097F18E
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:12:10 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5831DB;
	Thu, 27 Jul 2023 17:12:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbc64f9a91so12561475ad.0;
        Thu, 27 Jul 2023 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690503128; x=1691107928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMW+tXZSB1IEy+NDCmgRCT1T7EwZ+vB6EPHap/SErQw=;
        b=OSIMkA0drhFblDJk8sAYp21OQBEJ2DcKXwT+WpvmrCpsuw5agsf3LKC6ScahrsaAl+
         1NwVW+pNCdN2G1CrSFmaojvlL7nvD0pBmcL2DPSoB56mkjPurRar9VQjRtR/L2udVkul
         ka4GWEUAooO2A7ssX+aUIIoPbe3EbnIg7GG4L4TZSnkjxN6Ug3FdeUeLZ3v6vFtdJpby
         weWGKs4n0WqdToiWXPFgO2SSR3Y4DAlK9Z+YkLWf3+Z307IoQztJPrynrk4dWdRis3vd
         2LVE25mvIQjdsCqwL/ewJnC1T14waXPsJJSOOz3iqPQDLtdJCeTVbA3sZ0qe3KcliJx6
         UONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503128; x=1691107928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMW+tXZSB1IEy+NDCmgRCT1T7EwZ+vB6EPHap/SErQw=;
        b=PiHNSPySMapuIyJ9CZCIj1iL7W38zzSgvHS2Xb20N+M8zrKY3dhVec/E7dHalx1MFr
         IqZ1+J/uEywQHcb70JOHIUpJhhOUSSfH1PtgUUoBP4Gi40LH02XocFCXEkJE8GJ+npQh
         2BrQxV/xnnxTgwBEXBgxdu0HGAcIymJPu28GwOG8HhrHYh8atC/yHAkWjyERe+SrU+9J
         ws/F/a8m0IAHNhRXEp/4Kmp5mHr5YYRChYQe5h570ZGjeA1BB67pLa/5nVjfVQ3aefMn
         HBnb8c+gpLvVVFJdz7Pxjk0vE6aGx4+Yrzxu+AzfbvCBQOj6npC+74QYxkOSAZ3lqJmb
         JmNw==
X-Gm-Message-State: ABy/qLb11VKiWVVj0sJEn1eKnd/P3/JQe9p/zIWCki2USs4ct/2iXAWi
	HSXyJ/rsygA1XuLgSms53w0=
X-Google-Smtp-Source: APBJJlF99T5r4z5NUxqqZbdV2TKrRrCZFlXIT6/CeIPe0cFNHtCrmlxmaKNwHERAPTAittP3QDwJKA==
X-Received: by 2002:a17:903:244e:b0:1b8:aee8:a21c with SMTP id l14-20020a170903244e00b001b8aee8a21cmr147234pls.31.1690503127802;
        Thu, 27 Jul 2023 17:12:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902bc4b00b001b53be3d942sm2191641plz.232.2023.07.27.17.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 17:12:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jul 2023 14:12:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
Message-ID: <ZMMH1WiYlipR0byf@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
 <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726091752.GA3802077@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Peter.

On Wed, Jul 26, 2023 at 11:17:52AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 21, 2023 at 08:37:41AM -1000, Tejun Heo wrote:
> > We are comfortable with the current API. Everything we tried fit pretty
> > well. It will continue to evolve but sched_ext now seems mature enough for
> > initial inclusion. I suppose lack of response doesn't indicate tacit
> > agreement from everyone, so what are you guys all thinking?
> 
> I'm still hating the whole thing with a passion.
> 
> As can be seen from the wide-spread SCHED_DEBUG abuse; people are, in
> general, not interested in doing the right thing. They prod random
> numbers (as in really, some are just completely insane) until their
> workload improves and call it a day.

I think it'd be useful to add some details to what's going on in situations
like above. This of course wouldn't apply directly to everyone but I suspect
many will recognize at least some parts of it.

In many production setups, there are aspects of workload behaviors that are
difficult to understand comprehensively. The workloads are often massively
complex, constantly being developed by many people, and dynamically
interacting with external entities. As with any sufficiently complex system,
there are many emergent properties which are difficult to untangle
completely.

Add to that multiple generations of divergent hardware and most of the
software stack coming from third parties (including kernel from application
team's POV), people often and justifiably feel as if they're swimming in the
sea of black boxes and emergent properties.

Scheduling, naturally, is one of the areas that people look into when trying
to optimize system performance. Vast majority of people don't know scheduler
code base well enough to hack on it. Even when they do, it's often not easy
to set up benchmarks in production environments and cycle through different
kernels. We (Meta) are a lot better now than a couple years ago, but even
now swapping kernels and ramping workloads back up can take a long time for
certain workloads.

Given the circumstances, it's not surprising that people go for tunable
knobs when they're trying to find out whether changing scheduling behaviors
would improve performance for their workloads. That's often the only option
available and tuning the knobs frequently leads to some gains. Most people
aren't scheduling experts and the causal relationships between changes and
results may not be direct or intuitive. So, that's often where things end.
Given that nobody has found scheduling behavior which is optimal for every
workload and the SCHED_DEBUG knobs are what people can access, it is an
expected outcome.

If a consistent pattern is repeated across multiple workloads, we can
sometimes work back why tuning certain way makes sense and generalize that,
which is to some degree how we ended up focusing on recent work-conservation
related projects.

Maybe the situation is not ideal but I don't think it's people not being
interested in doing the right thing. They are doing what they can within the
confines of available mechanisms, expertise, and time & effort they can
afford to invest.

One of the impediments when trying to connect these disparate data points
into something meaningful is the difficulty in experimentation. The trials
are confined to whatever combinations that can be achieved with SCHED_DEBUG
knobs which are both limiting and obscuring. I believe we're a lot more
likely to learn more about scheduling with sched_ext widely available than
without as it would allow easier and wider-in-scope experimentations.

> There is not a single doubt in my mind that if I were to merge this,
> there will be Enterprise software out there that will mandate its own
> BPF sched thing, or else it won't work.
>
> They will not care, they will not contribute, they might even pull a
> RedHat and only share the code to customers.

I'm sure some will behave in a way which isn't the most conducive to
collective improvement of the upstream kernel. That said, I don't see how
this will be noticeably worsened by inclusion of sched_ext. Most mobile
kernels and some production kernels in cloud environments already carry
significant custom modifications, and they're often addressing real problems
for their use cases.

It'd be ideal if everyone had the commitment and bandwidth to try their best
to merge back their changes but it's also understandable why that can't
always be the case. Sometimes, it's too specific or underdeveloped. At other
times, time and resources just aren't there. We can incentivize and coerce
but that can be pushed only so far. However, we do have an a lot easier time
learning about what people are doing thanks to GPL which all sched_ext
programs would need to follow exactly like the rest of the kernel.

At least relatively speaking, scheduling doesn't seem like an area which is
particularly starved for developer bandwidth although one can always hope
for more. Actual insights and an easy way to experiment and collaborate to
discover them seem like a bigger bottleneck. Hopefully, sched_ext will widen
the scope of things that people will try. Even when they don't directly
contribute those changes back to CFS, if a strategy is effective and general
enough, others can learn from them and apply to improve scheduling for
everyone.

Both Meta and Google are committed to sharing what we learn, both in terms
of code and insights. The example schedulers in the posting are all we
(Meta) have been experimenting with except for really hacky soft affinity
trials which will be generalized and shared too. David has also been
actively working to apply the shared runqueue changes to CFS which came from
earlier sched_ext experiments. Google has been open-sourcing their ghOSt
framework and schedulers built on top of it which will be ported to
sched_ext in the future. Google is starting to see promising results with
search and will share their findings in code and through other venues
including conferences.

> We all loose in that scenario. Not least me, because I get the
> additional maintenance burden.

sched_ext isn't that invasive to the core code and its interactions with
other scheduling classes are very limited. This would make changing
scheduling core API a bit more burdensome but they have been relatively
stable and both David and I would be on the hook if anything is in your way.
I don't see why this would significantly increase your maintenance burden.
It's a thing but it's a thing in its own corner.

> I also don't see upsides to merging this. You all can play with
> schedulers out-of-tree just fine and then submit what actually works.

There is a huge difference between having a common framework upstream and
not having one. If in kernel, everyone knows that it's widely available and
will remain so for a very long time. It removes the risk of investing energy
and effort into something which may or may not exist next year.

It also has the standardizing effect where different parties can exchange
code and ideas easily. It's so much more effective to be able to directly
build upon other people's work than trying to reimplement everything on your
own or navigate maze of different frameworks and patches with different
baseline kernel versions and so on. I mean, these are the reasons that we
want things upstreamed, right?

Thanks.

-- 
tejun

