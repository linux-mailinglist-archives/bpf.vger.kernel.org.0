Return-Path: <bpf+bounces-50571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF1A29DC5
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000973A769E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834211373;
	Thu,  6 Feb 2025 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2heMLyO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC92904
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800572; cv=none; b=UTx5DpZtLIEenVmlotlLy3gVbAWycJO0n+TRC9mOzvHdiMumSGRxaPrPPNIpSnbbcVuaKqMesZwyZbq0QxlSw33va6zp5l+nG0r8uMT8i/fh4dPiQW6JGfEKsoJrSIuKqV1fc7/LJpGYOH2lFDVSybjzcMxmomMUyY+ud8hOJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800572; c=relaxed/simple;
	bh=zgo+SsB9sfiycK2vrS7orO4AjYc5sexjKRJVG7DQLnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scK+TazENyJzPsAbHoxP5GA/0mUPixeryo5oc6PSWOj94RVS38pzp+4xUcEzwUXzz90BafCLoyk8O7eze+la/3lKG/t8ynp8s95emMZHjQOynmI0Shvh6D5vGb6II8d4c12uPzmRhKpwt28zxaDtyDIJNSK4Px+seob3dbtSfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2heMLyO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso7375195ad.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800569; x=1739405369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slQ7ZnLn/NoQaHAIWtwzyYHeMqWtEufAHyCFNrZwd1c=;
        b=J2heMLyO5MhrOwqJc3La1TD0SUhEwsik8TYXpo71gFHz2tMCHoGTOMwgOXNiRFJhsw
         qh8/mIl+hnrxdrEZG7CJMyuxA1UN4rlMWzI5616JK8Fen/TlC9sHS4f03mnRczqlKbtc
         b7IZDQk8kceWhRTGsO+ag6SCSAvgQ4IGwoxjiMCZpnFh5TNBDz0JnpZ1dlk4Z7JlhNR0
         rfm6yNwXJCdd6uVt21vAh0TUa0ERmwC/Pc2Qqc6oW7e0rT1fz5JZVa/y0donkldCLwFx
         Rm2t8OsIJ00mnE+10AWbbpdsymD1zic6Ke398inFhO19Opd1ecIxyjGm+drpqyNlQMtu
         ifFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800569; x=1739405369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slQ7ZnLn/NoQaHAIWtwzyYHeMqWtEufAHyCFNrZwd1c=;
        b=vf9cdFUmCQG7YUKcU3ffVY2uGfMIV3cwqrCt0y4UxRXmzz4F5f9WvwV2+JKqqwWJG2
         yg7IyWf//G1peO7aIsthS8S2A+0QXaZ89HNfqEJ/sUl+sPtR9fshkhdn3yEH0YiiYilF
         Ye2IIqrhmDYdNszHfYOwZPgYdbJ2xIl3z+wC0kKaUJKIi2Xq+wMhJpd/ugZH1TlyydX7
         pbTflLFj2JpYyoEe0vPEMm2s+gdAf2mdBOlyXWnxRXWJZ226BeVt/C7Ul5HlNS5egyhf
         1rR2crq0pgH7r3Yw2JBgYVI5zcbEC/p9oRuUu+ZnUUXwPPYxoYBrC5mpbBvgxNr0czxO
         m3vA==
X-Gm-Message-State: AOJu0YxNug7SNKyEd4uAHpTgF8WokqN8DC4lulccxR0RirubSCounEKu
	3Cnu6M3IP9Qqdme8r566WCrsDbhjfYfd5oSNGOFtA9OTEUwxRwgesvi/tbUYgS+c3oKPDVEmsdZ
	ZN+78X12z0rRSVawy0Vwfq6gQdh8=
X-Gm-Gg: ASbGncsKVSt7djXUsOODufjKU76/ORKNP3pb/u7KWD77b+nq11P308zTOdkL0VsF8JZ
	3FBBV5aggeGprBrcEeg7/oRLspFBrvjkWRzPiVhTWJpSe5r8RToEO9buWCGG8ZNxd7hM3tAvgfT
	Ano0w9eTBhVfID
