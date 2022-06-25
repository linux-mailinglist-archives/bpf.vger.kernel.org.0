Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1520755AAA7
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiFYNy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jun 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiFYNy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jun 2022 09:54:56 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA612ACB
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 06:54:55 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id m188so2467722vkm.3
        for <bpf@vger.kernel.org>; Sat, 25 Jun 2022 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DzUTh7oPyYwfjy5rFYKtBOpCrN54eQl+KjUU0VIh5M=;
        b=C4eCcZabKFsj4hQcQKh7cvv/ikD1fLep7IDkjj0qOpKHWFvWkiSVGrtoCF8WmD2xlX
         +iBvzDP0SRHu+U/Nczulb41AG/gqJfdt+rFVY27oAuPcQSWB6qpckJbqki5su87EoKgh
         l/BhWT6JG7B9TDv/ek35oARiUjMULhZaii1LnWeEK0kmm1mX8YmsJBIvA9AfG05hmvJk
         VMHyuEkt+gYFz4WvIBQQkq+gP8BuEw0snTuJDywL7MC9FrcTbrIeKRtGtN6TstWZgSNm
         JJfn1X9JjLXvmOen4DlJJb+vIKfNIViBG9ICXcy4xUe4tEx61/Ox9gvdVyrcJeL2np4w
         3i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DzUTh7oPyYwfjy5rFYKtBOpCrN54eQl+KjUU0VIh5M=;
        b=rX8wZIz9CbHFfP+OCUziU5Y/TVwoJc79vcODguBdJbywi5JyFawWfK01fPU7iSD7by
         nY4em5YmXfLadhxENSvw0GSmc2NRFmmQZ2qcEQsTQRilFiK8crff5vCaNgMyfBnrN9k1
         LSnuP0dAG3xlbATpAKgcOghRsxG7nAoY0Pr7b/0+eekjFpOFeEhyFZhq/5FLiXAVDpo+
         TMCv3+BSt11QonvNKRW1YWZDau3q9SLjAVQ6WmnNj/cLVGYsMRpM/YvYStqM+0WpDxI6
         oxCk2Jl9NmClmTAFWuVdGhvX0UYBQotzwvH86met4nVyJF1ycE+zNCL4ShSjl+5YSm9p
         wjtg==
X-Gm-Message-State: AJIora+aY+fSjfwkHBn+7NxxXrc9upw+pxCi+MD0mrAWzNbecQWtuZPf
        j6y1urlTziLpZo1IqwWLpQBG/3WwqMvPHmfWksg=
X-Google-Smtp-Source: AGRyM1vrRDfBHEkvghDMs3K9uonUUXqSV9b0f2DOGVI5iaL7QxKbYHFGCllywnwrOQU/Hs7NLl+LfK+3shinxuYlZ1k=
X-Received: by 2002:a1f:a348:0:b0:36f:be56:9381 with SMTP id
 m69-20020a1fa348000000b0036fbe569381mr437176vke.8.1656165294893; Sat, 25 Jun
 2022 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <20220619155032.32515-4-laoar.shao@gmail.com>
 <YrPXfG4UVNw2lmkk@castle>
In-Reply-To: <YrPXfG4UVNw2lmkk@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 25 Jun 2022 21:54:17 +0800
Message-ID: <CALOAHbAET_9=CqYOuxt9zxwYo4O4u5-GfQGMKtMOqrjEpp7khw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 03/10] mm, memcg: Add new helper obj_cgroup_from_current()
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

On Thu, Jun 23, 2022 at 11:01 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Sun, Jun 19, 2022 at 03:50:25PM +0000, Yafang Shao wrote:
> > The difference between get_obj_cgroup_from_current() and obj_cgroup_from_current()
> > is that the later one doesn't add objcg's refcnt.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  1 +
> >  mm/memcontrol.c            | 24 ++++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index cf074156c6ac..402b42670bcd 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1703,6 +1703,7 @@ bool mem_cgroup_kmem_disabled(void);
> >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
> >  void __memcg_kmem_uncharge_page(struct page *page, int order);
> >
> > +struct obj_cgroup *obj_cgroup_from_current(void);
> >  struct obj_cgroup *get_obj_cgroup_from_current(void);
> >  struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index abec50f31fe6..350a7849dac3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2950,6 +2950,30 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
> >       return objcg;
> >  }
> >
> > +__always_inline struct obj_cgroup *obj_cgroup_from_current(void)
> > +{
> > +     struct obj_cgroup *objcg = NULL;
> > +     struct mem_cgroup *memcg;
> > +
> > +     if (memcg_kmem_bypass())
> > +             return NULL;
> > +
> > +     rcu_read_lock();
> > +     if (unlikely(active_memcg()))
> > +             memcg = active_memcg();
> > +     else
> > +             memcg = mem_cgroup_from_task(current);
> > +
> > +     for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > +             objcg = rcu_dereference(memcg->objcg);
> > +             if (objcg)
> > +                     break;
> > +     }
> > +     rcu_read_unlock();
>
> Hm, what prevents the objcg from being released here? Under which conditions
> it's safe to call it?

obj_cgroup_from_current() is used when we know the objcg's refcnt has
already been incremented.
For example in my case, it is called after we have already call get_
parent_mem_cgroup().
I should add a comment or a WARN_ON() in this function.

-- 
Regards
Yafang
