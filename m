Return-Path: <bpf+bounces-21788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FB7852173
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7A81C2228E
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516E4F5FA;
	Mon, 12 Feb 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKL/xn2a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB23E47A
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777030; cv=none; b=eiyUe2+BGisIGibg0aTfLYIT+sRLem9FvLhRv2sNIM273nHitCEgLSSoM2hQ4YadQyscrEeykzY2nSwcXwx04AxC67RRtI95zMGNc6kGwo13d1DEJQdTb+XDELwaJSW5lAbdWaUuTTqvATjQS7d32707qqUaoAfeYX6HahL1C7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777030; c=relaxed/simple;
	bh=tfj5n/CQSJF0/vHRRKW2+RWlT/dir2NiGTE5gp4k2J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXure/81vc3R+6VJhzcn+LGJfsA4yCZ3bOk9SX/PNgBvcSzp7r+5zRQzJqoel1KM0sbzK8pvVg2idJy6VYsWQoZ7OQK/VKDKDPzlt2XRHdS0aay1+UEzh2Mo7L8RqQog5ee5CVTNQoMQaJn9bPtV6/+y3wyUCDZcG8brcId1UJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKL/xn2a; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2d107ae5288so500601fa.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777026; x=1708381826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEJ6Lqdkpw6fVpUxp3rYG6I0VjqWxy4CWbgjI/OFhDc=;
        b=ZKL/xn2apmRMsh1fi1uEZPxCWZSZ8QHDbnALodyvMt64I1wHZoEjWKpFB9tUqNO1ub
         ix9TGvbq6Mvrk9zzmB7KcT1Eb7X+4rgdLVTknhcAEvMGngwIpXZGjaEVOBwpaF59pvmq
         FHxKaEjDXkSRthwep7msBfaI+mpCEPKSM1xxE1XbTO6le/BBgqwFJuuQ2tyiCjnqHDI3
         JQBrF5Rbqpg9uNuK7yT+VzbphB/eG5ngNgDcPhOB29OYcV5sqUq3Hae820fVQ0zb2jwq
         o6Nav1Ra/9lkU7g/nQbmFiTngKRqDDOERV2dswnIP7zvqToceLB70iaGx7hZFY5ktLxL
         V8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777026; x=1708381826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEJ6Lqdkpw6fVpUxp3rYG6I0VjqWxy4CWbgjI/OFhDc=;
        b=Ri/7dc7HwIYUGclYw1LPEiRT5u0OqHK1Y5uwTBiopUq2/qRLor7SLSvEKV6r+BL8ll
         GJoVNcXR2YZ2O/hzlZeYH5rTn3FmVKlwP2GBf3fwsYQFeCFDPBiRdb3+ekF5Ho/bbERN
         InzNY7VM1zLV4Cguf3u8MBuHW2vdHLsW3YOoruBgnd16udg81MOWhnblQCCVzUPq+rSB
         8eCU1H9YT7i4DNWGwYtu7jZuQ3Blo6uxw4H8tmUJIBAqN8sC1NVb0FEhm3B/WK5BecIP
         ZZDhvv2DOJ12YgPYq3ZniV1cMXDqvwfpcrQ9cdios7eyo6m23Uz7BgPg82lZblbSRLrW
         Yuxw==
X-Gm-Message-State: AOJu0YxRg1tVQfJ+cKDQIdCnSrxpfwDPDNNr4c/GSJ+oAlmj084L8StE
	WSoOL6+gTHzBYNJoqsbY8EjqKubcvsCGyvsv4iq1qERKhzBQLD2OQ98hNFJ6RPxjqgQPWBb1fjG
	hmaAhECrbkIee06YuSKMDxSLhkws=
X-Google-Smtp-Source: AGHT+IFFUVJOSkFAlj9RXjhIrlzB069Yadezy2kAnFcy9068je873Ry8rcE2NkM7JxycNQryF6jcwly/wDL9PqIjYgM=
X-Received: by 2002:a2e:3c0f:0:b0:2d0:5f90:2b29 with SMTP id
 j15-20020a2e3c0f000000b002d05f902b29mr5071379lja.12.1707777026097; Mon, 12
 Feb 2024 14:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-13-alexei.starovoitov@gmail.com> <CAP01T761B1+paMwrQesjX+zqFwQp8iUzLORueTjTLSHPbJ+0fQ@mail.gmail.com>
 <CAEf4BzYikhyH8TF8GJy9rLX1SrmGKz1xSd_zFhGYhvXtTFwMgA@mail.gmail.com>
