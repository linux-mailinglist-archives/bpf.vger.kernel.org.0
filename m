Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0636E7FA6
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 18:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjDSQa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSQa6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 12:30:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0F421F
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:30:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a35b0d130so755951166b.3
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681921855; x=1684513855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ7XW866EcUocCXGcuxQNx5WUnuyakf8PPSZ6plRmdw=;
        b=eCrWGm18GHykjJHT3UPKYPtb+uNFXOjTI4oH8lXLZdzIEBPtYdrVBdmeeppSIH39T+
         fWvlIjoec8vOJ5aqq1Haqmj43AztFXEfPK4fg/aw7+Ncks1gogF54NjCLVYOWRM1tlcG
         Vg3lt2mHvsqEwg9SyNiH9x8IEzVPhLScGq+TCpZ//q9iRxvqOsS8QnGPz8pXn3fv4dXj
         MaDu/+aEpv5JiEu8M28RirVkK9o8ODtxtHSNtwJSJIGhAJ8JJ/2uW/WVD44OQLxav7nT
         KY78R3r1Lf5dQ6H5AAxLKBx+7VehJs/WVWuPCDeSOFLgaQs7ZsH66CzK+mSmhtLOxhcD
         u+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681921855; x=1684513855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ7XW866EcUocCXGcuxQNx5WUnuyakf8PPSZ6plRmdw=;
        b=SgSttaMAC+XvPIdUijlgKww8OSUdab8aI9R4PzGLezcEQhkNdCx3puwZNzYY8gZz2W
         M8fFD4RF5fTEqyMRxLq/+1oySKGZiCSkK9JWj5D8agv6sZsPghxMDwJsZogIAk8nUijQ
         M/+4X4hhV1sv6G+OIuuOYr5Rq+UnfRmIF77I8p8lEa50KSxCZDKXD60+l9MXuGSaL1lc
         1k7a4x2IyxD/TyMfRycsjBkajqRq+JIRtUx0ngblSG0pasav8tq6RlIkyZkNNL20oAQw
         ewyXbslnVEbOxSz2LICsjD7spnwE6qdz4wP7k1yLs+hCdk8MzDjHf8X0vUxZwtPa9A1G
         ISdw==
X-Gm-Message-State: AAQBX9fAdYL9N5rXK1VqRb0ZwcTiLG1xKZBIbFgqkfD4QBUi1pVI2Wh7
        9P+0uUJ9ABcx/QLCBjJk50OeQkf8B6a6txftxdZQQiOx
X-Google-Smtp-Source: AKy350bNBQFwEbTfml1SdGJXDXo00ZqCuiTVutCgiXC4gSoLjrbGZY7WmLpu4H5f1kSUrX/2FLIAZtJgQGrI7SDpNCY=
X-Received: by 2002:aa7:d50e:0:b0:506:bc6c:f39 with SMTP id
 y14-20020aa7d50e000000b00506bc6c0f39mr5949318edq.30.1681921854499; Wed, 19
 Apr 2023 09:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-2-joannelkoong@gmail.com> <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
 <CAJnrk1aynU2Ee1bTtEjMv50ajvDjQEQQZm6jMdBEwHsCH-ke5A@mail.gmail.com>
 <CAEf4BzZt9P-LpXZGbQBHCXNhH59MQ3DkNwhbtVK47FjH6V0-BA@mail.gmail.com> <CAJnrk1bJGhCSQSK=eU9BwrKxkOGe-tR7z3FPWfrM2J7JxUosMg@mail.gmail.com>
In-Reply-To: <CAJnrk1bJGhCSQSK=eU9BwrKxkOGe-tR7z3FPWfrM2J7JxUosMg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 09:30:42 -0700
Message-ID: <CAEf4BzYO4OkMsdDZELCWPpbzGF=S09U2GKQgdSi5=XwGcjvW1A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Tue, Apr 18, 2023 at 11:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Mon, Apr 17, 2023 at 4:36=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 10:15=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Wed, Apr 12, 2023 at 2:46=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > > >
> > > > > bpf_dynptr_trim decreases the size of a dynptr by the specified
> > > > > number of bytes (offset remains the same). bpf_dynptr_advance adv=
ances
> > > > > the offset of the dynptr by the specified number of bytes (size
> > > > > decreases correspondingly).
> > > > >
> > > > > Trimming or advancing the dynptr may be useful in certain situati=
ons.
> > > > > For example, when hashing which takes in generic dynptrs, if the =
dynptr
> > > > > points to a struct but only a certain memory region inside the st=
ruct
> > > > > should be hashed, advance/trim can be used to narrow in on the
> > > > > specific region to hash.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 49 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index b6a5cda5bb59..51b4c4b5dbed 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_d=
ynptr_kern *ptr)
> > > > >         return ptr->size & DYNPTR_SIZE_MASK;
> > > > >  }
> > > > >
> > > > > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32=
 new_size)
