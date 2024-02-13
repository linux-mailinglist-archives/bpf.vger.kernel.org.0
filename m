Return-Path: <bpf+bounces-21910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59B853FE0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27DC1C28D32
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87896633EA;
	Tue, 13 Feb 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PImbseTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6E6313D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866133; cv=none; b=bByg/HCfnBa15hfAvy6QdnNf94REqTIIHDcomiOGc7VH/BWLkdbtS9iD8eiNtS7pyE6XBl1J2ss2kZyCoxV8QqIWcTx9XOKltd1sIEnm6hKEINbWM420VqjRxKkN07TVvCwpDQI7LG/0zDdbaO8ZDHvV9cR4n7gA7uNF3FBOjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866133; c=relaxed/simple;
	bh=9d8IAbvveUu2+xKyqOz9Lvd7UXZcljip1dlkYio5r40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy0XEPv/EGQm0uXvClBUrirNil+1QMGvMnD7spv8aY/2ceghZk0SEdOC3VqjDMnuN6oy9CUuDWn+QLtz3+zkcnHVYESBuTesevp8cMlCGRIhHP6u7BKgtizfpqt3NYt2G9+ITqXLadSanX/LT3H6dsmQclGOdv2/3A6KNTfd4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PImbseTa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0a479a6cbso1942038b3a.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866130; x=1708470930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FjMl53jj5jAc1ILn2Q5wZSM5Pt3OeETnKsZC2xWPYg=;
        b=PImbseTamJawcjE3OVJWDAwFOVIK912SVDU8//N9Ik2CEodMYMHhNOYMiJjv7aingN
         SRkQKIPoOm4GyhMEZqEUlU0TE4/OFZxZ7/cPY7pK1Nyd0WWk6F3cnk1kV+UP+Cd9v8M5
         l8RYam5aLNW/XgZxB8cOFMDGtNTJN5hgEYW7FM3pzypYZ+Ze6FY/weaV1p0WqRojfZCY
         lfque1KZzkxktHyohAo5OzgPq4TLl9DuhjE+DPQsnvL69W5hMz/4drD5Jzt7jjA4Ciqs
         drxUA36BlFL/fK6eHzzrRv9j8qhRBgE1+LLUAvW0n4bsTMiqJ4NOkSxjvb7Qwx1chtOS
         ZZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866130; x=1708470930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FjMl53jj5jAc1ILn2Q5wZSM5Pt3OeETnKsZC2xWPYg=;
        b=wE+hZ+iPvjZr7zx1U+9sNwgMDXrsd7GtN8iwm6IRWRE7kIFPcxDnQTvizc3pNYCmI+
         lnvCy/NcbvzwU9zAjAdRTwBLl4lhpDSMbZIAwsVvsh/dDu53kSMAbd17VA6ry4zD4BWc
         iP0bedxm+rOMdrMnQ2qLT2RBx3onVKt8XK/XRGNxivW+mx/qoCaQ6zdui1Yr/9LgNqaI
         w306UB5u+bYPVl+Q73WjxZV4f/Ij5y5vAumLc6ukkdsXh9q1b2RI0OnLeM/n3huaONEa
         FeGnZOF4OoIgZmN4R1SENjDvVOEd2vqFi0kVkXU4DSwwFmuIg0a3jGXlcWWHV50c5Idp
         ZK/A==
X-Gm-Message-State: AOJu0YwNQHiUTVdmeMib3fKejQDBecpKZSFLgN2eH7w7hvMfWTHb3U0Z
	Wy4NhrcovLn91/1sCA7tqH6KJDiWfbBy0RxPTiQpnWoje4ajI3zzggGtKsoqC6f+Cg/rSRBB2rN
	T2T+gmtJ6IZZASDSwN2R2soMjMJo=
