Return-Path: <bpf+bounces-5336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F50759ABF
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F811C210B9
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB891BB2A;
	Wed, 19 Jul 2023 16:28:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237C1BB20
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 16:28:45 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F21BB;
	Wed, 19 Jul 2023 09:28:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso75686911fa.1;
        Wed, 19 Jul 2023 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689784122; x=1692376122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99yK8+KnHqRGqbqnzMVhOVnI/JP3FUcwgMY39whDxlg=;
        b=UnxyuKFJOvvgGrb4VavlzqnHs+xZ0waNJYz6YIk1Z3rxBTeE+/umfOLQ10Ti0TYDDH
         7HWt/AUWYYelCkjGH3s31LtmKjZrII6YN5+gNJZaMXhbcu/fe/aaoZLE7gsmKJysFlty
         wfs5w+RPI4B8bxLJt/PwRAudU9x/9MiXeHegGa2oTcSSQXsU13GEE88Y6s+/fnUCTkR1
         lAPjqaKgISJE2Acl6hitprBwz+/fMXvY5xwZb1AR6T/QmO4EBq/UsJfxEjxp3YILVwoM
         flWP9Kde14eyM8Nbh2d9XrhosU/8bAav+TzRpkMwQlkVxu2PJ816+Gl5xxOmSSTJvIW0
         WcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784122; x=1692376122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99yK8+KnHqRGqbqnzMVhOVnI/JP3FUcwgMY39whDxlg=;
        b=EvC6z/VzG4kELyYJZOSnVRw4nlr9ZtjLsMY8iH6hQOCTtM6El/K6vDJ4bg9VK+h6uj
         ZQ3uADpasow+3ol0a41oX3RasgKsoVL2dVL1S759VnTFDz9iQF2af36XD5Ez5zAATtkH
         lQowOwXWtbfglAf4+DvznOiel6TnxehVvlP9RG1V3kvHu0ZsYc9S1zauTZfjVDJFXm+2
         NP8/B8i/q0SlC1lp/pAtmwdW2SNOuOUupudpMn/B/ckbeuiYVvBPKDcZjI0KH/0+vuCJ
         aeDJHWzJOHNTpaw3S/mV97GIvE81+nyh+a2pUBCMh9wt2iByyXxRCTxdZ7otH7k1X6PM
         0cBg==
X-Gm-Message-State: ABy/qLaZrCamcyzWIXYFdp0LNODCEuaK1qbM553kdH7Cfi+1Be4J9smy
	K1hfOULZ0FU6m6HBjDeFSkYXRNgXsnjaEgQPI9ousv6H
X-Google-Smtp-Source: APBJJlGSuroHCEcnOzxN+od96nVS7g0jFyxSTSx+qFvOpExAY2JTQxe7mGDFxw0P7rtP+qgDJhXoPUAbwo4iFVezwq4=
X-Received: by 2002:a2e:7805:0:b0:2b9:55c9:c21d with SMTP id
 t5-20020a2e7805000000b002b955c9c21dmr322674ljc.33.1689784121432; Wed, 19 Jul
 2023 09:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717114307.46124-1-aspsk@isovalent.com> <20230717114307.46124-2-aspsk@isovalent.com>
 <CAADnVQKutS8fYLkNz-rhdmFJ3cTWS6JD9PmwjK7ZZ8N3u7nUYA@mail.gmail.com> <ZLeMExVzuG+uggn8@zh-lab-node-5>
In-Reply-To: <ZLeMExVzuG+uggn8@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jul 2023 09:28:30 -0700
Message-ID: <CAADnVQJ7EB0JMOzTOw5jg-nZcTnKn=nSwpsn4eTwg14LK7GcUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix setting return values for htab
 batch ops
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brian Vazquez <brianvv@google.com>, Hou Tao <houtao1@huawei.com>, 
	Joe Stringer <joe@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:07=E2=80=AFAM Anton Protopopov <aspsk@isovalent.=
com> wrote:
>
> On Tue, Jul 18, 2023 at 05:52:38PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 17, 2023 at 4:42=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > The map_lookup{,_and_delete}_batch operations are expected to set the
> > > output parameter, counter, to the number of elements successfully cop=
ied
> > > to the user space. This is also expected to be true if an error is
> > > returned and the errno is set to a value other than EFAULT. The curre=
nt
> > > implementation can return -EINVAL without setting the counter to zero=
, so
> > > some userspace programs may confuse this with a [partially] successfu=
l
> > > operation. Move code which sets the counter to zero to the top of the
> > > function so that we always return a correct value.
> > >
> > > Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  kernel/bpf/hashtab.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > index a8c7e1c5abfa..fa8e3f1e1724 100644
> > > --- a/kernel/bpf/hashtab.c
> > > +++ b/kernel/bpf/hashtab.c
> > > @@ -1692,6 +1692,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_=
map *map,
> > >         struct bucket *b;
> > >         int ret =3D 0;
> > >
> > > +       max_count =3D attr->batch.count;
> > > +       if (!max_count)
> > > +               return 0;
> > > +
> > > +       if (put_user(0, &uattr->batch.count))
> > > +               return -EFAULT;
> > > +
> > >         elem_map_flags =3D attr->batch.elem_flags;
> > >         if ((elem_map_flags & ~BPF_F_LOCK) ||
> > >             ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(m=
ap->record, BPF_SPIN_LOCK)))
> > > @@ -1701,13 +1708,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_=
map *map,
> > >         if (map_flags)
> > >                 return -EINVAL;
> > >
> > > -       max_count =3D attr->batch.count;
> > > -       if (!max_count)
> > > -               return 0;
> > > -
> > > -       if (put_user(0, &uattr->batch.count))
> > > -               return -EFAULT;
> > > -
> >
> > I hear your concern, but I don't think it's a good idea
> > to return 0 when flags were incorrect.
> > That will cause more suprises to user space.
> > I think the code is fine as-is.
>
> Yes, thanks, this makes sense. And actually we can do both:
>
>    max_count =3D attr->batch.count;
>    put_user(0, &uattr->batch.count);
>    /* check flags */
>    if (!max_count)
>            return 0;
>
> This way we always set the userspace counter to a correct value
> and also check flags in the right place.

Looks too convoluted to me.
I think concerns over user space always assuming batch.count
is updated with zero even when it calls api incorrectly are overblown.

