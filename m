Return-Path: <bpf+bounces-33389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC791C995
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35004285303
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7C824BD;
	Fri, 28 Jun 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM6fLopv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE39757EF
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719617436; cv=none; b=lrmdHJ6CwcrV4ew5LMjF0r3Dxy1Mvu69tJofREbxaJVU3sJc57GgcFDqer+Q2G2X/mmygavZ59u2KUnaWuYf9Swqn2PqjV9vm7fqBmYp0iHw4rNm1lOOU9FDVRikkK4ARU0Dj4FaC3N8j/dtrs18NCNY7xOHWxZaZvJ/xT6W7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719617436; c=relaxed/simple;
	bh=hscKp8iqJM0f+PpDTOftWEr6KFzOj2ll0Gryo8hbsD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNZOunGDUCieUxSJ1c3o5U2dfCecY5+aF4sIfvre/9MtOtrBZLV4/pAeHJ0dxFtK28MpeBDNrg5pR7mhxOCXhM+NRj69qaEHTT9cj8jKKVsBg6Sy8UAkksjHRRuVqD2cMZdtWf9PEL+UNdms1jARWxspDm7EJu+WAT0JuDUhwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM6fLopv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-701f397e8ffso646367a34.0
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719617434; x=1720222234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5EDqU9jxHSLJQY4x8BMSmakZ4G77aYaZ3Ey1Pj/CMA=;
        b=FM6fLopvet9OQ/o+gvxD4gsqNDfAocB4jWy/jFauQIsnTZRkK2Ap9TjfnlAtJjlGmq
         6ZeHBRr4daZ70DoeNdIW6E2ADIXD6N4QJ1epk51tFL8aSbV+Q4a1b3F7rjvV+uwcNRU8
         yKNUybGNz5zdmmIyjvEZgHryq9mOTN7rlpql6/VXM3m7GVPE4u9sq04M2e5U/lgxyUZg
         9D95Ih40UowRglqIGr241nYCHc7Clh7HdikWy1JRxFyj7gUH0Ewd4x4m8hop9JhveK/4
         awSq48UJSe/yEiNNQKFt3+9qlw5pPSP6j/IGHz8D8KNzLzCS5QN9lBiGCKiIKlHUV+3f
         bJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719617434; x=1720222234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5EDqU9jxHSLJQY4x8BMSmakZ4G77aYaZ3Ey1Pj/CMA=;
        b=vGBDk+lKlo8SjN1k0xGnI68Afd30Hszbq+uiTPQjwoFYtl/JOQTRF99qL1Lno/XPfR
         cBhWu9C2lhVhodEfx/pOFmDVzzxc7Il1YqfBi+wGdsiGFQXgmCiYkog+ene9Uzi4C/4H
         A7gUuJqCb6/0o8idH2tj8Roa9YFwX6TfQZGT0Nz6LNBPBsktr8Fc8Wrq0k3WygdyCllw
         ZMN5cmAI1knKvS7nM+X1MAyWUErwMrLU585Mfp77ebEBrRrYldDleB19x+CLPJc+PYem
         fDgXj1W0gTjASTtkd6mmYhlb0qWohO1XBLAfQ50O9H66sSfdBdC4hLbCni5n5B/pjBfG
         Z5zw==
X-Forwarded-Encrypted: i=1; AJvYcCXB8vIyVJkzoVprgbrUYiLsA/EgxhCXqQIlsDkKoDCWUijdR0bexETLbblWkJY+GfZ9LcRC0ypDgv7sgfuA8SYZEBKQ
X-Gm-Message-State: AOJu0YwaJKfllFcJjtXKesTSMHCjW/9uT8cq531UlN9/Uf+EoVa3NS7+
	gwIBlvs87jLyLYSl/1WkdvoODh75FGaDXGJjBikxuJRPkP/0pmSugPKwi3+XFdEynhaPl97tjtk
	Ne0qZ4eVZscwJCwCrD0EC/c8xcLA=
