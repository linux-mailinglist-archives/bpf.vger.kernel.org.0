Return-Path: <bpf+bounces-47465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7A9F9A60
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9278D7A1D64
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC62210D2;
	Fri, 20 Dec 2024 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSI3wKaD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B7143736;
	Fri, 20 Dec 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722697; cv=none; b=bRAya4HxCsDIjAzAkbBq+zPdz7ZDA0PEYGXvJ+X0zL2WHk6phPEXAVlRQhyD6A150gegH5UP7mQMqpUquruqjay8syuixvPZ4qYhGgyk/Tij3ay/gejDXmYicfd0GmdBNKGn5IQWrUY6rZytuE1w43qgb8LANQvGk5yVHi8M20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722697; c=relaxed/simple;
	bh=wV/YdBlfQNiDvTJrVJVxOSzC/plNKeR73VQON2TyRo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ7EuVt08kd7IIcxiLJ/5oK2yCBQENVTGiV+8rFZdG+DiFfUDRdt7OloLHQq1hsX9ye+wEf7S4wY36881+tbu9BVaQD4V7kwHKRIu79VSxSZMvJtIpa6e7OYCWjQB1yczZCpy4eNF6mMz9x0STQxufB3H/9xjQ/Zzo77FFoH9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSI3wKaD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6efe4324f96so19631307b3.1;
        Fri, 20 Dec 2024 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734722695; x=1735327495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEVwMyQgA+Ia+XCUUmg6Gvt7/yGoGQXRqwNATybxg9A=;
        b=CSI3wKaDJWAf8IV+FrJZbvP8ISxUzOfDpwQy9UEydkxgi0icuQDy4PipL46lvrXV5g
         yvLkawS/Yy6raN6I+4uvw6NxRhswLhE3d2YaffdzXqOw7sWyil+cFFDLxpWLLmWfXS/I
         QF7ZzG2eSeEji/P74YmuB7tTTtUGUSW6LEC8on7R+P9t+SXJxCjZlaUs4WpEUMt7ohxu
         VBxPOwJ/pBnW0Jtpt0HiZiI3qfKsqDjYnkPr7wTAmLMTG3HQ3H9vVa8KsDjW89yJ3RyO
         jpeM7loMh7XMEtRxAPINyYMbGmopqpjKbCmzbiPJTRsZP/Bt4zg6wGBrvDsGVewA1glc
         4m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722695; x=1735327495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEVwMyQgA+Ia+XCUUmg6Gvt7/yGoGQXRqwNATybxg9A=;
        b=lUQFgmHBPpILBRKoYMj6CosnNuS58pqvFfNOLariIPL7KekNgXbpt0nk9/D78mgp1Z
         VgMvZdnLRXGr8PUINk5rb6wVlcqRbp3mKE0VZshcxq8f0vzCn1Dwcf90wQlpcg/FVw49
         S93WqmYNbPrkHD6P0XqNuFDCNC4rvrLatHV5hDQ6rrsGFChWvflJlLZtxob6kj9C3LZt
         T79y5cXNVmGowBBkdGNn6eDTMDwc2sLWEgGFnK3Xl7FwhgSGCRHfd1F7dn88pf++YLDP
         A2ABLgGNBUAXGIvx+gL5fpBKWazvfaZDHHOiTWJ+V8fh9aty5ovAcvXhn0XFEXoEnYQK
         mKyw==
X-Forwarded-Encrypted: i=1; AJvYcCW9A+nWXQNPzt5ZFU2U9y2/+8ssB12IpOzcusgmdr1/Nheg19DCSFVbhurxVfhJoiiEuQw=@vger.kernel.org, AJvYcCXOBoAM+qSUKZB1gmUI8c3MOK9SH/CpfW98BIv7A9gLzTlBlwG5BHortm4hZK5tFNuORoJxyxqH@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbXI//NgbJEJKpPm/8A7WiIimXQAyjaiJdsbXSwBEC85oDpeQ
	CNCD0eh8krVjVFWX8DUZFruVyqo42LxIEJY/HlxienyBzFo1rOpfhDiYgY4q+IPmt3OaA+bQX8G
	mtVueNrX0Wfd35xpbqGTtegA533Q=
X-Gm-Gg: ASbGncsMRb7IpOEsmdJ3knTLE9GnlS+V8/oDrLpr1/OUOsgF09/+I/Cs8U/OqSVZ7Og
	bM4IamhfPpUF7yc/4Lacq1UB38WwYk/h+IRTkBg==
X-Google-Smtp-Source: AGHT+IF/UPm6g8FXn2V4OW8zPDsR+IJ+xbp4ik2pKznZ5isSFqJVUBAX6mOyH9H/vWdaGgB2PuKB0hYro0HbesKQ8/U=
X-Received: by 2002:a05:690c:f84:b0:6ef:4ed2:7df4 with SMTP id
 00721157ae682-6f3f821a9cemr35710437b3.33.1734722694929; Fri, 20 Dec 2024
 11:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-8-amery.hung@bytedance.com> <f57ee5de-bf8b-40ce-8883-904653c422b5@linux.dev>
