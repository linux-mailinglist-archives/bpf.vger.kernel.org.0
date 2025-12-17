Return-Path: <bpf+bounces-76802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A54CC5C73
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18616301177F
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 02:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35252737EE;
	Wed, 17 Dec 2025 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAA2+sei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B32AE84
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938866; cv=none; b=GloqqqNw1z4rgYcd0sCmxbloPBhageVQ+GD4CegUGh65O9G85AhuTOm/hjInDMuK7LfgFjLxzcgFs0DHU/fKo7CmWY6OgQJaQOuj6VIGGJ5c33sEKVXu95MtkBXdQum764rq6I0KjkpaZj1oB9HKxXxwRwca6G+SL6dgn1i7rRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938866; c=relaxed/simple;
	bh=3jK4e/LxfniZoh3hEznbMoseSzYwEzVAZoP0Z0ZO5ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGoTC3l0LXMjx5EaEkL8gj6YOe7NkJQRJJ015JprFfpzHDdv/I9MSIiJ9m8yIz5sdW6O5df7Hjp/yRKh8RZ4jooPVLgpQmS4aDdkfFJJplcL3OJuRxyYCqZJ0VA9AbhYOgB3yzZRE/4VHwE3p0rUnhgc+8V4oNWZgRwUhh0cZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAA2+sei; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79ea617f55so459605866b.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 18:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765938862; x=1766543662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37Dqa61xFauF/GxuE09FtVzTeHo2qggRB0cj5clwqno=;
        b=MAA2+seiU+ETztzG5eIC4iB+t/E2mcJVuF2SLxjo+15TpkGIHB2Zigf3qWK6rFWeze
         aGYf3o1dJ3eifjT+fde/38pP/QHMD8hp2yL3gBIR6FwhcVV2i5kzrykvqTJ0XtbFohfx
         rY4DfX4wiD4B8frMxh7AP5/14XzYqOMKW2FEWHv62o8RjdLwLOlVk36B1Gh5nrvelHiS
         2o4u7ibDFTJHDwbTHfhi8VW4BLatpA8epadbeG/o5vgNiHPPEjdGrRrdP18xOKw6XjNa
         De2WrVJJbYnBNIcxaaGF2Qh+Cey8FycfCVoD9dwcZFhbrsCHD5fiyxvxybfKnX4c8eVY
         3t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765938862; x=1766543662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37Dqa61xFauF/GxuE09FtVzTeHo2qggRB0cj5clwqno=;
        b=YAJtPa7dnFzL9x7NQJFzhHi4QZmLpNdpJmvFSB57L1AOCkaUVPYjCanBFqNCjRRvDW
         BSQXsbmWdZS9QhZ1pyJW40TomrstEyxu3tVEfpYeIhiL8u+XtqbQ5Qnfqi+Dm8BSL3t0
         lRtdxF9YyxFPu0vdZXtCSJGBxo02+k/kX53ecq/BKNyJ1jdGAV/4Elc08kxHdIKclbxR
         WMDJ9wfx7Cmc5H/wmm5VedqVKpfjJA2IS3rvHOhq1U1xc58Y9LxfydZKEttngGEQOakW
         0GUHXfOMkWeeMjp//6qrz1uu41kXWaYMuswwN0Zeufsiow6nPDhYHAaFtvJMn+VodgLb
         wy7w==
X-Forwarded-Encrypted: i=1; AJvYcCXh9I6b5CzTgQIPRyFnnp0uLcuSYHKmAZQvEva6nhLlArroKTucbZ1Ftu5uzxaZLGFUmx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywct5YQh7Vu88mJyOv1MXx1R5RxEcz3ZtHC/Ma0mtRJMp1jj3xN
	4O0YjLXq1CIG02YaknzYaQ1EfnZKiTNTS8C0jS3auod+uCgxjK5KFIWJpCXhMXYgxHwiYtBsffz
	DCvDlhwhkyY0DWcI6/RdI937OO1wOclQ=
X-Gm-Gg: AY/fxX7w1ETnMo6XVyytYahPTHtqiDyZRaHIo4yjC9W5DTzpJxQbMexXo9ZA5qF0GZy
	En3T7LINNb8yj8wXawXcJXDgwBSXzvsMa1UqWSavMO3Lf55q/y7nAJTj8Cdlm+mwhnStgx4/Zal
	kHIwn8ebgGVq81vHwNByLsuiDQ+HZfOABcWOqEbBdyCd3EEqaTXtKwydtiK7Ech03YGctUDS9tD
	NYGXbzgTFbhiLRjSCn3UYRlpwP16ZBHGrZtMcuVKCAGW4YXZXWEFGyHblbgUtJeSr4yq5oG
