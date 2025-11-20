Return-Path: <bpf+bounces-75143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A9C72A3A
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5CB735718A
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FE3081AD;
	Thu, 20 Nov 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEnXnPUY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF32FE567
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624517; cv=none; b=fQOLmYLtSVV/Jqq9s/zhJSE28ARcTdU43i5K7YMYqdRiLpTd2Fz1J0Tmmeq7n8LWwpqZSF3SHfG0Qql38R2wahRC1PrmXjlcZZSUtvkr+N0N+b9BmGrRiTek/5iaPXN/jPFw49sIIiMo+hA3zlRaPRQ+neGPbv20nCjLfErDdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624517; c=relaxed/simple;
	bh=T4xi2dlpbYRevPo5ZhbakQxF8F12oEKWcpgFVpYo86E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuP/K325U1FBfTHDUNiVqv7x6wDdCriOQDAEZG1bq+PhDNWjjKY8uUU00fLL8qjB1CasKSEvq4s6Yv3+ZX2vZPvTgVevKm2FOo8kz51fRIbLfhuZI+7wYOiX3n6mennxY6NLOtUy8wPbWZu5oKkXQtXOs5xyM9PqCS2PTwbJ82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEnXnPUY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b73a9592fb8so119484266b.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 23:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763624514; x=1764229314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY7vQvZgLPpOq2b0VmqzBieo0OcQymCafIsH9n2wopc=;
        b=LEnXnPUYNyYMiQGp+5XsVKLFWPmZKwdIZHt/W5M2ae8dL5pGWg1bQuz+/fqvo6yAbp
         Fx9y3ikjFtkujmxEgBGT9la3UGOLyQoaCtcqURhGdkCCmcbx7zaDJ3b4iVzTOYM6SDvq
         BblKBqmnxODmBPAF4/U2SQT0HyzU7eTA4m5rc+I64ny2/YPSnImyAShQrRhN/HOSMJ7x
         BCo6q0IhLM7n2JV7t7RAOemy7uHxkcxySxtTuSVjoBV3pmY1nEzx1eLRoZxHvmM7PxcQ
         U+ymJUe5AB3suUsHi/53XJ9u8KybQ4Uw980FWjx9zn2L/WBQALA9keGECz0mq9YHUB3g
         axMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763624514; x=1764229314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AY7vQvZgLPpOq2b0VmqzBieo0OcQymCafIsH9n2wopc=;
        b=Kx0jog5APmNL2gXCcDPb17glVvIhIks40fEaIFtK1V/qFHvnYzUK2Dc5rFMzzkje1X
         gW/riUsBlh7viRydyGfPeiav1Qj0g6RA5mEWkNI/S2wQx/MDNvzgpTdXs13AXda8/xm/
         gyncnbwTf88CFoqejdnrR8X34v4BxAeNSlX1mECApOsmW1Pso1GADBVywBjGW3f0RluN
         PA+/OGCECpxHXqYcf1oupYg8igpZq8AdV/N5phRC+ddpzyapm1q322YxD77FT4aXkq48
         dZALW2Z9rEgvoLtvrl28mAdr7Nckko92db0ZQEhaBYqn1pqpVvWjbh1jQTHtEtuKZCTs
         YX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsyvOCBR7jJlFJstWlQ78bqugVDq7z7160l48sic1vaVketoIUNnLddS0+AUkqWu9Yvdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+90WeLatNxeH2/D0IRYikXcWvQOgSNpnZf1+VNWC/P7ccC2M
	DMEm0flhHP+7QjXBGmU9RKmoK8fu6/FjmeSQCe2K1SqzL49LVjCy/d97sHB5Snis6PYvZTdV+YC
	hvo7c0SigrZVjCsalir9SKsQXwVg7S3w=
X-Gm-Gg: ASbGnctod9907AR/kYxqXqAzFiTRXqj5b2KerTRe419TDAqxWOvPXiES8HrH8n2LjAC
	CWYjjWkNXK7ZHEaOcIoGh0pYlac87jjnS6HUXK6MW2mudypA4JG1O4xlLDYXfjLxdwh0naTblIR
	U6nOCjhYYhT0costI/8MMY/WgHiF5/YtJGE7wy3ZrkxDF/sbkaWvJxGFc+0IKseXQHLjzqk+Tb6
	hZFs1QzkPuVDH9tP572dlg1bKdzOFGBcdUU1zgEZxiXa87DV2s6+88cIOiDmmN+dwvDb5xOpLhk
	/O9pr6U=
