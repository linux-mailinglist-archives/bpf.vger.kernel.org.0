Return-Path: <bpf+bounces-13838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CC7DE7BE
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A701C20E3D
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19F1B294;
	Wed,  1 Nov 2023 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8ZG4TgQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903323BC
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:57:03 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE0110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:57:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d10f94f70bso39977166b.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698875820; x=1699480620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16vHnjmUb0ErHCPQbdebc0dhpa0zP8iJTSE/053EUNc=;
        b=A8ZG4TgQcmPtOKRgvnk2MF4tOTrFxjxuC0gYUTbWEkAm5Dko1ov/2HMR4aXTUQy7Fd
         EYbIXlhizW8A3vDj4AaK8DjWdJNg7kt8xKf9IzbDAY1syr3qNvmBDVz9CmgHqlONzZC9
         GLiXMFwmE9b5m8dMV+oVIf0RpnJnv1R7UeuNkQhcvyuwwbc8G8CA+oO+L/WX1tSbqVKe
         JnFi9pPMUNozwUVPwNEbzCWXVpVgGTTRZMTs3ewPghFPkUcz5QjRp4fxtsJkwXpChzdY
         Ck0SKX8vXAp5hbV3UCZm+89hHOemWS69Zc54smDy7td29HinU0OaV1Kex45o6NdKj1zk
         uFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875820; x=1699480620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16vHnjmUb0ErHCPQbdebc0dhpa0zP8iJTSE/053EUNc=;
        b=Y7x2rjkO0kIrGCSh5jx6avF8tj4TE6zK8y/Y09W79a8OvG18RFGNY7X9Na4ETsX8WB
         4KA9WuRfhHRKEqmpMy9fsWiAuCSDERbBRh1+9bUwnBUOTamDsXwymKnZG+K8xixeI45c
         /9nXUGkBLzrYCpaqaDGAoLpmo1qnXjqbFIVlO/NDoKNp8jb9Keb4fA2+wh1oEnrw0Qqn
         QGsduS4fes86Auobo5rFMP5u9WxzDZpRtAZydunJ3+mhBVeQCHpFPvIvFIUJ7oyHRsv2
         CdyIdAnkcd2ea2xXaOUFjZ+6eZjDtzNEys29W4U/pT3Bx2Z0x/S8xvMkrmGC5cHY+ENK
         jSYQ==
X-Gm-Message-State: AOJu0Yy7pKUmoNgJOBkLGETiKKdREUOymKOUZwa03bEcTFZXPevrxwoc
	0TmnwII6bz7awnUeIajN0vR9VzD0Xee88L6pMlQ=
X-Google-Smtp-Source: AGHT+IHy7AjUSR97HOJje6qFrkCQL6BjvtHrfBHax0Tbcry2BhRrxDGVH1qbNWKc+wNQNes6qVsvT1HmUN8G/rEGzNE=
X-Received: by 2002:a17:906:ee85:b0:9be:dce3:6e07 with SMTP id
 wt5-20020a170906ee8500b009bedce36e07mr3162040ejb.32.1698875819743; Wed, 01
 Nov 2023 14:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023220030.2556229-1-davemarchevsky@fb.com> <20231023220030.2556229-3-davemarchevsky@fb.com>