X-Google-Smtp-Source: AGHT+IHHJ0JfNbE7npC0X4v6Zi3+6SZS37v5TQa6PnECRMABiw1Ko89OKLhwqNMs2gV0RaQRSr/cW5QFuPW5HuP2mwY=
X-Received: by 2002:a9d:5e05:0:b0:6fa:732b:862e with SMTP id
 46e09a7af769-700ac4bc60amr19335518a34.9.1719617433676; Fri, 28 Jun 2024
 16:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613095014.357981-1-alan.maguire@oracle.com> <20240613095014.357981-2-alan.maguire@oracle.com>
In-Reply-To: <20240613095014.357981-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 16:30:21 -0700
Message-ID: <CAEf4BzbmTYtOM6SLSZZ-oB3VvuaNnEiSvJPHSchYEO7OySSvdw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/9] libbpf: add btf__distill_base() creating
 split BTF with distilled base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 2:50=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
>
> This context comes in the form of distilled base BTF providing minimal
> information (name and - in some cases - size) for base INTs, FLOATs,
> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
> points at that base and contains any additional types needed (such as
> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
> information constitutes the minimal BTF representation needed to
> disambiguate or remove split BTF references to base BTF.  The rules
> are as follows:
>
> - INT, FLOAT, FWD are recorded in full.
> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>   will be encoded as a zero-member sized STRUCT/UNION (preserving
>   size for later relocation checks).  Only base BTF STRUCT/UNIONs
>   that are either embedded in split BTF STRUCT/UNIONs or that have
>   multiple STRUCT/UNION instances of the same name will _need_ size
>   checks at relocation time, but as it is possible a different set of
>   types will be duplicates in the later to-be-resolved base BTF,
>   we preserve size information for all named STRUCT/UNIONs.
> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
>   with no values) of the same size is used.
> - in all other cases, the type is added to the new split BTF.
>
> Avoiding struct/union/enum/enum64 expansion is important to keep the
> distilled base BTF representation to a minimum size.
>
> When successful, new representations of the distilled base BTF and new
> split BTF that refers to it are returned.  Both need to be freed by the
> caller.
>
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate distilled base BTF with a
> 0-member STRUCT sk_buff of the appropriate size, and the split BTF
> will refer to it instead.
>
> Tools like pahole can utilize such split BTF to populate the .BTF
> section (split BTF) and an additional .BTF.base section.  Then
> when the split BTF is loaded, the distilled base BTF can be used
> to relocate split BTF to reference the current (and possibly changed)
> base BTF.
>
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the distilled base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (relocated) base BTF sk_buff type id.
>
> Distilled base BTF is small; when building a kernel with all modules
> using distilled base BTF as a test, overall module size grew by only
> 5.3Mb total across ~2700 modules.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 319 ++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/btf.h      |  21 +++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 335 insertions(+), 6 deletions(-)
>

[...]

