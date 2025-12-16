Return-Path: <bpf+bounces-76753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C4CC5037
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28434303D30A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F5334C23;
	Tue, 16 Dec 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJJQfmg1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AB31A06F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765913675; cv=none; b=g9HTGrtmbSk2PkwMfbl9NPejv4A7NBdRr4JGLNejX3jiu3PdPeDw6GR6gcrTlpQwG4YUM+31CYMN7SM61ba6ihJUgjWL/DEFC37Ubqm04ss+QZezt6nBPOdiI+NXKrmb2F2H/O9MH+d/iBKowHV563++GGp3n/VbDJi7bfMG8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765913675; c=relaxed/simple;
	bh=FOUuSxJdgORqB3D7sSJIl9DIFcwVTc2m8UMrIKsIHuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1k/ejdGfD2H84gYLRawXPb0Ci/C8zVXM3u2/HRLYUYp2KatE2EwEzjziQN9PBOAj0XOuHAoK9bxc5F94i6XQ6ejRyx3aG2mm0UNCRryFxflNOorcz/mxZf7BpkBYzllAqO18drtE6Yyzq86hyIX3D/60M3nSezt2GiHCIXvBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJJQfmg1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0bae9aca3so38654415ad.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765913672; x=1766518472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc7wkmO1G/O6pko8A6pYs9YQriGWhLxGOsAWt5QrAsQ=;
        b=QJJQfmg1Vsk/e99Pdd1B77NmhIIxCvwJN0XTkSV4NFeCzIranNc5QmMrgG5EocEXWj
         5vvbyKYZ46IohyXvo0xLwS5BVaAh/mriBcBnq+SLiVupzoE0+0sAACS8vqaAUv9mISdM
         FRiOizXeGZMCKo6nh/jPkBM0hfwONc4jbhwXujnaLHgrniueHfyWfqamcc6YKBQulOCw
         71OlgCWlN2c+8l4hBoM4L5thCp8EBFOlDxJD7zrsb01EWqH6ULT0f05nQnG6QmVzL4jq
         N4bcZGMau2ckp1ABGEq8Rcunld5zIavHD1M48+7uOBwc+eom01OfrULu/t0k3vYtgMMc
         +6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765913672; x=1766518472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oc7wkmO1G/O6pko8A6pYs9YQriGWhLxGOsAWt5QrAsQ=;
        b=n5qeoaEueUxAE6tXxwbFx0yRqJ8e6XvnzsXPU0gEMd+qhC3jmo77sVIFQnQwFxonYJ
         uhUgc8yDCl+dz6iQrCrT4fL1weIvbA5xAqlj69RhS4k53ese67F10WyXDcHtjGZ0GsQt
         yrcT3cAw3xyAiSeO3WV2yz7KGYzTuU+Y+V6McKvLqqTOQGNz4g/Ot6AQLUIcaEwViird
         9YIL5jIyj+E6E1YntWdIENdtAIx9V8w6tvtCqT/pLEfi9Hbcdd5G10MTsdXoye4Rr41R
         NQZlgiQi/BnOre69pvwdnBXPeGIWFXopUiFQqrlNgGwGyBL2Fz6R5IA+MlW7NvjEvNCa
         Mo3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRfF3MtbhzjkmYoeTb34BAQclRmCM/3CwiS88vT5QZl+nkwensDUmSfc86vpFnMYjMwLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFP9GmuF1i3wXSbHoecahHXjwtpUFt/nziRGh/ZCPBfXFP1/s
	TUzfBgyda6xg86eehvg07cTu4ds8pGzDnBBqwP1X9R9R0f1desbUNpOWq1C9Vjzhm7GZSFmxFi9
	zeqozTP7hT2z4Y+k0Ry5g42SzQY2BQm4=
X-Gm-Gg: AY/fxX5InqWpMDZbwPHBZQxDg6HRGsmtbPqoWngPQQfFzTJ8gUi+VOQQKxlLpW24Fny
	Tv5aMTmD82tLmNjW0Gs24rdOR17nVK3rwlh0p5Xccg3uzqrGjPlAnapCrL8ssm0+MxiIjvGH3ug
	6ia9oLpj17KZ53MsXUsparFNC+dehIH0x/GWDeuYu7yFB21zDCGF83Bg89dtTELnzD3nA3+MGV2
	MdPflUy0WAdlt5tmnhVLYAa6vmHi+nGNErTwsjgUUCZsqwMcM9/6UNtpsHsaNHYZmk4/XRQwmux
	G4Zq1Jem3b5XurHe4LJIpA==
X-Google-Smtp-Source: AGHT+IEsuGduX2I3bXsULyMkGChsdw2z5fq5cnIZQT+MZ84MVYQK1PlYH1Ek/DkKCc50LTlhFjXA528yfrA5Rwazwm8=
X-Received: by 2002:a17:903:37ce:b0:295:195:23b6 with SMTP id
 d9443c01a7336-29f26eff462mr157031955ad.55.1765913671737; Tue, 16 Dec 2025
 11:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-3-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:34:19 -0800
