Return-Path: <bpf+bounces-73537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C2C3372D
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA718C6B56
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DB21D3DC;
	Wed,  5 Nov 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMHClgnc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C421D3E2
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301505; cv=none; b=O5euUEM/uHt3yMs9W3mRh2Atm1HC/wP6HlVCg/3PYEsYFNvVNJYEtUFBhYPn4hjylqYAuRT8zRR9ROwxuHat6YbUbMFmEL4fBooPBrauGEGwcoHEs0e6Z9tU2wdlf79ZH7Nu2boSIXJdHOasKCrNf6pODImSgOHkhAw/uaj2u+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301505; c=relaxed/simple;
	bh=9upztcecBw1kEpkmS9jAWoAKMVSODXK+8nFThvHapWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6tyuEmN1qnm25SGX/Tk07yaf6CrZm1WmXCmXX3v1kMI6ad+bBBerGXdxRjSiWQyYCWqDG1rrpF//fVfLSlzkSzfE6dYjkl3Boq4ccfKeFq24QSWox8ADGqyd+CaSflLYvj06y4U7FIxuXyg2o65uBr2HlWSpObc5rFlwiRHLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMHClgnc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3408c9a8147so338610a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301503; x=1762906303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tavMxAjGzhkDnTwrSVYGUhACYFwW8M8/eQz6V2FuWRY=;
        b=IMHClgnckx9u+4AKCOhUueNuM/La5AvRBIYua2WD3rEV93DlpLjdoQ4PFVUI+9/IxQ
         oyWE5AxFOj2IwIk5LknW3XCta7Xwqs/bpYCnoWAdimzjyBy9pw1QH2/fUmrU+JxxQfPt
         llS2pjCbJ1olTz767KXzlZtCGmRKMesL9kHD0FRkwhkBc5RUOoqaSDmwyc2fieHHyrYT
         Q8AUuZY6NRHfstt3+YT/gyaT7cdYywknw5ORNMRkwsTIzEhhGAmTkCwTZubJpJEzLBMm
         PaD6zJhPD2f7466ZbKLTBpKFD1nmF3C0NbScbaobc7wU+t9PTIAB3JlulzCnb1T9Ob7S
         sPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301503; x=1762906303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tavMxAjGzhkDnTwrSVYGUhACYFwW8M8/eQz6V2FuWRY=;
        b=eMcBPrVRO/5xJoMR8XuCiA69sBZIIhqvmg5JaKcBq4qP1MgVRNGat7XrMR6wfEVizp
         UZYqaElE2pYVoLiZSABJf63XAxgGP7419ESJ9hRrnbfGq0MemRq38QwHU9VNEcgIKOih
         y9YXMcS7fimBnf4/lVh3a2aH5xbkW/xHolxfFp3KVv8p5xXaEG+hfZypjXVn/EBBFx34
         kE10tffan2PGrizADdRFzahRkYAnVPIPaTeYpEqgeXCeDEU7T9MHOzR7vK9FFVurSIb/
         ooxdmqSd4039jLCfzLcbyzcQbj4ir9HSlahNXXTJ1gLh3rXIzNqtFjepG4PPY8FZviaq
         e20g==
X-Forwarded-Encrypted: i=1; AJvYcCX8P9I9B+4DZgioBOTMYGEppD2H/BD53xfSBwIjSEjAD8h6w4QVw16N+dRKQPL8zw34uEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XFePY7wVXT9KP8VY6rIj2weYa+/IDnVyIkBpuytUQ/j2W6+b
	4447RfpjbUL9w7uBQHmoLtI4tKmLqPNDq22X0Bmh88W/ShW/U5eqZaIWXi3e4bsm8+CWl33tejP
	+BgDDbVfT46d4bmU/BoQMlPvme6HRQZM=
