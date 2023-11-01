Return-Path: <bpf+bounces-13839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C137DE7C1
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B43B21085
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE591BDC9;
	Wed,  1 Nov 2023 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX+pbotj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C023BC
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:57:08 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF311D
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:57:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9db6cf8309cso19089866b.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698875824; x=1699480624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8n7sjbdkfiFNaANRvbHNEUeFYp9l2qRDhgQ3F0UfcU=;
        b=fX+pbotjbc9ssNFpeLq6vzl9DQoUxXur9hkPw/lxfQlFvqSTjmrFZ54J4VzLeqV6If
         2lVGKlSIjOJVOEcgqo35Vk4JGALwtjMGNltXqJzhznO5pNOhhti0BTW6HxTfX11w6F3h
         r4Ur9GOoIGc3hM7+GhauekaluNLgvcMXRfPOyijDew/5pQNTGswOcAZY3oaSFPUlZLxm
         ap5vSiZF+xLCHG2TAEv9MLiAOmSU75KdFEcMz/1OrD1z/f9pXMCAzR4CWyMKkW02BQZU
         5Udy/zmFHqQj31LKf3WUSnexjpq2Nz6GW0gb6WRc0pDFxZTQw/13GPiQMs8MtqRa7jLd
         F4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875824; x=1699480624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8n7sjbdkfiFNaANRvbHNEUeFYp9l2qRDhgQ3F0UfcU=;
        b=pksugSgwokqBcHVRiwdIHJeYpGwE3oZqBlRnus9bTSnqC++s+5xP0RPn92LbKHcyLx
         ZINIoR2pzlCSuS6T54sQxcDbmw9+LfSy+YZroyYwFlK2xsvM6wAHvGIC3KmXKDdR54GD
         w5JX6b8Zou5Nlqd6jNm8jV2wASZ/UMQ5SXAMlWOeXSGAnvSvK/F+PMiO6UeG8Ti649ur
         e24Bat2BNNstPnZFpqIH/rMDHE2tebeyGf6SmDIirjgawbbRBm12MbjaNwHX+AxJn/bO
         +YQDot8N3elbs+9IRVwVP0crV978G1f9WdzzevBngr4ZljouW0eJ0LF9nM8KJ1MWr6jd
         5EXw==
X-Gm-Message-State: AOJu0Ywih1IQg7xhNUfoFy6JVKGM/Cqex5wQeuPrihaOfdORArfBDICC
	aFJeYmfOG2jiwEtM5brDWahgsrIkjAAYwc2XsMY=
X-Google-Smtp-Source: AGHT+IHlIw37FzifkVwpYgUAimAh1o/5a7i6gg60HUtn+jLsTaaEuIJI5XX1XYcXJNpsCEtaH1v2EZuktGePrzQZIxI=
X-Received: by 2002:a17:907:9301:b0:9b2:89ec:d701 with SMTP id
 bu1-20020a170907930100b009b289ecd701mr3487133ejc.27.1698875823513; Wed, 01
 Nov 2023 14:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023220030.2556229-1-davemarchevsky@fb.com> <20231023220030.2556229-4-davemarchevsky@fb.com>
