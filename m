Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F046C5E95
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 06:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCWFPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWFPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 01:15:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA311F5CF
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:15:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so81700763edb.9
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679548542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiBnEdYy6Aid4dyiIRb9ptP+TZS4JSWAxv3bvFBhfG4=;
        b=KjytUVYDmXDoW1kHgbDCbvCLYfxK+63b9aN2H7qBDtgtsxUI5OrZu53Lwl+GZnw0aJ
         01ArWTb9RVmWC495n9DxCFBjmF0qY/lqyeeIAVSiAn/aUnYfvmYR3QRULUpzpOBma5HJ
         1+ytefxZiq0W1QKk5BPSDY7oYrkC4lDmQhAqbKsHhetsX6cK5fJcoZErFKGhWuRXhxyI
         p2BcFq4WozSFWYwoA28WxVcjRBVpqMyGmKeVHUGeck+Via4SQbj3gRnZsH2+wmdGGYqJ
         m3bky+4aHeeGT/A27qicrKyfuYVue8fxY0dpOhHe+LAcLJLzrkBD+xp1/xz5qYKXjWiw
         GJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiBnEdYy6Aid4dyiIRb9ptP+TZS4JSWAxv3bvFBhfG4=;
        b=E4Mbp9GFdKSLM0+cYX2W7x+xXMPnpwkwTJwW8uaXwuuaASk3VO+RcTEArsp9z+jdGt
         SIsYlur/mmQhlLzEEUamB6Z/uKQ1qUv0YJvlcyoZpy/EPgjF80VXPFLAb6ptlV4lPJP0
         +vdcwgbjaAvw+pLmiNZSQDyhBL43Al/FTm7/wwQWa1926jMjUcs683bqV+c205vreqHI
         myS1B3puSqrVaG6K1XOoVysMWn4EB44DJXEs2s1AoVMzvkxgSqzNGobEK/4Njvp8AyY9
         EUSmbGH9JjlvHCwUd/ni92LRJzbUagM6nJ6IlXmaFZ1xa2QhYdT9D3GYyiruleGSm44W
         IMEw==
X-Gm-Message-State: AO0yUKXQRmxoKpBELQeLNFp61AnsDXGr4I4So/qivWAZO1SXwhK8kSzV
        wXoFoMRyt42+X0lXG4WKoQeuzQKdRZ2QjG5CEjtCZw==
X-Google-Smtp-Source: AK7set9TkrVPoLwQATRu8u0oZvp5iDQj4vlxVo1OOqJOjETFOQd+b3oLzlntqCqCIUZCsCp2Y1/BhRjHZ4ki+1aUb4w=
X-Received: by 2002:a17:906:aac9:b0:927:912:6baf with SMTP id
 kt9-20020a170906aac900b0092709126bafmr4297724ejb.15.1679548542233; Wed, 22
 Mar 2023 22:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
In-Reply-To: <CALvZod7e7dMmkhKtXPAxmXjXQoTyeBf3Bht8HJC8AtWW93As3g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Mar 2023 22:15:05 -0700
Message-ID: <CAJD7tkbziGh+6hnMysHkoNr_HGBKU+s1rSGj=gZLki0ALT-jLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

On Wed, Mar 22, 2023 at 9:29=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
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
> >
> > If the caller of rstat flushing needs interrupts to be disabled, it's u=
p
> > to them to decide that, and it should be fine to hold the global rstat
> > lock with interrupts disabled. There is currently a single context that
> > may invoke rstat flushing with interrupts disabled, the
> > mem_cgroup_flush_stats() call in mem_cgroup_usage(), if called from
> > mem_cgroup_threshold().
> >
> > To make it safe to hold the global rstat lock with interrupts enabled,
> > make sure we only flush from in_task() contexts. The side effect of tha=
t
> > we read stale stats in interrupt context, but this should be okay, as
> > flushing in interrupt context is dangerous anyway as it is an expensive
> > operation, so reading stale stats is safer.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Couple of questions:
>
> 1. What exactly is cgroup_rstat_lock protecting? Can we just remove it
> altogether?

I believe it protects the global state variables that we flush into.
For example, for memcg, it protects mem_cgroup->vmstats.

I tried removing the lock and allowing concurrent flushing on
different cpus, by changing mem_cgroup->vmstats to use atomics
instead, but that turned out to be a little expensive. Also,
cgroup_rstat_lock is already contended by different flushers
(mitigated by stats_flush_lock on the memcg side). If we remove it,
concurrent flushers contend on every single percpu lock instead, which
also seems to be expensive.

> 2. Are we really calling rstat flush in irq context?

I think it is possible through the charge/uncharge path:
memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage(). I
added the protection against flushing in an interrupt context for
future callers as well, as it may cause a deadlock if we don't disable
interrupts when acquiring cgroup_rstat_lock.

> 3. The mem_cgroup_flush_stats() call in mem_cgroup_usage() is only
> done for root memcg. Why is mem_cgroup_threshold() interested in root
> memcg usage? Why not ignore root memcg in mem_cgroup_threshold() ?

I am not sure, but the code looks like event notifications may be set
up on root memcg, which is why we need to check thresholds.

Even if mem_cgroup_threshold() does not flush memcg stats, the purpose
of this patch is to make sure the rstat flushing code itself is not
disabling interrupts; which it currently does for any unsleepable
context, even if it is interruptible.
