Return-Path: <bpf+bounces-56162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B876A92C06
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B3B7A8FE9
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284E2063C8;
	Thu, 17 Apr 2025 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGZv+LG/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158A2AD0C
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920492; cv=none; b=lTt8q6AGoIMmNhU4PvpwY0iZuOTmSmSXMdLyLWoJ9fJoFYs+9YT6l+WCu0dFgjqYMHlVV+VrfDCJXVOjLHypDYxOEWcYCB3/jSkgiRaaPDHefECqwbnQPfUOmNECzL/2gtafeVYnkbcWvaJepP6mUXOums41A2NzZReBvnotVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920492; c=relaxed/simple;
	bh=gj/D0mycuUszU/OjPejcmKakSn9TgTGPubIBKtvzFFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDSViqkjHK2IVJb28KV3IrEOcUYqVIxD2jpKILVn7qz49h11ZOIsloXG+3nSxXLvEuKYacIkr+AmLX5pZTJCL51r1HwEshFwGG40rEoM01G0YONRjz0ZDN0+5iHddHTREIasPKetsVJFxKjzOeKEdZswhMQS0IWGMethq3g/Q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGZv+LG/; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso241650266b.0
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920489; x=1745525289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdQTomgK30a8bwQ9s8VvRY3iGtigYvX7eIjanRIRchg=;
        b=UGZv+LG/ZzS5KiiP57o18endgw5WGmLdg66rEzk1w8Zg+w64oeI70fR7j2J8KxRv8z
         YnuAiuDBunt+ncJfJr/lkcZB10JIZptG2O9zglHD7fY4arWR9OKZt63nVGLYIS7UAv8q
         ICerC866Hqa7sT9dil2AngQ7V3zoOvVknCoVg9pDQYypAERum/3unjTMGCKZ8fTCWSHD
         /ZO85eE9ITjeY7n9HEZqw7mq6LDPErDtCjlBxRoXi8ciHn7cSM3G02ynotOnwsSix3zi
         X9QsJciQ72LZgXDE6l/jYMi4j7sH0lZUNePEQntXwvp06p3MU2VTF34PMbMjNhFs6wZ6
         GzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920489; x=1745525289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdQTomgK30a8bwQ9s8VvRY3iGtigYvX7eIjanRIRchg=;
        b=hyiYux3asyDjDk6b4MTk/7rhAdc+t3ywtdNx628pn7L/KgV7gAs19MRvKlsGejaA2y
         ufShvfl4SHj/1w8Cx9Ck9RqTk4EhYEPpq68OJujVpQmzqquXWe2tXhhTAP07/NC+zoLt
         zLY+UIG5EWUDC+4+S2zttS2O6HOG0+iro2aDNOloIXgH5Z9TSYwN6tCpjZq8rvDLHGuJ
         tGo8NQgNzwr1ic75OZnTFnjZAJ6zGzVtzyKAbG1nSjp6j5uRDul9w6Xmg7yNmGbrlhQN
         E5XiSHa1692jmWmTypbeQP0Xn1VZIXLCoH/MaTEb5HNILvDNRGzl3HNGhGlGuTtRkOIz
         mJsA==
X-Gm-Message-State: AOJu0YwFcQGv4LYUsvWpCi0ZEDbfy8zXYsRsAkWJO3Hw+gbgBhtrY+Cb
	pGuT9j0+VgBaIfy4d4BDsI5VD2Ybm/UyvC7LCMmHl02zH4fZkYB0bxPqbvMgTbQoTlSrGJ8ZJZe
	2FZGSSGDD+ODmInIXtkn5DRpMxvc=
X-Gm-Gg: ASbGnct+TSlXjlWGXzWrzuq9VBk4IcHdvjbcjNSgO97kecGT2pBXGMbqpv2y3uTPDpO
	NGDMj2zzEgDEA+1QPlK7uxIOD88XY66+RZNHg6z2PHEzEh1KBQ+ySho+uXeeMhfEK2RpA+RwZzu
	NTU6lUh0Wspx9F3cj/gNC7tipxy028t7IgsGQcAizbyzc=
X-Google-Smtp-Source: AGHT+IHFYlmIsacXf0zaxmSuKSBxlJaGwSfeZvj/Boh7AraZGyrAHYZ1n328eDbMeWXvL9llQwXm5n+ks6T6Bsr979s=
X-Received: by 2002:a17:907:7288:b0:abf:6a53:2cd5 with SMTP id
 a640c23a62f3a-acb74dd0190mr15627666b.48.1744920488616; Thu, 17 Apr 2025
 13:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-7-memxor@gmail.com>
 <CAEf4BzY1xE=3f--Gd-xf_5bKMAEC5z5fF8PsFNkg3Q8Wjob6Bg@mail.gmail.com>
