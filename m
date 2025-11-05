Return-Path: <bpf+bounces-73744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D8C384C2
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67ACB4F7EAA
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655C2C11D0;
	Wed,  5 Nov 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJvTQoHu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451E1FDE31
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383803; cv=none; b=KiV4aLy17IYcXs8KA7O6nekZzQI0lO4BHG/qlfXXT7l1pZEDBQ4RXXPK0M0TBz1qXLtyJAQ9KxxKOPMI8DFC9zp6QVSYdvuxB/EdVJKX0JH+1TX2pihIUSpp+QMZrwH+l7bbzEXbsPHRkZJrbBaCVPfFarU3Di+/FRe98FxS/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383803; c=relaxed/simple;
	bh=GY7jCgCGhF08LV1OF1/1p5SByHwkFKGLZfSK8x9ZjUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1uA+21nITbQseXMXOsmEbQvTA57DRCLaOULVh2P3cOeR+wJRuiihQqX53umboM3edIpEKzGul4010IsMriKn1f2ewlbV9/ok3662JrCcBD9N21+8vh3/qE5O1Sx8lbNPGK0sWAh2aCh7ZAWWBLC0KXZ8J9o9s7XG2JFFziMyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJvTQoHu; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f996d4e1aso444299d50.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 15:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383800; x=1762988600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3cppbthmZOAdsO1AD4sUOmwz7AiXgoJgthxIEy3/qY=;
        b=AJvTQoHu6J0AUclewlY2Di54jOfqymkVrJWM32ZJqPFHoNjsj+j06g5xA/UPuKgBFb
         BtgzALRhfqIFYyNT3f0b8Z/+4ssOmc42OUDPpXzw3b0jLz2x9Gwgocw1NaD5vjclf8/D
         dB+aqTmVaeIY4i7BHesZ39vEGEtsWQUidimURT8CTo099zY8yl5iiArQWSO9t4+idZDw
         bwEw72RS8UQSsw2haN0ufEFGDQiTcMw9H3nppD5RBid82QtzwMInWCEY65z9wUvzhN3N
         iX15lRZ7mnxqsorx9eDy7eydrdpl80xv3IyzetqkQOMgEiWuwuHKBJwvHVNpfEvUMD0W
         4vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383800; x=1762988600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3cppbthmZOAdsO1AD4sUOmwz7AiXgoJgthxIEy3/qY=;
        b=tNhx6nHi6aemgi6jMVH/ZplwhWEn5VXtEySwnA1NglV08FIAJVZCiFnhGKF9jNOP7F
         Beht8vImPuu0tjWWeXFRy1z/BeMuMOvPJSY9It6IwqKuVl2AZsXpcA5Ozix415ANCJXA
         QZuzPKkxhKrGtX9kMPpjJpwFg67ODSVvCDL3sLsoXz7WNdSYSUvt1gyjGgGqoIKzopR0
         qbwuP9cZggnfCXHesPXJ6jsu79c9t36sbONovtpCBtpc5nNZor/a/r1IUKjE12xyN0xZ
         oGsrGSXEieYCzDnkPu5KEngvPLVJ8npyY9ZDOd6kD0k0roN5vLrWCTP40XYa6SNhx8tw
         mOaA==
X-Gm-Message-State: AOJu0YxGYErg51Gwu79F2ALQpflDAGZZNKe4cqyGQxmcPceqjRrBMd7A
	dKZTu3dLLCXxt++dpUNNMcUDDAOP5+C7ne8biZi+1RpigKo9s58ixn7X+sC3dNTYPd5TFQ4jAC1
	h81Jz6opLrXb1AV9p1HkWlZOz2gFIyMo=
X-Gm-Gg: ASbGncvq3ywTbk0CJufazbTKpWHtHx9gz65tpcikersXz/Us8vRX1UCx5wWlPeMgKvx
	cptWz2JPQSrwA5IZORjBUJAfMhn/in9aR3Qi8yoDQDy7uJUjWr/dubCgc/yfHUEIWf2rgRIrE0O
	bvQznnDCeHUcmNL9JjaghsaFqXp7KCrc6bbfOPXxUi0Fu5I8Px6LPVu0BNNyg0+zzPKU+Bo2ocE
	3PSaF9lVRM7yJjSQ/LstQ7cH3nHge+iept3IEE82SbLS7ehehOzZaQHWHFz
X-Google-Smtp-Source: AGHT+IF0niXd31IzenW6htM+C2nJjrWM6RBGfjhfMdGbngpSyU3XlueY8rCzmwNxY42g9fGV6fHVjoHHePhxIH4UIDI=
X-Received: by 2002:a05:690e:159a:10b0:63f:b12f:e992 with SMTP id
 956f58d0204a3-63fd355ba57mr3699056d50.34.1762383800499; Wed, 05 Nov 2025
 15:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-4-ameryhung@gmail.com>
 <CAEf4BzY+1PAE94PfoE=3VQVEYHWAiJP5btkx+u+UBjaZt_k==A@mail.gmail.com>
