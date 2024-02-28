Return-Path: <bpf+bounces-22899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E086B661
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528C71C2358B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162115DBB5;
	Wed, 28 Feb 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXePSrUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8615D5DE
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142554; cv=none; b=CDQfO9S+sdZelY9u6YSZgH6M+vHxIP8vihqR/aUGNgkxCv+3Tt5fQ5KTpa4ea4z4dtcxrMq7I7oP2OblqukvBfPAw5D0hPnZIwnm92+Rv44G9UZwMQ5UZRPCuzgRpegXAc0QGyXmf1NTg+idPWJ0kV5yfIW8b8afzvbx2H/hp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142554; c=relaxed/simple;
	bh=kaWJ376jin1bFBHAdEf6+1R0bgHnQNu04lYTezpQ7pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz8wy1p3bjD5Lpikve1qc3Y9XBKFZAMPUv67YRRcTfyvTF2/hOguTfKOJtRuFrUb5WNXFilS7Q+4c52nxRFOlsABpCOZwK0loFvDmWS4W3BasdzZi23KLyVg0ZfFfpYtNOCqUojeX8iWrE6naUnA3ktJEu5vkIWE6i+d3Z/0Pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXePSrUs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0e5b223eso512295ad.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142553; x=1709747353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XNoAPdoW1vZVx5cgOtsmiNJkzeEo3M7eXCQ5jgoOfc=;
        b=kXePSrUsRUATKFHpcyG+Q4iW4jnt8HfxMBnwZyC/OQ2fjNqzhEsTY2xYBffKvqld8z
         GYGy2opZHBkQuxDA9nk9o7i2cNWAteW5fpzRnIGZhsxqjLfV9op5BVxup0WbPC53b2AL
         Q8tliajK6MgOnw9ahFAC0xxSe6HhD4LsjI8jc9cKz3TZCNk6W+YUgSZpjNHFXHiuSwys
         u41v0GqVIo0VfEI7LAzBTVe/csVFBe1BTVXrmb1ePMQuX5Kz2PfOz4LqnKrdnx+19RZr
         YFM8jcNDODetmFss1MZbROrkEjLEAoUv5e+mFJBnCXptO7pPV+5ayNVuL57fNpNvvi8B
         inkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142553; x=1709747353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XNoAPdoW1vZVx5cgOtsmiNJkzeEo3M7eXCQ5jgoOfc=;
        b=TxrrUs4cyJb4rjpEnf1vLPOV2BxuF0zf5f5EdQ2NdhJgwArNDWE02cUAHPo+WmU7N8
         uARl1ciMh81zlwQA2fpuyUUiyO3mEDyvjuty+vKhhsO6RNXEqxpVq7AJ/QM2kEqdCSE4
         LVacwY4yeS5Rj3XY14Dvs6A0XokLmJAX/0uoel0FHQf57iUFGxNeIgoJVPbyONeBhsVS
         zyC3S4dY5YZuCIKSxRQeJoebz3dmlXyVkCYcp8AHT6TUZlrDZigFurox0KxPaNQsf2+8
         eSpzX0/tbQp5Asv9W0G63yVFKCoa5oBXfeuDxZdRExojzDTVcqZEwh1g9AbYZBpTdWbi
         p/pw==
X-Gm-Message-State: AOJu0YxBJ6pqgdHb170B/WnxfVPaBDRFmZCQwJN5oBcRk0NaiAyHYi5Q
	2vw2fXjYHQsGwcNvWguq9R0i29eD7/JcSzMRvv5Hg5JOzEG0vTe0vAEqG4Sz4yeRGAEEJxXJ5+9
	eSSZQJge4dW1luaojmNqQhbwQOG8=
X-Google-Smtp-Source: AGHT+IEMVy4s8ASZLDgnBTiEsPN/5S4UXDz85/au+LobovokNjStUAKo7fiJj2d2aI76fsrdqB4iahSIi+465CBiZZk=
X-Received: by 2002:a17:902:f80a:b0:1dc:b80e:5678 with SMTP id
 ix10-20020a170902f80a00b001dcb80e5678mr146250plb.23.1709142550958; Wed, 28
 Feb 2024 09:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-3-thinker.li@gmail.com>
In-Reply-To: <20240227010432.714127-3-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 09:48:59 -0800
Message-ID: <CAEf4BzYp0xjWPzeA1-QCL20PSBa9krcA=LwxuZpe+8-btQUf6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] libbpf: set btf_value_type_id of struct
 bpf_map for struct_ops.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> For a struct_ops map, btf_value_type_id is the type ID of it's struct
> type. This value is required by bpftool to generate skeleton including
> pointers of shadow types. The code generator gets the type ID from
> bpf_map__btf_vaule_type_id() in order to get the type information of the
> struct type of a map.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ef8fd20f33ca..465b50235a01 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1229,6 +1229,7 @@ static int init_struct_ops_maps(struct bpf_object *=
obj, const char *sec_name,
>                 map->name =3D strdup(var_name);
>                 if (!map->name)
>                         return -ENOMEM;
> +               map->btf_value_type_id =3D type_id;
>

this part is good

>                 map->def.type =3D BPF_MAP_TYPE_STRUCT_OPS;
>                 map->def.key_size =3D sizeof(int);
> @@ -4818,7 +4819,9 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
>         if (obj->btf && btf__fd(obj->btf) >=3D 0) {
>                 create_attr.btf_fd =3D btf__fd(obj->btf);
>                 create_attr.btf_key_type_id =3D map->btf_key_type_id;
> -               create_attr.btf_value_type_id =3D map->btf_value_type_id;
> +               create_attr.btf_value_type_id =3D
> +                       def->type !=3D BPF_MAP_TYPE_STRUCT_OPS ?
> +                       map->btf_value_type_id : 0;

but here I think it's cleaner to reset create_attr.btf_value_type_id
to zero a bit lower, see that we have special logic for
PERF_EVENT_ARRAY, CGROUP_ARRAY and a bunch more maps. Just add a case
for BPF_MAP_TYPE_STRUCT_OPS that will clear
create_attr.btf_value_type_id only (keeping btf_fd and
map->btf_value_Type_id intact)

>         }
>
>         if (bpf_map_type__is_map_in_map(def->type)) {
> --
> 2.34.1
>

