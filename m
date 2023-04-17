Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3639E6E5554
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDQXgo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDQXgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:36:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381A59E4
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:36:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt6so30417221ejb.0
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681774563; x=1684366563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZlnOI3FJJntvHXzsoo3JOIDciCNPkfdlVIQMc8HQRw=;
        b=YO9s42YDeuMnfL2Awy3AFPBurAMLylTQtRhuSV6PVImaVU+uoNSfxW0QnPgyjGc3Pe
         FxukmY3VYJgoJd95Pp3DpbmnyKP+hIh8ROLDs5PEkX8bDWj2Wbj4f5vfJDWpFEobcRxT
         MDZLnlSjynYukqidu2h4ecH8VohQ1GUmYC+GcUHSvtM4kSKt1P2BD0YTFfQUneyuRIC8
         +lkvcBp2eOiVNZTdh9twpkpvQ7RRRK2btCgpAOiA1SF3uYIZ997Wu87ZVyMhcyEfXK7u
         g1Q8S5dIgSKxsgYYY+FOI8IpFL+J1gLc8/b925SEwMoHUQTovDS3B/LGFUYsU9BGc+UN
         Dv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681774563; x=1684366563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZlnOI3FJJntvHXzsoo3JOIDciCNPkfdlVIQMc8HQRw=;
        b=ANtRITQzraPVz5XqnxRPeG2fkuRIV1dvigHdwxLeaH5asXG2yR+2jMIzRWJWfuw8Y8
         GatjW6bjrNTTpvhxs7ddmJv2hDRTNNWxMCRlBaUKv6K/h5mEKqr6WpgXUldtDaIBDM8I
         p6gk3coQutPjmK6Osiim9B5AR6+ah/nJtqfQ4DdjGAamW6baSjuIhwEgfLEES675jUQ7
         Hrqo8gLjXyNW/lWQWzt9nm++480YNuHYX/l4l+3F2Wx0xkSeCNSeLZL2q9PkLG5Wi2n5
         cAnHlKe9lL+cdkUisqECw0Bktu/ux4LDv00/pvV2WGo4nhb/DYICTsO0L1216L5l3G3B
         0XAA==
X-Gm-Message-State: AAQBX9da4/+wRPr/Wt+O9msyQX/S1zG5Bdr47wBd2uQVhUR3nkwrSQWE
        CaVmuIK60HJNFHzCdfBCzv6ed5Wjj7tLtYJzQPk=
X-Google-Smtp-Source: AKy350aT4+QUxMV1zzFc9m8rvhQeASXUbP0etMdM7jOhwkarmdIW4LbITZ4OwCIdVGISPLIgz0ZyI+6rV3ce7gy1H8s=
X-Received: by 2002:a17:906:284f:b0:94f:8ec3:5076 with SMTP id
 s15-20020a170906284f00b0094f8ec35076mr1745310ejc.5.1681774563078; Mon, 17 Apr
 2023 16:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
 <20230409033431.3992432-2-joannelkoong@gmail.com> <CAEf4BzYJ7UoUW2dOiHf617J2hP0FwugKdBBqURdPUrs1hjtaZw@mail.gmail.com>
 <CAJnrk1aynU2Ee1bTtEjMv50ajvDjQEQQZm6jMdBEwHsCH-ke5A@mail.gmail.com>
In-Reply-To: <CAJnrk1aynU2Ee1bTtEjMv50ajvDjQEQQZm6jMdBEwHsCH-ke5A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 16:35:51 -0700
Message-ID: <CAEf4BzZt9P-LpXZGbQBHCXNhH59MQ3DkNwhbtVK47FjH6V0-BA@mail.gmail.com>
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

