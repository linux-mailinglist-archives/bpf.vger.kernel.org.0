Return-Path: <bpf+bounces-74044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD68C44BFF
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 03:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3831B34574F
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62132221540;
	Mon, 10 Nov 2025 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYsvUsrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A93F9FB
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740306; cv=none; b=PRsmrLq9U8pvtENJDreEfwDOByGZ9uk3H5rUuOeAh5dX551De7ALdLjavoyWDoh1UvfxS76na2QPA2UvlNqDPcrsViI3eVvmmXJ/HRdy1EsqL3RzwuFHOhgrTuf9YPpBeOtxh8Cn0UaUsOnsrsNREcWQrEbIvPfra3W9bQgY8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740306; c=relaxed/simple;
	bh=IY3NQ3RmUYv9tqFPuwIEvyN6n+5T0I/NemYjL/b9ZJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvRu3UpbSTyoMFI0iX2+/e8nu+lUwwnedzHURL6mWYqr9Qth5zeFRiQUP5EFWmzsgarewZXrmPaPrWqzpT9fuTFlSsctfLFJ4YX2G+NoiLUMUwI/OPH9rnR7IT1X2WfkZz7ArEE1IDjbmRijnuJhNAqdZhPPmJPyhItexHn+gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYsvUsrl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b727f452fffso424302966b.1
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 18:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762740303; x=1763345103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MfKTFvu1Ddt4mx9rsrPlWMJDbZL3NDxl4jBYOb6ntM=;
        b=RYsvUsrl55m+sdJGIUziBMEXTBEitqZHZunAjeF+diQLUZeQyIQVQ/1GyJUj9kNoGK
         B4PHjdOVfGyldoWYeRFvk1D8EQObgT/7FHq9J9TWlTarLDE85Rg5/lyE/76XOxS4fmFh
         Xjg01T64jgs/zksuk0n8st0DY4g/J5TUlgos4piGrYQuJltm3dfvIUrmglGU2v0afqv3
         CVGQZjB3dsoeXWaZmg6HfuhcakoKrE9k3d1rcq55I/JoivMz2qhaWMxU4o9RpdveX/U/
         b2SRUg9QDJIMNGSfhRgJ9RKhQVdloy8RTHvT6OUPVo2VnoI9ZVvP0VAJ7PZul0bPjMK9
         tXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762740303; x=1763345103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MfKTFvu1Ddt4mx9rsrPlWMJDbZL3NDxl4jBYOb6ntM=;
        b=XFnmlzRaDO8XkN/PmP207c1qKn+Acy3F5CGbo8j01IBbf3hFakPqhtGPQtglMtN8kB
         2Qx9QkgJLdxhW5jl8y7qJsGputcUPthEjQo6M0NlzrSweGpGMHioB5pqp0CmpUA2w6a1
         YTQkRqXJFOYLkktX/og4pwL7QnsLJvv9nQC5c7Go9gtIfJgdEbSW6VC/Kw80uASUymH6
         /AykcBLoqV8psPyTn+zSrhnHDrc7OLRRWA5W6UAXH7I5yni50lSM5nd0KXLi84J/TXcr
         r7AsAd/iDZwjJ6NALcpCOZGWBelA7WsawHL3wrdmIm8hqdZE00nRkJfbClRTpW6FypiO
         GWKg==
X-Forwarded-Encrypted: i=1; AJvYcCWnLj3ZfBOZtAW5whFSC3SKCFYH9KR5JOyp+4/XUXtv08rDM67M2GQ3ac4dI+7GjHb2X6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgT0uYwYoQDN+LvrIZlMyhfcTVAaJN46Z2HbFCSE7H/hInOe65
	hXCYYC04xQ2SoWHSbozpVqE6jxnvsRvK86jZ4snkMihSeIwztJ0chHIZKd0nUUQ2/jRHCJA+Mmu
	JmNpEim3M8fnXkzJsJWcIZdhGI34r+OM=