X-Gm-Features: AQt7F2r7RadIHnW-JtgmqkW2Axe8h6an67lvT1fjUpr8JKMz67Elo4iajzTAOP4
Message-ID: <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support reading in kind layout fixing endian issues on reading;
> also support writing kind layout section to raw BTF object.
> There is not yet an API to populate the kind layout with meaningful
> information.
>
> As part of this, we need to consider multiple valid BTF header
> sizes; the original or the kind layout-extended headers.
> So to support this, the "struct btf" representation is modified
> to always allocate a "struct btf_header" and copy the valid
> portion from the raw data to it; this means we can always safely
> check fields like btf->hdr->kind_layout_len.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 183 insertions(+), 77 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b136572e889a..8835aee6ee84 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -40,42 +40,53 @@ struct btf {
>
>         /*
>          * When BTF is loaded from an ELF or raw memory it is stored
> -        * in a contiguous memory block. The hdr, type_data, and, strs_da=
ta
> +        * in a contiguous memory block. The  type_data, and, strs_data

nit: two spaces, and so many commas around and ;) let's leave Oxford
comma, but comma after and is weird

>          * point inside that memory region to their respective parts of B=
TF
>          * representation:
>          *
> -        * +--------------------------------+
> -        * |  Header  |  Types  |  Strings  |
> -        * +--------------------------------+
> -        * ^          ^         ^
> -        * |          |         |
> -        * hdr        |         |
> -        * types_data-+         |
> -        * strs_data------------+
> +        * +--------------------------------+---------------------+
> +        * |  Header  |  Types  |  Strings  |Optional kind layout |

Space missing, boo. Keep diagrams beautiful!..

> +        * +--------------------------------+---------------------+
> +        * ^          ^         ^           ^
> +        * |          |         |           |
> +        * raw_data   |         |           |
> +        * types_data-+         |           |
> +        * strs_data------------+           |
> +        * kind_layout----------------------+
> +        *
> +        * A separate struct btf_header is allocated for btf->hdr,
> +        * and header information is copied into it.  This allows us
> +        * to handle header data for various header formats; the original=
,
> +        * the extended header with kind layout, etc.
>          *
>          * If BTF data is later modified, e.g., due to types added or
>          * removed, BTF deduplication performed, etc, this contiguous
> -        * representation is broken up into three independently allocated
> -        * memory regions to be able to modify them independently.
> +        * representation is broken up into four independent memory
> +        * regions.
> +        *
>          * raw_data is nulled out at that point, but can be later allocat=
ed
>          * and cached again if user calls btf__raw_data(), at which point
> -        * raw_data will contain a contiguous copy of header, types, and
> -        * strings:
> +        * raw_data will contain a contiguous copy of header, types, stri=
ngs
> +        * and optionally kind_layout.  kind_layout optionally points to =
a
> +        * kind_layout array - this allows us to encode information about
> +        * the kinds known at encoding time.  If kind_layout is NULL no
> +        * kind information is encoded.
>          *
> -        * +----------+  +---------+  +-----------+
> -        * |  Header  |  |  Types  |  |  Strings  |
> -        * +----------+  +---------+  +-----------+
> -        * ^             ^            ^
> -        * |             |            |
> -        * hdr           |            |
> -        * types_data----+            |
> -        * strset__data(strs_set)-----+
> +        * +----------+  +---------+  +-----------+   +-----------+
> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
> +        * +----------+  +---------+  +-----------+   +-----------+

nit: spaces (and if we go with "layout" naming, this will be short and
beautiful " Layout " ;)

> +        * ^             ^            ^               ^
> +        * |             |            |               |
> +        * hdr           |            |               |
> +        * types_data----+            |               |
> +        * strset__data(strs_set)-----+               |
> +        * kind_layout--------------------------------+

[...]

> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
>
>         /* replace BTF string data and hash with deduped ones */
>         strset__free(d->btf->strs_set);
> -       d->btf->hdr->str_len =3D strset__data_size(d->strs_set);
> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
>         d->btf->strs_set =3D d->strs_set;
>         d->strs_set =3D NULL;
>         d->btf->strs_deduped =3D true;
> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_dedu=
p *d)
>         d->btf->type_offs =3D new_offs;
>         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
>         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_len=
 + d->btf->hdr->str_len;
> +       if (d->btf->kind_layout) {
> +               d->btf->hdr->kind_layout_off =3D d->btf->hdr->str_off + r=
oundup(d->btf->hdr->str_len,
> +                                                                        =
     4);
> +               d->btf->raw_size =3D roundup(d->btf->raw_size, 4) + d->bt=
f->hdr->kind_layout_len;

maybe put layout data after type data, but before strings? rounding up
string section which is byte-based feels weird. I think old libbpf
implementations should handle all this well, because btf_header
explicitly specifies string section offset, no?

> +       }
>         return 0;
>  }
>
> --
> 2.39.3
>

