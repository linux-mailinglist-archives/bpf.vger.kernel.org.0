Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C256410F
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiGBPeD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGBPeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 11:34:02 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2410AA
        for <bpf@vger.kernel.org>; Sat,  2 Jul 2022 08:34:01 -0700 (PDT)
Date:   Sat, 2 Jul 2022 08:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656776038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0koBQrdHPcVIUR0L54i8lw1aAxWvfXxTIhqNWGsnhmE=;
        b=VSNnpIb3zPiCa58T1nsR3vom50wd/wka/ztKLz371Ix5/hMY3NzqK93ODr55G0qEPqNPl4
        buHd+gw0qSE2Wgi2F+hfHU4spW53a4Ympe3sHqXYQPUkHYgu6wdz01MQdnW1AbD/C1pf0l
        ZnPtikl8Xw5OoTdftSJIcNg8ScLpwvc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse
 bpf map
Message-ID: <YsBlXr29xELsqcuZ@castle>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
 <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
 <YrfSXVDONpxcUDI+@castle>
 <CALOAHbC2j35V6wLh4+-m9_+EPPvFfT3KqkD_6JFsPYj78G6dSw@mail.gmail.com>
 <Yr/INyiQ3eV4ToIP@castle>
 <CALOAHbCT=uAkp+HiJyfU-zOPfWnD2afHozUuZvrb8aiQyY6K1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCT=uAkp+HiJyfU-zOPfWnD2afHozUuZvrb8aiQyY6K1w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Sat, Jul 02, 2022 at 11:24:10PM +0800, Yafang Shao wrote:
> On Sat, Jul 2, 2022 at 12:23 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Sun, Jun 26, 2022 at 02:25:51PM +0800, Yafang Shao wrote:
> > > > >                                              htab->map.numa_node);
> > > > > And then we'd better introduce an improvement for memcg,
> > > > > +      /*
> > > > > +       *  Should wakeup async memcg reclaim first,
> > > > > +       *   in case there will be no direct memcg reclaim for a long time.
> > > > > +       *   We can either introduce async memcg reclaim
> > > > > +       *   or modify kswapd to reclaim a specific memcg
> > > > > +       */
> > > > > +       if (gfp_mask & __GFP_KSWAPD_RECLAIM)
> > > > > +            wake_up_async_memcg_reclaim();
> > > > >          if (!gfpflags_allow_blocking(gfp_mask))
> > > > >                 goto nomem;
> > > >
> > > > Hm, I see. It might be an issue if there is no global memory pressure, right?
> > > > Let me think what I can do here too.
> > > >
> > >
> > > Right. It is not a good idea to expect a global memory reclaimer to do it.
> > > Thanks for following up with it again.
> >
> > After thinking a bit more, I'm not sure if it's actually a good idea:
> > there might be not much memory to reclaim except the memory consumed by the bpf
> > map itself, so waking kswapd might be useless (and just consume cpu and drain
> > batteries).
> >
> 
> I'm not sure if it is a generic problem.
> For example, a latency-sensitive process running in a container
> doesn't set __GFP_DIRECT_RECLAIM, but there're page cache pages in
> this container. If there's no global memory pressure or no other kinds
> of memory allocation in this container, these page cache pages will
> not be reclaimed for a long time.
> Maybe we should also check the number of page cache pages in this
> container before waking up kswapd, but I'm not quite sure of it.

It's not a generic problem but it might be very specific.
Anyway, it doesn't really matter, we shouldn't exceed memory.max.