X-Gm-Gg: ASbGnct+ofxY6PJ7R7GSxP3Hh+OJSAEw/R9giQkZFFua80HiOqSJGwa3qDLgnExgL1x
	y5EEZEWLCtL83n/rRJD62/J3HXeolPGSmdRwIDlJy7aWDKuX2BnzMkQ/jrOLZLoauH88kOHJbgy
	HLg97djm1lQy5JfuJKL4gNkTZXD2Kwp6o91oMtG29YQogJnBV9j5crdArbLnvT22/U1zlXR975i
	NqJNUBt19vyoUzTmhJm0uCsV/PMqDqm5uZ8y8J7MnG8yT8mFvA8pVgS28HaEQ==
X-Google-Smtp-Source: AGHT+IGdpoX2obYyrTWTfrFqFe8H8gXPeLwwsj2b+aDOm7zHAXljJ1QWxDOzDltpzZ6EUJg9DO/Hn4u9LrQruPEhy9A=
X-Received: by 2002:a17:906:3993:b0:b72:dcda:fe5a with SMTP id
 a640c23a62f3a-b72dcdb1330mr565136566b.5.1762740302590; Sun, 09 Nov 2025
 18:05:02 -0800 (PST)
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
 <CAErzpmtJq5Qqdvy+9B8WmvZFQxDt6jKidNqtTMezesP0b=K8ZA@mail.gmail.com>
 <CAEf4BzZsgrKWwTZkdv-WviXvGkhV-ZyQbpb8wDqBGNventuRcg@mail.gmail.com>
 <CAErzpmu_FD_mHcU4uL0XpNU00XngY-1vN5OkKcBBfH2Mr-vY9A@mail.gmail.com> <CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=duDAxG1q=jykJkMBg@mail.gmail.com>
In-Reply-To: <CAEf4BzaqEPD46LddJHO1-k5KPGyVWf6d=duDAxG1q=jykJkMBg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 10 Nov 2025 10:04:50 +0800
X-Gm-Features: AWmQ_bks1RcWKzvfl1WQzjn4nzt-ALkOo4KxfroYjaDTt8E-wGGPUi2JezILKLM
Message-ID: <CAErzpmvqH62be=V1dvLNX1Vah+7SgDHd-eFHsmRh=k2CiEvAxg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, zhangxiaoqin@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 1:01=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 8:57=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Fri, Nov 7, 2025 at 1:31=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Nov 5, 2025 at 11:49=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Nov 6, 2025 at 2:11=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Nov 5, 2025 at 5:48=E2=80=AFAM Donglin Peng <dolinux.peng=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz8=
7@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > > > > > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <ed=
dyz87@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const st=
ruct btf *btf, __u32 type_id)
> > > > > > > > > > >         return type_id;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -__s32 btf__find_by_name(const struct btf *btf, const=
 char *type_name)
> > > > > > > > > > > +/*
> > > > > > > > > > > + * Find BTF types with matching names within the [le=
ft, right] index range.
> > > > > > > > > > > + * On success, updates *left and *right to the bound=
aries of the matching range
> > > > > > > > > > > + * and returns the leftmost matching index.
> > > > > > > > > > > + */
> > > > > > > > > > > +static __s32 btf_find_type_by_name_bsearch(const str=
uct btf *btf, const char *name,
> > > > > > > > > > > +                                               __s32=
 *left, __s32 *right)
> > > > > > > > > >
> > > > > > > > > > I thought we discussed this, why do you need "right"? T=
wo binary
> > > > > > > > > > searches where one would do just fine.
> > > > > > > > >
> > > > > > > > > I think the idea is that there would be less strcmp's if =
there is a
> > > > > > > > > long sequence of items with identical names.
> > > > > > > >
> > > > > > > > Sure, it's a tradeoff. But how long is the set of duplicate=
 name
