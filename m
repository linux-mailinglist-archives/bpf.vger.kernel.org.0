Return-Path: <bpf+bounces-31089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850528D6EBB
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932671C20F67
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57081946F;
	Sat,  1 Jun 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nad8BgEK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3C14267
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717228585; cv=none; b=tJZtAssaJ2kIqK1WoP5j1FNJLTFndLO0xn9pvoOFD7RgYYf6W2poyFMG4HhQTdYFd35wLN+p2YhaoYwNy07+nxxuF/a7QOO657APU5CY7np+1Yy0/93Y0uMqrX7E93SJVgLrw2tN83BXEcOlczYc7kTOjzgGYFt9nRjxEuxPySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717228585; c=relaxed/simple;
	bh=dzYwqF2pQiQ0Tj6iDwuXPp1FP6q+b2SM6Un38m2aq18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMn44syAmLJL9ceRLNKNdgG+3iYeZ4e7FZkIZK9ClB3HbrUtuc3YbtEzmEN0QK+B62Q0Qfj7i2pomea/XQ85PoI0Qdd+BDhqiKh9dNl/5Dn0ku8Q+3XGH1+TtdHVwNWJ+hrT8Pp85D+3NGUJOgqkSqHvimDXPWnFqIVefsDkM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nad8BgEK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c1e6eadb54so1036372a91.3
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2024 00:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717228583; x=1717833383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBIXn0b2gXluu5mifJRq2vNAFMfPScxiouw9SyJ0x+c=;
        b=nad8BgEKfDJhgSpTZy+hmewtEmPenD522u2QMM4PyAYHPo2VF1kVXUir34c/ASEaLn
         eNKvS/RLKNrD0FeK2/JMTF+wqNH9LCyAcihnqhRep1lAFDY1B8H7SFOiYA0oKBPDrUKv
         bjeiYSN2zvEpJg6vY2fEbxU2oQuwOqI4MGO6KhoFk/6EDbkXijyLWvzYibE7E3ZNTFLg
         5NxR22G5+D9Gw19Y3yG/UOKR33aANKp07lCFFlvmgs8QzKw39qrBu9tB2Zo1iNi20L4p
         7849eGvOMopYXvVySUYzIlB1kMdveHgpDj22KtaTf8HWvjUzR0WU8UzbKxzhP288o4A/
         YyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717228583; x=1717833383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBIXn0b2gXluu5mifJRq2vNAFMfPScxiouw9SyJ0x+c=;
        b=gopT/08ei4bL1VWoXCVOr9jr6eE+Pd8udoe6V/DwU23fKDnRD2iGxIK8jJyAOPUDT/
         v/HvUunWC1espGoYD6+2DCAsF6dWN4D2Dnzajko2/JN5rYvWD1Wv/edrzqqHG2jPsNg/
         WYDaKTr7271JkWPmnWxpFpEN4zvB8BUySmTqa/TyH5RijrmjusxqO3uZwEsLGygp+kys
         u7xhUeGPM3pCDtdJQH/DdWVo/d/YQwrq/jzOPCjld1l5sZuq6xxL0AcrKkexIF2qD+Ie
         5twW3mHpd5iI3Cb51X2G0z2hxlm8kkh6gkSHSUp8TddHBc8sglgKYcAwdxs4cDgcR4aU
         jRFg==
X-Forwarded-Encrypted: i=1; AJvYcCUe+AJ+ZMtNsEiG+2Lp2hiYQLVjcwwbdt9hlzm4aU8ZtqLZPS+iMG+yt+HUiwYUJZdumhCKGs2cWnxA/qP/LWyqPHPh
X-Gm-Message-State: AOJu0YxYzBSgq8ymc8T31au4PS0BAloBIL4W3aP0RwkLZAcPpSW8nj6N
	sNP555DB8I0l/AL+D7Z4lpghCjNcNgOSkhmwA8Fgv7q+WsxpUx9d
X-Google-Smtp-Source: AGHT+IFrwMnwT9LpnNsiZ8eR4C7xScvtGzFLJwyNO3i8RQuHCC0xfd/I40Z02B+2gnp7/4Adsh89fA==
X-Received: by 2002:a17:90a:dd83:b0:2bd:d42a:e071 with SMTP id 98e67ed59e1d1-2c1dc5bab2emr3740421a91.30.1717228582800;
        Sat, 01 Jun 2024 00:56:22 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7771386sm4673550a91.22.2024.06.01.00.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 00:56:22 -0700 (PDT)
Message-ID: <0848f8e3fec1954540b9d679aaa59c17177d0aa2.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
 quentin@isovalent.com,  mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev,  song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com,  kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, houtao1@huawei.com, 
 bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Sat, 01 Jun 2024 00:56:21 -0700
In-Reply-To: <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-4-alan.maguire@oracle.com>
	 <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
	 <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 16:38 +0100, Alan Maguire wrote:

Hi Alan,

> The in-kernel sort reports n*log2(n) + 0.37*n + o(n) comparisons on
> average; for base BTF that means sorting requires at least
>=20
> Base: 14307*14+0.37*14307	=3D 205592 comparisons
> Dist: 600*9+0.37*600		=3D 5622 comparisons
>=20
> So we get an inversion of the above results, with (unless I'm
> miscalculating something), sorting distilled base BTF requiring less
> comparisons overall across both sort+search.
>=20
> Sort Comparisons		Search comparisons		Total
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=09
> 5622	(distilled)		128763	(to base)		134385
> 205592	(base)			8400	(to distilled)		213992

