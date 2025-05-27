Return-Path: <bpf+bounces-59029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD24AC5D27
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB1E165539
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AB2139B0;
	Tue, 27 May 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVSZrIta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30F23A6
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385094; cv=none; b=BYDHlzHYQOxdwQxOyF73VlDvp34WTtdZZdxKto+Bs8HxurrDh9Yrpo5cPa/HrPMuf+nf8a6IMjSzY8AnwH4ZwNFHxjv3y19JAs/5Px08EMGoflRBo7VHbuuqsp0QRYhF4N3iMUtiPE2ex7I9T6v4tOrt1pYIX/86Og+uHil8R7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385094; c=relaxed/simple;
	bh=PEhtj2S8EcaOxsin/TvXnA9u2u+u+qnc1BKeSZqLaIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srjrY6vBi8CXs7JuX67P2uyxtuf62aCyUBuppVDUfQL+D8/LsAmgtLgH4q9dw051xbhihKEvhpQPm76ffhoDZojThTZOCnRfGXUQu8U7O1u9kkl+fWYNkCDZ5Q1Z+1dWzJFVz2LySIVSUyuxWykUTefyJ65mqB7DoiedixDfTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVSZrIta; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c27df0daso2908587b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385092; x=1748989892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA5tZprOjSKi+OAdGWArecazGfOtDzWi5Yr0onmwu4c=;
        b=KVSZrItaMx0aLvOQ1Z35A+DtsR04gOSY2sXcsg5ZTJ55HvUHf4H/UPjB8tXCHNYbFl
         yDr5RSgDHXd+AuOWICtiooNG6k92lAmo1Aadhik2NuFej50fdsDAWpXfo2Yu7n/6mNsU
         wCT8ajFSDp0zUILEIBhCcnGonKutvfYEu3ENfmUBI1Soja9V9RD32AHU7PA/nb1uoDN7
         wmINdunsBYTi21zpcu4ZZUyw+awV9nQgqGDTCOdgr7x38mTkVqQeCKLwoRdod8lwtOpy
         iLA+H4ZKD06nlhCguHqzInwuOiB1bhehcfT6LRrEA7kNGB3oQzFJVA2vh6a3u0mLRMwr
         iyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385092; x=1748989892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA5tZprOjSKi+OAdGWArecazGfOtDzWi5Yr0onmwu4c=;
        b=jyYpT7R9KpqPyyRWwc3udPqBmCJYdhsh5p0eAJcelHZjPFs18cF8w93vy7D0QW/Gzs
         lL5k+it3hmwVl2HYk3RIKvxKXAUiwXpZWy3lpCtITrZdCzz5aODCWtCNHpT0KH78dLrA
         Y7U3ckdwf9wDQBFrnTw7RgW8HdPHoxXy7ewDuoIbupct/dfrU3SjSFcvzWtCzGV58d2R
         sgUvHKsjHSFsiNHGG2DTM2DEp9tS+gx7hva9DOH8ccL4XQHTtg3kQaClXJzAPohCOcPn
         bgjwuA9kBsIq5lTukwKjlgJtUq3CM3ttckIY2qgrVuqmMj1Upb6UFaAeVwxvWN3I3NOI
         AC1Q==
X-Gm-Message-State: AOJu0YwUve6c2BgGFtZsuuVRXZQAwmvwzLa+T2e3MUzb1j1/ezn1XbhE
	n9LbnJFtnYRvX30wXRzaVgjXD/YNXbMDk+tyuJTuzPaSgU+vecHPR9l+WDvS2Ji0+p96vqRuntn
	pYUQ+mEK3XougXmBQpOn9i0t5BmEsX6E=
X-Gm-Gg: ASbGncsP0OmsoR7CPHUb6PTW09mQuH8t5uzNbhDgHVdhQgwmcUEQS2ys1pr2SJuse1N
	s/p8uoNBH2aZYsKjICTpAAatgTDgK0oH1RbcA79R8Nou07o1VgmEWJHI+J7l9JNYc/d2JPsMvA8
	PlVuowj7xht7d83npd0VVRRUvQfb7/DJD9btxQRH+Sr9lUjxnP
X-Google-Smtp-Source: AGHT+IHaIHo8yf77s4SwnA/W0fiRpyfJ3SByK0s3btZSE+6shQcdGi8izBDi8io+In8rLEvBmz987gszKBnNZ6wXqRA=
X-Received: by 2002:a17:90b:33cc:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-311103c1461mr21116677a91.19.1748385092025; Tue, 27 May 2025
 15:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 15:31:17 -0700
