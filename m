Return-Path: <bpf+bounces-21931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDE8540DD
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E292E283E16
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B237C;
	Wed, 14 Feb 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoKyBpb+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB27F
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870792; cv=none; b=dfFUvb5HZzErfkj4+n9rJO5WOhtSmUh1dena3CfeDj1vmu44XIrg3DJ9+1lq2TYIO7rlU2Bbxwb4Sw/Xen1gL/zqVOJw/ZPdB85eKodARJE2W5n65cBZheKXWijYgfHTKN/FpYOGg0Gor/VEIf9/9f3pDuDlPjwOh06EGsQRRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870792; c=relaxed/simple;
	bh=Owptpbm24FTEEN4FtGtQ+nEXV/idTY2s+QZsIlVjkfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9VpWJPMsKdmaKc0AjoKijx7/wkZDtpMamQD0+6oyV1wfvaLfURckYq+bwdAGQAuFEggEpeQC0ctpkAWl/3LCgoaFuAdi3jRvh9DfKgIJ6GOWopE5xiTeJDkdKMKm6qujRRin8jzhbISeIJSFLkHkb2iGi1UnCPQj954b5hrmDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoKyBpb+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so3466010f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707870789; x=1708475589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x2WNHiyjORQ3cesMvySm7mEwT4WaTJCyjtxON0pehY=;
        b=FoKyBpb+lEfM/vOxtMRYefS5+3IE1LRplTFLGioT2NzJaEmm2xufT5ZaU6XHBovr+a
         m2pKAcxXRyA2qozgephkOuR2MQ7yQvUA3GEcuUbCZZpZcaydL/EfS6zNcDWd5qVZ9EyU
         KiQ+UKfbwVJpTHm+iGfqrJll/X5YTLy9xJon0ouLj400eeT9p59uh95DxOZ8iQAlU6CE
         QR3wcEqxNi6rNepvtOKkYSXu1VAVXSrQmowPHJ6xUk8cwBLCcjegC+FjMrGztE8TraqH
         J1O7DdNsKC2mhYqeWQnuAP5UAgTgqupNCwqkXHj0tOJzRE0VjCoaI//gI1fKYLVNoxEO
         VupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707870789; x=1708475589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0x2WNHiyjORQ3cesMvySm7mEwT4WaTJCyjtxON0pehY=;
        b=kK0zhAgiO+qll6avGr6DhTzfhTfeA7yV8iG95pzE206dL53oUJsSbRkUjDR6plXEdD
         gF3MdtH3qSNQp0UChxVURwzjDVIesIKuADYOHCzwjyiw04PGaDuLB293HvWZ+xlob8AC
         X5GKcWHopxVA9jy1p7g9gq35slEyj9N0V/a2YaCZfdH1xC5og/E0DGfcHbWx4DooipMR
         G+bDje1n5sANdEsnx/C62JzTCyNMFWLMEbUovX5nb8gXRwEwcwUiFCO2GrKzIojkGAOS
         s+3wdt8NdOl6Srn/5k3deis3tAdOfZLRfy+jFtG+SaR5fcyxS/8swbzTQy4eCwsX8pK7
         V7BQ==
X-Gm-Message-State: AOJu0YwseMdbbIkGPSkV4LTmP8ImQIUsD+I3hrjamOrr/+zLejjyXRvy
	IF5MWMJqVD0NFVFJh3+Ks5xvXZwK7RfvVtM/50dVcuuBAIAXpvSlzyf3hR/T47yg0KqbeATVLlD
	5K5dnK+No5qAZva2SGZhmttzJDfQ=
X-Google-Smtp-Source: AGHT+IERYm7QlCAALmHKq5bz6Re3LbvIFvhGYHGcD1OHSZ8rFdDdFL6IBxFqsG8wKmI4jm8TgoedXgxzfw3e1J3v7ts=
X-Received: by 2002:a5d:5505:0:b0:33c:deed:673d with SMTP id
 b5-20020a5d5505000000b0033cdeed673dmr499308wrv.21.1707870788925; Tue, 13 Feb
 2024 16:33:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-13-alexei.starovoitov@gmail.com> <CAEf4BzYTGUpYXrbXq7dXQSjXgVFAe=oVYxno-PKQPRHGxW2UiQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYTGUpYXrbXq7dXQSjXgVFAe=oVYxno-PKQPRHGxW2UiQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Feb 2024 16:32:57 -0800
