Return-Path: <bpf+bounces-39067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2996E41E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75101F275AE
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786801A01B0;
	Thu,  5 Sep 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCJE4ffu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C216BE15
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568319; cv=none; b=D4yURTmZaxPVEZHW+9yYh40PgWorP/hReFSmXblSpHFH04y8ySn2ZeQPRVcgzWf1BwPAwrRo4rAW4SpCeFS9ZIQm03rFoSr75qPPp08ilvDYeZAlul7cEb99kFw0gCBfB2c2GvG3KrCL5/c1vVlsT3A5wdXzK7/J+N3zLVEruew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568319; c=relaxed/simple;
	bh=3t3HYPJGm7ZnC6hu0ARdQ9vs67UtkynRi3I14efg7Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWFxDK6iIYJS7SS0uZ4L4CYyUooFoq5HzTRd17++sb2veLK7RJ9oLidM7BkdsohSpodLdDHHSmRuIet8Ti7iwyxKUJY+s61a28k9R6Bxe5bqQTpwJXxGlQhCGmcUt1YGfN/bAHw4V5dPn29IThR8kyCJky5tr/FaxNv4JhkZdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCJE4ffu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-204d391f53bso13025905ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725568317; x=1726173117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cwx9hnIhftbhdJFykVg6xWY3vbGgrDLewiQBwJzxRuo=;
        b=LCJE4ffuyQqDRT216lL1Cjf5jo9s6pe2/pCzZLMzgkfH8l43qQSkuaw+T2SS+4eChs
         AWkKsYrGMHYE6KX4PyQWsCDVZjzGKqn9/dhgidIOMe2gpIUMmkmp+sjPNeWphvPD0DRK
         kOWsfqqYwFxOx3GKBfloKUIGD1poRz3EMCqba6w5NBsPJISmAy8Np2lotJzEHWKHoISZ
         4e0kYjGgq1jouNYeBGvLO3MatsGeDVIEvqYT9eSaHmUFKPw6TlYJdZ37QynOGvPh7qH+
         9taH2oiAjFhEQrHfjkZnpq6rla9YrtI20iNM6zww7OnJ5uClJy4XMKcPgAFrsoKeZXhU
         wuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725568317; x=1726173117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cwx9hnIhftbhdJFykVg6xWY3vbGgrDLewiQBwJzxRuo=;
        b=YZ1tFHcE1V+xI0YOuyI7jVWmSgBaDXsE2aqvR5qY/SCtPH1oHQGy7z6gzI/0+mkj+I
         Ln/z6VSX1S8/Re4xjno2suioWGJlRixLqejmV80XF9hPaJBR+f3NuB6XJrW3H23999SK
         BEnXcp03EW44gtAqNU5wLY8qe4ZgLS1vYljjf/P0+z7tQBWtmjS+NJepQyPJqEZ95EsY
         RpNpJOMV+ONMMwlhS4qZswJXm3YAVyFPCo21jCRqdKERPyQZqrex6MUwlTm1V7Fmj6kU
         ioqPXAqli0zXDJtv04BAllPDbDqS6Wv9KOW/0V0xZ9v9HCHFe5TEwDc08x9J2CZHvXgm
         /Srg==
X-Gm-Message-State: AOJu0YxJZY3TIK54zsOF38EzQCfN5b7ml6wvmuku4NGhVmFeW0/XMr6+
	cpKaCiEOx2mKVI54DpNJEaT5NFIEQ+CNw0kScqHfwS8S9wkPEtAxlaFVqeVa4gBODW5ht+ElPh+
	1f9krRQsvkY6i88z2tCDC4+F/h4g=
X-Google-Smtp-Source: AGHT+IGfOE8+Z069V1e84Ebj2+7dcBpfPtv7cMtlvmb/2ShLEbW6uRT7Vpvz/YdrjRR5juX7hKfjTnyfbjQ20OSKlwE=
X-Received: by 2002:a17:902:cecd:b0:203:a0ea:63c5 with SMTP id
 d9443c01a7336-206f0367aa2mr3001035ad.0.1725568316698; Thu, 05 Sep 2024
 13:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905201206.648932-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20240905201206.648932-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Sep 2024 13:31:44 -0700
Message-ID: <CAEf4BzYnrpdBcTFpA_MsM+6qyW3Cmcte9zhv2vrJsnYKQrFhAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: improve btf c dump sorting stability
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:12=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Existing algorithm for BTF C dump sorting uses only types and names of
> the structs and unions for ordering. As dump contains structs with the
> same names but different contents, relative to each other ordering of
> those structs will be accidental.
> This patch addresses this problem by introducing a new sorting field
> that contains hash of the struct/union field names and types to
> disambiguate comparison of the non-unique named structs.
>

Did you check how stable generated vmlinux.h now is when just
rebuilding kernel with no actual changes? Does it still have some
variation?

