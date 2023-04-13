Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E56E0321
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMAXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDMAXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:23:03 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2D30F3;
        Wed, 12 Apr 2023 17:23:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i20so17398682ybg.10;
        Wed, 12 Apr 2023 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47786Tvo3ubPUPg9a1KKyqdwsppQ194bsP0ErYUBcqc=;
        b=JqReUdKbdz67Vp17QrC2pIGcNYpdXBHXrNIU0xljpop/4JuxN8p9UrVXHkryipWl18
         WXzsbkx0j0OiEMQZaR8kk9PsNlJwU4Sh5+zBwywyVn3nRr27VJxe4KC95sagzxBisqTw
         gKtOWRm9eEwkJycwTHj7TqjsVCDfg4gblJBjFSTHz/VDugx5h3kLML5o/KHJmArQxpss
         tdGd9zg9A6ikINT/+PzZImxM5MmRJiudEsrc/uNL5rJgk0rjnBNTt2F1bSptlc8UBYZY
         7j83DxoGqxxj3EJImgkpj/BJCxFmM+6YnhbipSDvWAC8W5Eo/JJ82XaI9+ieQnYrvoMl
         Ph6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47786Tvo3ubPUPg9a1KKyqdwsppQ194bsP0ErYUBcqc=;
        b=AqyigX+f1fCbh0szO+cIlEfCdV1cAb3A897R/jLlC04SlfHFuOLvxzBKErA+JV4Lm9
         zXX1mO3WMsY0KR8ilLUr/dCJwDWJ0cf/TldVEYgyUO0R2f610AirAqGevxS4Fm62VAJ6
         PYFV17e6rx4MMuaD6VY42cJIOozlJ4U6ds5a+q81R2OXm6EQ2SQAHSe42stOVEQ3pmPN
         AkgsVO0rWLupNzRqDC5rTszShS5miIV9HolKhfU9ZEQ7KvHn7UQMpfcHmqgLIGkydN/N
         ld6ME7LHffeOIcUGZekjUXDrNeXDVlFTTbzGZDTDmNv41MASpkJnYo7jXrlNWttZsbPO
         OR1Q==
X-Gm-Message-State: AAQBX9fOU4O/QZzI6+4hDjkoQoC3lBd7jOyh7s9i1qpy9zU5ZQ/Ktxc2
        cDB8SGjxmm0gGKi+xOE6St7Nm6hREHgfR4T8l/o9uXLf
X-Google-Smtp-Source: AKy350Zc54TDwX8o90Z/NIo8V08DhKT5BFMhyJhzCWEZrJ28cH8fUlmw3v0HdAi4ANnb/4IkbawNH3X+hu2FYXwtnhI=
X-Received: by 2002:a25:6c41:0:b0:b8f:1d2c:243f with SMTP id
 h62-20020a256c41000000b00b8f1d2c243fmr220574ybc.1.1681345379916; Wed, 12 Apr
 2023 17:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-3-andrii@kernel.org>
 <6436f01e.a70a0220.e12e2.828e@mx.google.com>
In-Reply-To: <6436f01e.a70a0220.e12e2.828e@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:22:46 -0700
Message-ID: <CAEf4BzZhNJuSfOCgDWnDjMv5nYiCeZEJHyDRsU-h7-2CGZvhMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: inline map creation logic in
 map_create() function
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 10:53=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:54PM -0700, Andrii Nakryiko wrote:
> > Keep all the relevant generic sanity checks, permission checks, and
> > creation and initialization logic in one linear piece of code. Currentl=
y
> > helper function that handles memory allocation and partial
> > initialization is split apart and is about 1000 lines higher in the
> > file, hurting readability.
>
> At first glance, this seems like a step in the wrong direction: having a
> single-purpose function pulled out of a larger one seems like a good
> thing for stuff like unit testing, etc. Unless there's a reason later in
> the series for this inlining (which should be called out in the
> changelog here), I would say if it is only readability, just move the
> function down 1000 lines but leave it a separate function.

