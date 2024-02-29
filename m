Return-Path: <bpf+bounces-23093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB886D6D1
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06601C2246D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57074C01;
	Thu, 29 Feb 2024 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je/q6ex7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832D16FF47
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245563; cv=none; b=uBHCV4q4R6C3ndZwmvys+kRd0z5b6VQHcTjt0KGP75ZIYLskfxikuzihL9lFc8LcGsqoyiC1MuM7469G2YM1ESpnMQKpwdR8JkvgnUa67qY5sZjBW5nMt4tf/Zy1jjuEgr4y+h0cj5gPQnnnbQs6PEGug3ikB3O5MU7U0P5/d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245563; c=relaxed/simple;
	bh=doQcoGcO/oAvkh/7VuNEfdki4vw3q2OtSgCkxZ3f4R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmqd8Yj+yg1l2rMHJ5pFygBWRJdC/uVomyV5zRz8/q/Nj2ENXKzNvmnKaUdzKo4vrkBhgSvdJ5ZcstHpti6HIZil8SJv8nWaYv6QS9Tk3/xcX4BOr62/lGZATGTJxJnQydy9dKfveMoSB8yNpUS6WRRC+zfaTiz3rRyQ87t9w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je/q6ex7; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1253262a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245561; x=1709850361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G1KaIs5iHgePBKbeIsakAGQKC7ZT/BtK8CoyQBqXtI=;
        b=Je/q6ex7ao1GGKik5hA+PVqtbxk6cTexiXLQN43VnNUw+WbWYiNiKvC0XlMeiZ5ulB
         3UEjbB6SXqHjdJQTA8CkcowkWJYuKnRGEPA9ZuqUIGL6Qogi7mfVlqfz0KKBcugFI87V
         qLtOabOdPPiPpdW9SSi3CwXF23Zw1I230hcHRPw5FYIszPHIzGsvUvJTnRctOR1sdl1Y
         jIefVnSnxzOYCZAJLnk3zgJTyvmoMXuZ2YmJGVgMlYx3XF7UFA/3ZtA/+eMBPozVT53D
         fN99c3qJI8lbRSW+vPy8ISPUy7Ny0nBvBod4DVkop2O09L2hxCBU/OX1gv2IH/YP8c6X
         hkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245562; x=1709850362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G1KaIs5iHgePBKbeIsakAGQKC7ZT/BtK8CoyQBqXtI=;
        b=LFiH7JVDca42NNzyFp240otns9aFzRZt94NfIg5nXNNCbiP3u03Uz5Dr+dUV57NNd5
         DnlMuCIO8r0gGfIrbSKUdvOhfzc+hQmpq8zWQhD7Go2Q+1aKpVI47+7QObDi4cgZ4vOu
         7zaGHQPbhScBfF2ynPWJpy94LzY16NE0D958//qdd41VtAyOz192dHinh3+NQaHLMzZ8
         2ctcjfecD0FhWB8pTl2WfoY84Ur+tOWBugwkcFOqNru5sAHRfydCvYAJwj2ywiiU+kBl
         wCpmwZ4hghc1LNK/XjzPOL6PaX8hwsUG01yb7riQ5Eb29OeTiZiyrdD/ahAipm1X+8yg
         DGtA==
X-Gm-Message-State: AOJu0Yzn/TNY60yGL5CAnlb1TNO4uwE8FX33+jju0LKl/zW7pCvRPRgS
	sArYurO77Qd96xXoCQ908XHP4UrPt6wlXaascogBn1bIQGOSjJm7jQ5DeYcKcnU7L3w+APQmI25
	eTkVnhJ2RY/hds5MDFDaAmsnaJLY=
X-Google-Smtp-Source: AGHT+IGEfrWCzEslyssAKtxaCYZDs+VyBemT0oDLvraVLeG18H57XBSnXn2dmvWrLbjzgWcQAL+ZIN2/rrqtgA3zzOI=
X-Received: by 2002:a17:90a:f983:b0:29b:5c1:5e05 with SMTP id
 cq3-20020a17090af98300b0029b05c15e05mr416025pjb.2.1709245561594; Thu, 29 Feb
 2024 14:26:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229064523.2091270-1-thinker.li@gmail.com> <20240229064523.2091270-4-thinker.li@gmail.com>
