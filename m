Return-Path: <bpf+bounces-73521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF19C335DF
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233F818C1BD8
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B32DCF50;
	Tue,  4 Nov 2025 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHl9/a3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551327F166
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298469; cv=none; b=gUutCn5eR2rwSHAHUrSw82emhZggzrsuW0h6jxChXDcNCYOCV7GdMykmEN6elPU1N5JSpBLKLcDL0MExCwAMID5JWzARlPF3uDB/WiESAh2NVINN+UDex0oN9Z+t1hkLFWN3vHyESERTtGlE2ZT0f+NaW7NWnNsTHjdcCutwV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298469; c=relaxed/simple;
	bh=NgQUbqBdgVniha1kKMIKKWy96mVGzZLxjwBTU4JrDQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvnpcTBRXZx6IFnOMIlWuk48tYdM1zKjsrAe5xH1rvje2EI6EwsbCODiirErwqrGEjkXv6LxuTKegD02Ah2MTn0kbuiACmKa4kfzyV1nf5rkwJOV72+TsWi8zLwcGD3SGmOzejd5Xy1orGUWWEpgN0r09Jq9iZ9CIuW/kgExdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHl9/a3t; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34088fbd65aso5189435a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298467; x=1762903267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o352oLldK+m217WHfsZVlsJiiTd5rrIsqpGhmKyBzFs=;
        b=MHl9/a3t18E77crvUHqHGU8X5MD794VbOa7BTGulDSvRk6CKEnA/QG/+NeHJ72apVK
         f5oF3LxIdigMYBqiGIZEWei7KA2S1m0rBvuEiR2r++5KAot1XPtBGA7rOmbnt1Z45M6J
         tn3cgu6hGQgxNKzlcydId23pV4fids19kQjx9IJQV1ts9Fxov3N23sbYB9AhjlD/c+8O
         w9BAdDAFY4Rygroz4ZqI7xPfZzzRS/ARvAqHEk0M9mR743MyjfLKEX3kdLf03cMMza0N
         NZYOjIITw1ta+ijJU7+oeDJP8hQ74OWkGFT9mMyFdbXO08H6VICxXw7y406b6OPycxgS
         3QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298467; x=1762903267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o352oLldK+m217WHfsZVlsJiiTd5rrIsqpGhmKyBzFs=;
        b=B+XJI7kVyGe3b4dnto8Z5EwKYwMmA4/uJf6IwFUfxVeuYAac1N4rKyez3ro1i58gRE
         gu+UqHntWB0S4l2dsMuTU1i7JDSf7oUfVKuDNnZ9us8UDTLOhonOp9h3m/ELQRheunqd
         YAw7plJKqOotjAXKiEyL/NMiIkCQlKZcVX+4ifxEHD6klfBEvqzBRclXyk22PPeCOVA5
         Uj4fIyg1fYSYrmtwJMHiaA2xeGfZOdJMrMkNNHxKGF7EzciTpDc25QtMCqoo9H/vSrSx
         KidCPlVUox47gMV6aPH0dWiDqBdqaRAtbfeS0a5Hc1110cO7Dtm9cv0+5N1BWeGLs80v
         H4Zg==
X-Gm-Message-State: AOJu0YxdUtTzWn7P4Z7Qd1ngouqB9rVefSZYRYVB/CWPdkfJc2YnoLOe
	R17a4cpfdYZcU8pwkkrz85rjW581h1fMwdDvmCzP2riCJSrB5bVsh8Y8PffOjmVbocd+/tNB7y7
	lHT+msr5zl1ROFWvbZ4SBCKJlAW2rMD5Ixg==
X-Gm-Gg: ASbGncs7LbeMhPf8VLE7suTAdDNr+CFm1wJHLvqOyCTD8tVgOPn06T3Rtmf+OsXEerd
	EvXOxDxhyLGsC4JCSh2h+dKlMyqRk29AFRcfLuBbLWzI+CKNblU2EtL7pdt5yKAeZe4sODEUUic
	YA0kN92jYIdS7QKeWmLzwIPlIUgZOEEn3wb01om27Bv20sdqDdzU9EwpP2roCgBTgkXmMCmgmXD
	T6Hk9hGT5gab1zUCXWCqR4Y9e26reU5l6+RM4+h09gR/m0c5M7Oy3hP8YXoV81Ntlc7cpRWWDGl