X-Google-Smtp-Source: AGHT+IG9OvQW95F5ibjtyFxTZSFfZ4z9jrBw8myTzrMjMMPSa1Y65QmeTbSGzWKQw4WQerlxfFBTqZ6/vTbBb/UqYlA=
X-Received: by 2002:a17:907:3e10:b0:b73:21db:64aa with SMTP id
 a640c23a62f3a-b7d23a971e3mr1378573166b.38.1765938862114; Tue, 16 Dec 2025
 18:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-5-dolinux.peng@gmail.com> <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
 <CAErzpmtLMd6pS9OfeS1=_VTyUqPNfNa4J7d1m_ydC=u4_k8Cbw@mail.gmail.com>
In-Reply-To: <CAErzpmtLMd6pS9OfeS1=_VTyUqPNfNa4J7d1m_ydC=u4_k8Cbw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 10:34:10 +0800
X-Gm-Features: AQt7F2qz4oi-VXIbpbdtop9EnB4XfSkuFZKz-kjDHkXBNenAilN2N7I2w8Qhf4g
Message-ID: <CAErzpmt3aknKcxhbq8+=AxVJthf80-c2hFSK1RqfhwvS_9H0yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:32=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
> On Wed, Dec 17, 2025 at 7:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> >
> > [...]
> >
> > Lgtm, one question below.
> >
> > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_=
id,
> > >                                  const char *type_name, __u32 kind)
> > >  {
> > > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > > +     const struct btf_type *t;
> > > +     const char *tname;
> > > +     __s32 idx;
> > > +
> > > +     if (start_id < btf->start_id) {
> > > +             idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > > +                     type_name, kind);
> > > +             if (idx >=3D 0)
> > > +                     return idx;
> > > +             start_id =3D btf->start_id;
> > > +     }
> > >
> > > -     if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > > +     if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=
=3D 0)
> > >               return 0;
> > >
> > > -     for (i =3D start_id; i < nr_types; i++) {
> > > -             const struct btf_type *t =3D btf__type_by_id(btf, i);
> > > -             const char *name;
> > > +     if (btf->sorted_start_id > 0) {
> > > +             __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > +
> > > +             /* skip anonymous types */
> > > +             start_id =3D max(start_id, btf->sorted_start_id);
> > > +             idx =3D btf_find_by_name_bsearch(btf, type_name, start_=
id, end_id);
> > > +             if (unlikely(idx < 0))
> > > +                     return libbpf_err(-ENOENT);
> > > +
> > > +             if (unlikely(kind =3D=3D -1))
> > > +                     return idx;
> > > +
> > > +             t =3D btf_type_by_id(btf, idx);
> > > +             if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > > +                     return idx;
> > > +
> > > +             for (idx++; idx <=3D end_id; idx++) {
> > > +                     t =3D btf__type_by_id(btf, idx);
> > > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > > +                     if (strcmp(tname, type_name) !=3D 0)
> > > +                             return libbpf_err(-ENOENT);
> > > +                     if (btf_kind(t) =3D=3D kind)
> >                             ^^^^^^^^^^^^^^^^^^^
> >                 Is kind !=3D -1 check missing here?
>
> The check for kind !=3D -1 is unnecessary here because it has already bee=
n
> performed earlier in the logic, after btf_find_by_name_bsearch successful=
ly
> returned a valid idx. In v8, the implementation of btf_find_by_name_bsear=
ch
> was refined for better performance, and when idx > 0, it guarantees that =
the
> name has been matched.
>
> Thank you for the review.
> Donglin
>
> >
> > > +                             return idx;
> > > +             }
> > > +     } else {
> > > +             __u32 i, total;
> > >
> > > -             if (btf_kind(t) !=3D kind)
> > > -                     continue;
> > > -             name =3D btf__name_by_offset(btf, t->name_off);
> > > -             if (name && !strcmp(type_name, name))
> > > -                     return i;
> > > +             total =3D btf__type_cnt(btf);
> > > +             for (i =3D start_id; i < total; i++) {
> > > +                     t =3D btf_type_by_id(btf, i);
> > > +                     if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > > +                             continue;
> > > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > > +                     if (tname && strcmp(tname, type_name) =3D=3D 0)
> >
> > Nit: no need for `tname &&` part, as we found out.

Thanks, I will remove the check in the next version.

> >
> > > +                             return i;
> > > +             }
> > >       }
> > >
> > >       return libbpf_err(-ENOENT);
> > >  }
> > >
> > > +/* the kind value of -1 indicates that kind matching should be skipp=
ed */
> > > +__s32 btf__find_by_name(const struct btf *btf, const char *type_name=
)
> > > +{
> > > +     return btf_find_by_name_kind(btf, btf->start_id, type_name, -1)=
;
> > > +}
> > > +
> > >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *=
type_name,
> > >                                __u32 kind)
> > >  {
> >
> > [...]