X-Google-Smtp-Source: AGHT+IG6WoWqkdu9WxBgChevY+/ImXaKkHAkREI/ykMoOLncrzpL3zaD14ZW93R7kFY+5hdoWuk/hKRRaDW51FF1w8Y=
X-Received: by 2002:a05:6a20:394c:b0:1ed:a6c6:7206 with SMTP id
 adf61e73a8af0-1ede88231c8mr6419223637.8.1738800569423; Wed, 05 Feb 2025
 16:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-3-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:09:13 -0800
X-Gm-Features: AWEUYZlsc36TFmiqyCuPY7UdEDAQtFNmIWdzmz7DxK3Ihc5dZ_uJxCTthqVmFaY
Message-ID: <CAEf4Bza87kazAf2HfMZdqLCw4RfXRF+zMmfQs4cO_PYE2zKjOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, libbpf: Support global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces support for global percpu data in libbpf. A new
> section named ".percpu" is added, similar to the existing ".data" section=
.
> Internal maps are created for ".percpu" sections, which are then
> initialized and populated accordingly.
>
> The changes include:
>
> * Introduction of the ".percpu" section in libbpf.
> * Creation of internal maps for percpu data.
> * Initialization and population of these maps.
>
> This enhancement allows BPF programs to efficiently manage and access
> percpu global data, improving performance for use cases that require
> percpu buffer.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 172 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 135 insertions(+), 37 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da51725..6da6004c5c84d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
>  };
>
>  #define DATA_SEC ".data"
> +#define PERCPU_DATA_SEC ".percpu"
>  #define BSS_SEC ".bss"
>  #define RODATA_SEC ".rodata"
>  #define KCONFIG_SEC ".kconfig"
> @@ -530,6 +531,7 @@ enum libbpf_map_type {
>         LIBBPF_MAP_BSS,
>         LIBBPF_MAP_RODATA,
>         LIBBPF_MAP_KCONFIG,
> +       LIBBPF_MAP_PERCPU_DATA,

nit: let's keep it shorter: LIBBPF_MAP_PERCPU

>  };
>
>  struct bpf_map_def {
> @@ -562,6 +564,7 @@ struct bpf_map {
>         __u32 btf_value_type_id;
>         __u32 btf_vmlinux_value_type_id;
>         enum libbpf_map_type libbpf_type;
> +       void *data;
>         void *mmaped;
>         struct bpf_struct_ops *st_ops;
>         struct bpf_map *inner_map;
> @@ -640,6 +643,7 @@ enum sec_type {
>         SEC_DATA,
>         SEC_RODATA,
>         SEC_ST_OPS,
> +       SEC_PERCPU_DATA,

ditto, just SEC_PERCPU?

>  };
>
>  struct elf_sec_desc {
> @@ -1923,13 +1927,24 @@ static bool map_is_mmapable(struct bpf_object *ob=
j, struct bpf_map *map)
>         return false;
>  }
>
> +static void map_copy_data(struct bpf_map *map, const void *data)
> +{
> +       bool is_percpu_data =3D map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU=
_DATA;
> +       size_t data_sz =3D map->def.value_size;
> +
> +       if (data)
> +               memcpy(is_percpu_data ? map->data : map->mmaped, data, da=
ta_sz);
> +}
> +
>  static int
>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
>                               const char *real_name, int sec_idx, void *d=
ata, size_t data_sz)
>  {
> +       bool is_percpu_data =3D type =3D=3D LIBBPF_MAP_PERCPU_DATA;
>         struct bpf_map_def *def;
>         struct bpf_map *map;
>         size_t mmap_sz;
> +       size_t elem_sz;

nit: just:

size_t mmap_sz, elem_sz;

>         int err;
>
>         map =3D bpf_object__add_map(obj);
> @@ -1948,7 +1963,8 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         }
>
>         def =3D &map->def;
> -       def->type =3D BPF_MAP_TYPE_ARRAY;
> +       def->type =3D is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
> +                                  : BPF_MAP_TYPE_ARRAY;

nit: single line

>         def->key_size =3D sizeof(int);
>         def->value_size =3D data_sz;
>         def->max_entries =3D 1;

[...]

> +               if (map_is_mmapable(obj, map))
> +                       def->map_flags |=3D BPF_F_MMAPABLE;
> +
> +               mmap_sz =3D bpf_map_mmap_sz(map);
> +               map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRIT=
E,
> +                                  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +               if (map->mmaped =3D=3D MAP_FAILED) {
> +                       err =3D -errno;
> +                       map->mmaped =3D NULL;
> +                       pr_warn("map '%s': failed to alloc content buffer=
: %s\n",
> +                               map->name, errstr(err));
> +                       goto free_name;
> +               }
> +
> +               map_copy_data(map, data);

why not memcpy() here? you know it's not percpu map, so why obscuring
that memcpy?


> +       }
>
>         pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>         return 0;

