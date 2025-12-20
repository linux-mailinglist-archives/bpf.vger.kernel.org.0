Return-Path: <bpf+bounces-77250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC8CD30C1
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 742853001604
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4A29D26C;
	Sat, 20 Dec 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M79Uf9u1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A249298CBE
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766240835; cv=none; b=ZfH3IEpa+73GECh9NFE3vTxMO+Vm2ayhUR8+M74VqhBTNdeXAPCZSVUwLot92pRdmMVniqKcwrpNxDNl9YRo4V0x5Xc0+MOHvjOS+xtAEUvClfP1J3eRupBd5DnrZr2e6fCzJMXK3d9UFCEY/ztieRCJLc79dR9C3fahLbXvP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766240835; c=relaxed/simple;
	bh=KJKZQ0iQMADSzfU+taaUH+Qh5jPuCsmx/ghti5QeGJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPmMVTD2bFo0xer+AjSOCiHYfbJLgljRc1zill7NwJZN1e+MZ9HBDa5gblSmdzMLtkDYib2sDkgqfeAvr0w/8uSrVPgrItKTzt4D9U2F4A2qPKlsfTcDpWYvKWdcm6gU0Q+WWtR/6rpJl2zQx9LNtQl83OFdnAcocjkCp+beSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M79Uf9u1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b728a43e410so465029366b.1
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766240832; x=1766845632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gwZ2s9s6GzHxj4gRxEA7DnBSVFS9Q+sc2FyyKWcvaA=;
        b=M79Uf9u13L12i8H3IhggXovQWuBNcNstWKITYoE8loXfS2h6YKxV9LQJGY9OQWx3Ha
         fUMfb+SWARlcsCDHTMzqciX8srWJdslfYStMbL32DYHYHLJmd184ENIRbGcipou3anw5
         vz6MfOWe3N+nm2/AAi4Awn6Amp0KwjwZCx1ti4IEGl9PxibQAX41eXUnoiA2QWOIX/UE
         YlVDSzjw6eEykKb7ePS3wbEmmW6IJNhCHT8F+gVfF/YEgKYkO8+7i4xuU/3YS4LOFp/v
         RodBedAoQzNJhkYYXMBCYb3Vym1dAy9e2wwYbie++ybE269TSqpuW/9+ySlk7jqSpzK2
         8PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766240832; x=1766845632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gwZ2s9s6GzHxj4gRxEA7DnBSVFS9Q+sc2FyyKWcvaA=;
        b=NTr4CM8xJgbEcI/WAmR9UEUq+FPK46pslCajONJpxjTttEEMTeciFQYxA2+pNceBBt
         wrUADBjEehsp0wAEqmxWc4ED2Y5y+nyYxCxh9jJLxv8ZQovmqfhxfxvvs4iV1Bv1kzn6
         q4E9ZotYJWB/bIUmtynAeM+pfHDlayHj2VxeiaHVc1dDvNwMJrbb1gQ6YTipfpAS3AR8
         MAA8XkN3unbZUzMhXZvwqHlbD8jJKOL7/AQBwS1ZAWmKnJEHi3asQMWM31PNRQPHoSs1
         wXFmWtDsE2wUfXx+e+T2kp9zcge7iLxf0GVnEzLvnTZK2/60akvK9e87sl6uNifXiAdN
         O8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVCgIvoG7ggXMT8/0hPF4rELuC+mDT2KPNNBGigNNcqoYHlSxtc5/8UPar0fnInwCHrD7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAYlBq0RDWlZaCByKJgLqm8gHWOaloUNBG5XaPqNtBk/dwHmE
	Xei3CxOd7mDa+l0vRrTOgUKsd0DDvDNqAlIHuDxMEs03wcdKFNw6Gd2O4jKFn0R4G31lVXjKUZd
	0Qwoq47xNk/d8spXg8gKiZsjX11Tz52o=
X-Gm-Gg: AY/fxX7SV0YXB2GJlALxWyuZ4siNB2o1I0bdXwXJdbngZ47etP3WN2Q59C/6f4dQIbO
	5p5SqqOYTcpTKBstw90qSZl3yzR7FxmdwB9vsiliDZagdu4xyxlP73LLbbyyx21rdQcm7bLvtVs
	Ztx3n6Saomzf7GNXFECgMY7eVrFqqEFalBDsMMZ59uqodowUeETK2/EI54Efu8UGiqMDIQT6Y+D
	EWU/G67pioWihAEvlgRQAUXNjcy7OshnnbiBLsUEPHzO3vY7EPlrer2OQhBvz+D+0PLtoMb
