Return-Path: <bpf+bounces-77389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF6CDAFF4
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B7C309F68D
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897902459C5;
	Wed, 24 Dec 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp3Gub1T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66E1EB5FD
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536193; cv=none; b=uW5UlcIdHu18PtocsTOcfDcpFXGfdnSdpmdXuGwac5pYW+W3GCIwk7heM1KcGC/VkEDuIqOHr2hIavNqx4ICcTnfmHbFTQasA3NTG0Vr6dGMOT2H6paTzVEJpMbKLXQK4uIRWiENJjWI3pHWrbVOCKhD/pItPIbcsjoHFAcCJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536193; c=relaxed/simple;
	bh=sdIOe3Fn1USTHtfD/qU3HNwMXjdFiuKjwhqU8MiRVMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8whjljvK/1o2RAv/7Uza5/AwzUCXMcDGy+O/NOYyrwMonG6xAzeoreT5JaZzlkehwikJ3j5r4l2EXTg6F4/FE8w9tbzoQ18/IkrgkoZARPWj5hbMaJraq95Rpgf4VVE8L1jVi14oUoaZexYJbEjupRiLaJgTl8kp3vdILKd1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp3Gub1T; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d52c24dso2326519f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 16:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536189; x=1767140989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwTCYw9YodlrIa/YDR6+oDu5iQv43PM73QJ5hYb4D9M=;
        b=fp3Gub1TVyYvAqY6etkB15KJbVuRO92fepS62nUj6wZbnJ9040PxybehlD23RwDeO4
         hLnz3Ki27aXbJYPL3g+SBJ1i/m3tM6/RXLtPPXI/C/g2NHP0pD/p+PoSGSYx37Vj7TUG
         5MVJcXU3F6nrRkqvSANJdP0b4jnDE4drGFxb07vPZW4GUC6QJL1ATDsAptkVpA8+Cvsh
         Evwsz/XzC1hvekRrcLGIq9wKCDSYEXBvpMwvTtI4eR1rKX+Ru9SSMashKAN4DM9tYkrF
         rWdEmCI8uCMGX+mWQ2Nbcbv9WFXWa6Jqo7BmSBEJYHSg3DA6NxF++Q58UF1BKhWxF2EU
         IYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536190; x=1767140990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwTCYw9YodlrIa/YDR6+oDu5iQv43PM73QJ5hYb4D9M=;
        b=XJ4Gg1JmwNp60eVSeM0lg0VnxW7SYskGUK5ocJLC88fYemBt7vIaJ1ANEzmVkua0Yg
         suJYYfPgEHb1L3/BEMZ0dFO0Wol8OIgJWA86jybiJWn9cGdiXZNr5N5Aw7VI+r+ji7Uq
         2HsQRIM1cnfxrsSn9gqcRkr/NUhnXPfuYf2nAEG5FTrFWjM9NezdhfCrWc0LXLZ7m2jN
         ui/gqFWyhp/mi9OPxeyx3ADRCtsGulYgjo+cdfiZQRfzBG8qQAkoJetPmpdLAdkCTlCl
         Fh2eeaqKtXuvHPrb9XPSa5m4J8LU0V6Ga2x9572QonIyFKm7o9ez2YWsqwuA7Hxq6OuE
         s6iA==
X-Gm-Message-State: AOJu0YytK7W1BEhB1kTnXQUSUuokQ23OtUxFCb271RFUifDDxkxsrR7U
	52R93txdl67grP2Ib8NvhKG8ULh8J7xzNL1pQl+KQrt0LL3vSW4xf+O5Mwzus1JtGlc1FdoBXQU
	vaK1RZDMSx4hesI2nEvO5lIxxFUBQ6rA=
X-Gm-Gg: AY/fxX6XTbuxypbYPqaMfY37PSxmHFeaZ3pLOsb8v2ZG0YPTiZ4mDwslxkhMjfn+1cD
	y8NhCh86b+62uJGf1yjXuGoi5Vmd8p8qllYusdXR4bO+JgH7+rnJfz535zur6Z4Ns15Cj+2TtDD
	tbi5ZVtlM/ucmUBX/MlNZMV3CfNwTT3r3orER8ZnX+SJ6nP/PUu40ekPI6DD8QUljtHBfqwZHWj
	1mL0mOk7IOYARP/NRPGYwtoTXIoXCHEhwFDOZad5gk58wcuxy083Y1urUmjs9xGCkBoxn0j
X-Google-Smtp-Source: AGHT+IHOUmlmf3kgnts16VeCH5o5V6aMn7GyHeRbAIMvG3bRyyKmsApqLXYNmP8LGWCS8GOqVw2RR0F/0X1qhj3xyrg=
X-Received: by 2002:a05:6000:22c3:b0:430:f7dc:7e8e with SMTP id
 ffacd0b85a97d-4324e4f6916mr14960113f8f.34.1766536189353; Tue, 23 Dec 2025
 16:29:49 -0800 (PST)
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
 <CAADnVQLzKsogyKoo_aiY4nx96YS1MrAfU5kAMBvmuTsrxaESnA@mail.gmail.com> <CANk7y0jqPRE1u5uEPRCtsOT46uUUnjyQik3XWrMcSrq3bfgPFQ@mail.gmail.com>
