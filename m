Return-Path: <bpf+bounces-77387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40548CDADF3
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D553830215B7
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A327470;
	Wed, 24 Dec 2025 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXHTNJ4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C33A1E66
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534545; cv=none; b=qtMSdmHsN9IvrKO4M2yseNxErM79hVZI2EkHoefXdw0335wp7K0MqlvJUUe/6ACVtZJdVeJ/xU/RGJy74zlUnx2s87i4nbLYf0hprrDdASQ+nDpwjqRhNYhYCi7YNM5owcKHob93wM7U41kw0Uc7bGwBlR8war0eqs58UENI050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534545; c=relaxed/simple;
	bh=cWnSGhX3fRsjRGUxYR6Q1iZkcX6u6xtNxHHEiEGa1J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET4kp1L6TejgUGoBj5Z2q5QFGzMpZMc2cv82upd6S1KX8SwMYZq0qIRDGiSxHcogQWabMm64dZ1W1ryFoeWFnrag3C/kgpTIE/Un49IZ5bVLUBYfIImIvxCKXH3edqvEwjY8l5FUJ1pxwxm6txfhzFv0vCF6SknwXrR/X46OCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXHTNJ4d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso2352085f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 16:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766534541; x=1767139341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNq04KyX4u+/SigXBa3Lf7cP2T4UTCtYwjP7aiG8wIM=;
        b=DXHTNJ4d4VZpw99ug7d5FXBP2wrGMW9oBvZHR5DF6zbs2qSF0Q57cKSM8gJwcBNXJv
         B44kdvnPD/bleHaKNiTIKbzqZEhTKQhmtK57O0WRkWiqifa16GfmDqshyN0vPlqX8vjA
         dICxq9h7iegwnO/WooGy1wDGPSy2WtzbsRqF587u1KRaTZlVJWRyN8IyaCgXTWKtkiRY
         DlRcqNkY75A3mX4mQLM6V0kGf8Nai65vaXuX+u8f/l25dao9VVn8ouS9cZcvXnmaO2by
         Y2uGoCRj2WSztpuqQZSTCbINgr19JjBdG8kxat9Euwo8DYP+3OLvjfzTHEZnz3HEMjHq
         6bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766534541; x=1767139341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZNq04KyX4u+/SigXBa3Lf7cP2T4UTCtYwjP7aiG8wIM=;
        b=ZetCk3dAJ5JHV59XpZY+FMHJ//eS8d5UoFqOtcVaThwhPRHoj/UdLSoUWzrsHx9X+A
         woeDdN5wuQuZcWkBtMwF9x4h5CicTtV8NDz0cOs4M5TPc1oOQJgOBRAVMBXOf0uzKXeF
         wcbBK0JYAd6OPLr7HMpLUQJIkLqt2Mwt5PN3ww1DjEltdcnERRZglLdPK3EeBSxuhVJe
         oIMQBdYTnZxhsIlE4QVsk7PklSDFOQ16pqT0v07xGdi8HBKAYxvKsCSmoYqJsG2gr/jP
         KHuyL3teuy+N+Zvs4e6NW8OaUG3YogywARZ7KOhHrNuJPsTX7kLwi5IlzWGYH8bO9o0Y
         JwQA==
X-Gm-Message-State: AOJu0Yy55zHVR+Dv1DErU3I6fGAHtlG6/5d3JDlx9Bft0DOEc0Vb6x6s
	B1sUAaNuFwxA6cJBlH2nE3nf6o0VIp7wZA9aF6pyjMOGBRNqA6IIrHa4tKoKYLY43X13OEYsaiX
	IbmpaJNADCSz12w0bo1FOjX9I/qP1cKI+wA==
X-Gm-Gg: AY/fxX6KN3ih1ZoevzSiKvNQdDxtTZjh43dvC3cZvy/rJJXqzo7hk6uTnoIv5vS3VES
	betQvx1TgL11Y5srrnPcSRjfituc14UmZPN8lQGjaXyo/bNcjhaMx6CgsfkKXO+SJqYndJ7uetN
	ROeJCqheOTdFHfB/zkpn3aEbsv42k52ojeOSwlw0O3KiYRyAYcUUj3U+2qlLqOd9oqO56sg67YU
	0D8g32uU4o7kr/uhRG0dWSUJ6utaN2NhdrXZssxrwnJROgWBqS3ns6aGYPuyVc8gUL81Fsk
