Return-Path: <bpf+bounces-73682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF4AC3741C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6183ADFC5
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450F33BBB9;
	Wed,  5 Nov 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYYUlkq3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5732D0E3
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366289; cv=none; b=rE4OJMRdNrI4PzAauzEEIFb7QdJgH9iI0mIZEcR5SdtkHBWCoDekYbV3DA0PWJqmDMMHmA1ZuV4pHuqu9bZf8h8EJ8icIWradzT5kordJjp2Frc8eNMrJ8hhI2LTDDNcVs2YlAh/XkDYpW0+Iwh5GBG5yUw3oCZArsjBHR4G2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366289; c=relaxed/simple;
	bh=pIEoMImbfmFv1VQ8NFEqaIHCi19n/tF8mrFzfb2ekJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+zNMqItmU4mOHAHCbiukvqkaSBXlfB0Ev37h9V/ODNwCll/GTWprXUCUf6BqxDYLdTnbGV9KZuad81WvsL+RA0AqBdWJTrV0ltygSMI3Q7rr2U+TTWI8kB1ziOu4Kg4rfZ53sHw6idT7z1ejEHLOij1PlOtoaaWse20DrXSZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYYUlkq3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso176381a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 10:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762366285; x=1762971085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmw/L1MiFhMAbgh9WFlcUnoGsXLmqR25URVgTg+0nQg=;
        b=aYYUlkq3YPmt8ynjGsnHjMbfZ91gsfeHB/JPV7w+jx+4EcI/TCoZbgqJ49OwGjTfaZ
         iXESn7xcIFW64QJNDGVNAOhqNiiZLmqD5LKf326/X88+0PPNhMrcise3dI0n886rYPF0
         OAkn2FNdCXO8kwBdoeb23ZvNVGIeSWjPIZ4qljKAVc67Elg52t87frraPCjiLgAUyGvT
         61UzNvL9i76Tg+gADYMmzQQt6VD6/xdN9eEQhMi+vZTCEHdWDXWL+G/WIET1hJ0n6i/5
         Z6hcJDZPYQ3zBDDdezw+D+jgpHFEjJkkZLO5KRKgDDr/FCGYQOho9BuyYfmjlpohHDpw
         wyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366285; x=1762971085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kmw/L1MiFhMAbgh9WFlcUnoGsXLmqR25URVgTg+0nQg=;
        b=LUC3hX0cghUTMajekVQuyK1GSb9pJj1KL7Fiq13+y66xAirUN811s4OoZyUwstocnJ
         fSmKbKmF3IsBXEgNNRqheKkeJWOAnypYiELqOTO+8AKHtylH147M5oAYXbuuurFXm1IW
         rZuEZPC6NIl94tltvNvowMreyUF21AO1jtj0YoQRyvfbqOgtY3fBHJoOo2P0shW+7cvo
         Bj8x/22qBoJtd2EOdyaoYyr8GJe4HCEUp+c/RC1uBWPHgkxdO5yN4rUIU4rq5/hxRKhA
         ETLBMJOI3nTpFR8D9qaQrT1SB3GbqayC1daWnNN4z2UoyUAUsVYTNiolan3tEDbuMZrP
         2WkA==
X-Forwarded-Encrypted: i=1; AJvYcCW4gPIrtcOUo8vRBjKtUZBpe7u5e/BtAEItM3PaPv1elxs7Ua4t32IsisZiQhBid7fD7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdopO+Jcw4AqwfLED++bjdhUHqZCXjOtmIzTFqgE4m+2trajzc
	1WTyYf85pG6MxAkIQQMWTiMHRrVs9nTctjncib9kfBlMFtYMgdr/nKsWYqcSU+IyVGIRrwCctU4
	mz1B6wdaNXr57bcDR9BvcehwazCoDjpk=
X-Gm-Gg: ASbGncv46xo9EIbhc1m8cuohaZU3gSQoxckVuFZEKdqgZelB6IhygWjCCP27Ik08cX/
	uWDLhyMCmgyPlakI2nYtaHgX2GMMIutJ9AF92pzgsNBLuR5H2jwqOaPINWV2CSqh3IIi6bShseY
	z5TC9ZPKfMgErSIg8K6+gt8bpCX4wCBEd4QmxYgIQiILc/POy+2dlsg3wgHrXBzUJbWeS6MmwEq
	jM2gCc1Yoxmiclplq+6CdZ6kN9sU0trwTHtFy4lw+6uMhluwUB2B5+dwNWY
