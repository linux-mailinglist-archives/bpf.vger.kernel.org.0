Return-Path: <bpf+bounces-79103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C74D27154
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABC4C307F8A6
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6A3ECBD1;
	Thu, 15 Jan 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH2xm1Dy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749853ECBC2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499452; cv=pass; b=S+SHFr/w7+xM6QuAGbihfw6dTFLUTbQdBDFzAQ8zFxzMnOix0ZyxuCE26hewESF0zWMugbFroPV6ULMyDUZ4J79CLrzfhynFbaYVChpY3ekvir3Rv3GB57iTPPLAxux5WhfcTYhj9pUyKgwMH06mhueMZbF7iZz/nDpm69VIGBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499452; c=relaxed/simple;
	bh=ojjPyeHcm3BtKS6yvdU5MHAm2AVrykXO4qur5Wq9yNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjrZXrzhZbVewWr4ldKKWYFve2fv7NrjGlPjbIkk/oNfyxVNOFxwPbhurETPpigLQh2XMVBmVnLpwg93h9kQAg1vNxIIgLPEKXvHWu1iygMpLs2MOyfkI3zAXjGFD3itwjKxlHB+IsJe2kRVbwHJfJxpnHW7558hU8MC48Td96w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH2xm1Dy; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so594709a91.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768499451; cv=none;
        d=google.com; s=arc-20240605;
        b=N28kGUVDsDcPFoIt7bM7fod/xR4KIPLo1vnFRvFvD3uvvcvutuf9E2Kd9l7PenBPv9
         YUN3wkxJGajvkgf4G9+zNBGTHo23d0fHZ6ctSN289ifpFsRv/LyMrvska7o3L6mYPRV/
         2lE2cE1s3wVtDF+WQt9ljJamcj8ObjsJKj4e1yKg7IhohEcxaa0/MJwF6XL0ubRc329N
         8gVcBBPTY7KCaFz15UKSbuo3hLlE83kOZub8mi20rT/b4iDeV2EQYHbieVHakZ5qSiI5
         E2N+P7vY3BX8lUTdQ9bja+Ijpm9/6BBWZQfpl5chOAkdksa1UMeLsJ4+D8aaO2rP5U6J
         6a3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tP4w6lLzIVzGN/TMRTiK/TgWKWpAjw2fOPu72FGfpB4=;
        fh=vl5NQrwJ1u0XmVhwoN9Ruj1ugNPIZQL3fGGiRkPeJt8=;
        b=jKu/1UGYI3fvGVuvT6ka6udn3L6wE7tBwHQLaFnRpb9q+dr76fTP+4CCrCQZimP/tR
         OhiqbP95Y+y2F7oJ6z3KGfdrJm0FHKg2F08txAE8mgdzsJZiPP44M5wduNzo5p6hCAgC
         +M77exkWDTFISw9b0ZdsBsuaF04ugND4beJA2w0Nd+wb4ulX2RFTkEAgOZWq1MFKureR
         VSehBWa1LGroOaaczlHCC4vmARH7KCXmEx1hKUnExwHEdZf5ySScvqOZR/8PrWCMEEtJ
         OsUIQvbavsMIOCxmTSuJWJGW8wJDdTPOBUrpuM3/dicdeJ3ETqky5m0X5CnMPQW/ExDS
         SNrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768499451; x=1769104251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP4w6lLzIVzGN/TMRTiK/TgWKWpAjw2fOPu72FGfpB4=;
        b=bH2xm1Dy47F8QIlAHCADYrhM6b68V6K1diSSNcl73gtpnmZXxa8jDhDGpe74mklJDg
         EzwWDNMjqYVUe2Tkj/5/h0LMxKgM7lkHlYhICvCqTtnTBwhlx8vYhlt4E9lv1D/WkGnp
         E5XMkGka7b71SmuSek5hqg4yBqwrupDQKngtYK7/SpFVZo1xlDEs/boUwlcksi/M7aL0
         ls1Ac784V2OSMsENh9dSP2uzUoq8Jq3EAN+v3zZdl3UYAhEWtwEMegpiVq3lfOY287Mw
         +rXzkNgssHr0sdi3tryFDwWL6w/nyIDwWkeFpHWySM9eHYRPa24qZW9BKfYsj0Pa06PG
         RWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499451; x=1769104251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tP4w6lLzIVzGN/TMRTiK/TgWKWpAjw2fOPu72FGfpB4=;
        b=R92XslazQc06GxH/7hBpZHCkNeR4RoTwGEXlO8c+Uy5N41GB4F4ccRSWnM3FMjkufO
         Zx7myOgeWoITzzDWSq20EaRkWadpTa5LB6J5pS25FhI4tsg+6gXYErFDy9L9oOo99L17
         9HP6OY6/iY7ELr+TiqfbAkgWjF/b2sT3lZk6usszM4skujF3Q6gBuxjQ6/evcNY5ATBL
         3+yPsJ4WiEngmMSM2x+qZzZQ+JLBDUch/PWXSmiUa8PHGUJfujTggDxeWhoTt3k7T4e9
         nahVPVXkpI6BBzqIs+2EanAVV2iZsSDn9fRYKXfYEiwdkgTMV0gRh6MfRxFCuuJFSJ2D
         SzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhyKzYgty+u0wu3h74N+p5i76dLFHpHxDb2eWfkkYXfJ1moZBmUUzKcP3enpcjK+4CE1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcxspwqlRkimeb3bZMDMWdS8glCGD7wDH6mQMINEe6C9zSBdK
	fCUn7N0kfHb1Cql3Iu9JkBYfSDouQ+lMwSk+dvVWSBIAKhtQVwT3qliT8QRO19aejXDj72+4Gj/
	EVOL7JNniFh4Z4IVka677FdnWALAysUc=
