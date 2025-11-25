Return-Path: <bpf+bounces-75504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C86C87691
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 246D7353B9B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECE296BA2;
	Tue, 25 Nov 2025 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV5j4HE8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC001096F
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764111640; cv=none; b=acjQ2XkyhNd6D42AUi7xAdOMA7fetQbSVcrUNHAu2pb0qO4SyIgtWaorxl4JNyWVR1MfIDR+67UkFP71dCnF6COYYWt5zevEnA9mf5BzY+lHQwoI5GKc/z3YGgWuAcuVFtq4eWBYfw4Re03vSVL0apP0iDe1QFvHds93HsSfjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764111640; c=relaxed/simple;
	bh=jz9KHQ2NIaJ1nIgk99FREjAQtcOAoY+55PQQj/CgyW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLwwh/+AinlR4f7pwD1iphx5TTznE42on5WDl0FvlwvB+2MS/10ttZRUZbw0hbX8LZvyjVdUkCiep1BNhmGmCUHurRvP1nBlyNUYUalTBAs+aUheE/aY30hlVCO4gil7bfsnhsG/3GhXxcilX+4tWF4+kel+Rcwqk7dLRbMhc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV5j4HE8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3438231df5fso7909165a91.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764111638; x=1764716438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKB17VdFnHk9lWDDUotS5creHGGF927RPSx1K+PzuuM=;
        b=PV5j4HE8suBmdPKJ3rO5uCtBNtZ28PPtrWUrSKujBUSZmdzXHxN2blJvFdUOIk4CNO
         S/SbiJEmwhNSJOKKYhr51A46An/Vu5B53XumNgz0qWIVhiuoBpXvCsUb8G+a/q15b8YU
         5YAru24Sy/PYWFqypekLq1+Pa7gbnGQq1/Bv/tTUaVLjEGhTrLIixvX3UfI/Cw2M814g
         QnNGNtLfmHk/P/97L6ixZbvDRWa59pDBHo7F3/q0CDvUIOH8nEdYVVqf7e0X7v7ocaGo
         3emLJnUNYPcDG74ig4ZsOC8TTN2psHkscnMQk6euIiMtRebP+LfXl8wvz6UyLiOoiAeV
         JxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764111638; x=1764716438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKB17VdFnHk9lWDDUotS5creHGGF927RPSx1K+PzuuM=;
        b=Cq4rfe9y29g32qyliH7PGYkL5WU16WAWn8DTPhZyPca1I9XOSmJlSH1s1CS1QDw+wp
         TuinCEB2hM/vrHS65NMkobrG5K6AemAYw8Pga1lnmsVvypyQllpZBj6U/MyY6LtbwJbs
         4IhEnwwU79LlEw1ByR3xTARC/Vo8RVQ/E32M69gKhaQhHDGUuq61QsI+MzvS9EYsnLf5
         MMO0kmixdsyUaX74k138rNjeMM3hR6AyK2MSoJEUR2RbT4ZF0QjaSyZl68S/t5d3qJNi
         9q3WT8+711eF0ePRo/uSLxNfIDuEYRVJ63V4Ty3HT9yBG6PQiKuuu6sz7m0saHM7XMyA
         QLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXG5bpHhHdU9/xKmnsxq7Ziz0i8mKgm9eYJr6rmt1jd3lOGtBNKJ3uHDfRf0ei1CIgPA+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR82aVD1v5YVOtJttxea7UU1jcGB0JE4/Pmo7DDqbD5UWMpu5s
	wNTdu1lvl63J/b5MIW6ZfzhnoihQdLTfDhIyG3aPBNwXGdUqFJkrOS+mQ3E88C2pAnYfi/rJFOO
	RFsOLs+AA0abSSvROWSqmOdXVlIQirwc=
X-Gm-Gg: ASbGncvMmI9muUpmPw4RmgfW+UnMUOzzQqavr2jQqWf6T1T4oIUOHDqx/YLDYWYNc/x
	DIobn61XEKh65PkJUxlQPW8dtkhEkZUS7yCVYfV4WRXnhXkGeJ0p8lc5Q5+ZcMAEjnS8E9Qc9aI
	ZHYu1m9S/7tmy/Uz2mAup7od6w2/H3Srui95l36J4B9G+VI2piLKp7f7k4SVouhLZdwTpsj/cCr
	JLAKBLkNH6lpix0yGuc+YE5EpMmxRH5Rxc7UHtwjUEZRu5pFz9okU/ri+2+vn1juHldUGdUFxMb
	DV4v4F19+qg=
X-Google-Smtp-Source: AGHT+IHvbN/i6ytvR7tN9wvkBr5lchuBkDzpp2STAsmpTh3LbRGIx3WDAoAhzXaJlIES1C+x4dhm1fpjewcmMQpTve8=
X-Received: by 2002:a17:90a:ec84:b0:341:d326:7354 with SMTP id
 98e67ed59e1d1-3475ed6d58bmr5053916a91.37.1764111636098; Tue, 25 Nov 2025
 15:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120224256.51313-1-alan.maguire@oracle.com>