X-Google-Smtp-Source: AGHT+IHVxXmQM+6ZFlmn8oeEN16S1yh+ceATZ0yp+NzsAxaCE+Hy0JsNLdI13GJq1/Y4jRdCAcxXSjhIc4JI71aVKPw=
X-Received: by 2002:a17:90b:384a:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-341a6c00daamr1087424a91.8.1762298466824; Tue, 04 Nov 2025
 15:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-4-ameryhung@gmail.com>
In-Reply-To: <20251104172652.1746988-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 15:20:52 -0800
X-Gm-Features: AWmQ_bnFMAv4_P7-6IwjR4ypBQRRR95KM2j6PVEm5pB5mFoNANk1D0MGj2M8CJY
Message-ID: <CAEf4BzY+1PAE94PfoE=3VQVEYHWAiJP5btkx+u+UBjaZt_k==A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Take a refcount of the associated struct_ops map to prevent the map from
> being freed when an async callback scheduled from a struct_ops program
> runs.
>
> Since struct_ops programs do not take refcounts on the struct_ops map,
> it is possible for a struct_ops map to be freed when an async callback
> scheduled from it runs. To prevent this, take a refcount on prog->aux->
> st_ops_assoc and save it in a newly created struct bpf_async_res for
> every async mechanism. The reference needs to be preserved in
> bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
> and reference leak could happen.
>
> bpf_async_res will contain a async callback's BPF program and resources
> related to the BPF program. The resources will be acquired when
> registering a callback and released when cancelled or when the map
> associated with the callback is freed.
>
> Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
> what it now does.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/helpers.c | 105 +++++++++++++++++++++++++++++--------------
>  1 file changed, 72 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 930e132f440f..5c081cd604d5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1092,9 +1092,14 @@ static void *map_key_from_value(struct bpf_map *ma=
p, void *value, u32 *arr_idx)
>         return (void *)value - round_up(map->key_size, 8);
>  }
>
> +struct bpf_async_res {

"res" has a strong "result" meaning, which is a distraction here.
Maybe "bpf_async_ctx"? And then we can use prep and put (reset?)
terminology?

> +       struct bpf_prog *prog;
> +       struct bpf_map *st_ops_assoc;
> +};
> +
>  struct bpf_async_cb {
>         struct bpf_map *map;
> -       struct bpf_prog *prog;
> +       struct bpf_async_res res;
>         void __rcu *callback_fn;
>         void *value;
>         union {
> @@ -1299,8 +1304,8 @@ static int __bpf_async_init(struct bpf_async_kern *=
async, struct bpf_map *map, u
>                 break;
>         }
>         cb->map =3D map;
> -       cb->prog =3D NULL;
>         cb->flags =3D flags;
> +       memset(&cb->res, 0, sizeof(cb->res));
>         rcu_assign_pointer(cb->callback_fn, NULL);
>
>         WRITE_ONCE(async->cb, cb);
> @@ -1351,11 +1356,47 @@ static const struct bpf_func_proto bpf_timer_init=
_proto =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> +static void bpf_async_res_put(struct bpf_async_res *res)
> +{
> +       bpf_prog_put(res->prog);
> +
> +       if (res->st_ops_assoc)
> +               bpf_map_put(res->st_ops_assoc);
> +}
> +
> +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_prog =
*prog)
> +{
> +       struct bpf_map *st_ops_assoc =3D NULL;
> +       int err;
> +
> +       prog =3D bpf_prog_inc_not_zero(prog);
> +       if (IS_ERR(prog))
> +               return PTR_ERR(prog);
> +
> +       st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);

I think in about a month we'll forget why we inc_not_zero only for
STRUCT_OPS programs, so I'd add comment here that non-struct_ops
programs have explicit refcount on st_ops_assoc, so as long as we have
that inc_not_zero(prog) above, we don't need to also bump map refcount

> +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> +           st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> +               st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
> +               if (IS_ERR(st_ops_assoc)) {
> +                       err =3D PTR_ERR(st_ops_assoc);
> +                       goto put_prog;

nit: might be a bit premature to structure code with goto put_prog. As of n=
ow:


bpf_prog_put(prog);
return PTR_ERR(st_ops_assoc);

is short and sweet and good enough?

> +               }
> +       }
> +
> +       res->prog =3D prog;
> +       res->st_ops_assoc =3D st_ops_assoc;

