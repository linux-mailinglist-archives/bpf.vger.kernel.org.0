Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83F455AF7C
	for <lists+bpf@lfdr.de>; Sun, 26 Jun 2022 08:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiFZGim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jun 2022 02:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiFZGil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jun 2022 02:38:41 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B212AB9
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 23:38:37 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o13so6133944vsn.4
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc5mBUBFwgKTrRRt4LSadMoNNHHSgUJ0SJnmHF/RnUM=;
        b=SCQdUkdAQyZKPhKIg0KMj97v0BAdENB4f/gvqtXUN/ZCSMWTZI44JqvQVnKNibdHzc
         DjxW4IXJE2QaCCpYQXM7vHopn+X2/ODjSBXlKcf+dP7iOusEy8k7/ahemi/JREAll2Dm
         qR9X8c2iDfFnJTURz7kvBsOun+kVIQFLWnCWFrVuIiybhEB9VNQGjA1GBX5OpjA4l4Ph
         rOTcOYrq+vbXy1PMQMnH52dr6o3RiOiLBBsVTZduaQUBy+Bz+kBg9tZfzIFhhImEID5V
         Y1mSdSBI9NmWYOWX+Lz/SfHDOkgGasq7g9LOsQ+V83h0oWx4khXkbqnrqLX6C7yNRiOM
         82dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc5mBUBFwgKTrRRt4LSadMoNNHHSgUJ0SJnmHF/RnUM=;
        b=dLnvGnSQttYKYXVeKzBlZQbCPcCdIeMwyPlPSY+fncU2dZdBjQnWqi7+X/ksNXW103
         yi849tDc9FkQw8pAI7Cgy2oAJGD/ifECJSaKGPaUFdcbcccQvrAHm7ceaunQAAUouFjN
         zcyLQbnYPvG+Gtz3+/OuedO/R+ND0Y65X7WFtVuKnnQhu2Qj80VgHOtcYEzPsJA8XjHr
         gfj9RkngkrYAjldsP2zYKAMy1IAK0VNMqQ//OhSI4QxthcMmLAOTOO9DlZG8MN03HoM1
         +KQQedJHkps2Ms57RDofSNTdhh+GCnYBA2qerrVLaVO13fiI6kNK8rm3eVd6izj9UxcS
         LK3Q==
X-Gm-Message-State: AJIora+d6v0p9kNUv9oPpH7r6x9AK8CwSDiFiyNbweZlU09WIGGPM7Ag
        IjIrvra8jb5zYwNbG6fN1DYJ0p7HANFTuWkZoFs=
X-Google-Smtp-Source: AGRyM1tQ+6wylGo8I9U2Mjz5xtOOyfaXCnOY6/3jOO7JWo1UPg2W3rnzjHdNKMUP1xPgdtYuGNyIvjVHoKWbcOdC904=
X-Received: by 2002:a67:1945:0:b0:355:ab65:9db3 with SMTP id
 66-20020a671945000000b00355ab659db3mr2753358vsz.22.1656225516977; Sat, 25 Jun
 2022 23:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
 <YrfSXVDONpxcUDI+@castle> <YrfTR2nfU1ze/sTS@castle>