In-Reply-To: <20240229064523.2091270-4-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Feb 2024 14:25:49 -0800
Message-ID: <CAEf4BzbPG1CSC62dKcDb_=aH8pi7NEZ5zQFQxMQdOPEzZmLzvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpftool: generated shadow variables for
 struct_ops maps.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:45=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> Declares and defines a pointer of the shadow type for each struct_ops map=
.
>
> The code generator will create an anonymous struct type as the shadow typ=
e
> for each struct_ops map. The shadow type is translated from the original
> struct type of the map. The user of the skeleton use pointers of them to
> access the values of struct_ops maps.
>
> However, shadow types only supports certain types of fields, including
> scalar types and function pointers. Any fields of unsupported types are
> translated into an array of characters to occupy the space of the origina=
l
> field. Function pointers are translated into pointers of the struct
> bpf_program. Additionally, padding fields are generated to occupy the spa=
ce
> between two consecutive fields.
>
> The pointers of shadow types of struct_osp maps are initialized when
> *__open_opts() in skeletons are called. For a map called FOO, the user ca=
n
> access it through the pointer at skel->struct_ops.FOO.
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/bpf/bpftool/gen.c | 237 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 236 insertions(+), 1 deletion(-)
>

[...]

> +/* Generate the pointer of the shadow type for a struct_ops map.
> + *
> + * This function adds a pointer of the shadow type for a struct_ops map.
> + * The members of a struct_ops map can be exported through a pointer to =
a
> + * shadow type. The user can access these members through the pointer.
> + *
> + * A shadow type includes not all members, only members of some types.
> + * They are scalar types and function pointers. The function pointers ar=
e
> + * translated to the pointer of the struct bpf_program. The scalar types
> + * are translated to the original type without any modifiers.
> + *
> + * Unsupported types will be translated to a char array to occupy the sa=
me
> + * space as the original field, being renamed as __unsupported_*.  The u=
ser
> + * should treat these fields as opaque data.
> + */
> +static int gen_st_ops_shadow_type(const char *obj_name, struct btf *btf,=
 const char *ident,
> +                                 const struct bpf_map *map)
> +{
> +       const struct btf_type *map_type;
> +       const char *type_name;
> +       __u32 map_type_id;
> +       int err;
> +
> +       map_type_id =3D bpf_map__btf_value_type_id(map);
> +       if (map_type_id =3D=3D 0)
> +               return -EINVAL;
> +       map_type =3D btf__type_by_id(btf, map_type_id);
> +       if (!map_type)
> +               return -EINVAL;
> +
> +       type_name =3D btf__name_by_offset(btf, map_type->name_off);
> +
> +       printf("\t\tstruct %s_%s_%s {\n", obj_name, ident, type_name);

it should be %s__%s__%s, I fixed it up

> +
> +       err =3D walk_st_ops_shadow_vars(btf, ident, map_type, map_type_id=
);
> +       if (err)
> +               return err;
> +
> +       printf("\t\t} *%s;\n", ident);
> +
> +       return 0;
> +}
> +
> +static int gen_st_ops_shadow(const char *obj_name, struct btf *btf, stru=
ct bpf_object *obj)
> +{
> +       int err, st_ops_cnt =3D 0;
> +       struct bpf_map *map;
> +       char ident[256];
> +
> +       if (!btf)
> +               return 0;
> +
> +       /* Generate the pointers to shadow types of
> +        * struct_ops maps.
> +        */
> +       bpf_object__for_each_map(map, obj) {
> +               if (bpf_map__type(map) !=3D BPF_MAP_TYPE_STRUCT_OPS)
> +                       continue;
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +
> +               if (!st_ops_cnt++)

goodness, too much operator precedence knowledge assumed, I simplified
this to what I can follow myself:

if (st_ops_cnt =3D=3D 0)
    printf(...);
st_ops_cnt++;

I don't think saving one line of code is worth it.

> +                       printf("\tstruct {\n");
> +
> +               err =3D gen_st_ops_shadow_type(obj_name, btf, ident, map)=
;
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (st_ops_cnt)
> +               printf("\t} struct_ops;\n");
> +
> +       return 0;
> +}
> +

[...]