> > > > > +{
> > > > > +       u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > > > > +
> > > > > +       ptr->size =3D new_size | metadata;
> > > > > +}
> > > > > +
> > > > >  int bpf_dynptr_check_size(u32 size)
> > > > >  {
> > > > >         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > > > > @@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(co=
nst struct bpf_dynptr_kern *ptr, u32 o
> > > > >         return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk)=
;
> > > > >  }
> > > > >
> > > > > +/* For dynptrs, the offset may only be advanced and the size may=
 only be decremented */
> > > > > +static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 of=
f_inc, u32 sz_dec)
> > > >
> > > > it feels like this helper just makes it a bit harder to follow what=
's
> > > > going on. Half of this function isn't actually executed for
> > > > bpf_dynptr_trim, so I don't think we are saving all that much code,
> > > > maybe let's code each of advance and trim explicitly?
> > > >
> > >
> > > Sounds good, I will change this in v2 to handle advance and trim sepa=
rately
> > >
> > > > > +{
> > > > > +       u32 size;
> > > > > +
> > > > > +       if (!ptr->data)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       size =3D bpf_dynptr_get_size(ptr);
> > > > > +
> > > > > +       if (sz_dec > size)
> > > > > +               return -ERANGE;
> > > > > +
> > > > > +       if (off_inc) {
> > > > > +               u32 new_off;
> > > > > +
> > > > > +               if (off_inc > size)
> > > >
> > > > like here it becomes confusing if off_inc includes sz_dec, or they
> > > > should be added to each other. I think it's convoluted as is.
> > > >
> > > >
> > > > > +                       return -ERANGE;
> > > > > +
> > > > > +               if (check_add_overflow(ptr->offset, off_inc, &new=
_off))
> > > >
> > > > why do we need to worry about overflow, we checked all the error
> > > > conditions above?..
> > >
> > > Ahh you're right, this cant overflow u32. The dynptr max supported
> > > size is 2^24 - 1 as well
> > >
> > > >
> > > > > +                       return -ERANGE;
> > > > > +
> > > > > +               ptr->offset =3D new_off;
> > > > > +       }
> > > > > +
> > > > > +       bpf_dynptr_set_size(ptr, size - sz_dec);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, =
u32 len)
> > > > > +{
> > > > > +       return bpf_dynptr_adjust(ptr, len, len);
> > > > > +}
> > > > > +
> > > > > +__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32=
 len)
> > > >
> > > > I'm also wondering if trim operation is a bit unusual for dealing
> > > > ranges? Instead of a relative size decrement, maybe it's more
> > > > straightforward to have bpf_dynptr_resize() to set new desired size=
?
> > > > So if someone has original dynptr with 100 bytes but wants to have
> > > > dynptr for bytes [10, 30), they'd do a pretty natural:
> > > >
> > > > bpf_dynptr_advance(&dynptr, 10);
> > > > bpf_dynptr_resize(&dynptr, 20);
> > > >
> > > > ?
> > > >
> > >
> > > Yeah! I like this idea a lot, that way they dont' need to know the
> > > current size of the dynptr before they trim. This seems a lot more
> > > ergonomic
> >
> > Thinking a bit more, I'm now wondering if we should actually merge
> > those two into one API to allow adjust both at the same time.
> > Similarly how langauges like Go and Rust allow to adjust array slices
> > by specifying new [start, end) offsets, should we have just one:
> >
> > bpf_dynptr_adjust(&dynptr, 10, 30);
> >
> > bpf_dynptr_advance() could be expressed as:
> >
> > bpf_dynptr_adjust(&dynptr, 10, bpf_dynptr_size(&dynptr) - 10);
> >
> I think for expressing advance where only start offset changes, end
> needs to be "bpf_dynptr_size(&dynptr)" (no minus 10) here?

yep, you are right! it's end offset, so no need to adjust for 10. So
even better:

bpf_dynptr_adjust(&dynptr, 10, bpf_dynptr_size(&dynptr));

>
> > I suspect full adjust with custom [start, end) will be actually more
> > common than just advancing offset.
> >
>
> I think this might get quickly cumbersome for the use cases where the
> user just wants to parse through the data with only adjusting start
> offset, for example parsing an skb's header options. maybe there's
> some way to combine the two?:
>
> bpf_dynptr_adjust(&dynptr, start, end);
> where if end is -1 or some #define macro set to u32_max or something
> like that then that signifies dont' modify the end offset, just modify
> the start? That way the user can just advance instead of needing to
> know its size every time. I don't know if that makes the interface
> uglier / more confusing though. WDYT?

I think it does make it more cumbersome, I'd keep it as [start, end)
offset always. We can inline bpf_dynptr_size() if there is a
performance concern.

At least I'd start there, and if there is demand we can also add -1 as
a special case later.

>
> > >
> > > > > +{
> > > > > +       return bpf_dynptr_adjust(ptr, 0, len);
> > > > > +}
> > > > > +
> > > > >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > > > >  {
> > > > >         return obj;
> > > > > @@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, K=
F_RET_NULL)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL=
)
> > > > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > > > +BTF_ID_FLAGS(func, bpf_dynptr_trim)
> > > > > +BTF_ID_FLAGS(func, bpf_dynptr_advance)
> > > > >  BTF_SET8_END(common_btf_ids)
> > > > >
> > > > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > > > --
> > > > > 2.34.1
> > > > >
