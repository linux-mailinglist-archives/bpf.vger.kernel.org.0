Return-Path: <bpf+bounces-48096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F0A040D3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE76C161E2A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F81F03D1;
	Tue,  7 Jan 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihpTXQNx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB71EF09E
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256569; cv=none; b=FiVUSMd29zxreE1JrOB78cbhJYPBW4GiLEvRntp+T2lMPUwNzjMSZEGxahCa64Kv1jcTOhq8bvF2NLhpNKuV1G5BtzvDhVtSQqHghyCmJT38sb/CACpslK1iX0bPKdZ81eFS+RGsesUeUL2nGdjA0Js5nkK2XWBXaCcVWQ3r+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256569; c=relaxed/simple;
	bh=BqXwTA1Pn4RiYCZwy26Q6d68hTGg82OSaX1jFNBJSds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC826wAkPyWo4nXMwKhXtM3IFicgDfMEcylXtGu+BDp2amHklRJkw+4KSX+m20NgHS3o16xGhgL5wA8mw8pb7hcomoVcDwjBLIz0nyMsiEbqpR0ivFGAbqJ+Oif0ZYHGBaz6tOsPjIln5JY5fp8HUXlsR5ScK7XsCKccuZ060y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihpTXQNx; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e39f43344c5so20445668276.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256565; x=1736861365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsNUSjJlZtYTBoh93lHHHCs7NW4bupMrO3FLPcoKFiw=;
        b=ihpTXQNxyuvKwhq/0aR377b0HtOOK0fm9mvBrE02WGn4nkIGraEavgzYnaxb7xgBP1
         vzL0Jidm1Y7cdeV97VOjmfLY/kTxyb7zkWJ9zYS7nk4QbHOKbtMcNHt1t2iz61FwkT91
         XgVFjosTqGN9mPVQ8CjrLUMBpqXbrEJ/WwCiZIdNEA2u2iUm4hoZN/pd1a+r9FarR//N
         uLt5/bVcYU7M/XxgvvGD40PoqTcQIHInpTMBoFAUoXOJ5eM4Cs0sX/UK912Hn5b0k6UR
         cX0U9f1HdLQ6zWVo5I8FOBgspDtH75lxt7yWsvczA0FAmzFlmlZ5P2OGLvYu6z8YwDo4
         qNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256565; x=1736861365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsNUSjJlZtYTBoh93lHHHCs7NW4bupMrO3FLPcoKFiw=;
        b=hTeBVsbqmNA+aiP6KVlZS/ao+oeg8k1jt593QBD6NG0kD3XE1f3gr67NfEfaQ7DPlN
         N1yJw+QhOm9QDRtD/VgqaxDXs4EcEA3SHpkO5q3+2Rqrvz3p46upLpiC1Y2cEKSCnPCV
         AtcwHRECfAeQEUkb21milFgdxCKZRhR/Nx4CcMtACzyKl3ORbzd5eVZ9SH4QofFVxxoS
         0wwqZKaewqRIH0wQEuwHy4ZSY6NRK6fxWKV8N/ZvevAyWFSP+kPNysD2OBpx4VlUe3IT
         ie3O8Ng5joWINpRLrg0wDDY3JZ7vzzUiQZiVFJQZd3v/G/5Weakom56k/29ltNAsywwX
         CpfA==
X-Forwarded-Encrypted: i=1; AJvYcCVQH7q4CcLmI4aQfT3a45Nl/SAEU4o5QMg6FX33M5Gi7uOmpUsk+jVsiekvoR2q1/vpOrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqebAupcundvRdIA+/Code7+0MJld5AULUOSZGQgjmQvvpsRD
	8nWWfz8iw42Ofj0G8IN3OjSKnNAZO92qF9u12h5ooaJZZeRTPpi6JA9Fgd9Dtvvz3Z9yXhGfsc+
	1UcEIhCY2FHxZYfi8XUs9J3P+IDw=
X-Gm-Gg: ASbGnctAmmPrUeab3W6exyh2aXxPwO3ir+Hc1LKO9TaIac0RFlvhln5vr6jo91GaSpj
	G2JiVx7gl4F8SzEfO+873GFltmnkRjt4I0SFkfg==
