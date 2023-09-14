Return-Path: <bpf+bounces-10094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D067A0FDB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E79A1C20A6C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54326E3A;
	Thu, 14 Sep 2023 21:28:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FC10A2F
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B5C433C7
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694726927;
	bh=HdPWW2yFqakL/lJ80eEUzT6mjHd9OX1zy8RkA1ZjKus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KddoxJpzkHy1zBPJtTZOj9/hll8nUCTfr2SVlCXHmjyBFJ/cqNACvdREQI8wwv4yd
	 7iv1xywAcZfjacuxMzkY2qTwDYFPML2+buaty4I4MVupuBKuzCsX0IyxmbCzz1fk0N
	 Kp2pD5WoVwbUrhuEUvSXZgEhgoi4EkMqZk+7lnzSTc9tY8XqnrBv8aGrORJKyxoJvn
	 2p32gJFcbrCmxAvtUk5aUMIgikmhOSbOlKOKVRvU8YShHlCVzsjtrDbIveczsYAzA8
	 sY/TNnowbdi3EKBtGvpkN0ZuUe2QV/KuYb4anygn0GxI/V2Fxn+cl5q2t79ypSZAVr
	 UBSJy6Xd8ZosA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso24209411fa.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:28:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YzpJAt1dNjIe5ybh6IHzULMwfUbmpRnZ3Uz1P/48ylgfs+UsWu4
	CpIk91Z4UpKlgpIvMpRPViBhcDODijtpCjEL9fM=
X-Google-Smtp-Source: AGHT+IHQvwl07bAPw03ffNhJpdURVE1FVg6FvSTi1IhRozWEdOJSKxHxt3RbyU1yzY16X3xC8bI8ifTOjpCAIsFG38A=
X-Received: by 2002:a05:6512:ea7:b0:4fe:a2c:24b0 with SMTP id
 bi39-20020a0565120ea700b004fe0a2c24b0mr6450182lfb.26.1694726925175; Thu, 14
 Sep 2023 14:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913222632.3312183-1-song@kernel.org> <208035ba-3016-c9ba-92e4-fe2cee797ca8@linux.dev>
In-Reply-To: <208035ba-3016-c9ba-92e4-fe2cee797ca8@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 14 Sep 2023 14:28:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4LykHS9pnaaYuxgnoKMbVaxDpCKfL8OQxsjQGMnXqXPA@mail.gmail.com>
Message-ID: <CAPhsuW4LykHS9pnaaYuxgnoKMbVaxDpCKfL8OQxsjQGMnXqXPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Charge modmem for struct_ops trampoline
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 2:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/13/23 3:26 PM, Song Liu wrote:
> > Current code charges modmem for regular trampoline, but not for struct_=
ops
> > trampoline. Add bpf_jit_[charge|uncharge]_modmem() to struct_ops so the
> > trampoline is charged in both cases.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >   kernel/bpf/bpf_struct_ops.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index fdc3e8705a3c..ea6ca87a2ed9 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -615,7 +615,10 @@ static void __bpf_struct_ops_map_free(struct bpf_m=
ap *map)
> >       if (st_map->links)
> >               bpf_struct_ops_map_put_progs(st_map);
> >       bpf_map_area_free(st_map->links);
> > -     bpf_jit_free_exec(st_map->image);
> > +     if (st_map->image) {
> > +             bpf_jit_free_exec(st_map->image);
> > +             bpf_jit_uncharge_modmem(PAGE_SIZE);
> > +     }
> >       bpf_map_area_free(st_map->uvalue);
> >       bpf_map_area_free(st_map);
> >   }
> > @@ -657,6 +660,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
> >       struct bpf_struct_ops_map *st_map;
> >       const struct btf_type *t, *vt;
> >       struct bpf_map *map;
> > +     int ret;
> >
> >       st_ops =3D bpf_struct_ops_find_value(attr->btf_vmlinux_value_type=
_id);
> >       if (!st_ops)
> > @@ -681,6 +685,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(un=
ion bpf_attr *attr)
> >       st_map->st_ops =3D st_ops;
> >       map =3D &st_map->map;
> >
> > +     ret =3D bpf_jit_charge_modmem(PAGE_SIZE);
> > +     if (ret) {
> > +             __bpf_struct_ops_map_free(map);
> > +             return ERR_PTR(ret);
> > +     }
>
>
> This just came to my mind when reading it again.
>
> It will miss a bpf_jit_uncharge_modmem() if the bpf_jit_alloc_exec() at a=
 few
> lines below did fail (meaning st_map->image is NULL). It is because the
> __bpf_struct_ops_map_free() only uncharge if st_map->image is not NULL.

Indeed. This is a problem.

>
> How above moving the bpf_jit_alloc_exec() to here (immediately after
> bpf_jit_charge_modem succeeded). Like,
>
>         st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
>         if (!st_map->image) {
>                 bpf_jit_uncharge_modmem(PAGE_SIZE);
>                 __bpf_struct_ops_map_free(map);
>                 return ERR_PTR(-ENOMEM);
>         }
>
> Then there is also no need to test 'if (st_map->image)' in
> __bpf_struct_ops_map_free().

I think we still need this test for uncharge, no?

Thanks,
Song

>
> > +
> >       st_map->uvalue =3D bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
> >       st_map->links =3D
> >               bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_l=
inks *),
> > @@ -907,4 +917,3 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
> >       kfree(link);
> >       return err;
> >   }
> > -
>

