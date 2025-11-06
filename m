Return-Path: <bpf+bounces-73891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB87CC3CDE6
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BEA3AD21F
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1C34DCC2;
	Thu,  6 Nov 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+sY1f3E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FB224AF3
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450284; cv=none; b=u/cx29QhfOu+yq89dzliGnz7LQ0QSeyDLdBs9Dx1NJUel3aY5rcziRnDagX3cihwC3xNt1aJYXyQjmD1sSX61yYE76YSgYhf7L+DrNnDeYsdb1sAw0gmnbibdozB1jyTsz2blQRmvhgsucWuvEZ/wtvQanTH88cqP9dYJdcS7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450284; c=relaxed/simple;
	bh=NAGiZJWyVtGqj99vpJDTPKgTIylXaR8ImX5gzHQcXSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCyIajoxP1My/8Zg/4+v7L39+y5XEcmskK2sGdZpQ3txZee1S1m3UvifAnmhr2sTMiA9x6XcY9i4WQVmRbr8Nnnh3sgpZMAKhQj6f7ltS/n1awkOZTOnkJPEbIhEJL3ANLoeRpYKZ6kf2f4bcwO0xWuh43Wlb335UfwwBdZ3gp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+sY1f3E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7833765433cso1499844b3a.0
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762450280; x=1763055080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHPFfs02TEQKcxLPYted2bQqwk2cQyNDmVoP8GQVnKw=;
        b=K+sY1f3EXWDKNknyJwDajMXDXgWqb1Khpu7s8/D9rtOSOhFDxhyZThTu5Xhcd+x49X
         UbSWEQCIgc6PX4boB+MPzDmypER3vB/ZPTI9M/rdDZJ3XUrqtWf3G4rie3IZlkQALonF
         I4MVe6VNz6MZ82hv+6AZdbNJbilz/o8J9gzHpQ4I9mXennDAgX+Szi2LLfOMGtg6LH8I
         yjDKRPmqKzphZnjV8hsr3YjOTz5Xa3eFNdzEpRq4Ihh43IhAHkQ3gSTiK6kgvF5XW0fP
         I2XCr19JQjFWyKLxlT9MNjZdCIn009k/NaCE0Q0sDzWNi6f8pj6xe011tyTeh6W2DTWL
         Xfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450280; x=1763055080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHPFfs02TEQKcxLPYted2bQqwk2cQyNDmVoP8GQVnKw=;
        b=RpNDOHgJAgO5+f/BJOg7nVnF33whCehKllifOSYRVvXwVt5IVJNoMV1C2BFPgYIONj
         cZl5+FQs/Hcbcjd+bSMSUhBWhpnFMpbbHRR+hUeL1Ikr8zxPm64T8lnC1KLhrq/7FV+5
         MLLOO/tnWy2AMabuTT9hTkIevmQXcR+cxGcwsXG59wufbnaKXASqJKUYuWePMAg94Pxy
         iTKWwoLs8xHSHsZbD5vwjoXcdOZZUxV8RbfNnxRmkSv0wZTjlpZrwJfMjO+9HhU/m3qP
         tXKXq3g0OIBWfWo95mEocpEUm02p6ug7lNm2rCOPHNRiiyP62t+W9XxPMEv9+POusJpZ
         pCew==
X-Forwarded-Encrypted: i=1; AJvYcCXkfNq40bzrqtQvgtE6PSd83mswAZl6Q7EsuZX5+LBGaH1dWF8VJnFXej+9MSCU4TyJNfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtT+65V/Xi7KhrH1XcZNWwKpNS1qPNIQ2BAkGoZ7j/OZUNoOpk
	ZqZPwilBepSY/Zid/cwfQJKXZ0KPLuYraLk+M9TIQ+Q71UMCXlxScbIsLnp2m+b4Tf8/yK8Dr/C
	Ut6zlPaWezL6UQ7spcuraNeXfw+B94a4roSJH
