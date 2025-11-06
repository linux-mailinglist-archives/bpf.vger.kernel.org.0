Return-Path: <bpf+bounces-73872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B20C3C97C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E7318983E3
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A33376A5;
	Thu,  6 Nov 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbtRwoMh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488C137932
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448066; cv=none; b=Iv9jn1McouRA8OH9K1P/SPtdJr+KuTWYcw0RtM0nCVWBcX1joh/j4FrW04EOvgTAVEGGdcIBlxOxLEw9h3/jHRX3L+tdy7zQtqnAu3xRtV0uUtF4vSti/+WbY5UQ7nqSWeL2W6RIoc1+Pl2jdsPCE3ionESxr2s5R23tGhC6YY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448066; c=relaxed/simple;
	bh=eL4JKRR803xA5+R4XTte3LoFAvYjaqYOwFqXc/EnLB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhb+LBAzOopkTY/VU4fhz3QG5iq1wD7wY8yBfNNZ1ZrezthQLv3rOpQ7tWhjIj9exVjTJn9FxrT8po38f5Y2W/uuR7WBZqp/972XgZYyl0rIaYnwqHXhrWonQF9jO6uX9GHvohs0xgIbyE5wvffKrLLfCCIHvJ+3Qf5UrZsSdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbtRwoMh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34003f73a05so1396662a91.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448064; x=1763052864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hj4ooY08x927tvypPHkHnvR9G+gggkNDMLRyKh9IN9w=;
        b=cbtRwoMh6ls8KhWqU9zmada8tdp74VHvQFjN+XO6tAGd8OTWc4xAwyg2Hc+6T+LaQp
         nZfssjKd+u7dUXF5Cysmu82kpco+QaaaaT/aSTwr0F1LmbIRvIErS0vJRJwjvjQLqg8E
         epLFdNibs2QiapzljfxnjQZnSmTkR74bePvSz6I6nfylmQH7kTKzC/QCv7KMDGQmy04O
         TgJfhRrOQU02GsGnyUwCejTOmTyEE1HT0L6tI0+RBd1XhjHc0h3e4ZTsb/wKt+3rShPm
         EQACtBo2UCup2s2mppUOhHYbaqGxgezM2dfyg3MqkbHRlxb0z8sCwmh4PUYC4AcBatqD
         XWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448064; x=1763052864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hj4ooY08x927tvypPHkHnvR9G+gggkNDMLRyKh9IN9w=;
        b=FpuhSsBPr1fHS0uhLcl0RGSaqsA6iC2yEAjRAjmtwzLHl0AdrYOK0nOcmTdog5vuer
         W0iTI7Gs7Pu4vx2mAqxCw4/G09Xx+S7w6NtI104BqGsGdTjNgzA/PchOJ0Nu9MLx1OFF
         ilxOuVfGr/4eVAxtIfJQF3m5a1NfQqNtv8CDbCQANQlIChaRRshS8DSvkWPa79UxND09
         BLO0V68uDbH7Dl/oFxoNbdH+CFXJ2Jsgd9/F9fXOJKyf83I71iJtaZbFl+UgQOMN7QUe
         J2w9Punr83CqIjsc+Ev3N2X3XIUqydV6C2B9FdfjYgljSVNSKrDx3ABzIq2uwQh6UxBO
         nBOA==
X-Gm-Message-State: AOJu0YyCvncV5QHFyjiJ+s2qnzqfou35gLYHxxm5tDH2oHhavVBfbUdS
	sbqCCHhPFm/2XRqpHDPrXtX9DwYzZs3hLVrVdGpftu8uiPdtI7HQ87hc3TV53dSpryZSV9GYfRu
	XoiRHoPBf6X7zbVBpjdddydQGysz2j6qatA==
X-Gm-Gg: ASbGncs7j1+vsTdfDI5jf3NfZtoXm6CvupEvMhZZbT5QzPDJRjgOftvuPhpVhbVlKlU
	jLoYyeTyEsqX68LSkWK4i7J9cWuEPYcU9YNsOZhiI2eGZO5glq6Qjny/Q1g5HYj/GDJTCNKz8Rf
	4+JiHh7GYGLsmst+9FLPcYPD0mQQ7MrP24BgwGHyZShVIfpGUN7BawY++LqeyngPbOrqAuqilHD
	t4BiIFNcnvP8f0ClEpG1Q7OpcCIFsEFe8HineULSWpxzu9yevFtDn7FQEMxsVxWGqFkfvmQXMri
	3rEYn7KDvfs=
