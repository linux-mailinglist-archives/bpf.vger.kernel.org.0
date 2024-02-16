Return-Path: <bpf+bounces-22163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27C8582FF
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21C61C222F7
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B474130AF7;
	Fri, 16 Feb 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elPjAq2t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CE130ADF
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102348; cv=none; b=X++ij8QIPnfbJWe1LoDHuGW6bwBHxmFG0cHdqEmESUl+nCy9sTmqT4GgYuaqMjr4Vpe3MpHlENbd0YwgQyjNXOW/0RNFTYm//edg5vDUk0xEDzhQFX3IxTHK8Ts45JXZg/lKLdDCm2pO0P9LGnBT7VrUTsORjU7kQBxRTGd8/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102348; c=relaxed/simple;
	bh=am+D2k7Ws2osCaTouXNImYlzVEJiyvlvyZxDSU2D47s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti+CEZABewJ0bbMftrNjDoR6kedJ7TXLklfcJiO71K5E80bVDG66FsGOfE/PpzPisyfrBVW747nGaMVktMWtpMmHa2Lai0F8y59pRxRFyDq3oq87AcKuSuHK3quyyFdlGtA1eDk48sJ/5epF+OJ05TYigqUeh4IcB2DEVkVnJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elPjAq2t; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d932f6ccfaso20011165ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102346; x=1708707146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aakg8L9cZHexyzubUblti1O4WMqCKI56gCg8pb46W40=;
        b=elPjAq2t31hTu6pcM03DxJnpeDPXGuOe63VGbVOwEECMrbF9hFDTy1BOEaKH18R813
         cpVVXhxZ6HZ7NouHonpYZBoN0d+swzBwXoHKZeHE0OP1uhz8UPcsbGMQ/HLONlp5NNBK
         Ayy4swnFbMIa+tPlSkvKTwT20WUNiH1kSdQkAr9zRwsM2PKAUBIl4a7ewt1CzQlBJ0Lk
         /lDlyoXGVDqvbCn63pcBwwCxan+Fn35fZ3VqUbtwM6lZ21PIdd89M+0eDjoiZyC4Nsix
         rIAxI2oSQKKzGRen4MWYVmRRT9INYMhLrr03RkDPQcUu8kq7iZRFLETyHouRNmQQNhaS
         clDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102346; x=1708707146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aakg8L9cZHexyzubUblti1O4WMqCKI56gCg8pb46W40=;
        b=S0RSUEF6JWsURtwWz86aexxz1BJjm8E1Qvor6xF/Mjk8+gWDF5ZlG/F6uHUVvCEdJy
         w403D1UQGT5LV17tR4rQcUnvqZrstn1SXyZcn5CoNWHALUQzIDqBqePFkgMHUbQrALfw
         KcX2oLiqh06suCOSv23aU0Na21dKxycqCIk7wISeeaswacU8VZf+TJY6eWBS/S4Wg1fz
         buxQHPcuVwu4KIKZ+VZS9PSH4gQxQyEzRiT9IK090QAcfuzabX0gk7yDaqT91EOzHVwz
         SGI7id0ZZufdOE7uIJApgNi6gQRU3CHE5SmQD8TZCFgRygPFst1kW1BagCR2j2axf1Ll
         iDRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4p7jL0KxaE0V1LWmoWdhGmUMeL0vXb+6tf+Q5iJWdlxqxBZl6ACSmbVerZ/wfKAFz1Hs/9LcUzcSE/+Ckv0mLrQf7
X-Gm-Message-State: AOJu0YyGePBgGfQW08FonNrwbTlABenGmo/rjRTDu1dacyBQ5VCg07G9
	a0mw12PGeLe6Bw/MkHCwbxoD3avufS0zNKF+iNNOl7gx696iR2vTyxURXD3dcuB/C3vTJjFKKhc
	6ppAv8zy2ZbsUkct7hqFfaVXfLGw=
X-Google-Smtp-Source: AGHT+IFX2/LNxMUW+EuWEW4/Ppb1lEwJF1J/DrBQNZLZOBScr9wJwXJfBIHMbSlZ/oyUVPzcMB0NBwILzGbYyQCrE5M=
X-Received: by 2002:a17:902:9304:b0:1db:3618:fed5 with SMTP id
 bc4-20020a170902930400b001db3618fed5mr4755080plb.53.1708102346092; Fri, 16
 Feb 2024 08:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214020836.1845354-1-thinker.li@gmail.com>
 <20240214020836.1845354-2-thinker.li@gmail.com> <CAEf4BzZBP=aV4j38+hqVgXoKa+DAZu5F-yeDVge+sLi5OBuRGw@mail.gmail.com>
 <da6aeb49-3d01-4729-8f01-8770ba69019f@gmail.com>
