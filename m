Return-Path: <bpf+bounces-73794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E14C3972C
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 08:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87ACE4E6301
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C022882D7;
	Thu,  6 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmW0aiKS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393814F70
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415376; cv=none; b=gqVzzfrMEDyCyltz5cBnrjcnTe2CNE9KMjoyvBxmW8C0H7vSvbJLgOEbKxgRFahUwVhi7jcTvFIorK1YY3YMF5Eeok3OEpo+XxWsIj3Xkq4ogntmgwFsYWiqqsdKodY4BCO1rXVqg1ZwIFiLIN5qmp4SOKKWA6LSNqIDy+U/OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415376; c=relaxed/simple;
	bh=LaPNV5JwqAPmCbB2AHkLV/E6mdeYaEN1cj3GhiXXACU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJU81DaktpOGhGxowC85jjxSmBMNmOasfdodDBfkJRV/MNY49dtmN89V3+aiqC+ILAKKRjZflPeZSQSEfuQzMtvlkg3hoxwG4YOLcN4eSX3XeMXAy3uvADgru3TJe72XjBSVmrShK0uK3JGP9ayZQRf203FzP2xpxGFnz9Y/oI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmW0aiKS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e89ac45e61so5858331cf.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 23:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762415373; x=1763020173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tiWx6G2y5VkTXLe9CsWA2Y81nDkdhbh4l0X/t/ec0w=;
        b=SmW0aiKS/S+6Z5CB76hei2GkhLCKD6Ww7dLdXEDq2ELJlO07eJ3M3GkBUU/6vcL0tw
         ecJy5DgMS1w3qj+SW1FsQCxZ7fsmjLu0lyq8atwa4p7vbYkbMKKIAPaJIrxKpsc9bAUC
         rNxALbjOWa59jEbzPztzMQ5upC6+g04/GwsS2J/5NE1PO/Y1zdO3emAiO0CUS+vlFZAx
         AqYkC+Bon3vftPISW/kwc6keit3JDLNMethkqDPI3h2JgENL2G4hr8fmqBGIw1X5Jp7p
         Z+alwkSPnc+NVtCdRuttmK9WWwpN6hjwsPeFaBQFpZdU89gtS8NDbgC09Q7YErl8TJdC
         7jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415373; x=1763020173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tiWx6G2y5VkTXLe9CsWA2Y81nDkdhbh4l0X/t/ec0w=;
        b=sFXW83aI5v+WlX5PiGtPIEvM8ysby4y3VAALWsrvC66c6Kn3eJIaJY+8GtfVbgQ/Vw
         Liz1wOxIyjaErqPsswr9Ry76xIhiU3071jgRhTXqkD/SyTCdLfDipO7g8lkPchDux67p
         gGBHl+Hisd+FBspq1OS239UZ20sA5FOETKzC68eYmJN8//kaN7JL2uN8In29PPZMORZm
         hZZmMwt3ZTQPTw0RxDjFkFi92KXqjAN9YOB+TyfdPcCQu19rjFyniTYcyAyfzFlrE5+A
         MKWlM7+uGX6vj1gu4hYqzoTvuztE+bzAkjb9ZQzcgvv04hRhp/5iA2j0hqQ4cOYmLwtb
         EzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YPvUgYlrFeAUPmVXIXh7muDLqKq/xQvwQlgF7mV0ErlwlHRkiLJy2buHkSqdrHaw0gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhSGs2WGUE1PAhwnxWuwbnAVpZ4IXG8GqKSjrux7o7TcqrwFq
	cyantsiiWtb9MLg7V8FpMfph1EeqK9Okk58PNfzpASXw6I4gE/oSy1oEN5RcJAvXEsvUXq9l72x
	fi61bgbUNqUNsiSkFEAv5BryWPTWsFSg=
X-Gm-Gg: ASbGncv+/iuMji4woZyLUR/vrXI0SXRsdKnbHCVl2Avlq+Xh4OcWb7Boq9eJTvhqJBa
	UB1Gm6NwPGZ1yUYQODph9tSXn4tF3WnnhyUy2qrCcf7uJ+8Np7h3t8c+8lMxEaIhHDlYJ890lCz
	/M9FzytUG5jbtMtr9fnklMUqert0KrLIagMg7lzLTLpzHSn6lzhPKQ1j4O5HZfNCuMWFWqURGrz
	wfGJJnT6j1d3uD32WOdzh3XBGdU5zf6ULJ0p4SVqzY3aD9TjX94v2eDOYUXtQ==
