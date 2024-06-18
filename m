Return-Path: <bpf+bounces-32472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19690DF58
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EF428124A
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4517FAD8;
	Tue, 18 Jun 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2ZMNFIi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B1178CEC
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750914; cv=none; b=YzwniYP3DWV4/qsy2WHe5gWXB3jXHQ+2RVDAiuNHZlkAIOXssomqrwUCvPQdqwbtFclRre02CBvyVEJARtmRC/TDzK12KcS+uC/MDWnwTxRkondv8ZYD6o+UtnjbwLRRoiNnTtqTsWMXFfeZaiywZ9tP4tHb3hYry8YHijjQipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750914; c=relaxed/simple;
	bh=XkO6AxnfO36eF+60BVrKIjjShIAtru1F4VRQGhh98AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2cSwHYC/3jA7tjyHJoefYocIu9WUdnpzaVmIMjGqTgyPCbWF3bRNfWMhACREKjHearu6kMJC8lbllx6WF5vIjG9gLdbx6TT1SfmYwObkFnjCJPFFaGLP+pRHLY/C+wP5UR6H9g5Lzps03pCwi1zQfQvvOx47qzKCTIxXvFEXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2ZMNFIi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-70df2135428so1156128a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718750913; x=1719355713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9L8QkRqkbte5tVqXmDuldoRvelvEiduS0er7f5VAJ0=;
        b=R2ZMNFIikXrbJdfCo+vb6PGlBHEAsEkoBP4ENPytfXLQEhnJJdJTvJd31mbOJ1hglU
         qZ+tsNrgpOkRw6PmJCCmmiPXgQodwb+VzWCDgo/JtGKSGV5Gk3cZtPVKlX7Q3B8M+uy4
         VR6uDWiqbzUfXZJzwfhrCzt7/8aLVOetieT7PDGfr6liz5l0r2XKr23SQtxZLP/SWCPz
         0t7oWo9AVkLi3RY63OFXDmWupvixqy9NtOvM5nRkra9QqfpaEIxeob0ntMzEjI+rleTx
         lkViMiBFb8JehlcqFWlquo2w73odR0ta4FYOe2ijp8Wjf/jR3yhTcS44BRUj+71gSu4I
         2D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718750913; x=1719355713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9L8QkRqkbte5tVqXmDuldoRvelvEiduS0er7f5VAJ0=;
        b=WKFcCU288BpFADvbopUj4WOsB2OcoQOlgNl7rwzbPByH8jwnXjJbm3Cxps+uFizPMr
         IjO/Pzu2mnSUJYNK7tQkVJdwPayqDXbwPq43XN2/s5qBFjumyQfif65i1F9BoCzQ84s1
         a8EXAJvB73q+CmH7sRWpb+dEuRSo5FFAP7qp07zJO9SbmaE0I+MkX0wpRvNC4ViNwGXg
         SLHmQYwNHglDs8CTLi47fD2mmQuP6kR8JDlIYSaD+t0gvvQ7vOscU3OiMFuPJRiaAtKZ
         bUXmrwXLgaEiVhla84+gBHyx6VqhXEzvQGVtyTmNkVoW7cjkLIbrd3EfktTYMx0fOYoL
         cEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXBA6JxdP60mV2o0SmcaxGW6z8IgwTrX5efmaaPUYUnVdjbTRXhL8b/zd/MfB/TFIqoTHzAF0+cf/KzhjJOl/bYrGgV
X-Gm-Message-State: AOJu0YzwwF3ARBnkKQYsSfYcyZj2mdNkkCGxN2qYPmX8Z/GvR1otyR06
	GtD93Vt5WzH9apTZdY4xydvAF20S2cMw2t+fckAN29AxxiP/UKuZjuFbzylSyguIlGuhGn8AttL
	zxsIPDZmua27J38P3nyMvg6dFCF8=
X-Google-Smtp-Source: AGHT+IEuKzGR6Nz21U0QP6pijKvlChIjq/X2jCms9BOtLSnhe4eYRQa5D73EaG4dPmha8p5qP5OGXIlm/ZMR2wlT3U4=
X-Received: by 2002:a17:90b:124d:b0:2c2:f07d:8bae with SMTP id
 98e67ed59e1d1-2c7b5d90649mr1091309a91.45.1718750912663; Tue, 18 Jun 2024
 15:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618162449.809994-1-alan.maguire@oracle.com> <20240618162449.809994-2-alan.maguire@oracle.com>
In-Reply-To: <20240618162449.809994-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 15:48:20 -0700
Message-ID: <CAEf4BzZ-hfDJaJdFDpWKf+a5qT0491439NvhjmgiZhYyu+zAww@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: BTF relocation followup fixing
 naming, loop logic
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, acme@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, bentiss@kernel.org, 
	tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Use less verbose names in BTF relocation code and fix off-by-one error
