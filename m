Return-Path: <bpf+bounces-73683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A0C37450
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 19:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE401A21253
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E927280B;
	Wed,  5 Nov 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clAkR1/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800532701C4
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366824; cv=none; b=IcoCpo8fYP4IyBFSSLifnDkvzI5z0ZUYDdj3HC4mbZ1Fs4RDAig5BfJA8n8ZBVfhxGvSBQUdCr54drEdL0mdJ0wQTpYqM2w1L8VY2/Y5hLo4dYatYdcnOyWtxhM03teufKbkLIGIMOMjCt1U11VX2OiaALRU51nJzwfnh8ATc+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366824; c=relaxed/simple;
	bh=xyznBg8bPCkAbSVervFyuPrEom/+I/KelDwTFZFNcoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyNgKebR66epyGCwu8feJ7cW4StsMo58hcb33TNxhYpLESjxzC0+fipwYtdICDNZm1HGk+8UQbxXcNFN6ZCjR6zv/MVTs8x4OpaVgGwPY2IDy9YZ0XpcVD9KOkoXlZ5WcUD4rJDt4pJMkjbCoglJnGTlG83EB83lBxvdGCebgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clAkR1/E; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so166818a91.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762366821; x=1762971621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRNEtJ8HSzNu73MI7MXlf4Rp8v1VK9mI/rxZ4K0ZODI=;
        b=clAkR1/EGtAVXoSs1L44ez/QwDeek84tf9eCq/2qIis2c/qtrpbV04/GtzhLwt3SEm
         R4jklpdObxObou/mzgKPSOhPBWUBdoGWsU1+nbXGyGjRrz//HKmSFtkFhHa/wxeKpM2a
         pGBYp6oNTeajE6CEfx94r9PERLyYmxp0DFna1lRKiAdjG3RmrAQfqgHRCSfqzdKu9N/j
         fLzPmvfg9/FgzIpRlwWDt4hYtI0l60upbN52mK60aSTu2xdrPm6gL7AdSG6MaxlHwbYF
         7gPOsig8ujz1VnI0ysEhmX4tpISypQw9KTnzqOqbJ5nKgd4kEeOe2+m0rqMjRbW+JMtG
         KDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366821; x=1762971621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRNEtJ8HSzNu73MI7MXlf4Rp8v1VK9mI/rxZ4K0ZODI=;
        b=iinclvQIw2vwctEzvlosKYeT2H5PrLlzvhQCnU6G/TxchEMnSZyPnqxqaCvK3s+9nk
         n/Hn9R5qXzudGRNTrZNe8s+zdVkoOx/awOCpBXdImI8Dc3vkhknSnaN4CiEkocJleo2r
         O0uMidlD6tD6twgW7yUBjZiq/yrsr8kScKR1ZFZuxRR9smAbhXkbkmp8NM6/CtejLcBy
         WS70c+JWi28RVXzwBt7ErvRTDMbs4lRbesWSJNzy+Yy7jWJGln/UuJQqnefKecqv7O+6
         NYfAb81NmYWheWxxBUc7N0PPKZoxr2Dc1FzJpG0LxGjzM9sKTYVl82JxwlPXUgwOnzr8
         GE5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9uVIGjxiPVyQ7M6jq8CZys6rDApiQa1obVFX03XShtrEf7bOId67Q/+Gz1+zDDrmfHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7AcRAOjaZ26QexgdokIGKXMHmAgpZFgg3CTHjrZ0uysmBvY/
	eikmGFdKJM4TUCMpOu+GA3KzG/wokfiW3aGc8oaqWe2uT7uWCaCsShbjrjwmdkGRxTrO/64kZHy
	YDH7Rka9ULiVF+DPgMiWRD7pTf6gOHlg=
