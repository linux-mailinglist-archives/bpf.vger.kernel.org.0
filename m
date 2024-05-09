Return-Path: <bpf+bounces-29321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18988C185F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5446DB21EEB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62180126F2F;
	Thu,  9 May 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyRlRdLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DC85264
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290090; cv=none; b=lXwQcDilpIPOdNwZDiQJZ0eco+sgBDYq7XP6+oXZbKlDlYu4O1vic+n+nI+dStR5CAPjAR4SPXIqQUo+ZNy5YXXJlh+23dOqd/obcPhRZ2qymYhiPyYP7Q3dwpjc9lJjNwi6uIEljE7+YLSwHkquGQnXpF5d/M/wUXNKInLJ4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290090; c=relaxed/simple;
	bh=XMwGda2b+/1ErvDj0gIbxHl7JF5X+GbobVAVMHIcICI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJDVfGlDLC0E3XQSXsy8wNMjoGRJaHWwpgpgi/WZUHMHto2bXr+VqOkaWqBt9zqj6ufb9i9/UYxglbAP7mAveAPVv4ukascS5/pipKHgk49KeOvqvZxMzjC3U/dqf1BZbG906DKE/z+4wqrRfVAIcuo8bHT62vdYlr+bPWZ2234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyRlRdLb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so12072595ad.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715290088; x=1715894888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P2MD93L2U0QQ0Wo+xhzgVAE4+YqrcjU/tqSfMxGuqU=;
        b=gyRlRdLbqE4mw9Nip0SdxTLuRw+WKYqXYr8d5XXSNhdcXN6bHQlMon/PB2lvSqjj9f
         8iVXBWLI7Vr0aEpfjwI/AtQQYJWgtmpAEcyevThUS/wec7WLg3pqn37o1ABkZ5Eg+YXv
         pNU/mhzF7ChbXG2HYwXhd86SbwKQj4Ph9JFycPSufG0XM0aLmil8159dMYu7dWE0+EaU
         ZxXzGFRBg0uhtbwhjUMp6uDMudS2tlfTNXpKSM5qUlvTEwDk58FaWn8wrAe8EXu+RaWL
         ZREfHH1M6BLi6CFbBJSd1sGdLnChjDCmSXPR6n5wdvOlunDGRXpFrfZoA907LHT4n9uR
         LMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290088; x=1715894888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2P2MD93L2U0QQ0Wo+xhzgVAE4+YqrcjU/tqSfMxGuqU=;
        b=XmJJG3EGCzX4EPqmG3WsngJ2qOrtram6UjBurCCujEuKIxl1imxgX6OLj0EISazu3G
         ht/JZUGX87N1jnhl/KeTT4zvx2y4Lnv1Lv/NQAH33iQXYizeXDCMRChmWii0OU+NULXj
         7xO9Sa3LXsiZHjMDIwxvLPtydODUOJfkXDI0W0nRXLOljgyXVCOCfsCU8yhwqqeAIxO5
         QYkFaMDmNDns+tlyxA+UNMZmpqccpgXKjYBTyiINAuKqJnhrJHPAXQDzZAlMixu74yLz
         Hl4iYDs69Xn86SLN8NBH8k/CESbn3FSAkqLVlvOJCwJmQ3cegKDTy2eCYHe60v3+mSwr
         TVqg==
X-Forwarded-Encrypted: i=1; AJvYcCWcLigit/STItYIL/Ict7Jil4q6HzGw2WrCUGiVaMMGbpyPBH0IzSXzkr27jmv10qmMVnj06vZ4RK9nGIcQAvO22TiH
X-Gm-Message-State: AOJu0YypdFRWByMZksI8mPdGDvOADLHXGgrS0kALN1d/y/pjJ8X64B5p
	8grpKz+cIE7nvARYm/JJd2AHRZKCAfMixOOJHYkQgsxuxmxNeCE4QI1hNB/+ubjIN+QujQ8ZMTi
	ZZLPaB8c4zB21cfX3Mj9c4aQ/qSM=
