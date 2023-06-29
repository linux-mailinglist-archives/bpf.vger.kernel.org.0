Return-Path: <bpf+bounces-3686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA8C741EE9
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C636F1C20490
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01F1FDE;
	Thu, 29 Jun 2023 03:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DA1FB9;
	Thu, 29 Jun 2023 03:52:27 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06D297C;
	Wed, 28 Jun 2023 20:52:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so347121e87.2;
        Wed, 28 Jun 2023 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688010744; x=1690602744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/mShnN9MUl1H+Uj5ppePaa4sMACmwUz9u37+BJFKZE=;
        b=BVEN9r7qrjVLVv6PkvHynYjAu6Rjd6ivk1td+rcqFxtYPiFqgHpDVeUxPVXNorBeSb
         WvG5QrrjFJmYfqLE+coobGParakanK7ubUkKygoomHbksDcn9TPUlxtOyqoFF2i6xRtL
         wqeabKDvK/TI+ADiNqHg9jWm8Yvimae2yNxWaziwSXsd9lUJlAAD4V7sDigJRglpctL3
         gQu4Ws31EET/KAFLc2lgKaTO64KRySyYNjqTU54K6+xfdI3yY5FhukB43BG0Pdd227Tr
         QsOUmIIq2cXDEM+yxnA2UgXg0+MgInEApDd0EB5o/xjdQzrSWlDGxdHiWWCwLGrbOV6w
         lNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010744; x=1690602744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/mShnN9MUl1H+Uj5ppePaa4sMACmwUz9u37+BJFKZE=;
        b=A0TIiNPBNm7YOAFdDrqtGr2tt/fgYQ+hyB+NThgTg2Su6O4PcVJkkKS9BCVqOuTGRh
         btV36/dV5Zoiz5hCRtHWo4eVX3PachnaC8sVYMySWxx7wg28cvxsgmRtFiZpjkUHybIs
         dW6eZKc4bj1+AVIzn4DsPJQ9EECdmZgaXZQT8HLXQwdmfJlRDpwfUXWu3cpi1O3n+8yp
         kaH9QNdOhw0N75ruMxMmpxEbn1cfyjZoRo/IUKKcU3Kg71dXqn7QSEodWvAVUYdx/+JN
         gihUpMntuTwfRZfzUwTsL4zHj5tk+Ek2li6ER7DFXjCOxtm3pEN6Wf9WIWcQXKealZsK
         6CYA==
X-Gm-Message-State: AC+VfDx0lt4nDMpDyCt1mYkAdQyDVEqx1a5nYjfHIxY2GBjeN+RMwK40
	uLDfzMSZUQobDg2YodZe7HtCtEjmdbY1ujVIkHY=
X-Google-Smtp-Source: ACHHUZ4k+FMX1pP2TTmE1EQ6BD+dsv0O4YCLc/H6iUPCtg1z5Tm4nCtOkeTgKJYpXHPT/qdL5j9P/vLchyo7pE+Smyk=
X-Received: by 2002:a05:6512:3d06:b0:4fb:7be5:8f4e with SMTP id
 d6-20020a0565123d0600b004fb7be58f4emr8145248lfv.6.1688010744064; Wed, 28 Jun
 2023 20:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com> <6f8e0e91-44b4-4d0e-8df3-c1e765653255@paulmck-laptop>
In-Reply-To: <6f8e0e91-44b4-4d0e-8df3-c1e765653255@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jun 2023 20:52:12 -0700
Message-ID: <CAADnVQJq+NA0denwyr56jYz73n5BnkKF_GtY0zpwqsSvCrGs6Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, Hou Tao <houtao@huaweicloud.com>, Tejun Heo <tj@kernel.org>, 
	rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 10:57=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Tue, Jun 27, 2023 at 06:56:33PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> > Unlike bpf_mem_[cache_]free() that links objects for immediate reuse in=
to
> > per-cpu free list the _rcu() flavor waits for RCU grace period and then=
 moves