> +/* Create updated split BTF with distilled base BTF; distilled base BTF
> + * consists of BTF information required to clarify the types that split
> + * BTF refers to, omitting unneeded details.  Specifically it will conta=
in
> + * base types and memberless definitions of named structs, unions and en=
umerated
> + * types. Associated reference types like pointers, arrays and anonymous
> + * structs, unions and enumerated types will be added to split BTF.
> + * Size is recorded for named struct/unions to help guide matching to th=
e
> + * target base BTF during later relocation.
> + *
> + * The only case where structs, unions or enumerated types are fully rep=
resented
> + * is when they are anonymous; in such cases, the anonymous type is adde=
d to
> + * split BTF in full.
> + *
> + * We return newly-created split BTF where the split BTF refers to a new=
ly-created
> + * distilled base BTF. Both must be freed separately by the caller.
> + */
> +int btf__distill_base(const struct btf *src_btf, struct btf **new_base_b=
tf,
> +                     struct btf **new_split_btf)
> +{
> +       struct btf *new_base =3D NULL, *new_split =3D NULL;
> +       const struct btf *old_base;
> +       unsigned int n =3D btf__type_cnt(src_btf);
> +       struct btf_distill dist =3D {};
> +       struct btf_type *t;
> +       int i, err =3D 0;
> +
> +       /* src BTF must be split BTF. */
> +       old_base =3D btf__base_btf(src_btf);
> +       if (!new_base_btf || !new_split_btf || !old_base)
> +               return libbpf_err(-EINVAL);
> +
> +       new_base =3D btf__new_empty();
> +       if (!new_base)
> +               return libbpf_err(-ENOMEM);
> +       dist.id_map =3D calloc(n, sizeof(*dist.id_map));
> +       if (!dist.id_map) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +       dist.pipe.src =3D src_btf;
> +       dist.pipe.dst =3D new_base;
> +       dist.pipe.str_off_map =3D hashmap__new(btf_dedup_identity_hash_fn=
, btf_dedup_equal_fn, NULL);
> +       if (IS_ERR(dist.pipe.str_off_map)) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +       dist.split_start_id =3D btf__type_cnt(old_base);
> +       dist.split_start_str =3D old_base->hdr->str_len;
> +
> +       /* Pass over src split BTF; generate the list of base BTF type id=
s it
> +        * references; these will constitute our distilled BTF set to be
> +        * distributed over base and split BTF as appropriate.
> +        */
> +       for (i =3D src_btf->start_id; i < n; i++) {
> +               err =3D btf_add_distilled_type_ids(&dist, i);
> +               if (err < 0)
> +                       goto done;
> +       }
> +       /* Next add types for each of the required references to base BTF=
 and split BTF
> +        * in turn.
> +        */
> +       err =3D btf_add_distilled_types(&dist);
> +       if (err < 0)
> +               goto done;
> +
> +       /* Create new split BTF with distilled base BTF as its base; the =
final
> +        * state is split BTF with distilled base BTF that represents eno=
ugh
> +        * about its base references to allow it to be relocated with the=
 base
> +        * BTF available.
> +        */
> +       new_split =3D btf__new_empty_split(new_base);
> +       if (!new_split_btf) {

Coverity points out that new_split_btf probably isn't what should be
checked here. I think this was meant to be "new_split" here, is that
right? Can you please send a quick fix? Thanks!

> +               err =3D -errno;
> +               goto done;
> +       }
> +       dist.pipe.dst =3D new_split;
> +       /* First add all split types */
> +       for (i =3D src_btf->start_id; i < n; i++) {
> +               t =3D btf_type_by_id(src_btf, i);
> +               err =3D btf_add_type(&dist.pipe, t);
> +               if (err < 0)
> +                       goto done;
> +       }
> +       /* Now add distilled types to split BTF that are not added to bas=
e. */
> +       err =3D btf_add_distilled_types(&dist);
> +       if (err < 0)
> +               goto done;
> +
> +       /* All split BTF ids will be shifted downwards since there are le=
ss base
> +        * BTF ids in distilled base BTF.
> +        */
> +       dist.diff_id =3D dist.split_start_id - btf__type_cnt(new_base);
> +
> +       n =3D btf__type_cnt(new_split);
> +       /* Now update base/split BTF ids. */
> +       for (i =3D 1; i < n; i++) {
> +               err =3D btf_update_distilled_type_ids(&dist, i);
> +               if (err < 0)
> +                       break;
> +       }
> +done:
> +       free(dist.id_map);
> +       hashmap__free(dist.pipe.str_off_map);
> +       if (err) {
> +               btf__free(new_split);
> +               btf__free(new_base);
> +               return libbpf_err(err);
> +       }
> +       *new_base_btf =3D new_base;
> +       *new_split_btf =3D new_split;
> +
> +       return 0;
> +}

[...]