> > > > > > > > entries we expect in kernel BTF? Additional O(logN) over 70=
K+ types
> > > > > > > > with high likelihood will take more comparisons.
> > > > > > >
> > > > > > > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3=
}' | sort | uniq -c | sort -k1nr | head
> > > > > > >   51737 '(anon)'
> > > > > > >     277 'bpf_kfunc'
> > > > > > >       4 'long
> > > > > > >       3 'perf_aux_event'
> > > > > > >       3 'workspace'
> > > > > > >       2 'ata_acpi_gtm'
> > > > > > >       2 'avc_cache_stats'
> > > > > > >       2 'bh_accounting'
> > > > > > >       2 'bp_cpuinfo'
> > > > > > >       2 'bpf_fastcall'
> > > > > > >
> > > > > > > 'bpf_kfunc' is probably for decl_tags.
> > > > > > > So I agree with you regarding the second binary search, it is=
 not
> > > > > > > necessary.  But skipping all anonymous types (and thus having=
 to
> > > > > > > maintain nr_sorted_types) might be useful, on each search two
> > > > > > > iterations would be wasted to skip those.
> > > > >
> > > > > fair enough, eliminating a big chunk of anonymous types is useful=
, let's do this
> > > > >
> > > > > >
> > > > > > Thank you. After removing the redundant iterations, performance=
 increased
> > > > > > significantly compared with two iterations.
> > > > > >
> > > > > > Test Case: Locate all 58,719 named types in vmlinux BTF
> > > > > > Methodology:
> > > > > > ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
> > > > > >
> > > > > > Two iterations:
> > > > > > | Condition          | Lookup Time | Improvement |
> > > > > > |--------------------|-------------|-------------|
> > > > > > | Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > > > > > | Sorted (Binary)    | 19 ms       | 909x faster |
> > > > > >
> > > > > > One iteration:
> > > > > > Results:
> > > > > > | Condition          | Lookup Time | Improvement |
> > > > > > |--------------------|-------------|-------------|
> > > > > > | Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > > > > > | Sorted (Binary)    | 10 ms       | 1762x faster |
> > > > > >
> > > > > > Here is the code implementation with a single iteration approac=
h.
> > > > > > I believe this scenario differs from find_linfo because we cann=
ot
> > > > > > determine in advance whether the specified type name will be fo=
und.
> > > > > > Please correct me if I've misunderstood anything, and I welcome=
 any
