Return-Path: <bpf+bounces-35771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1293DAAE
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E421F234C2
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A714A097;
	Fri, 26 Jul 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ulo2gV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78B1E485;
	Fri, 26 Jul 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033065; cv=none; b=XzuBgGsDknG6Y25KvfhFxadS5Zt9ZXs8kTecip1wZ27Cxm98r4SlBDq11t6aFJSY0FxwBWVci92qs9O5db16I5NFDTafLUa7/CfD/Kv8XrvzeWsX2Gm6EyVJIwfM2PeqZovPgsEyVwcDExz9VxxjQWnaL6VFhhFE0Ci4u7tlOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033065; c=relaxed/simple;
	bh=LqkTHWoh7gU4KztgNsixQq0LllADeH3NCkY2b5vA/1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIUc44yBsC50xKAYSF2xxo1wXoklIDXg7NYv26Mg3c2kSMHhqDoKcqRhepXVRa4cX7krbwgtHEvfmeouZe0Ga+n7jwaAKS1/dmyNOiwj3qBv1I0vCEIxeXXWdg8tlKMvgBKiTwyDGu+eJXkibb617RIqdJB1O0y4qAKvTgRWeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8ulo2gV; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b2d502c6eso185415276.0;
        Fri, 26 Jul 2024 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722033061; x=1722637861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYw4tFK7mu1KCj90cmx09thjezug2/Jmx6ycESmOh+k=;
        b=P8ulo2gVImILE/CYKQ9FWFwdvMQaY6G0IgmkFAtdpnIeiz8ABSCjdGL3ZVSLRF8nzJ
         gfCwvtkOyausPStmCZQ+/T542cPtifUiSKvGRQyGL16tnIWR2sMtN8XsjfTsNdz97ScX
         2KfeswgQQyZ++TMKg7ih2N0oPvRd/WvsD6Oid6RIaRby+d7zKJIOUE6dEZLmYzlY/DjC
         gyGy5dCCNVSM4tlEPQ2LIrBrI6HWW4jCp/DigIBYwK1xIVcpM5KU6IPPOBEaPHTEeIDq
         aI+V1N/6fX83uonTWUWYAnwflRVHFjDFDcBRklBeuu3kXirZLRHZq7LE7BNETl14FsTG
         QK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722033061; x=1722637861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYw4tFK7mu1KCj90cmx09thjezug2/Jmx6ycESmOh+k=;
        b=gQIsBI7w2Qz06ZIDg5hdcHGfNdktJfmkA+FNHhGFMNEPo9wJctMNxF7qbqa97t8lkI
         H6QWUlQS1fCsm5VabTm9pVKrGb6lcjnhi8xTwUnEsJHKVIZMPslNOQ5j6RFv+awU5KTu
         gI/0VMlRARGX6eVqy4Q9hAMTSkxHqCoHnN7zHPlWMEeTP/I/On46osk8urpkU0xq6gM3
         475tWtHmJxFpHQkD1ZCFU4J8qKG16QdTiShbkdumyq/vQbVjn1EHZrzgSdFBLQM6eYNs
         LxBZWVpS+KoSfACQX5eK+zXcjfW7X5OxLzqPHA2IXGx85BigtJc+CdMhscN1d5Jmw0DE
         58Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWUT36j7x6InwLtpRltH4384UjHxp57VEHWBnDWOoo1yYHDzKS6kfkweYsfJUVKAknWGnCZ+KC8xkDTqwRqym+O29lXht3v
X-Gm-Message-State: AOJu0Yxhv4bz8qTlrO0byVIsYTj0VaGaeyt2t754/89GKVgzdDtJkmyg
	AP/0sMiNalI4F2U6KQAyJi5u4hlDuv/GCbBlLxNTSRHfKwvb1PzZKsT7ubqb/GqQw3FClJ/WBLD
	FgMjyM77DjOzsWZIC7nu7XpImb0g=
