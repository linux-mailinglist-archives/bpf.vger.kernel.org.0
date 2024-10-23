Return-Path: <bpf+bounces-42914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7C9ACF92
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90DB284942
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4550F1C7B6D;
	Wed, 23 Oct 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPyim7ts"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4D1C174A
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699159; cv=none; b=VWMhzTOC+fe5NETUveAEc2LhzztEKYPY5rT+BEX3muCPjOSrlUa+oCNUibeVokwmJGVK3M/cu+m70fO54qRxygW4gtl3j1aVbHmyKWI9yQaek3G54V1gtwynOxUi1u3W3NVfU0pHhRaivBRiN7Qkar5wx5vVK0+jU1EeFUh5k1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699159; c=relaxed/simple;
	bh=U5Pckgt1hgO1FhusQBrM6D6FXJ0lH61SnHwpIFaH850=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkoWPwhib4G7+qkAeuFwMFTFLt364g2HbnO3nZhUzn99MfhcYqz/nlqLjXUR8PgtLB6biwO/vZdo7mr5qdHP1lcuSdaI1Z+VQQDcPwVEyYkZ9yL31QwI2hk2tn35f3k2as8pzVQ/nmtmaZt9LF4W2w/maOixzHCM2I33j7KVJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPyim7ts; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso651754a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729699157; x=1730303957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJs4AAk/KokRBhYD2qED6dxVXrWUhjscpUfE77Jwx8I=;
        b=bPyim7tsMD4p+M6EI7BgksWUNgkL/wksb5SMO+h1O8NqmRZ6nW21uVVP6msPEZG7He
         Meq1AwetfSXMjGRhnfmF1MfAKhuMlpZ64+xTpJCvsP599Hr+oGO0HezuWlPcknJ4zVAH
         B3h4DubMS0TbgnLfwDkJXdOrhB8jNK8ZUaHeJapKGd66EEJEbxZBk1/w8oxa0nDnxI3f
         q4tp1lo3aWOr9hR1f3xfaKxsV9ExZbFisXFo1y3nj25dYmGpbDaou2YzDTBWmQWoUd4M
         iVZWsqdLLankAmieWyz/LGKI6lkYJhutmiAMV/V7Ruz6prbq25qBwLWYWhWKzViId+Pl
         B8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699157; x=1730303957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJs4AAk/KokRBhYD2qED6dxVXrWUhjscpUfE77Jwx8I=;
        b=eQ0YvkBQcrAoxL0dCwO3atiwMcvvr4bTlJ+Ahp/69LZblLZgksREhIH3QTIYX7xJK1
         fhkvSk3DJdmmQdKxotowQNEHqeD1MBG/2LRAOlC0wdW9qgsiL/8u03RrF+h7VLy+nPtA
         MNREj3HTh9Um3sC94WBUPj8krWJZmL4i4oQtS1c8rnMqwPSW5fCLcQuy/oMzZaFuwwvE
         S5O2tB5yk5c0w0DvEoGC0Rr/OvX5LFrHbIHBMAKkxat0OvzaQUQS6hvoCnR4hrA2m2Em
         /lsqRG0o1IIH755+9FOPIPZB/JHIIHmrjWmubgt/xoJ3WtL2QOng0gKgFQLZjKNbJHzQ
         KrnA==
X-Forwarded-Encrypted: i=1; AJvYcCWvCqcC9GwwZDDCkcABMV66u2IIL6Bz8X4/sgPZol4J4XGrNFy2wG4qKDncvH91C6knXUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTncoFXxVgtciEtxJv7GQK4ULShtXaTpsYuizFYyE4OvyPNvEV
	2hr/pWc6WRROgVKnVRvQFMKsOkKx0XGLOLrHc6ZFNG65d7Xulb23tkSuFmsmqBzHqTnPE50vlzX
	jOH52CnSMCYzAqLqrdedOEEHbihE=
X-Google-Smtp-Source: AGHT+IHK+W4d6dL0Cjx4gXjCahbCzyA6mHanpyZj97SFPaXn1ll8bj0e1ylQc3Rl2iT+aggv7W+nw5CTLmQIh4v4s8w=
X-Received: by 2002:a05:6a20:d50f:b0:1cf:3f2a:d1dd with SMTP id
 adf61e73a8af0-1d978b005a4mr3193940637.12.1729699157383; Wed, 23 Oct 2024
 08:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023043908.3834423-1-andrii@kernel.org> <20241023043908.3834423-3-andrii@kernel.org>
 <ZxjyCOWne0qXts5o@krava>