X-Google-Smtp-Source: AGHT+IHAV9yxAbhCFztk/YnUe1PKdnzMORcv/Ai0h3FBFvDC4QxDt54/3aetoan9wW9Pw/8bpgHDQnIx+pYcISgBBEw=
X-Received: by 2002:a17:903:2452:b0:1ea:cc:e123 with SMTP id
 d9443c01a7336-1ef43f517e2mr11534135ad.46.1715290088366; Thu, 09 May 2024
 14:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509151744.131648-1-yatsenko@meta.com> <b43d0677-5018-45a1-8b0e-00bdc68a09af@oracle.com>
 <3999bafb-c64e-489f-a461-ac1a748abb6d@gmail.com>
In-Reply-To: <3999bafb-c64e-489f-a461-ac1a748abb6d@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 May 2024 14:27:56 -0700
Message-ID: <CAEf4Bza80pTpbTbKRUM9KkrdAtjgqfBb_6LJzE9H=baBrUJsjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, kernel-team@meta.com, qmo@kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:42=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 5/9/24 17:08, Alan Maguire wrote:
> > On 09/05/2024 16:17, Mykyta@web.codeaurora.org wrote:
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
> > This looks great! Not sure if you experimented with sorting for the
> > split BTF case (dumping /sys/kernel/btf/tun say); are there any
> > additional issues in doing that? From what I can see below the sort
> > would just be applied across base and split BTF and should just work, i=
s
> > that right? A few suggestions below, but
> This functionality is oblivious to split BTF, dumping
> /sys/kernel/btf/tun will
> sort all types across both base and split BTF, not distinguishing where
> those
> types come from.
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >
> >> ---
> >>   tools/bpf/bpftool/btf.c | 125 ++++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 122 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >> index 91fcb75babe3..09ecd2abf066 100644
> >> --- a/tools/bpf/bpftool/btf.c
> >> +++ b/tools/bpf/bpftool/btf.c
> >> @@ -43,6 +43,13 @@ static const char * const btf_kind_str[NR_BTF_KINDS=
] =3D {
> >>      [BTF_KIND_ENUM64]       =3D "ENUM64",
> >>   };
> >>
> >> +struct sort_datum {
> >> +    int index;
> >> +    int type_rank;
> >> +    const char *sort_name;
> >> +    const char *own_name;
> >> +};
> >> +
> >>   static const char *btf_int_enc_str(__u8 encoding)
> >>   {
> >>      switch (encoding) {
> >> @@ -460,11 +467,114 @@ static void __printf(2, 0) btf_dump_printf(void=
 *ctx,
> >>      vfprintf(stdout, fmt, args);
> >>   }
> >>
> >> +static bool is_reference_type(const struct btf_type *t)
> >> +{
> >> +    int kind =3D btf_kind(t);
> >> +
> >> +    return kind =3D=3D BTF_KIND_CONST || kind =3D=3D BTF_KIND_PTR || =
kind =3D=3D BTF_KIND_VOLATILE ||
> >> +            kind =3D=3D BTF_KIND_RESTRICT || kind =3D=3D BTF_KIND_ARR=
AY || kind =3D=3D BTF_KIND_TYPEDEF ||
> >> +            kind =3D=3D BTF_KIND_DECL_TAG;
> >> +}
> >> +
> >> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has=
_name)
> >> +{
> >> +    const struct btf_type *t =3D btf__type_by_id(btf, index);
> >> +    const int max_rank =3D 10;
> >> +    const int kind =3D btf_kind(t);
> >> +
> >> +    if (t->name_off)
> >> +            has_name =3D true;
> >> +
> >> +    switch (kind) {
> >> +    case BTF_KIND_ENUM:
> >> +    case BTF_KIND_ENUM64:
> >> +            return has_name ? 1 : 0;
> >> +    case BTF_KIND_INT:
> >> +    case BTF_KIND_FLOAT:
> >> +            return 2;
> >> +    case BTF_KIND_STRUCT:
> >> +    case BTF_KIND_UNION:
> >> +            return has_name ? 3 : max_rank;
> >> +    case BTF_KIND_FUNC_PROTO:
> >> +            return has_name ? 4 : max_rank;
> >> +
> > Don't think a FUNC_PROTO will ever have a name, so has_name check
> > probably not needed here.
> The reason for that check is to penalize FUNC_PROTO type (assign
> max_rank to it),
> but assign rank 4 to typedef type pointing to that FUNC_PROTO. You can
> see that
> for reference types this function is called recursively until
> non-reference type
> is reached, we assign non-maximum rank only if there was a named type alo=
ng
> the chain of recursive calls. Assigning rank 4 to FUNC_PROTO will lead
> to printing
> those function prototypes unordered, as their names are assigned to
> typedef type.
>
> >> +    default: {
> >> +            if (has_name && is_reference_type(t)) {
> >> +                    const int parent =3D kind =3D=3D BTF_KIND_ARRAY ?=
 btf_array(t)->type : t->type;
> >> +
> >> +                    return btf_type_rank(btf, parent, has_name);
> >> +            }
> >> +            return max_rank;
> >> +    }
> >> +    }
> >> +}
> >> +
> >> +static const char *btf_type_sort_name(const struct btf *btf, __u32 in=
dex)
> >> +{
> >> +    const struct btf_type *t =3D btf__type_by_id(btf, index);
> >> +    int kind =3D btf_kind(t);
> >> +
> >> +    /* Use name of the first element for anonymous enums */
> >> +    if (!t->name_off && (kind =3D=3D BTF_KIND_ENUM || kind =3D=3D BTF=
_KIND_ENUM64) &&
> >> +        BTF_INFO_VLEN(t->info))
> >> +            return btf__name_by_offset(btf, btf_enum(t)->name_off);
> >> +
> >> +    /* Return base type name for reference types */
> >> +    while (is_reference_type(t)) {
> > The two times is_reference_type() is used, we use this conditional to
> > get the array type; worth rolling this into a get_reference_type(t)
> > function that returns t->type for reference types, btf_array(t)->type
> > for arrays and -1 otherwise perhaps?
> Agree.

I'd use 0, it can mean both "not valid type ID", but also doesn't need
extra checking because it's still a valid type if you need to get
btf__type_by_id() (you'll get VOID type) and/or get it's name (it will
be an empty name).

> >
> >> +            index =3D btf_kind(t) =3D=3D BTF_KIND_ARRAY ? btf_array(t=
)->type : t->type;
> >> +            t =3D btf__type_by_id(btf, index);
> >> +    }
> >> +
> >> +    return btf__name_by_offset(btf, t->name_off);
> >> +}
> >> +
> >> +static int btf_type_compare(const void *left, const void *right)
> >> +{
> >> +    const struct sort_datum *datum1 =3D (const struct sort_datum *)le=
ft;
> >> +    const struct sort_datum *datum2 =3D (const struct sort_datum *)ri=
ght;
> >> +    int sort_name_cmp;
> >> +
> >> +    if (datum1->type_rank !=3D datum2->type_rank)
> >> +            return datum1->type_rank < datum2->type_rank ? -1 : 1;
> >> +
> >> +    sort_name_cmp =3D strcmp(datum1->sort_name, datum2->sort_name);
> >> +    if (sort_name_cmp)
> >> +            return sort_name_cmp;
> >> +
> >> +    return strcmp(datum1->own_name, datum2->own_name);
> >> +}
> >> +
> >> +static struct sort_datum *sort_btf_c(const struct btf *btf)
> >> +{
> >> +    int total_root_types;
> >> +    struct sort_datum *datums;
> >> +
> >> +    total_root_types =3D btf__type_cnt(btf);
> >> +    datums =3D malloc(sizeof(struct sort_datum) * total_root_types);
> > calloc(total_root_types, sizeof(*datums)) will get you a
> > zero-initialized array, which may be useful below...
> >
> >> +    if (!datums)
> >> +            return NULL;
> >> +
> >> +    for (int i =3D 0; i < total_root_types; ++i) {
> > you're starting from zero here so you'll get &btf_void below; if you
> > zero-initialize above I think you can just start from 1.
> >
> >> +            struct sort_datum *current_datum =3D datums + i;
> >> +            const struct btf_type *t =3D btf__type_by_id(btf, i);
> >> +
> >> +            current_datum->index =3D i;
> >> +            current_datum->type_rank =3D btf_type_rank(btf, i, false)=
;
> >> +            current_datum->sort_name =3D btf_type_sort_name(btf, i);
> >> +            current_datum->own_name =3D btf__name_by_offset(btf, t->n=
ame_off);
> >> +    }
> >> +
> >> +    qsort(datums, total_root_types, sizeof(struct sort_datum), btf_ty=
pe_compare);
> >> +
> >> +    return datums;
> >> +}
> >> +
> >>   static int dump_btf_c(const struct btf *btf,
> >> -                  __u32 *root_type_ids, int root_type_cnt)
> >> +                  __u32 *root_type_ids, int root_type_cnt, bool sort_=
dump)
> >>   {
> >>      struct btf_dump *d;
> >>      int err =3D 0, i;
> >> +    struct sort_datum *datums =3D NULL;
> >>
> >>      d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> >>      if (!d)
> >> @@ -486,8 +596,12 @@ static int dump_btf_c(const struct btf *btf,
> >>      } else {
> >>              int cnt =3D btf__type_cnt(btf);
> >>
> >> +            if (sort_dump)
> >> +                    datums =3D sort_btf_c(btf);
> >>              for (i =3D 1; i < cnt; i++) {
> >> -                    err =3D btf_dump__dump_type(d, i);
> >> +                    int idx =3D datums ? datums[i].index : i;
> >> +
> >> +                    err =3D btf_dump__dump_type(d, idx);
> >>                      if (err)
> >>                              goto done;
> >>              }
> >> @@ -501,6 +615,7 @@ static int dump_btf_c(const struct btf *btf,
> >>
> >>   done:
> >>      btf_dump__free(d);
> >> +    free(datums);
> >>      return err;
> >>   }
> >>
> >> @@ -553,6 +668,7 @@ static int do_dump(int argc, char **argv)
> >>      __u32 root_type_ids[2];
> >>      int root_type_cnt =3D 0;
> >>      bool dump_c =3D false;
> >> +    bool sort_dump_c =3D true;
> >>      __u32 btf_id =3D -1;
> >>      const char *src;
> >>      int fd =3D -1;
> >> @@ -663,6 +779,9 @@ static int do_dump(int argc, char **argv)
> >>                              goto done;
> >>                      }
> >>                      NEXT_ARG();
> >> +            } else if (is_prefix(*argv, "unordered")) {
> > you'll need to update the man page and add to the bash completion for
> > this new argument I think.
> >
> >> +                    sort_dump_c =3D false;
> >> +                    NEXT_ARG();
> >>              } else {
> >>                      p_err("unrecognized option: '%s'", *argv);
> >>                      err =3D -EINVAL;
> >> @@ -691,7 +810,7 @@ static int do_dump(int argc, char **argv)
> >>                      err =3D -ENOTSUP;
> >>                      goto done;
> >>              }
> >> -            err =3D dump_btf_c(btf, root_type_ids, root_type_cnt);
> >> +            err =3D dump_btf_c(btf, root_type_ids, root_type_cnt, sor=
t_dump_c);
> >>      } else {
> >>              err =3D dump_btf_raw(btf, root_type_ids, root_type_cnt);
> >>      }
>
>