In-Reply-To: <CAEf4BzY1xE=3f--Gd-xf_5bKMAEC5z5fF8PsFNkg3Q8Wjob6Bg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 22:07:32 +0200
X-Gm-Features: ATxdqUFAe5x64RdI_MM-O142yoWl7PBv27fUMbPjaOyEr1PpTck7_B-B-3qjVmE
Message-ID: <CAP01T76nPMevP656EMeqR5Q3W6mz2Hswnv0=8fiH8w5=9mXzcw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 06/13] bpf: Introduce bpf_dynptr_from_mem_slice
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 at 23:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> > PTR_TO_BTF_ID exposing a variable-length slice of memory, represented b=
y
> > the new bpf_mem_slice type. This slice is read-only, for a read-write
> > slice we can expose a distinct type in the future.
> >
> > We rely on the previous commits ensuring source objects underpinning
> > dynptr memory are tracked correctly for invalidation to ensure when a
> > PTR_TO_BTF_ID holding a memory slice goes away, it's corresponding
> > dynptrs get invalidated.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   |  5 +++++
> >  kernel/bpf/helpers.c  | 32 ++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c |  6 +++++-
> >  3 files changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 3f0cc89c0622..9feaa9bbf0a4 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1344,6 +1344,11 @@ enum bpf_dynptr_type {
> >         BPF_DYNPTR_TYPE_XDP,
> >  };
> >
> > +struct bpf_mem_slice {
> > +       void *ptr;
> > +       size_t len;
>
> for better future extensibility and to avoid big-endian issues, let's hav=
e
>
> u32 len;
> u32 __reserved; /* or flags */
>

Ack.

> ?
>
> > +};
> > +
> >  int bpf_dynptr_check_size(u32 size);
> >  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> >  const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 l=
en);
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e3a2662f4e33..95e9c9df6062 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2826,6 +2826,37 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynpt=
r *dst_ptr, u32 dst_off,
> >         return 0;
> >  }
> >
> > +/**
> > + * XXX
> > + */
> > +__bpf_kfunc int bpf_dynptr_from_mem_slice(struct bpf_mem_slice *mem_sl=
ice, u64 flags, struct bpf_dynptr *dptr__uninit)
> > +{
> > +       struct bpf_dynptr_kern *dptr =3D (struct bpf_dynptr_kern *)dptr=
__uninit;
> > +       int err;
> > +
> > +       if (!mem_slice)
> > +               return -EINVAL;
>
> you have to initialize dynptr regardless of errors, just like
> bpf_dynptr_from_mem() does, so
>
> err =3D -EINVAL;
> goto error;

Thanks for catching this, will fix.

>
>
> > +
> > +       err =3D bpf_dynptr_check_size(mem_slice->len);
> > +       if (err)
> > +               goto error;
> > +
> > +       /* flags is currently unsupported */
> > +       if (flags) {
> > +               err =3D -EINVAL;
> > +               goto error;
> > +       }
> > +
> > +       bpf_dynptr_init(dptr, mem_slice->ptr, BPF_DYNPTR_TYPE_LOCAL, 0,=
 mem_slice->len);
> > +       bpf_dynptr_set_rdonly(dptr);
> > +
> > +       return 0;
> > +
> > +error:
> > +       bpf_dynptr_set_null(dptr);
> > +       return err;
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >         return obj;
> > @@ -3275,6 +3306,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> >  BTF_ID_FLAGS(func, bpf_dynptr_copy)
> > +BTF_ID_FLAGS(func, bpf_dynptr_from_mem_slice, KF_TRUSTED_ARGS)
> >  #ifdef CONFIG_NET
> >  BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
> >  #endif
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7e09c4592038..26aa70cd5734 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12125,6 +12125,7 @@ enum special_kfunc_type {
> >         KF_bpf_res_spin_unlock,
> >         KF_bpf_res_spin_lock_irqsave,
> >         KF_bpf_res_spin_unlock_irqrestore,
> > +       KF_bpf_dynptr_from_mem_slice,
> >  };
> >
> >  BTF_SET_START(special_kfunc_set)
> > @@ -12218,6 +12219,7 @@ BTF_ID(func, bpf_res_spin_lock)
> >  BTF_ID(func, bpf_res_spin_unlock)
> >  BTF_ID(func, bpf_res_spin_lock_irqsave)
> >  BTF_ID(func, bpf_res_spin_unlock_irqrestore)
> > +BTF_ID(func, bpf_dynptr_from_mem_slice)
> >
> >  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> >  {
> > @@ -13139,7 +13141,9 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                                 }
> >                         }
> >
> > -                       if (meta->func_id =3D=3D special_kfunc_list[KF_=
bpf_dynptr_from_skb]) {
> > +                       if (meta->func_id =3D=3D special_kfunc_list[KF_=
bpf_dynptr_from_mem_slice]) {
> > +                               dynptr_arg_type |=3D DYNPTR_TYPE_LOCAL;
> > +                       } else if (meta->func_id =3D=3D special_kfunc_l=
ist[KF_bpf_dynptr_from_skb]) {
> >                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
> >                         } else if (meta->func_id =3D=3D special_kfunc_l=
ist[KF_bpf_dynptr_from_xdp]) {
> >                                 dynptr_arg_type |=3D DYNPTR_TYPE_XDP;
> > --
> > 2.47.1
> >

