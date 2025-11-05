Return-Path: <bpf+bounces-73673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F02C370C9
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA14666416B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F5A336ECD;
	Wed,  5 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn68VZJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF31C56F
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361561; cv=none; b=ZHPZxuUbwim/073yw0cp7K6zLEx0K4mXb7QbdyVvyuEuUXaHyHnOXLK+z0dvVio/lQQF4uVp06+Zwcd0Hj83Y+IvKjZ/uWF1pZY+Qsee76Qachd/oEc81ngYlUknRJxaLveggLVj7Wf7TiSRbZ8gXRblRKPF2fUhD+Wjq9y2R08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361561; c=relaxed/simple;
	bh=6wlmdmjnSpQU9fRc7lN675cJD65XkkBg2XnCXVvTink=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1tUODd9kOIg273qrRe4KQzlj3n2uBk4PUVzQssEhtJjLepM17PZSdXjYUj8HXRBH67bUtI++75QaJS3uVO8jdSz4UpI5IUAXP9DNgywSoFrfbkuHjfMzm+6jX+6IIZ8az/3PwfxnEVWs87a4Lw2jiD258lS9iDXmkLBXnrF3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn68VZJz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so106998b3a.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361559; x=1762966359; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=St/YlSF/6HVAUWQqHTUl+fK8jNSN2VE1+U7dKILtNmc=;
        b=dn68VZJzJ5GP9rJXzmNvjgEyPN89FdMLJJ30b9qsVrokmj/Wu5fU/tEsXhVPxcjdEQ
         dJJygETU28Ca+DBzyaWH8aWABsi8kDYyXXkIcnkc0VQNhhwUSkcZ4rZnhHjX4gT1LgBe
         F//Q/ELK6ZOeuJ3bealosxzX4K0AxMxp5ofQIhhAYBV37ffQv3JD6rRtzYV29pNGObd0
         8eQemK8/gpsC12AEaWcgtfN4m0tmiPrsDcnNqHOhsG8XFrHc6+QeqeTH4b9hnGGQ9gU8
         kBx6lhILl6PZOVsx2Cy867fZOsvwXde1ahMzZOqrJ+TykPmeyUq1Xy+gPpYh4KPfZQ7s
         yqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361559; x=1762966359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St/YlSF/6HVAUWQqHTUl+fK8jNSN2VE1+U7dKILtNmc=;
        b=nHBmTc8sFWsWc0RuGHUvDBMT9fNYpokJffnwcCfM1BaUCuL7+dt/buvn58yWQqPRyB
         9dDCHurYQaLhRuMLhzvqdnNLKMcswTPXQqK44Az8Q9t3SHYCzRod4PoXN9xHP7uWyNiV
         JiK8QsiqfFj34rmZyLu6vP8ZZfJl2jELmKTbHeA6KlL8GsvzNXX0GUyZ5TfIl6s4inS0
         nUrF/vFRHMwhxi7wDbV3r70M2y+u8izFdd+Lgr3rHCYG4tGJRHcYCXJC7JI7mUuksY6w
         O5/j4+nCLvhKQOmILwLGyI5H9SGqvpRmHIW1yYQHwMfCPzngsq9/nfuGKMjajPFNDNY+
         BnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX9/uzbTEYHJqAiHqaICqxXD5h84RNM6kG69zPB+8aDBKJeghiTZI0BO52JucqeAdR5Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUweqs1lwZtSJUs08icV5YPjNluURetsCpf8pmMPTb+RpJl8N
	Q9t/wzCi2rhN7dgpI5wSki1KEtO3yNCNEweirDdYgUw0sL+vEBZ/xzLi
