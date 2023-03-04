Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD76AAAC6
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCDPey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDPex (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 10:34:53 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5701613D6E
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 07:34:52 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id o15so21500049edr.13
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1EEbGVgZ71JZ69RbE0e+eMHcrpWTok1fxwL05RB58pM=;
        b=Y2H56JcJPFXUlYAZDiPtPWfNi5bCH507cNdbd9Zh0D5/jYLGfcqbEHZy2l4n3Quu3f
         QWIPkH6ojW4c93dPWVkA4g/WOKpAj4L3tQtahcPwEE0TmPVXGhMgnBN3djJMrWY4Dgr2
         jQCGFxMRrZqRDGX9zzu3bYYUpFSl8IW0dTMPGdQpl9HMqmUEpYEsrsQ2zWr9Ngzfs79x
         9FAHkupV0hS+fstHZtB9UzVbqOeHWW77Y/BHfyx1aVi+ptg+svpVGyiNrJ8mm3s3T5jw
         zoGAAJzTg+Czw2v0qNdY6tMsA7BCHdQrgpolRnzEWS6JiF5deeIP5S+87BBOHR3V26st
         Gmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EEbGVgZ71JZ69RbE0e+eMHcrpWTok1fxwL05RB58pM=;
        b=SZBS+s5OUzMGrZplO1eTB358RTFMtYd7rAcK+IywugGhMQVd+RCehNgOXTlF4Pn/1e
         n5uLjzCCTdj0hXzwFqYwuYMWwQHb/DbLmJ88nV7Y+rvEVV1Ce6BJa7VTZ+RVgz8StM5U
         COBQyBg8MtEzUsZJX8+lqCeCOISQZsA3y62aVPx3LgHV+yysU3peOVNjLs9Bn90XF83J
         uKOwO+xAMDzNTUFY4r1N9pt4TqYP96hBMJspzPnWuCxFwZolvPTKyDglATkxfKEISb2r
         as7RWY4YUcLEV2LyYNL2uX0b3GSVlqigtuk36M6IgMeJKqnrty7G+QqP+hrNyobeJ0uA
         ZzdA==
X-Gm-Message-State: AO0yUKXTkAuUr9ZN/FmInInDK55dkbTXyGrUovxbwsGFrH8u7BxU7vZC
        +3FJM4Rk9TjxX8n9+T/fglAcdmx7uKCXuMatJS0=
X-Google-Smtp-Source: AK7set8wbefr2sTTYpydbtV0VxdX5VZd90JsEpvf3XfIdXdbmb2BOesM9tWG9pKucHo/erPFWAdglgBMj8CpNljzJAQ=
X-Received: by 2002:a17:906:3002:b0:8dc:6674:5bac with SMTP id
 2-20020a170906300200b008dc66745bacmr2588756ejz.4.1677944090695; Sat, 04 Mar
 2023 07:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20230225154010.391965-1-memxor@gmail.com> <20230225154010.391965-3-memxor@gmail.com>
 <2c4ba6a2-3225-9ffa-c537-f606c01b00e4@linux.dev>
In-Reply-To: <2c4ba6a2-3225-9ffa-c537-f606c01b00e4@linux.dev>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 4 Mar 2023 16:34:13 +0100
Message-ID: <CAP01T746zBF+sz3zfkGgmQ1NCQT2sXmKenN7F-09QKtLpjoiTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 4 Mar 2023 at 08:53, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/25/23 7:40 AM, Kumar Kartikeya Dwivedi wrote:
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> > index 6d37a40cd90e..0fe92986412b 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -74,6 +74,12 @@ struct bpf_local_storage_elem {
> >       struct hlist_node snode;        /* Linked to bpf_local_storage */
> >       struct bpf_local_storage __rcu *local_storage;
> >       struct rcu_head rcu;
> > +     bool can_use_smap; /* Is it safe to access smap in bpf_selem_free_* RCU
> > +                         * callbacks? bpf_local_storage_map_free only
> > +                         * executes rcu_barrier when there are special
> > +                         * fields, this field remembers that to ensure we
> > +                         * don't access already freed smap in sdata.
> > +                         */
> >       /* 8 bytes hole */
> >       /* The data is stored in another cacheline to minimize
> >        * the number of cachelines access during a cache hit.
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index 58da17ae5124..2bdd722fe293 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> >       if (selem) {
> >               if (value)
> >                       copy_map_value(&smap->map, SDATA(selem)->data, value);
> > +             /* No need to call check_and_init_map_value as memory is zero init */
> >               return selem;
> >       }
> >
> > @@ -113,10 +114,25 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
> >       struct bpf_local_storage_elem *selem;
> >
> >       selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > +     /* The can_use_smap bool is set whenever we need to free additional
> > +      * fields in selem data before freeing selem. bpf_local_storage_map_free
> > +      * only executes rcu_barrier to wait for RCU callbacks when it has
> > +      * special fields, hence we can only conditionally dereference smap, as
> > +      * by this time the map might have already been freed without waiting
> > +      * for our call_rcu callback if it did not have any special fields.
> > +      */
> > +     if (selem->can_use_smap)
> > +             bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
> > +     kfree(selem);
> > +}
> > +
> > +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
> > +{
> > +     /* Free directly if Tasks Trace RCU GP also implies RCU GP */
> >       if (rcu_trace_implies_rcu_gp())
> > -             kfree(selem);
> > +             bpf_selem_free_rcu(rcu);
> >       else
> > -             kfree_rcu(selem, rcu);
> > +             call_rcu(rcu, bpf_selem_free_rcu);
> >   }
> >
> >   /* local_storage->lock must be held and selem->local_storage == local_storage.
> > @@ -170,9 +186,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
> >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> >
> >       if (use_trace_rcu)
> > -             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > +             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
> >       else
> > -             kfree_rcu(selem, rcu);
> > +             call_rcu(&selem->rcu, bpf_selem_free_rcu);
>
> After another thought, bpf_obj_free_fields() does not need to go through the rcu
> gp, right?
>
> bpf_obj_free_fields() can be done just before the call_rcu_tasks_trace() and the
> call_rcu() here. In hashtab, bpf_obj_free_fields() is also done just before
> bpf_mem_cache_free().

Perhaps not. But the original code for hashtab prior to conversion to
use bpf_mem_cache actually freed timers and kptrs after waiting for a
complete RCU grace period for the kmalloc case. My main idea was to
try to delay it until the last point, where memory is returned for
reuse. Now that does not include a RCU grace period for hashtab
anymore because memory can be reused as soon as it is returned to
bpf_mem_cache. Same for array maps where update does the freeing.

bpf_obj_free_fields can possibly do a lot of work, try to acquire the
bpf_spin_lock in map value, etc. Even moreso now that we have lists
and rbtree that could be in map values, where they have to drain all
elements (which might have fields of their own). Not doing that in the
context of the program calling update or delete is usually better if
we have a choice, since it might introduce unexpected delays. Here we
are doing an RCU callback in all cases, so I think it's better to
delay freeing the fields and do it in RCU callback, since we are doing
call_rcu anyway.