X-Gm-Gg: AY/fxX7Si1wBvqmv0r8VVq6nMDNvGEmyxKfSDrmkNY/T51xaX7IfQjPSLRkORx49vSe
	Mb5xDjyeZbF524KdWD2srXAl/Iwe6m32tNpTnGXgPrkI27fgyrjDtsRrbg1kcDTaFBUE6u3zqaS
	Ivtn5Gqyhf233X2vsk7xYPKN0gvo05dvanHL+cw5LZ0y6gyW+uTi2e8LoDGUW7L5VcVtVcRmA9B
	hFDpzjN/uVI2Je9IFIofekfabBNLoKAs1SOfScwXaEJO7CUEYjaG5lLmKw5UrQKnx0XXYvWJfC4
	DI+xh9ckEU3b3L4Upyw=
X-Received: by 2002:a17:90b:2f45:b0:34c:c514:ee1f with SMTP id
 98e67ed59e1d1-35272edb200mr195187a91.11.1768499450743; Thu, 15 Jan 2026
 09:50:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114183808.2946395-1-alan.maguire@oracle.com> <20260114183808.2946395-2-alan.maguire@oracle.com>
In-Reply-To: <20260114183808.2946395-2-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 09:50:38 -0800
X-Gm-Features: AZwV_Qh__YNI_av8vn-sXN0g1tqfV8G4nq87mdCZMdMk5x7XsGuKtYk2yXMNriE
Message-ID: <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] libbpf: BTF dedup should ignore modifiers in
 type equivalence checks
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, yonghong.song@linux.dev, nilay@linux.ibm.com, 
	ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, bvanassche@acm.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> We see identical type problems in [1] as a result of an occasionally
> applied volatile modifier to kernel data structures. Such things can
> result from different header include patterns, explicit Makefile
> rules, and in the KCSAN case compiler flags.  As a result consider
> types with modifiers const, volatile and restrict as equivalent
> for dedup equivalence testing purposes.
>
> Type tag is excluded from modifier equivalence as it would be possible
> we would end up with the type without the type tag annotations in the
> final BTF, which could potentially lead to information loss.
>
> Importantly we do not update the hypothetical map for matching types;
> this allows us to match in both directions where the canonical has
> the modifier _and_ when it does not.  This bidirectional matching is
> important because in some cases we need to favour the modifier,
> and in other cases not.  Consider split BTF; if the base BTF has
> a struct containing a type without modifier and the split has the
> modifier, we want to deduplicate and have base type as canonical.
> Also if a type has a mix of modifier and non-modifier qualified
> types we want it to deduplicate against a possibly different mix.
> See the following selftest for examples of these cases.
>
> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linu=
x.ibm.com/
>
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>