In-Reply-To: <da6aeb49-3d01-4729-8f01-8770ba69019f@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Feb 2024 08:52:14 -0800
Message-ID: <CAEf4BzYbyEPFOM3XXA31U3KVJpGmtEFoNOLNR4dV=n7nyb7Kgg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/3] libbpf: Create a shadow copy for each
 struct_ops map if necessary.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 2/15/24 15:55, Andrii Nakryiko wrote:
> > On Tue, Feb 13, 2024 at 6:08=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >>
> >> From: Kui-Feng Lee <thinker.li@gmail.com>
> >>
> >> If the user has passed a shadow info for a struct_ops map along with s=
truct
> >> bpf_object_open_opts, a shadow copy will be created for the map and
> >> returned from bpf_map__initial_value().
> >>
> >> The user can read and write shadow variables through the shadow copy, =
which
> >> is placed in the struct pointed by skel->struct_ops.FOO, where FOO is =
the
> >> map name.
> >>
> >> The value of a shadow variable will be used to update the value of the=
 map
> >> when loading the map to the kernel.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c          | 195 ++++++++++++++++++++++++++++++=
--
> >>   tools/lib/bpf/libbpf.h          |  34 +++++-
> >>   tools/lib/bpf/libbpf.map        |   1 +
> >>   tools/lib/bpf/libbpf_internal.h |   1 +
> >>   4 files changed, 220 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 01f407591a92..ce9c4cdb2dc5 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -487,6 +487,14 @@ struct bpf_struct_ops {
> >>           * from "data".
> >>           */
> >>          void *kern_vdata;
> >> +       /* Description of the layout that a shadow copy should look li=
ke.
> >> +        */
> >> +       const struct bpf_struct_ops_map_info *shadow_info;
> >> +       /* A shadow copy of the struct_ops data created according to t=
he
> >> +        * layout described by shadow_info.
> >> +        */
> >> +       void *shadow_data;
> >> +       __u32 shadow_data_size;
> >
> > what I mentioned on cover letter, just a few lines above, before
> > kern_vdata we have just `void *data` which initially contains whatever
> > was set in ELF. Just expose that through bpf_map__initial_value() and
> > teach bpftool to generate section with variables for that memory and
> > that should be all we need, no?
>
> I am not sure if read your question correctly.
> Padding & alignments can vary in different platforms. BPF and
> user space programs are supposed to be in different platforms.
> So, I can not expect that the same struct has the same layout in
> BPF/x86/and ARM, right?

We can constraint this functionality to 64-bit host architectures, and
then all these concerns will go away. It should be possible to make
all this work even if the host architecture is 64-bit, but I'm not
sure it's worth doing.

Either way, we need to keep this simple and minimal, no extra
descriptors and stuff like that.

>
> >
> >>          __u32 type_id;
> >>   };
> >>
> >> @@ -1027,7 +1035,7 @@ static int bpf_map__init_kern_struct_ops(struct =
bpf_map *map)
> >>          struct module_btf *mod_btf;
> >>          void *data, *kern_data;
> >>          const char *tname;
> >> -       int err;
> >> +       int err, j;
> >>
> >>          st_ops =3D map->st_ops;
> >>          type =3D st_ops->type;
> >
> > [...]
> >
> >>   void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
> >>   {
> >> +       if (bpf_map__is_struct_ops(map)) {
> >> +               if (psize)
> >> +                       *psize =3D map->st_ops->shadow_data_size;
> >> +               return map->st_ops->shadow_data;
> >> +       }
> >> +
> >>          if (!map->mmaped)
> >>                  return NULL;
> >>          *psize =3D map->def.value_size;
> >> @@ -13462,3 +13632,8 @@ void bpf_object__destroy_skeleton(struct bpf_o=
bject_skeleton *s)
> >>          free(s->progs);
> >>          free(s);
> >>   }
> >> +
> >> +__u32 bpf_map__struct_ops_type(const struct bpf_map *map)
> >> +{
> >> +       return map->st_ops->type_id;
> >> +}
> >
> > we can expose this st_ops->type_id as map->def.value_type_id so that
> > existing bpf_map__btf_value_type_id() API can be used, no need to add
> > more struct_ops-specific APIs
>
> OK!
>
> >
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index 5723cbbfcc41..b435cafefe7a 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -109,6 +109,27 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(lib=
bpf_print_fn_t fn);
> >>   /* Hide internal to user */
> >>   struct bpf_object;
> >>
> >> +/* Description of a member in the struct_ops type for a map. */
> >> +struct bpf_struct_ops_member_info {
> >> +       const char *name;
> >> +       __u32 offset;
> >> +       __u32 size;
> >> +};
> >> +
> >> +/* Description of the layout of a shadow copy for a struct_ops map. *=
/
> >> +struct bpf_struct_ops_map_info {
> >> +       /* The name of the struct_ops map */
> >> +       const char *name;
> >> +       const struct bpf_struct_ops_member_info *members;
> >> +       __u32 cnt;
> >> +       __u32 data_size;
> >> +};
> >> +
> >> +struct bpf_struct_ops_shadow_info {
> >> +       const struct bpf_struct_ops_map_info *maps;
> >> +       __u32 cnt;
> >> +};
> >> +
> >>   struct bpf_object_open_opts {
> >>          /* size of this struct, for forward/backward compatibility */
> >>          size_t sz;
> >> @@ -197,9 +218,18 @@ struct bpf_object_open_opts {
> >>           */
> >>          const char *bpf_token_path;
> >>
> >> +       /* A list of shadow info for every struct_ops map.  A shadow i=
nfo
> >> +        * provides the information used by libbpf to map the offsets =
of
> >> +        * struct members of a struct_ops type from BTF to the offsets=
 of
> >> +        * the corresponding members in the shadow copy in the user
> >> +        * space. It ensures that the shadow copy provided by the libb=
pf
> >> +        * can be accessed by the user space program correctly.
> >> +        */
> >> +       const struct bpf_struct_ops_shadow_info *struct_ops_shadow;
> >> +
> >
> > I still don't follow. bpftool will generate memory-layout compatible
> > structure for user-space, they can just work directly with that
> > memory. We shouldn't need all this extra info structs.
> >
> > Libbpf can just check that fields that are supposed to be BPF prog
> > references are correct `struct bpf_program *` pointers.
>
> Check the explanation above.
>
> >
> >>          size_t :0;
> >>   };
> >> -#define bpf_object_open_opts__last_field bpf_token_path
> >> +#define bpf_object_open_opts__last_field struct_ops_shadow
> >>
> >>   /**
> >>    * @brief **bpf_object__open()** creates a bpf_object by opening
> >> @@ -839,6 +869,8 @@ struct bpf_map;
> >>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct =
bpf_map *map);
> >>   LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const str=
uct bpf_map *map);
> >>
> >> +LIBBPF_API __u32 bpf_map__struct_ops_type(const struct bpf_map *map);
> >> +
> >>   struct bpf_iter_attach_opts {
> >>          size_t sz; /* size of this struct for forward/backward compat=
ibility */
> >>          union bpf_iter_link_info *link_info;
> >> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> >> index 86804fd90dd1..e0efc85114df 100644
> >> --- a/tools/lib/bpf/libbpf.map
> >> +++ b/tools/lib/bpf/libbpf.map
> >> @@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
> >>                  bpf_token_create;
> >>                  btf__new_split;
> >>                  btf_ext__raw_data;
> >> +               bpf_map__struct_ops_type;
> >>   } LIBBPF_1.3.0;
> >> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_in=
ternal.h
> >> index ad936ac5e639..aec6d57fe5d1 100644
> >> --- a/tools/lib/bpf/libbpf_internal.h
> >> +++ b/tools/lib/bpf/libbpf_internal.h
> >> @@ -234,6 +234,7 @@ struct btf_type;
> >>   struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id=
);
> >>   const char *btf_kind_str(const struct btf_type *t);
> >>   const struct btf_type *skip_mods_and_typedefs(const struct btf *btf,=
 __u32 id, __u32 *res_id);
> >> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 =
id, __u32 *res_id);
> >>
> >>   static inline enum btf_func_linkage btf_func_linkage(const struct bt=
f_type *t)
> >>   {
> >> --
> >> 2.34.1
> >>

