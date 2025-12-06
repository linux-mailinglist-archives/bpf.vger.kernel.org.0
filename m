Return-Path: <bpf+bounces-76198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BD5CA9AEE
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 01:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8969A300AB0D
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A473318DB35;
	Sat,  6 Dec 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az1Qb5/T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A21487E9
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980075; cv=none; b=LZ0riIEHXl8OOsPMwAVgz+7rIvTkJjvh2+NBd8hZs5aakN8J6Z1N4fs2whf5ZvAD+6vzFfOAqUfxF7oSWg1MntTrxJQarp0bBqXdolg8tV+3crKmForA9601ftxnL1bkR2vzxAMsBk5J6db+J0n6YvOPhxYmsohoq1OMAUrZyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980075; c=relaxed/simple;
	bh=gWNyNMb4QFiVRxwyjUff+0vpvYXrf5bUTGFJIimmCjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRmm2VsBpBmyDPS/vwVi+5yDsQVmfq090fHlIs5TNBBNweXNobnjd7xo3cDPdIdHf1LqOarsEqTkCnmqgAuBicdWvEU/Lk0+I+zLPNOKD3tfAqXCkrmmKg9eN60760dgtmLfTn9vh6FFCWU//G7IeueJ5XXdQX4Rs6wTdqspTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az1Qb5/T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29806bd47b5so16364755ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 16:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764980072; x=1765584872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md29tIUdzoL4AYvvH0Ep3hgYCz/6ovWIQof3lwHkcZ4=;
        b=az1Qb5/Tb8dYQEZvWFmD8l3I5SpeQCGjcvgaSq5UeriR4TnlPKkhBhbZUDxFuBpvBa
         B5JgPmD8NT45QyS/h+BLcllnwfZJKvecgULdjTKdpimxCG57k/54f57sFFKa/mfvHhtJ
         c3nrE3igulB3h2T4Rj4GfttqYSPL5gonfu0v2y4VpUoUfdr9bDfsYFBmmI72uSPk9ut+
         cXqHPCfS3u0BE2vgtzGkrt+Y3cnuGrWdXsen1LE+HTCRRoQnEy1jbSRTL85voAeAtf5/
         JEoeWcozx4SPXM14yu+5pd0xJ/Djb9YYkrzPAdACIfs90sqmhdzUGguIlF6vLmukE2mq
         bgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980072; x=1765584872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Md29tIUdzoL4AYvvH0Ep3hgYCz/6ovWIQof3lwHkcZ4=;
        b=ULRDG+50O3y8TDanzA45dqW+Fo6x4qgV4fftAyoJ2/nRf6ePwyO1bYkI6zqSYpkmSZ
         CZ0LPzmLL3LJw2ZP6Uj2Dma7EzsjSGkS5d4cowupl1sYWETzid44+4XD4laJgAuXqVhF
         hGKibcyXZcm8V3RH/dW4/+mJ+cPns20iylDTL3vlLh3VzkMq/RcoC1Ec4MmCg8RsdT7Y
         wVBCprHbVdWrtVNEEWfRsbIyhoYvaMtbZKKaFK1GMfFjVeKqk1LkqroarcFAJG4ZCYQP
         VveTIIL6qEzLzJRrsqMcZUXlZ9bN8qrRGttgRTz52T5+dBPjJdIHM0mJjzMMsE0P7i3k
         RzKg==
X-Forwarded-Encrypted: i=1; AJvYcCWBTbA8UEHnPgc0BmaPOjTh8+NJ8AH3Rmny5NvVJ2zD7NxS8JYVb2jnMUX2Ui/8iCTkKKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOWLAvrGpEzJ/NrWI2mp1m0pbYHfBKk5uExNkL3n08JyKgYbk
	w7yZTbsITHXleFZWEGGGzl7ld2hTEjDhTq215yC80mjNzH2JpuMMBPgjvt927EiGtm/PMLH/OdQ
	V1ZFZx/HO2W8a/YTduRsTNdShWRfuiwc=
X-Gm-Gg: ASbGncsaBl4eYnLrMMIghA0aEcbm/lAnpEQv0tQ0LfJRmlMMrHD99tPE2aT6UrPHu+j
	w9vf9FkK9dCj8+SpT03QZq6uTyFrSuch3LlQqMulFMKEGi0QmfZj3LOzIcuZVASF8cCUn+vOIx2
	wxJRFeV+U2z6BNhXRztBYPrB665H2foFfXO0gqwkoF7WKDzguWDWuEWPgi3ijKAFWkTao7C9xoT
	8MryeUnm7+E+T/dm6rn7z4FL4heksvw/Rll7ttPf8oNMi1qKCOCeZXOgjMk2tNaPa0BSLPp/7//
	1vx35S3RfAk=
