Return-Path: <bpf+bounces-73939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B925C3E79E
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 05:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A043AC89A
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7C286409;
	Fri,  7 Nov 2025 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyx0fEne"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617391A254E
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762491464; cv=none; b=ikz7TbkPq6cZ2RrZnFNQuENuG+IRt858rDPKEZJD9EhjQoS47xWYvhcsQTJIaFQ5eSDYhTBqmTEfd1WlDpoX3qEO2yRJo5XgesfvrF+N4oh7w27Qood7A2g5IQ7ieXSnWqfFYai28+8+bhSs8xJzrRcSg4fR+u0a9/+OsrkrouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762491464; c=relaxed/simple;
	bh=obVSxsp0lgu2QTh9aB9BgbxdmU1tspuG0J8KPjRS9YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8t+ovO5ND9wNx5mS5gsKn5Oa9IZb1FRxlk9RN71NkDfpiWp/rRS/Qq4r2uHlAlsN7ijxEXuCgqNByfzjqpnmsELG/pqvOaCY22wtI9SdNBVaoOy95GNfsq3Pj+h5H/KL9VndxJldE9zBvcrepizpKkxe7OcDbxHf8F5YdQi/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyx0fEne; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4736e043f9so45052366b.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 20:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762491461; x=1763096261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUvmlQbRioEOhqgx+Ppu7Wngw7C7d6tWofXlwiWr8EY=;
        b=hyx0fEneOGJXAwgG864r/3Isgkxefm2M17gwwUSNNxRrGy5m2duee77r1HQ8oYXs1B
         ffaqVPNZh4oiCGKjuIOgEVO2nONMbxDqHxAc1VYu9v+4R3cG4xpSElDf147X4Ny3qVuT
         qmxrz9T2jV6O56ElTa9aGcpn8B3lq+g3f48efEaMXGOAZ03wfddCtQMEL1drrzbhbMNg
         sGjVnczekHLU+76ofzoDEd2NZXGJ2qKcuzBoCiFOmvUfMNZ0OlbzcgHaiLPTosmGu61Z
         nfb7yUuCqq2ow/iA9psDqnyNWZlVO8kXjA9NW2dvxXHYZNNE+1Cta6NE+4kzWDlvYjK4
         FkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762491461; x=1763096261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uUvmlQbRioEOhqgx+Ppu7Wngw7C7d6tWofXlwiWr8EY=;
        b=GKGzxAePnlPGmAJ08Y01465IgKGlFZR4d5kt/cReQFRFRxzNAVtwKLhrHYjt7BaqNL
         s2cC9Siau4RfUJQVTjcRq4fkrVt5h6+0YVZiH8DDqw/mMI6thbW4JyG+Sx4/YgMaj9X7
         AZSae4hbLU3SZ563CjKrk8vIzk2PmSwsP8AuZSdt5QUVZ0PtFkbH/7mNfUWwoNAHxmEw
         KFQTC8TR6PEUZ0+m6gDbeLadf2fXl5YsFkprHZnJ/IKq+gzc4oDWCtrWOva/RRaaAbhf
         7Wmbe1CmJv5/2oJXkqANWPhNkF/w3WSmv7qT6s+YEr1xUcQeQ/m4QMS9YtW7W1DpgCMd
         E6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp1zcgPGRjLpl9hx9j07/EE4ipkZlIXJWPCzFCiy4f07poTOPZPBRKiBm+/UzZNG5zrqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNgRHh0o35l91+h6FK51tBeoVPCuyy2Nh0EOHXGaf9u4kSHbE
	ieDvF/sGi1NxJ1r0hS2Xs1POXDb7Ty6EigKJP2zzmjxKEpkhgxDfcDffsAauYFaTgNc3oWSFxig
	BeNJZQ1K7hEGGMyAEoQpQuVO4ZMIa6og=
