Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BAD64D251
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 23:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLNWXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 17:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLNWXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 17:23:19 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2E8DF77;
        Wed, 14 Dec 2022 14:23:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b12so271907pgj.6;
        Wed, 14 Dec 2022 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzzTDEEFo1KYRfglg1DqBTihnqu17B7Mn2J+sVHXVo8=;
        b=EOhfC/CVbS3plh9PTqPPd1CN+BuVvJZqPd+3h7ujyuX8GscDA7PnRsaTDSt/U1gmYB
         YrXe0bkePhfa6apsa1gEHiBfgJvMCouPk4Dbs1xGVqKqDqTOeHefKxPPBfDj5H+0kYxE
         17yu084k3KHazDWYNOPKJwLpJoPH5q3f12sYW+pa/PVRa/8B3zoG0nBSApTHz1KcnHON
         nHziq5DlL+4AEBTk1EfFVosVG+2oEqmx40xR/fno8BPgiILRdG5/pHz7mzH4xkH3po40
         uTH+tYfmcYMl7VawydaGL81MhFNr1FG06gtyPP2/YEkDKfqj+Oe/QNuGIm1DjGLcaIUC
         7goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzzTDEEFo1KYRfglg1DqBTihnqu17B7Mn2J+sVHXVo8=;
        b=oxzHQdr30iaLYn7kJxUFFenFM4zhiAeaeMAGYYq8raODMgApTVkS7JTHqIHGJWF8jS
         DUEJ6xRzRtasO6vhL4UuDY+JWUh+7lqA5KakE2FrloBz4xjAYtExV4fTCPgQIe0LIzAY
         baZLVc9ru/B5x/CN6LRgbsaRubbjnOpniHrzeox3RM0AurfGV/A15lm60M9hNA41Zxfz
         X6d+ik1ABv67p497LwdLGdIi3ogB1r0HyXaLT4MIZu4jGciaDCpkbILKipBNupA4mFMq
         i3GZFbDayJo6fMvgnYTlIoH8liLygSrrAQaWMo+Wc21ot5Aa+zPY6sGMzikopA7Cc5OG
         R6oQ==
X-Gm-Message-State: ANoB5pl/gJlYNbT7VlPxC6nfvBvqBX95hyWOYfeLET6qKlbbeUUGBs8W
        2BBBh9wBFbGeakEdz+9imfg=
X-Google-Smtp-Source: AA0mqf4lFL33njTq7IWpEAJwT2IP2d9t6i7W/64boIZeDO7/qbcedMNtbtLLYSa1oIiK4x/DDrWQ2w==
X-Received: by 2002:aa7:8690:0:b0:577:501c:c154 with SMTP id d16-20020aa78690000000b00577501cc154mr26194975pfo.6.1671056597125;
        Wed, 14 Dec 2022 14:23:17 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:38e2])
        by smtp.gmail.com with ESMTPSA id y62-20020a623241000000b005774d225353sm332470pfy.137.2022.12.14.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:23:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 14 Dec 2022 12:23:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
Message-ID: <Y5pM0ralEr6coT25@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
 <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
 <Y5mPigH1bPatXNeB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5mPigH1bPatXNeB@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, Dec 14, 2022 at 09:55:38AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 13, 2022 at 06:11:38PM -0800, Josh Don wrote:
> > Improving scheduling performance requires rapid iteration to explore
> > new policies and tune parameters, especially as hardware becomes more
> > heterogeneous, and applications become more complex. Waiting months
> > between evaluating scheduler policy changes is simply not scalable,
> > but this is the reality with large fleets that require time for
> > testing, qualification, and progressive rollout. The security angle
> > should be clear from how involved it was to integrate core scheduling,
> > for example.
> 
> Surely you can evaluate stuff on a small subset of machines -- I'm
> fairly sure I've had google and facebook people tell me they do just
> that, roll out the test kernel on tens to hundreds of thousand of
> machines instead of the stupid number and see how it behaves there.
>
> Statistics has something here I think, you can get a reliable
> representation of stuff without having to sample *everyone*.

Google guys probably have a lot to say here too and there may be many
commonalties, but here's how things are on our end.