question: do we want to assign BPF_PTR_POISON to res->st_ops_assoc or
is it better to keep it as NULL in such a case? I'm not sure, just
bringing up the possibility

> +       return 0;
> +put_prog:
> +       bpf_prog_put(prog);
> +       return err;
> +}
> +
>  static int __bpf_async_set_callback(struct bpf_async_kern *async, void *=
callback_fn,
>                                     struct bpf_prog_aux *aux, unsigned in=
t flags,
>                                     enum bpf_async_type type)
>  {
>         struct bpf_prog *prev, *prog =3D aux->prog;
> +       struct bpf_async_res res;
>         struct bpf_async_cb *cb;
>         int ret =3D 0;
>
> @@ -1376,20 +1417,18 @@ static int __bpf_async_set_callback(struct bpf_as=
ync_kern *async, void *callback
>                 ret =3D -EPERM;
>                 goto out;
>         }
> -       prev =3D cb->prog;
> +       prev =3D cb->res.prog;
>         if (prev !=3D prog) {
> -               /* Bump prog refcnt once. Every bpf_timer_set_callback()
> +               /* Get prog and related resources once. Every bpf_timer_s=
et_callback()
>                  * can pick different callback_fn-s within the same prog.
>                  */
> -               prog =3D bpf_prog_inc_not_zero(prog);
> -               if (IS_ERR(prog)) {
> -                       ret =3D PTR_ERR(prog);
> +               ret =3D bpf_async_res_get(&res, prog);
> +               if (ret)
>                         goto out;
> -               }
>                 if (prev)
> -                       /* Drop prev prog refcnt when swapping with new p=
rog */
> -                       bpf_prog_put(prev);
> -               cb->prog =3D prog;
> +                       /* Put prev prog and related resources when swapp=
ing with new prog */
> +                       bpf_async_res_put(&cb->res);
> +               cb->res =3D res;
>         }

we discussed this offline, but I'll summarize here:

I think we need to abstract this away as bpf_async_ctx_update(), which
will accept a new prog pointer, and internally will deal with
necessary ref count inc/put as necessary, depending on whether prog
changed or not. With st_ops_assoc, prog pointer may not change, but
the underlying st_ops_assoc might (it can go from NULL to valid
assoc). And the implementation will be careful to leave previous async
ctx as it was if anything goes wrong (just like existing code
behaves).

>         rcu_assign_pointer(cb->callback_fn, callback_fn);
>  out:
> @@ -1423,7 +1462,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *=
, timer, u64, nsecs, u64, fla
>                 return -EINVAL;
>         __bpf_spin_lock_irqsave(&timer->lock);
>         t =3D timer->timer;
> -       if (!t || !t->cb.prog) {
> +       if (!t || !t->cb.res.prog) {
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> @@ -1451,14 +1490,14 @@ static const struct bpf_func_proto bpf_timer_star=
t_proto =3D {
>         .arg3_type      =3D ARG_ANYTHING,
>  };
>
> -static void drop_prog_refcnt(struct bpf_async_cb *async)
> +static void bpf_async_cb_reset(struct bpf_async_cb *cb)
>  {
> -       struct bpf_prog *prog =3D async->prog;
> +       struct bpf_prog *prog =3D cb->res.prog;
>
>         if (prog) {
> -               bpf_prog_put(prog);
> -               async->prog =3D NULL;
> -               rcu_assign_pointer(async->callback_fn, NULL);
> +               bpf_async_res_put(&cb->res);
> +               memset(&cb->res, 0, sizeof(cb->res));

shouldn't bpf_async_res_put() leave cb->res in zeroed out state? why
extra memset(0)?

> +               rcu_assign_pointer(cb->callback_fn, NULL);
>         }
>  }
>

[...]