X-Google-Smtp-Source: AGHT+IHM0de34NZimcRqb/6UhfC/hX5ZY4Rg33ko2UTXhPr6YpaeFk0VvjCYU5nmhiT9Tc0Orql05sQmQU+/Wuc4+hI=
X-Received: by 2002:a17:907:8e95:b0:b7c:e320:5250 with SMTP id
 a640c23a62f3a-b8036ebbe3fmr500254866b.7.1766240831814; Sat, 20 Dec 2025
 06:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-10-dolinux.peng@gmail.com> <CAEf4BzZVFMbP+XXTOedDESKL4jred6vg2L8Dv5C-mmKMp9sicQ@mail.gmail.com>
 <CAErzpmt85U7ggSpE+2u88C+kh+1JSnvZtW+Qx7c3xDLoHCbNtQ@mail.gmail.com>
In-Reply-To: <CAErzpmt85U7ggSpE+2u88C+kh+1JSnvZtW+Qx7c3xDLoHCbNtQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 22:27:00 +0800
X-Gm-Features: AQt7F2oY_2QOlwuIX892r8U-UmTLWZKDmnw330yi_h7L7CCaWp5cZOOU2_J6DwM
Message-ID: <CAErzpms0T9KWqzm3TBnEcYrfwvn+rQwsUDjQQuMrC7VLqsXwKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/13] bpf: Optimize the performance of find_bpffs_btf_enums
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 1:41=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Dec 19, 2025 at 8:02=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Currently, vmlinux BTF is unconditionally sorted during
> > > the build phase. The function btf_find_by_name_kind
> > > executes the binary search branch, so find_bpffs_btf_enums
> > > can be optimized by using btf_find_by_name_kind.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  kernel/bpf/inode.c | 42 +++++++++++++++++++-----------------------
> > >  1 file changed, 19 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..050fde1cf211 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -600,10 +600,18 @@ struct bpffs_btf_enums {
> > >
> > >  static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
> > >  {
> > > +       struct {
> > > +               const struct btf_type **type;
> > > +               const char *name;
> > > +       } btf_enums[] =3D {
> > > +               {&info->cmd_t,          "bpf_cmd"},
> > > +               {&info->map_t,          "bpf_map_type"},
> > > +               {&info->prog_t,         "bpf_prog_type"},
> > > +               {&info->attach_t,       "bpf_attach_type"},
> > > +       };
> > >         const struct btf *btf;
> > >         const struct btf_type *t;
> > > -       const char *name;
> > > -       int i, n;
> > > +       int i, id;
> > >
> > >         memset(info, 0, sizeof(*info));
> > >
> > > @@ -615,30 +623,18 @@ static int find_bpffs_btf_enums(struct bpffs_bt=
f_enums *info)
> > >
> > >         info->btf =3D btf;
> > >
> > > -       for (i =3D 1, n =3D btf_nr_types(btf); i < n; i++) {
> > > -               t =3D btf_type_by_id(btf, i);
> > > -               if (!btf_type_is_enum(t))
> > > -                       continue;
> > > +       for (i =3D 0; i < ARRAY_SIZE(btf_enums); i++) {
> > > +               id =3D btf_find_by_name_kind(btf, btf_enums[i].name,
> > > +                                          BTF_KIND_ENUM);
> > > +               if (id < 0)
> > > +                       goto out;
> > >
> > > -               name =3D btf_name_by_offset(btf, t->name_off);
> > > -               if (!name)
> > > -                       continue;
> >
> > return -ESRCH, why goto at all?

Thanks, will do.

> >
> > > -
> > > -               if (strcmp(name, "bpf_cmd") =3D=3D 0)
> > > -                       info->cmd_t =3D t;
> > > -               else if (strcmp(name, "bpf_map_type") =3D=3D 0)
> > > -                       info->map_t =3D t;
> > > -               else if (strcmp(name, "bpf_prog_type") =3D=3D 0)
> > > -                       info->prog_t =3D t;
> > > -               else if (strcmp(name, "bpf_attach_type") =3D=3D 0)
> > > -                       info->attach_t =3D t;
> > > -               else
> > > -                       continue;
> > > -
> > > -               if (info->cmd_t && info->map_t && info->prog_t && inf=
o->attach_t)
> > > -                       return 0;
> > > +               t =3D btf_type_by_id(btf, id);
> > > +               *btf_enums[i].type =3D t;
> >
> > nit: drop t local variable, just assign directly:
> >
> > *btf_enums[i].type =3D btf_type_by_id(btf, id);
>
> Thanks, I will do it.
>
> >
> > >         }
> > >
> > > +       return 0;
> > > +out:
> > >         return -ESRCH;
> > >  }
> > >
> > > --
> > > 2.34.1
> > >