On Thu, Apr 13, 2023 at 10:15=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Wed, Apr 12, 2023 at 2:46=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > bpf_dynptr_trim decreases the size of a dynptr by the specified
> > > number of bytes (offset remains the same). bpf_dynptr_advance advance=
s
> > > the offset of the dynptr by the specified number of bytes (size
> > > decreases correspondingly).
> > >
> > > Trimming or advancing the dynptr may be useful in certain situations.
> > > For example, when hashing which takes in generic dynptrs, if the dynp=
tr
> > > points to a struct but only a certain memory region inside the struct
> > > should be hashed, advance/trim can be used to narrow in on the
> > > specific region to hash.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c | 49 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 49 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index b6a5cda5bb59..51b4c4b5dbed 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynpt=
r_kern *ptr)
> > >         return ptr->size & DYNPTR_SIZE_MASK;
> > >  }
> > >
> > > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new=
_size)
> > > +{
> > > +       u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > > +
> > > +       ptr->size =3D new_size | metadata;
> > > +}
> > > +
> > >  int bpf_dynptr_check_size(u32 size)
> > >  {
> > >         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > > @@ -2275,6 +2282,46 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const =
struct bpf_dynptr_kern *ptr, u32 o
> > >         return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> > >  }
> > >
> > > +/* For dynptrs, the offset may only be advanced and the size may onl=
y be decremented */
> > > +static int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 off_in=
c, u32 sz_dec)
> >
> > it feels like this helper just makes it a bit harder to follow what's
> > going on. Half of this function isn't actually executed for
> > bpf_dynptr_trim, so I don't think we are saving all that much code,
> > maybe let's code each of advance and trim explicitly?
> >
>
> Sounds good, I will change this in v2 to handle advance and trim separate=
ly
>
> > > +{
> > > +       u32 size;
> > > +
> > > +       if (!ptr->data)
> > > +               return -EINVAL;
> > > +
> > > +       size =3D bpf_dynptr_get_size(ptr);
> > > +
> > > +       if (sz_dec > size)
> > > +               return -ERANGE;
> > > +
> > > +       if (off_inc) {
> > > +               u32 new_off;
> > > +
> > > +               if (off_inc > size)
> >
> > like here it becomes confusing if off_inc includes sz_dec, or they
> > should be added to each other. I think it's convoluted as is.
> >
> >
> > > +                       return -ERANGE;
> > > +
> > > +               if (check_add_overflow(ptr->offset, off_inc, &new_off=
))
> >
> > why do we need to worry about overflow, we checked all the error
> > conditions above?..
>
> Ahh you're right, this cant overflow u32. The dynptr max supported
> size is 2^24 - 1 as well
>
> >
> > > +                       return -ERANGE;
> > > +
> > > +               ptr->offset =3D new_off;
> > > +       }
> > > +
> > > +       bpf_dynptr_set_size(ptr, size - sz_dec);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +__bpf_kfunc int bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 =
len)
> > > +{
> > > +       return bpf_dynptr_adjust(ptr, len, len);
> > > +}
> > > +
> > > +__bpf_kfunc int bpf_dynptr_trim(struct bpf_dynptr_kern *ptr, u32 len=
)
> >
> > I'm also wondering if trim operation is a bit unusual for dealing
> > ranges? Instead of a relative size decrement, maybe it's more
> > straightforward to have bpf_dynptr_resize() to set new desired size?
> > So if someone has original dynptr with 100 bytes but wants to have
> > dynptr for bytes [10, 30), they'd do a pretty natural:
> >
> > bpf_dynptr_advance(&dynptr, 10);
> > bpf_dynptr_resize(&dynptr, 20);
> >
> > ?
> >
>
> Yeah! I like this idea a lot, that way they dont' need to know the
> current size of the dynptr before they trim. This seems a lot more
> ergonomic

Thinking a bit more, I'm now wondering if we should actually merge
those two into one API to allow adjust both at the same time.
Similarly how langauges like Go and Rust allow to adjust array slices
by specifying new [start, end) offsets, should we have just one:

bpf_dynptr_adjust(&dynptr, 10, 30);

bpf_dynptr_advance() could be expressed as:

bpf_dynptr_adjust(&dynptr, 10, bpf_dynptr_size(&dynptr) - 10);

I suspect full adjust with custom [start, end) will be actually more
common than just advancing offset.

>
> > > +{
> > > +       return bpf_dynptr_adjust(ptr, 0, len);
> > > +}
> > > +
> > >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> > >  {
> > >         return obj;
> > > @@ -2347,6 +2394,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RE=
T_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> > >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > > +BTF_ID_FLAGS(func, bpf_dynptr_trim)
> > > +BTF_ID_FLAGS(func, bpf_dynptr_advance)
> > >  BTF_SET8_END(common_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > --
> > > 2.34.1
> > >
