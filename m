Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45E6575AC8
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiGOFKC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGOFKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:10:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF8E753A9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:10:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k30so4886221edk.8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gv/oQanSYPVPu7xpUnANgXEexgqi1G96uAOKlRF6+pQ=;
        b=RnlU6UgQHgtCMmxcI8GZRTZFjY0Lqa9HegoFEGRvVvqHXS2mYsx3Qq9caf6AcX/2Hw
         RVQEAZboemLVnUy9Hq5zaq4SvbFveWf5at2PyLbQ0KkQ4Ujw974uXcZf5dBnigZvEiAM
         tnVfkaAMEgJGJ3k2k65pWze9iKWDavFzZz7y8a/MHAgqROfU3e3Vnwof4WOcP1fg1RZk
         lQOI6oscTMkCEFc0eaeBmavQIQs4G5YChWmvIng1Tojs0iP/sd48qPHxrEL4uBgMPg8t
         7ytr6j/JGxMbEeUeCSSZ9oYdUW4sbkYMAzmugt6roLX1XeF2p/JydSb7OII48AXnR75W
         dW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gv/oQanSYPVPu7xpUnANgXEexgqi1G96uAOKlRF6+pQ=;
        b=bHYFxBHTNOtjvjEY4LDZgfIUs3SGzzEbFgr2z0SPu/wLjNsHS2347S9wOtXeACFM+e
         0jlMd+T0ALTPSVraAtB3kxn6r1GYJ+HiEr0yAoWBin9/AA9+Ru41yvWhCPGXqoG2vn5c
         wxFyXd33+83TupSXGH0mNjzibeIQshEmC73pryvksxpmP8tsZ7cECWoX7ZCY49XmRVBm
         rmMVRA9V0LwC1fvg9dttmpwLm3i7FwweACveqEP3Su3/itKtEYOXdlDyukNm9qRKfBpM
         qbs+eOmUhorfKNRQ1XeuXsUzJ2kTgae7h3TX4hZoV8G5M3kpR4OybDhG0h9Ckw0eI6Hj
         bJ9A==
X-Gm-Message-State: AJIora9fwPuDoI6PYj+zokzCkXOSg3b46L3FbyXF+l0oCxzkn4hjE+LM
        g2q+5mzcQR5dCmKNM3XytU0SPlQqGoFvH7QrilX3pzrj3Mo=
X-Google-Smtp-Source: AGRyM1v0Ouf8Jd/IU4dPDDY1Kr12bjAweivNpn1KCTKbLnX1Y0vD4LHaOXNeqkQE/LJhuqokXSw4EYgB6qXO3aff3wk=
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id
 n4-20020aa7c784000000b0043acaa875b9mr16156038eds.311.1657861798592; Thu, 14
 Jul 2022 22:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220714214305.3189551-1-andrii@kernel.org> <20220714214305.3189551-2-andrii@kernel.org>
 <20220715045755.e5swvwkf6isxm7xj@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220715045755.e5swvwkf6isxm7xj@macbook-pro-3.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 22:09:47 -0700
Message-ID: <CAEf4Bza3smUgGUO5TSO3Q3x=+CTKCB8zDZrdCVaTLObXQn7DQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: fix potential 32-bit overflow when
 accessing ARRAY map element
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 9:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 14, 2022 at 02:43:02PM -0700, Andrii Nakryiko wrote:
> > If BPF array map is bigger than 4GB, element pointer calculation can
> > overflow because both index and elem_size are u32. Fix this everywhere
> > by forcing 64-bit multiplication. Extract this formula into separate
> > small helper and use it consistently in various places.
> >
> > Speculative-preventing formula utilizing index_mask trick is left as is,
> > but explicit u64 casts are added in both places.
> >
> > Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/arraymap.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index fe40d3b9458f..d3dfc28dbb05 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -156,6 +156,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
> >       return &array->map;
> >  }
> >
> > +static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
> > +{
> > +     return array->value + (u64)array->elem_size * (index & array->index_mask);
> > +}
> > +
> >  /* Called from syscall or from eBPF program */
> >  static void *array_map_lookup_elem(struct bpf_map *map, void *key)
> >  {
> > @@ -165,7 +170,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
> >       if (unlikely(index >= array->map.max_entries))
> >               return NULL;
> >
> > -     return array->value + array->elem_size * (index & array->index_mask);
> > +     return array->value + (u64)array->elem_size * (index & array->index_mask)
> >  }
> >
> >  static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
> > @@ -339,7 +344,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
> >                      value, map->value_size);
> >       } else {
> >               val = array->value +
> > -                     array->elem_size * (index & array->index_mask);
> > +                     (u64)array->elem_size * (index & array->index_mask);
> >               if (map_flags & BPF_F_LOCK)
> >                       copy_map_value_locked(map, val, value, false);
> >               else
> > @@ -408,8 +413,7 @@ static void array_map_free_timers(struct bpf_map *map)
> >               return;
> >
> >       for (i = 0; i < array->map.max_entries; i++)
> > -             bpf_timer_cancel_and_free(array->value + array->elem_size * i +
> > -                                       map->timer_off);
> > +             bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
> >  }
> >
> >  /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
> > @@ -420,7 +424,7 @@ static void array_map_free(struct bpf_map *map)
> >
> >       if (map_value_has_kptrs(map)) {
> >               for (i = 0; i < array->map.max_entries; i++)
> > -                     bpf_map_free_kptrs(map, array->value + array->elem_size * i);
> > +                     bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
>
> This is incorrect. There is no need to mask pointer here.
> There is no security issue here.

Hm.. not sure what happened, but this is not the version of the patch
that I intended to send, sorry about that. I'll resend correct
version.