In-Reply-To: <f57ee5de-bf8b-40ce-8883-904653c422b5@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 20 Dec 2024 11:24:44 -0800
Message-ID: <CAMB2axNgThq22C+w7OCY5FXy4Gp4_RYF+twT5Rk9AUHOF2SHkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/13] bpf: net_sched: Add a qdisc watchdog timer
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:16=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 3:29 PM, Amery Hung wrote:
> > Add a watchdog timer to bpf qdisc. The watchdog can be used to schedule
> > the execution of qdisc through kfunc, bpf_qdisc_schedule(). It can be
> > useful for building traffic shaping scheduling algorithm, where the tim=
e
> > the next packet will be dequeued is known.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   include/net/sch_generic.h |  4 +++
> >   net/sched/bpf_qdisc.c     | 51 ++++++++++++++++++++++++++++++++++++++=
-
> >   net/sched/sch_api.c       | 11 +++++++++
> >   net/sched/sch_generic.c   |  8 ++++++
> >   4 files changed, 73 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 5d74fa7e694c..6a252b1b0680 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -1357,4 +1357,8 @@ static inline void qdisc_synchronize(const struct=
 Qdisc *q)
> >               msleep(1);
> >   }
> >
> > +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struc=
t netlink_ext_ack *extack);
> > +void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
> > +void bpf_qdisc_reset_post_op(struct Qdisc *sch);
> > +
> >   #endif
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index 28959424eab0..7c155207fe1e 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -8,6 +8,10 @@
> >
> >   static struct bpf_struct_ops bpf_Qdisc_ops;
> >
> > +struct bpf_sched_data {
> > +     struct qdisc_watchdog watchdog;
> > +};
> > +
> >   struct bpf_sk_buff_ptr {
> >       struct sk_buff *skb;
> >   };
> > @@ -17,6 +21,32 @@ static int bpf_qdisc_init(struct btf *btf)
> >       return 0;
> >   }
> >
> > +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
> > +                       struct netlink_ext_ack *extack)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +
> > +     qdisc_watchdog_init(&q->watchdog, sch);
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(bpf_qdisc_init_pre_op);
> > +
> > +void bpf_qdisc_reset_post_op(struct Qdisc *sch)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +
> > +     qdisc_watchdog_cancel(&q->watchdog);
> > +}
> > +EXPORT_SYMBOL(bpf_qdisc_reset_post_op);
> > +
> > +void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +
> > +     qdisc_watchdog_cancel(&q->watchdog);
> > +}
> > +EXPORT_SYMBOL(bpf_qdisc_destroy_post_op);
>
> These feel like the candidates for the ".gen_prologue" and ".gen_epilogue=
". Then
> the changes to sch_api.c is not needed.
>

I will switch to gen_prologue and gen_epilogue in the next version.
Thank you so much for working on this.

> > +
> >   static const struct bpf_func_proto *
> >   bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
> >                        const struct bpf_prog *prog)
> > @@ -134,12 +164,25 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buf=
f *skb,
> >       __qdisc_drop(skb, (struct sk_buff **)to_free_list);
> >   }
> >
> > +/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time usin=
g a timer.
> > + * @sch: The qdisc to be scheduled.
> > + * @expire: The expiry time of the timer.
> > + * @delta_ns: The slack range of the timer.
> > + */
> > +__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 ex=
pire, u64 delta_ns)
> > +{
> > +     struct bpf_sched_data *q =3D qdisc_priv(sch);
> > +
> > +     qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
> > +}
> > +
> >   __bpf_kfunc_end_defs();
> >
> >   #define BPF_QDISC_KFUNC_xxx \
> >       BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
> >       BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
> >       BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
> > +     BPF_QDISC_KFUNC(bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS) \
> >
> >   BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
> >   #define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
> > @@ -154,9 +197,14 @@ BPF_QDISC_KFUNC_xxx
> >
> >   static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> >   {
> > -     if (kfunc_id =3D=3D bpf_qdisc_skb_drop_ids[0])
> > +     if (kfunc_id =3D=3D bpf_qdisc_skb_drop_ids[0]) {
> >               if (strcmp(prog->aux->attach_func_name, "enqueue"))
> >                       return -EACCES;
> > +     } else if (kfunc_id =3D=3D bpf_qdisc_watchdog_schedule_ids[0]) {
> > +             if (strcmp(prog->aux->attach_func_name, "enqueue") &&
> > +                 strcmp(prog->aux->attach_func_name, "dequeue"))
> > +                     return -EACCES;
> > +     }
> >
> >       return 0;
> >   }
> > @@ -189,6 +237,7 @@ static int bpf_qdisc_init_member(const struct btf_t=
ype *t,
> >       case offsetof(struct Qdisc_ops, priv_size):
> >               if (uqdisc_ops->priv_size)
> >                       return -EINVAL;
> > +             qdisc_ops->priv_size =3D sizeof(struct bpf_sched_data);
>
> ah. ok. The priv_size case is still needed.
>
>