X-Gm-Gg: ASbGncuKbRJ+9a4Ywtb7Xalf3Gxfu9cCkxSfRiWjER2sxOd+obyI353qZkblh5vNRfM
	RRXHf7xleTLki2wSWE7jEEtgSDBQfmUAF8916/Uny4kvUyyL9OesV7uAE/WlNy22PcpBG3PNlYf
	q5AcILVlhScHUZXgMAOWuRDFarCoWX5EQlpeQcoKDrnkdUKsBRHvye3zZLJr4S7OXiHIw3lHHSY
	BSdNjqWRJ4IXzaZ6FBCUWLWftAyueJDNau0O07XNZec4E+U923yfluIXOMmHz9hXuph2c3tNus2
	NSbGO+oatvIN/WGMPVj5UNM3cK6pYH/aKMoTnpz8C4+xikyLfZHJdHPmAk3DyhV4xJdUNgZvgzm
	/pdq5gaXm8f2GsA5MtyBvaaMsMaKf9RWqmIV8DRG10RnRRwhVJm/rA+WSINQeqpo8/Ns/c8Jgcp
	YIvwjJelokcJ/P1rug8IsLz07bddgh3qNQjXw=
X-Google-Smtp-Source: AGHT+IHR2B6DtDaHzOI4A23z85FIW2164BTIShW+IpjXW96KXD/wdqkXo75vpTMPhnVKAlOTsJ7Iyg==
X-Received: by 2002:a05:6a00:3926:b0:7aa:a8b6:73fe with SMTP id d2e1a72fcca58-7ae1f8804aemr4060602b3a.25.1762361559242;
        Wed, 05 Nov 2025 08:52:39 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f857sm6958895b3a.45.2025.11.05.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:38 -0800 (PST)
Message-ID: <f6b2596eadf032516b81c19c6f9a8fd85c8ff195.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan
 Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Wed, 05 Nov 2025 08:52:37 -0800
In-Reply-To: <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
	 <CAEf4BzaxU1ea_cVRRD9EenTusDy54tuEpbFqoDQUZVf46zdawg@mail.gmail.com>
	 <a2aa0996f076e976b8aef43c94658322150443b6.camel@gmail.com>
	 <CAEf4Bzb73ZGjtbwbBDg9wEPtXkL5zXc3SRqfbeyuqNeiPGhyoA@mail.gmail.com>
	 <7c77c74a761486c694eba763f9d0371e5c354d31.camel@gmail.com>
	 <CAErzpmtu7UuP9ttf1oQSuVh6f4BAkKsmfZBjj_+OHs9-oDUfjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 21:48 +0800, Donglin Peng wrote:
> On Wed, Nov 5, 2025 at 9:17=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-04 at 16:54 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 4, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > > @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *=
btf, __u32 type_id)
> > > > > >         return type_id;
> > > > > >  }
> > > > > >=20
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
> > > > >=20
> > > > > I thought we discussed this, why do you need "right"? Two binary
> > > > > searches where one would do just fine.
> > > >=20
> > > > I think the idea is that there would be less strcmp's if there is a
> > > > long sequence of items with identical names.
> > >=20
> > > Sure, it's a tradeoff. But how long is the set of duplicate name
> > > entries we expect in kernel BTF? Additional O(logN) over 70K+ types
> > > with high likelihood will take more comparisons.
> >=20
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
> >=20
> > 'bpf_kfunc' is probably for decl_tags.
> > So I agree with you regarding the second binary search, it is not
> > necessary.  But skipping all anonymous types (and thus having to
> > maintain nr_sorted_types) might be useful, on each search two
> > iterations would be wasted to skip those.
>=20
> Thank you. After removing the redundant iterations, performance increased
> significantly compared with two iterations.
>=20
> Test Case: Locate all 58,719 named types in vmlinux BTF
> Methodology:
> ./vmtest.sh -- ./test_progs -t btf_permute/perf -v
>=20
> Two iterations:
> > Condition          | Lookup Time | Improvement |
> > --------------------|-------------|-------------|
> > Unsorted (Linear)  | 17,282 ms   | Baseline    |
> > Sorted (Binary)    | 19 ms       | 909x faster |
>=20
> One iteration:
> Results:
> > Condition          | Lookup Time | Improvement |
> > --------------------|-------------|-------------|
> > Unsorted (Linear)  | 17,619 ms   | Baseline    |
> > Sorted (Binary)    | 10 ms       | 1762x faster |
>=20
> Here is the code implementation with a single iteration approach.

Could you please also check if there is a difference between having
nr_sorted_types as is and having it equal to nr_types?
Want to understand if this optimization is necessary.

[...]

