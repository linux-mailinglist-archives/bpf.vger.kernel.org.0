Return-Path: <bpf+bounces-34162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CC92AC32
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F22825ED
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1D1509B6;
	Mon,  8 Jul 2024 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLzLB6sV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A514F9EB;
	Mon,  8 Jul 2024 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478523; cv=none; b=jtMbKQsI/vPYpPmaawf8gbzSlR8s35HMr1w5ZjbC5eTIdh+ZN4ixkFMYRnDnkVjpG2ecxk2IwZia94yu3O4jvuZLkaJl5jiu5TzNWLuq0osMROEPyrfdh/g6/He4pKTrtuJBzorAYcQ7PjOD0iPK13+bKOldT47micDZfM7wrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478523; c=relaxed/simple;
	bh=BA8Mj+A9DwgKVuqs1Ox4H4NcikONMpdM1NXfnsc3faA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISIJjZhZllSmAnp6odqWig+bCUeg9XqhNtgjRWzRpbTUEzeUF5fhV3+LaaVMcMKQFKVPM5YDHcNe4b3tg5h7JrqnCv+Cg6vpYJiV7XJOK8gBW+YJ7pUySWM9tewvtmMk2utyBYl07biavgCzZQ0w0cCIB66XJDDl3XJLZCRJQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLzLB6sV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso2707257f8f.0;
        Mon, 08 Jul 2024 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720478520; x=1721083320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evtvPvNZrA04ORqItPV8xM+oDcZwis0jC0vS7LNZylY=;
        b=PLzLB6sV8WOg6/4BIzUJEEQ8rMIq+NdY6vOfvI/5FDIC6fRhOiJfp6RcjlcWg1eG79
         NEdIKSj0HrFhcRyd9omvi3zsP++CF5LIfTRSfSPokigSw+Vpof2l023tf/oepQ4UwRZb
         nlbDeQEbQhfjBsWEirDI/ikAWDHqR1sYsXaaEJbBXyqLd57Q/JqlrXNpQ3y3XNZFb5Az
         EJIsjOLOY+qbPjsHn8lkqTGMe4s33s+L5WOxkvxdgL3un+F1jiuLEGAQBgm6b2MNZOik
         O94vuOKQgtFjkqTSakjjEb8UmQo5jzd+2NgR1mR7ST+vsnfOy97K1lPBZTrEd5ePd58n
         /clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720478520; x=1721083320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evtvPvNZrA04ORqItPV8xM+oDcZwis0jC0vS7LNZylY=;
        b=XY/sPS3rycaOc85N14g9uDJDpF1yhYtfsARhR2Kje58deHDF2ISoVUTx6dQcYGDwsu
         pgciWwzyCcz47sPuQsXr9Qd7TRIpLmzktNjV9CxORGzxV1cts3CJoCRHcCZE8wrcs2dG
         iFakTVUuqnUzF9exwV0oP2/T8WIa/yM9hv8t4R4I53yt5kYGA4WgpsgDFm2LHomIMnka
         b8hQ9LTMHO2UqTDtIoywm0FwMVrQFUEbnZA9/ee7Sv0FyevOG3usbf+qilVhuLYelBUa
         OOaFvHEOHoNAOkvVunz5sRBWMkfevSqNCC0DBhfaAhHdAxC/u5yY5aV1fjTCkI7iMZuM
         TqbA==
X-Forwarded-Encrypted: i=1; AJvYcCVuAMpdDSy8qZ+Mola/Oi/rDz5EbxITTTF7S39aS98KQWypsXpZXxmCixbCbjPHb4GLQd6GkS8X9vDDoRgOSMv9Tomtpm1lujwgDRtR1o4tvMiI12WhAsiAn6PFX3C+hRde
X-Gm-Message-State: AOJu0YzZ2N3OfCxi/WdZKpD6R6frnOjcmBXYs3R5NQuX/LKeSrI1fu9B
	CCpWzxSSPWVLSExGc4Pt7Td31jlehWuBCO7xxDYFUKNcKyJkquWI28uyjBHhMwbVLPLKUuHhLXG
	rnmargudHli6TAj/+lkrzC6mp/GE=
X-Google-Smtp-Source: AGHT+IHJd1MGg8DX0+8XXPs+iBd/273EvXK0VTcTOcp9tu61lxvjPh7uoX372uc40/uFG55xRziLxokuosYMdBuXlWg=
X-Received: by 2002:a05:6000:174d:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-367d2d52e99mr334128f8f.24.1720478519867; Mon, 08 Jul 2024
 15:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn9oEjsm_1aWb35J@slm.duckdns.org> <Zoh4kp7-jAFZXhe6@slm.duckdns.org>