X-Gm-Gg: ASbGnctW7N8abWV6x2GUkyehkgTS/DRWwRi8LrbqR/THMvLCAZLADwqoQPgqLW4FGab
	Q5KN9YO0q2QryyEJNsFsPmrcB7znWyzqxYA5hFgndrMWcfeomERkj8K6m40UX3f/UeCvF2r3Fux
	K1TeqgbRUldJOwFK/fwq2Ct+T9attmgTlMMXWZFZwpWrfJwc7xy/tRFkJcNV1NSJKJwlYdZuHZ4
	e9u+k6Wa3FITJDMUN0DAcu89liKZH3cXtDAuE8BMLWGFj/lstVfi8cmzFixIFX2O2qKs4TyQA+Q
	ce7zPqZIQec=
X-Google-Smtp-Source: AGHT+IGZtco1z8s/y0+kMLQlYjyWH9T7w9rro0QaflTngPYpexq/c0ZbBD8oot1+gHAwplZlfXOcphzGyf7iqos29HA=
X-Received: by 2002:a17:90b:6cb:b0:340:2a59:45c6 with SMTP id
 98e67ed59e1d1-341a6c38db5mr10787672a91.4.1762450280444; Thu, 06 Nov 2025
 09:31:20 -0800 (PST)
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
 <CAEf4Bzb3Eu0J83O=Y4KA-LkzBMjtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com> <CAErzpmtJq5Qqdvy+9B8WmvZFQxDt6jKidNqtTMezesP0b=K8ZA@mail.gmail.com>
