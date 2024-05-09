Return-Path: <bpf+bounces-29322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C218C1890
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489381C21C7F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379185653;
	Thu,  9 May 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jrmudwbi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89761A2C03
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290793; cv=none; b=b6ALiE7damLum/t3ps9cTHjlde2ShIrXosJxlqm/Tx7VR6JaGjm2plwn7KO+bmWJmrrStj4EfJtwYDlin2S4JPlv+8sfTfX0Wso/TJtoC9BYI4km/gt4KM7Gl0wVFU1+qHe9kBQ8ej0zQFLyzixDYQtQ4uWkfiA7NTrJSeXygks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290793; c=relaxed/simple;
	bh=2m9p783/ja6HmLCp0rUyPGwIDgi2DhOxIUk+frljNj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itevgQ2INGgoLDS74I2vGa5MoJFMsIdzMEd/KUU20AcF/3fVW0qvk4q/NGdbFcUcdUHBpVwLDblGVtrM4lq3rO5sM5IfF4p8JyXicT35flkw1ekk2N8V3MCg13KNjsqg3g1tmmZ0xYSdO/b8NQozZae+iGu+2Sb7yCZf3SXuBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jrmudwbi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b338460546so1091854a91.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715290791; x=1715895591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViO21zRpd7JrG71Nf6OyyYZ+fqQaBurLRgX16wzNXZM=;
        b=Jrmudwbien7mqd52ajWVt1GDYvQVUNjyVv/TSDP9WDVYhUhSf+BFRpT2GEyM/wgIEJ
         BZ0exJBl0gybZRSiUkOT0lrdXtxRKbWmC1vIuCfb4lMlWGD4HmhcdA6N6zhvfPfBeK2B
         qhtODcWq4JdY+zUu7BCcxSt2te4/kqAzoY7FpS2YGbRV+N5PpaIx0tUPSCyJuymGjSw6
         TPxHY9mRrdv6RkuabaB4dq/yjRWxSKw6zrhX0DA6vccJrkZRbzEsVCNd8nlnOdW06+Qj
         nHDoPFgmM8pBN1V77a+FRQZS0ei0K9/Ybpyu+EGQoPP7Etn4iiQbD1BiAP6jNglGIMwN
         Hk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290791; x=1715895591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViO21zRpd7JrG71Nf6OyyYZ+fqQaBurLRgX16wzNXZM=;
        b=eHBGty7EAALfJpCzrzU9Cn0LApBsX4IFW35tHD3u56aOwITB/r2FCJ0UIB5V2xsMa8
         XPC1xWGpS/UIgZPO6GvRj2pduryyqaenN22Ur2Nkga12zFPeMjsxkQzEltnIdt+dXfPC
         lUb3esvSqRP3GddzJkHpV+SUy6xv/0dJzua1KAxKLeYtfYNNosa/Gq/XBTEAJW1KrUxv
         G2RxxZaibSebLTVfmHowiPUxEN0WSP4ytiv43QO2qncEyIk3CrvpPHajHKmySUJ721wW
         a75ggDXzN6PlP25EtJ4cT2Eu5uXYWx5GCRxsUGUIpntvrdkzIe6g6saRtgnzRUCGAM8W
         qViw==
X-Gm-Message-State: AOJu0Yzj/6QNRdxcw4i2B3BUrFeCsU3HTX8XfEaQ+l5AGU69EKETMRAw
	6mEW7/Y3NJqfIah+wI06lzD531UZBY4hrCWW8KM2RDL1Un2INwGc7CD5osls7hZ9oQV0OUiytHR
	upW0JdWcuvp8jMIWHQzvx+BeKCqU=
X-Google-Smtp-Source: AGHT+IFCuqOu2FeBGhYfmpOBP0+aQ4hPy87Mk53pA1WOodLO0YZTBfn7IDMDmaywhY86Nbej04WlH8yj1R4pRyATbFg=
X-Received: by 2002:a17:90a:d30c:b0:2ae:b8df:89e7 with SMTP id
 98e67ed59e1d1-2b6ccd7fbf3mr801414a91.38.1715290790837; Thu, 09 May 2024
 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509151744.131648-1-yatsenko@meta.com>
