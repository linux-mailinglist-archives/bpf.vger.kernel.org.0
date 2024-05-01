Return-Path: <bpf+bounces-28379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721088B8EB6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A551C20F37
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC017995;
	Wed,  1 May 2024 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asg8Orqf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6F168DA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582923; cv=none; b=gv6GWjyZtkd3EurLfamlxu+eT7LhVqATXzAB4mlHW+Pxim8DL83m81x5YXaOBDN+75XZz2+oTHtoXjpMTgA8IUJ89Fbw8Gy+dQ8H+WBsy3j3fYzfLU0LOSxJidE309HlTkEq16UKWi0mE5RoytGTk/vBUj4Tm7A/ytdVesebANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582923; c=relaxed/simple;
	bh=ZHekrx2QwEFf6ogUsuXo3bxqXQlNNFym7iExYPPK1XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTeFCZsBxsF6JbQJT0Nu62VE7xMTr+kBvuF723fVM/qZMEL/kRRY82od/2Pdm9nU7I7WS9umN0AXqHCaTYsfu7BbvGNRnPtm4aYjQcNKIfv2XhKhzGH+0n9qZDHuCo8LZFh+8ZhCP/zrYIqqjnZUsLScQmvntwDXWzZl3tCd4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asg8Orqf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso6467222b3a.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582921; x=1715187721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QBv/9c7DbY7XZaKIZkCnZKCSMYS95huZARpXxrCu4M=;
        b=asg8Orqflf1YV4hRTl5NSyVah6NN4ksQejm6rtGovhgAeBEXi0ASVGQyuSNGldzWuZ
         8uLVUTGgGMfVrxl9p4tz46h/4MW0mrhy5XMnRKQshkOUschiprTswIojAbQ63fYWEMB7
         8z5xnL5H2dELQrdt1kwM3wSr0dmYbhGHN2mpj4lYMHK1UTdEpU4o515l8ujIDSCm4bfM
         g1U4Vs3VbJt/h01hSEA6AieVU7dGjwsN69511MO9DjBElsMDpBcazz7+iydhlu4yZ7Jo
         SNCbABWWMHK4ccWNO8Z5yEsvcb1sCgzF3O3ViwNTmisXzis7e/D4qFeDZOHSM3MsLF0T
         ZxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582921; x=1715187721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QBv/9c7DbY7XZaKIZkCnZKCSMYS95huZARpXxrCu4M=;
        b=WFCvb79qeCehetBBIpsQFfFPZgBHbhSQFYh9z28P5pJYPrylGggx1uw8oUkZWtvDeq
         AKmtuVy+1H0I+6DREmXY0RwWVFCq5ImAi+n60qpl3NycqVgczZPAT7tVOudPmrXzs/Ko
         RRS+QKshvadn8UX5YuG6ouuzupbfUhvd4ZLO+Rqq7xnId4bNUZwache0w/lONUVDNgc0
         0AbUxVfgjfTYHDMjlpAj48u0woiN4vz3fiY4948aSP0A39XfzUJa7akH44Gubc+Hf5g7
         Cn2/t5mbRYqtHGdPyfRCnWFgSJx9zKKzEFiBVz3w9fdtILHx+iZRcUnEm21tQjVwWYQq
         TJRw==
X-Gm-Message-State: AOJu0YzZhkLpcTCkjmUpNJXMzi0BooFU1xh3SsH6Pa48Ud/X/mhFoRGW
	H3+R5TUdlwqe9k0gS+/MnDLs8OKKVjSdQJYbMeD7xY3lzYFXNqbhVZDTDZm2f6Ch7S7ghEnSDR1
	+LpL4TornLu4N1gKY689wess7E+0=
X-Google-Smtp-Source: AGHT+IEN+7V+3OD2WawgQEz0xYML/gN5Z5twK0vBPgCPEPoBBL77N+0Go/ai8iyy1nwZUKj5yC549Rj4xOs3laFTKc4=
X-Received: by 2002:a17:90b:3c41:b0:2b2:b98f:6bea with SMTP id
 pm1-20020a17090b3c4100b002b2b98f6beamr3020193pjb.25.1714582920651; Wed, 01
 May 2024 10:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429213609.487820-1-thinker.li@gmail.com> <20240429213609.487820-2-thinker.li@gmail.com>