Alan,

I do not like this approach and I do not want to teach BTF dedup to
ignore random volatiles. Let's either work with KCSAN folks to fix
__data_racy discrepancy or add some option to pahole to strip
volatiles (but not by default, only if KCSAN is enabled in Kconfig)
before dedup (and thus we can't do that in resolve_btfids,
unfortunately; it has to go into pahole).

Furthermore, it seems like __data_racy is meant to be used with
*variables*, not as part of *field* declaration ([0]), so perhaps it
was a mistake to add those to fields. Note, there are just *TWO*
fields with __data_racy:

include/linux/blkdev.h
498:    unsigned int __data_racy rq_timeout;

include/linux/backing-dev-defs.h
174:    unsigned long __data_racy ra_pages;

So NACK to this approach, let's find a better solution that doesn't
involve compromising the BTF dedup algorithm.

pw-bot: cr

  [0] tools/memory-model/Documentation/access-marking.txt


> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 83fe79ffcb8f..74c93e936d1c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4734,20 +4734,15 @@ static int btf_dedup_is_equiv(struct btf_dedup *d=
, __u32 cand_id,
>                 return 0;
>         }
>
> -       if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> -               return -ENOMEM;
> -
>         cand_type =3D btf_type_by_id(d->btf, cand_id);
>         canon_type =3D btf_type_by_id(d->btf, canon_id);
>         cand_kind =3D btf_kind(cand_type);
>         canon_kind =3D btf_kind(canon_type);
>
> -       if (cand_type->name_off !=3D canon_type->name_off)
> -               return 0;
> -
>         /* FWD <--> STRUCT/UNION equivalence check, if enabled */
> -       if ((cand_kind =3D=3D BTF_KIND_FWD || canon_kind =3D=3D BTF_KIND_=
FWD)
> -           && cand_kind !=3D canon_kind) {
> +       if ((cand_kind =3D=3D BTF_KIND_FWD || canon_kind =3D=3D BTF_KIND_=
FWD) &&
> +           cand_type->name_off =3D=3D canon_type->name_off &&
> +           cand_kind !=3D canon_kind) {
>                 __u16 real_kind;
>                 __u16 fwd_kind;
>
> @@ -4761,12 +4756,34 @@ static int btf_dedup_is_equiv(struct btf_dedup *d=
, __u32 cand_id,
>                         if (fwd_kind =3D=3D real_kind && canon_id < d->bt=
f->start_id)
>                                 d->hypot_adjust_canon =3D true;
>                 }
> +               if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> +                       return -ENOMEM;
>                 return fwd_kind =3D=3D real_kind;
>         }
>
> -       if (cand_kind !=3D canon_kind)
> +       /*
> +        * Types are considered equivalent if modifiers (const, volatile,
> +        * restrict) are present for one but not the other.
> +        */
> +       if (cand_kind !=3D canon_kind) {
> +               __u32 next_cand_id =3D cand_id;
> +               __u32 next_canon_id =3D canon_id;
> +
> +               if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
> +                       next_cand_id =3D cand_type->type;
> +               if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type=
))
> +                       next_canon_id =3D canon_type->type;
> +               if (cand_id =3D=3D next_cand_id && canon_id =3D=3D next_c=
anon_id)
> +                       return 0;
> +               return btf_dedup_is_equiv(d, next_cand_id, next_canon_id)=
;
> +       }
> +
> +       if (cand_type->name_off !=3D canon_type->name_off)
>                 return 0;
>
> +       if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> +               return -ENOMEM;
> +
>         switch (cand_kind) {
>         case BTF_KIND_INT:
>                 return btf_equal_int_tag(cand_type, canon_type);
> --
> 2.31.1
>