X-Google-Smtp-Source: AGHT+IGUPQdcA52Xf8O7x2K5f3NBufmOnYmK+WrYj4s3LL477TxFXLmVdZ3F+pupMNthlHH4RewO/pyPUxtWY4SNO3g=
X-Received: by 2002:a05:690c:25c2:b0:6ef:910d:7847 with SMTP id
 00721157ae682-6f3f8135bdbmr482368567b3.24.1736256565356; Tue, 07 Jan 2025
 05:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
 <20241220140058.GE17537@noisy.programming.kicks-ass.net> <CADxym3Z5GKJB_+m4iyw-Ycy98usMvwHr6jBwW_zBiwX+mdPW5Q@mail.gmail.com>
 <CAADnVQJct=ANAmXCSancBjm7k7uThEOau3u_e8Pe3Mf9jrDzYg@mail.gmail.com>
In-Reply-To: <CAADnVQJct=ANAmXCSancBjm7k7uThEOau3u_e8Pe3Mf9jrDzYg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 7 Jan 2025 21:28:51 +0800
X-Gm-Features: AbW1kvYAgIjcN88RWxp34Zu88FhSM2VOXRe_ViFeXTKi0FuU8d1L2brUlgJ2rrc
Message-ID: <CADxym3YgUdPNdnQmKJGm2zZe-V075hb2u0Wuxwt7ShEYguHUnA@mail.gmail.com>
Subject: Re: Idea for "function meta"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 3:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 24, 2024 at 7:25=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Fri, Dec 20, 2024 at 10:01=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Fri, Dec 20, 2024 at 09:57:22PM +0800, Menglong Dong wrote:
> > >
> > > > However, the other 5-bytes will be consumed if CFI_CLANG is
> > > > enabled, and the space is not enough anymore in this case, and
> > > > the insn will be like this:
> > > >
> > > > __cfi_do_test:
> > > > mov (5byte)
> > > > nop nop (2 bytes)
> > > > sarq (9 bytes)
> > > > do_test:
> > > > xxx
> > > >
> > >
> > > FineIBT will fully consume those 16 bytes.
> > >
> > > Also, text is ROX, you cannot easily write there. Furthermore, writin=
g
> > > non-instructions there will destroy disassemblers ability to make sen=
se
> > > of the memory.
> >
> > Thanks for the reply. Your words make sense, and it
> > seems to be dangerous too.
>
> Raw bytes are indeed dangerous in the text section, but
> I think we can make it work.
>
> We can prepend 5 byte mov %eax, 0x12345678
> or 10 byte mov %rax, 0x12345678aabbccdd
> instructions before function entry and before FineIBT/kcfi preamble.

Sounds great, which makes the raw bytes safe enough!

> Ideally 5 byte insn and use 4 byte as an offset within 4Gb region
> for this per-function metadata that we will allocate on demand.
> We can prototype with 10 byte insn and full 8 byte pointer to metadata.
> Without mitigations it will be
> -fpatchable-function-entry=3D10
> with FineIBT
> -fpatchable-function-entry=3D26

Yeah! And we even don't need extra bytes if CONFIG_CFI_CLANG
is not enabled and mitigation is enabled (which is enabled by default),
as the remaining 7-bytes is enough for us.

> but we have to measure the impact on I-cache iTLB first.
>
> Menglong,
> could you do performance benchmarking for no-mitigation kernel
> with extra 5 and extra 10 bytes of padding ?

Okay, I'll do this performance benchmarking (maybe a few days later,
as I am busy at my work these days :/).

>
> Since we have:
> select FUNCTION_ALIGNMENT_16B           if X86_64 || X86_ALIGNMENT_16
>
> the functions are aligned to 16 all the time,
> so there is some gap between them.
> Extra -fpatchable-function-entry=3D5 might be in the noise
> from performance point of view,
> but the ability to provide such per function metadata block
> will be very useful for all kinds of use cases.

Thanks for the advice, which gives me some faith in this idea.

Thanks!
Menglong Dong

