Return-Path: <bpf+bounces-31545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE428FF79B
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 00:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153D61F25135
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9C13C67B;
	Thu,  6 Jun 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdnSrTNG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5173444
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712363; cv=none; b=AdcemHyooiBRyUCJTFEt+q2ADpeQlu7MH7S2347ojt6gmqKxVmidg+cUFdMoeMsqUn0UWjivEdY+7RIHIOu29pZ6x5RX5gb+ZQy4AmawnvJ89wgDQWgvDIx0c1IajqynoeHHh8YsTBhBIuV2F71XRWGFSiMfZIMU3gf44rfwum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712363; c=relaxed/simple;
	bh=7LKKMsKoVo5L465xDGk4ASIxYM6YBZQ7UsIR4qdf04k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXef+rc2mjuc3WIJ1ObixL5nstdSoIAoBO4kzPoZ7kKxU5d7WQrhVGPsx/53s38wQaMIsW448kFADXlY+oltm/RcSLWNopsqGESror60f4bdxKVW7FGbOCaf9hC0ckoac6rVPbrZDR+rmbaNNX2HW6NK8bM/3z+jiIOIm644k+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdnSrTNG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-703ed15b273so1255369b3a.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717712362; x=1718317162; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ckEjD/KO+hVtQm09m+Esrf11SanNdOxOlMLDtAzgF8=;
        b=GdnSrTNGlGS89Rla8jIEA9ZDXdrHPOmFz5tA2CRH1vWddZ90yaBSDoA3Np7RDFCbVW
         MT7j1YIJzss3VT3pnhyHy20KLwgLlvEqoEIPurIQf6gcvT0ApyZvjAgEkM694ygfAIs3
         TqABTyou+M7wKJfD/0NJV0Pb1Vf3OAdg3qgRgDV1YUqj11ZydmClT/+V9pu3hrDwHcM2
         3UIdUjzJQs4OGJlFYYN3+3ZjhxmeeM0KlZ9NRxmWLqrs3rLhDe6OlQBhySGgLzm8IVS7
         BrnKKQmHFyURom44YdAD2t3ujoRdwS2u7rKwTa58PXq1mXOSxa1XvWoyiB9UWfklTXe+
         hQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712362; x=1718317162;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ckEjD/KO+hVtQm09m+Esrf11SanNdOxOlMLDtAzgF8=;
        b=jhRe3JWjt86YCKADIC+FkA/OpyxtSGVBtQiLuqS/eiweqJ2VntFNakW7L7bvjeK+3m
         NBXHVT9sskCuU+nDE/mEnmO+LpE0XbxgrOeznzyqAQ3jo5xbSiwprL2KRtxVLSYc43FD
         s0hwVHC8MqC/AWb+Un1UmgoWLMra4uodvLYMTpw52uniMhwJKPrWwaxBPOfZpGi15IDV
         3qg9xi39DJNUDM77UnoKUU1ZuXWHlCuW+i09jUy8oML59KS2tUl1hnxhz8VpkMqcPSoL
         T2U9lvZ7CAHvNSgZVauMc6gjwtqdCSyxNoztbPRgdQI5VjNnN04Z+NNiEuI7jRPj04Bk
         56sg==
X-Gm-Message-State: AOJu0YynVY0p3LBiAQSmslsTZCnf/LyGvPM61MARAl4su5PP1BPYCP+v
	lIlgKyb6QTmHqFNYl27NOu8lmb+SkXbJ6rRH44/hqMW/ILtc4IVv
X-Google-Smtp-Source: AGHT+IFl8Ef50D1kx5o5KzAmh31lO8VfN4dY1ho2keRa9f6UF2wsfwvSbGbLcubJdRCkby2m2NqZzQ==
X-Received: by 2002:a05:6a21:1507:b0:1b3:54bc:d45b with SMTP id adf61e73a8af0-1b354bcd52emr228148637.52.1717712361487;
        Thu, 06 Jun 2024 15:19:21 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd495168sm1534539b3a.104.2024.06.06.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:19:21 -0700 (PDT)
Message-ID: <098d570be9bb15fc804355851b4b99837f18c664.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Thu, 06 Jun 2024 15:19:16 -0700
In-Reply-To: <CAADnVQ+KFoNW-yJCa5fFmNzXjoEN4ECvPeQ1YoCeSZpyR9uO5Q@mail.gmail.com>
References: <20240606005425.38285-1-alexei.starovoitov@gmail.com>
	 <20240606005425.38285-2-alexei.starovoitov@gmail.com>
	 <6dbfd5e14ffbf9d828d63c5855f9bb783ac2506a.camel@gmail.com>
	 <CAADnVQ+KFoNW-yJCa5fFmNzXjoEN4ECvPeQ1YoCeSZpyR9uO5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 13:02 -0700, Alexei Starovoitov wrote:

[...]

> > > +             reg1->var_off =3D tnum_unknown;
> > > +             reg2->var_off =3D tnum_unknown;
> > > +             break;
> >=20
> > Just a random thought: suppose that one of the registers in question
> > is used as an index int the array of ints, and compiler increments it
> > using +=3D 4. Would it be interesting to preserve alignment info in the
> > var_off in such case? (in other words, preserve known trailing zeros).
>=20
> Well, the verifier cannot figure out which register is
> an induction variable. Compiler can generate a code where
> would be multiple such registers too.
> But even if it was one rX +=3D 4
> it's nor clear how to figure out the size of the increment.
>=20
> Also the above code is called at the time of comparison like "if 2 < 100"=
.
> I figured I will try a heuristic at that time.
> See attached diff.
> It computes alignment of LHS and RHS and
> then heuristically adjusts the range.
> After spending all morning on it and various heuristics
> I'm convinced that this is a dead end.
> It cannot be made to work with i +=3D 2 loops.

Summary of off-list discussion below.
For the following C code:

    long arr1[1024];

    SEC("socket")
    __success
    int test1(const void *ctx)
    {
        long i;
   =20
        for (i =3D 0; i < 1024 && can_loop; i++)
                arr1[i] =3D i;
        return 0;
    }
   =20
clang generates the following BPF code:

0000000000000340 <test1>:
     104:       r1 =3D 0x0
     105:       r2 =3D 0x0 ll

0000000000000358 <LBB28_1>:
     107:       may_goto +0x4 <LBB28_3>
     108:       *(u64 *)(r2 + 0x0) =3D r1
     109:       r2 +=3D 0x8
     110:       r1 +=3D 0x1
     111:       if r1 !=3D 0x400 goto -0x5 <LBB28_1>

0000000000000380 <LBB28_3>:
     112:       w0 =3D 0x0
     113:       exit

Here r2 is used as an index and r1 as a counter.
Since r2 is never compared it is never widened.
Hence my point about preserving trailing zeros
for widened values is moot, as it won't really
help for real-life programs.