X-Gm-Gg: ASbGncv2RWcHSJgYM2A4BC0YGbTplGwJD9LYE/BDmARJE9fsDD/Zl5tLELoL8c3MlXF
	vvJw67mXnn6UnPSpXp1wSZ6XqzyKgnvw+//TyN/jfX43o40qfs8jxKtm4e00gcvhTHmHCMlxA24
	Xkyh3Ngi5lW0bN7tsheBGW3RYs+5iYF/O5oP4+qByQcexaHLnrvWlVFHGLNn73rwuoDaf4brRzJ
	ET6Q7t6nq+EWayBwFQUhqeq7GJrOT69yApu2CLGY+k+3mTxFhraQ0p3lwW9PQ==
X-Google-Smtp-Source: AGHT+IEutS9TBc7mmjCecOgGAwsuDbl+YjNZGqV1KE8rfZ4O5r8pRFRuY9qw/wFZg0KwlwFwXhBHFYTyLHx9GhgM3Fk=
X-Received: by 2002:a17:907:7f87:b0:b72:614a:ab42 with SMTP id
 a640c23a62f3a-b72c0657cdfmr177605266b.0.1762491460532; Thu, 06 Nov 2025
 20:57:40 -0800 (PST)
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
 <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
 <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
 <CAEf4Bzb3Eu0J83O=Y4KA-LkzBMjtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com>
 <CAErzpmtJq5Qqdvy+9B8WmvZFQxDt6jKidNqtTMezesP0b=K8ZA@mail.gmail.com> <CAEf4BzZsgrKWwTZkdv-WviXvGkhV-ZyQbpb8wDqBGNventuRcg@mail.gmail.com>
In-Reply-To: <CAEf4BzZsgrKWwTZkdv-WviXvGkhV-ZyQbpb8wDqBGNventuRcg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 7 Nov 2025 12:57:28 +0800
X-Gm-Features: AWmQ_bmhz9eWfWc0bL69iohIKFAp0AxBrhKI-9VMIE7X-mruIaPLVpR4x8i2KTY
Message-ID: <CAErzpmu_FD_mHcU4uL0XpNU00XngY-1vN5OkKcBBfH2Mr-vY9A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, zhangxiaoqin@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 1:31=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 11:49=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Thu, Nov 6, 2025 at 2:11=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 5:48=E2=80=AFAM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > > >
> > > > On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > > > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz8=
7@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct=
 btf *btf, __u32 type_id)
> > > > > > > > >         return type_id;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -__s32 btf__find_by_name(const struct btf *btf, const cha=
r *type_name)
> > > > > > > > > +/*
> > > > > > > > > + * Find BTF types with matching names within the [left, =
right] index range.
> > > > > > > > > + * On success, updates *left and *right to the boundarie=
s of the matching range
> > > > > > > > > + * and returns the leftmost matching index.
> > > > > > > > > + */
> > > > > > > > > +static __s32 btf_find_type_by_name_bsearch(const struct =
btf *btf, const char *name,
> > > > > > > > > +                                               __s32 *le=
ft, __s32 *right)
> > > > > > > >
> > > > > > > > I thought we discussed this, why do you need "right"? Two b=
inary
> > > > > > > > searches where one would do just fine.
> > > > > > >
> > > > > > > I think the idea is that there would be less strcmp's if ther=
e is a
> > > > > > > long sequence of items with identical names.
> > > > > >
> > > > > > Sure, it's a tradeoff. But how long is the set of duplicate nam=
e
> > > > > > entries we expect in kernel BTF? Additional O(logN) over 70K+ t=
ypes
> > > > > > with high likelihood will take more comparisons.
> > > > >
> > > > > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' |=
 sort | uniq -c | sort -k1nr | head
