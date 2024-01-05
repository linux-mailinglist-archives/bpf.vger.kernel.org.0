Return-Path: <bpf+bounces-19095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B668824C55
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EF41F2340E
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602DA1C02;
	Fri,  5 Jan 2024 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1OkHQ5q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09B1854
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so13323201fa.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 17:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704416731; x=1705021531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmS5/R456qIKMtn+yUDU5rBlBvbAGXegaQyotziEQEM=;
        b=K1OkHQ5qN6iOpZoJN9NTIVvDxQZlB8yaD14fLMKALM7I+ROmLHIoT7BWH8y+dMiH2K
         zh4di5gCyNFPuJCr83y1vxF8aFVuF49O+D17sWwrMiQUXWLnBHCW0UoImDaLueS/yaEG
         GH9XI1N4QVEcJ38jfsjwTx5oG73BFGZ0rbdjZjXi4tRWonP7DuNCOICzbpMKbUS2ob/p
         re03OMHDOIBkKd4gglwDWv7JSYcLoibrvoUUfY1cYg4OBLK07Oi1sE/UO8gzCaUAY7D1
         PNCL7cB5FJ1tS5WN2O1ygobVdQ75zFTVYKIm6OfeCbMvy5esEA4wx3GSKeI5lFui1+Ud
         TtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704416731; x=1705021531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmS5/R456qIKMtn+yUDU5rBlBvbAGXegaQyotziEQEM=;
        b=pdv4LzxLIUbXSmu+Nj9PgQSxDFUovMDrkQ19vks5zhs5z02y5PheNoeh+nL7uTlJ5G
         yKHlxvXMhyVThglq7h6W/M4M92zFULdCG5IpoAYXsGdu1qaTNg+EC5xygVC87IxgqBR4
         ishu7vB7zm5KfhNLRjauKzfTA9jEnSgQQ7A2P/o918FVNoAWZHnUoxp3pSW3qBuMF1p2
         ARzewPRVekg9q3eo0P9Q4Ym4NuniNyi+3SbUZLGd8nboXYL1m4MBTzsf5UX9kT8EG8V/
         jZxYiCC0MVv3uxhL00snngkuEzWg8EMcJU6kiv1AJncLlOajyhtv4D4WbqTJ5/gc/BN5
         E0NA==
X-Gm-Message-State: AOJu0YxUM1YRp0742AtV/7bMv75v+5VKnaD2yLRB83U85SCNelkHf7OL
	UxB1zIyMJ17Wvl9h4KcTWp77FtzPaBVODsE4eSo=
X-Google-Smtp-Source: AGHT+IHCSy5G97/8HRsM8QGbXGalKvbgsaSnD0okjrXGQTn5Nm0j04r/2SgTnXp8TUKpz1jw696u6jh0M4RUfAvd7l0=
X-Received: by 2002:a2e:b1c8:0:b0:2cc:5caa:ee95 with SMTP id
 e8-20020a2eb1c8000000b002cc5caaee95mr362834lja.143.1704416731054; Thu, 04 Jan
 2024 17:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev> <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com> <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
In-Reply-To: <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 17:05:18 -0800
Message-ID: <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-01-04 at 15:09 -0800, Andrii Nakryiko wrote:
> [...]
> > > This seemed logical at the time of discussion, however, I can't figur=
e
> > > a counter example at the moment. It appears that whatever are
> > > assumptions in check_stack_write_var_off() if spill is used in the
> > > precise context it would be marked eventually.
> > > E.g. the following is correctly rejected:
> > >
> > > SEC("raw_tp")
> > > __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
> > > __failure
> > > __naked void var_stack_1(void)
> > > {
> > >         asm volatile (
> > >                 "call %[bpf_get_prandom_u32];"
> > >                 "r9 =3D 100500;"
> > >                 "if r0 > 42 goto +1;"
> > >                 "r9 =3D 0;"
> > >                 "*(u64 *)(r10 - 16) =3D r9;"
> > >                 "call %[bpf_get_prandom_u32];"
> > >                 "r0 &=3D 0xf;"
> > >                 "r1 =3D -1;"
> > >                 "r1 -=3D r0;"
> > >                 "r2 =3D r10;"
> > >                 "r2 +=3D r1;"
> > >                 "r0 =3D 0;"
> > >                 "*(u8 *)(r2 + 0) =3D r0;"
> > >                 "r1 =3D %[two_byte_buf];"
> > >                 "r2 =3D *(u32 *)(r10 -16);"
> > >                 "r1 +=3D r2;"
> > >                 "*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine =
*/
> > >                 "exit;"
> > >         :
> > >         : __imm_ptr(two_byte_buf),
> > >           __imm(bpf_get_prandom_u32)
> > >         : __clobber_common);
> > > }
> > >
> > > So now I'm not sure :(
> > > Sorry for too much noise.
> >
> >
> > hm... does that test have to do so many things and do all these u64 vs
> > u32 vs u8 conversions?
>
> The test is actually quite minimal, the longest part is conjuring of
> varying offset pointer in r2, here it is with additional comments:
>
>     /* Write 0 or 100500 to fp-16, 0 is on the first verification pass */
>     "call %[bpf_get_prandom_u32];"
>     "r9 =3D 100500;"
>     "if r0 > 42 goto +1;"
>     "r9 =3D 0;"
>     "*(u64 *)(r10 - 16) =3D r9;"
>     /* prepare a variable length access */
>     "call %[bpf_get_prandom_u32];"
>     "r0 &=3D 0xf;" /* r0 range is [0; 15] */
>     "r1 =3D -1;"
>     "r1 -=3D r0;"  /* r1 range is [-16; -1] */
>     "r2 =3D r10;"
>     "r2 +=3D r1;"  /* r2 range is [fp-16; fp-1] */
>     /* do a variable length write of constant 0 */
>     "r0 =3D 0;"
>     "*(u8 *)(r2 + 0) =3D r0;"

I meant this u8

>     /* use fp-16 to access an array of length 2 */
>     "r1 =3D %[two_byte_buf];"
>     "r2 =3D *(u32 *)(r10 -16);"

and this u32. I'm not saying it's anything wrong, but it's simpler to
deal with u64 consistently. There is nothing wrong with the test per
se, I'm just saying we should try eliminate unnecessary cross-plays
with narrowing/widening stores/loads.

But that's offtopic, sorry.

>     "r1 +=3D r2;"
>     "*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine */
>     "exit;"
>
> > Can we try a simple test were we spill u64
> > SCALAR (imprecise) zero register to fp-8 or fp-16, and then use those
> > fp-8|fp-16 slot as an index into an array in precise context. Then
> > have a separate delayed branch that will write non-zero to fp-8|fp-16.
> > States shouldn't converge and this should be rejected.
>
> That is what test above does but it also includes varying offset access.
>

Yes, and the test fails, but if you read the log, you'll see that fp-8
is never marked precise, but it should. So we need more elaborate test
that would somehow exploit fp-8 imprecision.

I ran out of time. But what I tried was replacing


"r2 =3D *(u32 *)(r10 -16);"

with

"r2 =3D *(u8 *)(r2 +0);"

So keep both read and write as variable offset. And we are saved by
some missing logic in read_var_off that would set r2 as known zero
(because it should be for the branch where both fp-8 and fp-16 are
zero). But that fails in the branch that should succeed, and if that
branch actually succeeds, I suspect the branch where we initialize
with non-zero r9 will erroneously succeed.

Anyways, I still claim that we are mishandling a precision of spilled
register when doing zero var_off writes.



> [...]

