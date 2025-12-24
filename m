Return-Path: <bpf+bounces-77423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE73CDD049
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3513010AB2
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D72D6E72;
	Wed, 24 Dec 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eitQKSho"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025922A4FC
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766603201; cv=none; b=KrQyaIqF7wC4Xw7W6z3OA8eSNi5HfWmjwAi6SUBfYbYARshSH+M/EW/+tPFq5bCXtpEG43v3q8GCfO6FTp9qIIV+DNX6mLJGn/jbmzr390i9ChBIR31aQI5w8g6y53XJ/B6Qb8RQHsPIkHZSOy9gSQEQIvnvCvDaNXxJlaBzE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766603201; c=relaxed/simple;
	bh=xtucAJmd1Kjq3DqsMDGjdyjyM/T1mgJvo33rrpECKEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf6fWavFlhnqvsJ6sCTQTd6HREP9a6ddpejq+UPGgtPBBNt+OIt2qzd1HPMUBumLrAXIaMKrKJDvDSUmi3RBjmjt6NV9OOnJ/28itDaLJhwOojRmAa+DGQBWrRul7qHvU6onKHo9jA5FYBn0xjObz+dtBeYwIrQmziCOcBVdZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eitQKSho; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so7006933a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 11:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766603198; x=1767207998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wawGHGtUHQYAJgeAgwLK9yAAc8/77tC9ON3jiRBFhOs=;
        b=eitQKShoXdet1yq7XI+pqGccyakXVLkapXj0X2aiQEf5dy1skAyKrKUB8kYs7NCRTJ
         w/QFwun0ooRea0AiNA+70bsM0eTCoa2JU9C38PlH4d5t/rLc775FE7SI5BKNvXnNSJBo
         mRib/z0l5C+ySg0285NB4YMM2XbywG5HYmsrQxdguGFfAp3r48F3dx5lfoQDF07Yh0HU
         B1xy58M9fgj3pfwu3h034uYAHbmdWdxBN0lqEM8QE4YUw2Wx/tl9lUvg31XAQVErx0QE
         19OzZS5kUM7It78q2gHJuDs9QZaFJiPdWWd6fE3FAb8sIrWLP4L5whV5pvZzDnEbl0Vb
         n0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766603198; x=1767207998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wawGHGtUHQYAJgeAgwLK9yAAc8/77tC9ON3jiRBFhOs=;
        b=h9cNE3HvCsT3UxYiFo6F6ODTMuFOsM87SHrYdN7Y0Lk5ipSR7F98ZFBgOO+pxr00FX
         qnoGHlUjhjFJOoIHTHguAa7WWyv2YW/yfBMkcIbc1U6hykPAaiIp8DJyjiz4hoMltdgV
         Xz+Ys3cI5DHLlPL6zFnEDvKrpo4MvJ9ldQc2SZaYUvpa3wXcBpW8+HwVgb+bK5qg2JxH
         yOOXNayZi1F3AveYpGUOKt5MvYYfFnqbEDTDcDfDBxXUj7FuokkDX7//0k0H9RemBTyC
         hrcUQagf1da/Pnpxs2hwgT7i3KsWC94FLg3gLkFTo8BStRcN9/dgpsmsDrXnXk0949CI
         5JCA==
X-Gm-Message-State: AOJu0YwXM0fRjsdMLdyjEeja/Fnia83GVybxA4zuPCd15bHdp0ogc53/
	S0vZtFizljOgkJe4CAWzbCEiTcy0oQ/sbxJOTp8e+X9WaHHrNM12u4GprDl3AayL09AbdsRsoU2
	c4bHaK/PY++HBHcOdRzto3FvLv/I7leo=
X-Gm-Gg: AY/fxX6Pln/5dmcpiP6k8Z3533Lpx7BaoW7Tpg+duEzxtB+30l4xlUO0D9rEldnV9TR
	Zty8C8GlGtAE+Ux6AN7zfhlFTqco4qjMVyV2YBWl/WR5h9Dij541wR5Aa2c2jNXcLuR/d+wxx4Q
	R9kJ3aK/uZErq3Vt3b/rTN5IdB84IYZu1lrHAqiyxLyltYzAG1lX1/P+8xZq+FZJxreDXhuBULI
	fwuwBqIszegpQafVPfu3giO4NIvb7b0nD4w/DU6iiL8ES+Bc9YzWdz0BZxkOMIBLB3XKd22wQrh
	ns1/UUglEII=