> > > > >   51737 '(anon)'
> > > > >     277 'bpf_kfunc'
> > > > >       4 'long
> > > > >       3 'perf_aux_event'
> > > > >       3 'workspace'
> > > > >       2 'ata_acpi_gtm'
> > > > >       2 'avc_cache_stats'
> > > > >       2 'bh_accounting'
> > > > >       2 'bp_cpuinfo'
> > > > >       2 'bpf_fastcall'
> > > > >
> > > > > 'bpf_kfunc' is probably for decl_tags.
> > > > > So I agree with you regarding the second binary search, it is not
> > > > > necessary.  But skipping all anonymous types (and thus having to
> > > > > maintain nr_sorted_types) might be useful, on each search two
> > > > > iterations would be wasted to skip those.
> > >
> > > fair enough, eliminating a big chunk of anonymous types is useful, le=
t's do this
> > >
> > > >
> > > > Thank you. After removing the redundant iterations, performance inc=
reased
> > > > significantly compared with two iterations.
> > > >
> > > > Test Case: Locate all 58,719 named types in vmlinux BTF
> > > > Methodology:
> > > > ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
> > > >
> > > > Two iterations:
> > > > | Condition          | Lookup Time | Improvement |
> > > > |--------------------|-------------|-------------|
> > > > | Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > > > | Sorted (Binary)    | 19 ms       | 909x faster |
> > > >
> > > > One iteration:
> > > > Results:
> > > > | Condition          | Lookup Time | Improvement |
> > > > |--------------------|-------------|-------------|
> > > > | Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > > > | Sorted (Binary)    | 10 ms       | 1762x faster |
> > > >
> > > > Here is the code implementation with a single iteration approach.
> > > > I believe this scenario differs from find_linfo because we cannot
> > > > determine in advance whether the specified type name will be found.
> > > > Please correct me if I've misunderstood anything, and I welcome any
> > > > guidance on this matter.
> > > >
> > > > static __s32 btf_find_type_by_name_bsearch(const struct btf *btf,
> > > > const char *name,
> > > >                                                 __s32 start_id)
> > > > {
> > > >         const struct btf_type *t;
> > > >         const char *tname;
> > > >         __s32 l, r, m, lmost =3D -ENOENT;
> > > >         int ret;
> > > >
> > > >         /* found the leftmost btf_type that matches */
> > > >         l =3D start_id;
> > > >         r =3D btf__type_cnt(btf) - 1;
> > > >         while (l <=3D r) {
> > > >                 m =3D l + (r - l) / 2;
> > > >                 t =3D btf_type_by_id(btf, m);
> > > >                 if (!t->name_off) {
> > > >                         ret =3D 1;
> > > >                 } else {
> > > >                         tname =3D btf__str_by_offset(btf, t->name_o=
ff);
> > > >                         ret =3D !tname ? 1 : strcmp(tname, name);
> > > >                 }
> > > >                 if (ret < 0) {
> > > >                         l =3D m + 1;
> > > >                 } else {
> > > >                         if (ret =3D=3D 0)
> > > >                                 lmost =3D m;
> > > >                         r =3D m - 1;
> > > >                 }
> > > >         }
> > > >
> > > >         return lmost;
> > > > }
> > >
> > > There are different ways to implement this. At the highest level,
> > > implementation below just searches for leftmost element that has name
> > > >=3D the one we are searching for. One complication is that such elem=
ent
> > > might not event exists. We can solve that checking ahead of time
> > > whether the rightmost type satisfied the condition, or we could do
> > > something similar to what I do in the loop below, where I allow l =3D=
=3D r
> > > and then if that element has name >=3D to what we search, we exit
> > > because we found it. And if not, l will become larger than r, we'll
> > > break out of the loop and we'll know that we couldn't find the
> > > element. I haven't tested it, but please take a look and if you decid=
e
> > > to go with such approach, do test it for edge cases, of course.
> > >
> > > /*
> > >  * We are searching for the smallest r such that type #r's name is >=
=3D name.
> > >  * It might not exist, in which case we'll have l =3D=3D r + 1.
> > >  */
> > > l =3D start_id;
> > > r =3D btf__type_cnt(btf) - 1;
> > > while (l < r) {
> > >     m =3D l + (r - l) / 2;
> > >     t =3D btf_type_by_id(btf, m);
> > >     tname =3D btf__str_by_offset(btf, t->name_off);
> > >
> > >     if (strcmp(tname, name) >=3D 0) {
> > >         if (l =3D=3D r)
> > >             return r; /* found it! */
> >
> > It seems that this if condition will never hold, because a while(l < r)=
 loop
>
> It should be `while (l <=3D r)`, I forgot to update it, but I mentioned
> that I do want to allow l =3D=3D r condition.
>
> > is used. Moreover, even if the condition were to hold, it wouldn't guar=
antee
> > a successful search.
>
> Elaborate please on "wouldn't guarantee a successful search".

I think a successful search is that we can successfully find the element th=
at
we want.

>
> >
> > >         r =3D m;
> > >     } else {
> > >         l =3D m + 1;
> > >     }
> > > }
> > > /* here we know given element doesn't exist, return index beyond end =
of types */
> > > return btf__type_cnt(btf);
> >
> > I think that return -ENOENT seems more reasonable.
>
> Think how you will be using this inside btf_find_type_by_name_kind():
>
>
> int idx =3D btf_find_by_name_bsearch(btf, name);
>
> for (int n =3D btf__type_cnt(btf); idx < n; idx++) {
>     struct btf_type *t =3D btf__type_by_id(btf, idx);
>     const char *tname =3D btf__str_by_offset(btf, t->name_off);
>     if (strcmp(tname, name) !=3D 0)
>         return -ENOENT;
>     if (btf_kind(t) =3D=3D kind)
>         return idx;
> }
> return -ENOENT;