It was absolutely stupid of me to not include the base sort cost into
the calculations, really embarrassing. Thank you for pointing this out
and my apologies for suggesting such nonsense.

[...]

> > The algorithm might not handle name duplicates in the distilled BTF wel=
l,
> > e.g. in theory, the following is a valid C code
> >=20
> >   struct foo { int f; }; // sizeof(struct foo) =3D=3D 4
> >   typedef int foo;       // sizeof(foo) =3D=3D 4
> >=20
> > Suppose that these types are a part of the distilled BTF.
> > Depending on which one would end up first in 'dist_base_info_sorted'
> > bsearch might fail to find one or the other.
>=20
> In the case of distilled base BTF, only struct, union, enum, enum64,
> int, float and fwd can be present. Size matches would have to be between
> one of these kinds I think, but are still possible nevertheless.

As Andrii noted in a sibling reply, there is still a slim possibility
for name duplicates in the distilled base. Imo, if we can catch the
corner case we should.

> > Also, algorithm does not report an error if there are several
> > types with the same name and size in the base BTF.
>=20
> Yep, while we have to handle this, it only becomes an ambiguity problem
> if distilled base BTF refers to one of such types. On my vmlinux I see
> the following duplicate name/size STRUCTs

As you noted, this situation is really easy to catch by checking if
id_map slot is already occupied, so it should be checked.

[...]

> struct elf_thread_core_info___2;
>=20
> struct elf_note_info___2 {
>         struct elf_thread_core_info___2 *thread;
>         struct memelfnote psinfo;
>         struct memelfnote signote;
>         struct memelfnote auxv;
>         struct memelfnote files;
>         compat_siginfo_t csigdata;
>         size_t size;
>         int thread_notes;
> };
>=20
> Both of these share self-reference, either directly or indirectly so
> maybe it's a corner-case of dedup we're missing. I'll dig into these late=
r.

This is interesting indeed.

> > I suggest to modify the algorithm as follows:
> > - let 'base_info_sorted' be a set of tuples {kind,name,size,id}
> >   corresponding to the base BTF, sorted by kind, name and size;
>=20
> That was my first thought, but we can't always search by kind; for
> example it's possible the distilled base has a fwd and vmlinux only has
> a struct kind for the same type name; in such a case we'd want to
> support a match provided the fwd's kflag indicated a struct fwd.
>=20
> In fact looking at the code we're missing logic for the opposite
> condition (fwd only in base, struct in distilled base). I'll fix that.
>=20
> The other case is an enum in distilled base matching an enum64
> or an enum.

I think it could be possible to do some kinds normalization
(e.g. represent fwd's as zero sized structs or unions in
btf_name_info).
I'll try to implement this and get back to you on Monday.

[...]

> I think flipping the search order could gain search speed, but only at
> the expense of slowing things down overall due to the extra cost of
> having to sort so many more elements. I suspect it will mostly be a
> wash, though numbers above seem to suggest sorting distilled base may
> have an edge when we consider both search and sort. The question is
> probably which sort/search order is most amenable to handling the data
> and helping us deal with the edge cases like duplicates.

Yes, you are absolutely correct.

[...]

> @@ -136,6 +137,19 @@ static int btf_relocate_map_distilled_base(struct
> btf_relocate *r)
>         qsort(dist_base_info_sorted, r->nr_dist_base_types,
> sizeof(*dist_base_info_sorted),
>               cmp_btf_name_size);
>=20
> +       /* It is possible - though highly unlikely - that
> duplicate-named types
> +        * end up in distilled based BTF; error out if this is the case.
> +        */
> +       for (id =3D 1; id < r->nr_dist_base_types; id++) {
> +               if (last_name =3D=3D dist_base_info_sorted[id].name) {
> +                       pr_warn("Multiple distilled base types [%u],
> [%u] share name '%s'; cannot relocate with base BTF.\n",
> +                               id - 1, id, last_name);
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +               last_name =3D dist_base_info_sorted[id].name;
> +       }
> +

Nit: this rejects a case when both distilled types are embedded and a
     counterpart for each could be found in base. But that's a bit
     inconvenient to check for in the current framework. Probably not
     important.

>         /* Mark distilled base struct/union members of split BTF
> structs/unions
>          * in id_map with BTF_IS_EMBEDDED; this signals that these types
>          * need to match both name and size, otherwise embeddding the bas=
e
> @@ -272,6 +286,21 @@ static int btf_relocate_map_distilled_base(struct
> btf_relocate *r)
>                 default:
>                         continue;
>                 }
> +               if (r->id_map[dist_name_info->id] &&
> + 		    r->id_map[dist_name_info->id !=3D BTF_IS_EMBEDDED) {
> +                       /* we already have a match; this tells us that
> +                        * multiple base types of the same name
> +                        * have the same size, since for cases where
> +                        * multiple types have the same name we match
> +                        * on name and size.  In this case, we have
> +                        * no way of determining which to relocate
> +                        * to in base BTF, so error out.
> +                        */
> +                       pr_warn("distilled base BTF type '%s' [%u], size
> %u has multiple candidates of the same size (ids [%u, %u]) in base BTF\n"=
,
> +                               base_name_info.name, dist_name_info->id,
> base_t->size,
> +                               id, r->id_map[dist_name_info->id]);
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }

I think this hunk should be added.

[...]

Best regards,
Eduard