In-Reply-To: <CAErzpmtJq5Qqdvy+9B8WmvZFQxDt6jKidNqtTMezesP0b=K8ZA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:31:06 -0800
X-Gm-Features: AWmQ_bkBCIJJEmtag8QSVuDb66_aEmB6m0B0uBfUdut8Y97PyEuF54ujykODHuY
Message-ID: <CAEf4BzZsgrKWwTZkdv-WviXvGkhV-ZyQbpb8wDqBGNventuRcg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:49=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Thu, Nov 6, 2025 at 2:11=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Nov 5, 2025 at 5:48=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > > >
> > > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct b=
tf *btf, __u32 type_id)
> > > > > > > >         return type_id;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -__s32 btf__find_by_name(const struct btf *btf, const char =
*type_name)
> > > > > > > > +/*
> > > > > > > > + * Find BTF types with matching names within the [left, ri=
ght] index range.
> > > > > > > > + * On success, updates *left and *right to the boundaries =
of the matching range
> > > > > > > > + * and returns the leftmost matching index.
> > > > > > > > + */
> > > > > > > > +static __s32 btf_find_type_by_name_bsearch(const struct bt=
f *btf, const char *name,
> > > > > > > > +                                               __s32 *left=
, __s32 *right)
> > > > > > >
> > > > > > > I thought we discussed this, why do you need "right"? Two bin=
ary
> > > > > > > searches where one would do just fine.
> > > > > >
> > > > > > I think the idea is that there would be less strcmp's if there =
is a
> > > > > > long sequence of items with identical names.
> > > > >
> > > > > Sure, it's a tradeoff. But how long is the set of duplicate name
> > > > > entries we expect in kernel BTF? Additional O(logN) over 70K+ typ=
es
> > > > > with high likelihood will take more comparisons.
> > > >
> > > > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | s=
ort | uniq -c | sort -k1nr | head
> > > >   51737 '(anon)'
> > > >     277 'bpf_kfunc'
> > > >       4 'long
> > > >       3 'perf_aux_event'
> > > >       3 'workspace'
> > > >       2 'ata_acpi_gtm'
> > > >       2 'avc_cache_stats'
> > > >       2 'bh_accounting'
> > > >       2 'bp_cpuinfo'
> > > >       2 'bpf_fastcall'
> > > >
> > > > 'bpf_kfunc' is probably for decl_tags.
> > > > So I agree with you regarding the second binary search, it is not
> > > > necessary.  But skipping all anonymous types (and thus having to
> > > > maintain nr_sorted_types) might be useful, on each search two
> > > > iterations would be wasted to skip those.
> >
> > fair enough, eliminating a big chunk of anonymous types is useful, let'=
s do this
> >
> > >
> > > Thank you. After removing the redundant iterations, performance incre=
ased
> > > significantly compared with two iterations.
> > >
> > > Test Case: Locate all 58,719 named types in vmlinux BTF
> > > Methodology:
> > > ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
> > >
> > > Two iterations:
> > > | Condition          | Lookup Time | Improvement |
> > > |--------------------|-------------|-------------|
> > > | Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > > | Sorted (Binary)    | 19 ms       | 909x faster |
> > >
> > > One iteration:
> > > Results:
> > > | Condition          | Lookup Time | Improvement |
> > > |--------------------|-------------|-------------|
> > > | Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > > | Sorted (Binary)    | 10 ms       | 1762x faster |
> > >
> > > Here is the code implementation with a single iteration approach.
> > > I believe this scenario differs from find_linfo because we cannot
> > > determine in advance whether the specified type name will be found.
> > > Please correct me if I've misunderstood anything, and I welcome any
> > > guidance on this matter.
> > >
> > > static __s32 btf_find_type_by_name_bsearch(const struct btf *btf,
> > > const char *name,
> > >                                                 __s32 start_id)
> > > {
> > >         const struct btf_type *t;
> > >         const char *tname;
> > >         __s32 l, r, m, lmost =3D -ENOENT;
> > >         int ret;
> > >
> > >         /* found the leftmost btf_type that matches */
> > >         l =3D start_id;
> > >         r =3D btf__type_cnt(btf) - 1;
> > >         while (l <=3D r) {
> > >                 m =3D l + (r - l) / 2;
> > >                 t =3D btf_type_by_id(btf, m);
> > >                 if (!t->name_off) {
> > >                         ret =3D 1;
> > >                 } else {
> > >                         tname =3D btf__str_by_offset(btf, t->name_off=
);
> > >                         ret =3D !tname ? 1 : strcmp(tname, name);
> > >                 }
> > >                 if (ret < 0) {
> > >                         l =3D m + 1;
> > >                 } else {
> > >                         if (ret =3D=3D 0)
> > >                                 lmost =3D m;
> > >                         r =3D m - 1;
> > >                 }
> > >         }
> > >
> > >         return lmost;
> > > }
> >
> > There are different ways to implement this. At the highest level,
> > implementation below just searches for leftmost element that has name
> > >=3D the one we are searching for. One complication is that such elemen=
t
> > might not event exists. We can solve that checking ahead of time
> > whether the rightmost type satisfied the condition, or we could do
> > something similar to what I do in the loop below, where I allow l =3D=
=3D r
> > and then if that element has name >=3D to what we search, we exit
> > because we found it. And if not, l will become larger than r, we'll
> > break out of the loop and we'll know that we couldn't find the
> > element. I haven't tested it, but please take a look and if you decide
> > to go with such approach, do test it for edge cases, of course.
> >
> > /*
> >  * We are searching for the smallest r such that type #r's name is >=3D=
 name.
> >  * It might not exist, in which case we'll have l =3D=3D r + 1.
> >  */
> > l =3D start_id;
> > r =3D btf__type_cnt(btf) - 1;
> > while (l < r) {
> >     m =3D l + (r - l) / 2;
> >     t =3D btf_type_by_id(btf, m);
> >     tname =3D btf__str_by_offset(btf, t->name_off);
> >
> >     if (strcmp(tname, name) >=3D 0) {
> >         if (l =3D=3D r)
> >             return r; /* found it! */
>
> It seems that this if condition will never hold, because a while(l < r) l=
oop

It should be `while (l <=3D r)`, I forgot to update it, but I mentioned
that I do want to allow l =3D=3D r condition.

> is used. Moreover, even if the condition were to hold, it wouldn't guaran=
tee
> a successful search.

Elaborate please on "wouldn't guarantee a successful search".

>
> >         r =3D m;
> >     } else {
> >         l =3D m + 1;
> >     }
> > }
> > /* here we know given element doesn't exist, return index beyond end of=
 types */
> > return btf__type_cnt(btf);
>
> I think that return -ENOENT seems more reasonable.