[...]

> @@ -5125,23 +5180,54 @@ static int
>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map=
 *map)
>  {
>         enum libbpf_map_type map_type =3D map->libbpf_type;
> -       int err, zero =3D 0;
> +       bool is_percpu_data =3D map_type =3D=3D LIBBPF_MAP_PERCPU_DATA;
> +       int err =3D 0, zero =3D 0;
> +       void *data =3D NULL;
> +       int num_cpus, i;
> +       size_t data_sz;
> +       size_t elem_sz;
>         size_t mmap_sz;

nit: keep those size_t variables grouped: `size_t mmap_sz, data_sz, elem_sz=
;`

>
> +       data_sz =3D map->def.value_size;
> +       if (is_percpu_data) {
> +               num_cpus =3D libbpf_num_possible_cpus();
> +               if (num_cpus < 0) {
> +                       err =3D libbpf_err_errno(num_cpus);

why? num_cpus *IS* error code if num_cpus < 0

> +                       pr_warn("map '%s': failed to get num_cpus: %s\n",
> +                               bpf_map__name(map), errstr(err));

this is unlikely to happen, I'd drop pr_warn()

> +                       return err;
> +               }
> +
> +               elem_sz =3D roundup(data_sz, 8);
> +               data_sz =3D elem_sz * num_cpus;
> +               data =3D malloc(data_sz);
> +               if (!data) {
> +                       err =3D -ENOMEM;
> +                       pr_warn("map '%s': failed to malloc memory: %s\n"=
,
> +                               bpf_map__name(map), errstr(err));

-ENOMEM is rather self-descriptive (and generally not expected), so
don't add pr_warn() for such cases

> +                       return err;
> +               }
> +
> +               for (i =3D 0; i < num_cpus; i++)
> +                       memcpy(data + i * elem_sz, map->data, elem_sz);
> +       } else {
> +               data =3D map->mmaped;
> +       }
> +

[...]

>  static void bpf_map__destroy(struct bpf_map *map);
> @@ -8120,7 +8209,9 @@ static int bpf_object__sanitize_maps(struct bpf_obj=
ect *obj)
>         struct bpf_map *m;
>
>         bpf_object__for_each_map(m, obj) {
> -               if (!bpf_map__is_internal(m))
> +               if (!bpf_map__is_internal(m) ||
> +                   /* percpu data map is internal and not-mmapable. */
> +                   m->libbpf_type =3D=3D LIBBPF_MAP_PERCPU_DATA)

original logic would work anyways, no? let's not add unnecessary
special casing here

>                         continue;
>                 if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
>                         m->def.map_flags &=3D ~BPF_F_MMAPABLE;
> @@ -9041,6 +9132,8 @@ static void bpf_map__destroy(struct bpf_map *map)
>         if (map->mmaped && map->mmaped !=3D map->obj->arena_data)
>                 munmap(map->mmaped, bpf_map_mmap_sz(map));
>         map->mmaped =3D NULL;
> +       if (map->data)
> +               zfree(&map->data);
>

this whole map->mmaped and map->data duality and duplication seems not
worth it, tbh. Maybe we should keep using map->mmaped (we probably
could name it more generically at some point, but I don't want to
start bike shedding now) even for malloc'ed memory? After all, we
already have ARENA as another special case? WDYT, can your changes be
implemented by reusing map->mmaped, taking into account a type of map?

pw-bot: cr

>         if (map->st_ops) {
>                 zfree(&map->st_ops->data);
> @@ -10132,14 +10225,18 @@ int bpf_map__fd(const struct bpf_map *map)
>
>  static bool map_uses_real_name(const struct bpf_map *map)
>  {
> -       /* Since libbpf started to support custom .data.* and .rodata.* m=
aps,
> -        * their user-visible name differs from kernel-visible name. User=
s see
> -        * such map's corresponding ELF section name as a map name.
> -        * This check distinguishes .data/.rodata from .data.* and .rodat=
a.*
> -        * maps to know which name has to be returned to the user.
> +       /* Since libbpf started to support custom .data.*, .percpu.* and
> +        * .rodata.* maps, their user-visible name differs from kernel-vi=
sible
> +        * name. Users see such map's corresponding ELF section name as a=
 map
> +        * name. This check distinguishes .data/.percpu/.rodata from .dat=
a.*,
> +        * .percpu.* and .rodata.* maps to know which name has to be retu=
rned to
> +        * the user.
>          */
>         if (map->libbpf_type =3D=3D LIBBPF_MAP_DATA && strcmp(map->real_n=
ame, DATA_SEC) !=3D 0)
>                 return true;
> +       if (map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU_DATA &&
> +           strcmp(map->real_name, PERCPU_DATA_SEC) !=3D 0)
> +               return true;

nit: shorten LIBBPF_MAP_PERCPU_DATA and keep single line, please

>         if (map->libbpf_type =3D=3D LIBBPF_MAP_RODATA && strcmp(map->real=
_name, RODATA_SEC) !=3D 0)
>                 return true;
>         return false;
> @@ -10348,7 +10445,8 @@ int bpf_map__set_initial_value(struct bpf_map *ma=
p,
>         if (map->obj->loaded || map->reused)
>                 return libbpf_err(-EBUSY);
>
> -       if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG)
> +       if ((!map->mmaped && !map->data) ||
> +           map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG)
>                 return libbpf_err(-EINVAL);
>
>         if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
> @@ -10358,7 +10456,7 @@ int bpf_map__set_initial_value(struct bpf_map *ma=
p,
>         if (size !=3D actual_sz)
>                 return libbpf_err(-EINVAL);
>
> -       memcpy(map->mmaped, data, size);
> +       map_copy_data(map, data);
>         return 0;
>  }
>
> @@ -10370,7 +10468,7 @@ void *bpf_map__initial_value(const struct bpf_map=
 *map, size_t *psize)
>                 return map->st_ops->data;
>         }
>
> -       if (!map->mmaped)
> +       if (!map->mmaped && !map->data)
>                 return NULL;
>
>         if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
> @@ -10378,7 +10476,7 @@ void *bpf_map__initial_value(const struct bpf_map=
 *map, size_t *psize)
>         else
>                 *psize =3D map->def.value_size;
>
> -       return map->mmaped;
> +       return map->libbpf_type =3D=3D LIBBPF_MAP_PERCPU_DATA ? map->data=
 : map->mmaped;

Good chunk of changes like this wouldn't be necessary if we just reuse
map->mmaped.


>  }
>
>  bool bpf_map__is_internal(const struct bpf_map *map)
> --
> 2.47.1
>