In-Reply-To: <20240429213609.487820-2-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 10:01:48 -0700
Message-ID: <CAEf4Bza3YmsxD7yrK2+TJx=EWyobmgps5ySLmzU7QVQHhUigpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: add a pointer of the attached link to bpf_struct_ops_map.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:36=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> To facilitate the upcoming unregistring struct_ops objects from the syste=
ms
> consuming objects, a pointer of the attached link is added to allow for
> accessing the attached link of a bpf_struct_ops_map directly from the map
> itself.
>
> Previously, a st_map could be attached to multiple links. This patch now
> enforces only one link attached at most.

I'd like to avoid this restriction, in principle. We don't enforce
that BPF program should be attached through a single BPF link, so I
don't think we should allow that for maps. Worst case you can keep a
list of attached links.

>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  kernel/bpf/bpf_struct_ops.c | 47 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 86c7884abaf8..072e3416c987 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -20,6 +20,8 @@ struct bpf_struct_ops_value {
>
>  #define MAX_TRAMP_IMAGE_PAGES 8
>
> +struct bpf_struct_ops_link;
> +
>  struct bpf_struct_ops_map {
>         struct bpf_map map;
>         struct rcu_head rcu;
> @@ -39,6 +41,8 @@ struct bpf_struct_ops_map {
>         void *image_pages[MAX_TRAMP_IMAGE_PAGES];
>         /* The owner moduler's btf. */
>         struct btf *btf;
> +       /* The link is attached by this map. */
> +       struct bpf_struct_ops_link __rcu *attached;
>         /* uvalue->data stores the kernel struct
>          * (e.g. tcp_congestion_ops) that is more useful
>          * to userspace than the kvalue.  For example,
> @@ -1048,6 +1052,22 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf=
_map *map)
>                 smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF=
_STRUCT_OPS_STATE_READY;
>  }
>
> +/* Set the attached link of a map.
> + *
> + * Return the current value of the st_map->attached.
> + */
> +static inline struct bpf_struct_ops_link *map_attached(struct bpf_struct=
_ops_map *st_map,
> +                                                      struct bpf_struct_=
ops_link *st_link)
> +{
> +       return unrcu_pointer(cmpxchg(&st_map->attached, NULL, st_link));
> +}
> +
> +/* Reset the attached link of a map */
> +static inline void map_attached_null(struct bpf_struct_ops_map *st_map)
> +{
> +       rcu_assign_pointer(st_map->attached, NULL);
> +}
> +
>  static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>  {
>         struct bpf_struct_ops_link *st_link;
> @@ -1061,6 +1081,7 @@ static void bpf_struct_ops_map_link_dealloc(struct =
bpf_link *link)
>                  * bpf_struct_ops_link_create() fails to register.
>                  */
>                 st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
> +               map_attached_null(st_map);
>                 bpf_map_put(&st_map->map);
>         }
>         kfree(st_link);
> @@ -1125,9 +1146,21 @@ static int bpf_struct_ops_map_link_update(struct b=
pf_link *link, struct bpf_map
>                 goto err_out;
>         }
>
> +       if (likely(st_map !=3D old_st_map) && map_attached(st_map, st_lin=
k)) {
> +               /* The map is already in use */
> +               err =3D -EBUSY;
> +               goto err_out;
> +       }
> +
>         err =3D st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, =
old_st_map->kvalue.data);
> -       if (err)
> +       if (err) {
> +               if (st_map !=3D old_st_map)
> +                       map_attached_null(st_map);
>                 goto err_out;
> +       }
> +
> +       if (likely(st_map !=3D old_st_map))
> +               map_attached_null(old_st_map);
>
>         bpf_map_inc(new_map);
>         rcu_assign_pointer(st_link->map, new_map);
> @@ -1172,20 +1205,28 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>         }
>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL);
>
> +       if (map_attached(st_map, link)) {
> +               err =3D -EBUSY;
> +               goto err_out;
> +       }
> +
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> -               goto err_out;
> +               goto err_out_attached;
>
>         err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
>         if (err) {
>                 bpf_link_cleanup(&link_primer);
> +               /* The link has been free by bpf_link_cleanup() */
>                 link =3D NULL;
> -               goto err_out;
> +               goto err_out_attached;
>         }
>         RCU_INIT_POINTER(link->map, map);
>
>         return bpf_link_settle(&link_primer);
>
> +err_out_attached:
> +       map_attached_null(st_map);
>  err_out:
>         bpf_map_put(map);
>         kfree(link);
> --
> 2.34.1
>

