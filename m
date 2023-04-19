Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B06E7321
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDSGXz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjDSGXy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 02:23:54 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F659751
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 23:23:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n203so19249183ybg.6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681885371; x=1684477371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3U5t7eq6hDbKCpfDJFPVz+2xsR7zcTsXVgLk+6x+jo=;
        b=B7bCVIEUag2xdckybQk+ztR6jG3YkJY3UhTmu4JDloZouLZywsXGXZZEvOmAsfo7iv
         /8KGktrQR4XLBx1rxyOt3TVlB4qPXrIKPQYMjw2GIHumhngK9n07DOxe7slccRur0WvC
         hqRt8bHeQBqqKEbh9roGOxunP+RwyV8eyAzI8SmhAr6GPe8k40db2kCszU6FwI4xgGTH
         YdBx+pZyQvdfHKOsDpwUTAGtXHbwX4bARmEJKQVzKmwDJ73W+7rT81ag7/5A96rv3Cz9
         oW/Bhp2gRunNFhqBeY1h3Yu//UTpKWiwHVo6VWwmIpA29oXcPKs3cEaVlmy2dmEKaBhq
         A9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681885371; x=1684477371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3U5t7eq6hDbKCpfDJFPVz+2xsR7zcTsXVgLk+6x+jo=;
        b=IpXcDd5NqFMCGrLNrsNoVzyJA79opSGBGVrAXlTUJOPGqLxHEd93liJcv6HBUaKeaP
         Sm+1mZPvhoRZoVSjaF4jLJh5xf+UhX+sC03fIHh8fhoCl7zG3whOvAEi6/j9P/ILK2ew
         /1p5gDOAGWD59TExCQFSCar1f+aKJThlY/JplPmMfBq8VMSwN7o44U/fa/X6GmiXTwJE
         /Ue855Let9J1q4Wda25b1p2S/2swKv36uqPwnvR9nNku+9IrUwE6iyZ3SXaBHsIjS/bJ
         F4LHfCUntTv8M/ec53vEoRWvO9xot/QMO0ji/ISZD5q35vNsA3WFHaYvMCJkZ1l32ghW
         DxFg==
X-Gm-Message-State: AAQBX9dx8G275hS83LXgtnTBbxSeC5IlG2ZuP9WxW0n3mHVyJKiN7lw8
        JQTN4rrnLR5O5LSr5HbIRQfw58rKUl/sbzQPzRCm2KsIIGSDuw==
X-Google-Smtp-Source: AKy350bkeK+4O1Qv+7TTHaqkD0neRu4+RahwttfzeErx8M/c4XIuBpHQNHu355KsDd2t5tIilY42bNR173lmLs+aFKU=
X-Received: by 2002:a25:d48c:0:b0:b8e:efd8:f2c with SMTP id
 m134-20020a25d48c000000b00b8eefd80f2cmr897199ybf.1.1681885370720; Tue, 18 Apr
 2023 23:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-2-joannelkoong@gmail.com> <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
 <CAJnrk1aynU2Ee1bTtEjMv50ajvDjQEQQZm6jMdBEwHsCH-ke5A@mail.gmail.com> <CAEf4BzZt9P-LpXZGbQBHCXNhH59MQ3DkNwhbtVK47FjH6V0-BA@mail.gmail.com>
