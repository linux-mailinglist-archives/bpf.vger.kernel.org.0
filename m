Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891EF6C7118
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCWTfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCWTff (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 15:35:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAF71A662
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 12:35:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-544787916d9so411976897b3.13
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679600133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VcmchQqt9DaMxSLZ78hVIFyFO9YofibofDFlcn/C/A=;
        b=qcmPuY4UNpBr+P2ZKeYHu1R051ec4TvA2Clkq4ip2880X7aXBn2kafw99H0CzcQE8Y
         55btBqMovU8tiALDLxofgtxE/bZ0HgUAqQ7/uL9ivj3gfCrk6Yuh0oGKI0h3hhLcEY7P
         dflHLX+NDoqrZpncNEKvk51KUcHVmknk2JEAaqvkhAXJHpK54fIOZMMCA7hah18AZ/bd
         JkZhELoYu+zcuogS32m/qQmFm811rpAtxS23YU+81bGhLBg7rvz3YmoDRQyp8dCCDNhb
         lUPfwH5qF/cf+E5RouEWAGBRgF9zRDRmzCb9ikWcAdK0VJGHDe0vWwWNlwRMGXpXzXAs
         LaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VcmchQqt9DaMxSLZ78hVIFyFO9YofibofDFlcn/C/A=;
        b=sELqQx28ZY+x48epTcGRgUFwQbre3D3CukgCI1yqOKa4Gjha8mI1kJxGzcpJTkiqog
         CPUg/tse7rprbsEfCf4VhqS2u00z1tMqwOw8nmuY7d6aAWNWghDThts6fTiRN0e5QI+3
         jSFb/JqtasfyVb0+w8NVzBVj5GcQy3IEgNMfMNa4lkONnWOdfD2/poBgkwiHyl1AkOg0
         6rgVzoUZ/vLvEDLfT/3qFOEuklFngPSSStTHgQfPu+aS69PGACsP1pRXYn6WFzrkTmNW
         85jrGNjwxKDHBnyrxAApoYeZm8MqpmeugH8Y4acgI0/gn04jVcRReE6i5mjmgULPZCGo
         +1EQ==
X-Gm-Message-State: AAQBX9fXhzGggGZk9J/5yZt3Ep2vsOncL5OQbcVd/I1xDevjCmGhbhFz
        sZ4nCRllqLbwFD6aOEf9x9y+XJHCejcjFLS/gaY9Jg==
X-Google-Smtp-Source: AKy350ZXwVmW+8wxag0P4Y079RwZrC59m2sOfutsdJVuOG7wMxgYoQ6G9rfVZpnKi1K8J8jngBYLKTgqhGctfMls/iw=
X-Received: by 2002:a81:ef08:0:b0:545:883a:542c with SMTP id
 o8-20020a81ef08000000b00545883a542cmr1610295ywm.0.1679600131909; Thu, 23 Mar
 2023 12:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com> <20230323155613.GC739026@cmpxchg.org>
 <CAJD7tkZ7Dz9myftc9bg7jhiaOYcn7qJ+V4sxZ_2kfnb+k=zhJQ@mail.gmail.com>
 <20230323172732.GE739026@cmpxchg.org> <CAJD7tkbtHhzOytu3hfN8tjdAyNq0BZXYN8TEipS4NTApUzkL7w@mail.gmail.com>
In-Reply-To: <CAJD7tkbtHhzOytu3hfN8tjdAyNq0BZXYN8TEipS4NTApUzkL7w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Mar 2023 12:35:20 -0700
Message-ID: <CALvZod4z6F2Rr3prKdLqBuWUjippOBoLFw3QFFY7Bk=czm5iHg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe contexts
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, Mar 23, 2023 at 11:08=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Mar 23, 2023 at 10:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Thu, Mar 23, 2023 at 09:01:12AM -0700, Yosry Ahmed wrote:
> > > On Thu, Mar 23, 2023 at 8:56=E2=80=AFAM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> > > > > @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
> > > > >               return;
> > > > >
> > > > >       flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
> > > > > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> > > > > +     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);
> > > >
> > > > How is it safe to call this with may_sleep=3Dtrue when it's holding=
 the
