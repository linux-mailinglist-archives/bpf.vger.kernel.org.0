Return-Path: <bpf+bounces-71142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0AEBE515C
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CCE1A67FEE
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E80239562;
	Thu, 16 Oct 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeRpnaKF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09922A7E2
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640085; cv=none; b=uV0mNE0CsyX97Yje8ns5Sx00DY1PlLh+xVRQzdIJeWuR3EDV0f2FOxlH1bhF+b4d3j9Uyo78cnNRgBA2dTjaMnp+saGIvQTbIdqV7S+ISEroZo8NAbRQnIxEXWm92vmDaKKklRQX3abolzwOtpgn1ULCEQD21rFfq/W71aDgiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640085; c=relaxed/simple;
	bh=HcRduAOkMhRguvZPmMplj2R2qBLQSNFSj+MyA7gT3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeUhZvNDoM1VK1dLwyEWFHLT4EcB2vDKX7iqsblJ/Z2Fus41ipQtGmQJY9Cy9XPlxbm6rH5IwBRlDs3FCqxlMvXjxU+OwI3P+hyiFKCCEEsuLTXyD6hTI3wBwVhB0GKmGqvHZhHuHVLcfsXep+BO09oKTlGpDg7dTTJnyTlR3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeRpnaKF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso1053719a91.3
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640083; x=1761244883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kvLJ/laGzw9IIGcz9cWJT22pNRifQD5Ko61iDZYwmw=;
        b=SeRpnaKFBFy/hvxM44bZ5OrGp8PuMe6pDy1sAzOiXjNiawMNGN5Ue2N21I0nP7v09b
         EndMBCNyOjOWehgTA2nKgslAheaY+/gkmr5/QM01B9UQ5MiWSQ3K86WKFsxQ/0g4IEKq
         npB8LRMsnmBNbSbagwTnA0DY+8ISO02s4YKRXJZZJyIVcFavf02CojSjPc6T9eE6MkiY
         GWjnzbbTI7nYdpPuqbRXwCkf2wyGGe0aBbK7gTD8igjqN8SUaIjmUhOpOyH7bGFaZ2Sh
         favlDE46yz4Km+EmVOTjoVMUl0pIrVIEzS8Iw2D+vIaV84cUFMl7LG87cPyEhAZ1ZW4A
         pwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640083; x=1761244883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kvLJ/laGzw9IIGcz9cWJT22pNRifQD5Ko61iDZYwmw=;
        b=qy/cOK8w4cq+ROGqyiN5yp9GwGMzgw91DNb00cfnuYP55/GpvJ75nywNOtTUgrQm6w
         lPgw94beJoaTroF6om5TibCuXsFCQd7OL8hb1XbI/C1mGF9qBa22IO3HQaeGk8bI5nn5
         fBdzMg41CMuurQ2GYto6e4mN3FEkzybNwpKBOdSiScXzp2119+Jpgg6NS6KKPHqyqfPK
         hAAuBIxYmjSBqMb+1f97BwDGkTBETWMHrkhKPnEQ/whiz8kEEi/kBYsRAIkzDk1220GK
         y5vCLNN6Rju5MPhjbecDxLbSOS9YJrno+bIJWqyrGKTzuywX9A1o6x84acKK/tskvw6K
         OZOQ==
X-Gm-Message-State: AOJu0Yx/YsxwWmKb3xycIHPYDjSBUd43a3mlf/kFya16DIyMcsUWTqoo
	kdBMCXsQh3ly8GNYJGlYce3Wd0/qPd4IX9MzXtp2LEBcbZCjHCpXBhOXS1CmMU+BYA+Pgx3XcWj
	c9CTPTVeoFi6QTuRpaLcVTiaYiCwt+eI=
X-Gm-Gg: ASbGncta22Gf0exPg8hIKQlM4+sAc1e6pL7S7xXXJ2D+aL7TLrbdTNs+dbrmbRaOF/R
	Bixdx4znWEaJCUlz4/t/DheFlBQpUo7TvQMODHaf0CEeZMptYRLDXBHWmnXWtkb9mLgXuc279/m
	pVAM+Jjslp+/9y75OXOAXXxfydKjVy749fe6CsZuf43isCqYvPCprPljPKRqVxlH/yV4Wa8Uuc1
	/0VDJJRRin2Tyzi39vPhNlIoKxdHE+41PoK4/fdlneSemVTxzlDU/FF8+qirVOPuGHlg1KEM/jB
	wjsBxuTHPoQ1NSwgi6U/Ww==
X-Google-Smtp-Source: AGHT+IHksK6zHHXEZhidpSOSopL3XuBqhuvPbN22SNJzp0gXRHPPANZsyP6f346zd6pa38fd5HflEjyAhnaQPUuIpKE=
X-Received: by 2002:a17:90b:3f10:b0:330:84dc:d11b with SMTP id
 98e67ed59e1d1-33bcf8e4e19mr793789a91.18.1760640082491; Thu, 16 Oct 2025
 11:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-3-ameryhung@gmail.com>
 <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com> <CAMB2axN7o0pHca_u2HnbMb+pEOJubRR8Y8JewExzwxaRWtKUmQ@mail.gmail.com>