In-Reply-To: <YrfTR2nfU1ze/sTS@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 26 Jun 2022 14:38:00 +0800
Message-ID: <CALOAHbBuA=Nn=-kxXcETr1MvEnaJ1BqNgAHQ5a9Z9vJcR=dbXw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 26, 2022 at 11:32 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Sat, Jun 25, 2022 at 08:28:37PM -0700, Roman Gushchin wrote:
> > On Sat, Jun 25, 2022 at 11:26:13AM +0800, Yafang Shao wrote:
> > > On Thu, Jun 23, 2022 at 11:29 AM Roman Gushchin
> > > <roman.gushchin@linux.dev> wrote:
> > > >
> > > > On Sun, Jun 19, 2022 at 03:50:22PM +0000, Yafang Shao wrote:
> > > > > After switching to memcg-based bpf memory accounting, the bpf memory is
> > > > > charged to the loader's memcg by default, that causes unexpected issues for
> > > > > us. For instance, the container of the loader may be restarted after
> > > > > pinning progs and maps, but the bpf memcg will be left and pinned on the
> > > > > system. Once the loader's new generation container is started, the leftover
> > > > > pages won't be charged to it. That inconsistent behavior will make trouble
> > > > > for the memory resource management for this container.
> > > > >
> > > > > In the past few days, I have proposed two patchsets[1][2] to try to resolve
> > > > > this issue, but in both of these two proposals the user code has to be
> > > > > changed to adapt to it, that is a pain for us. This patchset relieves the
> > > > > pain by triggering the recharge in libbpf. It also addresses Roman's
> > > > > critical comments.
> > > > >
> > > > > The key point we can avoid changing the user code is that there's a resue
> > > > > path in libbpf. Once the bpf container is restarted again, it will try
> > > > > to re-run the required bpf programs, if the bpf programs are the same with
> > > > > the already pinned one, it will reuse them.
> > > > >
> > > > > To make sure we either recharge all of them successfully or don't recharge
> > > > > any of them. The recharge prograss is divided into three steps:
> > > > >   - Pre charge to the new generation
> > > > >     To make sure once we uncharge from the old generation, we can always
> > > > >     charge to the new generation succeesfully. If we can't pre charge to
> > > > >     the new generation, we won't allow it to be uncharged from the old
> > > > >     generation.
> > > > >   - Uncharge from the old generation
> > > > >     After pre charge to the new generation, we can uncharge from the old
> > > > >     generation.
> > > > >   - Post charge to the new generation
> > > > >     Finnaly we can set pages' memcg_data to the new generation.
> > > > > In the pre charge step, we may succeed to charge some addresses, but fail
> > > > > to charge a new address, then we should uncharge the already charged
> > > > > addresses, so another recharge-err step is instroduced.
> > > > >
> > > > > This pachset has finished recharging bpf hash map. which is mostly used
> > > > > by our bpf services. The other maps hasn't been implemented yet. The bpf
> > > > > progs hasn't been implemented neither.
> > > >
> > > > Without going into the implementation details, the overall approach looks
> > > > ok to me. But it adds complexity and code into several different subsystems,
> > > > and I'm 100% sure it's not worth it if we talking about a partial support
> > > > of a single map type. Are you committed to implement the recharging
> > > > for all/most map types and progs and support this code in the future?
> > > >
> > >
> > > I'm planning to support it for all map types and progs. Regarding the
> > > progs, it seems that we have to introduce a new UAPI for the user to
> > > do the recharge, because there's no similar reuse path in libbpf.
> > >
> > > Our company is a heavy bpf user. We have many bpf programs running on
> > > our production environment, including networking bpf,
> > > tracing/profiling bpf, and some other bpf programs which are not
> > > supported in upstream kernel, for example we're even trying the
> > > sched-bpf[1] proposed by you (and you may remember that I reviewed
> > > your patchset).  Most of the networking bpf, e.g. gateway-bpf,
> > > edt-bpf, loadbalance-bpf, veth-bpf, are pinned on the system.
> > >
> > > It is a trend that bpf will be introduced in more and more subsystems,
> > > and thus it is no doubt that a bpf patchset will involve many
> > > subsystems.
> > >
> > > That means I will be continuously active in these areas in the near
> > > future,  several years at least.
> >
> > Ok, I'm glad to hear this. I highly recommend to cover more map types
> > and use cases in next iterations of the patchset.
> >
> > >
> > > [1]. https://lwn.net/Articles/869433/
> > >
> > > > I'm still feeling you trying to solve a userspace problem in the kernel.
> > >
> > > Your feeling can be converted to a simple question: is it allowed to
> > > pin a bpf program by a process running in a container.  The answer to
> > > this simple question can help us to understand whether it is a user
> > > bug or a kernel bug.
> > >
> > > I think you will agree with me that there's definitely no reason to
> > > refuse to pin a bpf program by a containerized process.  And then we
> > > will find that the pinned-bpf-program doesn't cooperate well with
> > > memcg.  A kernel feature can't work together with another kernel
> > > feature, and there's not even an interface provided to the user to
> > > adjust it. The user either doesn't pin the bpf program or disable
> > > kmemcg.   Isn't it a kernel bug ?
> > >
> > > You may have a doubt why these two features can't cooperate.  I will
> > > explain it in detail.  That will be a long story.
> > >
> > > It should begin with why we introduce bpf pinning. We pin it because
> > > sometimes the lifecycle of a user application is different with the
> > > bpf program, or there's no user agent at all.  In order to make it
> > > simple, I will take the no-user-agent (agent exits after pinning bpf
> > > program) case as an example.
> > >
> > > Now thinking about what will happen if the agent which pins the bpf
> > > program has a memcg. No matter if the agent destroys the memcg or not
> > > once it exits, the memcg will not disappear because it is pinned by
> > > the bpf program. To make it easy, let's assume the memcg isn't being
> > > destroyed, IOW, it is online.
> > >
> > > An online memcg is not populated, but it is still being remote charged
> > > (if it is a non-preallocate bpf map), that looks like a ghost. Now we
> > > will look into the details to find what will happen to this ghost
> > > memcg.
> > >
> > > If this ghost memcg is limited, it will introduce many issues AFAICS.
> > > Firstly, the memcg will be force charged[2], and I think I don't need
> > > to explain the reason to you.
> > > Even worse is that it force-charges silently without any event,
> > > because it comes from,
> > >         if (!gfpflags_allow_blocking(gfp_mask))
> > >             goto nomem;
> > > And then all memcg events will be skipped. So at least we will
> > > introduce a force-charge event,
> > >     force:
> > > +      memcg_memory_event(mem_over_limit, MEMCG_FORCE_CHARGE);
> > >         page_counter_charge(&memcg->memory, nr_pages);
> >
> > This is actually a good point, let me try to fix it.
> >
> > >
> > > And then we should allow alloc_htab_elem() to fail,
> > >                 l_new = bpf_map_kmalloc_node(&htab->map, htab->elem_size,
> > > -                                            GFP_ATOMIC | __GFP_NOWARN,
> > > +                                            __GFP_ATOMIC |
> > > __GFP_KSWAPD_RECLAIM | __GFP_NOWARN,
> >
> > It's not a memcg thing, it was done this way previously. Probably Alexei
> > has a better explanation. Personally, I'm totally fine with removing
> > __GFP_NOWARN, but maybe I just don't know something.
> >
> > >                                              htab->map.numa_node);
> > > And then we'd better introduce an improvement for memcg,
> > > +      /*
> > > +       *  Should wakeup async memcg reclaim first,
> > > +       *   in case there will be no direct memcg reclaim for a long time.
> > > +       *   We can either introduce async memcg reclaim
> > > +       *   or modify kswapd to reclaim a specific memcg
> > > +       */
> > > +       if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> > > +            wake_up_async_memcg_reclaim();
> > >          if (!gfpflags_allow_blocking(gfp_mask))
> > >                 goto nomem;
> >
> > Hm, I see. It might be an issue if there is no global memory pressure, right?
> > Let me think what I can do here too.
> >
> > >
> > > And .....
> > >
> > > Really bad luck that there are so many issues in memcg, but it may
> > > also be because I don't have a deep understanding of memcg ......
> > >
> > > I have to clarify that these issues are not caused by
> > > memcg-based-bpf-accounting, but exposed by it.
> > >
> > > [ Time for lunch here, so I have to stop. ]
> >
> > Thank you for writing this text, it was interesting to follow your thinking.
> > And thank you for bringing in these problems above.
> >
> > Let me be clear: I'm not opposing the idea of recharging, I'm only against
> > introducing hacks for bpf-specific issues, which can't be nicely generalized
> > for other use cases and subsystems. That's the only reason why I'm a bit
> > defensive here.
> >
> > In general, as now memory cgroups do not provide an ability to recharge
> > accounted objects (with some exceptions from the v1 legacy). It applies
> > both to user and kernel memory. I agree, that bpf maps are in some sense
> > unique, as they are potentially large kernel objects with a lot of control
> > from the userspace. Is this a good reason to extend memory cgroup API
> > with the recharging ability? Maybe, but if yes, let's do it well.
> >
> > The big question is how to do it? Memcg accounting is done in a way
> > that requires little changes from the kernel code, right? You just
> > add __GFP_ACCOUNT to gfp flags and that's it, you get a pointer to
> > an already accounted object. The same applies for uncharging.
> > It works transparently.
> >
> > Recharging is different: a caller should have some sort of the ownership
> > over the object (to make sure we are not racing against the reclaim and/or
> > another recharging). And the rules are different for each type of objects.
> > It's a caller duty to make sure all parts of the complex object are properly
> > recharged and nothing is left behind. There is also the reparenting mechanism
> > which can race against the recharging. So it's not an easy problem.
> > If an object is large, we probably don't want to recharge it at once,
> > otherwise temporarily doubling of the accounted memory (thanks to the
> > precharge-uncharge-commit approach) risks introducing spurious OOMs
> > on memory-limited systems.
> >
> > So yeah, if it doesn't sound too scary for you, I'm happy to help
> > with this. But it's a lot of work to do it properly, that's why I'm thinking
> > that maybe it's better to workaround it in userspace, as Alexei suggested.
>
> And as Alexei mentioned, there are some changes coming around the way
> how memory allocations will be usually performed by the bpf code, which might
> make the whole problem and/or your solution obsolete. Please, make sure it's
> still actual before sending the next version.
>

I have taken a look at Alexei's patchset.
For the non-preallocated bpf memory, we have to use map->memcg to do
the accounting, then this issue will still exist.
It also reminds us that when we reuse a map we must make sure the
map->memcg is the expected one.

-- 
Regards
Yafang