Oh, I should probably clarify this in the commit message. This
function is not that single-function, really. It performs some sanity
checking and then allocates and (partially) initializes the BPF map
itself. By "inlining" it, it makes it possible to perform these sanity
checks first, then do capabilities/security checks, and only if both
pass, allocate and initialize the map. Next patch inserts
(centralizes) all the spread out capabilities checks from per-map
custom callbacks into the same function, right before performing map
allocation and initialization, but after validation of parameters.

So yeah, I do take advantage of this in the next patch, because LSM
hook gets validated bpf_uattr. I'll call this out more clearly. It's
definitely not just moving code around for no good reason.


>
> -Kees
>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 54 ++++++++++++++++++--------------------------
> >  1 file changed, 22 insertions(+), 32 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c1d268025985..a090737f98ea 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -108,37 +108,6 @@ const struct bpf_map_ops bpf_map_offload_ops =3D {
> >       .map_mem_usage =3D bpf_map_offload_map_mem_usage,
> >  };
> >
> > -static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
> > -{
> > -     const struct bpf_map_ops *ops;
> > -     u32 type =3D attr->map_type;
> > -     struct bpf_map *map;
> > -     int err;
> > -
> > -     if (type >=3D ARRAY_SIZE(bpf_map_types))
> > -             return ERR_PTR(-EINVAL);
> > -     type =3D array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
> > -     ops =3D bpf_map_types[type];
> > -     if (!ops)
> > -             return ERR_PTR(-EINVAL);
> > -
> > -     if (ops->map_alloc_check) {
> > -             err =3D ops->map_alloc_check(attr);
> > -             if (err)
> > -                     return ERR_PTR(err);
> > -     }
> > -     if (attr->map_ifindex)
> > -             ops =3D &bpf_map_offload_ops;
> > -     if (!ops->map_mem_usage)
> > -             return ERR_PTR(-EINVAL);
> > -     map =3D ops->map_alloc(attr);
> > -     if (IS_ERR(map))
> > -             return map;
> > -     map->ops =3D ops;
> > -     map->map_type =3D type;
> > -     return map;
> > -}
> > -
> >  static void bpf_map_write_active_inc(struct bpf_map *map)
> >  {
> >       atomic64_inc(&map->writecnt);
> > @@ -1124,7 +1093,9 @@ static int map_check_btf(struct bpf_map *map, con=
st struct btf *btf,
> >  /* called via syscall */
> >  static int map_create(union bpf_attr *attr)
> >  {
> > +     const struct bpf_map_ops *ops;
> >       int numa_node =3D bpf_map_attr_numa_node(attr);
> > +     u32 map_type =3D attr->map_type;
> >       struct btf_field_offs *foffs;
> >       struct bpf_map *map;
> >       int f_flags;
> > @@ -1167,9 +1138,28 @@ static int map_create(union bpf_attr *attr)
> >               return -EINVAL;
> >
> >       /* find map type and init map: hashtable vs rbtree vs bloom vs ..=
. */
> > -     map =3D find_and_alloc_map(attr);
> > +     map_type =3D attr->map_type;
> > +     if (map_type >=3D ARRAY_SIZE(bpf_map_types))
> > +             return -EINVAL;
> > +     map_type =3D array_index_nospec(map_type, ARRAY_SIZE(bpf_map_type=
s));
> > +     ops =3D bpf_map_types[map_type];
> > +     if (!ops)
> > +             return -EINVAL;
> > +
> > +     if (ops->map_alloc_check) {
> > +             err =3D ops->map_alloc_check(attr);
> > +             if (err)
> > +                     return err;
> > +     }
> > +     if (attr->map_ifindex)
> > +             ops =3D &bpf_map_offload_ops;
> > +     if (!ops->map_mem_usage)
> > +             return -EINVAL;
> > +     map =3D ops->map_alloc(attr);
> >       if (IS_ERR(map))
> >               return PTR_ERR(map);
> > +     map->ops =3D ops;
> > +     map->map_type =3D map_type;
> >
> >       err =3D bpf_obj_name_cpy(map->name, attr->map_name,
> >                              sizeof(attr->map_name));
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