In-Reply-To: <20251120224256.51313-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Nov 2025 15:00:24 -0800
X-Gm-Features: AWmQ_bmPtw9i48n5D25tzW0Zc9Cg-XQMw_2tGdJa-O_8vAXp6siNcJM1kh-02oM
Message-ID: <CAEf4BzaDx52argxexyaG3AbvsfQzjmftqrT=xWNuRqfvORM9-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:43=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> We have seen a number of issues like [1]; failures to deduplicate
> key kernel data structures like task_struct.  These are often hard
> to debug from pahole even with verbose output, especially when
> identity/equivalence checks fail deep in a nested struct comparison.
>
> Here we add debug messages of the form
>
> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but =
differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0
>
> These will be emitted during dedup from pahole when --verbose/-V
> is specified.  This greatly helps identify exactly where dedup
> failures are experienced.
>
> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@orac=
le.com/
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 84a4b0abc8be..c220ba1fbcab 100644
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
> @@ -4497,8 +4500,18 @@ static bool btf_dedup_identical_types(struct btf_d=
edup *d, __u32 id1, __u32 id2,
>                 for (i =3D 0, n =3D btf_vlen(t1); i < n; i++, m1++, m2++)=
 {
>                         if (m1->type =3D=3D m2->type)
>                                 continue;
> -                       if (!btf_dedup_identical_types(d, m1->type, m2->t=
ype, depth - 1))
> +                       if (!btf_dedup_identical_types(d, m1->type, m2->t=
ype, depth - 1)) {
> +                               /* provide debug message for named types.=
 */
> +                               if (t1->name_off) {
> +                                       pr_debug("%s '%s' (size %d vlen %=
d) appears equal but differs for %d-indexed members '%s'/'%s'\n",

Honestly, reading this message in the commit description above I was a
bit confused about what it actually means... "appears equal" refers to
shallow equality check passing, right? Given this is for debugging,
just use consistent terminology here, maybe? It's for you, me, Eduard,
Ihor, maybe a few more people, so we don't have to invent UX-friendly
allegories here :) Just say "are shallow-equal" or something like
that, maybe? As for "%d-indexed", IMO, "field #%d" would be
unambiguous.

 Also, I saw you reply to Eduard, but I still think that if I were to
debug this I'd like to know original type IDs of structs involved to
be able to look at raw BTF dump and dive deeper? We have consistent
"[%u] %s" pattern for referring to BTF types, let's use that here to
identify two structs/unions involved?

Also, is size/vlen really useful? I bet you'd still be looking at raw
BTF output to check details about the struct/union, and there the
size/vlen is readily available. Just curious if it's really that
useful to have it here.

pw-bot: cr


> +                                                k1 =3D=3D BTF_KIND_STRUC=
T ? "struct" : "union",
> +                                                btf__name_by_offset(d->b=
tf, t1->name_off),
> +                                                t1->size, btf_vlen(t1), =
i,
> +                                                btf__name_by_offset(d->b=
tf, m1->name_off),
> +                                                btf__name_by_offset(d->b=
tf, m2->name_off));

field names will be identical, guaranteed by shallow-equal check, why
logging twice?

> +                               }
>                                 return false;
> +                       }
>                 }
>                 return true;
>         }
> @@ -4739,8 +4752,21 @@ static int btf_dedup_is_equiv(struct btf_dedup *d,=
 __u32 cand_id,
>                 canon_m =3D btf_members(canon_type);
>                 for (i =3D 0; i < vlen; i++) {
>                         eq =3D btf_dedup_is_equiv(d, cand_m->type, canon_=
m->type);
> -                       if (eq <=3D 0)
> +                       if (eq <=3D 0) {
> +                               /* provide debug message for named types =
only;

please use more "canonical" comment style

> +                                * too many anon struct/unions match.
> +                                */
> +                               if (cand_type->name_off) {
> +                                       pr_debug("%s '%s' (size %d vlen %=
d) appears equivalent but differs for %d-indexed cand/canon member '%s'/'%s=
': %d\n",
> +                                                cand_kind =3D=3D BTF_KIN=
D_STRUCT ? "struct" : "union",
> +                                                btf__name_by_offset(d->b=
tf, cand_type->name_off),
> +                                                vlen, cand_type->size, i=
,
> +                                                btf__name_by_offset(d->b=
tf, cand_m->name_off),
> +                                                btf__name_by_offset(d->b=
tf, canon_m->name_off),

same question about field names, can they be different here ever?

> +                                                eq);
> +                               }
>                                 return eq;
> +                       }
>                         cand_m++;
>                         canon_m++;
>                 }
> --
> 2.39.3
>

