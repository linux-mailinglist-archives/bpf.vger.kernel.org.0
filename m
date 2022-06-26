Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA655AE13
	for <lists+bpf@lfdr.de>; Sun, 26 Jun 2022 03:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiFZBwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jun 2022 21:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiFZBwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jun 2022 21:52:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4412AAC
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 18:52:14 -0700 (PDT)
Date:   Sat, 25 Jun 2022 18:52:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656208333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3abD8MY8AFNkt9IMrGyI8BpvZiqLUJO1kMPiRlUrc=;
        b=mZ9bljj+Q9GANyah9tPGURJT0uBGi3FRPJSOYvX2zXYmqxGfO14xlRc8JV8SQNpAY0hQ0Z
        pU9MfKOCIInMClWkmaIUxKDe7bHmpzZmB54cclnlPVyclbo+haMl/LUYLAtYaxlN32XVR4
        PxbH1S8vpBHzN6hRcsDSKIblSHYqOfg=
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
Subject: Re: [RFC PATCH bpf-next 03/10] mm, memcg: Add new helper
 obj_cgroup_from_current()
Message-ID: <Yre7xWVNjYI7ZzBI@castle>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
 <20220619155032.32515-4-laoar.shao@gmail.com>
 <YrPXfG4UVNw2lmkk@castle>
 <CALOAHbAET_9=CqYOuxt9zxwYo4O4u5-GfQGMKtMOqrjEpp7khw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAET_9=CqYOuxt9zxwYo4O4u5-GfQGMKtMOqrjEpp7khw@mail.gmail.com>
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

On Sat, Jun 25, 2022 at 09:54:17PM +0800, Yafang Shao wrote:
> On Thu, Jun 23, 2022 at 11:01 AM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > On Sun, Jun 19, 2022 at 03:50:25PM +0000, Yafang Shao wrote:
> > > The difference between get_obj_cgroup_from_current() and obj_cgroup_from_current()
> > > is that the later one doesn't add objcg's refcnt.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h |  1 +
> > >  mm/memcontrol.c            | 24 ++++++++++++++++++++++++
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index cf074156c6ac..402b42670bcd 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1703,6 +1703,7 @@ bool mem_cgroup_kmem_disabled(void);
> > >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
> > >  void __memcg_kmem_uncharge_page(struct page *page, int order);
> > >
> > > +struct obj_cgroup *obj_cgroup_from_current(void);
> > >  struct obj_cgroup *get_obj_cgroup_from_current(void);
> > >  struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index abec50f31fe6..350a7849dac3 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2950,6 +2950,30 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
> > >       return objcg;
> > >  }
> > >
> > > +__always_inline struct obj_cgroup *obj_cgroup_from_current(void)
> > > +{
> > > +     struct obj_cgroup *objcg = NULL;
> > > +     struct mem_cgroup *memcg;
> > > +
> > > +     if (memcg_kmem_bypass())
> > > +             return NULL;
> > > +
> > > +     rcu_read_lock();
> > > +     if (unlikely(active_memcg()))
> > > +             memcg = active_memcg();
> > > +     else
> > > +             memcg = mem_cgroup_from_task(current);
> > > +
> > > +     for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > > +             objcg = rcu_dereference(memcg->objcg);
> > > +             if (objcg)
> > > +                     break;
> > > +     }
> > > +     rcu_read_unlock();
> >
> > Hm, what prevents the objcg from being released here? Under which conditions
> > it's safe to call it?
> 
> obj_cgroup_from_current() is used when we know the objcg's refcnt has
> already been incremented.
> For example in my case, it is called after we have already call get_
> parent_mem_cgroup().
> I should add a comment or a WARN_ON() in this function.

Yes, it's very confusing, please add a big comment explaining under which
conditions it's safe to call it.

Thanks!