> and typo in btf_relocate.c.  Simplify loop over matching distilled
> types, moving from assigning a _next value in loop body to moving
> match check conditions into the guard.
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf_relocate.c | 74 ++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 41 deletions(-)
>

Few more nits, but generally looks great, thanks!

> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index eabb8755f662..64cd8bdc0105 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -160,7 +160,7 @@ static int btf_mark_embedded_composite_type_ids(struc=
t btf_relocate *r, __u32 i)
>   */
>  static int btf_relocate_map_distilled_base(struct btf_relocate *r)
>  {
> -       struct btf_name_info *dist_base_info_sorted, *dist_base_info_sort=
ed_end;
> +       struct btf_name_info *info, *info_end;
>         struct btf_type *base_t, *dist_t;
>         __u8 *base_name_cnt =3D NULL;
>         int err =3D 0;
> @@ -169,26 +169,25 @@ static int btf_relocate_map_distilled_base(struct b=
tf_relocate *r)
>         /* generate a sort index array of name/type ids sorted by name fo=
r
>          * distilled base BTF to speed name-based lookups.
>          */
> -       dist_base_info_sorted =3D calloc(r->nr_dist_base_types, sizeof(*d=
ist_base_info_sorted));
> -       if (!dist_base_info_sorted) {
> +       info =3D calloc(r->nr_dist_base_types, sizeof(*info));
> +       if (!info) {
>                 err =3D -ENOMEM;
>                 goto done;
>         }
> -       dist_base_info_sorted_end =3D dist_base_info_sorted + r->nr_dist_=
base_types;
> +       info_end =3D info + r->nr_dist_base_types;
>         for (id =3D 0; id < r->nr_dist_base_types; id++) {
>                 dist_t =3D btf_type_by_id(r->dist_base_btf, id);
> -               dist_base_info_sorted[id].name =3D btf__name_by_offset(r-=
>dist_base_btf,
> -                                                                    dist=
_t->name_off);
> -               dist_base_info_sorted[id].id =3D id;
> -               dist_base_info_sorted[id].size =3D dist_t->size;
> -               dist_base_info_sorted[id].needs_size =3D true;
> +               info[id].name =3D btf__name_by_offset(r->dist_base_btf,
> +                                                   dist_t->name_off);

please make it a single line, now that it's much shorter

> +               info[id].id =3D id;
> +               info[id].size =3D dist_t->size;
> +               info[id].needs_size =3D true;
>         }

[...]

>                 /* iterate over all matching distilled base types */
> -               for (dist_name_info =3D search_btf_name_size(&base_name_i=
nfo, dist_base_info_sorted,
> -                                                          r->nr_dist_bas=
e_types);
> -                    dist_name_info !=3D NULL; dist_name_info =3D dist_na=
me_info_next) {
> -                       /* Are there more distilled matches to process af=
ter
> -                        * this one?
> -                        */
> -                       dist_name_info_next =3D dist_name_info + 1;
> -                       if (dist_name_info_next >=3D dist_base_info_sorte=
d_end ||
> -                           cmp_btf_name_size(&base_name_info, dist_name_=
info_next))
> -                               dist_name_info_next =3D NULL;
> -
> -                       if (!dist_name_info->id || dist_name_info->id > r=
->nr_dist_base_types) {
> +               for (dist_info =3D search_btf_name_size(&base_info, info,
> +                                                     r->nr_dist_base_typ=
es);

does it fit under 100? please prioritize keeping single-line code as
much as possible

> +                    dist_info && dist_info < info_end &&

I missed the need for `dist_info < info_end` in my original
suggestion, but yes, this looks much better, thanks (and yeah, I don't
think one extra cmp_btf_name_size() call matters much).

> +                    !cmp_btf_name_size(&base_info, dist_info);

nit: given this is strcmp()-like function, I'd prefer explicit `=3D=3D 0`
instead of boolean-like !


> +                    dist_info++) {
> +                       if (!dist_info->id || dist_info->id >=3D r->nr_di=
st_base_types) {
>                                 pr_warn("base BTF id [%d] maps to invalid=
 distilled base BTF id [%d]\n",
> -                                       id, dist_name_info->id);
> +                                       id, dist_info->id);
>                                 err =3D -EINVAL;
>                                 goto done;
>                         }
> -                       dist_t =3D btf_type_by_id(r->dist_base_btf, dist_=
name_info->id);
> +                       dist_t =3D btf_type_by_id(r->dist_base_btf, dist_=
info->id);
>                         dist_kind =3D btf_kind(dist_t);
>

[...]