> > objects into free_by_rcu_ttrace list where they are waiting for RCU
> > task trace grace period to be freed into slab.
> >
> > The life cycle of objects:
> > alloc: dequeue free_llist
> > free: enqeueu free_llist
> > free_rcu: enqueue free_by_rcu -> waiting_for_gp
> > free_llist above high watermark -> free_by_rcu_ttrace
> > after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> > free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf_mem_alloc.h |   2 +
> >  kernel/bpf/memalloc.c         | 129 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 128 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_allo=
c.h
> > index 3929be5743f4..d644bbb298af 100644
> > --- a/include/linux/bpf_mem_alloc.h
> > +++ b/include/linux/bpf_mem_alloc.h
> > @@ -27,10 +27,12 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma=
);
> >  /* kmalloc/kfree equivalent: */
> >  void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
> >  void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
> > +void bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
> >
> >  /* kmem_cache_alloc/free equivalent: */
> >  void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
> >  void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
> > +void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
> >  void bpf_mem_cache_raw_free(void *ptr);
> >  void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)=
;
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 40524d9454c7..3081d06a434c 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -101,6 +101,15 @@ struct bpf_mem_cache {
> >       bool draining;
> >       struct bpf_mem_cache *tgt;
> >
> > +     /* list of objects to be freed after RCU GP */
> > +     struct llist_head free_by_rcu;
> > +     struct llist_node *free_by_rcu_tail;
> > +     struct llist_head waiting_for_gp;
> > +     struct llist_node *waiting_for_gp_tail;
> > +     struct rcu_head rcu;
> > +     atomic_t call_rcu_in_progress;
> > +     struct llist_head free_llist_extra_rcu;
> > +
> >       /* list of objects to be freed after RCU tasks trace GP */
> >       struct llist_head free_by_rcu_ttrace;
> >       struct llist_head waiting_for_gp_ttrace;
> > @@ -344,6 +353,69 @@ static void free_bulk(struct bpf_mem_cache *c)
> >       do_call_rcu_ttrace(tgt);
> >  }
> >
> > +static void __free_by_rcu(struct rcu_head *head)
> > +{
> > +     struct bpf_mem_cache *c =3D container_of(head, struct bpf_mem_cac=
he, rcu);
> > +     struct bpf_mem_cache *tgt =3D c->tgt;
> > +     struct llist_node *llnode;
> > +
> > +     llnode =3D llist_del_all(&c->waiting_for_gp);
> > +     if (!llnode)
> > +             goto out;
> > +
> > +     llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu=
_ttrace);
> > +
> > +     /* Objects went through regular RCU GP. Send them to RCU tasks tr=
ace */
> > +     do_call_rcu_ttrace(tgt);
> > +out:
> > +     atomic_set(&c->call_rcu_in_progress, 0);
> > +}
> > +
> > +static void check_free_by_rcu(struct bpf_mem_cache *c)
> > +{
> > +     struct llist_node *llnode, *t;
> > +     unsigned long flags;
> > +
> > +     /* drain free_llist_extra_rcu */
> > +     if (unlikely(!llist_empty(&c->free_llist_extra_rcu))) {
> > +             inc_active(c, &flags);
> > +             llist_for_each_safe(llnode, t, llist_del_all(&c->free_lli=
st_extra_rcu))
> > +                     if (__llist_add(llnode, &c->free_by_rcu))
> > +                             c->free_by_rcu_tail =3D llnode;
> > +             dec_active(c, flags);
> > +     }
> > +
> > +     if (llist_empty(&c->free_by_rcu))
> > +             return;
> > +
> > +     if (atomic_xchg(&c->call_rcu_in_progress, 1)) {
> > +             /*
> > +              * Instead of kmalloc-ing new rcu_head and triggering 10k
> > +              * call_rcu() to hit rcutree.qhimark and force RCU to not=
ice
> > +              * the overload just ask RCU to hurry up. There could be =
many
> > +              * objects in free_by_rcu list.
> > +              * This hint reduces memory consumption for an artifical
> > +              * benchmark from 2 Gbyte to 150 Mbyte.
> > +              */
> > +             rcu_request_urgent_qs_task(current);
>
> I have been going back and forth on whether rcu_request_urgent_qs_task()
> needs to throttle calls to itself, for example, to pay attention to only
> one invocation per jiffy.  The theory here is that RCU's state machine
> normally only advances about once per jiffy anyway.
>
> The main risk of *not* throttling is if several CPUs were to invoke
> rcu_request_urgent_qs_task() in tight loops while those same CPUs were
> undergoing interrupt storms, which would result in heavy lock contention
> in __rcu_irq_enter_check_tick().  This is not exactly a common-case
> scenario, but on the other hand, if you are having this degree of trouble=
,
> should RCU really be adding lock contention to your troubles?

I see spin_lock in __rcu_irq_enter_check_tick(), but I didn't observe
it in practice even when I was calling rcu_request_urgent_qs_task()
in multiple places through bpf_mem_alloc.
I left it only in one place (this patch),
because it was enough to 'hurry up the RCU' and make the difference.
rdp =3D this_cpu_ptr(&rcu_data); is percpu, so I'm not sure why
you think that the contention is possible.
I think we should avoid extra logic either in RCU or in bpf_mem_alloc
to keep the code simple, since contention is hypothetical at this point.
I've tried preempt and no preempt configs. With and without debug.

