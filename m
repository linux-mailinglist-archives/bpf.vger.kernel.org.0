Return-Path: <bpf+bounces-46114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDD9E465C
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A7A169AF8
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A1190485;
	Wed,  4 Dec 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brgaJQ6d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A977918C32C
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346847; cv=none; b=CeJ7as27S/5DuPQ1LxJFsMnJ5jFTXz+zqOx4P+BS7jdVeiJkdg17IEi/xdtGHbYt1+hR4BM9k15DyI2niHjmCNReb7SPogOowqhdPiAlNH6u6VMBwi4ske3Yy2Nw64t6VgAbyEeKZk6JcgoZ7biG7W/Vcc/Uigx8+CKJCltR4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346847; c=relaxed/simple;
	bh=AD1tP02NBj2ZogRRf1mjr3WDkPOz6aPmn3WMTZjfXUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2B4AVEhdfIpjZKS/4Im+3YHfXWZxVk3G7cnhWeKhHEtXytGb4gmRDpD63EU0y7E6ASTD8uA2U7HlRpseCggpA+qAqh/oC61Ka01tQdsfesc+8B4Gd4lpAnS1x6ltvECkIwyiqzNpKBlbO46mxtl4ryydszswPDcHHIREkXLh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brgaJQ6d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385df8815fcso120480f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 13:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733346844; x=1733951644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8h+4dhP1JvvWwAYa5D4MxhLitwNDA92kMuNjlvshhk=;
        b=brgaJQ6dzZ9SOlQkzLrjDpENVHXtmexTBk/0eMBMX3hrFNqCXhnJrJibYT6it5+sSm
         MTINTxY+9krXlj4l2TBFO3GvQV+Tvnju5XE1E4SYWojAKyrVElcwdePIkTOVbmNgTfKu
         7MpIzyjzkhhpeQ9LNoaMLEX7OB3mu9WTLPWMhJXuxDKN5N3x6twdCOEOvGXAZLPAzedy
         A7CXNFGTsc0xvtby4pNJgV777O49aZGAm+RSWFYcQDaNx/uwCB0BMg/ociMTbXrroAlP
         dubiWSFbwjWDKfTOx0H810QfV274hTIdlnpV0xmSIEAgbGS41xhUj+FVLTwBlNV/Zo1Z
         apnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346844; x=1733951644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8h+4dhP1JvvWwAYa5D4MxhLitwNDA92kMuNjlvshhk=;
        b=tO9KGek9J08w9YtxMTp0syfD71/k38GNPUZLar6tvy3ZuhvupBUqkEMpPc0GaQg0dH
         Rq85m/xaUtfH2uA8rBljmDQRWEqfpkKzo16RwRyyNew87U2W0b1QMKRCkGdXRWLYy9K5
         Av0VsQRQ+mtDJOffw2m3KqZjAIP32VSMrjBNhs3KV9vxtnIlkK8OeY8pwn+cVoPCucQl
         vCid1vxJYPsy7VVkQh1L/1+53Hpj3O3PkdxeoixHJd81nytPqFpTIM4Z77mRHv5VZ8JB
         Q29MZjZrR+9M8CNc1684WdoT0MHrw1j9MZSebvSwlbVg4HMi9MRLZUm8y2V6dUjVO9PW
         9VAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Tuk8LWcxc3CWZpkf2TXNoN3y8g1oZvl2BB8XKDtZEgq5ZzUn3GTI2Z1sF1U+sE1vHgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/MqBboXgZVTTkMNWxldkC27RmlNA74NV6DWAUOBnI8XH04p6
	TmpcJ0YGZZ3k0E+4nLCQYETcLrOYAo7W9+m6HIlzn8oP7ce9z6ft9Sz2Ar5UJoYuYJlr2e7dsX2
	KrkDOGwBJPKQPF5XIWEYwOl6eke8=
X-Gm-Gg: ASbGncve+gemHByP0gAntfSdNbiU0zWjFesQ1CZENJACWNjKXqKFDzq4mlp8FwXutcb
	YLeTeba+TErKPL5+tSROIF2emE58SePb7hQ==
X-Google-Smtp-Source: AGHT+IEXaLdd4ISsqWM6fLKfLvRv+KDYXYuepM0Ont4ExxImqnpSH+/7VCzx5oxqD2EBsK/W68smUPOS5FFFBvsbXO8=
X-Received: by 2002:a5d:6d89:0:b0:385:e429:e59a with SMTP id
 ffacd0b85a97d-385fd3f2febmr6169202f8f.25.1733346843786; Wed, 04 Dec 2024
 13:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-3-memxor@gmail.com>
 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
 <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
 <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
 <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com> <ce15b00ac30c6cfba16f63e6c03018a59af8acb1.camel@gmail.com>
In-Reply-To: <ce15b00ac30c6cfba16f63e6c03018a59af8acb1.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Dec 2024 13:13:52 -0800
Message-ID: <CAADnVQ+ObWEF4g_FVrwFJF4gnkmBB=4UcnGZV5jaJ3SffyG0HQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Manu Bretelle <chantra@meta.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-12-04 at 21:48 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...[
>
> (A) ----.
>         |
>         v
> > > > What this will do in both cases::
> > > > First, avoid walking states when off !=3D 0, and reset id.
> > > > If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all regs, =
and
> > > > remove marks for those with off !=3D 0.
>
> (B) ----.
>         |
>         v
> > > That's getting intrusive.
> > > How about we reset id=3D0 in adjust_ptr_min_max_vals()
> > > right after we suppressed "null-check it first" message for raw_tp-s.
> > >
> > > That will address the issue as well, right?
> >
> > Yes (minor detail, it needs to be reset to a new id, otherwise we have
> > warn on maybe_null set but !reg->id, but the idea is the same).
> > Let's see what Eduard thinks and then I can give it a go.
>
> Sorry for delay.
>
> I like what Kumar is proposing in (A) because it could be generalized:
> there is no real harm in doing 'r2 =3D r1; r2 +=3D 8; r1 !=3D 0; ...'
> and what Kumar suggests could be used to lift the "null-check it first ..=
."
> restriction.

I don't see how it can be generalized.
Also 'avoid walking states when off !=3D 0' is far from simple.
We call into mark_ptr_or_null_regs() with id =3D=3D 0 already
and with reg->off !=3D 0 for RCU and alloc_obj.

'avoid walking with off !=3D 0' doesn't look trivial.
It would need to be special cased to raw_tp and some other
conditions.
I could be missing something.

Let's see how patches look.

> However, as far as I understand, the plan is to fix this by generating
> two entry tracepoint states: one with parameter as null, another with
> parameter not-null (all combinations for every parameter).
> If that is the plan, what Alexei suggests in (B) is simpler.