X-Gm-Features: AX0GCFv1QDt7Oespq3Xznem227xpYnIHHNzakgjB7y6O13SSTVgBeESlUS3xH-4
Message-ID: <CAEf4BzY7MB9h-xAnPbheUgBhcqOMNaf1=HH=8V-HmC8k4VPgwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces support for global percpu data in libbpf by adding =
a
> new ".data..percpu" section, similar to ".data". It enables efficient
> handling of percpu global variables in bpf programs.
>
> This enhancement improves performance for workloads that benefit from
> percpu storage.
>
> Meanwhile, add bpf_map__is_internal_percpu() API to check whether the map
> is an internal map used for global percpu variables.

I'm not a big fan of this super specific API. We do have
bpf_map__is_internal() to let customer know that map is special in
some way, but I'd like to avoid making this fine distinction between
per-CPU internal map vs non-per-CPU (and then why stop there, why not
have kconfig-specific API, ksym-specific check, etc)?

All this is mostly useful just for bpftool for skeleton codegen, and
bpftool already has to know about .percpu prefix, so it doesn't need
this API to make all these decisions. Let's try to drop this
bpf_map__is_internal_percpu() API?

>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c   | 102 +++++++++++++++++++++++++++++++--------
>  tools/lib/bpf/libbpf.h   |   9 ++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 91 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e9c641a2fb203..65f0df09ac6d8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -518,6 +518,7 @@ struct bpf_struct_ops {
>  };
>
>  #define DATA_SEC ".data"
> +#define PERCPU_DATA_SEC ".data..percpu"
>  #define BSS_SEC ".bss"
>  #define RODATA_SEC ".rodata"
>  #define KCONFIG_SEC ".kconfig"
> @@ -532,6 +533,7 @@ enum libbpf_map_type {
>         LIBBPF_MAP_BSS,
>         LIBBPF_MAP_RODATA,
>         LIBBPF_MAP_KCONFIG,
> +       LIBBPF_MAP_PERCPU_DATA,
>  };
>
>  struct bpf_map_def {
> @@ -642,6 +644,7 @@ enum sec_type {
>         SEC_DATA,
>         SEC_RODATA,
>         SEC_ST_OPS,
> +       SEC_PERCPU_DATA,
>  };
>
>  struct elf_sec_desc {
> @@ -1902,7 +1905,7 @@ static bool map_is_mmapable(struct bpf_object *obj,=
 struct bpf_map *map)
>         struct btf_var_secinfo *vsi;
>         int i, n;
>
> -       if (!map->btf_value_type_id)
> +       if (!map->btf_value_type_id || map->libbpf_type =3D=3D LIBBPF_MAP=
_PERCPU_DATA)

Not sure this is correct. We should have btf_value_type_id for PERCPU
global data array, no?

>                 return false;
>
>         t =3D btf__type_by_id(obj->btf, map->btf_value_type_id);
> @@ -1926,6 +1929,7 @@ static int
>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
>                               const char *real_name, int sec_idx, void *d=
ata, size_t data_sz)
>  {
> +       bool is_percpu =3D type =3D=3D LIBBPF_MAP_PERCPU_DATA;
>         struct bpf_map_def *def;
>         struct bpf_map *map;
>         size_t mmap_sz;
> @@ -1947,9 +1951,9 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         }
>
>         def =3D &map->def;
> -       def->type =3D BPF_MAP_TYPE_ARRAY;
> +       def->type =3D is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYP=
E_ARRAY;
>         def->key_size =3D sizeof(int);
> -       def->value_size =3D data_sz;
> +       def->value_size =3D is_percpu ? roundup(data_sz, 8) : data_sz;
>         def->max_entries =3D 1;
>         def->map_flags =3D type =3D=3D LIBBPF_MAP_RODATA || type =3D=3D L=
IBBPF_MAP_KCONFIG
>                 ? BPF_F_RDONLY_PROG : 0;
> @@ -1960,10 +1964,11 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
>         if (map_is_mmapable(obj, map))
>                 def->map_flags |=3D BPF_F_MMAPABLE;
>
> -       pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flag=
s %x.\n",
> -                map->name, map->sec_idx, map->sec_offset, def->map_flags=
);
> +       pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, fl=
ags %x.\n",
> +                map->name, is_percpu ? "percpu " : "", map->sec_idx,
> +                map->sec_offset, def->map_flags);
>
> -       mmap_sz =3D bpf_map_mmap_sz(map);
> +       mmap_sz =3D is_percpu ? def->value_size : bpf_map_mmap_sz(map);
>         map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         if (map->mmaped =3D=3D MAP_FAILED) {
> @@ -1999,6 +2004,13 @@ static int bpf_object__init_global_data_maps(struc=
t bpf_object *obj)
>                         continue;
>
>                 switch (sec_desc->sec_type) {
> +               case SEC_PERCPU_DATA:
> +                       sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj=
, sec_idx));
> +                       err =3D bpf_object__init_internal_map(obj, LIBBPF=
_MAP_PERCPU_DATA,
> +                                                           sec_name, sec=
_idx,
> +                                                           sec_desc->dat=
a->d_buf,
> +                                                           sec_desc->dat=
a->d_size);
> +                       break;
>                 case SEC_DATA:
>                         sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj=
, sec_idx));
>                         err =3D bpf_object__init_internal_map(obj, LIBBPF=
_MAP_DATA,
> @@ -3363,6 +3375,10 @@ static int btf_fixup_datasec(struct bpf_object *ob=
j, struct btf *btf,
>                 fixup_offsets =3D true;
>         }
>
> +       /* .data..percpu DATASEC must have __aligned(8) size. */

please remind me why? similarly for def->value_size special casing?
What will happen if we don't explicitly roundup() on libbpf side
(kernel always does roundup(8) for ARRAY value_size anyways, which is
why I am asking)

> +       if (strcmp(sec_name, PERCPU_DATA_SEC) =3D=3D 0 || str_has_pfx(sec=
_name, PERCPU_DATA_SEC))
> +               t->size =3D roundup(t->size, 8);
> +
>         for (i =3D 0, vsi =3D btf_var_secinfos(t); i < vars; i++, vsi++) =
{
>                 const struct btf_type *t_var;
>                 struct btf_var *var;
> @@ -3923,6 +3939,11 @@ static int bpf_object__elf_collect(struct bpf_obje=
ct *obj)
>                                 err =3D bpf_object__add_programs(obj, dat=
a, name, idx);
>                                 if (err)
>                                         return err;
> +                       } else if (strcmp(name, PERCPU_DATA_SEC) =3D=3D 0=
 ||
> +                                  str_has_pfx(name, PERCPU_DATA_SEC)) {
> +                               sec_desc->sec_type =3D SEC_PERCPU_DATA;
> +                               sec_desc->shdr =3D sh;
> +                               sec_desc->data =3D data;
>                         } else if (strcmp(name, DATA_SEC) =3D=3D 0 ||
>                                    str_has_pfx(name, DATA_SEC ".")) {
>                                 sec_desc->sec_type =3D SEC_DATA;
> @@ -4452,6 +4473,7 @@ static bool bpf_object__shndx_is_data(const struct =
bpf_object *obj,
>         case SEC_BSS:
>         case SEC_DATA:
>         case SEC_RODATA:
> +       case SEC_PERCPU_DATA:
>                 return true;
>         default:
>                 return false;
> @@ -4477,6 +4499,8 @@ bpf_object__section_to_libbpf_map_type(const struct=
 bpf_object *obj, int shndx)
>                 return LIBBPF_MAP_DATA;
>         case SEC_RODATA:
>                 return LIBBPF_MAP_RODATA;
> +       case SEC_PERCPU_DATA:
> +               return LIBBPF_MAP_PERCPU_DATA;
>         default:
>                 return LIBBPF_MAP_UNSPEC;
>         }
> @@ -4794,7 +4818,7 @@ static int map_fill_btf_type_info(struct bpf_object=
 *obj, struct bpf_map *map)
>
>         /*
>          * LLVM annotates global data differently in BTF, that is,
> -        * only as '.data', '.bss' or '.rodata'.
> +        * only as '.data', '.bss', '.rodata' or '.data..percpu'.
>          */
>         if (!bpf_map__is_internal(map))
>                 return -ENOENT;
> @@ -5129,23 +5153,47 @@ static int
>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map=
 *map)
>  {
>         enum libbpf_map_type map_type =3D map->libbpf_type;
> -       int err, zero =3D 0;
> -       size_t mmap_sz;
> +       bool is_percpu =3D map_type =3D=3D LIBBPF_MAP_PERCPU_DATA;
> +       int err =3D 0, zero =3D 0, num_cpus, i;
> +       size_t data_sz, elem_sz, mmap_sz;
> +       void *data =3D NULL;
> +
> +       data_sz =3D map->def.value_size;
> +       if (is_percpu) {
> +               num_cpus =3D libbpf_num_possible_cpus();
> +               if (num_cpus < 0) {
> +                       err =3D num_cpus;
> +                       return err;

hm... why not `return num_cpus;`?

> +               }
> +
> +               data_sz =3D data_sz * num_cpus;
> +               data =3D malloc(data_sz);
> +               if (!data) {
> +                       err =3D -ENOMEM;
> +                       return err;
> +               }

[...]

>  /**
>   * @brief **bpf_map__set_pin_path()** sets the path attribute that tells=
 where the
>   * BPF map should be pinned. This does not actually create the 'pin'.
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1205f9a4fe048..1c239ac88c699 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -443,4 +443,5 @@ LIBBPF_1.6.0 {
>                 bpf_program__line_info_cnt;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
> +               bpf_map__is_internal_percpu;

alphabetically sorted

>  } LIBBPF_1.5.0;




> --
> 2.49.0
>