Thanks, it seems cleaner.

>
>
> Having btf_find_by_name_bsearch() return -ENOENT instead of
> btf__type_cnt() just will require extra explicit -ENOENT handling. And
> given the function now can return "error", we'd need to either handle
> other non-ENOENT errors, to at least leave comment that this should
> never happen, though interface itself looks like it could.
>
> This is relatively minor and its all internal implementation, so we
> can change that later. But I'm explaining my reasons for why I'd
> return index of non-existing type after the end, just like you'd do
> with pointer-based interfaces that return pointer after the last
> element.

Thanks, I see.

>
>
> >
> > >
> > >
> > > We could have checked instead whether strcmp(btf__str_by_offset(btf,
> > > btf__type_by_id(btf, btf__type_cnt() - 1)->name_off), name) < 0 and
> > > exit early. That's just a bit more code duplication of essentially
> > > what we do inside the loop, so that if (l =3D=3D r) seems fine to me,=
 but
> > > I'm not married to this.
> >
> > Sorry, I believe that even if strcmp(btf__str_by_offset(btf,
> > btf__type_by_id(btf,
> > btf__type_cnt() - 1)->name_off), name) >=3D 0, it still doesn't seem to
> > guarantee that the search will definitely succeed.
>
> If the last element has >=3D name, search will definitely find at least
> that element. What do you mean by "succeed"? All I care about here is

Thank you. By "successful search," I mean finding the exact matching
element we're looking for=E2=80=94not just the first element that meets the=
 "=E2=89=A5"
condition.

Here's a concrete example to illustrate the issue:

Base BTF contains: {"A", "C", "E", "F"}
Split BTF contains: {"B", "D"}
Target search: "D" in split BTF

The current implementation recursively searches from the base BTF first.
While "D" is lexicographically =E2=89=A4 "F" (the last element in base BTF)=
, "D" doesn't
actually exist in the base BTF. When the binary search reaches the l
=3D=3D r condition,
it returns the index of "E" instead.

This requires an extra name comparison check after btf_find_by_name_bsearch
returns, which could be avoided in the first loop iteration if the
search directly
identified exact matches.

int idx =3D btf_find_by_name_bsearch(btf, name);

for (int n =3D btf__type_cnt(btf); idx < n; idx++) {
    struct btf_type *t =3D btf__type_by_id(btf, idx);
    const char *tname =3D btf__str_by_offset(btf, t->name_off);
    if (strcmp(tname, name) !=3D 0)  <<< This check is redundant on the fir=
st loop
                                                            iteration
when a matching index is found
        return -ENOENT;
    if (btf_kind(t) =3D=3D kind)
        return idx;
}
return -ENOENT;