In-Reply-To: <Zoh4kp7-jAFZXhe6@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 15:41:48 -0700
Message-ID: <CAADnVQJ6o-ikfnHiatbNwS8+MKi44kcBfVtnDQkYLdDUZ80Rtg@mail.gmail.com>
Subject: Re: [PATCH v4 sched_ext/for-6.11 2/2] sched_ext: Implement DSQ iterator
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:50=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
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
> v4: - bpf_iter_scx_dsq_new() declaration in common.bpf.h was using the wr=
ong
>       type for the last argument (bool rev instead of u64 flags). Fix it.

Overall lgtm.
Acked-by: Alexei Starovoitov <ast@kernel.org>

In the future pls resubmit the whole series as v4
(all patches not just one).
It was difficult for me to find the patch 1/2 without any vN tag
that corresponds to this v4 patch.
lore helped at the end.

Few nits below:

> v3: - Alexei pointed out that the iterator is too big to allocate on stac=
k.
>       Added a prep patch to reduce the size of the cursor. Now
>       bpf_iter_scx_dsq is 48 bytes and bpf_iter_scx_dsq_kern is 40 bytes =
on
>       64bit.
>
>     - u32_before() comparison factored out.
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
>  include/linux/sched/ext.h                |    3
>  kernel/sched/ext.c                       |  187 ++++++++++++++++++++++++=
++++++-
>  tools/sched_ext/include/scx/common.bpf.h |    3
>  tools/sched_ext/scx_qmap.bpf.c           |   25 ++++
>  tools/sched_ext/scx_qmap.c               |    8 -
>  5 files changed, 222 insertions(+), 4 deletions(-)
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
> @@ -123,6 +124,7 @@ enum scx_kf_mask {
>
>  struct scx_dsq_list_node {
>         struct list_head        node;
> +       bool                    is_bpf_iter_cursor;
>  };
>
>  /*
> @@ -133,6 +135,7 @@ struct sched_ext_entity {
>         struct scx_dispatch_q   *dsq;
>         struct scx_dsq_list_node dsq_list;      /* dispatch order */
>         struct rb_node          dsq_priq;       /* p->scx.dsq_vtime order=
 */
> +       u32                     dsq_seq;
>         u32                     dsq_flags;      /* protected by DSQ lock =
*/
>         u32                     flags;          /* protected by rq lock *=
/
>         u32                     weight;
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -926,6 +926,11 @@ static u32 highest_bit(u32 flags)
>         return ((u64)1 << bit) >> 1;
>  }
>
> +static bool u32_before(u32 a, u32 b)
> +{
> +       return (s32)(a - b) < 0;
> +}
> +
>  /*
>   * scx_kf_mask enforcement. Some kfuncs can only be called from specific=
 SCX
>   * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to ind=
icate
> @@ -1066,6 +1071,73 @@ static __always_inline bool scx_kf_allow
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
> +       struct scx_dsq_list_node *dsq_lnode;
> +
> +       lockdep_assert_held(&dsq->lock);
> +
> +       if (cur)
> +               list_node =3D &cur->scx.dsq_list.node;
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
> +               dsq_lnode =3D container_of(list_node, struct scx_dsq_list=
_node,
> +                                        node);
> +       } while (dsq_lnode->is_bpf_iter_cursor);
> +
> +       return container_of(dsq_lnode, struct task_struct, scx.dsq_list);
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
> +       struct scx_dsq_list_node        cursor;
> +       struct scx_dispatch_q           *dsq;
> +       u32                             dsq_seq;
> +       u32                             flags;
> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_scx_dsq {
> +       u64                             __opaque[6];
> +} __attribute__((aligned(8)));
> +
>
>  /*
>   * SCX task iterator.
> @@ -1415,7 +1487,7 @@ static void dispatch_enqueue(struct scx_
>                  * tested easily when adding the first task.
>                  */
>                 if (unlikely(RB_EMPTY_ROOT(&dsq->priq) &&
> -                            !list_empty(&dsq->list)))
> +                            nldsq_next_task(dsq, NULL, false)))

There is also consume_dispatch_q() that is doing
list_empty(&dsq->list) check.
Does it need to be updated as well?