X-Google-Smtp-Source: AGHT+IFnfeDempYnux+zQUPN8hPmO1whNM3DVSY4U4bNwH+Nsy3ZE2acm1Goqm/p4GafjK/G+YVJDSv1wBfoOqkJQUI=
X-Received: by 2002:a05:622a:2d3:b0:4ec:ed9e:7fc1 with SMTP id
 d75a77b69052e-4ed7262f327mr86233571cf.60.1762415373358; Wed, 05 Nov 2025
 23:49:33 -0800 (PST)
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
 <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com> <CAEf4Bzb3Eu0J83O=Y4KA-LkzBMjtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3Eu0J83O=Y4KA-LkzBMjtx7cbonxPzkiduzZ1Pedajg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 6 Nov 2025 15:49:18 +0800
X-Gm-Features: AWmQ_bmgI8QZNrZYj30gBC8F2EuWnfMCfYQIX_xp3XQmkC4yFPXeguunpIlcKpE
Message-ID: <CAErzpmtJq5Qqdvy+9B8WmvZFQxDt6jKidNqtTMezesP0b=K8ZA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:11=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 5:48=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf=
 *btf, __u32 type_id)
> > > > > > >         return type_id;
> > > > > > >  }
> > > > > > >
> > > > > > > -__s32 btf__find_by_name(const struct btf *btf, const char *t=
ype_name)
> > > > > > > +/*
> > > > > > > + * Find BTF types with matching names within the [left, righ=
t] index range.
> > > > > > > + * On success, updates *left and *right to the boundaries of=
 the matching range
> > > > > > > + * and returns the leftmost matching index.
> > > > > > > + */
> > > > > > > +static __s32 btf_find_type_by_name_bsearch(const struct btf =
*btf, const char *name,
> > > > > > > +                                               __s32 *left, =
__s32 *right)
> > > > > >
> > > > > > I thought we discussed this, why do you need "right"? Two binar=
y
> > > > > > searches where one would do just fine.
> > > > >
> > > > > I think the idea is that there would be less strcmp's if there is=
 a
> > > > > long sequence of items with identical names.
> > > >
> > > > Sure, it's a tradeoff. But how long is the set of duplicate name
> > > > entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> > > > with high likelihood will take more comparisons.
> > >
> > > $ bpftool btf dump file vmlinux | grep '^\[' | awk '{print $3}' | sor=
t | uniq -c | sort -k1nr | head
> > >   51737 '(anon)'
> > >     277 'bpf_kfunc'
> > >       4 'long
> > >       3 'perf_aux_event'
> > >       3 'workspace'
> > >       2 'ata_acpi_gtm'
> > >       2 'avc_cache_stats'
> > >       2 'bh_accounting'
> > >       2 'bp_cpuinfo'
> > >       2 'bpf_fastcall'
> > >
> > > 'bpf_kfunc' is probably for decl_tags.
> > > So I agree with you regarding the second binary search, it is not
> > > necessary.  But skipping all anonymous types (and thus having to
> > > maintain nr_sorted_types) might be useful, on each search two
> > > iterations would be wasted to skip those.
>
> fair enough, eliminating a big chunk of anonymous types is useful, let's =
do this
>
> >
> > Thank you. After removing the redundant iterations, performance increas=
ed
> > significantly compared with two iterations.
> >
> > Test Case: Locate all 58,719 named types in vmlinux BTF
> > Methodology:
> > ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
> >
> > Two iterations:
> > | Condition          | Lookup Time | Improvement |
> > |--------------------|-------------|-------------|
> > | Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > | Sorted (Binary)    | 19 ms       | 909x faster |
> >
> > One iteration:
> > Results:
> > | Condition          | Lookup Time | Improvement |
> > |--------------------|-------------|-------------|
> > | Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > | Sorted (Binary)    | 10 ms       | 1762x faster |
> >
> > Here is the code implementation with a single iteration approach.
> > I believe this scenario differs from find_linfo because we cannot
> > determine in advance whether the specified type name will be found.
> > Please correct me if I've misunderstood anything, and I welcome any
> > guidance on this matter.
> >
> > static __s32 btf_find_type_by_name_bsearch(const struct btf *btf,
> > const char *name,
> >                                                 __s32 start_id)
> > {
> >         const struct btf_type *t;
> >         const char *tname;
> >         __s32 l, r, m, lmost =3D -ENOENT;
> >         int ret;
> >
> >         /* found the leftmost btf_type that matches */
> >         l =3D start_id;
> >         r =3D btf__type_cnt(btf) - 1;
> >         while (l <=3D r) {
> >                 m =3D l + (r - l) / 2;
> >                 t =3D btf_type_by_id(btf, m);
> >                 if (!t->name_off) {
> >                         ret =3D 1;
> >                 } else {
> >                         tname =3D btf__str_by_offset(btf, t->name_off);
> >                         ret =3D !tname ? 1 : strcmp(tname, name);
> >                 }
> >                 if (ret < 0) {
> >                         l =3D m + 1;
> >                 } else {
> >                         if (ret =3D=3D 0)
> >                                 lmost =3D m;
> >                         r =3D m - 1;
> >                 }
> >         }
> >
> >         return lmost;
> > }
>
> There are different ways to implement this. At the highest level,
> implementation below just searches for leftmost element that has name
> >=3D the one we are searching for. One complication is that such element
> might not event exists. We can solve that checking ahead of time
> whether the rightmost type satisfied the condition, or we could do
> something similar to what I do in the loop below, where I allow l =3D=3D =
r
> and then if that element has name >=3D to what we search, we exit
> because we found it. And if not, l will become larger than r, we'll
> break out of the loop and we'll know that we couldn't find the
> element. I haven't tested it, but please take a look and if you decide
> to go with such approach, do test it for edge cases, of course.
>
> /*
>  * We are searching for the smallest r such that type #r's name is >=3D n=
ame.
>  * It might not exist, in which case we'll have l =3D=3D r + 1.
>  */
> l =3D start_id;
> r =3D btf__type_cnt(btf) - 1;
> while (l < r) {
>     m =3D l + (r - l) / 2;
>     t =3D btf_type_by_id(btf, m);
>     tname =3D btf__str_by_offset(btf, t->name_off);
>
>     if (strcmp(tname, name) >=3D 0) {
>         if (l =3D=3D r)
>             return r; /* found it! */

It seems that this if condition will never hold, because a while(l < r) loo=
p
is used. Moreover, even if the condition were to hold, it wouldn't guarante=
e
a successful search.

>         r =3D m;
>     } else {
>         l =3D m + 1;
>     }
> }
> /* here we know given element doesn't exist, return index beyond end of t=
ypes */
> return btf__type_cnt(btf);

