Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0BB6C78B6
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 08:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCXHWu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCXHWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 03:22:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7161AE
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 00:22:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so4126033edb.11
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa396lb8MjMOl888rXohQoljyuvFkmmjAMpaedz2iKQ=;
        b=KJ9iz5Uxy+UE7eTmfuZpdee6ope6aJEfkespR2fZMv6ZHIq8x8lW4vifO9yR+IS7pd
         AK7dGPutrSQ13hJJ80evRzpXtgobfZFo8jXuTzRATpMeqGO6i8D5NSa73p0qsx5i481+
         7yXiGgxPWmcaJdwbUyT1PbP3K0ZyFQ7Al79kpt3c+Idj9EX40zqvfzZ8aXiS7pBZAi5c
         qDNLiwlOYnW0tVo8pGG8bbNsjTBTTctF7v1u8gW1K9bJA0CKfZjEf/5jsWat5ZudO5jG
         cU9nAY6htLcFCArHxPUvuBAUnt26YcyoPsjONXhbMoH+B0T69pLrtxIpj5GEcP1xxW3T
         K9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa396lb8MjMOl888rXohQoljyuvFkmmjAMpaedz2iKQ=;
        b=dET+43rg3nTD/TyZB3Y16z8/ZM7JYLxB8yAIkIgpvsRisU17qoNuJXMJlt50uPW0VI
         9pJ0LINOnvhtR5thFwmV2GVPaiAQba/Yfxs6WG/3Re7/5zI5IljY4s2gYZnlRfFoxvmb
         LAtYPgrwvK8T6Epuqtd0M4Kd3JYZZuPIBWyzkZ9joIDyn+v3IQm1Qa7l7h9sA2rhn0pu
         XzchqJD4zWnFNMlf/AOsx1PpCNIoLizZhFrVSH/yGfI6rnJMVNeHy2gq+ZflglbWU3Pu
         CZmKpVwmCqh61SRW7ukurkwkEdg9tCkviQN7XPvAnh7PbFRLRU37f6A9IFr3xi6AirCS
         9v1Q==
X-Gm-Message-State: AO0yUKXfScpVyodKmfvG+koTiVC8wZlLYZ4xqDpdO2+1yDU8NnWO1oJO
        eQwAnUdwbXrUypHlD6Rp3oup2RkHHBZ3B21nAkUaPg==
X-Google-Smtp-Source: AK7set9nDooOE3Uv4xSdzevtlYQN6Wrt2NapQojoPuIK5bxgo1JQyfUpt3JH2yw9C0xTBXIvxswIEM39+kTwiiQaVDw=
X-Received: by 2002:a05:6402:540c:b0:4fb:e069:77ac with SMTP id
 ev12-20020a056402540c00b004fbe06977acmr6398957edb.0.1679642566177; Fri, 24
 Mar 2023 00:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
In-Reply-To: <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Mar 2023 00:22:09 -0700
Message-ID: <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 6:39=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Mar 23, 2023 at 04:00:31AM +0000, Yosry Ahmed wrote:
> > Currently, when sleeping is not allowed during rstat flushing, we hold
> > the global rstat lock with interrupts disabled throughout the entire
> > flush operation. Flushing in an O(# cgroups * # cpus) operation, and
> > having interrupts disabled throughout is dangerous.
> >
> > For some contexts, we may not want to sleep, but can be interrupted
> > (e.g. while holding a spinlock or RCU read lock). As such, do not
> > disable interrupts throughout rstat flushing, only when holding the
> > percpu lock. This breaks down the O(# cgroups * # cpus) duration with
> > interrupts disabled to a series of O(# cgroups) durations.
> >
> > Furthermore, if a cpu spinning waiting for the global rstat lock, it
> > doesn't need to spin with interrupts disabled anymore.
>
> I'm generally not a fan of big spin locks w/o irq protection. They too of=
ten
> become a source of unpredictable latency spikes. As you said, the global
> rstat lock can be held for quite a while. Removing _irq makes irq latency
> better on the CPU but on the other hand it makes a lot more likely that t=
he
> lock is gonna be held even longer, possibly significantly so depending on
> the configuration and workload which will in turn stall other CPUs waitin=
g
> for the lock. Sure, irqs are being serviced quicker but if the cost is mo=
re
> and longer !irq context multi-cpu stalls, what's the point?
>
> I don't think there's anything which requires the global lock to be held
> throughout the entire flushing sequence and irq needs to be disabled when
> grabbing the percpu lock anyway, so why not just release the global lock =
on
> CPU boundaries instead? We don't really lose anything significant that wa=
y.
> The durations of irq disabled sections are still about the same as in the
> currently proposed solution at O(# cgroups) and we avoid the risk of hold=
ing
> the global lock for too long unexpectedly from getting hit repeatedly by
> irqs while holding the global lock.

Thanks for taking a look!

I think a problem with this approach is that we risk having to contend
for the global lock at every CPU boundary in atomic contexts. Right
now we contend for the global lock once, and once we have it we go
through all CPUs to flush, only having to contend with updates taking
the percpu locks at this point. If we unconditionally release &
reacquire the global lock at every CPU boundary then we may contend
for it much more frequently with concurrent flushers.

On the memory controller side, concurrent flushers are already held
back to avoid a thundering herd problem on the global rstat lock, but
flushers from outside the memory controller can still compete together
or with a flusher from the memory controller. In this case, we risk
contending the global lock more and concurrent flushers taking a
longer period of time, which may end up causing multi-CPU stalls
anyway, right? Also, if we keep _irq when spinning for the lock, then
concurrent flushers still need to spin with irq disabled -- another
problem that this series tries to fix.

This is particularly a problem for flushers in atomic contexts. There
is a flusher in mem_cgroup_wb_stats() that flushes while holding
another spinlock, and a flusher in mem_cgroup_usage() that flushes
with irqs disabled. If flushing takes a longer period of time due to
repeated lock contention, it affects such atomic context negatively.

I am not sure how all of this matters in practice, it depends heavily
on the workloads and the configuration like you mentioned. I am just
pointing out the potential disadvantages of reacquiring the lock at
every CPU boundary in atomic contexts.

>
> Thanks.
>
> --
> tejun