X-Google-Smtp-Source: AGHT+IE4tXnoMGl791qkKFmkbInpxx+nqKvSS++fMPmzBlubVDv8KSj46rcZOXbHQRojES90DZyjp7KQcyAGe1F0z7g=
X-Received: by 2002:a17:907:2d9f:b0:b70:83a2:3f5a with SMTP id
 a640c23a62f3a-b7656fad56amr190478266b.0.1763624514295; Wed, 19 Nov 2025
 23:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-5-dolinux.peng@gmail.com> <CAEf4BzaT0RR=iVpgnBOXQpHN++6Soz4ECAYex6bpd2zficSCRQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaT0RR=iVpgnBOXQpHN++6Soz4ECAYex6bpd2zficSCRQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 20 Nov 2025 15:41:42 +0800
X-Gm-Features: AWmQ_bnPg-LE6ZjJ5m3F5BFKRb_Z7PK2OEt8rgM2JyIZur-Ey-FHQ8A3ZORyXM8
Message-ID: <CAErzpmsFpK47tdJ4GvwR_T1c5ie31LNwNY7ED9LReLYCbHxJTA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 4/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:47=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This patch introduces binary search optimization for BTF type lookups
> > when the BTF instance contains sorted types.
> >
> > The optimization significantly improves performance when searching for
> > types in large BTF instances with sorted type names. For unsorted BTF
> > or when nr_sorted_types is zero, the implementation falls back to
> > the original linear search algorithm.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 104 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 81 insertions(+), 23 deletions(-)
> >
>
> [...]
>
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       int err =3D -ENOENT;
> > +
> > +       if (start_id < btf->start_id) {
> > +               err =3D btf_find_type_by_name_kind(btf->base_btf, start=
_id,
> > +                       type_name, kind);
>
> nit: align wrapped args on the second line
>
> also, we expect that err will be set to -ENOENT if we didn't find a
> match in the base BTF, right? I'm a bit uneasy about this, I'd rather
> do explicit err =3D -ENOENT setting for each goto out

Thanks, I will refactor it.

>
> > +               if (err > 0)
> > +                       goto out;
> > +               start_id =3D btf->start_id;
> > +       }
> > +
> > +       if (btf->nr_sorted_types > 0) {
> > +               /* binary search */
> > +               __s32 end_id;
> > +               int idx;
> > +
> > +               end_id =3D btf->start_id + btf->nr_sorted_types - 1;
> > +               idx =3D btf_find_type_by_name_bsearch(btf, type_name, s=
tart_id, end_id);
> > +               for (; idx <=3D end_id; idx++) {
> > +                       t =3D btf__type_by_id(btf, idx);
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, type_name))
>
> nit: please add explicit !=3D 0 here

Thanks. I will fix it.

>
> also, why not just `return -ENOENT;`?

I thought about that, but I feel the function should return from
one place. Frankly, just returning -ENOENT is cleaner

>
> > +                               goto out;
> > +                       if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
> > +                               return idx;
> > +               }
> > +       } else {
> > +               /* linear search */
> > +               __u32 i, total;
> >
> > -               if (name && !strcmp(type_name, name))
> > -                       return i;
> > +               total =3D btf__type_cnt(btf);
> > +               for (i =3D start_id; i < total; i++) {
> > +                       t =3D btf_type_by_id(btf, i);
> > +                       if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > +                               continue;
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (tname && !strcmp(tname, type_name))
>
> nit: let's do explicit =3D=3D 0 for strcmp, please

Thanks, I will fix it.

>
> > +                               return i;
> > +               }
> >         }
> >
> > -       return libbpf_err(-ENOENT);
> > +out:
> > +       return err;
> >  }
> >
> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> >                                    const char *type_name, __u32 kind)
> >  {
> > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > -
> >         if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> >                 return 0;
>
> this is the only thing that btf_find_by_name_kind() does on top of
> what btf_find_type_by_name_kind(), right? Any reason we can't merge
> those and keep only btf_find_by_name_kind()?

Thanks. The check exists in the original btf_find_by_name_kind.
Because btf_find_type_by_name_kind uses recursion, adding the
check there would cause it to run multiple times. I'm open to merging
the functions if the overhead is acceptable.

>
> >
> > -       for (i =3D start_id; i < nr_types; i++) {
> > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -               const char *name;
> > -
> > -               if (btf_kind(t) !=3D kind)
> > -                       continue;
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (name && !strcmp(type_name, name))
> > -                       return i;
> > -       }
> > +       return libbpf_err(btf_find_type_by_name_kind(btf, start_id, typ=
e_name, kind));
> > +}
> >
>
> [...]