I think that return -ENOENT seems more reasonable.

>
>
> We could have checked instead whether strcmp(btf__str_by_offset(btf,
> btf__type_by_id(btf, btf__type_cnt() - 1)->name_off), name) < 0 and
> exit early. That's just a bit more code duplication of essentially
> what we do inside the loop, so that if (l =3D=3D r) seems fine to me, but
> I'm not married to this.

Sorry, I believe that even if strcmp(btf__str_by_offset(btf,
btf__type_by_id(btf,
btf__type_cnt() - 1)->name_off), name) >=3D 0, it still doesn't seem to
guarantee that the search will definitely succeed.

>
> >
> > static __s32 btf_find_type_by_name_kind(const struct btf *btf, int star=
t_id,
> >                                    const char *type_name, __u32 kind)
> > {
> >         const struct btf_type *t;
> >         const char *tname;
> >         int err =3D -ENOENT;
> >         __u32 total;
> >
> >         if (!btf)
> >                 goto out;
> >
> >         if (start_id < btf->start_id) {
> >                 err =3D btf_find_type_by_name_kind(btf->base_btf, start=
_id,
> >                                                  type_name, kind);
> >                 if (err =3D=3D -ENOENT)
> >                         start_id =3D btf->start_id;
> >         }
> >
> >         if (err =3D=3D -ENOENT) {
> >                 if (btf_check_sorted((struct btf *)btf)) {
> >                         /* binary search */
> >                         bool skip_first;
> >                         int ret;
> >
> >                         /* return the leftmost with maching names */
> >                         ret =3D btf_find_type_by_name_bsearch(btf,
> > type_name, start_id);
> >                         if (ret < 0)
> >                                 goto out;
> >                         /* skip kind checking */
> >                         if (kind =3D=3D -1)
> >                                 return ret;
> >                         total =3D btf__type_cnt(btf);
> >                         skip_first =3D true;
> >                         do {
> >                                 t =3D btf_type_by_id(btf, ret);
> >                                 if (btf_kind(t) !=3D kind) {
> >                                         if (skip_first) {
> >                                                 skip_first =3D false;
> >                                                 continue;
> >                                         }
> >                                 } else if (skip_first) {
> >                                         return ret;
> >                                 }
> >                                 if (!t->name_off)
> >                                         break;
> >                                 tname =3D btf__str_by_offset(btf, t->na=
me_off);
> >                                 if (tname && !strcmp(tname, type_name))
> >                                         return ret;
> >                                 else
> >                                         break;
> >                         } while (++ret < total);
> >                 } else {
> >                         /* linear search */
> > ...
> >                 }
> >         }
> >
> > out:
> >         return err;
> > }