X-Google-Smtp-Source: AGHT+IGb4ZufKFxeiY5mdb4HrBELYv2p38TBNfYZTNFBSabJV61irE31LdKVNHoS29JVN07+GidyFjnWjdNunzLuhSE=
X-Received: by 2002:a05:6000:4202:b0:430:f5ed:83f9 with SMTP id
 ffacd0b85a97d-4324e4c71b0mr15321419f8f.2.1766534541320; Tue, 23 Dec 2025
 16:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
 <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
 <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com> <CANk7y0hCBWW+z2Z_c8p9Wb8-nXRp_1HJHSLLCDpxcUQz4qM_tA@mail.gmail.com>
In-Reply-To: <CANk7y0hCBWW+z2Z_c8p9Wb8-nXRp_1HJHSLLCDpxcUQz4qM_tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 14:02:09 -1000
X-Gm-Features: AQt7F2rDpDhwo-ZsLZvjTltWjM7cvRb2FdCj0j5Lrk_WMgNzhyR0L1rd2Um_Qy8
Message-ID: <CAADnVQLzKsogyKoo_aiY4nx96YS1MrAfU5kAMBvmuTsrxaESnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 1:13=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Dec 23, 2025 at 7:36=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@ke=
rnel.org> wrote:
> > > > >
> > > > >  int reserve_invalid_region(void *ctx)
> > > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_lar=
ge.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > > > >                 return 9;
> > > > >         return 0;
> > > > >  }
> > > > > +
> > > > > +SEC("socket")
> > > > > +__success __retval(0)
> > > > > +int big_alloc3(void *ctx)
> > > > > +{
> > > > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > > > +       char __arena *pages;
> > > > > +       u64 i;
> > > > > +
> > > > > +       /*
> > > > > +        * Allocate 2051 pages in one go to check how kmalloc_nol=
ock() handles large requests.
> > > > > +        * Since kmalloc_nolock() can allocate up to 1024 struct =
page * at a time, this call should
> > > > > +        * result in three batches: two batches of 1024 pages eac=
h, followed by a final batch of 3
> > > > > +        * pages.
> > > > > +        */
> > > > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_=
NO_NODE, 0);
> > > > > +       if (!pages)
> > > > > +               return -1;
> > > > > +
> > > > > +       bpf_for(i, 0, 2051)
> > > > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > > > +       bpf_for(i, 0, 2051)
> > > > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > > > +                               return i;
> > > > > +
> > > > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > > > +#endif
> > > > > +       return 0;
> > > > > +}
> > > >
> > > > CI says that it's failing on arm64.
> > > > Error: #511/6 verifier_arena_large/big_alloc3
> > > > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> > > >
> > > > cannot quite tell whether it's sporadic or caused by this patch set=
.
> > >
> > > I tried reproducing it locally multiple times and it didn't fail. It
> > > also doesn't fail on manual CI run:
> > > https://github.com/kernel-patches/bpf/actions/runs/20442781110/job/58=
740000164?pr=3D10475
> > >
> > > I assume it is sporadic.
> >
> > Ok. Applied. Let's watch for this. If it's actually flaky
> > we need to fix it.
>
> I have found out why it fails sometimes:
>
> arena_alloc_pages() -> bpf_map_alloc_pages(1024) ->
> alloc_pages_nolock(1) this is called in a loop and fails sometimes,
> from my debug prints:
>
> __bpf_alloc_page: alloc_pages_nolock failed for nid=3D-1
> bpf_map_alloc_pages: allocation failed at page 435/1024, freeing 435
> already allocated pages
> bpf_map_alloc_pages: returning ret=3D-12, allocated 435/1024 pages
> fail: bpf_map_alloc_pages failed with ret=3D-12 for 1024 pages
>
>
> The VM runs with 4G of memory, when I changed this to 8G, this stopped fa=
iling.

That doesn't quite make sense.
The test allocates 2051 pages, that's just 8 Mbyte. Nowhere
close to a Gbyte. So 4Gb should be plenty.
Number of cpus shouldn't matter either.

> So, I think we can do the same for the CI.
> The CI currently runs through vmtest which runs a VM with 4G of memory
> an 2 CPUs by default:
>
> I checked the logs of the CI and saw:
>
> [ 0.626933] smp: Brought up 1 node, 2 CPUs
> [ 0.628387] smpboot: Total of 2 processors activated (12029.10 BogoMIPS)
> [...]
> [ 0.629145] Memory: 3388084K/4193784K available
>
>
> I think we should change the CI to run vmtest with 8 CPUs and 16G of memo=
ry.
>
> Here is a PR for this change: https://github.com/libbpf/ci/pull/206

I don't think we should bump it without full understanding.
It's better to make selftest recover on page alloc failure.

