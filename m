Return-Path: <bpf+bounces-73787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A0C39388
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 07:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DAD1A24D6D
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F12DBF78;
	Thu,  6 Nov 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHoDwdnR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEC2D12E7
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409426; cv=none; b=NwZ7quw8ffbgH42U4Mb05waTL8s0lj2aRid5CyfeBQrx6mOmqi6HyoY0RB+98qyB4UUTinL4QsU51e9GgEt8rJi8AWmV8VxLD2D5XuLhbvSMwCkyI6s5Nf2syHluf9cLbxU/vCGUj/u6XQBnvBoyIzgU7ul+vwcsqyw9bGEKGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409426; c=relaxed/simple;
	bh=8zU8wbn2z1V8CTGGApcTBZoXpzriYORpFImI4i1/BrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhJgN53YNC9Zw4W0qIDKmHq0M2mKYpRpYEES9AdupyNvDKlfbVJX+NIdvR7z6IYzExn7WJihI2GjjemfcAF+IA3efTO05485f7WDvemJ9ruxigy3F+Nsll+k7OUQ02IZWym0+QOygZje02vdKwYQW8w+PvEQ/snsSGytuaL33Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHoDwdnR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b729a941e35so33264366b.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762409423; x=1763014223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orfpxuWkJXcAaZjFD8OqI76Fe/duVOXyBW/7SsSgZf4=;
        b=DHoDwdnRvI9Gqutlcqo9qn9dqQb0+ctH5kMlDucdh7lY0hOAmmWbd4a+ujnH8mzaxU
         MVA4r2YgkitB0eR2ip5ktTswmQtIvSSKJr1SFuSBQ5dbBRk0aeWuCyzrBPwuL28sKv8T
         3uEfZ0OwsT9HHUrcUokQsLK4gkwBP8sMFrAWCiVBVoLAdADNnSWXkXyXI87k9fY6yR5F
         ezmZPHdhihhEok7ku+UYMQVGj498TD4gDtagGQecy/Uq4ie1AH/6WK6SnxrxUaom9uik
         zUWbtQ+tESmuCWZulF47wFf721ohHESZKhS9WFMDSPNkpKlDb3eJ6W72EU8YNcKqWpHX
         R3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409423; x=1763014223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orfpxuWkJXcAaZjFD8OqI76Fe/duVOXyBW/7SsSgZf4=;
        b=LcjOug4MKoQTyHX0tkmzNI2kImPKq/OdsLtduzoboTMkPuXXLzeCy0KSvJoK2moYnM
         aT8YPmOHDTTFcdHQbEaJlxoDUlY7cCZyi4XmqjX0luk6rOwKWk3McqMwc4gsJC3wFsK8
         J5N+pdiVDkjIa91gli+OnTjAzZ58jelCU3PY2Yu7mU6WKc8U1e5t+fs+KHE/WwmSiTRw
         grflw3+DdHzziwEx4FUnu4gXiqINvOt99aVBePN8noMaDOsXuUxWulzEiKlrKTqt4MIl
         29/hKrg6CJrdtcAqbGKXHPO+RNykYAYgN3iMNqb/WV+bEEFCtdkAhdxV92JXrXvf/K7n
         EvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhGhgtZz4aQlVG6PcI4BLrKj4b3JpElQ3BOw3RbNGiflZ0Bmx6kk+WIuCVnZ2l38S43d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxcVQVmhA2GHmmTeZAH/CJklfYnSw79EY4p5VJ51PnfLjEFJI
	+AwwtoPKZstE2QJcMYCSO9NOI7k5yEv4bsbaBg1N6VAkSkQHg6jYDUwsdjEa8bbz6IkQ007Xjx9
	kViGSnShN+8cBE3E+MAtyFt6jduIpl04=
X-Gm-Gg: ASbGnctnufjPcq0vroMYJuj60SysjjiSAvxarcOq5fq88Oj/psO8wXfqby4k+lIPqBg
	gIosLUxpVjWfBza1huJjnM1hH5Wp6LgevyKm7PQgtL4e/+k7L29zX2qwyyaM0db58v4vLETm3Oz
	x1iTp3O9tqdqXkXKpZPmsgpmyC62kXIMguay4unAD1hxUl8hAtfRFrLgdWBdcGILYhkezCqAPrg
	Xm6KYI0bq11XUVb9upi7AWWdTw45M8TTJWt4l38/jyznPqaeKS/I7hKbf7qZdltL9sPZner
X-Google-Smtp-Source: AGHT+IEidHI/FsHQMKJRhGUczDXlQ9eJAKyM9ahYXSasyjeT6UMUJOVYgc8zIR1wN6nxxZFYAqEzwcdOGM1mMiUmSvc=
X-Received: by 2002:a17:907:3da3:b0:b70:7cd8:9098 with SMTP id
 a640c23a62f3a-b72655ee49emr621490466b.61.1762409423165; Wed, 05 Nov 2025
 22:10:23 -0800 (PST)
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
 <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com> <f6b2596eadf032516b81c19c6f9a8fd85c8ff195.camel@gmail.com>
In-Reply-To: <f6b2596eadf032516b81c19c6f9a8fd85c8ff195.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 6 Nov 2025 14:10:11 +0800
X-Gm-Features: AWmQ_blC0ncp1CzLNuLcqLTH7HRaiajrysKatVZp9OLg5bZUuEHPLLgr-byQw5w
Message-ID: <CAErzpmsoNO66S8ER8EfmH-9H_iMAEWQGtKNEF=767-n3SR-JJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-05 at 21:48 +0800, Donglin Peng wrote:
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
> > > Condition          | Lookup Time | Improvement |
> > > --------------------|-------------|-------------|
> > > Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > > Sorted (Binary)    | 19 ms       | 909x faster |
> >
> > One iteration:
> > Results:
> > > Condition          | Lookup Time | Improvement |
> > > --------------------|-------------|-------------|
> > > Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > > Sorted (Binary)    | 10 ms       | 1762x faster |
> >
> > Here is the code implementation with a single iteration approach.
>
> Could you please also check if there is a difference between having
> nr_sorted_types as is and having it equal to nr_types?
> Want to understand if this optimization is necessary.

Yes, here is the result:

| Condition                                       | Lookup Time   |
Improvement  |
|----------------------------------------------|------------------
--|------------------|
| Unsorted (Linear)                          | 16666461 us   | Baseline    =
   |
| Sorted (Binary) nr__types             | 9957 us           | 1673x faster =
|
| Sorted (Binary) nr_sorted_types   | 9337 us           | 1785x faster |

Using nr_sorted_types provides an additional 6% performance improvement
over nr_types.

>
> [...]