LGTM, but let's keep the btf_type_sort_name() as is? See below.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/btf.c | 93 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 14 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 3b57ba095ab6..0e7151bfc3d5 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -50,6 +50,7 @@ struct sort_datum {
>         int type_rank;
>         const char *sort_name;
>         const char *own_name;
> +       __u64 disambig_hash;
>  };
>
>  static const char *btf_int_enc_str(__u8 encoding)
> @@ -557,17 +558,6 @@ static const char *btf_type_sort_name(const struct b=
tf *btf, __u32 index, bool f
>         const struct btf_type *t =3D btf__type_by_id(btf, index);
>
>         switch (btf_kind(t)) {
> -       case BTF_KIND_ENUM:
> -       case BTF_KIND_ENUM64: {
> -               int name_off =3D t->name_off;
> -
> -               if (!from_ref && !name_off && btf_vlen(t))
> -                       name_off =3D btf_kind(t) =3D=3D BTF_KIND_ENUM64 ?
> -                               btf_enum64(t)->name_off :
> -                               btf_enum(t)->name_off;
> -
> -               return btf__name_by_offset(btf, name_off);
> -       }

Why remove this? anonymous enums will usually still have some
meaningful prefix for each enumerator value, and so sorting based on
those prefixes (effective) still seems useful for more logical
ordering

pw-bot: cr

>         case BTF_KIND_ARRAY:
>                 return btf_type_sort_name(btf, btf_array(t)->type, true);
>         case BTF_KIND_TYPE_TAG:
> @@ -584,20 +574,94 @@ static const char *btf_type_sort_name(const struct =
btf *btf, __u32 index, bool f
>         return NULL;
>  }
>
> +static __u64 hasher(__u64 hash, __u64 val)
> +{
> +       return hash * 31 + val;
> +}
> +
> +static __u64 btf_name_hasher(__u64 hash, const struct btf *btf, __u32 na=
me_off)
> +{
> +       if (!name_off)
> +               return hash;
> +
> +       return hasher(hash, str_hash(btf__name_by_offset(btf, name_off)))=
;
> +}
> +
> +static __u64 btf_type_disambig_hash(const struct btf *btf, __u32 index, =
bool include_members)

nit: s/index/id/ ?

> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, index);
> +       int i;
> +       size_t hash =3D 0;
> +
> +       hash =3D btf_name_hasher(hash, btf, t->name_off);
> +
> +       switch (btf_kind(t)) {
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +               for (i =3D 0; i < btf_vlen(t); i++) {
> +                       __u32 name_off =3D btf_is_enum(t) ?
> +                               btf_enum(t)[i].name_off :
> +                               btf_enum64(t)[i].name_off;
> +
> +                       hash =3D btf_name_hasher(hash, btf, name_off);
> +               }
> +               break;
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +               if (!include_members)
> +                       break;
> +               for (i =3D 0; i < btf_vlen(t); i++) {
> +                       const struct btf_member *m =3D btf_members(t) + i=
;
> +
> +                       hash =3D btf_name_hasher(hash, btf, m->name_off);
> +                       /* resolve field type's name and hash it as well =
*/
> +                       hash =3D hasher(hash, btf_type_disambig_hash(btf,=
 m->type, false));
> +               }
> +               break;
> +       case BTF_KIND_TYPE_TAG:
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_PTR:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_TYPEDEF:
> +       case BTF_KIND_DECL_TAG:
> +               hash =3D hasher(hash, btf_type_disambig_hash(btf, t->type=
, include_members));
> +               break;
> +       case BTF_KIND_ARRAY: {
> +               struct btf_array *arr =3D btf_array(t);
> +
> +               hash =3D hasher(hash, arr->nelems);
> +               hash =3D hasher(hash, btf_type_disambig_hash(btf, arr->ty=
pe, include_members));
> +               break;
> +       }
> +       default:
> +               break;
> +       }
> +       return hash;
> +}
> +
>  static int btf_type_compare(const void *left, const void *right)
>  {
>         const struct sort_datum *d1 =3D (const struct sort_datum *)left;
>         const struct sort_datum *d2 =3D (const struct sort_datum *)right;
>         int r;
>
> -       if (d1->type_rank !=3D d2->type_rank)
> -               return d1->type_rank < d2->type_rank ? -1 : 1;
> +       r =3D d1->type_rank - d2->type_rank;
> +       if (r)
> +               return r;
>
>         r =3D strcmp(d1->sort_name, d2->sort_name);
>         if (r)
>                 return r;
>
> -       return strcmp(d1->own_name, d2->own_name);
> +       r =3D strcmp(d1->own_name, d2->own_name);
> +       if (r)
> +               return r;

when I was playing with this code I had stong desire to do something
like below to cut down on visual noise

r =3D d1->type_rank - d2->type_rank;
r =3D r ?: strcmp(d1->sort_name, d2->sort_name);
r =3D r ?: strcmp(d1->own_name, d2->own_name);
if (r)
    return r;

WDYT?

> +
> +       if (d1->disambig_hash !=3D d2->disambig_hash)
> +               return d1->disambig_hash < d2->disambig_hash ? -1 : 1;
> +
> +       return d1->index - d2->index;
>  }
>
>  static struct sort_datum *sort_btf_c(const struct btf *btf)
> @@ -618,6 +682,7 @@ static struct sort_datum *sort_btf_c(const struct btf=
 *btf)
>                 d->type_rank =3D btf_type_rank(btf, i, false);
>                 d->sort_name =3D btf_type_sort_name(btf, i, false);
>                 d->own_name =3D btf__name_by_offset(btf, t->name_off);
> +               d->disambig_hash =3D btf_type_disambig_hash(btf, i, true)=
;
>         }
>
>         qsort(datums, n, sizeof(struct sort_datum), btf_type_compare);
> --
> 2.46.0
>