X-Google-Smtp-Source: AGHT+IFCce3myqJYkM+YRe6itlN73YMcHSHi23KchJiDtio4ufNcI2QRdFLEzB64BKcF5fh0UjifkDQj+iwnqWLuLSM=
X-Received: by 2002:a05:6a21:1585:b0:19e:bd3e:76e1 with SMTP id
 nr5-20020a056a21158500b0019ebd3e76e1mr1265023pzb.48.1707866129699; Tue, 13
 Feb 2024 15:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-13-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:15:17 -0800
Message-ID: <CAEf4BzYTGUpYXrbXq7dXQSjXgVFAe=oVYxno-PKQPRHGxW2UiQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> mmap() bpf_arena right after creation, since the kernel needs to
> remember the address returned from mmap. This is user_vm_start.
> LLVM will generate bpf_arena_cast_user() instructions where
> necessary and JIT will add upper 32-bit of user_vm_start
> to such pointers.
>
> Fix up bpf_map_mmap_sz() to compute mmap size as
> map->value_size * map->max_entries for arrays and
> PAGE_SIZE * map->max_entries for arena.
>
> Don't set BTF at arena creation time, since it doesn't support it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c        | 43 ++++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf_probes.c |  7 ++++++
>  2 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..4880d623098d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -185,6 +185,7 @@ static const char * const map_type_name[] =3D {
>         [BPF_MAP_TYPE_BLOOM_FILTER]             =3D "bloom_filter",
>         [BPF_MAP_TYPE_USER_RINGBUF]             =3D "user_ringbuf",
>         [BPF_MAP_TYPE_CGRP_STORAGE]             =3D "cgrp_storage",
> +       [BPF_MAP_TYPE_ARENA]                    =3D "arena",
>  };
>
>  static const char * const prog_type_name[] =3D {
> @@ -1577,7 +1578,7 @@ static struct bpf_map *bpf_object__add_map(struct b=
pf_object *obj)
>         return map;
>  }
>
> -static size_t bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_en=
tries)
> +static size_t __bpf_map_mmap_sz(unsigned int value_sz, unsigned int max_=
entries)

please rename this to array_map_mmap_sz, underscores are not very meaningfu=
l

