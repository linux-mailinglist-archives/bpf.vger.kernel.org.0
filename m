Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A246E1B8D
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDNFPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 01:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNFPd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 01:15:33 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75727524B
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:15:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a13so17781470ybl.11
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681449331; x=1684041331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRImYcpI3L5Qpp5fpS21YSTLzTniZGOeEgg/cV5n7I4=;
        b=KmperwrJHFrWJmfigg+khDVBI99jKUCW2tjqqD6k89cjSXKKV/XC88fnGuqCl2dyfu
         R1WIokk2jQWE9++bYA/cIKuZCy3B1wFZxQy7++ojkF/Lhk6watyFyNfVpexQ/pyWnMzn
         2xa13xd52AQJphZgTzE0JI6J+EXHGq1YVNSt/QYByv3qXnTLEBzkvnMFTzBiKhCK+jE6
         862WU/yVlitIai7jesH4i2OQvC/BPwc2ti5+/lhLpHAr8UDRqKH+eAQV58AlgQymVAi4
         6QXUxLwDm0ONmRFgZ6LvmEysBtq3sqZ9APTFE6gP+AIxcH4FWv7oJ67COv2rmXTluBFM
         rUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681449331; x=1684041331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRImYcpI3L5Qpp5fpS21YSTLzTniZGOeEgg/cV5n7I4=;
        b=R5fijkJZ1m0CH2p2PEmqBODO9tTSgHplNP10Bu4F5atcwt2Cea9pavUzYrSgziM1ar
         vX4iwWHwfcuqOUPCYzw1g/z/13WnCYQfAb2vWCQfuuUXA9NyC7eIrvFJvc/dGGpMsiTl
         cZLokTnIdi8jYPJEzcjfXrcJKeltnd+Uyo15Uvsk5/5Dtv85w29Dh4Mfbrdq8IAQEhKE
         RK8tlSYGddxkOghFkhqsLfhIjFh04d6vgiqwLxXEv9xuC5qt48jy95LaLMS/swVp10XR
         wNXyR1822+mO0Oqgsg7F/tD1dj97rrhE0DLt8mBXiiMRGnElrpZk+jQbKxQ7B8ru7RTR
         tPNg==
X-Gm-Message-State: AAQBX9cx6wqxWloLwec5sq30bL13EJAH9vjdMcJHW4dJcsxmTfpZ/GzE
        0TaD19HurgCvypWQwjWlniFTiP9ofmxFxJtS6rezmjE7FBB9Dw==
X-Google-Smtp-Source: AKy350YNKLRCK0CLX+02aypxubokTg4+1XMKbGs+4ACSSSSchURGA/XlTsbkfpvpZ3s6DZd3TURIu1E8/nc3bP5Zk4I=
X-Received: by 2002:a25:d68a:0:b0:b8f:1d87:5948 with SMTP id
 n132-20020a25d68a000000b00b8f1d875948mr3090634ybg.10.1681449331541; Thu, 13
 Apr 2023 22:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-2-joannelkoong@gmail.com> <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
In-Reply-To: <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 13 Apr 2023 22:15:20 -0700
Message-ID: <CAJnrk1aynU2Ee1bTtEjMv50ajvDjQEQQZm6jMdBEwHsCH-ke5A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
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

On Wed, Apr 12, 2023 at 2:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > bpf_dynptr_trim decreases the size of a dynptr by the specified
> > number of bytes (offset remains the same). bpf_dynptr_advance advances
> > the offset of the dynptr by the specified number of bytes (size
> > decreases correspondingly).
> >
> > Trimming or advancing the dynptr may be useful in certain situations.
> > For example, when hashing which takes in generic dynptrs, if the dynptr
> > points to a struct but only a certain memory region inside the struct
> > should be hashed, advance/trim can be used to narrow in on the
> > specific region to hash.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b6a5cda5bb59..51b4c4b5dbed 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_=
kern *ptr)
> >         return ptr->size & DYNPTR_SIZE_MASK;
> >  }
> >
> > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_s=
ize)
> > +{
> > +       u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > +
> > +       ptr->size =3D new_size | metadata;
> > +}
> > +
> >  int bpf_dynptr_check_size(u32 size)
> >  {
> >         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > @@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const st=
ruct bpf_dynptr_kern *ptr, u32 o
> >         return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> >  }
> >
> > +/* For dynptrs, the offset may only be advanced and the size may only =
be decremented */
> > +static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_inc,=
 u32 sz_dec)
>
> it feels like this helper just makes it a bit harder to follow what's
> going on. Half of this function isn't actually executed for
> bpf_dynptr_trim, so I don't think we are saving all that much code,
> maybe let's code each of advance and trim explicitly?
>

Sounds good, I will change this in v2 to handle advance and trim separately

> > +{
> > +       u32 size;
> > +
> > +       if (!ptr->data)
> > +               return -EINVAL;
> > +
> > +       size =3D bpf_dynptr_get_size(ptr);
> > +
> > +       if (sz_dec > size)
> > +               return -ERANGE;
> > +
> > +       if (off_inc) {
> > +               u32 new_off;
> > +
> > +               if (off_inc > size)
>
> like here it becomes confusing if off_inc includes sz_dec, or they
> should be added to each other. I think it's convoluted as is.
>
>
> > +                       return -ERANGE;
> > +
> > +               if (check_add_overflow(ptr->offset, off_inc, &new_off))
>
> why do we need to worry about overflow, we checked all the error
> conditions above?..

Ahh you're right, this cant overflow u32. The dynptr max supported
size is 2^24 - 1 as well

>
> > +                       return -ERANGE;
> > +
> > +               ptr->offset =3D new_off;
> > +       }
> > +
> > +       bpf_dynptr_set_size(ptr, size - sz_dec);
> > +
> > +       return 0;
> > +}
> > +
> > +__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 le=
n)
> > +{
> > +       return bpf_dynptr_adjust(ptr, len, len);
> > +}
> > +
> > +__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 len)
>
> I'm also wondering if trim operation is a bit unusual for dealing
> ranges? Instead of a relative size decrement, maybe it's more
> straightforward to have bpf_dynptr_resize() to set new desired size?
> So if someone has original dynptr with 100 bytes but wants to have
> dynptr for bytes [10, 30), they'd do a pretty natural:
>
> bpf_dynptr_advance(&dynptr, 10);
> bpf_dynptr_resize(&dynptr, 20);
>
> ?
>

Yeah! I like this idea a lot, that way they dont' need to know the
current size of the dynptr before they trim. This seems a lot more
ergonomic

> > +{
> > +       return bpf_dynptr_adjust(ptr, 0, len);
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >         return obj;
> > @@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_=
NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_dynptr_trim)
> > +BTF_ID_FLAGS(func, bpf_dynptr_advance)
> >  BTF_SET8_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.34.1
> >