>                         scx_ops_error("DSQ ID 0x%016llx already had FIFO-=
enqueued tasks",
>                                       dsq->id);
>
> @@ -1447,6 +1519,10 @@ static void dispatch_enqueue(struct scx_
>                         list_add_tail(&p->scx.dsq_list.node, &dsq->list);
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
> @@ -2109,7 +2185,7 @@ retry:
>
>         raw_spin_lock(&dsq->lock);
>
> -       list_for_each_entry(p, &dsq->list, scx.dsq_list.node) {
> +       nldsq_for_each_task(p, dsq) {
>                 struct rq *task_rq =3D task_rq(p);
>
>                 if (rq =3D=3D task_rq) {
> @@ -5697,6 +5773,110 @@ __bpf_kfunc void scx_bpf_destroy_dsq(u64
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
> +       INIT_LIST_HEAD(&kit->cursor.node);
> +       kit->cursor.is_bpf_iter_cursor =3D true;
> +       kit->dsq_seq =3D READ_ONCE(kit->dsq->seq);
> +       kit->flags =3D flags;
> +
> +       return 0;
> +}
> +
> +/**
> + * bpf_iter_scx_dsq_next - Progress a DSQ iterator
> + * @it: iterator to progress
> + *
> + * Return the next task. See bpf_iter_scx_dsq_new().
> + */
> +__bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_sc=
x_dsq *it)
> +{
> +       struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +       bool rev =3D kit->flags & SCX_DSQ_ITER_REV;
> +       struct task_struct *p;
> +       unsigned long flags;
> +
> +       if (!kit->dsq)
> +               return NULL;
> +
> +       raw_spin_lock_irqsave(&kit->dsq->lock, flags);
> +
> +       if (list_empty(&kit->cursor.node))
> +               p =3D NULL;
> +       else
> +               p =3D container_of(&kit->cursor, struct task_struct, scx.=
dsq_list);
> +
> +       /*
> +        * Only tasks which were queued before the iteration started are
> +        * visible. This bounds BPF iterations and guarantees that vtime =
never
> +        * jumps in the other direction while iterating.
> +        */
> +       do {
> +               p =3D nldsq_next_task(kit->dsq, p, rev);
> +       } while (p && unlikely(u32_before(kit->dsq_seq, p->scx.dsq_seq)))=
;
> +
> +       if (p) {
> +               if (rev)
> +                       list_move_tail(&kit->cursor.node, &p->scx.dsq_lis=
t.node);
> +               else
> +                       list_move(&kit->cursor.node, &p->scx.dsq_list.nod=
e);
> +       } else {
> +               list_del_init(&kit->cursor.node);
> +       }
> +
> +       raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
> +
> +       return p;
> +}
> +
> +/**
> + * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
> + * @it: iterator to destroy
> + *
> + * Undo scx_iter_scx_dsq_new().
> + */
> +__bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
> +{
> +       struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +
> +       if (!kit->dsq)
> +               return;
> +
> +       if (!list_empty(&kit->cursor.node)) {
> +               unsigned long flags;
> +
> +               raw_spin_lock_irqsave(&kit->dsq->lock, flags);
> +               list_del_init(&kit->cursor.node);
> +               raw_spin_unlock_irqrestore(&kit->dsq->lock, flags);
> +       }
> +       kit->dsq =3D NULL;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  static s32 __bstr_format(u64 *data_buf, char *line_buf, size_t line_size=
,
> @@ -6118,6 +6298,9 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -39,6 +39,9 @@ u32 scx_bpf_reenqueue_local(void) __ksym
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 fl=
ags) __ksym __weak;
> +struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) _=
_ksym __weak;
> +void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak=
;
>  void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *dat=
a, u32 data__sz) __ksym __weak;
>  void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_le=
n) __ksym;
>  void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len=
) __ksym __weak;
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c

We typically split kernel changes vs bpf prog and selftests changes
into separate patches.

> @@ -36,6 +36,7 @@ const volatile u32 stall_user_nth;
>  const volatile u32 stall_kernel_nth;
>  const volatile u32 dsp_inf_loop_after;
>  const volatile u32 dsp_batch;
> +const volatile bool print_shared_dsq;
>  const volatile s32 disallow_tgid;
>  const volatile bool suppress_dump;
>
> @@ -604,10 +605,34 @@ out:
>         scx_bpf_put_cpumask(online);
>  }
>
> +/*
> + * Dump the currently queued tasks in the shared DSQ to demonstrate the =
usage of
> + * scx_bpf_dsq_nr_queued() and DSQ iterator. Raise the dispatch batch co=
unt to
> + * see meaningful dumps in the trace pipe.
> + */
> +static void dump_shared_dsq(void)
> +{
> +       struct task_struct *p;
> +       s32 nr;
> +
> +       if (!(nr =3D scx_bpf_dsq_nr_queued(SHARED_DSQ)))
> +               return;
> +
> +       bpf_printk("Dumping %d tasks in SHARED_DSQ in reverse order", nr)=
;
> +
> +       bpf_rcu_read_lock();
> +       bpf_for_each(scx_dsq, p, SHARED_DSQ, SCX_DSQ_ITER_REV)
> +               bpf_printk("%s[%d]", p->comm, p->pid);
> +       bpf_rcu_read_unlock();
> +}

...

> +"  -P            Print out DSQ content to trace_pipe every second, use w=
ith -b\n"

tbh the demo of the iterator is so-so. Could have done something more
interesting :)