In-Reply-To: <20231023220030.2556229-3-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 14:56:48 -0700
Message-ID: <CAEf4BzZXdkRX4gTjS65peW7xae=1xLdjuChZqcjMcAsqRJsCsg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/4] bpf: Refactor btf_find_field with btf_field_info_search
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:00=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> btf_find_field takes (btf_type, special_field_types) and returns info
> about the specific special fields in btf_type, in the form of an array
> of struct btf_field info. The meat of this 'search for special fields'
> process happens in btf_find_datasec_var and btf_find_struct_field
> helpers: each member is examined and, if it's special, a struct
> btf_field_info describing it is added to the return array. Indeed, any
> function that might add to the output probably also looks at struct
> members or datasec vars.
>
> Most of the parameters passed around between helpers doing the search
> can be grouped into two categories: "info about the output array" and
> "info about which fields to search for". This patch joins those together
> in struct btf_field_info_search, simplifying the signatures of most
> helpers involved in the search, including array flattening helper that
> later patches in the series will add.
>
> The aforementioned array flattening logic will greatly increase the
> number of btf_field_info's needed to describe some structs, so this
> patch also turns the statically-sized struct btf_field_info
> info_arr[BTF_FIELDS_MAX] into a growable array with a larger max size.
>
> Implementation notes:
>   * BTF_FIELDS_MAX is now max size of growable btf_field_info *infos
>     instead of initial (and max) size of static result array
>     * Static array before had 10 elems (+1 tmp btf_field_info)
>     * growable array starts with 16 and doubles every time it needs to
>       grow, up to BTF_FIELDS_MAX of 256
>
>   * __next_field_infos is used with next_cnt > 1 later in the series
>
>   * btf_find_{datasec_var, struct_field} have special logic for an edge
>     case where the result array is full but the field being examined
>     gets BTF_FIELD_IGNORE return from btf_find_{struct, kptr,graph_root}
>     * If result wasn't BTF_FIELD_IGNORE, a btf_field_info would have to
>       be added to the array. Since it is we can look at next field.
>     * Before this patch the logic handling this edge case was hard to
>       follow and used a tmp btf_struct_info. This patch moves the
>       add-if-not-ignore logic down into btf_find_{struct, kptr,
>       graph_root}, removing the need to opportunistically grab a
>       btf_field_info to populate before knowing if it's actually
>       necessary. Now a new one is grabbed only if the field shouldn't
>       be ignored.
>
>   * Within btf_find_{datasec_var, struct_field}, each member is
>     currently examined in two phases: first btf_get_field_type checks
>     the member type name, then btf_find_{struct,graph_root,kptr} do
>     additional sanity checking and populate struct btf_field_info. Kptr
>     fields don't have a specific type name, though, so
>     btf_get_field_type assumes that - if we're looking for kptrs - any
>     member that fails type name check could be a kptr field.
>     * As a result btf_find_kptr effectively does all the pointer
>       hopping, sanity checking, and info population. Instead of trying
>       to fit kptr handling into this two-phase model, where it's
>       unwieldy, handle it in a separate codepath when name matching
>       fails.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h |   4 +-
>  kernel/bpf/btf.c    | 331 +++++++++++++++++++++++++++++---------------
>  2 files changed, 219 insertions(+), 116 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..e07cac5cc3cf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -171,8 +171,8 @@ struct bpf_map_ops {
>  };
>
>  enum {
> -       /* Support at most 10 fields in a BTF type */
> -       BTF_FIELDS_MAX     =3D 10,
> +       /* Support at most 256 fields in a BTF type */
> +       BTF_FIELDS_MAX     =3D 256,
>  };
>
>  enum btf_field_type {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 975ef8e73393..e999ba85c363 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3257,25 +3257,94 @@ struct btf_field_info {
>         };
>  };
>
> +struct btf_field_info_search {
> +       /* growable array. allocated in __next_field_infos
> +        * free'd in btf_parse_fields
> +        */
> +       struct btf_field_info *infos;
> +       /* size of infos */
> +       int info_cnt;
> +       /* index of next btf_field_info to populate */
> +       int idx;

this seems pretty unconventional naming, typically info_cnt would be
called "cap" (for capacity) and idx would be "cnt" (number of actually
filled elements)

> +
> +       /* btf_field_types to search for */
> +       u32 field_mask;
> +       /* btf_field_types found earlier */
> +       u32 seen_mask;
> +};
> +
> +/* Reserve next_cnt contiguous btf_field_info's for caller to populate
> + * Returns ptr to first reserved btf_field_info
> + */
> +static struct btf_field_info *__next_field_infos(struct btf_field_info_s=
earch *srch,
> +                                                u32 next_cnt)

both next_cnt and __next_field_infos that do allocation are quite
surprising, this is a function to add/append more elements, so why not
add_field_infos() and new_cnt or add_cnt? The terminology around
"next" is confusing, IMO, because you'd expect this to be about
iteration, not memory allocation.

