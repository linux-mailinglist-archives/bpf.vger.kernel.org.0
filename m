Return-Path: <bpf+bounces-77386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B7CDAD07
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BF7F301DCEB
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624430BF6B;
	Tue, 23 Dec 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwrh+1Fy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78D2F1FD5
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531602; cv=none; b=f7SKyds55YAYwSRZZ1eRn1hhFbzP4bbOWP5FVbpHEG3Q/ofBzKEV7cCp7aK4HW+F0fKlXGWekAg87/+DIl0C0+zE3oR9rvfM6Cnx4nD1wgLxhUOJNKGVQrEGPjHesGfNFXGMl7Zz4B+Q4Z58lwBfFbXkl3pFcFgLeMNmCdfY/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531602; c=relaxed/simple;
	bh=XRsqzRUSayQ6QNRFHJg1iup0r52rpN+MS9e8t37mOgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMsGaL1zZkUGzZ1PaI1u28xx7TWI6fGuctntgknWKEun/xuaQhvjO+rGM91ym23LbbEhP8/P3vnndaMpvmTpUao0Rxn/lihpz1JeBJcaSPpqtGDTamAuZj7AtTgy98KArjmXSlEcvbB93tUYz7q3Hd9xtUWSWPepH+L3pRs5ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwrh+1Fy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so880212466b.3
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531598; x=1767136398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D79QJ5YkpgLONv9dqaEHL9msIDE+5c0lsVfxCfpZ7Q8=;
        b=dwrh+1Fy3YVqgI4S6EdlhquYlI5RfNKbyQZIBqOXhjy0xBL5qxKC+vB4SNaxDcL0aJ
         FSkS7HzOXIzv5AIJ1TDQeVa6R1VYj8LTNFBQUJDvqlfd+KKldFwblAi1G+Xc03LSAgfu
         egT7XlAh9xmMzYlVFowyCebuIR6/DrTyWvkm5yxG/veL46yfQMsvilLqEzp4vz6BLHEY
         PriVaC7waQU4KjJusV5JJwWQ89TM+UwUW0J5VN8UHCylSRtGmMpt3jDytmswsA2T+FRg
         hSRjdSGNPyEq8OaItLydjZHGOxaXPtwRX5kKQKpZPXubKQo2yHXGLSifTbSjTvTPLzvl
         npUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531598; x=1767136398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D79QJ5YkpgLONv9dqaEHL9msIDE+5c0lsVfxCfpZ7Q8=;
        b=VNqi2T5Jsg+NLH207fgVy8EhxdR54rygWS0J3xpm2ICqsqfViQWr/9XezXjsyqQKfU
         cIglejhers4OEwpNHlV9CvyR66IMYfzUv2xeYyKfq3g1gJUdVc/7kUsXezFvieBjPgCD
         uc9cM+ZixfR/MFdRlZfYnAce9t5N2BBuCcZ3ouUENXZuovZjdo2qCjkVnPYk8ixElBo4
         lt8jLGoCNiS5A9U3HA8iVfhAKyRLuvQuTY6nCZXy8vjeMqdEuxCR/XrayUSbbUM+AEfP
         n7dNM1Dfs1jb7PdRu5tTN2RAvKqzRHmDzzxgRzw+PQ3f64T+7n/Hx+Z2/qJQyp1e0YFz
         5HfQ==
X-Gm-Message-State: AOJu0Yz2MaElXOgMLsyXRhNJL0v3IvSPMAN/5fC+sFGZCjktasTiBRAO
	0bb5yIA7nqiFNubgDG6BccNsYNrS++q9zQ1SxzdErIGKkeQIlV3hMeJHkOQPiBkd3sJ+YStl0Wi
	1jeoCdolErFdR2t8BUkLs+HdktcTyEO0=
X-Gm-Gg: AY/fxX47fnHMjWJWvdZMdY1VUNWHc7O8fgrq6iiEJmHk38rYTUun4FNrghcF/SnZCWj
	4DALmj6CIEZb0YdlyZYGm6MlEq0gbDlYRg4lVIdLHSNcfvsO1mcyMDZZSj/ReFkdzka0O5Er3GW
	wOXJGYdieeOL2REbbndNsfsg5vlzU7kpy/jhHE9ik6HVf+B10z2SW2wU2TM6X7slfnsBiXYpRH5
	QGgGnd30Phr2dGLXF94eWRhZOCg6E9AJPqz16BqyDtMqwFpUz8NcZrcbuq+srPi1KhqxZAxOotV
	4kqvsInz3xQ=
