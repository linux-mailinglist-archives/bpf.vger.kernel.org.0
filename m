Return-Path: <bpf+bounces-29333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48478C19D3
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE51F23E71
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9312D770;
	Thu,  9 May 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRQsItIB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130012D75A
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296455; cv=none; b=AbMsBbP9KEHoQywVcPNRsxnngRK8i6fmGIO9zMkMykEflFISNTRvSDUFywLqN2FKX/vxx/JlnZjXcm6ciiO0mjgEfF3TYdIKvv0AE3pLnZkzluWUbvvHuTr5Wi5LXEr1R1ii4zKIJ3vbYCRgyI7GWZIebgP3Wm46L4Z0l6h6+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296455; c=relaxed/simple;
	bh=A8+SGOh8d1PgCnpRiPdUL9QkVm/2V4Vw5kIb0ceDank=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHOQETm95/FT5jeheXN/5c7zCiRMOWAM/bWo24sBgtQsKySK7QB2rYth522ufMh5UJHH0YCWYQMiEDzWnSDMXB1LW7Vg27jUUkGyB0ph6Q+VYxBu8J0afsHgnD8jlOPZhtsdzS2zPd78YX6VYb0+MYtIiy7ik6TfgLbnwn6dhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRQsItIB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso1292392b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715296453; x=1715901253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+ioWwYGy0zyZyut8t3v8aeGRGcDjM5skj5kaAqXvIs=;
        b=dRQsItIB0MctRWDirfZDqOYM7hRBZP9Ar6grNH2PPQT8X++SFKgKBlXGtnpvO/79rw
         JpNbwR/pNFHwoxQ58vXR7kLmNNtyLj6hYM755c2erjY1rKINSt+CBztHINPL46yTtNxp
         S7FiWBlDZ5ZopGYQhULcnDKYXGEAlO3tFNA3QazzrWcJXWFAaiqLbZtP74cphHQ/VQZ2
         96zMdHXXsdSBvh/1MSM08Yy19RemDnec2MHhgxnAawVK/FvlkWwszp7QxjDdyapKR/hA
         rNRkzN5vESKXFp+WhKhYnIPIEKiXyNk/HD+wE1bvhW+uCn8uPEO9pgxiHcDCQzjo+tpb
         rc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715296453; x=1715901253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+ioWwYGy0zyZyut8t3v8aeGRGcDjM5skj5kaAqXvIs=;
        b=ett2JCHQb7HujrlPpp/YZMJY9Y/1kEdaHGUiGDCZukSj31/cjz8u7BQAYz3sVfSnRt
         wAiaj5ZOIbwwp6zjiDAecT512qqtFwWlss1M71HJoV53LNce9VQXdtdWsKtA92rVhsGp
         bvywg1WAxhY3wuyZLL/MQ1BeXqIe+LtI1PJyGHi06JwusdEjIz+TMgpJN7KRGxbmoULf
         SRBOu/GX+JfV010BZszWQE0LSQRhDcHQCsqoHY/XyQFvOkwdBq3y3SbzS1VZ5l6+So7Q
         CK/2lNGtIQ95Fms7sVeMFL+FVVXNSOUZ6T1S/b21LwsddYYbdmhGwE2gnDr/hcb9eu9t
         bRcw==
X-Forwarded-Encrypted: i=1; AJvYcCWVFUm1AGwhd3BETv1fY/Q8u8mHUST/WvZo9Xjw4M83wuDbm+U1qsI3rUzQ3STIeJ8j5hyvH8BmUEx33uqp892zFJf0
X-Gm-Message-State: AOJu0YwnEPoMjwpDwp5E/F1zBZtnvi7YOQHD1ogK7e5GRbyIXUiHj3jL
	PgHJjFoRpnbJ2amV/gzlCYkC75llcABgQ59PJFgW5bzrr7uPUj72Dn/qZ7O6VAmFlFbb7ngv9dl
	bqo3AppfjxIhnTuiSGt7FArVLpH0=