X-Google-Smtp-Source: AGHT+IFIPzVBshvmq+nNzeRnlDT4GwRqAB85hDl2sFlWz+a9WJHxD0jRkIgAQViSnMd2x5alVQhdxnYk5H8Kq5rwWkU=
X-Received: by 2002:a17:90b:3bce:b0:340:f05a:3ece with SMTP id
 98e67ed59e1d1-3434a1ef373mr309187a91.9.1762448063907; Thu, 06 Nov 2025
 08:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-4-ameryhung@gmail.com>
 <CAEf4BzY+1PAE94PfoE=3VQVEYHWAiJP5btkx+u+UBjaZt_k==A@mail.gmail.com> <CAMB2axMNzemRgxQfNLi2GrTYJdmgchSH+ND6+QaFQM2m9ygajQ@mail.gmail.com>
In-Reply-To: <CAMB2axMNzemRgxQfNLi2GrTYJdmgchSH+ND6+QaFQM2m9ygajQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 08:54:11 -0800
X-Gm-Features: AWmQ_bkxyzogYpJ6Y6KUmMZ1viIFLFXRtnxxoHxUyd50fIlL4ns6qEcWRy0QArI
Message-ID: <CAEf4Bza5VjkVsms959iHr-TvXLP3cMt=DYH2UeGzFJZiG1MiJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Nov 4, 2025 at 3:21=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > Take a refcount of the associated struct_ops map to prevent the map f=
rom
> > > being freed when an async callback scheduled from a struct_ops progra=
m
> > > runs.
> > >
> > > Since struct_ops programs do not take refcounts on the struct_ops map=
,
> > > it is possible for a struct_ops map to be freed when an async callbac=
k
> > > scheduled from it runs. To prevent this, take a refcount on prog->aux=
->
> > > st_ops_assoc and save it in a newly created struct bpf_async_res for
> > > every async mechanism. The reference needs to be preserved in
> > > bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
> > > and reference leak could happen.
> > >
> > > bpf_async_res will contain a async callback's BPF program and resourc=
es
> > > related to the BPF program. The resources will be acquired when
> > > registering a callback and released when cancelled or when the map
> > > associated with the callback is freed.
> > >
> > > Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
> > > what it now does.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c | 105 +++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 72 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 930e132f440f..5c081cd604d5 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1092,9 +1092,14 @@ static void *map_key_from_value(struct bpf_map=
 *map, void *value, u32 *arr_idx)