We (Meta) experiment and debug at multiple levels. For example, when
qualifying a new kernel or feature, a common pattern we follow is
two-phased. The first phase is testing it on several well-known and widely
used workloads in a controlled experiment environment with fewer number of
machines, usually some dozens but can go one or two orders of magnitude
higher. Once that looks okay, the second phase is to gradually deploy while
monitoring system-level behaviors (crashes, utilization, latency and
pressure metrics and so on) and feedbacks from service owners.

We run tens of thousands of different workloads in the fleet and we try hard
to do as much as possible in the first phase but many of the difficult and
subtle problems are only detectable in the second phase. When we detect such
problems in the second phase, we triage the problem and pull back deployment
if necessary and then restart after fixing.

As the overused saying goes, quantity has a quality of its own. The
workloads become largely opaque because there are so many of them doing so
many different things for anyone from system side to examine each of them.
In many cases, the best and sometimes only visibility we get is statistical
- comparing two chunks of the fleet which are large enough for the
statistical signals to overcome the noise. That threshold can be pretty
high. Multiple hundreds of thousands of machines being used for a test set
isn't all that uncommon.

One complicating factor for the second phase is that we're deploying on
production fleet running live production workloads. Besides the obvious fact
that users become mightily unhappy when machines crash, there are
complicating matters like limits on how many and which machines can be
rebooted at any given time due to interactions with capacity and maintenance
which severely restricts how fast kernels can be iterated. A full sweep
through the fleet can easily take months.

Between a large number of opaque workloads and production constraints which
limit the type and speed of kernel iterations, our ability to experiment
with scheduling by modifying the kernel directly is severely limited. We can
do small things but trying out big ideas can become logistically
prohibitive.

Note that all these get even worse for public cloud operators. If we really
need to, we can at least find the service owner and talk with them. For
public cloud operators, the workloads are truly opaque.

There's yet another aspect which is caused by fleet dynamism. When we're
hunting down a scheduling misbehavior and want to test out specific ideas,
it can actually be pretty difficult to get back the same workload
composition after a reboot or crash. The fleet management layer will kick in
right away and the workloads get reallocated who-knows-where. This problem
is likely shared by smaller scale operations too. There are just a lot of
layers which are difficult to fixate across reboots and crashes. Even in the
same workload, the load balancer or dispatcher might behave very differently
for the machine after a reboot.

> I was given to believe this was a fairly rapid process.

Going back to the first phase where we're experimenting in a more controlled
environment. Yes, that is a faster process but only in comparison to the
second phase. Some controlled experiments, the faster ones, usually take
several hours to obtain a meaningful result. It just takes a while for
production workloads to start, jit-compile all the hot code paths, warm up
caches and so on. Others, unfortunately, take a lot longer to ramp up to the
degree whether it can be compared against production numbers. Some of the
benchmarks stretch multiple days.

With SCX, we can keep just keep hotswapping and tuning the scheduler
behavior getting results in tens of minutes instead of multiple hours and
without worrying about crashing the test machines, which often have
side-effects on the benchmark setup - the benchmarks are often performed
with shadowed production traffic using the same production software and they
get unhappy when a lot of machines crash. These problems can easily take
hours to resolve.

> Just because you guys have more machines than is reasonable, doesn't
> mean we have to put BPF everywhere.

There are some problems which are specific to large operators like us or
google for sure, but many of these problems are shared by other use cases
which need to test with real-world applications. Even on mobile devices,
it's way easier and faster to have a running test environment setup and
iterate through scheduling behavior changes without worrying about crashing
the machine than having to cycle and re-setup test setup for each iteration.

The productivity gain extends to individual kernel developers and
researchers. Just rebooting a server class hardware often takes upwards of
ten minutes, so most of us try to iterate as much on VMs as possible which
unfortunately doesn't work out too well for subtle performance issues. SCX
can easily cut down iteration time by an order of magnitude or more.

> Additionally, we don't merge and ship everybodies random debug patch
> either -- you're free to do whatever you need to iterate on your own and
> then send the patches that result from this experiment upstream. This is
> how development works, no?

We of course don't merge random debug patches which have limited usefulness
to a small number of use cases. However, we absolutely do ship code to
support debugging and development when the benefit outweights the cost, just
to list several examples - lockdep, perf, tracing, all the memory debug
options.

The argument is that given the current situation including hardware and
software landscape, the benefit of having BPF extensible scheduling
framework has enough benefits to justify the cost.

Thanks.

-- 
tejun
