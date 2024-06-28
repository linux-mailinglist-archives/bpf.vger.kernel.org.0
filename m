Return-Path: <bpf+bounces-33318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF991B48B
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 03:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AB61C21055
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016DF9F5;
	Fri, 28 Jun 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Isj7DezS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45096FC7;
	Fri, 28 Jun 2024 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537123; cv=none; b=unKxqWPls7BXcTHvJqmG6cKxIPGgh6B18WSXmrFXoTy1e1aj3cxSClOeUCHxSf3ASbJNR8+rrXKZBPOuHnvnEMlyLNX92hp6rwtCi6cY07LbUw8RxtkW1W/xvDMgrxS4y0Wg35w8QyhOYLLpuUq1dTpcR4bfwTyFOVOQCc12gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537123; c=relaxed/simple;
	bh=U8cIVcknMk/yANvHszyfQ+vb50bqsarjVpIp9dz7cC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNEuO2MwsI2RAdRCfh+d/Pr9tcre60bUWQ9Lk0GN0e8scehzu7JwNUuHZDRKT0SclpOnBkQSIFwmPnmPHi2oesicGigoiLSNGdWJfhewImrtE8tRKt+/S7IJSrIcMToEdk41//eotRu/isNWZMmkEAIwYADaFHYUm1kvbrtYHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Isj7DezS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-424720e73e1so562625e9.1;
        Thu, 27 Jun 2024 18:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719537120; x=1720141920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MstboDj0v4tQRIjKo2n9bEA4S+rx/ubRi/zLQG/2cd8=;
        b=Isj7DezSUndpgjgcK8xcanxWsn4lZw6TqqqbJ2hcCgcAOK6zaDc5G5WWYxwbcrkxDS
         kgx1pGnKXUaMDZiGEKjKGdks8Hir7vsFlJepuNq4Tih10q5uYSRzVjehLKgG2Yf1zDrC
         x1xV+yGC/OP9kAtuJfm3Sne2Jc86NJpFFmwChh5MjCF6jzj1bGR1d5bcgENT4pUMrFn3
         tP3sTnMFIdYwSF/2Q8VZ9+6CHSH+59Hoo1bC+BL/xnzYtFfhYbhU1UKS1sN7ELYWWmy+
         R2WcKPwwBVDFC/s3I3shrhKxm/c5L+rCrtZv0r6suVW04aLz6B2YtOeQD2Ln3nFzly2Y
         vTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719537120; x=1720141920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MstboDj0v4tQRIjKo2n9bEA4S+rx/ubRi/zLQG/2cd8=;
        b=DWHJJo9hsE6nu/UwPUnsMwo77bfoeQkSgd1HhZPY1C9nXpIB4SV2GVNUkVHrd5u3KH
         EDi4a3T5Ao/MhGN8XUPt68Tk1168zPXDTftRq+9urI3Hck5yE60JCqRxhE7oZfNmNSv/
         KTiv2K/EgIXl5zHet4plQFC+pYg4NDP+U79iw3KM9GnW9zmVDdt2bwV7dtbsjof7YbMT
         SuYAZEaXjJvU8GbJ9T7m4rSrIzaOqJkqCbIMypVwoGB7poSZDEiOaxV6060tZMIcgeje
         9ndqjfb1aeblZodpiNYmyEXD73RocDxGoWlVD+dQNsU3jJRktPOQP0cZ93WQNewJC+eM
         Iihw==
X-Forwarded-Encrypted: i=1; AJvYcCV/TBYwPYv3+tz49SzJv/9UTS2CAd852RB1n7rCKqWExMOKKHHfesU8NZb3aevif/N/bu+knL77eNKMQcvVS9QgR53g7NFi2O50SpxStwDjzE9SdSCZYjXLnHvClodvh96n
X-Gm-Message-State: AOJu0Yx51pz9f3qmlA+0Aei9ffss14Ff56dMBntuF3An1dEZ/Zj72G+d
	3JxoItmpxO/A7BvYKee332epSPCJkXz8KCmE1+Vu3UTeFNgQoU++SYQPwv6yjcqqwoQ5VYLjQYO
	nQ94d7gsLE9mirDn2PRX9Q65Kyzk=
X-Google-Smtp-Source: AGHT+IHHmNfYbb+PbB+j+hLCPozeBTYMmikpJYxSuVNMe0yZHU2tY6Cc462L7dGKP81WcF3BhfRJ+Q9kG0fMlS4asGI=
X-Received: by 2002:a05:600c:4315:b0:424:f2b9:7969 with SMTP id
 5b1f17b1804b1-424f2b97a4fmr41740875e9.1.1719537119603; Thu, 27 Jun 2024
 18:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