Message-ID: <CAADnVQ+p6EG-BsAYtFyK0ERaA6mbZnLafCd5=yRu+XsLevdv7A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > mmap() bpf_arena right after creation, since the kernel needs to
> > remember the address returned from mmap. This is user_vm_start.
> > LLVM will generate bpf_arena_cast_user() instructions where
> > necessary and JIT will add upper 32-bit of user_vm_start
> > to such pointers.
> >
> > Fix up bpf_map_mmap_sz() to compute mmap size as
> > map->value_size * map->max_entries for arrays and
> > PAGE_SIZE * map->max_entries for arena.
> >
> > Don't set BTF at arena creation time, since it doesn't support it.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/libbpf_probes.c |  7 ++++++
> >  2 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 01f407591a92..4880d623098d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -185,6 +185,7 @@ static const char * const map_type_name[] =3D {
> >         [BPF_MAP_TYPE_BLOOM_FILTER]             =3D "bloom_filter",
> >         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
> >         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
> > +       [BPF_MAP_TYPE_ARENA]                    =3D "arena",
> >  };
> >
> >  static const char * const prog_type_name[] =3D {
> > @@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(struct=
 bpf_object *obj)
> >         return map;
> >  }
> >
> > -static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_=
entries)
> > +static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int ma=
x_entries)
>
> please rename this to array_map_mmap_sz, underscores are not very meaning=
ful

makes sense.

> >  {
> >         const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> >         size_t map_sz;
> > @@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int value=
_sz, unsigned int max_entries)
> >         return map_sz;
> >  }
> >
> > +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> > +{
> > +       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> > +
> > +       switch (map->def.type) {
> > +       case BPF_MAP_TYPE_ARRAY:
> > +               return __bpf_map_mmap_sz(map->def.value_size, map->def.=
max_entries);
> > +       case BPF_MAP_TYPE_ARENA:
> > +               return page_sz * map->def.max_entries;
> > +       default:
> > +               return 0; /* not supported */
> > +       }
> > +}
> > +
> >  static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, siz=
e_t new_sz)
> >  {
> >         void *mmaped;
> > @@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
> >         pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, fl=
ags %x.\n",
> >                  map->name, map->sec_idx, map->sec_offset, def->map_fla=
gs);
> >
> > -       mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max_e=
ntries);
> > +       mmap_sz =3D bpf_map_mmap_sz(map);
> >         map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> >                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >         if (map->mmaped =3D=3D MAP_FAILED) {
> > @@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_obje=
ct *obj, struct bpf_map *map, b
> >         case BPF_MAP_TYPE_SOCKHASH:
> >         case BPF_MAP_TYPE_QUEUE:
> >         case BPF_MAP_TYPE_STACK:
> > +       case BPF_MAP_TYPE_ARENA:
> >                 create_attr.btf_fd =3D 0;
> >                 create_attr.btf_key_type_id =3D 0;
> >                 create_attr.btf_value_type_id =3D 0;
> > @@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_obj=
ect *obj, struct bpf_map *map, b
> >         if (map->fd =3D=3D map_fd)
> >                 return 0;
> >
> > +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> > +               map->mmaped =3D mmap((void *)map->map_extra, bpf_map_mm=
ap_sz(map),
> > +                                  PROT_READ | PROT_WRITE,
> > +                                  map->map_extra ? MAP_SHARED | MAP_FI=
XED : MAP_SHARED,
> > +                                  map_fd, 0);
> > +               if (map->mmaped =3D=3D MAP_FAILED) {
> > +                       err =3D -errno;
> > +                       map->mmaped =3D NULL;
> > +                       close(map_fd);
> > +                       pr_warn("map '%s': failed to mmap bpf_arena: %d=
\n",
> > +                               bpf_map__name(map), err);
>
> seems like we just use `map->name` directly elsewhere in this
> function, let's keep it consistent

that was to match the next patch, since arena is using real_name.
map->name is also correct and will have the same name here.
The next patch will have two arena maps, but one will never be
passed into this function to create a real kernel map.
So I can use map->name here, but bpf_map__name() is a bit more correct.

> > +                       return err;
> > +               }
> > +       }
> > +
> >         /* Keep placeholder FD value but now point it to the BPF map ob=
ject.
> >          * This way everything that relied on this map's FD (e.g., relo=
cated
> >          * ldimm64 instructions) will stay valid and won't need adjustm=
ents.
> > @@ -8582,7 +8613,7 @@ static void bpf_map__destroy(struct bpf_map *map)
> >         if (map->mmaped) {
> >                 size_t mmap_sz;
> >
> > -               mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->d=
ef.max_entries);
> > +               mmap_sz =3D bpf_map_mmap_sz(map);
> >                 munmap(map->mmaped, mmap_sz);
> >                 map->mmaped =3D NULL;
> >         }
> > @@ -9830,8 +9861,8 @@ int bpf_map__set_value_size(struct bpf_map *map, =
__u32 size)
> >                 int err;
> >                 size_t mmap_old_sz, mmap_new_sz;
> >
>
> this logic assumes ARRAY (which are the only ones so far that could
> have `map->mapped !=3D NULL`, so I think we should error out for ARENA
> maps here, instead of silently doing the wrong thing?
>
> if (map->type !=3D BPF_MAP_TYPE_ARRAY)
>     return -EOPNOTSUPP;
>
> should do

Good point. Will do.

