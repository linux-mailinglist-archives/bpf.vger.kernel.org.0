Return-Path: <bpf+bounces-46117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0519E46FA
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B0316A3A9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CC1C3C0A;
	Wed,  4 Dec 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/X2gaUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91281C3C03
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348249; cv=none; b=te4A+73v2B1EvkElzfufRzIMNO1YeGVO1HFquOgvq6At7pQKglYBnwNl9xmCSYmDTXgNsZ5SParcJmzwiKfRafSDhbzMj9Ms0TZG8VLD942MH6Ojk2FhBOC5Q9rq+56G/+WtAh3ucidFwkM/2NyTMA2t+ctnPkudeRVcNHuHvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348249; c=relaxed/simple;
	bh=HgWpKM/yc0Glwnlp6Qz3aPUH0GQ+ns6H/2m2RStaWMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ef0LwaUkh1wwQIjwLo7l3kPkdtlKbrx1Y3lTsXkWVzGkLnxg0GYeXzmXjIPHp02CCj4sPdrimIy8UJAULHKTfHtz5NJIF34rDFlB3SsZLf2M7ysRX7F4Ngn5iZTLUylmdQ6DYpA9AeiGnTwWljI6mhUey5bxx/sg+sqxxk6zFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/X2gaUd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7250844b0ecso251135b3a.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 13:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733348247; x=1733953047; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aL/prB2+OSuZpvLxI+jMCUTuhnuekOnBdRUi9LaeRDQ=;
        b=O/X2gaUdU/aUGJAfXUbY9dKcHIwGmqgPzaOrxiFM0S4OV1vrz14Phx6VpRHcSDHT/r
         4CGnYkLR5kr9c1K0h+lcctHSN8cNf4kdFW0JLntehYtQ6Monev7SHPmPdjai4DVnFEQH
         ey8jwt5XAihXvQq3zTAallR0p++5GnC6ZsG4sKI+4JtHI22oM342N3B3fOWIEcLzVCy7
         2c94dNQQfAy2VZPNEwI2eFwMZyAwnOiK0nY+ck+HtmSOkjOUvraAf9W4taRmqKrTT3JY
         bUf9/xjYrgXuVSYYkIiFiVNAIPyHq5Ur2OxYjarM67fEeIwsLF4QKAvnhho0CQGRZ77U
         Nq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733348247; x=1733953047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL/prB2+OSuZpvLxI+jMCUTuhnuekOnBdRUi9LaeRDQ=;
        b=oJ0ZCtB4IB6W23Qx9U+7xLGXXtlKDuszGjR2wwA6myaLLjZGm/2uxp6cLthWHwThl5
         UMaa07GM0BJF4ZiMX/6HR4LcLV4lkPrLvPWlhdW8Tl3zLfAh0FDvBv4d2RnA059V5p8U
         fG0k/Fu1CwLFmqzjQuy4GExnLKPkijd4xHeatDBg8lq8IZBgaVginhtUeYx2ZjVuZaJ6
         vk3aMrR6M4JQ/rQFvr6mCG6gjVJmnhYDfwH8MLIBevFLrrGs6lkpRA0JpjSMheQ5T6R/
         QBrebaHHUyAH5lfW5It2tITacKm/hvELP9Mrw+Y5Xe5Q1WZmpgXncNWUMpKkQ/6omaSI
         opiA==
X-Forwarded-Encrypted: i=1; AJvYcCXaCb0jeyvH/8Xo2ujVzlLrL3pGONktjNPxY5NBnLK0vd3igb/5Kj8ro6AiXXRRLkZrxsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZwWtL6oT6iV+GdT9iw9ODwTotT8sgBmDyUs2wBgDbZ/WhMeQ
	fSMzEqYdDKJPGU5USaY0k121AkykvvCshNuP5mIAIW+h0bd+KumY
X-Gm-Gg: ASbGncvMc7Gvm3rSHe5C32b2yGaVJJHdLPwsF0xCzdIDMbnb2uo5svREPYMq2F1Xm2f
	5AU80ORliT4ugIyD6D0h/nLGS6q9QZ1NFexQwfG9bu3UCfQ7yhj+3EhF9mqV2yoV9NwlKtcV3w3
	Ho7KXIT+p2c0IT72EVS7UEr26Sd8+5LWjQrpyp37KBvcPuaQ3+rDZtS5kS6YjiTC2NR6B02xfaA
	+JMf81f8ohcGKlFX161NEXfkdVTLjSlHdUaQ/okr4ALjhgfj5YsFVBUV6/sg8mtExmJMZwOBfJm