> +{
> +       struct btf_field_info *new_infos, *ret;
> +
> +       if (!next_cnt)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (srch->idx + next_cnt < srch->info_cnt)
> +               goto nogrow_out;

why goto? just update count and return a pointer? Goto makes sense if
there is at least two code paths with the same exit logic.

> +
> +       /* Need to grow */
> +       if (srch->idx + next_cnt > BTF_FIELDS_MAX)
> +               return ERR_PTR(-E2BIG);
> +
> +       while (srch->idx + next_cnt >=3D srch->info_cnt)
> +               srch->info_cnt =3D srch->infos ? srch->info_cnt * 2 : 16;

I think krealloc() is smart enough to not allocate exact number of
bytes, and instead is rounding it up to closes bucket size. So I think
you can just keep it simple and ask for `srch->idx + next_cnt`
elements, and leave smartness to krealloc(). Not sure why 16 is the
starting size, though? How many elements do we typically have? 1, 2,
3, 5?

> +
> +       new_infos =3D krealloc(srch->infos,
> +                            srch->info_cnt * sizeof(struct btf_field_inf=
o),
> +                            GFP_KERNEL | __GFP_NOWARN);
> +       if (!new_infos)
> +               return ERR_PTR(-ENOMEM);
> +       srch->infos =3D new_infos;
> +
> +nogrow_out:
> +       ret =3D &srch->infos[srch->idx];
> +       srch->idx +=3D next_cnt;
> +       return ret;
> +}
> +
> +/* Request srch's next free btf_field_info to populate, possibly growing
> + * srch->infos
> + */
> +static struct btf_field_info *__next_field_info(struct btf_field_info_se=
arch *srch)
> +{
> +       return __next_field_infos(srch, 1);
> +}
> +
>  static int btf_find_struct(const struct btf *btf, const struct btf_type =
*t,
>                            u32 off, int sz, enum btf_field_type field_typ=
e,
> -                          struct btf_field_info *info)
> +                          struct btf_field_info_search *srch)
>  {
> +       struct btf_field_info *info;
> +
>         if (!__btf_type_is_struct(t))
>                 return BTF_FIELD_IGNORE;
>         if (t->size !=3D sz)
>                 return BTF_FIELD_IGNORE;
> +
> +       info =3D __next_field_info(srch);
> +       if (IS_ERR_OR_NULL(info))

Can it return NULL? If not, let's not check for NULL at all, it's misleadin=
g.

> +               return PTR_ERR(info);
> +
>         info->type =3D field_type;
>         info->off =3D off;
>         return BTF_FIELD_FOUND;
>  }
>
> -static int btf_find_kptr(const struct btf *btf, const struct btf_type *t=
,
> -                        u32 off, int sz, struct btf_field_info *info)
> +static int btf_maybe_find_kptr(const struct btf *btf, const struct btf_t=
ype *t,
> +                              u32 off, struct btf_field_info_search *src=
h)
>  {
> +       struct btf_field_info *info;
>         enum btf_field_type type;
>         u32 res_id;
>
> +       if (!(srch->field_mask & BPF_KPTR))
> +               return BTF_FIELD_IGNORE;
> +
>         /* Permit modifiers on the pointer itself */
>         if (btf_type_is_volatile(t))
>                 t =3D btf_type_by_id(btf, t->type);
> @@ -3304,6 +3373,10 @@ static int btf_find_kptr(const struct btf *btf, co=
nst struct btf_type *t,
>         if (!__btf_type_is_struct(t))
>                 return -EINVAL;
>
> +       info =3D __next_field_info(srch);
> +       if (IS_ERR_OR_NULL(info))
> +               return PTR_ERR(info);
> +

ditto

>         info->type =3D type;
>         info->off =3D off;
>         info->kptr.type_id =3D res_id;

[...]

>  #undef field_mask_test_name_check_seen
>  #undef field_mask_test_name
>
> +static int __struct_member_check_align(u32 off, enum btf_field_type fiel=
d_type)
> +{
> +       u32 align =3D btf_field_type_align(field_type);
> +
> +       if (off % align)

maybe guard against zero division? WARN_ON_ONCE() in
btf_field_type_align() shouldn't cause crash here

> +               return -EINVAL;
> +       return 0;
> +}
> +
>  static int btf_find_struct_field(const struct btf *btf,
> -                                const struct btf_type *t, u32 field_mask=
,
> -                                struct btf_field_info *info, int info_cn=
t)
> +                                const struct btf_type *t,
> +                                struct btf_field_info_search *srch)
>  {
> -       int ret, idx =3D 0, align, sz, field_type;
>         const struct btf_member *member;
> -       struct btf_field_info tmp;
> -       u32 i, off, seen_mask =3D 0;
> +       int ret, field_type;
> +       u32 i, off, sz;
>

[...]

> +
> +static int __datasec_vsi_check_align_sz(const struct btf_var_secinfo *vs=
i,
> +                                       enum btf_field_type field_type,
> +                                       u32 expected_sz)
> +{
> +       u32 off, align;
> +
> +       off =3D vsi->offset;
> +       align =3D btf_field_type_align(field_type);
> +
> +       if (vsi->size !=3D expected_sz)
> +               return -EINVAL;
> +       if (off % align)
> +               return -EINVAL;

same about possible align =3D=3D 0

> +
> +       return 0;
>  }
>

[...]