X-Google-Smtp-Source: AGHT+IGRZmAhMLt3FT/uU2kwL7Ey3KPgGl/L/wxIvavOxZUMAoSQ7T3JUnhW3WDBDYNXcIwenxlNiWvUF+9NQYvy77E=
X-Received: by 2002:a05:6a20:f3a3:b0:1af:acd5:b462 with SMTP id
 adf61e73a8af0-1afde201cbdmr1170767637.50.1715296453136; Thu, 09 May 2024
 16:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509151744.131648-1-yatsenko@meta.com> <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
 <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
In-Reply-To: <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 May 2024 16:14:01 -0700
Message-ID: <CAEf4BzYfdy7govH-3+Sr2_q+Fu29DEgvJigOEAX86aLgVTAvRg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 4:09=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> On 09/05/2024 22:39, Andrii Nakryiko wrote:
> > On Thu, May 9, 2024 at 8:17=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Sort bpftool c dump output; aiming to simplify vmlinux.h diffing and
> >> forcing more natural type definitions ordering.
> >>
> >> Definitions are sorted first by their BTF kind ranks, then by their ba=
se
> >> type name and by their own name.
> >>
> >> Type ranks
> >>
> >> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> >> next order:
> >> 1. Anonymous enums/enums64
> >> 2. Named enums/enums64
> >> 3. Trivial types typedefs (ints, then floats)
> >> 4. Structs/Unions
> >> 5. Function prototypes
> >> 6. Forward declarations
> >>
> >> Type rank is set to maximum for unnamed reference types, structs and
> >> unions to avoid emitting those types early. They will be emitted as
> >> part of the type chain starting with named type.
> >>
> >> Lexicographical ordering
> >>
> >> Each type is assigned a sort_name and own_name.
> >> sort_name is the resolved name of the final base type for reference
> >> types (typedef, pointer, array etc). Sorting by sort_name allows to
> >> group typedefs of the same base type. sort_name for non-reference type
> >> is the same as own_name. own_name is a direct name of particular type,
> >> is used as final sorting step.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/bpf/bpftool/btf.c | 125 +++++++++++++++++++++++++++++++++++++++=
-
> >>  1 file changed, 122 insertions(+), 3 deletions(-)
> >>
> >
> > It's getting very close, see a bunch of nits below.
>
> Agreed, it's in a nice shape, thanks a lot for this work. Apologies for
> the review delay, I just have a few additional nits.
>
> >
> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >> index 91fcb75babe3..09ecd2abf066 100644
> >> --- a/tools/bpf/bpftool/btf.c
> >> +++ b/tools/bpf/bpftool/btf.c
> >> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS=
] =3D {
> >>         [BTF_KIND_ENUM64]       =3D "ENUM64",
> >>  };
> >>
> >> +struct sort_datum {
> >> +       int index;
> >> +       int type_rank;
> >> +       const char *sort_name;
> >> +       const char *own_name;
> >> +};
> >> +
> >>  static const char *btf_int_enc_str(__u8 encoding)
> >>  {
> >>         switch (encoding) {
> >> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void=
 *ctx,
> >>         vfprintf(stdout, fmt, args);
> >>  }
> >>
> >> +static bool is_reference_type(const struct btf_type *t)
> >> +{
> >> +       int kind =3D btf_kind(t);
> >> +
> >> +       return kind =3D=3D BTF_KIND_CONST || kind =3D=3D BTF_KIND_PTR =
|| kind =3D=3D BTF_KIND_VOLATILE ||
> >> +               kind =3D=3D BTF_KIND_RESTRICT || kind =3D=3D BTF_KIND_=
ARRAY || kind =3D=3D BTF_KIND_TYPEDEF ||
> >> +               kind =3D=3D BTF_KIND_DECL_TAG;
> >
> > probably best to write as a switch, also make sure that
> > BTF_KIND_TYPE_TAG is supported, it is effectively treated as
> > CONST/VOLATILE
> >
> > and actually looking below, I'd just incorporate these as extra cases
> > in the existing btf_type_rank() switch, and then have a similar
> > open-coded switch for btf_type_sort_name()
> >
> > When dealing with BTF I find these explicit switches listing what
> > kinds are special and how they are processed much easier to check and
> > follow than any of the extra helpers doing some kind checks
> >
> >
> >> +}
> >> +
> >> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has=
_name)
> >> +{
> >> +       const struct btf_type *t =3D btf__type_by_id(btf, index);
> >> +       const int max_rank =3D 10;
> >> +       const int kind =3D btf_kind(t);
> >> +
> >> +       if (t->name_off)
> >> +               has_name =3D true;
> >> +
> >> +       switch (kind) {
> >> +       case BTF_KIND_ENUM:
> >> +       case BTF_KIND_ENUM64:
> >> +               return has_name ? 1 : 0;
> >> +       case BTF_KIND_INT:
> >> +       case BTF_KIND_FLOAT:
> >> +               return 2;
> >> +       case BTF_KIND_STRUCT:
> >> +       case BTF_KIND_UNION:
> >> +               return has_name ? 3 : max_rank;
> >> +       case BTF_KIND_FUNC_PROTO:
> >> +               return has_name ? 4 : max_rank;
> >> +
> >> +       default: {
> >> +               if (has_name && is_reference_type(t)) {
> >> +                       const int parent =3D kind =3D=3D BTF_KIND_ARRA=
Y ? btf_array(t)->type : t->type;
> >> +
> >> +                       return btf_type_rank(btf, parent, has_name);
> >> +               }
> >> +               return max_rank;
> >> +       }
> >
> > nit: you don't need these {} for default
> >
> >> +       }
> >> +}
> >> +
> >> +static const char *btf_type_sort_name(const struct btf *btf, __u32 in=
dex)
> >> +{
> >> +       const struct btf_type *t =3D btf__type_by_id(btf, index);
> >> +       int kind =3D btf_kind(t);
> >> +
> >> +       /* Use name of the first element for anonymous enums */
> >> +       if (!t->name_off && (kind =3D=3D BTF_KIND_ENUM || kind =3D=3D =
BTF_KIND_ENUM64) &&
> >
> > there is btf_is_any_enum() helper for this kind check
> >
> >> +           BTF_INFO_VLEN(t->info))
> >
> > please use btf_vlen(t) helper
> >
> >> +               return btf__name_by_offset(btf, btf_enum(t)->name_off)=
;
> >
> > what if enum's vlen =3D=3D 0? I think I mentioned that before, it
> > shouldn't happen in valid BTF, but it's technically allowable in BTF,
> > so best to be able to handle that instead of crashing or doing random
> > memory reads.
> >
> >> +
> >> +       /* Return base type name for reference types */
> >> +       while (is_reference_type(t)) {
> >> +               index =3D btf_kind(t) =3D=3D BTF_KIND_ARRAY ? btf_arra=
y(t)->type : t->type;
> >> +               t =3D btf__type_by_id(btf, index);
> >> +       }
> >> +
> >> +       return btf__name_by_offset(btf, t->name_off);
> >> +}
> >> +
> >> +static int btf_type_compare(const void *left, const void *right)
> >> +{
> >> +       const struct sort_datum *datum1 =3D (const struct sort_datum *=
)left;
> >> +       const struct sort_datum *datum2 =3D (const struct sort_datum *=
)right;
> >> +       int sort_name_cmp;
> >
> > stylistic nit: it's minot, but I'd use less distracting naming. Eg., d1=
, d2, r.
> >
> >> +
> >> +       if (datum1->type_rank !=3D datum2->type_rank)
> >> +               return datum1->type_rank < datum2->type_rank ? -1 : 1;
> >> +
> >> +       sort_name_cmp =3D strcmp(datum1->sort_name, datum2->sort_name)=
;
> >> +       if (sort_name_cmp)
> >> +               return sort_name_cmp;
> >> +
> >> +       return strcmp(datum1->own_name, datum2->own_name);
> >> +}
> >> +
> >> +static struct sort_datum *sort_btf_c(const struct btf *btf)
> >> +{
> >> +       int total_root_types;
> >> +       struct sort_datum *datums;
> >> +
> >> +       total_root_types =3D btf__type_cnt(btf);
> >
> > nit: s/total_root_types/n/
> >
> >> +       datums =3D malloc(sizeof(struct sort_datum) * total_root_types=
);
> >> +       if (!datums)
> >> +               return NULL;
> >> +
> >> +       for (int i =3D 0; i < total_root_types; ++i) {
> >> +               struct sort_datum *current_datum =3D datums + i;
> >
> > nit: just d for the name, it's not going to be hard to follow or ambigu=
ous
> >
> >> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> >> +
> >> +               current_datum->index =3D i;
> >> +               current_datum->type_rank =3D btf_type_rank(btf, i, fal=
se);
> >> +               current_datum->sort_name =3D btf_type_sort_name(btf, i=
);
> >> +               current_datum->own_name =3D btf__name_by_offset(btf, t=
->name_off);
> >> +       }
> >> +
> >> +       qsort(datums, total_root_types, sizeof(struct sort_datum), btf=
_type_compare);
> >> +
> >> +       return datums;
> >> +}
> >> +
> >>  static int dump_btf_c(const struct btf *btf,
> >> -                     __u32 *root_type_ids, int root_type_cnt)
> >> +                     __u32 *root_type_ids, int root_type_cnt, bool so=
rt_dump)
> >>  {
> >>         struct btf_dump *d;
> >>         int err =3D 0, i;
> >> +       struct sort_datum *datums =3D NULL;
>
> Nit: Most variables in the file are declared in "reverse-Christmas-tree"
> order (longest lines first, unless there's a reason not to). Could you
> please try to preserve this order, here and elsewhere, for consistency?
>
> >>
> >>         d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> >>         if (!d)
> >> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
> >>         } else {
> >>                 int cnt =3D btf__type_cnt(btf);
> >>
> >> +               if (sort_dump)
> >> +                       datums =3D sort_btf_c(btf);
> >>                 for (i =3D 1; i < cnt; i++) {
> >> -                       err =3D btf_dump__dump_type(d, i);
> >> +                       int idx =3D datums ? datums[i].index : i;
> >> +
> >> +                       err =3D btf_dump__dump_type(d, idx);
> >>                         if (err)
> >>                                 goto done;
> >>                 }
> >> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
> >>
> >>  done:
> >>         btf_dump__free(d);
> >> +       free(datums);
>
> Small nit: I'd swap the two lines above, it would seem more logical to
> free in the reverse order from allocation and would be more
> straightforward to "split" if we ever need to free d only when jumping
> from the first goto.
>
> >>         return err;
> >>  }
> >>
> >> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
> >>         __u32 root_type_ids[2];
> >>         int root_type_cnt =3D 0;
> >>         bool dump_c =3D false;
> >> +       bool sort_dump_c =3D true;
> >>         __u32 btf_id =3D -1;
> >>         const char *src;
> >>         int fd =3D -1;
> >> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
> >>                                 goto done;
> >>                         }
> >>                         NEXT_ARG();
> >> +               } else if (is_prefix(*argv, "unordered")) {
> >
> > it's more of a "original order" rather than unordered, so maybe "unnorm=
alized"?
> I'd have gone with "unsorted", but Andrii's reasoning probably applies

unsorted also makes sense, let's go with that, it's a single word

> the same to it. I find "unnormalized" might be difficult to understand,
> maybe "preserve_order" or, shorter, "keep_order"?
>
> And as Alan mentioned on the other thread, we'll need the following
> updates for the new keyword:
>
> - Adding the keyword to the command summary at the top of
>   tools/bpf/bpftool/Documentation/bpftool-btf.rst:
>   | *FORMAT* :=3D { **raw** | **c** [**unordered**]}
>   (or whatever keyword we pick)
> - Adding the description for the keyword, below on the same page
> - Adding the keyword to the help message, at the end of btf.c
> - Updating the bash completion. The patch below should work (to adjust
>   with the final keyword):
>
> ------
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index 04afe2ac2228..85a43c867e5f 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -930,6 +930,9 @@ _bpftool()
>                          format)
>                              COMPREPLY=3D( $( compgen -W "c raw" -- "$cur=
" ) )
>                              ;;
> +                        c)
> +                            COMPREPLY=3D( $( compgen -W "unordered" -- "=
$cur" ) )
> +                            ;;
>                          *)
>                              # emit extra options
>                              case ${words[3]} in
> ------