X-Google-Smtp-Source: AGHT+IE3pH14Mzw70YOzPiLwkuFh1R0gxgX2TyQhNiM9gIVa/WbUBcqZGYOV9py+BA/y6Dd0DdDRlcfIJrEvUnmC9CU=
X-Received: by 2002:a17:90b:1844:b0:340:c151:2d6c with SMTP id
 98e67ed59e1d1-341a6deaf38mr5036226a91.29.1762366285478; Wed, 05 Nov 2025
 10:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-4-dolinux.peng@gmail.com> <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
 <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com> <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
In-Reply-To: <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 10:11:13 -0800
X-Gm-Features: AWmQ_bkvEnz3AMDh59gnBVByLzHCuD0_tXvTHG5Sqjd27rI1PE_lsl9_xEnYCNA
Message-ID: <CAEf4Bzb3Eu0J83O=Y4KA-LkzBMjtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:48=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > >
> > > > [...]
> > > >
> > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *=
btf, __u32 type_id)
> > > > > >         return type_id;
> > > > > >  }
> > > > > >
> > > > > > -__s32 btf__find_by_name(const struct btf *btf, const char *typ=
e_name)
> > > > > > +/*
> > > > > > + * Find BTF types with matching names within the [left, right]=
 index range.
> > > > > > + * On success, updates *left and *right to the boundaries of t=
he matching range
> > > > > > + * and returns the leftmost matching index.
> > > > > > + */
> > > > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf *b=
tf, const char *name,
> > > > > > +                                               __s32 *left, __=
s32 *right)
> > > > >
> > > > > I thought we discussed this, why do you need "right"? Two binary
> > > > > searches where one would do just fine.
> > > >
> > > > I think the idea is that there would be less strcmp's if there is a
> > > > long sequence of items with identical names.
> > >
> > > Sure, it's a tradeoff. But how long is the set of duplicate name
> > > entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> > > with high likelihood will take more comparisons.
> >
> > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sort =
| uniq -c | sort -k1nr | head
> >   51737 '(anon)'
> >     277 'bpf_kfunc'
> >       4 'long
> >       3 'perf_aux_event'
> >       3 'workspace'
> >       2 'ata_acpi_gtm'
> >       2 'avc_cache_stats'
> >       2 'bh_accounting'
> >       2 'bp_cpuinfo'
> >       2 'bpf_fastcall'
> >
> > 'bpf_kfunc' is probably for decl_tags.
> > So I agree with you regarding the second binary search, it is not
> > necessary.  But skipping all anonymous types (and thus having to
> > maintain nr_sorted_types) might be useful, on each search two
> > iterations would be wasted to skip those.

fair enough, eliminating a big chunk of anonymous types is useful, let's do=
 this

>
> Thank you. After removing the redundant iterations, performance increased
> significantly compared with two iterations.
>
> Test Case: Locate all 58,719 named types in vmlinux BTF
> Methodology:
> ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
>
> Two iterations:
> | Condition          | Lookup Time | Improvement |
> |--------------------|-------------|-------------|
> | Unsorted (Linear)  | 17,282 ms   | Baseline    |
> | Sorted (Binary)    | 19 ms       | 909x faster |
>
> One iteration:
> Results:
> | Condition          | Lookup Time | Improvement |
> |--------------------|-------------|-------------|
> | Unsorted (Linear)  | 17,619 ms   | Baseline    |
> | Sorted (Binary)    | 10 ms       | 1762x faster |
>
> Here is the code implementation with a single iteration approach.
> I believe this scenario differs from find_linfo because we cannot
> determine in advance whether the specified type name will be found.
> Please correct me if I've misunderstood anything, and I welcome any
> guidance on this matter.
>
> static __s32 btf_find_type_by_name_bsearch(const struct btf *btf,
> const char *name,
>                                                 __s32 start_id)
> {
>         const struct btf_type *t;
>         const char *tname;
>         __s32 l, r, m, lmost =3D -ENOENT;
>         int ret;
>
>         /* found the leftmost btf_type that matches */
>         l =3D start_id;
>         r =3D btf__type_cnt(btf) - 1;
>         while (l <=3D r) {
>                 m =3D l + (r - l) / 2;
>                 t =3D btf_type_by_id(btf, m);
>                 if (!t->name_off) {
>                         ret =3D 1;
>                 } else {
>                         tname =3D btf__str_by_offset(btf, t->name_off);
>                         ret =3D !tname ? 1 : strcmp(tname, name);
>                 }
>                 if (ret < 0) {
>                         l =3D m + 1;
>                 } else {
>                         if (ret =3D=3D 0)
>                                 lmost =3D m;
>                         r =3D m - 1;
>                 }
>         }
>
>         return lmost;
> }