>  {
>         const long page_sz =3D sysconf(_SC_PAGE_SIZE);
>         size_t map_sz;
> @@ -1587,6 +1588,20 @@ static size_t bpf_map_mmap_sz(unsigned int value_s=
z, unsigned int max_entries)
>         return map_sz;
>  }
>
> +static size_t bpf_map_mmap_sz(const struct bpf_map *map)
> +{
> +       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> +
> +       switch (map->def.type) {
> +       case BPF_MAP_TYPE_ARRAY:
> +               return __bpf_map_mmap_sz(map->def.value_size, map->def.ma=
x_entries);
> +       case BPF_MAP_TYPE_ARENA:
> +               return page_sz * map->def.max_entries;
> +       default:
> +               return 0; /* not supported */
> +       }
> +}
> +
>  static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_=
t new_sz)
>  {
>         void *mmaped;
> @@ -1740,7 +1755,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flag=
s %x.\n",
>                  map->name, map->sec_idx, map->sec_offset, def->map_flags=
);
>
> -       mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max_ent=
ries);
> +       mmap_sz =3D bpf_map_mmap_sz(map);
>         map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         if (map->mmaped =3D=3D MAP_FAILED) {
> @@ -4852,6 +4867,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
>         case BPF_MAP_TYPE_SOCKHASH:
>         case BPF_MAP_TYPE_QUEUE:
>         case BPF_MAP_TYPE_STACK:
> +       case BPF_MAP_TYPE_ARENA:
>                 create_attr.btf_fd =3D 0;
>                 create_attr.btf_key_type_id =3D 0;
>                 create_attr.btf_value_type_id =3D 0;
> @@ -4908,6 +4924,21 @@ static int bpf_object__create_map(struct bpf_objec=
t *obj, struct bpf_map *map, b
>         if (map->fd =3D=3D map_fd)
>                 return 0;
>
> +       if (def->type =3D=3D BPF_MAP_TYPE_ARENA) {
> +               map->mmaped =3D mmap((void *)map->map_extra, bpf_map_mmap=
_sz(map),
> +                                  PROT_READ | PROT_WRITE,
> +                                  map->map_extra ? MAP_SHARED | MAP_FIXE=
D : MAP_SHARED,
> +                                  map_fd, 0);
> +               if (map->mmaped =3D=3D MAP_FAILED) {
> +                       err =3D -errno;
> +                       map->mmaped =3D NULL;
> +                       close(map_fd);
> +                       pr_warn("map '%s': failed to mmap bpf_arena: %d\n=
",
> +                               bpf_map__name(map), err);

seems like we just use `map->name` directly elsewhere in this
function, let's keep it consistent

> +                       return err;
> +               }
> +       }
> +
>         /* Keep placeholder FD value but now point it to the BPF map obje=
ct.
>          * This way everything that relied on this map's FD (e.g., reloca=
ted
>          * ldimm64 instructions) will stay valid and won't need adjustmen=
ts.
> @@ -8582,7 +8613,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>         if (map->mmaped) {
>                 size_t mmap_sz;
>
> -               mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def=
.max_entries);
> +               mmap_sz =3D bpf_map_mmap_sz(map);
>                 munmap(map->mmaped, mmap_sz);
>                 map->mmaped =3D NULL;
>         }
> @@ -9830,8 +9861,8 @@ int bpf_map__set_value_size(struct bpf_map *map, __=
u32 size)
>                 int err;
>                 size_t mmap_old_sz, mmap_new_sz;
>

this logic assumes ARRAY (which are the only ones so far that could
have `map->mapped !=3D NULL`, so I think we should error out for ARENA
maps here, instead of silently doing the wrong thing?

if (map->type !=3D BPF_MAP_TYPE_ARRAY)
    return -EOPNOTSUPP;

should do



> -               mmap_old_sz =3D bpf_map_mmap_sz(map->def.value_size, map-=
>def.max_entries);
> -               mmap_new_sz =3D bpf_map_mmap_sz(size, map->def.max_entrie=
s);
> +               mmap_old_sz =3D bpf_map_mmap_sz(map);
> +               mmap_new_sz =3D __bpf_map_mmap_sz(size, map->def.max_entr=
ies);
>                 err =3D bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz=
);
>                 if (err) {
>                         pr_warn("map '%s': failed to resize memory-mapped=
 region: %d\n",
> @@ -13356,7 +13387,7 @@ int bpf_object__load_skeleton(struct bpf_object_s=
keleton *s)
>
>         for (i =3D 0; i < s->map_cnt; i++) {
>                 struct bpf_map *map =3D *s->maps[i].map;
> -               size_t mmap_sz =3D bpf_map_mmap_sz(map->def.value_size, m=
ap->def.max_entries);
> +               size_t mmap_sz =3D bpf_map_mmap_sz(map);
>                 int prot, map_fd =3D map->fd;
>                 void **mmaped =3D s->maps[i].mmaped;
>
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
> index ee9b1dbea9eb..302188122439 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -338,6 +338,13 @@ static int probe_map_create(enum bpf_map_type map_ty=
pe)
>                 key_size =3D 0;
>                 max_entries =3D 1;
>                 break;
> +       case BPF_MAP_TYPE_ARENA:
> +               key_size        =3D 0;
> +               value_size      =3D 0;
> +               max_entries     =3D 1; /* one page */
> +               opts.map_extra  =3D 0; /* can mmap() at any address */
> +               opts.map_flags  =3D BPF_F_MMAPABLE;
> +               break;
>         case BPF_MAP_TYPE_HASH:
>         case BPF_MAP_TYPE_ARRAY:
>         case BPF_MAP_TYPE_PROG_ARRAY:
> --
> 2.34.1
>

