Return-Path: <bpf+bounces-22515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067085FF55
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416BF1C24201
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E6156985;
	Thu, 22 Feb 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlkAXm3H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3300155A4E
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622942; cv=none; b=Z+JsamPNlG5SkCQABYqKaYoaM5T2+qyBxLcc0zTiCTg6OfmgO9VIvkDqDjRr1ktvr/eAA28PS3NasBV8t/C4wH/fv/CHqzKl6YNYGL9aut0a2nIvJAnyKJM8ZJmD/GvPHcqDZeLosKrqzEbaEbO4H+G3DEMNE4zLZGeVEh59UFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622942; c=relaxed/simple;
	bh=F8qWr+/owUCgEeKRpBidaRUCn2rSvKgzaFShEsf3oeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkizMh9wZbGnYWbM3/8yMGCsyS4fN3Y61KOLGWvwZcpCQQIqLj7ZNPKr8wxgFnRBTmjGFhCMA2e63TntyOC36texZMHGkTeu83qsPwHZk67y9RqOTFITeR3lN9v7zzKqsrIJzpv5ZoT8/kD46ZNytQY0zBDM1IN4xpGFXn9120E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlkAXm3H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d509ab80eso2668820f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622939; x=1709227739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmVOvrfBOyH5HYw70mAyWuU5BlTwyJCt3mxbttKweDo=;
        b=TlkAXm3HtbMGzwuvMS4BLx476y8gJiG1Ci5Lc3u1qXAoaSm2uGQcgX1EzuAY/OGAQo
         T22mp+AE+FU0dRubodTCn6o79BSb7ugyfk66w/h3v7OX3/+SiQ0Yb97ngg4XHH2Eh9IC
         QSi6Oh1b2T7arfTiMRpTJ32nikwHIUNaoW9l1jHOOeY4Tz3GcniN2I+COvArils2SVtW
         AtxCt3wQrYiOioD90XUW5SuAQVLYJXLpENMVRxA0TgTetJXTWj3Mn+enZMBGhUSuNfbq
         7V48qUtfmEhpjcVvcyEukTU9YVpV5J1nZUc2nrrubmql+kRq9e5Rr1J/JGHAxRWVlGlN
         oRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622939; x=1709227739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmVOvrfBOyH5HYw70mAyWuU5BlTwyJCt3mxbttKweDo=;
        b=E4Y+7zKMFOOeJjGF/0JujqPR0j7gaTfV9Dmb5xT/kFOvqdKEFqQXqghEIH7BPZFJMu
         uNmVIqMPGFW99wYHsPE4iE2/SVXRlWJQp0LR9lSD28a/klWNDwQygN8GRJjR/oFGLd8z
         oFVEJJmYnYevxwlP4ACTnb84zvxapOYkw72RyOXGceC2kPaZfWyQcC77xFXMraiESmqt
         BuICu6x0gBKeX0rjjqDBLvREk/8TNbVa34Ak3/DSuujB5LrbUQxo9Aw334FKixKw+N/r
         f22oubBiufdMrvsiBCVvJg3ncoXmWZDjNt/iOgkeVnM2EzNjJ+4xsH7D2P7XquAdSMLI
         bU5w==
X-Gm-Message-State: AOJu0Yw99b2+2sSxM/3dfi4DINxw9J/+IjhU7s4WcgCv6EvU4EthmWbJ
	pMOxn8dp/WuP1OWLdIayRxL1avE20ysWQpUaF/FD3K7Gee8t2XcJj72OeEpx/gv2pk5c53f/V5j
	cEPRi7VtvbGJS4mEjtU0U6NueVEI=
X-Google-Smtp-Source: AGHT+IGtBUxwQVQR+4XZGBCh39LhtLKXvCgK5lVDvYph37wboINgejFecRbM6gtDmmPASF5y7Sk2G8mdTNBtiec/H6A=
X-Received: by 2002:a5d:5645:0:b0:33d:3b83:c0a with SMTP id
 j5-20020a5d5645000000b0033d3b830c0amr9254121wrw.34.1708622939255; Thu, 22 Feb
 2024 09:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221191725.17586-1-dthaler1968@gmail.com>
In-Reply-To: <20240221191725.17586-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 09:28:47 -0800
Message-ID: <CAADnVQJq0aG2kF2KN1SCM9cZtRLqxKG=UkF=5-XWjFBbvLZhhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf, docs: Add callx instructions in new
 conformance group
To: Dave Thaler <dthaler1968@googlemail.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:17=E2=80=AFAM Dave Thaler <dthaler1968@googlemai=
l.com> wrote:
>
> -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X o=
nly

...

> +* call_by_address(value) means to call a helper function by the address =
specified by 'value' (see `Helper functions`_ for details)


Sorry, we're not going to take this path in the kernel verifier.
I understand that you went with this semantics in PREVAIL verifier,
but this is user space and I suspect once PREVAIL folks realize
that it's not that useful you will change that.
User space has a luxury to change. The kernel doesn't
and we won't be able to change such things in the standard either.

Essentially what you're proposing is to treat
callx dst_reg
as calling any of the existing helpers by a number.
Let's look at the first ~6:
id =3D 1  void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
id =3D 2 long bpf_map_update_elem(struct bpf_map *map, const void *key,
const void *value, u64 flags)
...
id =3D 6 long bpf_trace_printk(const char *fmt, u32 fmt_size, ...)

They have almost nothing in common.
In C that would be an indirect call of "long (*fn)(...)"
just call anything and hope it works.
This is not useful in practice.

Also commit log is wrong:

> Only src=3D0 is currently listed for callx. Neither clang nor gcc
> use src=3D1 or src=3D2, and both use exactly the same semantics for
> src=3D0 which was agreed between them (Yonghong and Jose).

this is not at all what gcc and clang are doing.
They emit "callx dst_reg" when they need to compile a normal indirect call
which address is in dst_reg.
It's the real address of the function and not a helper ID.

Hence these two:
> +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x0  call_by_address(dst)             BPF_JMP | BPF_X o=
nly

are not correct.
call imm is a call of helper with a given ID.
callx dst_reg is a call of a function by its real address.

This is _prelminary_ definition of callx dst_reg from compiler pov,
but there is no implementation of it in the kernel, so
it's way too early to hard code such semantics in the standard.

pw-bot: cr