X-Google-Smtp-Source: AGHT+IF4RI3Llp5do8qXbp/4TVIzt7/oxRiYAXOfjItMX8dWzJSXIEh6a2ISCzyO573xS9bQqMzgOCe6jXeRdRl0HFM=
X-Received: by 2002:a25:ad45:0:b0:e08:7cec:fc99 with SMTP id
 3f1490d57ef6-e0b544fd01bmr1325400276.18.1722033061451; Fri, 26 Jul 2024
 15:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-8-amery.hung@bytedance.com> <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
In-Reply-To: <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 26 Jul 2024 15:30:50 -0700
Message-ID: <CAMB2axNNmoGAE8DBULe8Pjd3jtc=Tt4xKCyamPwqtB8fT5j75A@mail.gmail.com>
Subject: Re: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional
 operators in Qdisc_ops
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:15=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/14/24 10:51 AM, Amery Hung wrote:
> > So far, init, reset, and destroy are implemented by bpf qdisc infra as
> > fixed operators that manipulate the watchdog according to the occasion.
> > This patch allows users to implement these three operators to perform
> > desired work alongside the predefined ones.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   include/net/sch_generic.h |  6 ++++++
> >   net/sched/bpf_qdisc.c     | 20 ++++----------------
> >   net/sched/sch_api.c       | 11 +++++++++++
> >   net/sched/sch_generic.c   |  8 ++++++++
> >   4 files changed, 29 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 214ed2e34faa..3041782b7527 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -1359,4 +1359,10 @@ static inline void qdisc_synchronize(const struc=
t Qdisc *q)
> >               msleep(1);
> >   }
> >
> > +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> > +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struc=
t netlink_ext_ack *extack);
> > +void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
> > +void bpf_qdisc_reset_post_op(struct Qdisc *sch);
> > +#endif
> > +
> >   #endif
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index eff7559aa346..903b4eb54510 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -9,9 +9,6 @@
> >   static struct bpf_struct_ops bpf_Qdisc_ops;
> >
> >   static u32 unsupported_ops[] =3D {
> > -     offsetof(struct Qdisc_ops, init),
> > -     offsetof(struct Qdisc_ops, reset),
> > -     offsetof(struct Qdisc_ops, destroy),
> >       offsetof(struct Qdisc_ops, change),
> >       offsetof(struct Qdisc_ops, attach),
> >       offsetof(struct Qdisc_ops, change_real_num_tx),
> > @@ -36,8 +33,8 @@ static int bpf_qdisc_init(struct btf *btf)
> >       return 0;
> >   }
> >
> > -static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
> > -                          struct netlink_ext_ack *extack)
> > +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
> > +                       struct netlink_ext_ack *extack)
> >   {
> >       struct bpf_sched_data *q =3D qdisc_priv(sch);
> >
> > @@ -45,14 +42,14 @@ static int bpf_qdisc_init_op(struct Qdisc *sch, str=
uct nlattr *opt,
> >       return 0;
> >   }
> >
> > -static void bpf_qdisc_reset_op(struct Qdisc *sch)
> > +void bpf_qdisc_reset_post_op(struct Qdisc *sch)
> >   {
> >       struct bpf_sched_data *q =3D qdisc_priv(sch);
> >
> >       qdisc_watchdog_cancel(&q->watchdog);
> >   }
> >
> > -static void bpf_qdisc_destroy_op(struct Qdisc *sch)
> > +void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
>
> The reset_post_ops and destroy_post_op are identical. They only do
> qdisc_watchdog_cancel().
>
> >   {
> >       struct bpf_sched_data *q =3D qdisc_priv(sch);
> >
> > @@ -235,15 +232,6 @@ static int bpf_qdisc_init_member(const struct btf_=
type *t,
> >                       return -EINVAL;
> >               qdisc_ops->static_flags =3D TCQ_F_BPF;
> >               return 1;
> > -     case offsetof(struct Qdisc_ops, init):
> > -             qdisc_ops->init =3D bpf_qdisc_init_op;
> > -             return 1;
> > -     case offsetof(struct Qdisc_ops, reset):
> > -             qdisc_ops->reset =3D bpf_qdisc_reset_op;
> > -             return 1;
> > -     case offsetof(struct Qdisc_ops, destroy):
> > -             qdisc_ops->destroy =3D bpf_qdisc_destroy_op;
> > -             return 1;
> >       case offsetof(struct Qdisc_ops, peek):
> >               if (!uqdisc_ops->peek)
> >                       qdisc_ops->peek =3D qdisc_peek_dequeued;
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 5064b6d2d1ec..9fb9375e2793 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -1352,6 +1352,13 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >               rcu_assign_pointer(sch->stab, stab);
> >       }
> >
> > +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> > +     if (sch->flags & TCQ_F_BPF) {
>
> I can see the reason why this patch is needed. It is a few line changes a=
nd they
> are not in the fast path... still weakly not excited about them but I kno=
w it
> could be a personal preference.
>
> I think at the very least, instead of adding a new TCQ_F_BPF, let see if =
the
> "owner =3D=3D BPF_MODULE_OWNER" test can be reused like how it is done in=
 the
> bpf_try_module_get().
>

Thanks for the suggestion. Will do.

>
> A rough direction I am spinning...
>
> The pre/post is mainly to initialize and cleanup the "struct bpf_sched_da=
ta"
> before/after calling the bpf prog.
>
> For the pre (init), there is a ".gen_prologue(...., const struct bpf_prog
> *prog)" in the "bpf_verifier_ops". Take a look at the tc_cls_act_prologue=
().
> It calls a BPF_FUNC_skb_pull_data helper. It potentially can call a kfunc
> bpf_qdisc_watchdog_cancel. However, the gen_prologue is invoked too late =
in the
> verifier for kfunc calling now. This will need some thoughts and works.
>
> For the post (destroy,reset), there is no "gen_epilogue" now. If
> bpf_qdisc_watchdog_schedule() is not allowed to be called in the ".reset"=
 and
> ".destroy" bpf prog. I think it can be changed to pre also? There is a ".=
filter"
> function in the "struct btf_kfunc_id_set" during the kfunc register.
>

I can see how that would work. The ability to add prologue, epilogue
to struct_ops operators is one thing on my wish list.

Meanwhile, I am not sure whether that should be written in the kernel
or rewritten by the verifier. An argument for keeping it in the kernel
is that the prologue or epilogue can get quite complex and involves
many kernel structures not exposed to the bpf program (pre-defined ops
in Qdisc_ops in v8).

Maybe we can keep the current approach in the initial version as they
are not in the fast path, and then move to (gen_prologue,
gen_epilogue) once the plumbing is done?

> > +             err =3D bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], exta=
ck);
> > +             if (err !=3D 0)
> > +                     goto err_out4;
> > +     }
> > +#endif
> >       if (ops->init) {
> >               err =3D ops->init(sch, tca[TCA_OPTIONS], extack);
> >               if (err !=3D 0)
> > @@ -1388,6 +1395,10 @@ static struct Qdisc *qdisc_create(struct net_dev=
ice *dev,
> >        */
> >       if (ops->destroy)
> >               ops->destroy(sch);
> > +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> > +     if (sch->flags & TCQ_F_BPF)
> > +             bpf_qdisc_destroy_post_op(sch);
> > +#endif
> >       qdisc_put_stab(rtnl_dereference(sch->stab));
> >   err_out3:
> >       lockdep_unregister_key(&sch->root_lock_key);
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 76e4a6efd17c..0ac05665c69f 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -1033,6 +1033,10 @@ void qdisc_reset(struct Qdisc *qdisc)
> >
> >       if (ops->reset)
> >               ops->reset(qdisc);
> > +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> > +     if (qdisc->flags & TCQ_F_BPF)
> > +             bpf_qdisc_reset_post_op(qdisc);
> > +#endif
> >
> >       __skb_queue_purge(&qdisc->gso_skb);
> >       __skb_queue_purge(&qdisc->skb_bad_txq);
> > @@ -1076,6 +1080,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
> >
> >       if (ops->destroy)
> >               ops->destroy(qdisc);
> > +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> > +     if (qdisc->flags & TCQ_F_BPF)
> > +             bpf_qdisc_destroy_post_op(qdisc);
> > +#endif
> >
> >       lockdep_unregister_key(&qdisc->root_lock_key);
> >       bpf_module_put(ops, ops->owner);
>

