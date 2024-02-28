Return-Path: <bpf+bounces-22901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95486B693
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2904528A671
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601BD4085A;
	Wed, 28 Feb 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhxpwVqr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A540848
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143105; cv=none; b=Gxy1mObCzEHs+7t667/W1/3ktdvSwe9Zz6ZmCaDrI8YI9t0I7KeHOZWRKdcT8fDESrYOFzL3xrJOSaDjenAHZ86vpRUPajpQMT+slz2S1/WOiN4UcHDcy3qkmsXZSiiFdDrHXgy8Wks5lUA1lAmaHSnWsToE5ng6Vkre651tY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143105; c=relaxed/simple;
	bh=6mpFQ3cS56ziSG/cS1ekSKVFVBsjuOxAmY5Yl3Slc8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoX1b17oVjX4/MsZYy/Gs4gaQroWZFExOH1eqUjgJTZ5bGp3rSuhB6rvDvLoSt1Crvjca8lJWj4LxtFsJ7IY9hWquGFchrhOa8zG41ezpfm7Q7Z9PVpqEHoI6xEOjlQFLHZpk4dY2ztWsywxPYs4tqeDrjsC7DgtbC/k6hKS3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhxpwVqr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d95d67ff45so521145ad.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143104; x=1709747904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42C7pAM2di1iWvD7Se8gdZqkF642gHr0FtNcB0iYM/0=;
        b=fhxpwVqr+ObpbptxgLNokiBa4+ymYIyj9AiTDoX+AJPiIabvDsY/O9YwyuaSwP6OY3
         muO3AsIzl/kv20nO0F6zK/+6K3B3l/SD6z12b7OWtGeR7ruLX898CFlsC96IjNAYHzN3
         xaQBkpjDHyZb9mIpF1k8IAj+9Md85nhhs7mvXBc6Aut+W3xNUwhZfUK1/fhQzVWfZfug
         dHs97imsLnzQyJ62Cj7WoiZaireEZp91JXS4b2L7pxivZGKl6t0cO1h+H8vcwpRWabqG
         uW0M9wyIWeOtUfdyUSTyUEEXGyfH4KCzGtUVGN6aeJ7/D2cYGxYSIjw8+BrvWLrnEcK0
         p3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143104; x=1709747904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42C7pAM2di1iWvD7Se8gdZqkF642gHr0FtNcB0iYM/0=;
        b=p9/nKo6JC0qgXw9ioLtjhzKCwtgeWDJ7OXFkFejkQi4nEUp57xXppOF+UBtRZ1O1sp
         LRnpawcIVIZqSr+roA6TB0kWeHU1BomTUYhZ57zHd+X7JnxUmEZNLhAbvs+sI6FamgxM
         jegFBhj4EYeB0zPusSumD2HHzwPhxUifgy4fnSB37NJxs+a/7D9p/iX8W6RmB0+dWIDp
         Fdi1wljXjyNX5xvykiimovp5EPUWZy+2bvZ6aGirAtSXYb/xNn+ELxeqHyrmINODMwkQ
         1SbcXquVkjmKM6KVRR1ADGXRpacGgt/2+Ov7kub3zLqibSqvYoqm4gjlJ80FPR8DztJs
         337A==
X-Gm-Message-State: AOJu0YxOe65aiZItQzFQq11gP5cotPO3QHOWORqlE0IjHMfBTIkH6LPX
	BwTvhvye0sE6cAAtwYeV7+bJk72LtqAhbpiFVIphQQaBdToOdbHBiWW23EIiZFNgU/4bgmrbJ+Q
	LyfHPrWMaADAvly9xJsFOYMibhM5OwS9v
X-Google-Smtp-Source: AGHT+IEgQmCDvGHArG+/6Ce+2JNXwvH52S1pz26nce2joy9uOV5dgLHcIxynyiMYphlvQ8S86qaHbWFp+0bIAFRi4nQ=
X-Received: by 2002:a17:903:2309:b0:1dc:42da:bad with SMTP id
 d9-20020a170903230900b001dc42da0badmr183416plh.62.1709143103791; Wed, 28 Feb
 2024 09:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-4-thinker.li@gmail.com>
In-Reply-To: <20240227010432.714127-4-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 09:58:11 -0800
Message-ID: <CAEf4BzZbE=2Kvrx_XK60jhtFfJuFsu18=pcZFry8UuF-s_Lg_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/6] libbpf: Convert st_ops->data to shadow type.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> Convert st_ops->data to the shadow type of the struct_ops map. The shadow
> type of a struct_ops type is a variant of the original struct type
> providing a way to access/change the values in the maps of the struct_ops
> type.
>
> bpf_map__initial_value() will return st_ops->data for struct_ops types. T=
he
> skeleton is going to use it as the pointer to the shadow type of the
> original struct type.
>
> One of the main differences between the original struct type and the shad=
ow
> type is that all function pointers of the shadow type are converted to
> pointers of struct bpf_program. Users can replace these bpf_program
> pointers with other BPF programs. The st_ops->progs[] will be updated
> before updating the value of a map to reflect the changes made by users.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 465b50235a01..2d22344fb127 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1102,6 +1102,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf=
_map *map)
>                 if (btf_is_ptr(mtype)) {
>                         struct bpf_program *prog;
>
> +                       /* Update the value from the shadow type */
> +                       st_ops->progs[i] =3D *(struct bpf_program **)mdat=
a;
> +

it's unsettling to just cast a pointer like this without any
validation. It's too easy for users to set either some garbage there
or struct bpf_program * pointer from some other skeleton.

Luckily, validation is pretty simple, we can just iterate over all
bpf_object's programs and check if any of them matches the value of
the mdata pointer. If not, error out with meaningful error.

Also, even if the bpf_program pointer is correct, it could be a
program of the wrong type, so I think we should add a bit more
validation here, given these pointers are set by users directly after
bpf_object is opened.

>                         prog =3D st_ops->progs[i];
>                         if (!prog)
>                                 continue;
> @@ -9308,7 +9311,9 @@ static struct bpf_map *find_struct_ops_map_by_offse=
t(struct bpf_object *obj,
>         return NULL;
>  }
>
> -/* Collect the reloc from ELF and populate the st_ops->progs[] */
> +/* Collect the reloc from ELF, populate the st_ops->progs[], and update
> + * st_ops->data for shadow type.
> + */
>  static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
>                                             Elf64_Shdr *shdr, Elf_Data *d=
ata)
>  {
> @@ -9422,6 +9427,14 @@ static int bpf_object__collect_st_ops_relos(struct=
 bpf_object *obj,
>                 }
>
>                 st_ops->progs[member_idx] =3D prog;
> +
> +               /* st_ops->data will be expose to users, being returned b=
y

typo: exposed

> +                * bpf_map__initial_value() as a pointer to the shadow
> +                * type. All function pointers in the original struct typ=
e
> +                * should be converted to a pointer to struct bpf_program
> +                * in the shadow type.
> +                */
> +               *((struct bpf_program **)(st_ops->data + moff)) =3D prog;
>         }
>
>         return 0;
> @@ -9880,6 +9893,12 @@ int bpf_map__set_initial_value(struct bpf_map *map=
,
>
>  void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
>  {
> +       if (bpf_map__is_struct_ops(map)) {
> +               if (psize)
> +                       *psize =3D map->def.value_size;
> +               return map->st_ops->data;
> +       }
> +
>         if (!map->mmaped)
>                 return NULL;
>         *psize =3D map->def.value_size;
> --
> 2.34.1
>