X-Google-Smtp-Source: AGHT+IEs/efHcmjJPHv95aEG3HAEMhgF28vMqLcsucDwRm+2Ha5EXPBbQYDhnL5Z90Ez0P1vps/KW09HDX15qrRNuX0=
X-Received: by 2002:a17:907:7246:b0:b73:792c:6326 with SMTP id
 a640c23a62f3a-b8036ebbbc5mr1854788866b.11.1766603197565; Wed, 24 Dec 2025
 11:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
 <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
 <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com>
 <CANk7y0hCBWW+z2Z_c8p9Wb8-nXRp_1HJHSLLCDpxcUQz4qM_tA@mail.gmail.com>
 <CAADnVQLzKsogyKoo_aiY4nx96YS1MrAfU5kAMBvmuTsrxaESnA@mail.gmail.com>
 <CANk7y0jqPRE1u5uEPRCtsOT46uUUnjyQik3XWrMcSrq3bfgPFQ@mail.gmail.com> <CAADnVQ+rXZKutzsUJGD7mSFAUFhyKeG73Oiw6TkgPMfFGVqong@mail.gmail.com>
In-Reply-To: <CAADnVQ+rXZKutzsUJGD7mSFAUFhyKeG73Oiw6TkgPMfFGVqong@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 24 Dec 2025 19:06:24 +0000
X-Gm-Features: AQt7F2op6TtYTDRg0B_R02LZxkgkHbpQ9LmY-GitJtaNs7vlOpx3tWljRLWMppk
Message-ID: <CANk7y0jsWjt4VMbCza7TOLLXSVtGA=MDNVj3roTrwG=ZMhcG3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 12:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 23, 2025 at 2:28=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > On Wed, Dec 24, 2025 at 12:02=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 1:13=E2=80=AFPM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Dec 23, 2025 at 7:36=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay1=
2@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puran=
jay@kernel.org> wrote:
> > > > > > > >
> > > > > > > >  int reserve_invalid_region(void *ctx)
> > > > > > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_are=
na_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > > > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > > > > > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_larg=
e.c
> > > > > > > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_larg=
e.c
> > > > > > > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > > > > > > >                 return 9;
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > > +
> > > > > > > > +SEC("socket")
> > > > > > > > +__success __retval(0)
> > > > > > > > +int big_alloc3(void *ctx)
> > > > > > > > +{
> > > > > > > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > > > > > > +       char __arena *pages;
> > > > > > > > +       u64 i;
> > > > > > > > +
> > > > > > > > +       /*
> > > > > > > > +        * Allocate 2051 pages in one go to check how kmall=
oc_nolock() handles large requests.
> > > > > > > > +        * Since kmalloc_nolock() can allocate up to 1024 s=
truct page * at a time, this call should
> > > > > > > > +        * result in three batches: two batches of 1024 pag=
es each, followed by a final batch of 3
> > > > > > > > +        * pages.
> > > > > > > > +        */
> > > > > > > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051,=
 NUMA_NO_NODE, 0);
