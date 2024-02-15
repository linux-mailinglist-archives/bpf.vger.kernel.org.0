Return-Path: <bpf+bounces-22115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABF85721D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444211C227B6
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57AF145B2F;
	Thu, 15 Feb 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehTtfh1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC977AE5E
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041334; cv=none; b=OqpcSSv30nucBOTDe7iQswTTxDUwvBGFUqSSJFaKIdIl7gASii/wZ58pCnULkK5fEYhDXWkoAm+6frX4yQDR01HLkKW5I8Uh6cKtEZthGZYhRLuI05iTMb1jFT/HXkU4SYKFb+HUv+ST4TVeRok4MJ6NfZyztRs3k3YJ0di3u54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041334; c=relaxed/simple;
	bh=vSiG4bpdAaj/RXVgW3AEjueripR0iK5NCM60MisFsWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrzkUzUXxPTTVmbknaNzGTgeQ48P+5tDiHjXqIJLFbooCO1GQJtXsKfA6fNMMbiXaujwoRfGouwGyXdz1twqedWiUHQ4SUyS/yWEKQoRIzrMq0HqM3XJPz2AfCs+IGxx1vXynAaGMTAULLbJW6qP5aB9voNw2bbm6gJQDK6CTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehTtfh1F; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1229203a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708041331; x=1708646131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueX8X/FnbUqeEy3b3xKbbbAZEWT+2+nuTqHCypvdFX8=;
        b=ehTtfh1Ff+DCsCOSMhy67LDXX0Y4/txiNQqVd7V1s1DWIw4qjNBJBctCL52aVrQLmd
         0yl4KqUsRxR3cmp269o+O+7K6rkYrdlJ5vSUlypZ6P72w38HBWnV+sUqIzBfJfrtFBVc
         2Vdrh/GijpO6NCqGrFJsrKcLs2ak7zq4w29fyfChjKvAFAxSix38D64NaUqhStJBtqSp
         905dpHRTsVUMirD9CEAwBVg+7tX1LJa1B1Rp01PF1EE4puPTHpUZi64QTiig/KZ4prjG
         brZRF35QrZKY6oT2tN/9DTmmoxM4WMUUKMdzCT0lTsic7Qk/IXap2oti4NS5pCKICTeG
         j17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041331; x=1708646131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueX8X/FnbUqeEy3b3xKbbbAZEWT+2+nuTqHCypvdFX8=;
        b=bVvoFpw6cMZp+7a9xVJz5/8tzw+fr8+YdvwUvqZvfMtlw6tbBzEmiH9wa21+DPAGjx
         GmpzJXfEUULQ/1iO1ESqcKFFo0BwFUYZOeey4xO0QU6xuYRehC4uH+v8dr7cv+2Pt3TD
         qs3EB1J7mc0oL1TG2jadYeeNAc8j/yDWSHqn3QwthW9z7JPKtUtkVdXMOEzdFmpqc7DF
         ZnrHB4tPDejWziruXRwzQHsIBwBLt2kE5EduRvJlVxXoMIViIbeCP0IV6GXMlIfjJbDp
         GDBYnbT7CQDc8yItCSLcHVlbHYjoppLbqQoSqk4KeoYh6lD7fhfngohzPVqljha3Ye1f
         snfA==
X-Gm-Message-State: AOJu0YxRZa/Q6utkfn5+rGXRlePnexPW/YPZPCjI2lZ4Tvch+qFzUZaN
	TzPCvePBHSay/SiWMghgJ0Zf2oPtSsDXeW8kDNqyE0rsbvV8hW1ie/1l19naSsGA4nxMD3wQCi7
	5F6if7gPPCtjCCFjcBE8ihpZMy2s=
X-Google-Smtp-Source: AGHT+IHweD3cAjhh7qadqfI022vtxVyV34IY5G56hJ63dLQjeytTBW6/ZECvCAxHJm4eJfL91ySXDHZXRaZAtwIxQFk=
X-Received: by 2002:a17:90b:fca:b0:299:3007:ad13 with SMTP id
 gd10-20020a17090b0fca00b002993007ad13mr832308pjb.32.1708041331003; Thu, 15
 Feb 2024 15:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214020836.1845354-1-thinker.li@gmail.com> <20240214020836.1845354-2-thinker.li@gmail.com>