X-Gm-Gg: ASbGncsL0NuxpSBpbmrZyNYxOecd3uUkfqj/+5uT5LNFJHvfjeUXPKidc1//X4ZvQUI
	2DuibfT/i3WGj1GN/2mxt3lw8hxmDB8biV4wH9HjZh/ddF80wAM/1SFc8ch5QFv+2CnRzhoWZhy
	UXJBGp+YIl7Kz+XuxP1dBXyB2MblfhkEUsovBuqDEyHC1nGl/1N3HznvFAe0eYnEtnzPXojzjyN
	CJU+2PaQ18JUoNu1ESIkPoHlNCmGjL938RZhrd5o0K1R/PaeDbN/61clpobR63AwhABYcEZFyUT
X-Google-Smtp-Source: AGHT+IECJTq7hC7va2Tb+2EUQVphnvTYI9W5nwU4nLrwtxEFOQhPe6QAUq7lvxwUqOc+0do9fME4c6DHDyp4Zl5yljU=
X-Received: by 2002:a17:90b:1c12:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-341a2d96ec1mr2143546a91.1.1762301503256; Tue, 04 Nov 2025
 16:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-3-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-3-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:11:28 -0800
X-Gm-Features: AWmQ_bm1h86K6WKFYU_6X_6KUHNRi6qmkA3JSaPBKDpA07CQgGN1hfN_3SGYDjw
Message-ID: <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Introduce btf__permute() API to allow in-place rearrangement of BTF types=
.
> This function reorganizes BTF type order according to a provided array of
> type IDs, updating all type references to maintain consistency.
>
> The permutation process involves:
> 1. Shuffling types into new order based on the provided ID mapping
> 2. Remapping all type ID references to point to new locations
> 3. Handling BTF extension data if provided via options
>
> This is particularly useful for optimizing type locality after BTF
> deduplication or for meeting specific layout requirements in specialized
> use cases.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  34 +++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 196 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5e1c09b5dce8..3bc03f7fe31f 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const struct b=
tf *base_btf)
>                 btf->owns_base =3D false;
>         return libbpf_err(err);
>  }
> +
> +struct btf_permute {
> +       /* .BTF section to be permuted in-place */
> +       struct btf *btf;
> +       struct btf_ext *btf_ext;
> +       /* Array of type IDs used for permutation. The array length must =
equal

/*
 * Use this comment style
 */

> +        * the number of types in the BTF being permuted, excluding the s=
pecial
> +        * void type at ID 0. For split BTF, the length corresponds to th=
e
> +        * number of types added on top of the base BTF.

many words, but what exactly ids[i] means is still not clear, actually...

> +        */
> +       __u32 *ids;
> +       /* Array of type IDs used to map from original type ID to a new p=
ermuted
> +        * type ID, its length equals to the above ids */

wrong comment style

> +       __u32 *map;

"map" is a bit generic. What if we use s/ids/id_map/ and
s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the public
API to make it clear that it's a mapping of IDs, not just some array
of IDs.

> +};
> +
> +static int btf_permute_shuffle_types(struct btf_permute *p);
> +static int btf_permute_remap_types(struct btf_permute *p);
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> +
> +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permute_o=
pts *opts)

Let's require user to pass id_map_cnt in addition to id_map itself.
It's easy to get this wrong (especially with that special VOID 0 type
that has to be excluded, which I can't even make up my mind if that's
a good idea or not), so having user explicitly say what they think is
necessary for permutation is good.

> +{
> +       struct btf_permute p;
> +       int i, err =3D 0;
> +       __u32 *map =3D NULL;
> +
> +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)

libbpf doesn't protect against NULL passed for mandatory parameters,
please drop !ids check