In-Reply-To: <ZxjyCOWne0qXts5o@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 08:59:05 -0700
Message-ID: <CAEf4Bzb-Zi4EZawwOQg59TNckS2KrKSAFryqg9jjqarbBGxdTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: move global data mmap()'ing into bpf_object__load()
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Alastair Robertson <ajor@meta.com>, Jonathan Wiepert <jwiepert@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:54=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Oct 22, 2024 at 09:39:07PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > @@ -5146,11 +5147,43 @@ bpf_object__populate_internal_map(struct bpf_ob=
ject *obj, struct bpf_map *map)
> >               if (err) {
> >                       err =3D -errno;
> >                       cp =3D libbpf_strerror_r(err, errmsg, sizeof(errm=
sg));
> > -                     pr_warn("Error freezing map(%s) as read-only: %s\=
n",
> > -                             map->name, cp);
> > +                     pr_warn("map '%s': failed to freeze as read-only:=
 %s\n",
> > +                             bpf_map__name(map), cp);
> >                       return err;
> >               }
> >       }
> > +
> > +     /* Remap anonymous mmap()-ed "map initialization image" as
> > +      * a BPF map-backed mmap()-ed memory, but preserving the same
> > +      * memory address. This will cause kernel to change process'
> > +      * page table to point to a different piece of kernel memory,
> > +      * but from userspace point of view memory address (and its
> > +      * contents, being identical at this point) will stay the
> > +      * same. This mapping will be released by bpf_object__close()
> > +      * as per normal clean up procedure.
> > +      */
> > +     mmap_sz =3D bpf_map_mmap_sz(map);
> > +     if (map->def.map_flags & BPF_F_MMAPABLE) {
> > +             void *mmaped;
> > +             int prot;
> > +
> > +             if (map->def.map_flags & BPF_F_RDONLY_PROG)
> > +                     prot =3D PROT_READ;
> > +             else
> > +                     prot =3D PROT_READ | PROT_WRITE;
> > +             mmaped =3D mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | =
MAP_FIXED, map->fd, 0);
> > +             if (mmaped =3D=3D MAP_FAILED) {
> > +                     err =3D -errno;
> > +                     pr_warn("map '%s': failed to re-mmap() contents: =
%d\n",
> > +                             bpf_map__name(map), err);
> > +                     return err;
> > +             }
> > +             map->mmaped =3D mmaped;
> > +     } else if (map->mmaped) {
> > +             munmap(map->mmaped, mmap_sz);
> > +             map->mmaped =3D NULL;
> > +     }
>
> this caught my eye because we did not do that in bpf_object__load_skeleto=
n,
> makes sense, but why do we mmap *!*BPF_F_MMAPABLE maps in the first place=
?

The initial mmap(ANONYMOUS) is basically malloc(), but it works
uniformly for both BPF_F_MMAPABLE global data arrays, and non-mmapable
ones. Just a streamlining and thus simplification.

>
> jirka
>
> > +
> >       return 0;
> >  }
> >
> > @@ -5467,8 +5500,7 @@ bpf_object__create_maps(struct bpf_object *obj)
> >                               err =3D bpf_object__populate_internal_map=
(obj, map);
> >                               if (err < 0)
> >                                       goto err_out;
> > -                     }
> > -                     if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA) {
> > +                     } else if (map->def.type =3D=3D BPF_MAP_TYPE_AREN=
A) {
> >                               map->mmaped =3D mmap((void *)(long)map->m=
ap_extra,
> >                                                  bpf_map_mmap_sz(map), =
PROT_READ | PROT_WRITE,
> >                                                  map->map_extra ? MAP_S=
HARED | MAP_FIXED : MAP_SHARED,
> > @@ -13916,46 +13948,11 @@ int bpf_object__load_skeleton(struct bpf_obje=
ct_skeleton *s)
> >       for (i =3D 0; i < s->map_cnt; i++) {
> >               struct bpf_map_skeleton *map_skel =3D (void *)s->maps + i=
 * s->map_skel_sz;
> >               struct bpf_map *map =3D *map_skel->map;
> > -             size_t mmap_sz =3D bpf_map_mmap_sz(map);
> > -             int prot, map_fd =3D map->fd;
> > -             void **mmaped =3D map_skel->mmaped;
> > -
> > -             if (!mmaped)
> > -                     continue;
> > -
> > -             if (!(map->def.map_flags & BPF_F_MMAPABLE)) {
> > -                     *mmaped =3D NULL;
> > -                     continue;
> > -             }
> >
> > -             if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA) {
> > -                     *mmaped =3D map->mmaped;
> > +             if (!map_skel->mmaped)
> >                       continue;
> > -             }
> > -
> > -             if (map->def.map_flags & BPF_F_RDONLY_PROG)
> > -                     prot =3D PROT_READ;
> > -             else
> > -                     prot =3D PROT_READ | PROT_WRITE;
> >
> > -             /* Remap anonymous mmap()-ed "map initialization image" a=
s
> > -              * a BPF map-backed mmap()-ed memory, but preserving the =
same
> > -              * memory address. This will cause kernel to change proce=
ss'
> > -              * page table to point to a different piece of kernel mem=
ory,
> > -              * but from userspace point of view memory address (and i=
ts
> > -              * contents, being identical at this point) will stay the
> > -              * same. This mapping will be released by bpf_object__clo=
se()
> > -              * as per normal clean up procedure, so we don't need to =
worry
> > -              * about it from skeleton's clean up perspective.
> > -              */
> > -             *mmaped =3D mmap(map->mmaped, mmap_sz, prot, MAP_SHARED |=
 MAP_FIXED, map_fd, 0);
> > -             if (*mmaped =3D=3D MAP_FAILED) {
> > -                     err =3D -errno;
> > -                     *mmaped =3D NULL;
> > -                     pr_warn("failed to re-mmap() map '%s': %d\n",
> > -                              bpf_map__name(map), err);
> > -                     return libbpf_err(err);
> > -             }
> > +             *map_skel->mmaped =3D map->mmaped;
> >       }
> >
> >       return 0;
> > --
> > 2.43.5
> >
> >

