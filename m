Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80764C20F
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 03:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLNCAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 21:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLNCAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 21:00:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07913D41
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:00:32 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e126so1071391pgc.6
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ4CSVZZ+NoydkcJKVQO6YNOhus6JhiYOMFjQ8jjtjU=;
        b=m/SKUa27vVBjK1uJ2X221o05KhZ9jtihYba01Ju4Ef9NiQruOgsHzM/Kf1zncuPTTX
         5WeMUgP2qqB8oX/4aP0MqYeAjg3qs/eM20mosQEYuuuFZnP4JWFMeKxBkG3TuR5NK4vu
         qFImpcXkZ2530uslsCBedMtoQkMTCMSn577sVPwZQ4PtS7Ixp2wQrQhf3JPXBZeWg99f
         xhPEhRvSnr9JK20Gn1Xy65nImGw11v7zxUokfH2gN5b0GSEXW//gCO0MyExz+vTrRPRC
         Muj85AAhNQdYKoc9aj4gGiO9y1whE7GOJaJob8+6UkimVCJbodt1gz6mB2zEZSbiY6zc
         Q58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ4CSVZZ+NoydkcJKVQO6YNOhus6JhiYOMFjQ8jjtjU=;
        b=SYo7ic4OPfS1Jykcc93fNKW86aEfKnjVXIILKJdzcXTjWqI5rWG35HeGF3Qv5HS+bO
         IxDrWSThuIPkX91VOqgEz5+vxwmo/Hd20+qQVChtfC8Kmj3d+pWgVYdZD15W4CYk7tAR
         UA+Ds4LheVB/KfoxSme10R8bm1ZAfZ8JNOQAlYUa7Bwo8Ti/74vfyfhidccdZCQz/cGF
         JeSdpn8j6sd3bF0iPUPPI44wgcoqF5qbThYW6XI7SHfSasCmgL8pfbJtmY/761QDuihJ
         3xl9LgQuN1kbow/d/ybIhC+qiZDdZx/EABysbvO4j/YP3mPS0A1Pb6wqlnwEmuAVi4MO
         IIqQ==
X-Gm-Message-State: ANoB5pkabxfT+/kovE42k2BNL8JJ7XJLctR/SdW5LKmIqCvDRwa8GG33
        wyaxXclbyvGchazpiPXv3gZBE+++QAhk2a+0MAHzgw==
X-Google-Smtp-Source: AA0mqf67HjB2QuUnPoIyEET5gO5fYZFekKta2m+eJepPSJ0NzH0Lf7dZNLdzf8CBGYYlGHlbu/mQbGXA6ehU1ULXrlQ=
X-Received: by 2002:a63:1247:0:b0:476:ed2a:6216 with SMTP id
 7-20020a631247000000b00476ed2a6216mr77727663pgs.556.1670983231384; Tue, 13
 Dec 2022 18:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20221130082313.3241517-1-tj@kernel.org> <20221130082313.3241517-32-tj@kernel.org>
 <Y5c0qEuyn8cAvLGQ@hirez.programming.kicks-ass.net> <CABk29Nu5WiCmhNN2jZrTShELbCDOYUziUeW5xojkwB83R+VzEQ@mail.gmail.com>
 <Y5hiPqaT6UqaUcGK@hirez.programming.kicks-ass.net>
In-Reply-To: <Y5hiPqaT6UqaUcGK@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 13 Dec 2022 18:00:19 -0800
Message-ID: <CABk29Nu0JJ6xY_2SL0Y=iWstmoiRnRRnQ+Xvm3t_oU4sp72vpg@mail.gmail.com>
Subject: Re: [PATCH 31/31] sched_ext: Add a rust userspace hybrid example scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > and ignoring
> > the specifics of this example, the UMCG and sched_ext work are
> > complementary, but not mutually exclusive. UMCG is about driving
> > cooperative scheduling within a particular application. UMCG does not
> > have control over or react to external preemption,
>
> It can control preemption inside the process, and if you have the degree
> of control you need to make the whole BPF thing work, you also have the
> degree of control to ensure you only run the one server task on a CPU
> and all that no longer matters because there's only the process and you
> control preemption inside that.

To an extent yes, but this doesn't extend to the case where cpu is
overcommitted. Even if not by other applications, then responding to
preemption by, for example, kthreads (necessary for microsecond scale
workloads). But in general the common case is interference from other
applications, something which is handled by a system level scheduler
like sched_ext. The application vs system level control is an
important distinction here.

> > nor does it make thread placement decisions.
>
> It can do that just fine -- inside the process. UMCG has full control
> over which server task a worker task is associated with, then run a
> single server task per CPU and have them pinned and you get full
> placement control.

Again, this doesn't really scale past single server per cpu. It is not
feasible to partition systems in this way due to the loss of
efficiency.

> > sched_ext is considering things more at
> > the system level: arbitrating fairness and preemption between
> > processes, deciding when and where threads run, etc., and also being
> > able to take application-specific hints if desired.
>
> sched_ext does fundamentally not compose, you cannot run two different
> schedulers for two different application stacks that happen to co-reside
> on the same machine.

We're actually already developing a framework (and plan to share) to
support composing an arbitrary combination of schedulers. Essentially,
a "scheduler of schedulers". This supports the case, for example, of a
system that runs most tasks under some default SCX scheduler, but
allows a particular application or group of applications to utilize a
bespoke SCX scheduler of their own.

> sched_ext also sits at the very bottom of the class stack (it more or
> less has to) the result is that in order to use it at all, you have to
> have control over all runnable tasks in the system (a stray CFS task
> would interfere quite disastrously) but that is exactly the same
> constraint you need to make UMCG work.

UMCG still works when mixed with other tasks. You're specifying which
threads of your application you want running, but no guarantees are
made that they'll run right now if the system has other work to do.

SCX vs CFS is a more interesting story. Yes it is true that a single
CFS task could hog a cpu, but since SCX is managing things at a system
level, we feel that this is something that should be handled by system
administration. You shouldn't expect to mix cpu bound CFS tasks in the
same partition as threads running under SCX with good results.

> Conversely, it is very hard to use the BPF thing to do what UMCG can do.
> Using UMCG I can have a SCHED_DEADLINE server implement a task based
> pipeline schedule (something that's fairly common and really hard to
> pull off with just SCHED_DEADLINE itself).

UMCG and SCX are solving different problems though. An application can
decide execution order or control internal preemption via UMCG, while
SXC arbitrates allocation of system resources over time.

And, conversely, SCX can do things very difficult or impossible with
UMCG. For example, implementing core scheduling. Guaranteeing
microsecond scale tail latency. Applying a new scheduling algorithm
across multiple independent applications.

> Additionally, UMCG naturally works with things like Proxy Execution,
> seeing how the server task *is* a proxy for the current active worker
> task.

Proxy execution should also work with SCX; the enqueue/dequeue
abstraction can still be used to allow the SCX scheduler to select the
proxy.
