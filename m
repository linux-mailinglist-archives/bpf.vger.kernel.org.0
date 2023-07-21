Return-Path: <bpf+bounces-5576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2025575BCA0
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 05:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423F71C2156C
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F94644;
	Fri, 21 Jul 2023 03:02:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF317F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 03:02:46 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37CAE4C
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:02:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so12194185e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689908562; x=1690513362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H66ZeQCkleoaJLDrwcxhC7Oe56iVMrHjVjCO/PNd9CQ=;
        b=URoSjjmcnyyh9YTWUC8lm8ar2dq2zAQm/Ocjl6utrENHZSHsWwfwVJQWfL2ZoTj8qe
         9p9ea4MVUgcRwqOxJK27fb6WCg9dJSxJShlyDOu2aZvyDfpXL8VI7EZym8jZCQScGMFY
         LpbxUUtihh6FJun4kcrMOG+8WYgea6ohNkUP/+SdsZdF5sFklbF5AFdKtUICugQGQo/O
         172maAJ38SVQSIv4kzQNW1yks9yAloDxdE2hZro5PqqVqFzxjsWku72ve/wVOdbmmYEF
         DK7nEC9MAeeJh0rk7JRg2Y4ZB2/dh8nuYnMJJOAi03+wLZnEJsCnUEYy2OS/GCavp8jP
         xVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689908562; x=1690513362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H66ZeQCkleoaJLDrwcxhC7Oe56iVMrHjVjCO/PNd9CQ=;
        b=IvGebySiFIt7EdlQmA5XoemlAZgCOYZlwcVNRU91YH0EshpaAJV02TRUPIqdKqdNIH
         gDaNGfli7Ov/P+nl4UwPsmRyW0Q0Z88De/WkmNbqT6pnJoNP07Adldqo4jXrIVDF7tL3
         w8hz72uFG0x2lm3b49jU1+hQALhMOk9G5ZX8+xucXB+0xtn1Nr9uUb0d8XbemVVBrrAt
         GNlTbrRD4G7myRCcSQZnn01X94nCujc46Ql9sUPv2y2HA43DImeo5hZswpJPWivNzUUS
         nthkv96wz1XHKa/+PAAvnc/F4N7qruTqShloxVH3OXRmE/6TdyfWX/tKRbDiDmBpojRj
         Z+fw==
X-Gm-Message-State: ABy/qLZuqHhmo58dYf15v/cldZghnRuhylt43H+WkM8w0mnsBzf7AjMO
	f+7wWoXqz7SVTTnT3rSAXOn5LSc2wmvcRD2itIdrakn0euRbwCEVieHPFA==
X-Google-Smtp-Source: APBJJlEazW2kcnixvI1H9UGV3QYy+WaQjRD0r0tT0JiRL5EAWkXIDYqVTb3/EuzvjHrRMbTGQwtK0fcog7G8OCAJMYM=
X-Received: by 2002:a5d:5541:0:b0:314:14be:1004 with SMTP id
 g1-20020a5d5541000000b0031414be1004mr440108wrw.63.1689908558373; Thu, 20 Jul
 2023 20:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689885610.git.zhuyifei@google.com> <3516fa9cc4bdbaeb90f208f5c970e622ba76be3e.1689885610.git.zhuyifei@google.com>
 <87874222-1d01-b08b-87e5-a94d90167e94@huaweicloud.com>