X-Google-Smtp-Source: AGHT+IHOJknJCaiBXyhlLq+FkM7KliKBNH/sIdecQXM8CyqZR5r1KxTx1yz26v88dtUvsfbf8hV1VTJrU6NF62CZlDQ=
X-Received: by 2002:a17:903:986:b0:295:105:c87d with SMTP id
 d9443c01a7336-29df5ca8490mr5808745ad.32.1764980072136; Fri, 05 Dec 2025
 16:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203191507.55565-1-alan.maguire@oracle.com>
In-Reply-To: <20251203191507.55565-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:14:19 -0800
X-Gm-Features: AWmQ_bnHFKeWipB_QNEUKr-gd-HBZSmwOH7wxVFZfaOeFsoQWpgfIakx1OES7cc
Message-ID: <CAEf4Bzanmi6DCSFdsKheW8Ymz0xUtPR-R3EtPBPVYY01OXVpbg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
To: Alan Maguire <alan.maguire@oracle.com>
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> We have seen a number of issues like [1]; failures to deduplicate
> key kernel data structures like task_struct.  These are often hard
> to debug from pahole even with verbose output, especially when
> identity/equivalence checks fail deep in a nested struct comparison.
>
> Here we add debug messages of the form
>
> libbpf: STRUCT 'task_struct' size=3D2560 vlen=3D194 cand_id[54222] canon_=
id[102820] shallow-equal but not equiv for field#23 'sched_class': 0
>
> These will be emitted during dedup from pahole when --verbose/-V
> is specified.  This greatly helps identify exactly where dedup
> failures are experienced.
>
> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@orac=
le.com/
>
> Changes since v1:
>
> - updated debug messages to refer to shallow-equal, added ids (Andrii)
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 84a4b0abc8be..e5003885bda8 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4431,11 +4431,14 @@ static bool btf_dedup_identical_types(struct btf_=
dedup *d, __u32 id1, __u32 id2,
>         struct btf_type *t1, *t2;
>         int k1, k2;
>  recur:
> -       if (depth <=3D 0)
> -               return false;
> -
>         t1 =3D btf_type_by_id(d->btf, id1);
>         t2 =3D btf_type_by_id(d->btf, id2);
> +       if (depth <=3D 0) {
> +               pr_debug("Reached depth limit for identical type comparis=
on for '%s'/'%s'\n",
> +                        btf__name_by_offset(d->btf, t1->name_off),
> +                        btf__name_by_offset(d->btf, t2->name_off));
> +               return false;
> +       }
>
>         k1 =3D btf_kind(t1);
>         k2 =3D btf_kind(t2);
> @@ -4497,8 +4500,17 @@ static bool btf_dedup_identical_types(struct btf_d=
edup *d, __u32 id1, __u32 id2,
>                 for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2++)=
 {
>                         if (m1->type =3D=3D m2->type)
>                                 continue;
> -                       if (!btf_dedup_identical_types(d, m1->type, m2->t=
ype, depth - 1))
> +                       if (!btf_dedup_identical_types(d, m1->type, m2->t=
ype, depth - 1)) {
> +                               /* Provide debug message for named types.=
 */

applied the patch to bpf-next, but dropped this comment and the one
below, so patchbot is not going to send a notification

> +                               if (t1->name_off) {
> +                                       pr_debug("%s '%s' size=3D%d vlen=
=3D%d id1[%u] id2[%u] shallow-equal but not identical for field#%d '%s'\n",
> +                                                k1 =3D=3D BTF_KIND_STRUC=
T ? "STRUCT" : "UNION",
> +                                                btf__name_by_offset(d->b=
tf, t1->name_off),
> +                                                t1->size, btf_vlen(t1), =
id1, id2, i,
> +                                                btf__name_by_offset(d->b=
tf, m1->name_off));
> +                               }
>                                 return false;
> +                       }
>                 }
>                 return true;
>         }
> @@ -4739,8 +4751,20 @@ static int btf_dedup_is_equiv(struct btf_dedup *d,=
 __u32 cand_id,
>                 canon_m =3D btf_members(canon_type);
>                 for (i =3D 0; i < vlen; i++) {
>                         eq =3D btf_dedup_is_equiv(d, cand_m->type, canon_=
m->type);
> -                       if (eq <=3D 0)
> +                       if (eq <=3D 0) {
> +                               /*
> +                                * Provide debug message for named types =
only;
> +                                * too many anon struct/unions match.
> +                                */
> +                               if (cand_type->name_off) {
> +                                       pr_debug("%s '%s' size=3D%d vlen=
=3D%d cand_id[%u] canon_id[%u] shallow-equal but not equiv for field#%d '%s=
': %d\n",
> +                                                cand_kind =3D=3D BTF_KIN=
D_STRUCT ? "STRUCT" : "UNION",
> +                                                btf__name_by_offset(d->b=
tf, cand_type->name_off),
> +                                                cand_type->size, vlen, c=
and_id, canon_id, i,
> +                                                btf__name_by_offset(d->b=
tf, cand_m->name_off), eq);
> +                               }
>                                 return eq;
> +                       }
>                         cand_m++;
>                         canon_m++;
>                 }
> --
> 2.39.3
>