Think how you will be using this inside btf_find_type_by_name_kind():


int idx =3D btf_find_by_name_bsearch(btf, name);

for (int n =3D btf__type_cnt(btf); idx < n; idx++) {
    struct btf_type *t =3D btf__type_by_id(btf, idx);
    const char *tname =3D btf__str_by_offset(btf, t->name_off);
    if (strcmp(tname, name) !=3D 0)
        return -ENOENT;
    if (btf_kind(t) =3D=3D kind)
        return idx;
}
return -ENOENT;


Having btf_find_by_name_bsearch() return -ENOENT instead of
btf__type_cnt() just will require extra explicit -ENOENT handling. And
given the function now can return "error", we'd need to either handle
other non-ENOENT errors, to at least leave comment that this should
never happen, though interface itself looks like it could.

This is relatively minor and its all internal implementation, so we
can change that later. But I'm explaining my reasons for why I'd
return index of non-existing type after the end, just like you'd do
with pointer-based interfaces that return pointer after the last
element.


>
> >
> >
> > We could have checked instead whether strcmp(btf__str_by_offset(btf,
> > btf__type_by_id(btf, btf__type_cnt() - 1)->name_off), name) < 0 and
> > exit early. That's just a bit more code duplication of essentially
> > what we do inside the loop, so that if (l =3D=3D r) seems fine to me, b=
ut
> > I'm not married to this.
>
> Sorry, I believe that even if strcmp(btf__str_by_offset(btf,
> btf__type_by_id(btf,
> btf__type_cnt() - 1)->name_off), name) >=3D 0, it still doesn't seem to
> guarantee that the search will definitely succeed.

If the last element has >=3D name, search will definitely find at least
that element. What do you mean by "succeed"? All I care about here is
that binary search loop doesn't loop forever and it returns correct
index (or detects that no element can be found).

>
> >
> > >
> > > static __s32 btf_find_type_by_name_kind(const struct btf *btf, int st=
art_id,
> > >                                    const char *type_name, __u32 kind)
> > > {
> > >         const struct btf_type *t;
> > >         const char *tname;
> > >         int err =3D -ENOENT;
> > >         __u32 total;
> > >
> > >         if (!btf)
> > >                 goto out;
> > >
> > >         if (start_id < btf->start_id) {
> > >                 err =3D btf_find_type_by_name_kind(btf->base_btf, sta=
rt_id,
> > >                                                  type_name, kind);
> > >                 if (err =3D=3D -ENOENT)
> > >                         start_id =3D btf->start_id;
> > >         }
> > >
> > >         if (err =3D=3D -ENOENT) {
> > >                 if (btf_check_sorted((struct btf *)btf)) {
> > >                         /* binary search */
> > >                         bool skip_first;
> > >                         int ret;
> > >
> > >                         /* return the leftmost with maching names */
> > >                         ret =3D btf_find_type_by_name_bsearch(btf,
> > > type_name, start_id);
> > >                         if (ret < 0)
> > >                                 goto out;
> > >                         /* skip kind checking */
> > >                         if (kind =3D=3D -1)
> > >                                 return ret;
> > >                         total =3D btf__type_cnt(btf);
> > >                         skip_first =3D true;
> > >                         do {
> > >                                 t =3D btf_type_by_id(btf, ret);
> > >                                 if (btf_kind(t) !=3D kind) {
> > >                                         if (skip_first) {
> > >                                                 skip_first =3D false;
> > >                                                 continue;
> > >                                         }
> > >                                 } else if (skip_first) {
> > >                                         return ret;
> > >                                 }
> > >                                 if (!t->name_off)
> > >                                         break;
> > >                                 tname =3D btf__str_by_offset(btf, t->=
name_off);
> > >                                 if (tname && !strcmp(tname, type_name=
))
> > >                                         return ret;
> > >                                 else
> > >                                         break;
> > >                         } while (++ret < total);
> > >                 } else {
> > >                         /* linear search */
> > > ...
> > >                 }
> > >         }
> > >
> > > out:
> > >         return err;
> > > }