X-Google-Smtp-Source: AGHT+IGeSMbgbN+GW119gFo0/RShxZv17bG+g8Z6+aOs2Tgwl5SjXt5O1XDXZLJLEIVwkNVogLbNeojZbBdC8JPurmM=
X-Received: by 2002:a17:906:f592:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b8036ecfe47mr1590963066b.3.1766531598065; Tue, 23 Dec 2025
 15:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
 <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com> <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com>
In-Reply-To: <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 23 Dec 2025 23:13:04 +0000
X-Gm-Features: AQt7F2pS87s34dRtubOI7jvKiupw4SJHp9jt36w7-zPf7Y-bVyaue-X83Dwntr4
Message-ID: <CANk7y0hCBWW+z2Z_c8p9Wb8-nXRp_1HJHSLLCDpxcUQz4qM_tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 7:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> > > >
> > > >  int reserve_invalid_region(void *ctx)
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large=
.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > > >                 return 9;
> > > >         return 0;
> > > >  }
> > > > +
> > > > +SEC("socket")
> > > > +__success __retval(0)
> > > > +int big_alloc3(void *ctx)
> > > > +{
> > > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > > +       char __arena *pages;
> > > > +       u64 i;
> > > > +
> > > > +       /*
> > > > +        * Allocate 2051 pages in one go to check how kmalloc_noloc=
k() handles large requests.
> > > > +        * Since kmalloc_nolock() can allocate up to 1024 struct pa=
ge * at a time, this call should
> > > > +        * result in three batches: two batches of 1024 pages each,=
 followed by a final batch of 3
> > > > +        * pages.
> > > > +        */
> > > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO=
_NODE, 0);
> > > > +       if (!pages)
> > > > +               return -1;
> > > > +
> > > > +       bpf_for(i, 0, 2051)
> > > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > > +       bpf_for(i, 0, 2051)
> > > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > > +                               return i;
> > > > +
> > > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > > +#endif
> > > > +       return 0;
> > > > +}
> > >
> > > CI says that it's failing on arm64.
> > > Error: #511/6 verifier_arena_large/big_alloc3
> > > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> > >
> > > cannot quite tell whether it's sporadic or caused by this patch set.
> >
> > I tried reproducing it locally multiple times and it didn't fail. It
> > also doesn't fail on manual CI run:
> > https://github.com/kernel-patches/bpf/actions/runs/20442781110/job/5874=
0000164?pr=3D10475
> >
> > I assume it is sporadic.
>
> Ok. Applied. Let's watch for this. If it's actually flaky
> we need to fix it.

I have found out why it fails sometimes:

arena_alloc_pages() -> bpf_map_alloc_pages(1024) ->
alloc_pages_nolock(1) this is called in a loop and fails sometimes,
from my debug prints:

__bpf_alloc_page: alloc_pages_nolock failed for nid=3D-1
bpf_map_alloc_pages: allocation failed at page 435/1024, freeing 435
already allocated pages
bpf_map_alloc_pages: returning ret=3D-12, allocated 435/1024 pages
fail: bpf_map_alloc_pages failed with ret=3D-12 for 1024 pages


The VM runs with 4G of memory, when I changed this to 8G, this stopped fail=
ing.
So, I think we can do the same for the CI.
The CI currently runs through vmtest which runs a VM with 4G of memory
an 2 CPUs by default:

I checked the logs of the CI and saw:

[ 0.626933] smp: Brought up 1 node, 2 CPUs
[ 0.628387] smpboot: Total of 2 processors activated (12029.10 BogoMIPS)
[...]
[ 0.629145] Memory: 3388084K/4193784K available


I think we should change the CI to run vmtest with 8 CPUs and 16G of memory=
.

Here is a PR for this change: https://github.com/libbpf/ci/pull/206