In-Reply-To: <CAMB2axN7o0pHca_u2HnbMb+pEOJubRR8Y8JewExzwxaRWtKUmQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:41:06 -0700
X-Gm-Features: AS18NWC0gh3ZBEPZK-ETwn3WfKdzJxK0qtkoA7PM5Lyf6t9FbQMn16MrmkDLYUU
Message-ID: <CAEf4BzbpVkpCyQX4C0gn13t63LETAfGpbf27rSJKyMcp=ELKDw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:35=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 5:10=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associat=
ing
> > > a BPF program with a struct_ops. This command takes a file descriptor=
 of
> > > a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
> > > the kdata of the struct_ops map.
> > >
> > > The command does not accept a struct_ops program or a non-struct_ops
> > > map. Programs of a struct_ops map is automatically associated with th=
e
> > > map during map update. If a program is shared between two struct_ops
> > > maps, the first one will be the map associated with the program. The
> > > associated struct_ops map, once set cannot be changed later. This
> > > restriction may be lifted in the future if there is a use case.
> > >
> > > Each associated programs except struct_ops programs of the map will t=
ake
> > > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if s=
et,
> > > is always valid. However, it is not guaranteed whether the map member=
s
> > > are fully updated nor is it attached or not. For example, a BPF progr=
am
> > > can be associated with a struct_ops map before map_update. The
> > > struct_ops implementer will be responsible for maintaining and checki=
ng
> > > the state of the associated struct_ops map before accessing it.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf.h            | 11 ++++++++++
> > >  include/uapi/linux/bpf.h       | 16 ++++++++++++++
> > >  kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
> > >  kernel/bpf/core.c              |  6 ++++++
> > >  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
> > >  6 files changed, 119 insertions(+)
> > >

[...]

> > > +       } struct_ops_assoc_prog;
> > > +
> > >  } __attribute__((aligned(8)));
> > >
> > >  /* The description below is an attempt at providing documentation to=
 eBPF
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index a41e6730edcf..e57428e1653b 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct b=
pf_struct_ops_map *st_map)
> > >         for (i =3D 0; i < st_map->funcs_cnt; i++) {
> > >                 if (!st_map->links[i])
> > >                         break;
> > > +               bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
> > >                 bpf_link_put(st_map->links[i]);
> > >                 st_map->links[i] =3D NULL;
> > >         }
> > > @@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struc=
t bpf_map *map, void *key,
> > >                         goto reset_unlock;
> > >                 }
> > >
> > > +               /* Don't stop a program from being reused. prog->aux-=
>st_ops_assoc
> >
> > nit: comment style, we are converging onto /* on separate line
>
> Got it, so I assume it applies to kerne/bpf/* even existing comments
> in the file are netdev style. Is it also the case for
> net/core/filter.c?

yeah

>
>
> >
> > > +                * will point to the first struct_ops kdata.
> > > +                */
> > > +               bpf_struct_ops_assoc_prog(&st_map->map, prog);
> >
> > ignoring error? we should do something better here... poisoning this
> > association altogether if program is used in multiple struct_ops seems
> > like the only thing we can reasonable do, no?
> >
> > > +
> > >                 link =3D kzalloc(sizeof(*link), GFP_USER);
> > >                 if (!link) {
> > >                         bpf_prog_put(prog);
> >
> > [...]
> >
> > >
> > > +#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_pr=
og.prog_fd
> > > +
> >
> > looking at libbpf side, it's quite a mouthful to write out
> > bpf_struct_ops_associate_prog()... maybe let's shorten this to
> > BPF_STRUCT_OPS_ASSOC or BPF_ASSOC_STRUCT_OPS (with the idea that we
> > associate struct_ops with a program). The latter is actually a bit
> > more preferable, because then we can have a meaningful high-level
> > bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map
> > *map), where map has to be struct_ops. Having bpf_map__assoc_prog() is
> > a bit too generic, as this works only for struct_ops maps.
> >
> > It's all not major, but I think that lends for a bit better naming and
> > more logical usage throughout.
>
> Will change the naming.

thanks

>
> >
> > > +static int struct_ops_assoc_prog(union bpf_attr *attr)
> > > +{
> > > +       struct bpf_prog *prog;
> > > +       struct bpf_map *map;
> > > +       int ret;
> > > +
> > > +       if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
> > > +               return -EINVAL;
> > > +
> > > +       prog =3D bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
> > > +       if (IS_ERR(prog))
> > > +               return PTR_ERR(prog);
> > > +
> > > +       map =3D bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
> > > +       if (IS_ERR(map)) {
> > > +               ret =3D PTR_ERR(map);
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> > > +           prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> >
> > you can check prog->type earlier, before getting map itself
>
> Got it. I will make it a separate check right after getting prog.
>
> >
> > > +               ret =3D -EINVAL;
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret =3D bpf_struct_ops_assoc_prog(map, prog);
> > > +out:
> > > +       if (ret && !IS_ERR(map))
> >
> > nit: purely stylistic preference, but I'd rather have a clear
> > error-only clean up path, and success with explicit return 0, instead
> > of checking ret or IS_ERR(map)
> >
> >     ...
> >
> >     /* goto to put_{map,prog}, depending on how far we've got */
> >
> >     err =3D bpf_struct_ops_assoc_prog(map, prog);
> >     if (err)
> >         goto put_map;
> >
> >     return 0;
> >
> > put_map:
> >     bpf_map_put(map);
> > put_prog:
> >     bpf_prog_put(prog);
> >     return err;
>
> I will separate error path out.

great, thanks

>
> >
> >
> > > +               bpf_map_put(map);
> > > +       bpf_prog_put(prog);
> > > +       return ret;
> > > +}
> > > +
> >
> > [...]