> > > > > > > > +       if (!pages)
> > > > > > > > +               return -1;
> > > > > > > > +
> > > > > > > > +       bpf_for(i, 0, 2051)
> > > > > > > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > > > > > > +       bpf_for(i, 0, 2051)
> > > > > > > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > > > > > > +                               return i;
> > > > > > > > +
> > > > > > > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > > > > > > +#endif
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > >
> > > > > > > CI says that it's failing on arm64.
> > > > > > > Error: #511/6 verifier_arena_large/big_alloc3
> > > > > > > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> > > > > > >
> > > > > > > cannot quite tell whether it's sporadic or caused by this pat=
ch set.
> > > > > >
> > > > > > I tried reproducing it locally multiple times and it didn't fai=
l. It
> > > > > > also doesn't fail on manual CI run:
> > > > > > https://github.com/kernel-patches/bpf/actions/runs/20442781110/=
job/58740000164?pr=3D10475
> > > > > >
> > > > > > I assume it is sporadic.
> > > > >
> > > > > Ok. Applied. Let's watch for this. If it's actually flaky
> > > > > we need to fix it.
> > > >
> > > > I have found out why it fails sometimes:
> > > >
> > > > arena_alloc_pages() -> bpf_map_alloc_pages(1024) ->
> > > > alloc_pages_nolock(1) this is called in a loop and fails sometimes,
> > > > from my debug prints:
> > > >
> > > > __bpf_alloc_page: alloc_pages_nolock failed for nid=3D-1
> > > > bpf_map_alloc_pages: allocation failed at page 435/1024, freeing 43=
5
> > > > already allocated pages
> > > > bpf_map_alloc_pages: returning ret=3D-12, allocated 435/1024 pages
> > > > fail: bpf_map_alloc_pages failed with ret=3D-12 for 1024 pages
> > > >
> > > >
> > > > The VM runs with 4G of memory, when I changed this to 8G, this stop=
ped failing.
> > >
> > > That doesn't quite make sense.
> > > The test allocates 2051 pages, that's just 8 Mbyte. Nowhere
> > > close to a Gbyte. So 4Gb should be plenty.
> > > Number of cpus shouldn't matter either.
> > >
> > > > So, I think we can do the same for the CI.
> > > > The CI currently runs through vmtest which runs a VM with 4G of mem=
ory
> > > > an 2 CPUs by default:
> > > >
> > > > I checked the logs of the CI and saw:
> > > >
> > > > [ 0.626933] smp: Brought up 1 node, 2 CPUs
> > > > [ 0.628387] smpboot: Total of 2 processors activated (12029.10 Bogo=
MIPS)
> > > > [...]
> > > > [ 0.629145] Memory: 3388084K/4193784K available
> > > >
> > > >
> > > > I think we should change the CI to run vmtest with 8 CPUs and 16G o=
f memory.
> > > >
> > > > Here is a PR for this change: https://github.com/libbpf/ci/pull/206
> > >
> > > I don't think we should bump it without full understanding.
> > > It's better to make selftest recover on page alloc failure.
> >
> >
> > Okay, I will debug deeper to find out exactly where it fails in
> > alloc_pages_nolock().
> > For now do we want to allow the CI to fail or I can send a patch with f=
ollowing:
> >
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > @@ -300,7 +300,7 @@ int big_alloc3(void *ctx)
> >          */
> >         pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NOD=
E, 0);
> >         if (!pages)
> > -               return -1;
> > +               return 0;
> >
> >         bpf_for(i, 0, 2051)
> >                         pages[i * PAGE_SIZE] =3D 123;
> >
> > This will make this test unconditionally pass.
>
> Pls make it skip on failure instead of pass.


Extracted more information using some debug prints (AI Generated):


[   29.946603]   [mm/page_alloc.c:3386] PCP list[0] empty
[   29.946642]     Zone: DMA
[   29.946649]     CPU: 1
[   29.946655]     Migratetype: 0
[   29.946662]     Order: 0
[   29.946668]     Total PCP count: 491 (all migratetypes)
[   29.946681]     PCP high: 46754
[   29.946689]   [mm/page_alloc.c:3214] spin_trylock_irqsave(&zone->lock) F=
AILED
[   29.946706]     Zone: DMA
[   29.946713]     CPU: 1
[   29.946719]     Retry attempts: 3
[   29.946727]     Cycles spent: 384
[   29.946734]     Zone free pages: 221198
[   29.946743]     Zone watermarks: min=3D9903 low=3D12378 high=3D14853
[   29.946757]     Zone managed pages: 751344
[   29.946767]   [mm/page_alloc.c:3977] rmqueue() returned NULL for zone DM=
A
[   29.946783]   [mm/page_alloc.c:4010] get_page_from_freelist() failed
[   29.946797]     Zones attempted: 1
[   29.946805]     skip_kswapd_nodes: 0
[   29.946814]     skipped_kswapd_nodes: 0
[   29.946823] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.946838] alloc_pages_nolock() FAILED
[   29.946847]   Order: 0
[   29.946852]   Node: 0
[   29.946858]   Context: preempt_count=3D514 irqs_disabled=3D1 in_interrup=
t=3D512
[   29.946874]   Architecture: ARM64
[   29.946881]   Page size: 4096 bytes
[   29.946889] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.946905] bpf_map_alloc_pages() failed: page 670/1024 (nid=3D-1)


The failure occurs when allocating 1024 pages one-by-one in softirq
context on ARM64:

  1. PCP Exhaustion (mm/page_alloc.c:3386): After ~670 pages, the PCP
list for migratetype 0 (MIGRATE_UNMOVABLE) becomes empty, despite 491
pages remaining in other
  migratetype lists
  2. Zone Lock Contention (mm/page_alloc.c:3214): Fallback to buddy
allocator requires zone->lock, but spin_trylock_irqsave() fails after
3 attempts (384 cycles), even
  though 221,198 free pages are available