There are different ways to implement this. At the highest level,
implementation below just searches for leftmost element that has name
>=3D the one we are searching for. One complication is that such element
might not event exists. We can solve that checking ahead of time
whether the rightmost type satisfied the condition, or we could do
something similar to what I do in the loop below, where I allow l =3D=3D r
and then if that element has name >=3D to what we search, we exit
because we found it. And if not, l will become larger than r, we'll
break out of the loop and we'll know that we couldn't find the
element. I haven't tested it, but please take a look and if you decide
to go with such approach, do test it for edge cases, of course.

/*
 * We are searching for the smallest r such that type #r's name is >=3D nam=
e.
 * It might not exist, in which case we'll have l =3D=3D r + 1.
 */
l =3D start_id;
r =3D btf__type_cnt(btf) - 1;
while (l < r) {
    m =3D l + (r - l) / 2;
    t =3D btf_type_by_id(btf, m);
    tname =3D btf__str_by_offset(btf, t->name_off);

    if (strcmp(tname, name) >=3D 0) {
        if (l =3D=3D r)
            return r; /* found it! */
        r =3D m;
    } else {
        l =3D m + 1;
    }
}
/* here we know given element doesn't exist, return index beyond end of typ=
es */
return btf__type_cnt(btf);


We could have checked instead whether strcmp(btf__str_by_offset(btf,
btf__type_by_id(btf, btf__type_cnt() - 1)->name_off), name) < 0 and
exit early. That's just a bit more code duplication of essentially
what we do inside the loop, so that if (l =3D=3D r) seems fine to me, but
I'm not married to this.

>
> static __s32 btf_find_type_by_name_kind(const struct btf *btf, int start_=
id,
>                                    const char *type_name, __u32 kind)
> {
>         const struct btf_type *t;
>         const char *tname;
>         int err =3D -ENOENT;
>         __u32 total;
>
>         if (!btf)
>                 goto out;
>
>         if (start_id < btf->start_id) {
>                 err =3D btf_find_type_by_name_kind(btf->base_btf, start_i=
d,
>                                                  type_name, kind);
>                 if (err =3D=3D -ENOENT)
>                         start_id =3D btf->start_id;
>         }
>
>         if (err =3D=3D -ENOENT) {
>                 if (btf_check_sorted((struct btf *)btf)) {
>                         /* binary search */
>                         bool skip_first;
>                         int ret;
>
>                         /* return the leftmost with maching names */
>                         ret =3D btf_find_type_by_name_bsearch(btf,
> type_name, start_id);
>                         if (ret < 0)
>                                 goto out;
>                         /* skip kind checking */
>                         if (kind =3D=3D -1)
>                                 return ret;
>                         total =3D btf__type_cnt(btf);
>                         skip_first =3D true;
>                         do {
>                                 t =3D btf_type_by_id(btf, ret);
>                                 if (btf_kind(t) !=3D kind) {
>                                         if (skip_first) {
>                                                 skip_first =3D false;
>                                                 continue;
>                                         }
>                                 } else if (skip_first) {
>                                         return ret;
>                                 }
>                                 if (!t->name_off)
>                                         break;
>                                 tname =3D btf__str_by_offset(btf, t->name=
_off);
>                                 if (tname && !strcmp(tname, type_name))
>                                         return ret;
>                                 else
>                                         break;
>                         } while (++ret < total);
>                 } else {
>                         /* linear search */
> ...
>                 }
>         }
>
> out:
>         return err;
> }