X-Google-Smtp-Source: AGHT+IFGpeLEgPZQZybWY1f4Hd8OcR7O8VyQJa9adsmQDOy+IXAH7Uk9v0S/zRCos+cILhvvPPGDgg==
X-Received: by 2002:a17:902:ce8b:b0:215:711f:4974 with SMTP id d9443c01a7336-215bd192916mr94776725ad.55.1733348247152;
        Wed, 04 Dec 2024 13:37:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:ab16:b297:5216:f3f1? ([2620:10d:c090:600::1:468e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e64383sm56515ad.106.2024.12.04.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:37:26 -0800 (PST)
Message-ID: <4d96bbb0433d4fdd285b9fe12cdfe9259d8b929f.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
 kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Manu Bretelle <chantra@meta.com>, Kernel Team
 <kernel-team@fb.com>
Date: Wed, 04 Dec 2024 13:37:24 -0800
In-Reply-To: <CAADnVQ+ObWEF4g_FVrwFJF4gnkmBB=4UcnGZV5jaJ3SffyG0HQ@mail.gmail.com>
References: <20241204024154.21386-1-memxor@gmail.com>
	 <20241204024154.21386-3-memxor@gmail.com>
	 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
	 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
	 <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
	 <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
	 <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com>
	 <ce15b00ac30c6cfba16f63e6c03018a59af8acb1.camel@gmail.com>
	 <CAADnVQ+ObWEF4g_FVrwFJF4gnkmBB=4UcnGZV5jaJ3SffyG0HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-04 at 13:13 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2024-12-04 at 21:48 +0100, Kumar Kartikeya Dwivedi wrote:
> >=20
> > [...[
> >=20
> > (A) ----.
> >         |
> >         v
> > > > > What this will do in both cases::
> > > > > First, avoid walking states when off !=3D 0, and reset id.
> > > > > If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all regs=
, and
> > > > > remove marks for those with off !=3D 0.
> >=20
> > (B) ----.
> >         |
> >         v
> > > > That's getting intrusive.
> > > > How about we reset id=3D0 in adjust_ptr_min_max_vals()
> > > > right after we suppressed "null-check it first" message for raw_tp-=
s.
> > > >=20
> > > > That will address the issue as well, right?
> > >=20
> > > Yes (minor detail, it needs to be reset to a new id, otherwise we hav=
e
> > > warn on maybe_null set but !reg->id, but the idea is the same).
> > > Let's see what Eduard thinks and then I can give it a go.
> >=20
> > Sorry for delay.
> >=20
> > I like what Kumar is proposing in (A) because it could be generalized:
> > there is no real harm in doing 'r2 =3D r1; r2 +=3D 8; r1 !=3D 0; ...'
> > and what Kumar suggests could be used to lift the "null-check it first =
..."
> > restriction.
>=20
> I don't see how it can be generalized.
> Also 'avoid walking states when off !=3D 0' is far from simple.
> We call into mark_ptr_or_null_regs() with id =3D=3D 0 already
> and with reg->off !=3D 0 for RCU and alloc_obj.

I did not try to implement this, so there might be a devil in the details.
The naive approach looks as below.

Suppose we want to allow 'rX +=3D K' when rX is PTR_MAYBE_NULL.
Such operations generate a set of pointers with different .off values
but same .id .
For a regular (non raw_tp) case:
- dereferencing PTR_MAYBE_NULL is disallowed;
- if there is a check 'if rY !=3D 0' and rY.off =3D=3D 0,
  the non-null status could be propagated to each
  register in a set (and PTR_MAYBE_NULL mark removed);
- if there is a check 'if rY !=3D 0' and rY.off !=3D 0,
  nothing happens, no marks are changed.

For a raw_tp case:
- dereferencing PTR_MAYBE_NULL is allowed (as it is already);
- the mechanics for 'if rY !=3D 0' and rY.off =3D=3D/!=3D 0 can remain the =
same,
  nothing is wrong with removing PTR_MAYBE_NULL marks from such pointers.

> 'avoid walking with off !=3D 0' doesn't look trivial.
> It would need to be special cased to raw_tp and some other
> conditions.
> I could be missing something.
>=20
> Let's see how patches look.
>=20
> > However, as far as I understand, the plan is to fix this by generating
> > two entry tracepoint states: one with parameter as null, another with
> > parameter not-null (all combinations for every parameter).
> > If that is the plan, what Alexei suggests in (B) is simpler.