In-Reply-To: <87874222-1d01-b08b-87e5-a94d90167e94@huaweicloud.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Thu, 20 Jul 2023 20:02:27 -0700
Message-ID: <CAA-VZPnVE7MSnXn-5pMun2D_naMSU9Q6XFost7ZgncyJDtnnAg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf/memalloc: Schedule highprio wq for non-atomic
 alloc when atomic fails
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
> Hi,
>
> On 7/21/2023 4:44 AM, YiFei Zhu wrote:
> > Atomic refill can fail, such as when all percpu chunks are full,
> > and when that happens there's no guarantee when more space will be
> > available for atomic allocations.
> >
> > Instead of having the caller wait for memory to be available by
> > retrying until the related BPF API no longer gives -ENOMEM, we can
> > kick off a non-atomic GFP_KERNEL allocation with highprio workqueue.
> > This should make it much less likely for those APIs to return
> > -ENOMEM.
> >
> > Because alloc_bulk can now be called from the workqueue,
> > non-atomic calls now also calls local_irq_save/restore to reduce
> > the chance of races.
> >
> > Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory al=
locator.")
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >  kernel/bpf/memalloc.c | 47 ++++++++++++++++++++++++++++++-------------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 016249672b43..2915639a5e16 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -84,14 +84,15 @@ struct bpf_mem_cache {
> >       struct llist_head free_llist;
> >       local_t active;
> >
> > -     /* Operations on the free_list from unit_alloc/unit_free/bpf_mem_=
refill
> > +     /* Operations on the free_list from unit_alloc/unit_free/bpf_mem_=
refill_*
> >        * are sequenced by per-cpu 'active' counter. But unit_free() can=
not
> >        * fail. When 'active' is busy the unit_free() will add an object=
 to
> >        * free_llist_extra.
> >        */
> >       struct llist_head free_llist_extra;
> >
> > -     struct irq_work refill_work;
> > +     struct irq_work refill_work_irq;
> > +     struct work_struct refill_work_wq;
> >       struct obj_cgroup *objcg;
> >       int unit_size;
> >       /* count of objects in free_llist */
> > @@ -153,7 +154,7 @@ static struct mem_cgroup *get_memcg(const struct bp=
f_mem_cache *c)
> >  #endif
> >  }
> >
> > -/* Mostly runs from irq_work except __init phase. */
> > +/* Mostly runs from irq_work except workqueue and __init phase. */
> >  static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, boo=
l atomic)
> >  {
> >       struct mem_cgroup *memcg =3D NULL, *old_memcg;
> > @@ -188,10 +189,18 @@ static void alloc_bulk(struct bpf_mem_cache *c, i=
nt cnt, int node, bool atomic)
> >                        * want here.
> >                        */
> >                       obj =3D __alloc(c, node, gfp);
> > -                     if (!obj)
> > +                     if (!obj) {
> > +                             /* We might have exhausted the percpu chu=
nks, schedule
> > +                              * non-atomic allocation so hopefully cal=
ler can get
> > +                              * a free unit upon next invocation.
> > +                              */
> > +                             if (atomic)
> > +                                     queue_work_on(smp_processor_id(),
> > +                                                   system_highpri_wq, =
&c->refill_work_wq);
>
> I am not a MM expert. But according to the code in
> pcpu_balance_workfn(), it will try to do pcpu_create_chunk() when
> pcpu_atomic_alloc_failed is true, so the reason for introducing
> refill_work_wq is that pcpu_balance_workfn is too slow to fulfill the
> allocation request from bpf memory allocator ?

Oh I missed that part of the code. In one of my tests I had the
previous patch applied, and I had a lot of assertions around the code
(for debugging-by-kdumping), and I was able to get some crashes that
suggested I needed to add more, so I wrote this. However I wasn't able
to reproduce that again. Though, after giving it another thought, this
sequence of events could still happen:

  initial condition: free_cnt =3D 1, low_watermark =3D 1
  unit_alloc()
    sets free_cnt =3D 0
    free_cnt < low_watermark
      irq_work_raise()
  irq work: bpf_mem_refill()
    alloc_bulk()
      __alloc()
        __alloc_percpu_gfp()
          fails
          pcpu_schedule_balance_work()
          return NULL
  pcpu_balance_workfn()
    succeeds, next __alloc_percpu_gfp will succeed
  unit_alloc()
    free_cnt is still 0
    return NULL

The thing here is that, even if pcpu_balance_workfn is fast enough to
run before the next unit_alloc, unit_alloc will still return NULL. I'm
not sure if this is desired, but this should be a very rare condition
requiring 8k unit_size. I'm not exactly sure what happened in that
dump. And since I'm unable to reproduce this again, and if we are okay
with the rare case above, I'm happy to drop this patch until I have a
better idea of what happened (or it was just my bad assertions, which
could very well be what happened).

> >                               break;
> > +                     }
> >               }
> > -             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +             if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
> >                       /* In RT irq_work runs in per-cpu kthread, so dis=
able
> >                        * interrupts to avoid preemption and interrupts =
and
> >                        * reduce the chance of bpf prog executing on thi=
s cpu
> > @@ -208,7 +217,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int=
 cnt, int node, bool atomic)
> >               __llist_add(obj, &c->free_llist);
> >               c->free_cnt++;
> >               local_dec(&c->active);
> > -             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +             if (IS_ENABLED(CONFIG_PREEMPT_RT) || !atomic)
> >                       local_irq_restore(flags);
> >       }
> >       set_active_memcg(old_memcg);
> > @@ -314,9 +323,9 @@ static void free_bulk(struct bpf_mem_cache *c)
> >       do_call_rcu(c);
> >  }
> >
> > -static void bpf_mem_refill(struct irq_work *work)
> > +static void bpf_mem_refill_irq(struct irq_work *work)
> >  {
> > -     struct bpf_mem_cache *c =3D container_of(work, struct bpf_mem_cac=
he, refill_work);
> > +     struct bpf_mem_cache *c =3D container_of(work, struct bpf_mem_cac=
he, refill_work_irq);
> >       int cnt;
> >
> >       /* Racy access to free_cnt. It doesn't need to be 100% accurate *=
/
> > @@ -332,7 +341,14 @@ static void bpf_mem_refill(struct irq_work *work)
> >
> >  static void notrace irq_work_raise(struct bpf_mem_cache *c)
> >  {
> > -     irq_work_queue(&c->refill_work);
> > +     irq_work_queue(&c->refill_work_irq);
> > +}
> > +
> > +static void bpf_mem_refill_wq(struct work_struct *work)
> > +{
> > +     struct bpf_mem_cache *c =3D container_of(work, struct bpf_mem_cac=
he, refill_work_wq);
> > +
> > +     alloc_bulk(c, c->batch, NUMA_NO_NODE, false);
>
> Considering that the kworker may be interrupted by irq work, so there
> will be concurrent __llist_del_first() operations on free_by_rcu, andI
> think it is not safe to call alloc_bulk directly here. Maybe we can just
> skip __llist_del_first() for !atomic context.

Ack.

> >  }
> >
> >  /* For typical bpf map case that uses bpf_mem_cache_alloc and single b=
ucket
> > @@ -352,7 +368,8 @@ static void notrace irq_work_raise(struct bpf_mem_c=
ache *c)
> >
> >  static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
> >  {
> > -     init_irq_work(&c->refill_work, bpf_mem_refill);
> > +     init_irq_work(&c->refill_work_irq, bpf_mem_refill_irq);
> > +     INIT_WORK(&c->refill_work_wq, bpf_mem_refill_wq);
> >       if (c->unit_size <=3D 256) {
> >               c->low_watermark =3D 32;
> >               c->high_watermark =3D 96;
> > @@ -529,7 +546,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma=
)
> >               for_each_possible_cpu(cpu) {
> >                       c =3D per_cpu_ptr(ma->cache, cpu);
> >                       /*
> > -                      * refill_work may be unfinished for PREEMPT_RT k=
ernel
> > +                      * refill_work_irq may be unfinished for PREEMPT_=
RT kernel
> >                        * in which irq work is invoked in a per-CPU RT t=
hread.
> >                        * It is also possible for kernel with
> >                        * arch_irq_work_has_interrupt() being false and =
irq
> > @@ -537,7 +554,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma=
)
> >                        * the completion of irq work to ease the handlin=
g of
> >                        * concurrency.
> >                        */
> > -                     irq_work_sync(&c->refill_work);
> > +                     irq_work_sync(&c->refill_work_irq);
> > +                     cancel_work_sync(&c->refill_work_wq);
>
> cancel_work_sync() may be time-consuming. We may need to move it to
> free_mem_alloc_deferred() to prevent blocking the destroy of bpf memory
> allocator.

Ack.

> >                       drain_mem_cache(c);
> >                       rcu_in_progress +=3D atomic_read(&c->call_rcu_in_=
progress);
> >               }
> > @@ -552,7 +570,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma=
)
> >                       cc =3D per_cpu_ptr(ma->caches, cpu);
> >                       for (i =3D 0; i < NUM_CACHES; i++) {
> >                               c =3D &cc->cache[i];
> > -                             irq_work_sync(&c->refill_work);
> > +                             irq_work_sync(&c->refill_work_irq);
> > +                             cancel_work_sync(&c->refill_work_wq);
> >                               drain_mem_cache(c);
> >                               rcu_in_progress +=3D atomic_read(&c->call=
_rcu_in_progress);
> >                       }
> > @@ -580,7 +599,7 @@ static void notrace *unit_alloc(struct bpf_mem_cach=
e *c)
> >        *
> >        * but prog_B could be a perf_event NMI prog.
> >        * Use per-cpu 'active' counter to order free_list access between
> > -      * unit_alloc/unit_free/bpf_mem_refill.
> > +      * unit_alloc/unit_free/bpf_mem_refill_*.
> >        */
> >       local_irq_save(flags);
> >       if (local_inc_return(&c->active) =3D=3D 1) {
>