> > >         return (void *)value - round_up(map->key_size, 8);
> > >  }
> > >
> > > +struct bpf_async_res {
> >
> > "res" has a strong "result" meaning, which is a distraction here.
> > Maybe "bpf_async_ctx"? And then we can use prep and put (reset?)
> > terminology?
> >
> > > +       struct bpf_prog *prog;
> > > +       struct bpf_map *st_ops_assoc;
> > > +};
> > > +
> > >  struct bpf_async_cb {
> > >         struct bpf_map *map;
> > > -       struct bpf_prog *prog;
> > > +       struct bpf_async_res res;
> > >         void __rcu *callback_fn;
> > >         void *value;
> > >         union {
> > > @@ -1299,8 +1304,8 @@ static int __bpf_async_init(struct bpf_async_ke=
rn *async, struct bpf_map *map, u
> > >                 break;
> > >         }
> > >         cb->map =3D map;
> > > -       cb->prog =3D NULL;
> > >         cb->flags =3D flags;
> > > +       memset(&cb->res, 0, sizeof(cb->res));
> > >         rcu_assign_pointer(cb->callback_fn, NULL);
> > >
> > >         WRITE_ONCE(async->cb, cb);
> > > @@ -1351,11 +1356,47 @@ static const struct bpf_func_proto bpf_timer_=
init_proto =3D {
> > >         .arg3_type      =3D ARG_ANYTHING,
> > >  };
> > >
> > > +static void bpf_async_res_put(struct bpf_async_res *res)
> > > +{
> > > +       bpf_prog_put(res->prog);
> > > +
> > > +       if (res->st_ops_assoc)
> > > +               bpf_map_put(res->st_ops_assoc);
> > > +}
> > > +
> > > +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_p=
rog *prog)
> > > +{
> > > +       struct bpf_map *st_ops_assoc =3D NULL;
> > > +       int err;
> > > +
> > > +       prog =3D bpf_prog_inc_not_zero(prog);
> > > +       if (IS_ERR(prog))
> > > +               return PTR_ERR(prog);
> > > +
> > > +       st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
> >
> > I think in about a month we'll forget why we inc_not_zero only for
> > STRUCT_OPS programs, so I'd add comment here that non-struct_ops
> > programs have explicit refcount on st_ops_assoc, so as long as we have
> > that inc_not_zero(prog) above, we don't need to also bump map refcount
>
> Will document this in the comment.
>
> >
> > > +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > > +           st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> > > +               st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
> > > +               if (IS_ERR(st_ops_assoc)) {
> > > +                       err =3D PTR_ERR(st_ops_assoc);
> > > +                       goto put_prog;
> >
> > nit: might be a bit premature to structure code with goto put_prog. As =
of now:
> >
> >
> > bpf_prog_put(prog);
> > return PTR_ERR(st_ops_assoc);
> >
> > is short and sweet and good enough?
>
> Yes. We can change it to this style once there are more fields in bpf_asy=
nc_ctx.
>
> >
> > > +               }
> > > +       }
> > > +
> > > +       res->prog =3D prog;
> > > +       res->st_ops_assoc =3D st_ops_assoc;
> >
> > question: do we want to assign BPF_PTR_POISON to res->st_ops_assoc or
> > is it better to keep it as NULL in such a case? I'm not sure, just
> > bringing up the possibility
>
> As this doesn't make a difference on what
> bpf_prog_get_assoc_struct_ops() returns, I'd keep it as NULL to
> simplify things.
>
> >
> > > +       return 0;
> > > +put_prog:
> > > +       bpf_prog_put(prog);
> > > +       return err;
> > > +}
> > > +
> > >  static int __bpf_async_set_callback(struct bpf_async_kern *async, vo=
id *callback_fn,
> > >                                     struct bpf_prog_aux *aux, unsigne=
d int flags,
> > >                                     enum bpf_async_type type)
> > >  {
> > >         struct bpf_prog *prev, *prog =3D aux->prog;
> > > +       struct bpf_async_res res;
> > >         struct bpf_async_cb *cb;
> > >         int ret =3D 0;
> > >
> > > @@ -1376,20 +1417,18 @@ static int __bpf_async_set_callback(struct bp=
f_async_kern *async, void *callback
> > >                 ret =3D -EPERM;
> > >                 goto out;
> > >         }
> > > -       prev =3D cb->prog;
> > > +       prev =3D cb->res.prog;
> > >         if (prev !=3D prog) {
> > > -               /* Bump prog refcnt once. Every bpf_timer_set_callbac=
k()
> > > +               /* Get prog and related resources once. Every bpf_tim=
er_set_callback()
> > >                  * can pick different callback_fn-s within the same p=
rog.
> > >                  */
> > > -               prog =3D bpf_prog_inc_not_zero(prog);
> > > -               if (IS_ERR(prog)) {
> > > -                       ret =3D PTR_ERR(prog);
> > > +               ret =3D bpf_async_res_get(&res, prog);
> > > +               if (ret)
> > >                         goto out;
> > > -               }
> > >                 if (prev)
> > > -                       /* Drop prev prog refcnt when swapping with n=
ew prog */
> > > -                       bpf_prog_put(prev);
> > > -               cb->prog =3D prog;
> > > +                       /* Put prev prog and related resources when s=
wapping with new prog */
> > > +                       bpf_async_res_put(&cb->res);
> > > +               cb->res =3D res;
> > >         }
> >
> > we discussed this offline, but I'll summarize here:
> >
> > I think we need to abstract this away as bpf_async_ctx_update(), which
> > will accept a new prog pointer, and internally will deal with
> > necessary ref count inc/put as necessary, depending on whether prog
> > changed or not. With st_ops_assoc, prog pointer may not change, but
> > the underlying st_ops_assoc might (it can go from NULL to valid
> > assoc). And the implementation will be careful to leave previous async
> > ctx as it was if anything goes wrong (just like existing code
> > behaves).
>
> How about three APIs like below. First we just bump refcounts
> unconditionally with prepare(). Then, xchg the local bpf_async_ctx
> with the one embedded in callbacks with update(), and drop refcount in
> cleanup().
>

Do we need separate prepare and update steps? Wouldn't they always go
together anyways?

> This will have some overhead as there are unnecessary atomic op, but
> can make update() much straightforward.
>
> static void bpf_async_ctx_cleanup(struct bpf_async_ctx *ctx)
> {
>         bpf_prog_put(ctx->prog);
>
>         if (ctx->st_ops_assoc)
>                 bpf_map_put(ctx->st_ops_assoc);
>
>         memset(&ctx, 0, sizeof(*ctx));
> }
>
> static int bpf_async_ctx_prepare(struct bpf_async_ctx *ctx, struct
> bpf_prog *prog)
> {
>         struct bpf_map *st_ops_assoc =3D NULL;
>         int err;
>
>         prog =3D bpf_prog_inc_not_zero(prog);
>         if (IS_ERR(prog))
>                 return PTR_ERR(prog);
>
>         st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
>         if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
>             st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
>                 st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
>                 if (IS_ERR(st_ops_assoc)) {
>                         bpf_prog_put(prog);
>                         return PTR_ERR(st_ops_assoc);
>                 }
>         }
>
>         ctx->prog =3D prog;
>         ctx->st_ops_assoc =3D st_ops_assoc;
>         return 0;
> }
>
> static void bpf_async_ctx_update(struct bpf_async_ctx *ctx, struct
> bpf_async_ctx *new)
> {
>         struct bpf_async_ctx old;
>
>         old =3D *ctx;
>         *ctx =3D *new;
>
>         bpf_async_ctx_cleanup(old);
> }
>
>
> >
> > >         rcu_assign_pointer(cb->callback_fn, callback_fn);
> > >  out:
> > > @@ -1423,7 +1462,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_ke=
rn *, timer, u64, nsecs, u64, fla
> > >                 return -EINVAL;
> > >         __bpf_spin_lock_irqsave(&timer->lock);
> > >         t =3D timer->timer;
> > > -       if (!t || !t->cb.prog) {
> > > +       if (!t || !t->cb.res.prog) {
> > >                 ret =3D -EINVAL;
> > >                 goto out;
> > >         }
> > > @@ -1451,14 +1490,14 @@ static const struct bpf_func_proto bpf_timer_=
start_proto =3D {
> > >         .arg3_type      =3D ARG_ANYTHING,
> > >  };
> > >
> > > -static void drop_prog_refcnt(struct bpf_async_cb *async)
> > > +static void bpf_async_cb_reset(struct bpf_async_cb *cb)
> > >  {
> > > -       struct bpf_prog *prog =3D async->prog;
> > > +       struct bpf_prog *prog =3D cb->res.prog;
> > >
> > >         if (prog) {
> > > -               bpf_prog_put(prog);
> > > -               async->prog =3D NULL;
> > > -               rcu_assign_pointer(async->callback_fn, NULL);
> > > +               bpf_async_res_put(&cb->res);
> > > +               memset(&cb->res, 0, sizeof(cb->res));
> >
> > shouldn't bpf_async_res_put() leave cb->res in zeroed out state? why
> > extra memset(0)?
>
> Will move memset(0) into bpf_async_res_put().

I'd rather have explicit NULL assignments for each field that needs to
be cleared. Having "generic" memset(0) will make it easier to forget
to clear stuff (especially if clearing involves some extra operation
wil refcount decrement or whatnot), IMO. I'd do ctx->prog =3D NULL;
ctx->st_ops_assoc =3D NULL.

>
> >
> > > +               rcu_assign_pointer(cb->callback_fn, NULL);
> > >         }
> > >  }
> > >
> >
> > [...]

