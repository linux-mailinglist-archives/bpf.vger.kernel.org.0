Return-Path: <bpf+bounces-30318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07F8CC5CC
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 19:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE37282BB5
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95B77109;
	Wed, 22 May 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akvgZ3UT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F1145B1C
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400040; cv=none; b=g5/JBE9FfAWOhSDJFObsmxx1u0wR2F563tvmKtrHU8abrfLdoNJSGgLe/BnQ/vjs/Ldf+o+MyqFv/I0x/achPoR4xq7Vpwv1XIr3vX6/iroErknQKiceqZcpcAQ0hBQhvLv2cdG3nzoy7yj/LvMkb2filvzvlXdKCcp/uICvmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400040; c=relaxed/simple;
	bh=l/aqMP/pAxxQNkv1cpn6DL6g6yJONydNx3Emd5onJIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsR+psKr8n2CrFArQ24SL18AKBd5Wpja2Y/ITHXhNSmchA7Q9O/8yQv6VZYhqIQnFiPjIsrMUnS8RMrOaYXR2m/Niy0QGLnL7EUfkSOXK6lQR72sqJTcQkifyUHioh1l7qO/W/5FmrneqnYrnMgM08CN44jg45jp/OBrOC559DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akvgZ3UT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso696a12.1
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716400037; x=1717004837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=akvgZ3UTlTl9+ivduLm+K+kDJXBgX7m9rh6LWIoJ5H2KbLUZiAEB+xALqgtsTGcreC
         /iGvWquaYv1hZkIID9rsWH+bYGPL6cSEsuu9vwcfp8yYhRq43Gc0JxhJxl5pavZeNLgf
         V5pUTOKdLZycj5x8roYhHYzdODB4RXw2uQ5wRgrNK2r5wdpnM1rukZEcDTa7gomOZaIe
         8gv/LNbpNsqpwDslxTRQeWL5ogIzMRe4J1F6OlwOJyEZK87fsy8x8cx251k/J+4mmtgv
         CgJxGH85eI1EexL14QfqlkKsmNLAOqijklgJtii18KpWAe9UOs0ibb0ysTJhD2wrnZDm
         6cPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400037; x=1717004837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpzkj4h24ckPZbqXAVMFddkCZE0Xyra0TpA42yUw6Y=;
        b=sKqbnkSQKz6FzVjJBWvG5MGu+xV8IVrm2T6b9r4asXqTR1C2N3zPZPVOuG9ZaYMotS
         zSZ/fcgO7gg22YUWWMw6psXBSr5Ok1NLFiyRykfqngft7SA/RxAj+m8vJaK3/nlxV5yV
         x2fSkoNuA5T50u9wUV9c3RTqRaQo8F5HQGowLNAEyeFc/5NxkCLUxiHX3t4a8cLliZcv
         0BQBrKRqsz7ABKOJ0xuiNIcbDcAC5oD5hjRjGVc4sSgtmOwfGFwqEAAq/zVQYQA/hLII
         xly0sNqwKBkNLuKK9vV9nC05m9fJtPg9pDnBUTm6AGJaiYqYg1sbOOixkqjlVBreHv/Z
         l0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXpUuUrjHanP1A9y9PxBvn3DDaDGupU4cxWZjCxSIDW7UDELw34K4w3ZFXDl5STqeBj3BcfEv7kUx5uCnubCBoAUHZM
X-Gm-Message-State: AOJu0YzHNvJoShXcJESexu1x0iUlIqDmCk4HZ/RJgZ50RtF2JNSofWi0
	A6JAlLmYnWzwqa/JWWgc9RP7LVhd/GB+sbrq5PoJpnHItMC56YcmgAXIXPEbIvd+huxJaRH85ic
	fgrP36XYWo9yp0BZ9bLaJRkO43S2lS3z8G7dp
X-Google-Smtp-Source: AGHT+IEhvV3LATx35FZqHosI0UhkBDI1Niq/eTXGrnklxwDEu8dQhBOKQ05jw+yjdKEjHZAcrzgbp92SS4Zf1xFsuR0=
X-Received: by 2002:a05:6402:50cf:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5782f9f7e7bmr285506a12.2.1716400037143; Wed, 22 May 2024
 10:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com> <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
In-Reply-To: <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 22 May 2024 10:46:50 -0700
Message-ID: <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:21=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
>
> > to make stopping builds early replace the static_assert() with a
> > missing without making the error more severe than it already was.  This
> > will be moot once the issue is fixed properly but reduces the disruptio=
n
> > while that happens.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/kselftest_harness.h | 2 +-
>
> You've not provided a Signed-off-by for this so people can't do anything
> with it, please see Documentation/process/submitting-patches.rst for
> details on what this is and why it's important.

Sorry, my mistake, I forgot to add it after cherry-picking.  If added
in a reply like so would it suffice, or would I need to send another
patch?

Signed-off-by: Edward Liaw <edliaw@google.com>