> > > > > > guidance on this matter.
> > > > > >
> > > > > > static __s32 btf_find_type_by_name_bsearch(const struct btf *bt=
f,
> > > > > > const char *name,
> > > > > >                                                 __s32 start_id)
> > > > > > {
> > > > > >         const struct btf_type *t;
> > > > > >         const char *tname;
> > > > > >         __s32 l, r, m, lmost =3D -ENOENT;
> > > > > >         int ret;
> > > > > >
> > > > > >         /* found the leftmost btf_type that matches */
> > > > > >         l =3D start_id;
> > > > > >         r =3D btf__type_cnt(btf) - 1;
> > > > > >         while (l <=3D r) {
> > > > > >                 m =3D l + (r - l) / 2;
> > > > > >                 t =3D btf_type_by_id(btf, m);
> > > > > >                 if (!t->name_off) {
> > > > > >                         ret =3D 1;
> > > > > >                 } else {
> > > > > >                         tname =3D btf__str_by_offset(btf, t->na=
me_off);
> > > > > >                         ret =3D !tname ? 1 : strcmp(tname, name=
);
> > > > > >                 }
> > > > > >                 if (ret < 0) {
> > > > > >                         l =3D m + 1;
> > > > > >                 } else {
> > > > > >                         if (ret =3D=3D 0)
> > > > > >                                 lmost =3D m;
> > > > > >                         r =3D m - 1;
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > >         return lmost;
> > > > > > }
> > > > >
> > > > > There are different ways to implement this. At the highest level,
> > > > > implementation below just searches for leftmost element that has =
name
> > > > > >=3D the one we are searching for. One complication is that such =
element
> > > > > might not event exists. We can solve that checking ahead of time
> > > > > whether the rightmost type satisfied the condition, or we could d=
o
> > > > > something similar to what I do in the loop below, where I allow l=
 =3D=3D r
> > > > > and then if that element has name >=3D to what we search, we exit
> > > > > because we found it. And if not, l will become larger than r, we'=
ll
> > > > > break out of the loop and we'll know that we couldn't find the
> > > > > element. I haven't tested it, but please take a look and if you d=
ecide
> > > > > to go with such approach, do test it for edge cases, of course.
> > > > >
> > > > > /*
> > > > >  * We are searching for the smallest r such that type #r's name i=
s >=3D name.
> > > > >  * It might not exist, in which case we'll have l =3D=3D r + 1.
> > > > >  */
> > > > > l =3D start_id;
> > > > > r =3D btf__type_cnt(btf) - 1;
> > > > > while (l < r) {
> > > > >     m =3D l + (r - l) / 2;
> > > > >     t =3D btf_type_by_id(btf, m);
> > > > >     tname =3D btf__str_by_offset(btf, t->name_off);
> > > > >
> > > > >     if (strcmp(tname, name) >=3D 0) {
> > > > >         if (l =3D=3D r)
> > > > >             return r; /* found it! */
> > > >
> > > > It seems that this if condition will never hold, because a while(l =
< r) loop
> > >
> > > It should be `while (l <=3D r)`, I forgot to update it, but I mention=
ed
> > > that I do want to allow l =3D=3D r condition.
> > >
> > > > is used. Moreover, even if the condition were to hold, it wouldn't =
guarantee
> > > > a successful search.
> > >
> > > Elaborate please on "wouldn't guarantee a successful search".
> >
> > I think a successful search is that we can successfully find the elemen=
t that
> > we want.
> >
>
> Ok, I never intended to find exact match with that leftmost >=3D element
> as a primitive.
>
> > >
> > > >
> > > > >         r =3D m;
> > > > >     } else {
> > > > >         l =3D m + 1;
> > > > >     }
> > > > > }
> > > > > /* here we know given element doesn't exist, return index beyond =
end of types */
> > > > > return btf__type_cnt(btf);
> > > >
> > > > I think that return -ENOENT seems more reasonable.
> > >
> > > Think how you will be using this inside btf_find_type_by_name_kind():
> > >
> > >
> > > int idx =3D btf_find_by_name_bsearch(btf, name);
> > >
> > > for (int n =3D btf__type_cnt(btf); idx < n; idx++) {
> > >     struct btf_type *t =3D btf__type_by_id(btf, idx);
> > >     const char *tname =3D btf__str_by_offset(btf, t->name_off);
> > >     if (strcmp(tname, name) !=3D 0)
> > >         return -ENOENT;
> > >     if (btf_kind(t) =3D=3D kind)
> > >         return idx;
> > > }
> > > return -ENOENT;
> >
> > Thanks, it seems cleaner.
>
> ok, great
>
> >
> > >
> > >
> > > Having btf_find_by_name_bsearch() return -ENOENT instead of
> > > btf__type_cnt() just will require extra explicit -ENOENT handling. An=
d
> > > given the function now can return "error", we'd need to either handle
> > > other non-ENOENT errors, to at least leave comment that this should
> > > never happen, though interface itself looks like it could.
> > >
> > > This is relatively minor and its all internal implementation, so we
> > > can change that later. But I'm explaining my reasons for why I'd
> > > return index of non-existing type after the end, just like you'd do
> > > with pointer-based interfaces that return pointer after the last
> > > element.
> >
> > Thanks, I see.
> >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > We could have checked instead whether strcmp(btf__str_by_offset(b=
tf,
> > > > > btf__type_by_id(btf, btf__type_cnt() - 1)->name_off), name) < 0 a=
nd
> > > > > exit early. That's just a bit more code duplication of essentiall=
y
> > > > > what we do inside the loop, so that if (l =3D=3D r) seems fine to=
 me, but
> > > > > I'm not married to this.
> > > >
> > > > Sorry, I believe that even if strcmp(btf__str_by_offset(btf,
> > > > btf__type_by_id(btf,
> > > > btf__type_cnt() - 1)->name_off), name) >=3D 0, it still doesn't see=
m to
> > > > guarantee that the search will definitely succeed.
> > >
> > > If the last element has >=3D name, search will definitely find at lea=
st
> > > that element. What do you mean by "succeed"? All I care about here is
> >
> > Thank you. By "successful search," I mean finding the exact matching
> > element we're looking for=E2=80=94not just the first element that meets=
 the "=E2=89=A5"
> > condition.
>
> We don't have to find the exact match, just the leftmost >=3D element.
> For search by name+kind you will have to do linear search *anyways*
> and compare name for every single potential candidate (Except maybe
> the very first one as micro-optimization and complication, if we had
> exact matching leftmost element; but I don't care about that
> complication). So leftmost >=3D element is a universal "primitive" that
> allows you to implement exact by name or exact by name+kind search in
> exactly the same fashion.
>
> >
> > Here's a concrete example to illustrate the issue:
> >
> > Base BTF contains: {"A", "C", "E", "F"}
> > Split BTF contains: {"B", "D"}
> > Target search: "D" in split BTF
> >
> > The current implementation recursively searches from the base BTF first=
.
> > While "D" is lexicographically =E2=89=A4 "F" (the last element in base =
BTF), "D" doesn't
> > actually exist in the base BTF. When the binary search reaches the l
> > =3D=3D r condition,
> > it returns the index of "E" instead.
> >
> > This requires an extra name comparison check after btf_find_by_name_bse=
arch
> > returns, which could be avoided in the first loop iteration if the
> > search directly
> > identified exact matches.
>
> See above, I think this is misguided. There is nothing wrong with
> checking after bsearch returns *candidate* index, and you cannot avoid
> that for name+kind search.
>
> >
> > int idx =3D btf_find_by_name_bsearch(btf, name);
> >
> > for (int n =3D btf__type_cnt(btf); idx < n; idx++) {
> >     struct btf_type *t =3D btf__type_by_id(btf, idx);
> >     const char *tname =3D btf__str_by_offset(btf, t->name_off);
> >     if (strcmp(tname, name) !=3D 0)  <<< This check is redundant on the=
 first loop
> >                                                             iteration
>
> Yes, I think this is absolutely OK and acceptable. Are you worried
> about the overhead of a single strcmp()? See below for notes on having
> single overall name and name+kind implementation using this approach.
>
> > when a matching index is found
> >         return -ENOENT;
> >     if (btf_kind(t) =3D=3D kind)
> >         return idx;
> > }
> > return -ENOENT;
> >
> > I tested this with a simple program searching for 3 in {0, 1, 2, 4, 5}:
> >
> > int main(int argc, char *argv[])
> > {
> >         int values[] =3D {0, 1, 2, 4, 5};
> >         int to_find;
> >         int i;
> >
> >         to_find =3D atoi(argv[1]);;
> >
> >         for (i =3D 0; i < ARRAY_SIZE(values); i++)
> >                 printf("[%d] =3D %d\n", i , values[i]);
> >
> >         printf("To Find %d\n", to_find);
> >
> >         {
> >                 int l, m, r;
> >
> >                 l =3D 0;
> >                 r =3D ARRAY_SIZE(values) - 1;
> >
> >                 while (l <=3D r) {
> >                         m =3D l + (r- l) / 2;
> >                         if (values[m] >=3D to_find) {
> >                                 if (l =3D=3D r) {
> >                                         printf("!!!! Found: [%d] =3D=3D=
>
> > %d\n", r, values[r]);
> >                                         break;
> >                                 }
> >                                 r =3D m;
> >                         } else {
> >                                 l =3D m + 1;
> >                         }
> >                 }
> >
> >                 printf("END: l: %d, r: %d\n", l, r);
> >         }
> >
> >         return 0;
> > }
> >
> > Output:
> > [0] =3D 0
> > [1] =3D 1
> > [2] =3D 2
> > [3] =3D 4
> > [4] =3D 5
> > To Find 3
> > !!!! Found: [3] =3D=3D> 4
> > END: l: 3, r: 3
> >
> > The search returns index 3 (value 4), which is the first value =E2=89=
=A5 3,
> > but since 4 =E2=89=A0 3,
> > it's not an exact match. Thus, the algorithm cannot guarantee a
> > successful search
> > for the exact element without additional checks.
>
> It was never a goal to find an exact match, yes, additional checks
> after the search is necessary to confirm name or name+kind match (and
> the latter will have to check name for every single item, except maybe
> the first one if we had exact match "guarantee", but I think this is
> absolutely unnecessary). And this is unavoidable for name+kind search.
> So instead of optimizing one extra strcmp() let's have uniform
> implementation for both name and name+kind searches. In fact, you can
> even have the same universal implementation of both if you treat kind
> =3D=3D 0 as "don't care about kind".

Thanks, I'll apply this suggestion in the next version.

>
>
> >
> > > that binary search loop doesn't loop forever and it returns correct
> > > index (or detects that no element can be found).
> > >
> > > >
> > > > >
> > > > > >
> > > > > > static __s32 btf_find_type_by_name_kind(const struct btf *btf, =
int start_id,
> > > > > >                                    const char *type_name, __u32=
 kind)
> > > > > > {
> > > > > >         const struct btf_type *t;
> > > > > >         const char *tname;
> > > > > >         int err =3D -ENOENT;
> > > > > >         __u32 total;
> > > > > >
> > > > > >         if (!btf)
> > > > > >                 goto out;
> > > > > >
> > > > > >         if (start_id < btf->start_id) {
> > > > > >                 err =3D btf_find_type_by_name_kind(btf->base_bt=
f, start_id,
> > > > > >                                                  type_name, kin=
d);
> > > > > >                 if (err =3D=3D -ENOENT)
> > > > > >                         start_id =3D btf->start_id;
> > > > > >         }
> > > > > >
> > > > > >         if (err =3D=3D -ENOENT) {
> > > > > >                 if (btf_check_sorted((struct btf *)btf)) {
> > > > > >                         /* binary search */
> > > > > >                         bool skip_first;
> > > > > >                         int ret;
> > > > > >
> > > > > >                         /* return the leftmost with maching nam=
es */
> > > > > >                         ret =3D btf_find_type_by_name_bsearch(b=
tf,
> > > > > > type_name, start_id);
> > > > > >                         if (ret < 0)
> > > > > >                                 goto out;
> > > > > >                         /* skip kind checking */
> > > > > >                         if (kind =3D=3D -1)
> > > > > >                                 return ret;
> > > > > >                         total =3D btf__type_cnt(btf);
> > > > > >                         skip_first =3D true;
> > > > > >                         do {
> > > > > >                                 t =3D btf_type_by_id(btf, ret);
> > > > > >                                 if (btf_kind(t) !=3D kind) {
> > > > > >                                         if (skip_first) {
> > > > > >                                                 skip_first =3D =
false;
> > > > > >                                                 continue;
> > > > > >                                         }
> > > > > >                                 } else if (skip_first) {
> > > > > >                                         return ret;
> > > > > >                                 }
> > > > > >                                 if (!t->name_off)
> > > > > >                                         break;
> > > > > >                                 tname =3D btf__str_by_offset(bt=
f, t->name_off);
> > > > > >                                 if (tname && !strcmp(tname, typ=
e_name))
> > > > > >                                         return ret;
> > > > > >                                 else
> > > > > >                                         break;
> > > > > >                         } while (++ret < total);
> > > > > >                 } else {
> > > > > >                         /* linear search */
> > > > > > ...
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > > out:
> > > > > >         return err;
> > > > > > }