In-Reply-To: <Zn4BupVa65CVayqQ@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jun 2024 18:11:48 -0700
Message-ID: <CAADnVQ+h2W88nWnj_frPa24vYmE+yebHYaT6mronRnDYvC+JLQ@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11 1/2] sched_ext: Implement DSQ iterator
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:20=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> DSQs are very opaque in the consumption path. The BPF scheduler has no wa=
y
> of knowing which tasks are being considered and which is picked. This pat=
ch
> adds BPF DSQ iterator.
>
> - Allows iterating tasks queued on a DSQ in the dispatch order or reverse
>   from anywhere using bpf_for_each(scx_dsq) or calling the iterator kfunc=
s
>   directly.
>
> - Has ordering guarantee where only tasks which were already queued when =
the
>   iteration started are visible and consumable during the iteration.
>
> scx_qmap is updated to implement periodic dumping of the shared DSQ.
>
> v2: - scx_bpf_consume_task() is separated out into a separate patch.
>
>     - DSQ seq and iter flags don't need to be u64. Use u32.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> ---
> Hello, Alexei.
>
> These two patches implement inline iterator for a task queue data structu=
re
> that's used by sched_ext. The first one implements the iterator itself. I=
t's
> pretty straightforward and seems to work fine. The second one implements =
a
> kfunc which consumes a task while iterating. This one is a bit nasty
> unfortunately. I'll continue on the second patch.
>
> Thanks.
>
>  include/linux/sched/ext.h                |    4
>  kernel/sched/ext.c                       |  182 ++++++++++++++++++++++++=
++++++-
>  tools/sched_ext/include/scx/common.bpf.h |    3
>  tools/sched_ext/scx_qmap.bpf.c           |   25 ++++
>  tools/sched_ext/scx_qmap.c               |    8 +
>  5 files changed, 218 insertions(+), 4 deletions(-)
>
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -61,6 +61,7 @@ struct scx_dispatch_q {
>         struct list_head        list;   /* tasks in dispatch order */
>         struct rb_root          priq;   /* used to order by p->scx.dsq_vt=
ime */
>         u32                     nr;
> +       u32                     seq;    /* used by BPF iter */
>         u64                     id;
>         struct rhash_head       hash_node;
>         struct llist_node       free_node;
> @@ -94,6 +95,8 @@ enum scx_task_state {
>  /* scx_entity.dsq_flags */
>  enum scx_ent_dsq_flags {
>         SCX_TASK_DSQ_ON_PRIQ    =3D 1 << 0, /* task is queued on the prio=
rity queue of a dsq */
> +
> +       SCX_TASK_DSQ_CURSOR     =3D 1 << 31, /* iteration cursor, not a t=
ask */
>  };
>
>  /*
> @@ -134,6 +137,7 @@ struct scx_dsq_node {
>  struct sched_ext_entity {
>         struct scx_dispatch_q   *dsq;
>         struct scx_dsq_node     dsq_node;       /* protected by dsq lock =
*/
> +       u32                     dsq_seq;
>         u32                     flags;          /* protected by rq lock *=
/
>         u32                     weight;
>         s32                     sticky_cpu;
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1066,6 +1066,72 @@ static __always_inline bool scx_kf_allow
>         return true;
>  }
>
> +/**
> + * nldsq_next_task - Iterate to the next task in a non-local DSQ
> + * @dsq: user dsq being interated
> + * @cur: current position, %NULL to start iteration
> + * @rev: walk backwards
> + *
> + * Returns %NULL when iteration is finished.
> + */
> +static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
> +                                          struct task_struct *cur, bool =
rev)
> +{
> +       struct list_head *list_node;
> +       struct scx_dsq_node *dsq_node;
> +
> +       lockdep_assert_held(&dsq->lock);
> +
> +       if (cur)
> +               list_node =3D &cur->scx.dsq_node.list;
> +       else
> +               list_node =3D &dsq->list;
> +
> +       /* find the next task, need to skip BPF iteration cursors */
> +       do {
> +               if (rev)
> +                       list_node =3D list_node->prev;
> +               else
> +                       list_node =3D list_node->next;
> +
> +               if (list_node =3D=3D &dsq->list)
> +                       return NULL;
> +
> +               dsq_node =3D container_of(list_node, struct scx_dsq_node,=
 list);
> +       } while (dsq_node->flags & SCX_TASK_DSQ_CURSOR);
> +
> +       return container_of(dsq_node, struct task_struct, scx.dsq_node);
> +}
> +
> +#define nldsq_for_each_task(p, dsq)                                     =
       \
> +       for ((p) =3D nldsq_next_task((dsq), NULL, false); (p);           =
         \
> +            (p) =3D nldsq_next_task((dsq), (p), false))
> +
> +
> +/*
> + * BPF DSQ iterator. Tasks in a non-local DSQ can be iterated in [revers=
e]
> + * dispatch order. BPF-visible iterator is opaque and larger to allow fu=
ture
> + * changes without breaking backward compatibility. Can be used with
> + * bpf_for_each(). See bpf_iter_scx_dsq_*().
> + */
> +enum scx_dsq_iter_flags {
> +       /* iterate in the reverse dispatch order */
> +       SCX_DSQ_ITER_REV                =3D 1U << 0,
> +
> +       __SCX_DSQ_ITER_ALL_FLAGS        =3D SCX_DSQ_ITER_REV,
> +};
> +
> +struct bpf_iter_scx_dsq_kern {
> +       struct scx_dsq_node             cursor;
> +       struct scx_dispatch_q           *dsq;
> +       u32                             dsq_seq;
> +       u32                             flags;
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_scx_dsq {
> +       u64                             __opaque[12];
> +} __attribute__((aligned(8)));

I think this is a bit too much to put on the prog stack.
Folks are working on increasing this limit and moving
the stack into "divided stack", so it won't be an issue eventually,
but let's find a way to reduce it.
It seems to me scx_dsq_node has a bunch of fields,
but if I'm reading the code correctly this patch is
only using cursor.list part of it ?

Another alternative is to use bpf_mem_alloc() like we do
in bpf_iter_css_task and others?

> +
>
>  /*
>   * SCX task iterator.
> @@ -1415,7 +1481,7 @@ static void dispatch_enqueue(struct scx_
>                  * tested easily when adding the first task.
>                  */
>                 if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
> -                            !list_empty(&dsq->list)))
> +                            nldsq_next_task(dsq, NULL, false)))
>                         scx_ops_error("DSQ ID 0x%016llx already had FIFO-=
enqueued tasks",
>                                       dsq->id);
>
> @@ -1447,6 +1513,10 @@ static void dispatch_enqueue(struct scx_
>                         list_add_tail(&p->scx.dsq_node.list, &dsq->list);
>         }
>
> +       /* seq records the order tasks are queued, used by BPF DSQ iterat=
or */
> +       dsq->seq++;
> +       p->scx.dsq_seq =3D dsq->seq;
> +
>         dsq_mod_nr(dsq, 1);
>         p->scx.dsq =3D dsq;
>
> @@ -2109,7 +2179,7 @@ retry:
>
>         raw_spin_lock(&dsq->lock);
>
> -       list_for_each_entry(p, &dsq->list, scx.dsq_node.list) {
> +       nldsq_for_each_task(p, dsq) {
>                 struct rq *task_rq =3D task_rq(p);
>
>                 if (rq =3D=3D task_rq) {
> @@ -5697,6 +5767,111 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64
>         destroy_dsq(dsq_id);
>  }
>
> +/**
> + * bpf_iter_scx_dsq_new - Create a DSQ iterator
> + * @it: iterator to initialize
> + * @dsq_id: DSQ to iterate
> + * @flags: %SCX_DSQ_ITER_*
> + *
> + * Initialize BPF iterator @it which can be used with bpf_for_each() to =
walk
> + * tasks in the DSQ specified by @dsq_id. Iteration using @it only inclu=
des
> + * tasks which are already queued when this function is invoked.
> + */
> +__bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 ds=
q_id,
> +                                    u64 flags)
> +{
> +       struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_scx_dsq_kern) >
> +                    sizeof(struct bpf_iter_scx_dsq));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=3D
> +                    __alignof__(struct bpf_iter_scx_dsq));
> +
> +       if (flags & ~__SCX_DSQ_ITER_ALL_FLAGS)
> +               return -EINVAL;
> +
> +       kit->dsq =3D find_non_local_dsq(dsq_id);
> +       if (!kit->dsq)
> +               return -ENOENT;
> +
> +       INIT_LIST_HEAD(&kit->cursor.list);
> +       RB_CLEAR_NODE(&kit->cursor.priq);
> +       kit->cursor.flags =3D SCX_TASK_DSQ_CURSOR;

Are these two assignments really necessary?
Something inside nldsq_next_task() is using that?


> +       kit->dsq_seq =3D READ_ONCE(kit->dsq->seq);
> +       kit->flags =3D flags;
> +
> +       return 0;
> +}

