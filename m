Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EFD563E38
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 06:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGBEXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 00:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGBEXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 00:23:30 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5D1F2E4
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 21:23:28 -0700 (PDT)
Date:   Fri, 1 Jul 2022 21:23:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656735807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzXNs70WHMtboWd+grqVTGNXmGyPHBV+9qhpjinuT/Q=;
        b=mN5Q7vRy1UUefFFp6lW21PTy22P2fZiejxINM5EGYmMxDGaz2xQU2S9Q0swwk6CnPVQ9en
        dh64+nloD6q+mdFeCMTdh+u5TesvZlzbgdqcFPsWglix4UcgfHjrrXAMTZzQZmUkmwMxtx
        hwypus3zirQNrFntcfhD/YAmuWIDp5s=
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
        Shakeel Butt <shakeelb@google.com>, songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse
 bpf map
Message-ID: <Yr/INyiQ3eV4ToIP@castle>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
 <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
 <YrfSXVDONpxcUDI+@castle>
 <CALOAHbC2j35V6wLh4+-m9_+EPPvFfT3KqkD_6JFsPYj78G6dSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC2j35V6wLh4+-m9_+EPPvFfT3KqkD_6JFsPYj78G6dSw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 26, 2022 at 02:25:51PM +0800, Yafang Shao wrote:
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
> 
> Right. It is not a good idea to expect a global memory reclaimer to do it.
> Thanks for following up with it again.

After thinking a bit more, I'm not sure if it's actually a good idea:
there might be not much memory to reclaim except the memory consumed by the bpf
map itself, so waking kswapd might be useless (and just consume cpu and drain
batteries).

What we need to do instead is to prevent bpf maps to meaningfully exceed
memory.max, which is btw guaranteed by the cgroup API: memory.max is defined
as a hard limit in docs. Your recent patch is actually doing this for hash maps,
let's fix the rest of the bpf code.

Thanks!