In-Reply-To: <20240214020836.1845354-2-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 15:55:19 -0800
Message-ID: <CAEf4BzZBP=aV4j38+hqVgXoKa+DAZu5F-yeDVge+sLi5OBuRGw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/3] libbpf: Create a shadow copy for each
 struct_ops map if necessary.
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:08=E2=80=AFPM <thinker.li@gmail.com> wrote:
>
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> If the user has passed a shadow info for a struct_ops map along with stru=
ct
> bpf_object_open_opts, a shadow copy will be created for the map and
> returned from bpf_map__initial_value().
>
> The user can read and write shadow variables through the shadow copy, whi=
ch
> is placed in the struct pointed by skel->struct_ops.FOO, where FOO is the
> map name.
>
> The value of a shadow variable will be used to update the value of the ma=
p
> when loading the map to the kernel.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 195 ++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h          |  34 +++++-
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   1 +
>  4 files changed, 220 insertions(+), 11 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 01f407591a92..ce9c4cdb2dc5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -487,6 +487,14 @@ struct bpf_struct_ops {
>          * from "data".
>          */
>         void *kern_vdata;
> +       /* Description of the layout that a shadow copy should look like.
> +        */
> +       const struct bpf_struct_ops_map_info *shadow_info;
> +       /* A shadow copy of the struct_ops data created according to the
> +        * layout described by shadow_info.
> +        */
> +       void *shadow_data;
> +       __u32 shadow_data_size;

what I mentioned on cover letter, just a few lines above, before
kern_vdata we have just `void *data` which initially contains whatever
was set in ELF. Just expose that through bpf_map__initial_value() and
teach bpftool to generate section with variables for that memory and
that should be all we need, no?

>         __u32 type_id;
>  };
>
> @@ -1027,7 +1035,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>         struct module_btf *mod_btf;
>         void *data, *kern_data;
>         const char *tname;
> -       int err;
> +       int err, j;
>
>         st_ops =3D map->st_ops;
>         type =3D st_ops->type;

[...]

>  void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
>  {
> +       if (bpf_map__is_struct_ops(map)) {
> +               if (psize)
> +                       *psize =3D map->st_ops->shadow_data_size;
> +               return map->st_ops->shadow_data;
> +       }
> +
>         if (!map->mmaped)
>                 return NULL;
>         *psize =3D map->def.value_size;
> @@ -13462,3 +13632,8 @@ void bpf_object__destroy_skeleton(struct bpf_obje=
ct_skeleton *s)
>         free(s->progs);
>         free(s);
>  }
> +
> +__u32 bpf_map__struct_ops_type(const struct bpf_map *map)
> +{
> +       return map->st_ops->type_id;
> +}

we can expose this st_ops->type_id as map->def.value_type_id so that
existing bpf_map__btf_value_type_id() API can be used, no need to add
more struct_ops-specific APIs

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5723cbbfcc41..b435cafefe7a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -109,6 +109,27 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf=
_print_fn_t fn);
>  /* Hide internal to user */
>  struct bpf_object;
>
> +/* Description of a member in the struct_ops type for a map. */
> +struct bpf_struct_ops_member_info {
> +       const char *name;
> +       __u32 offset;
> +       __u32 size;
> +};
> +
> +/* Description of the layout of a shadow copy for a struct_ops map. */
> +struct bpf_struct_ops_map_info {
> +       /* The name of the struct_ops map */
> +       const char *name;
> +       const struct bpf_struct_ops_member_info *members;
> +       __u32 cnt;
> +       __u32 data_size;
> +};
> +
> +struct bpf_struct_ops_shadow_info {
> +       const struct bpf_struct_ops_map_info *maps;
> +       __u32 cnt;
> +};
> +
>  struct bpf_object_open_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> @@ -197,9 +218,18 @@ struct bpf_object_open_opts {
>          */
>         const char *bpf_token_path;
>
> +       /* A list of shadow info for every struct_ops map.  A shadow info
> +        * provides the information used by libbpf to map the offsets of
> +        * struct members of a struct_ops type from BTF to the offsets of
> +        * the corresponding members in the shadow copy in the user
> +        * space. It ensures that the shadow copy provided by the libbpf
> +        * can be accessed by the user space program correctly.
> +        */
> +       const struct bpf_struct_ops_shadow_info *struct_ops_shadow;
> +

I still don't follow. bpftool will generate memory-layout compatible
structure for user-space, they can just work directly with that
memory. We shouldn't need all this extra info structs.

Libbpf can just check that fields that are supposed to be BPF prog
references are correct `struct bpf_program *` pointers.

>         size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field struct_ops_shadow
>
>  /**
>   * @brief **bpf_object__open()** creates a bpf_object by opening
> @@ -839,6 +869,8 @@ struct bpf_map;
>  LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
>  LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
>
> +LIBBPF_API __u32 bpf_map__struct_ops_type(const struct bpf_map *map);
> +
>  struct bpf_iter_attach_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>         union bpf_iter_link_info *link_info;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 86804fd90dd1..e0efc85114df 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
>                 bpf_token_create;
>                 btf__new_split;
>                 btf_ext__raw_data;
> +               bpf_map__struct_ops_type;
>  } LIBBPF_1.3.0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index ad936ac5e639..aec6d57fe5d1 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -234,6 +234,7 @@ struct btf_type;
>  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
>  const char *btf_kind_str(const struct btf_type *t);
>  const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u=
32 id, __u32 *res_id);
> +const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id,=
 __u32 *res_id);
>
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_ty=
pe *t)
>  {
> --
> 2.34.1
>