> +               return libbpf_err(-EINVAL);
> +
> +       map =3D calloc(btf->nr_types, sizeof(*map));
> +       if (!map) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       for (i =3D 0; i < btf->nr_types; i++)
> +               map[i] =3D BTF_UNPROCESSED_ID;
> +
> +       p.btf =3D btf;
> +       p.btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +       p.ids =3D ids;
> +       p.map =3D map;
> +
> +       if (btf_ensure_modifiable(btf)) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +       err =3D btf_permute_shuffle_types(&p);
> +       if (err < 0) {
> +               pr_debug("btf_permute_shuffle_types failed: %s\n", errstr=
(err));

let's drop these pr_debug(), I don't think it's something we expect to ever=
 see

> +               goto done;
> +       }
> +       err =3D btf_permute_remap_types(&p);
> +       if (err < 0) {
> +               pr_debug("btf_permute_remap_types failed: %s\n", errstr(e=
rr));

ditto

> +               goto done;
> +       }
> +
> +done:
> +       free(map);
> +       return libbpf_err(err);
> +}
> +
> +/* Shuffle BTF types.
> + *
> + * Rearranges types according to the permutation map in p->ids. The p->m=
ap
> + * array stores the mapping from original type IDs to new shuffled IDs,
> + * which is used in the next phase to update type references.
> + *
> + * Validates that all IDs in the permutation array are valid and unique.
> + */
> +static int btf_permute_shuffle_types(struct btf_permute *p)
> +{
> +       struct btf *btf =3D p->btf;
> +       const struct btf_type *t;
> +       __u32 *new_offs =3D NULL, *map;
> +       void *nt, *new_types =3D NULL;
> +       int i, id, len, err;
> +
> +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));

we don't really need to allocate memory and maintain this, we can just
shift types around and then do what btf_parse_type_sec() does -- just
go over types one by one and calculate offsets, and update them
in-place inside btf->type_offs

> +       new_types =3D calloc(btf->hdr->type_len, 1);
> +       if (!new_offs || !new_types) {
> +               err =3D -ENOMEM;
> +               goto out_err;
> +       }
> +
> +       nt =3D new_types;
> +       for (i =3D 0; i < btf->nr_types; i++) {
> +               id =3D p->ids[i];
> +               /* type IDs from base_btf and the VOID type are not allow=
ed */
> +               if (id < btf->start_id) {
> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               /* must be a valid type ID */
> +               t =3D btf__type_by_id(btf, id);
> +               if (!t) {
> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               map =3D &p->map[id - btf->start_id];
> +               /* duplicate type IDs are not allowed */
> +               if (*map !=3D BTF_UNPROCESSED_ID) {

there is no need for BTF_UNPROCESSED_ID, zero is a perfectly valid
value to use as "not yet set" value, as we don't allow remapping VOID
0 to anything anyways.

> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               len =3D btf_type_size(t);
> +               memcpy(nt, t, len);

once you memcpy() data, you can use that btf_field_iter_init +
btf_field_iter_next to *trivially* remap all IDs, no need for patch 1
refactoring, IMO. And no need for two-phase approach either.

> +               new_offs[i] =3D nt - new_types;
> +               *map =3D btf->start_id + i;
> +               nt +=3D len;
> +       }
> +
> +       free(btf->types_data);
> +       free(btf->type_offs);
> +       btf->types_data =3D new_types;
> +       btf->type_offs =3D new_offs;
> +       return 0;
> +
> +out_err:
> +       free(new_offs);
> +       free(new_types);
> +       return err;
> +}
> +
> +/* Callback function to remap individual type ID references
> + *
> + * This callback is invoked by btf_remap_types() for each type ID refere=
nce
> + * found in the BTF data. It updates the reference to point to the new
> + * permuted type ID using the mapping table.
> + */
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{
> +       struct btf_permute *p =3D ctx;
> +       __u32 new_type_id =3D *type_id;
> +
> +       /* skip references that point into the base BTF */
> +       if (new_type_id < p->btf->start_id)
> +               return 0;
> +
> +       new_type_id =3D p->map[*type_id - p->btf->start_id];

I'm actually confused, I thought p->ids would be the mapping from
original type ID (minus start_id, of course) to a new desired ID, but
it looks to be the other way? ids is a desired resulting *sequence* of
types identified by their original ID. I find it quite confusing. I
think about permutation as a mapping from original type ID to a new
type ID, am I confused?


> +       if (new_type_id > BTF_MAX_NR_TYPES)
> +               return -EINVAL;
> +
> +       *type_id =3D new_type_id;
> +       return 0;
> +}

[...]