> > > > stats_flush_lock?
> > >
> > > stats_flush_lock is always called with trylock, it is only used today
> > > so that we can skip flushing if another cpu is already doing a flush
> > > (which is not 100% correct as they may have not finished flushing yet=
,
> > > but that's orthogonal here). So I think it should be safe to sleep as
> > > no one can be blocked waiting for this spinlock.
> >
> > I see. It still cannot sleep while the lock is held, though, because
> > preemption is disabled. Make sure you have all lock debugging on while
> > testing this.
>
> Thanks for pointing this out, will do.
>
> >
> > > Perhaps it would be better semantically to replace the spinlock with
> > > an atomic test and set, instead of having a lock that can only be use=
d
> > > with trylock?
> >
> > It could be helpful to clarify what stats_flush_lock is protecting
> > first. Keep in mind that locks should protect data, not code paths.
> >
> > Right now it's doing multiple things:
> >
> > 1. It protects updates to stats_flush_threshold
> > 2. It protects updates to flush_next_time
> > 3. It serializes calls to cgroup_rstat_flush() based on those ratelimit=
s
> >
> > However,
> >
> > 1. stats_flush_threshold is already an atomic
> >
> > 2. flush_next_time is not atomic. The writer is locked, but the reader
> >    is lockless. If the reader races with a flush, you could see this:
> >
> >                                         if (time_after(jiffies, flush_n=
ext_time))
> >         spin_trylock()
> >         flush_next_time =3D now + delay
> >         flush()
> >         spin_unlock()
> >                                         spin_trylock()
> >                                         flush_next_time =3D now + delay
> >                                         flush()
> >                                         spin_unlock()
> >
> >    which means we already can get flushes at a higher frequency than
> >    FLUSH_TIME during races. But it isn't really a problem.
> >
> >    The reader could also see garbled partial updates, so it needs at
> >    least READ_ONCE and WRITE_ONCE protection.
> >
> > 3. Serializing cgroup_rstat_flush() calls against the ratelimit
> >    factors is currently broken because of the race in 2. But the race
> >    is actually harmless, all we might get is the occasional earlier
> >    flush. If there is no delta, the flush won't do much. And if there
> >    is, the flush is justified.
> >
> > In summary, it seems to me the lock can be ditched altogether. All the
> > code needs is READ_ONCE/WRITE_ONCE around flush_next_time.
>
> Thanks a lot for this analysis. I agree that the lock can be removed
> with proper READ_ONCE/WRITE_ONCE, but I think there is another purpose
> of the lock that we are missing here.
>
> I think one other purpose of the lock is avoiding a thundering herd
> problem on cgroup_rstat_lock, particularly from reclaim context, as
> mentioned by the log of  commit aa48e47e3906 ("memcg: infrastructure
> to flush memcg stats").
>
> While testing, I did notice that removing this lock indeed causes a
> thundering herd problem if we have a lot of concurrent reclaimers. The
> trylock makes sure we abort immediately if someone else is flushing --
> which is not ideal because that flusher might have just started, and
> we may end up reading stale data anyway.
>
> This is why I suggested replacing the lock by an atomic, and do
> something like this if we want to maintain the current behavior:
>
> static void __mem_cgroup_flush_stats(void)
> {
>     ...
>     if (atomic_xchg(&ongoing_flush, 1))
>         return;
>     ...
>     atomic_set(&ongoing_flush, 0)
> }
>
> Alternatively, if we want to change the behavior and wait for the
> concurrent flusher to finish flushing, we can maybe spin until
> ongoing_flush goes back to 0 and then return:
>
> static void __mem_cgroup_flush_stats(void)
> {
>     ...
>     if (atomic_xchg(&ongoing_flush, 1)) {
>         /* wait until the ongoing flusher finishes to get updated stats *=
/
>         while (atomic_read(&ongoing_flush) {};
>         return;
>     }
>     /* flush the stats ourselves */
>     ...
>     atomic_set(&ongoing_flush, 0)
> }
>
> WDYT?

I would go with your first approach i.e. no spinning.