X-Gm-Gg: ASbGncu2Tn2ZOH0TL3x4DXPkvyfrn5QkQazmnGtJJluJr+3G9GVOmhM9xCuIUZzTFic
	2UZe3QOLaHQ1vMuW6Ivrebi+owa1U4xNSNpFmScA7Im4dfsAswv6lInIE8EE5JRX9GVagbaSi9B
	xiEfEWf8AXRfRBMCaJaCwHFrZOW9eq2+4RguHPuvi+yr5Phs75WqygIXnnxebB1h+Q9HyApWTmG
	SJmBTVMrbFr0DTfbGMPYU9dm5FaFv7F0TtWo/O1R26Lm/xuIuk6FekNnuCNnwFXmoEN4Lc=
X-Google-Smtp-Source: AGHT+IGus8TJU8QkKB5Se4uQPYLLb+yyzFNRAIPH/6IHHSouV82Pu17ktViR3Jp0IP6UsdzEFCXVYhUfHgJPGH90eiE=
X-Received: by 2002:a17:90a:d406:b0:340:b572:3b7f with SMTP id
 98e67ed59e1d1-341a6dcb832mr5547227a91.20.1762366820810; Wed, 05 Nov 2025
 10:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-2-dolinux.peng@gmail.com> <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
 <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
 <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com> <61f94d36d6777b9b84e9bf865edd17476a278e73.camel@gmail.com>
In-Reply-To: <61f94d36d6777b9b84e9bf865edd17476a278e73.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 10:20:08 -0800
X-Gm-Features: AWmQ_blkJQviRlhU2we_k_QwrAfW2pz3y165tNeAghpP-pTEgRNfpEg02PZWoIs
Message-ID: <CAEf4BzZffw1sTJUBxwUnhx8XjQNMRf2-e+vUzOfyMqgMTpYsdA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic into
 helper function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:57 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 4, 2025 at 4:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext=
 *btf_ext, enum btf_endianness endian)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_=
ext,
> > > > > +                          btf_remap_type_fn visit, void *ctx)
> > > >
> > > > tbh, my goal is to reduce the amount of callback usage within libbp=
f,
> > > > not add more of it...
> > > >
> > > > I don't like this refactoring. We should convert
> > > > btf_ext_visit_type_ids() into iterators, have btf_field_iter_init +
> > > > btf_field_iter_next usable in for_each() form, and not try to reuse=
 5
> > > > lines of code. See my comments in the next patch.
> > >
> > > Remapping types is a concept.
> > > I hate duplicating code for concepts.
> > > Similarly, having patch #3 =3D=3D patch #5 and patch #4 =3D=3D patch =
#6 is
> > > plain ugly. Just waiting for a bug because we changed the one but
> > > forgot to change another in a year or two.
> >
> > Tricky and evolving part (iterating all type ID fields) is abstracted
> > behind the iterator (and we should do the same for btf_ext). Iterating
> > types is not something tricky or requiring constant maintenance.
> >
> > Same for binary search, I don't see why we'd need to adjust it. So no,
> > I don't want to share code between kernel and libbpf just to reuse
> > binary search implementation, sorry.
>
> <rant>
>
> Sure binary search is trivial, but did you count how many times you
> asked people to re-implement binary search as in [1]?

Exact match binary search can be called trivial, yes. Lower/upper
bound binary search looks deceivingly simple, but it requires
attention to every single line of code. But the end result is simple
and straightforward, yes.

I'm not sure what point you are trying to make, though. Yes, I've
asked people many times to implement upper/lower bound binary search
similarly to the one in find_linfo(), because usually people have
various unnecessary checks, keeping track not just of bounds, but also
remembering some element that we know satisfied the condition at some
point before, etc. It's not elegant, harder to reason about, and can
be done more succinctly.

You don't like that I ask people to improve implementation? You don't
like the implementation itself? Or are you suggesting that we should
add a "generic" C implementation of lower_bound/upper_bound and use
callbacks for comparison logic? What are you ranting about, exactly?

As I said, once binary search (of whatever kind, bounds or exact) is
written for something like this, it doesn't have to ever be modified.
I don't see this as a maintainability hurdle at all. But sharing code
between libbpf and kernel is something to be avoided. Look at #ifdef
__KERNEL__ sections of relo_core.c as one reason why.

>
> [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/kernel/bpf/verifier=
.c#L2952
>
> </rant>

