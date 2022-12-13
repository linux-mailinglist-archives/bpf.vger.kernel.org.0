Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF664BBA5
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiLMSMN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiLMSMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:12:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2923EAC;
        Tue, 13 Dec 2022 10:12:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4488657pjt.0;
        Tue, 13 Dec 2022 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0m3R6rCXT8yOLMVNuxnRvaS71+8kQVchp2Qkxuqcwfk=;
        b=n86cgql6kHCsrBKnQ4bscxkuG73FtW7lOCaFQ6Qb3fwnYKycpXfEY8A7rirgqseVtc
         QfQu/NdnPL6YTdczS7W/vRmc6CwCs01yeC4vj0RLteIAPgarJ3HLlreh/ACQiIxJQaoA
         uYSF5JycwpdVSvXhjE+bGYOuq5Tj8IAZ053npUPYDOkNZvqNdhUCi59NzYnCpuphVY8P
         ULuHUzSjTDX4nbdtcP4fs06cFWkDmUqhWnPSbszVYfvuvWYyChRZtJDYmgrZsdpBqd44
         LKEFxikap3qjUVYnTvVwP15ZOpiBxLNrC1QmA3I6A9nJhbApuG/H2leZmcG8PnUT7tA1
         UeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m3R6rCXT8yOLMVNuxnRvaS71+8kQVchp2Qkxuqcwfk=;
        b=lJDq2ns/ENkljx56jO/mbXAHKdSJqMUS1Jztm36PAhqE8eIZBnR4Eqdh58fpam/GGB
         opPPgyb/lSiBgxTy+4QTKUpj+J8ztZ8JNqF487k/7AfY5q/4Wnvbl7M8q0lfdPfzEt7I
         sf3H8OKg4JB4hw6atVxgszl7ZCwFGmvivMxnA26NUzN9qPcXIOFnGdM0MzRdYGZefMQJ
         RopN+p6LceiYI75I7t6TtZ4UsH3MlhD0EHXkyrBXcVgZIke8ZSo5p2Aew1Kr6gR1tksw
         9XYJmJ838jq2GP2ia9ppoN65rmkPLrqB8cioQ90aus6EiFea8AdL+JGS0ePmk63HzoiT
         iIRg==
X-Gm-Message-State: ANoB5pkiowOQZncgCAev+RQ2UWiafoTeWQ5fPyNhHYxnSeQxAT0WRoXz
        CTqh7U3eyUcP8zfwuU9gdj8=
X-Google-Smtp-Source: AA0mqf4sox4u+FcwG0+cMcPftuNagVjj7o32wteyPgZTvcm1x2qcdb7XQmevivDgZ4OgWumoJOIVOA==
X-Received: by 2002:a17:90b:19d7:b0:219:ccbc:ed8e with SMTP id nm23-20020a17090b19d700b00219ccbced8emr21746861pjb.20.1670955125497;
        Tue, 13 Dec 2022 10:12:05 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a1b0800b0021937b2118bsm7437756pjq.54.2022.12.13.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:12:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 13 Dec 2022 08:12:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 14/31] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Y5jAc/Gs4gVRzkDe@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-15-tj@kernel.org>
 <Y5ckYyz14bxCvv40@hirez.programming.kicks-ass.net>
 <Y5eeGMpr/SuyGBQO@slm.duckdns.org>
 <Y5haDh3sYUFcXkBx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5haDh3sYUFcXkBx@hirez.programming.kicks-ass.net>
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

On Tue, Dec 13, 2022 at 11:55:10AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 12, 2022 at 11:33:12AM -1000, Tejun Heo wrote:
> 
> > > But this.. afaict that means that:
> > > 
> > >  - the whole EXT thing is incompatible with SCHED_CORE
> > 
> > Can you expand on why this would be? I didn't test against SCHED_CORE, so am
> > sure things might be broken but can't think of a reason why it'd be
> > fundamentally incompatible.
> 
> For starters, SCHED_CORE doesn't use __pick_next_task() (much). But I

SCX implements ->pick_task() and the CORE selection path calls ->balance()
and then ->pick_task(). That should work, right? Will test later.

> think you're going to have more trouble with prio_less() (which is the
> 3rd implementation of the scheduling function :/)

Can't it take the same approach as CFS? The BPF scheduler is gonna be the
one defining the relative priorities among SCX tasks, so that's where the
decision belongs.

> > >  - the whole EXT thing can be trivially starved by the presence of a
> > >    single CFS/BATCH/IDLE task.
> > 
> > It's a simliar situation w/ RT vs. CFS, which is resolved via RT having
> > starvation avoidance.
> 
> That is a horrible situation as is, FIFO/RR are very crap scheduling
> policies for a number of reasons but we're stuck with them due to
> history and POSIX :-(, that is not something you should justify anything
> with.
> 
> In fact, it should be an example of what to avoid.
> 
> Specifically, FIFO/RR fail at the fundamentals of OS
> abstractions -- they provide neither resource distribution nor
> isolation.
> 
> > Here, the way it's handled is a bit different, SCX has
> > a watchdog mechanism implemented in "[PATCH 18/31] sched_ext: Implement
> > runnable task stall watchdog", so if SCX tasks hang for whatever reason
> > including being starved by CFS, it will get aborted and all tasks will be
> > handed back to CFS. IOW, it's treated like any other BPF scheduler errors
> > that can lead to stalls and recovered the same way.
> 
> That all sounds quite terrible.. :/

The main source of difference is that we can't implicitly trust the BPF
scheduler and if it malfunctions or on user request, the system should
always be recoverable, so there are some extra things which are inherently
necessary to support that.

> When the scheduler isn't available it should be an error to switch a
> task to the policy, when there are tasks in the policy, it must not go
> away.

Yeah, this part is an interface design choice. Currently, when the BPF
scheduler fails or is not present for any reason, SCX falls back to CFS
because that seemed like the least invasive way to go about it, but it's
trivial to just let SCX do dumb FIFO scheduling with the global DSQ instead,
which in fact is already used during transition to guarantee forward
progress.

Thanks.

-- 
tejun