In-Reply-To: <CAEf4BzYikhyH8TF8GJy9rLX1SrmGKz1xSd_zFhGYhvXtTFwMgA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 Feb 2024 23:29:50 +0100
Message-ID: <CAP01T74QOykC09WYf_YFB1Xwi6Qd-8sxk5LGoNqiCMkzQH_qCA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Feb 2024 at 20:11, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Fri, Feb 9, 2024 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > mmap() bpf_arena right after creation, since the kernel needs to
> > > remember the address returned from mmap. This is user_vm_start.
> > > LLVM will generate bpf_arena_cast_user() instructions where
> > > necessary and JIT will add upper 32-bit of user_vm_start
> > > to such pointers.
> > >
> > > Fix up bpf_map_mmap_sz() to compute mmap size as
> > > map->value_size * map->max_entries for arrays and
> > > PAGE_SIZE * map->max_entries for arena.
> > >
> > > Don't set BTF at arena creation time, since it doesn't support it.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++---=
--
> > >  tools/lib/bpf/libbpf_probes.c |  7 ++++++
> > >  2 files changed, 44 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 01f407591a92..4880d623098d 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -185,6 +185,7 @@ static const char * const map_type_name[] =3D {
> > >         [BPF_MAP_TYPE_BLOOM_FILTER]             =3D "bloom_filter",
> > >         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
> > >         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
> > > +       [BPF_MAP_TYPE_ARENA]                    =3D "arena",
> > >  };
> > >
> > >  static const char * const prog_type_name[] =3D {
> > > @@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(stru=
ct bpf_object *obj)
> > >         return map;
> > >  }
> > >
> > > -static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int ma=
x_entries)
> > > +static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int =
max_entries)
> > >  {
> > >         const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > >         size_t map_sz;
> > > @@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int val=
ue_sz, unsigned int max_entries)
> > >         return map_sz;
> > >  }
> > >
> > > +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> > > +{
> > > +       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > > +
> > > +       switch (map->def.type) {
> > > +       case BPF_MAP_TYPE_ARRAY:
> > > +               return __bpf_map_mmap_sz(map->def.value_size, map->de=
f.max_entries);
> > > +       case BPF_MAP_TYPE_ARENA:
> > > +               return page_sz * map->def.max_entries;
> > > +       default:
> > > +               return 0; /* not supported */
> > > +       }
> > > +}
> > > +
> > >  static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, s=
ize_t new_sz)
> > >  {
> > >         void *mmaped;
> > > @@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object=
 *obj, enum libbpf_map_type type,
> > >         pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, =
flags %x.\n",
> > >                  map->name, map->sec_idx, map->sec_offset, def->map_f=
lags);
> > >
> > > -       mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max=
_entries);
> > > +       mmap_sz =3D bpf_map_mmap_sz(map);
> > >         map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> > >                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > >         if (map->mmaped =3D=3D MAP_FAILED) {
> > > @@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_ob=
ject *obj, struct bpf_map *map, b
> > >         case BPF_MAP_TYPE_SOCKHASH:
> > >         case BPF_MAP_TYPE_QUEUE:
> > >         case BPF_MAP_TYPE_STACK:
> > > +       case BPF_MAP_TYPE_ARENA:
> > >                 create_attr.btf_fd =3D 0;
> > >                 create_attr.btf_key_type_id =3D 0;
> > >                 create_attr.btf_value_type_id =3D 0;
> > > @@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_o=
bject *obj, struct bpf_map *map, b
> > >         if (map->fd =3D=3D map_fd)
> > >                 return 0;
> > >
> > > +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> > > +               map->mmaped =3D mmap((void *)map->map_extra, bpf_map_=
mmap_sz(map),
> > > +                                  PROT_READ | PROT_WRITE,
> > > +                                  map->map_extra ? MAP_SHARED | MAP_=
FIXED : MAP_SHARED,
> > > +                                  map_fd, 0);
> > > +               if (map->mmaped =3D=3D MAP_FAILED) {
> > > +                       err =3D -errno;
> > > +                       map->mmaped =3D NULL;
> > > +                       close(map_fd);
> > > +                       pr_warn("map '%s': failed to mmap bpf_arena: =
%d\n",
> > > +                               bpf_map__name(map), err);
> > > +                       return err;
> > > +               }
> > > +       }
> > > +
> >
> > Would it be possible to introduce a public API accessor for getting
> > the value of map->mmaped?
>
> That would be bpf_map__initial_value(), no?
>

Ah, indeed, that would do the trick. Thanks Andrii!

> [...]