In-Reply-To: <20240509151744.131648-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 May 2024 14:39:38 -0700
Message-ID: <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kernel-team@meta.com, qmo@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:17=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> forcing more natural type definitions ordering.
>
> Definitions are sorted first by their BTF kind ranks, then by their base
> type name and by their own name.
>
> Type ranks
>
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums/enums64
> 2. Named enums/enums64
> 3. Trivial types typedefs (ints, then floats)
> 4. Structs/Unions
> 5. Function prototypes
> 6. Forward declarations
>
> Type rank is set to maximum for unnamed reference types, structs and
> unions to avoid emitting those types early. They will be emitted as
> part of the type chain starting with named type.
>
> Lexicographical ordering
>
> Each type is assigned a sort_name and own_name.
> sort_name is the resolved name of the final base type for reference
> types (typedef, pointer, array etc). Sorting by sort_name allows to
> group typedefs of the same base type. sort_name for non-reference type
> is the same as own_name. own_name is a direct name of particular type,
> is used as final sorting step.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 3 deletions(-)
>

It's getting very close, see a bunch of nits below.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..09ecd2abf066 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
>         [BTF_KIND_ENUM64]       =3D "ENUM64",
>  };
>
> +struct sort_datum {
> +       int index;
> +       int type_rank;
> +       const char *sort_name;
> +       const char *own_name;
> +};
> +
>  static const char *btf_int_enc_str(__u8 encoding)
>  {
>         switch (encoding) {
> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void *c=
tx,
>         vfprintf(stdout, fmt, args);
>  }
>
> +static bool is_reference_type(const struct btf_type *t)
> +{
> +       int kind =3D btf_kind(t);
> +
> +       return kind =3D=3D BTF_KIND_CONST || kind =3D=3D BTF_KIND_PTR || =
kind =3D=3D BTF_KIND_VOLATILE ||
> +               kind =3D=3D BTF_KIND_RESTRICT || kind =3D=3D BTF_KIND_ARR=
AY || kind =3D=3D BTF_KIND_TYPEDEF ||
> +               kind =3D=3D BTF_KIND_DECL_TAG;

probably best to write as a switch, also make sure that
BTF_KIND_TYPE_TAG is supported, it is effectively treated as
CONST/VOLATILE

and actually looking below, I'd just incorporate these as extra cases
in the existing btf_type_rank() switch, and then have a similar
open-coded switch for btf_type_sort_name()

When dealing with BTF I find these explicit switches listing what
kinds are special and how they are processed much easier to check and
follow than any of the extra helpers doing some kind checks


> +}
> +
> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_na=
me)
> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, index);
> +       const int max_rank =3D 10;
> +       const int kind =3D btf_kind(t);
> +
> +       if (t->name_off)
> +               has_name =3D true;
> +
> +       switch (kind) {
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +               return has_name ? 1 : 0;
> +       case BTF_KIND_INT:
> +       case BTF_KIND_FLOAT:
> +               return 2;
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION:
> +               return has_name ? 3 : max_rank;
> +       case BTF_KIND_FUNC_PROTO:
> +               return has_name ? 4 : max_rank;
> +
> +       default: {
> +               if (has_name && is_reference_type(t)) {
> +                       const int parent =3D kind =3D=3D BTF_KIND_ARRAY ?=
 btf_array(t)->type : t->type;
> +
> +                       return btf_type_rank(btf, parent, has_name);
> +               }
> +               return max_rank;
> +       }

nit: you don't need these {} for default

> +       }
> +}
> +
> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index=
)
> +{
> +       const struct btf_type *t =3D btf__type_by_id(btf, index);
> +       int kind =3D btf_kind(t);
> +
> +       /* Use name of the first element for anonymous enums */
> +       if (!t->name_off && (kind =3D=3D BTF_KIND_ENUM || kind =3D=3D BTF=
_KIND_ENUM64) &&

there is btf_is_any_enum() helper for this kind check

> +           BTF_INFO_VLEN(t->info))

please use btf_vlen(t) helper

> +               return btf__name_by_offset(btf, btf_enum(t)->name_off);

what if enum's vlen =3D=3D 0? I think I mentioned that before, it
shouldn't happen in valid BTF, but it's technically allowable in BTF,
so best to be able to handle that instead of crashing or doing random
memory reads.

> +
> +       /* Return base type name for reference types */
> +       while (is_reference_type(t)) {
> +               index =3D btf_kind(t) =3D=3D BTF_KIND_ARRAY ? btf_array(t=
)->type : t->type;
> +               t =3D btf__type_by_id(btf, index);
> +       }
> +
> +       return btf__name_by_offset(btf, t->name_off);
> +}
> +
> +static int btf_type_compare(const void *left, const void *right)
> +{
> +       const struct sort_datum *datum1 =3D (const struct sort_datum *)le=
ft;
> +       const struct sort_datum *datum2 =3D (const struct sort_datum *)ri=
ght;
> +       int sort_name_cmp;

stylistic nit: it's minot, but I'd use less distracting naming. Eg., d1, d2=
, r.

> +
> +       if (datum1->type_rank !=3D datum2->type_rank)
> +               return datum1->type_rank < datum2->type_rank ? -1 : 1;
> +
> +       sort_name_cmp =3D strcmp(datum1->sort_name, datum2->sort_name);
> +       if (sort_name_cmp)
> +               return sort_name_cmp;
> +
> +       return strcmp(datum1->own_name, datum2->own_name);
> +}
> +
> +static struct sort_datum *sort_btf_c(const struct btf *btf)
> +{
> +       int total_root_types;
> +       struct sort_datum *datums;
> +
> +       total_root_types =3D btf__type_cnt(btf);

nit: s/total_root_types/n/

> +       datums =3D malloc(sizeof(struct sort_datum) * total_root_types);
> +       if (!datums)
> +               return NULL;
> +
> +       for (int i =3D 0; i < total_root_types; ++i) {
> +               struct sort_datum *current_datum =3D datums + i;

nit: just d for the name, it's not going to be hard to follow or ambiguous

> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +
> +               current_datum->index =3D i;
> +               current_datum->type_rank =3D btf_type_rank(btf, i, false)=
;
> +               current_datum->sort_name =3D btf_type_sort_name(btf, i);
> +               current_datum->own_name =3D btf__name_by_offset(btf, t->n=
ame_off);
> +       }
> +
> +       qsort(datums, total_root_types, sizeof(struct sort_datum), btf_ty=
pe_compare);
> +
> +       return datums;
> +}
> +
>  static int dump_btf_c(const struct btf *btf,
> -                     __u32 *root_type_ids, int root_type_cnt)
> +                     __u32 *root_type_ids, int root_type_cnt, bool sort_=
dump)
>  {
>         struct btf_dump *d;
>         int err =3D 0, i;
> +       struct sort_datum *datums =3D NULL;
>
>         d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
>         if (!d)
> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
>         } else {
>                 int cnt =3D btf__type_cnt(btf);
>
> +               if (sort_dump)
> +                       datums =3D sort_btf_c(btf);
>                 for (i =3D 1; i < cnt; i++) {
> -                       err =3D btf_dump__dump_type(d, i);
> +                       int idx =3D datums ? datums[i].index : i;
> +
> +                       err =3D btf_dump__dump_type(d, idx);
>                         if (err)
>                                 goto done;
>                 }
> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
>
>  done:
>         btf_dump__free(d);
> +       free(datums);
>         return err;
>  }
>
> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
>         __u32 root_type_ids[2];
>         int root_type_cnt =3D 0;
>         bool dump_c =3D false;
> +       bool sort_dump_c =3D true;
>         __u32 btf_id =3D -1;
>         const char *src;
>         int fd =3D -1;
> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
>                                 goto done;
>                         }
>                         NEXT_ARG();
> +               } else if (is_prefix(*argv, "unordered")) {

it's more of a "original order" rather than unordered, so maybe "unnormaliz=
ed"?

> +                       sort_dump_c =3D false;
> +                       NEXT_ARG();
>                 } else {
>                         p_err("unrecognized option: '%s'", *argv);
>                         err =3D -EINVAL;
> @@ -691,7 +810,7 @@ static int do_dump(int argc, char **argv)
>                         err =3D -ENOTSUP;
>                         goto done;
>                 }
> -               err =3D dump_btf_c(btf, root_type_ids, root_type_cnt);
> +               err =3D dump_btf_c(btf, root_type_ids, root_type_cnt, sor=
t_dump_c);
>         } else {
>                 err =3D dump_btf_raw(btf, root_type_ids, root_type_cnt);
>         }
> --
> 2.44.0
>