I tested this with a simple program searching for 3 in {0, 1, 2, 4, 5}:

int main(int argc, char *argv[])
{
        int values[] =3D {0, 1, 2, 4, 5};
        int to_find;
        int i;

        to_find =3D atoi(argv[1]);;

        for (i =3D 0; i < ARRAY_SIZE(values); i++)
                printf("[%d] =3D %d\n", i , values[i]);

        printf("To Find %d\n", to_find);

        {
                int l, m, r;

                l =3D 0;
                r =3D ARRAY_SIZE(values) - 1;

                while (l <=3D r) {
                        m =3D l + (r- l) / 2;
                        if (values[m] >=3D to_find) {
                                if (l =3D=3D r) {
                                        printf("!!!! Found: [%d] =3D=3D>
%d\n", r, values[r]);
                                        break;
                                }
                                r =3D m;
                        } else {
                                l =3D m + 1;
                        }
                }

                printf("END: l: %d, r: %d\n", l, r);
        }

        return 0;
}

Output:
[0] =3D 0
[1] =3D 1
[2] =3D 2
[3] =3D 4
[4] =3D 5
To Find 3
!!!! Found: [3] =3D=3D> 4
END: l: 3, r: 3

The search returns index 3 (value 4), which is the first value =E2=89=A5 3,
but since 4 =E2=89=A0 3,
it's not an exact match. Thus, the algorithm cannot guarantee a
successful search
for the exact element without additional checks.

> that binary search loop doesn't loop forever and it returns correct
> index (or detects that no element can be found).
>
> >
> > >
> > > >
> > > > static __s32 btf_find_type_by_name_kind(const struct btf *btf, int =
start_id,
> > > >                                    const char *type_name, __u32 kin=
d)
> > > > {
> > > >         const struct btf_type *t;
> > > >         const char *tname;
> > > >         int err =3D -ENOENT;
> > > >         __u32 total;
> > > >
> > > >         if (!btf)
> > > >                 goto out;
> > > >
> > > >         if (start_id < btf->start_id) {
> > > >                 err =3D btf_find_type_by_name_kind(btf->base_btf, s=
tart_id,
> > > >                                                  type_name, kind);
> > > >                 if (err =3D=3D -ENOENT)
> > > >                         start_id =3D btf->start_id;
> > > >         }
> > > >
> > > >         if (err =3D=3D -ENOENT) {
> > > >                 if (btf_check_sorted((struct btf *)btf)) {
> > > >                         /* binary search */
> > > >                         bool skip_first;
> > > >                         int ret;
> > > >
> > > >                         /* return the leftmost with maching names *=
/
> > > >                         ret =3D btf_find_type_by_name_bsearch(btf,
> > > > type_name, start_id);
> > > >                         if (ret < 0)
> > > >                                 goto out;
> > > >                         /* skip kind checking */
> > > >                         if (kind =3D=3D -1)
> > > >                                 return ret;
> > > >                         total =3D btf__type_cnt(btf);
> > > >                         skip_first =3D true;
> > > >                         do {
> > > >                                 t =3D btf_type_by_id(btf, ret);
> > > >                                 if (btf_kind(t) !=3D kind) {
> > > >                                         if (skip_first) {
> > > >                                                 skip_first =3D fals=
e;
> > > >                                                 continue;
> > > >                                         }
> > > >                                 } else if (skip_first) {
> > > >                                         return ret;
> > > >                                 }
> > > >                                 if (!t->name_off)
> > > >                                         break;
> > > >                                 tname =3D btf__str_by_offset(btf, t=
->name_off);
> > > >                                 if (tname && !strcmp(tname, type_na=
me))
> > > >                                         return ret;
> > > >                                 else
> > > >                                         break;
> > > >                         } while (++ret < total);
> > > >                 } else {
> > > >                         /* linear search */
> > > > ...
> > > >                 }
> > > >         }
> > > >
> > > > out:
> > > >         return err;
> > > > }