In-Reply-To: <CAEf4BzY+1PAE94PfoE=3VQVEYHWAiJP5btkx+u+UBjaZt_k==A@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Nov 2025 15:03:09 -0800
X-Gm-Features: AWmQ_bnuznQAMiyG_qFYnojzA_LKPc-0h7bkDgwpxPBLRMIY-yvXDDveLdzll8A
Message-ID: <CAMB2axMNzemRgxQfNLi2GrTYJdmgchSH+ND6+QaFQM2m9ygajQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > Take a refcount of the associated struct_ops map to prevent the map fro=
m
> > being freed when an async callback scheduled from a struct_ops program
> > runs.
> >
> > Since struct_ops programs do not take refcounts on the struct_ops map,
> > it is possible for a struct_ops map to be freed when an async callback
> > scheduled from it runs. To prevent this, take a refcount on prog->aux->
> > st_ops_assoc and save it in a newly created struct bpf_async_res for
> > every async mechanism. The reference needs to be preserved in
> > bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
> > and reference leak could happen.
> >
> > bpf_async_res will contain a async callback's BPF program and resources
> > related to the BPF program. The resources will be acquired when
> > registering a callback and released when cancelled or when the map
> > associated with the callback is freed.
> >
> > Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
> > what it now does.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 105 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 72 insertions(+), 33 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 930e132f440f..5c081cd604d5 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1092,9 +1092,14 @@ static void *map_key_from_value(struct bpf_map *=
map, void *value, u32 *arr_idx)
> >         return (void *)value - round_up(map->key_size, 8);
> >  }
> >
> > +struct bpf_async_res {
>
> "res" has a strong "result" meaning, which is a distraction here.
> Maybe "bpf_async_ctx"? And then we can use prep and put (reset?)
> terminology?
>
> > +       struct bpf_prog *prog;
> > +       struct bpf_map *st_ops_assoc;
> > +};
> > +
> >  struct bpf_async_cb {
> >         struct bpf_map *map;
> > -       struct bpf_prog *prog;
> > +       struct bpf_async_res res;
> >         void __rcu *callback_fn;
> >         void *value;
> >         union {
> > @@ -1299,8 +1304,8 @@ static int __bpf_async_init(struct bpf_async_kern=
 *async, struct bpf_map *map, u
> >                 break;
> >         }
> >         cb->map =3D map;
> > -       cb->prog =3D NULL;
> >         cb->flags =3D flags;
> > +       memset(&cb->res, 0, sizeof(cb->res));
> >         rcu_assign_pointer(cb->callback_fn, NULL);
> >
> >         WRITE_ONCE(async->cb, cb);
> > @@ -1351,11 +1356,47 @@ static const struct bpf_func_proto bpf_timer_in=
it_proto =3D {
> >         .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > +static void bpf_async_res_put(struct bpf_async_res *res)
> > +{
> > +       bpf_prog_put(res->prog);
> > +
> > +       if (res->st_ops_assoc)
> > +               bpf_map_put(res->st_ops_assoc);
> > +}
> > +
> > +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_pro=
g *prog)
> > +{
> > +       struct bpf_map *st_ops_assoc =3D NULL;
> > +       int err;
> > +
> > +       prog =3D bpf_prog_inc_not_zero(prog);
> > +       if (IS_ERR(prog))
> > +               return PTR_ERR(prog);
> > +
> > +       st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
>
> I think in about a month we'll forget why we inc_not_zero only for
> STRUCT_OPS programs, so I'd add comment here that non-struct_ops
> programs have explicit refcount on st_ops_assoc, so as long as we have
> that inc_not_zero(prog) above, we don't need to also bump map refcount

Will document this in the comment.

>
> > +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +           st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> > +               st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
> > +               if (IS_ERR(st_ops_assoc)) {
> > +                       err =3D PTR_ERR(st_ops_assoc);
> > +                       goto put_prog;
>
> nit: might be a bit premature to structure code with goto put_prog. As of=
 now:
>
>
> bpf_prog_put(prog);
> return PTR_ERR(st_ops_assoc);
>
> is short and sweet and good enough?

Yes. We can change it to this style once there are more fields in bpf_async=
_ctx.

>
> > +               }
> > +       }
> > +
> > +       res->prog =3D prog;
> > +       res->st_ops_assoc =3D st_ops_assoc;
>
> question: do we want to assign BPF_PTR_POISON to res->st_ops_assoc or
> is it better to keep it as NULL in such a case? I'm not sure, just
> bringing up the possibility

As this doesn't make a difference on what
bpf_prog_get_assoc_struct_ops() returns, I'd keep it as NULL to
simplify things.

>
> > +       return 0;
> > +put_prog:
> > +       bpf_prog_put(prog);
> > +       return err;
> > +}
> > +
> >  static int __bpf_async_set_callback(struct bpf_async_kern *async, void=
 *callback_fn,
> >                                     struct bpf_prog_aux *aux, unsigned =
int flags,
> >                                     enum bpf_async_type type)
> >  {
> >         struct bpf_prog *prev, *prog =3D aux->prog;
> > +       struct bpf_async_res res;
> >         struct bpf_async_cb *cb;
> >         int ret =3D 0;
> >
> > @@ -1376,20 +1417,18 @@ static int __bpf_async_set_callback(struct bpf_=
async_kern *async, void *callback
> >                 ret =3D -EPERM;
> >                 goto out;
> >         }
> > -       prev =3D cb->prog;
> > +       prev =3D cb->res.prog;
> >         if (prev !=3D prog) {
> > -               /* Bump prog refcnt once. Every bpf_timer_set_callback(=
)
> > +               /* Get prog and related resources once. Every bpf_timer=
_set_callback()
> >                  * can pick different callback_fn-s within the same pro=
g.
> >                  */
> > -               prog =3D bpf_prog_inc_not_zero(prog);
> > -               if (IS_ERR(prog)) {
> > -                       ret =3D PTR_ERR(prog);
> > +               ret =3D bpf_async_res_get(&res, prog);
> > +               if (ret)
> >                         goto out;
> > -               }
> >                 if (prev)
> > -                       /* Drop prev prog refcnt when swapping with new=
 prog */
> > -                       bpf_prog_put(prev);
> > -               cb->prog =3D prog;
> > +                       /* Put prev prog and related resources when swa=
pping with new prog */
> > +                       bpf_async_res_put(&cb->res);
> > +               cb->res =3D res;
> >         }
>
> we discussed this offline, but I'll summarize here:
>
> I think we need to abstract this away as bpf_async_ctx_update(), which
> will accept a new prog pointer, and internally will deal with
> necessary ref count inc/put as necessary, depending on whether prog
> changed or not. With st_ops_assoc, prog pointer may not change, but
> the underlying st_ops_assoc might (it can go from NULL to valid
> assoc). And the implementation will be careful to leave previous async
> ctx as it was if anything goes wrong (just like existing code
> behaves).

How about three APIs like below. First we just bump refcounts
unconditionally with prepare(). Then, xchg the local bpf_async_ctx
with the one embedded in callbacks with update(), and drop refcount in
cleanup().

This will have some overhead as there are unnecessary atomic op, but
can make update() much straightforward.

static void bpf_async_ctx_cleanup(struct bpf_async_ctx *ctx)
{
        bpf_prog_put(ctx->prog);

        if (ctx->st_ops_assoc)
                bpf_map_put(ctx->st_ops_assoc);

        memset(&ctx, 0, sizeof(*ctx));
}

static int bpf_async_ctx_prepare(struct bpf_async_ctx *ctx, struct
bpf_prog *prog)
{
        struct bpf_map *st_ops_assoc =3D NULL;
        int err;

        prog =3D bpf_prog_inc_not_zero(prog);
        if (IS_ERR(prog))
                return PTR_ERR(prog);

        st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
        if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
            st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
                st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
                if (IS_ERR(st_ops_assoc)) {
                        bpf_prog_put(prog);
                        return PTR_ERR(st_ops_assoc);
                }
        }

        ctx->prog =3D prog;
        ctx->st_ops_assoc =3D st_ops_assoc;
        return 0;
}

static void bpf_async_ctx_update(struct bpf_async_ctx *ctx, struct
bpf_async_ctx *new)
{
        struct bpf_async_ctx old;

        old =3D *ctx;
        *ctx =3D *new;

        bpf_async_ctx_cleanup(old);
}


>
> >         rcu_assign_pointer(cb->callback_fn, callback_fn);
> >  out:
> > @@ -1423,7 +1462,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern=
 *, timer, u64, nsecs, u64, fla
> >                 return -EINVAL;
> >         __bpf_spin_lock_irqsave(&timer->lock);
> >         t =3D timer->timer;
> > -       if (!t || !t->cb.prog) {
> > +       if (!t || !t->cb.res.prog) {
> >                 ret =3D -EINVAL;
> >                 goto out;
> >         }
> > @@ -1451,14 +1490,14 @@ static const struct bpf_func_proto bpf_timer_st=
art_proto =3D {
> >         .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > -static void drop_prog_refcnt(struct bpf_async_cb *async)
> > +static void bpf_async_cb_reset(struct bpf_async_cb *cb)
> >  {
> > -       struct bpf_prog *prog =3D async->prog;
> > +       struct bpf_prog *prog =3D cb->res.prog;
> >
> >         if (prog) {
> > -               bpf_prog_put(prog);
> > -               async->prog =3D NULL;
> > -               rcu_assign_pointer(async->callback_fn, NULL);
> > +               bpf_async_res_put(&cb->res);
> > +               memset(&cb->res, 0, sizeof(cb->res));
>
> shouldn't bpf_async_res_put() leave cb->res in zeroed out state? why
> extra memset(0)?

Will move memset(0) into bpf_async_res_put().

>
> > +               rcu_assign_pointer(cb->callback_fn, NULL);
> >         }
> >  }
> >
>
> [...]