In-Reply-To: <CAEf4BzZt9P-LpXZGbQBHCXNhH59MQ3DkNwhbtVK47FjH6V0-BA@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 18 Apr 2023 23:22:39 -0700
Message-ID: <CAJnrk1bJGhCSQSK=eU9BwrKxkOGe-tR7z3FPWfrM2J7JxUosMg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 4:36=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 13, 2023 at 10:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Wed, Apr 12, 2023 at 2:46=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > > >
> > > > bpf_dynptr_trim decreases the size of a dynptr by the specified
> > > > number of bytes (offset remains the same). bpf_dynptr_advance advan=
ces
> > > > the offset of the dynptr by the specified number of bytes (size
> > > > decreases correspondingly).
> > > >
> > > > Trimming or advancing the dynptr may be useful in certain situation=
s.
> > > > For example, when hashing which takes in generic dynptrs, if the dy=
nptr
> > > > points to a struct but only a certain memory region inside the stru=
ct
> > > > should be hashed, advance/trim can be used to narrow in on the
> > > > specific region to hash.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 49 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index b6a5cda5bb59..51b4c4b5dbed 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dyn=
ptr_kern *ptr)
> > > >         return ptr->size & DYNPTR_SIZE_MASK;
> > > >  }
> > > >
> > > > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 n=
ew_size)
> > > > +{
> > > > +       u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > > > +
> > > > +       ptr->size =3D new_size | metadata;
> > > > +}
> > > > +
> > > >  int bpf_dynptr_check_size(u32 size)
> > > >  {
> > > >         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > > > @@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(cons=
t struct bpf_dynptr_kern *ptr, u32 o
> > > >         return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> > > >  }
> > > >
> > > > +/* For dynptrs, the offset may only be advanced and the size may o=
nly be decremented */
> > > > +static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_=
inc, u32 sz_dec)
> > >
> > > it feels like this helper just makes it a bit harder to follow what's
> > > going on. Half of this function isn't actually executed for
> > > bpf_dynptr_trim, so I don't think we are saving all that much code,
> > > maybe let's code each of advance and trim explicitly?
> > >
> >
> > Sounds good, I will change this in v2 to handle advance and trim separa=
tely
> >
> > > > +{
> > > > +       u32 size;
> > > > +
> > > > +       if (!ptr->data)
> > > > +               return -EINVAL;
> > > > +
> > > > +       size =3D bpf_dynptr_get_size(ptr);
> > > > +
> > > > +       if (sz_dec > size)
> > > > +               return -ERANGE;
> > > > +
> > > > +       if (off_inc) {
> > > > +               u32 new_off;
> > > > +
> > > > +               if (off_inc > size)
> > >
> > > like here it becomes confusing if off_inc includes sz_dec, or they
> > > should be added to each other. I think it's convoluted as is.
> > >
> > >
> > > > +                       return -ERANGE;
> > > > +
> > > > +               if (check_add_overflow(ptr->offset, off_inc, &new_o=
ff))
> > >
> > > why do we need to worry about overflow, we checked all the error
> > > conditions above?..
> >
> > Ahh you're right, this cant overflow u32. The dynptr max supported
> > size is 2^24 - 1 as well
> >
> > >
> > > > +                       return -ERANGE;
> > > > +
> > > > +               ptr->offset =3D new_off;
> > > > +       }
> > > > +
> > > > +       bpf_dynptr_set_size(ptr, size - sz_dec);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u3=
2 len)
> > > > +{
> > > > +       return bpf_dynptr_adjust(ptr, len, len);
> > > > +}
> > > > +
> > > > +__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 l=
en)
> > >
> > > I'm also wondering if trim operation is a bit unusual for dealing
> > > ranges? Instead of a relative size decrement, maybe it's more
> > > straightforward to have bpf_dynptr_resize() to set new desired size?
> > > So if someone has original dynptr with 100 bytes but wants to have
> > > dynptr for bytes [10, 30), they'd do a pretty natural:
> > >
> > > bpf_dynptr_advance(&dynptr, 10);
> > > bpf_dynptr_resize(&dynptr, 20);
> > >
> > > ?
> > >
> >
> > Yeah! I like this idea a lot, that way they dont' need to know the
> > current size of the dynptr before they trim. This seems a lot more
> > ergonomic
>
> Thinking a bit more, I'm now wondering if we should actually merge
> those two into one API to allow adjust both at the same time.
> Similarly how langauges like Go and Rust allow to adjust array slices
> by specifying new [start, end) offsets, should we have just one:
>
> bpf_dynptr_adjust(&dynptr, 10, 30);
>
> bpf_dynptr_advance() could be expressed as:
>
> bpf_dynptr_adjust(&dynptr, 10, bpf_dynptr_size(&dynptr) - 10);
>
I think for expressing advance where only start offset changes, end
needs to be "bpf_dynptr_size(&dynptr)" (no minus 10) here?

> I suspect full adjust with custom [start, end) will be actually more
> common than just advancing offset.
>

I think this might get quickly cumbersome for the use cases where the
user just wants to parse through the data with only adjusting start
offset, for example parsing an skb's header options. maybe there's
some way to combine the two?:

bpf_dynptr_adjust(&dynptr, start, end);
where if end is -1 or some #define macro set to u32_max or something
like that then that signifies dont' modify the end offset, just modify
the start? That way the user can just advance instead of needing to
know its size every time. I don't know if that makes the interface
uglier / more confusing though. WDYT?

> >
> > > > +{
> > > > +       return bpf_dynptr_adjust(ptr, 0, len);
> > > > +}
> > > > +
> > > >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > > >  {
> > > >         return obj;
> > > > @@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_=
RET_NULL)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > > +BTF_ID_FLAGS(func, bpf_dynptr_trim)
> > > > +BTF_ID_FLAGS(func, bpf_dynptr_advance)
> > > >  BTF_SET8_END(common_btf_ids)
> > > >
> > > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > > --
> > > > 2.34.1
> > > >