In-Reply-To: <CANk7y0jqPRE1u5uEPRCtsOT46uUUnjyQik3XWrMcSrq3bfgPFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 14:29:38 -1000
X-Gm-Features: AQt7F2pGPnWjs7ikM73DCniFp7OwcqT9dRnI9-of4YNBQedIgAAX-JLPIb1s1pw
Message-ID: <CAADnVQ+rXZKutzsUJGD7mSFAUFhyKeG73Oiw6TkgPMfFGVqong@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 2:28=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Dec 24, 2025 at 12:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 23, 2025 at 1:13=E2=80=AFPM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 7:36=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay12@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranja=
y@kernel.org> wrote:
> > > > > > >
> > > > > > >  int reserve_invalid_region(void *ctx)
> > > > > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena=
_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > > > > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.=
c
> > > > > > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.=
c
> > > > > > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > > > > > >                 return 9;
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > > +
> > > > > > > +SEC("socket")
> > > > > > > +__success __retval(0)
> > > > > > > +int big_alloc3(void *ctx)
> > > > > > > +{
> > > > > > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > > > > > +       char __arena *pages;
> > > > > > > +       u64 i;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Allocate 2051 pages in one go to check how kmalloc=
_nolock() handles large requests.
> > > > > > > +        * Since kmalloc_nolock() can allocate up to 1024 str=
uct page * at a time, this call should
> > > > > > > +        * result in three batches: two batches of 1024 pages=
 each, followed by a final batch of 3
> > > > > > > +        * pages.
> > > > > > > +        */
> > > > > > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, N=
UMA_NO_NODE, 0);
> > > > > > > +       if (!pages)
> > > > > > > +               return -1;
> > > > > > > +
> > > > > > > +       bpf_for(i, 0, 2051)
> > > > > > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > > > > > +       bpf_for(i, 0, 2051)
> > > > > > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > > > > > +                               return i;
> > > > > > > +
> > > > > > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > > > > > +#endif
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > >
> > > > > > CI says that it's failing on arm64.
> > > > > > Error: #511/6 verifier_arena_large/big_alloc3
> > > > > > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> > > > > >
> > > > > > cannot quite tell whether it's sporadic or caused by this patch=
 set.
> > > > >
> > > > > I tried reproducing it locally multiple times and it didn't fail.=
 It
> > > > > also doesn't fail on manual CI run:
> > > > > https://github.com/kernel-patches/bpf/actions/runs/20442781110/jo=
b/58740000164?pr=3D10475
> > > > >
> > > > > I assume it is sporadic.
> > > >
> > > > Ok. Applied. Let's watch for this. If it's actually flaky
> > > > we need to fix it.
> > >
> > > I have found out why it fails sometimes:
> > >
> > > arena_alloc_pages() -> bpf_map_alloc_pages(1024) ->
> > > alloc_pages_nolock(1) this is called in a loop and fails sometimes,
> > > from my debug prints:
> > >
> > > __bpf_alloc_page: alloc_pages_nolock failed for nid=3D-1
> > > bpf_map_alloc_pages: allocation failed at page 435/1024, freeing 435
> > > already allocated pages
> > > bpf_map_alloc_pages: returning ret=3D-12, allocated 435/1024 pages
> > > fail: bpf_map_alloc_pages failed with ret=3D-12 for 1024 pages
> > >
> > >
> > > The VM runs with 4G of memory, when I changed this to 8G, this stoppe=
d failing.
> >
> > That doesn't quite make sense.
> > The test allocates 2051 pages, that's just 8 Mbyte. Nowhere
> > close to a Gbyte. So 4Gb should be plenty.
> > Number of cpus shouldn't matter either.
> >
> > > So, I think we can do the same for the CI.
> > > The CI currently runs through vmtest which runs a VM with 4G of memor=
y
> > > an 2 CPUs by default:
> > >
> > > I checked the logs of the CI and saw:
> > >
> > > [ 0.626933] smp: Brought up 1 node, 2 CPUs
> > > [ 0.628387] smpboot: Total of 2 processors activated (12029.10 BogoMI=
PS)
> > > [...]
> > > [ 0.629145] Memory: 3388084K/4193784K available
> > >
> > >
> > > I think we should change the CI to run vmtest with 8 CPUs and 16G of =
memory.
> > >
> > > Here is a PR for this change: https://github.com/libbpf/ci/pull/206
> >
> > I don't think we should bump it without full understanding.
> > It's better to make selftest recover on page alloc failure.
>
>
> Okay, I will debug deeper to find out exactly where it fails in
> alloc_pages_nolock().
> For now do we want to allow the CI to fail or I can send a patch with fol=
lowing:
>
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -300,7 +300,7 @@ int big_alloc3(void *ctx)
>          */
>         pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE,=
 0);
>         if (!pages)
> -               return -1;
> +               return 0;
>
>         bpf_for(i, 0, 2051)
>                         pages[i * PAGE_SIZE] =3D 123;
>
> This will make this test unconditionally pass.

Pls make it skip on failure instead of pass.