In-Reply-To: <20231023220030.2556229-4-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 14:56:52 -0700
Message-ID: <CAEf4BzY4qoRwdjZ_+9t51DOJOTQnvW1BpSP3VQizPsW7H=3Cxg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/4] btf: Descend into structs and arrays
 during special field search
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:00=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> Structs and arrays are aggregate types which contain some inner
> type(s) - members and elements - at various offsets. Currently, when
> examining a struct or datasec for special fields, the verifier does
> not look into the inner type of the structs or arrays it contains.
> This patch adds logic to descend into struct and array types when
> searching for special fields.
>
> If we have struct x containing an array:
>
> struct x {
>   int a;
>   u64 b[10];
> };
>
> we can construct some struct y with no array or struct members that
> has the same types at the same offsets:
>
> struct y {
>   int a;
>   u64 b1;
>   u64 b2;
>   /* ... */
>   u64 b10;
> };
>
> Similarly for a struct containing a struct:
>
> struct x {
>   char a;
>   struct {
>     int b;
>     u64 c;
>   } inner;
> };
>
> there's a struct y with no aggregate members and same types/offsets:
>
> struct y {
>   char a;
>   int inner_b __attribute__ ((aligned (8))); /* See [0] */
>   u64 inner_c __attribute__ ((aligned (8)));
> };
>
> This patch takes advantage of this equivalence to 'flatten' the
> field info found while descending into struct or array members into
> the btf_field_info result array of the original type being examined.
> The resultant btf_record of the original type being searched will
> have the correct fields at the correct offsets, but without any
> differentiation between "this field is one of my members" and "this
> field is actually in my some struct / array member".
>
> For now this descendant search logic looks for kptr fields only.
>
> Implementation notes:
>   * Search starts at btf_find_field - we're either looking at a struct
>     that's the type of some mapval (btf_find_struct_field), or a
>     datasec representing a .bss or .data map (btf_find_datasec_var).
>     Newly-added btf_find_aggregate_field is a "disambiguation helper"
>     like btf_find_field, but is meant to be called from one of the
>     starting points of the search - btf_find_{struct_field,
>     datasec_var}.
>     * btf_find_aggregate_field may itself call btf_find_struct_field,
>       so there's some recursive digging possible here
>
>   * Newly-added btf_flatten_array_field handles array fields by
>     finding the type of their element and continuing the dig based on
>     elem type.
>
>   [0]:  Structs have the alignment of their largest field, so the
>         explicit alignment is necessary here. Luckily this patch's
>         changes don't need to care about alignment / padding, since
>         the BTF created during compilation is being searched, and
>         it already has the correct information.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/btf.c | 151 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 142 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e999ba85c363..b982bf6fef9d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3496,9 +3496,41 @@ static int __struct_member_check_align(u32 off, en=
um btf_field_type field_type)
>         return 0;
>  }
>
> +/* Return number of elems and elem_type of a btf_array
> + *
> + * If the array is multi-dimensional, return elem count of
> + * equivalent single-dimensional array
> + *   e.g. int x[10][10][10] has same layout as int x[1000]
> + */
> +static u32 __multi_dim_elem_type_nelems(const struct btf *btf,

What's the purpose of these double underscored names? Are we avoiding
a naming conflict here?

> +                                       const struct btf_type *t,
> +                                       const struct btf_type **elem_type=
)
> +{
> +       u32 nelems =3D btf_array(t)->nelems;
> +
> +       if (!nelems)
> +               return 0;
> +
> +       *elem_type =3D btf_type_by_id(btf, btf_array(t)->type);
> +
> +       while (btf_type_is_array(*elem_type)) {

you need to strip modifiers and typedefs, presumably?

> +               if (!btf_array(*elem_type)->nelems)
> +                       return 0;

I agree with Yonghong, this duplicated nelems =3D=3D 0 check does look a
bit sloppy and unsure :) I'd rather us handle zero naturally

> +               nelems *=3D btf_array(*elem_type)->nelems;

check for overflow?

> +               *elem_type =3D btf_type_by_id(btf, btf_array(*elem_type)-=
>type);

think about skipping modifiers and maybe typedefs?

> +       }
> +       return nelems;
> +}
> +
> +static int btf_find_aggregate_field(const struct btf *btf,
> +                                   const struct btf_type *t,
> +                                   struct btf_field_info_search *srch,
> +                                   int field_off, int rec);
> +
>  static int btf_find_struct_field(const struct btf *btf,
>                                  const struct btf_type *t,
> -                                struct btf_field_info_search *srch)
> +                                struct btf_field_info_search *srch,
> +                                int struct_field_off, int rec)
>  {
>         const struct btf_member *member;
>         int ret, field_type;
> @@ -3522,10 +3554,24 @@ static int btf_find_struct_field(const struct btf=
 *btf,
>                          * checks, all ptrs have same align.
>                          * btf_maybe_find_kptr will find actual kptr type
>                          */
> -                       if (__struct_member_check_align(off, BPF_KPTR_REF=
))
> +                       if (srch->field_mask & BPF_KPTR &&

nit: () around & operation?


> +                           !__struct_member_check_align(off, BPF_KPTR_RE=
F)) {
> +                               ret =3D btf_maybe_find_kptr(btf, member_t=
ype,
> +                                                         struct_field_of=
f + off,
> +                                                         srch);

nit: does it fit in under 100 characters? If yes, go for it.

> +                               if (ret < 0)
> +                                       return ret;
> +                               if (ret =3D=3D BTF_FIELD_FOUND)
> +                                       continue;
> +                       }
> +
> +                       if (!(btf_type_is_array(member_type) ||
> +                             __btf_type_is_struct(member_type)))
>                                 continue;
>
> -                       ret =3D btf_maybe_find_kptr(btf, member_type, off=
, srch);
> +                       ret =3D btf_find_aggregate_field(btf, member_type=
, srch,
> +                                                      struct_field_off +=
 off,
> +                                                      rec);
>                         if (ret < 0)
>                                 return ret;
>                         continue;
> @@ -3541,15 +3587,17 @@ static int btf_find_struct_field(const struct btf=
 *btf,
>                 case BPF_LIST_NODE:
>                 case BPF_RB_NODE:
>                 case BPF_REFCOUNT:
> -                       ret =3D btf_find_struct(btf, member_type, off, sz=
, field_type,
> -                                             srch);
> +                       ret =3D btf_find_struct(btf, member_type,
> +                                             struct_field_off + off,
> +                                             sz, field_type, srch);
>                         if (ret < 0)
>                                 return ret;
>                         break;
>                 case BPF_LIST_HEAD:
>                 case BPF_RB_ROOT:
>                         ret =3D btf_find_graph_root(btf, t, member_type,
> -                                                 i, off, sz, srch, field=
_type);
> +                                                 i, struct_field_off + o=
ff, sz,
> +                                                 srch, field_type);
>                         if (ret < 0)
>                                 return ret;
>                         break;
> @@ -3566,6 +3614,82 @@ static int btf_find_struct_field(const struct btf =
*btf,
>         return srch->idx;
>  }
>
> +static int btf_flatten_array_field(const struct btf *btf,
> +                                  const struct btf_type *t,
> +                                  struct btf_field_info_search *srch,
> +                                  int array_field_off, int rec)
> +{
> +       int ret, start_idx, elem_field_cnt;
> +       const struct btf_type *elem_type;
> +       struct btf_field_info *info;
> +       u32 i, j, off, nelems;
> +
> +       if (!btf_type_is_array(t))
> +               return -EINVAL;
> +       nelems =3D __multi_dim_elem_type_nelems(btf, t, &elem_type);
> +       if (!nelems || !__btf_type_is_struct(elem_type))

and typedef fails this check, so yeah, you do need to strip typedefs

> +               return srch->idx;
> +
> +       start_idx =3D srch->idx;
> +       ret =3D btf_find_struct_field(btf, elem_type, srch, array_field_o=
ff + off, rec);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* No btf_field_info's added */
> +       if (srch->idx =3D=3D start_idx)
> +               return srch->idx;
> +
> +       elem_field_cnt =3D srch->idx - start_idx;
> +       info =3D __next_field_infos(srch, elem_field_cnt * (nelems - 1));
> +       if (IS_ERR_OR_NULL(info))
> +               return PTR_ERR(info);
> +
> +       /* Array elems after the first can copy first elem's btf_field_in=
fos
> +        * and adjust offset
> +        */
> +       for (i =3D 1; i < nelems; i++) {
> +               memcpy(info, &srch->infos[start_idx],
> +                      elem_field_cnt * sizeof(struct btf_field_info));
> +               for (j =3D 0; j < elem_field_cnt; j++) {

nit: instead of memcpy above, why not just

*info =3D srch->infos[start_idx + j];

inside the loop?

It seems a bit more natural in this case, as you are adjusting each
copied element either way.

Or, you know, if we go with memcpy, then why not single memcpy() with
elem_field_cnt * (nelems - 1) elements?


> +                       info->off +=3D (i * elem_type->size);
> +                       info++;

can you please check if zero-sized structs are handled (and probably
rejected) correctly?

E.g.:

struct my_struct {
    struct fancy_kptr __kptr kptrs[0];
}

> +               }
> +       }
> +       return srch->idx;
> +}
> +

[...]

