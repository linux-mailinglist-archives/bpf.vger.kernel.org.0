Return-Path: <bpf+bounces-36794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44594D74B
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A901C224C7
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2C15FA8B;
	Fri,  9 Aug 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaEz7Imf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855014F9E7
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231694; cv=none; b=n6XxT7lDmrgDk9WFbDdwFGONPGUTP9892VI1nNnicE+h4kKbsxAN0NhGcukPNWG/sp5G1lADRbt7nphOXODKS+Iswn5KqZuL916+srE9kEeknLvQREb7X1QHZHUvdKHFRrHQkexp649V8fBJHSDLg759BNPfTCNI9AWTClzKitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231694; c=relaxed/simple;
	bh=IkB9NaxRwmEjNpNTBcllNjhWm1IL+Y60NHUYrziFDuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpe6dTOYOgPZPcNdVzdS8AzWJvpVGmPri9JpPrc5ejiL/nA8X7htdRv800+aAGBj0vrzrEVWJRTWhrrV3OfO0pFK3jO+/ujXm3RzBNS4LBLTG0/ak30IBYba3zodeA7hbMvguBpx+uhO6g4FxJM0IO+kX9rTz8zyo9PX0a5TN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaEz7Imf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1545036a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723231692; x=1723836492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZGkVDbEPvh6/s9H2pcjwLTUqf9s3z08tKEjgN6Xi+A=;
        b=SaEz7ImfIyZ0A2cWKZopsUt33N3hGLpuV3qv0zfFexUJiNpP61G4UBYbFljxZ3aX2x
         PTSOhu1oBleXBtdo5UPlr3SLlB8lRwjLz9vc6gDPCbUrcZmawNCxLzV0zqfWTYEAG9s6
         YEAKrMuP5WJMfDmEMlWYoxS9TO6gNLVbmqfUa2moEL0pu5/2MCKSt9H3PTAoQinCc7kl
         BZwx1zMARs+NactopBrgtsUa/gL+7egkyNvBaCDa62nEFnJvIt8dRAyCZtmT2rW7KZPN
         uOEdU9tQDwW9ddJTJRE5j9PImLVyUvbt0sn09aoT5a23XVqsKoE7PyIiu0TJHJEtNdPe
         VqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723231692; x=1723836492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZGkVDbEPvh6/s9H2pcjwLTUqf9s3z08tKEjgN6Xi+A=;
        b=B/OrbEoebC/+HXlQi3nxeIY4gegt1nw2Op7/lw9ZQWTllr6umbe7HS87qfUI0H/eV1
         kHJPTWXNy2jGxsOihdHux0XNZgV4Q7mRP7yGSQKxknEJtp/tubQM36qum8GtyXWwVZ3H
         ngziP0sUYjWAGiLFOcgKwFCkkH9+2V0hHHSfGIgZjGcdB50Tojt1aK5TDBieZ1OHADyJ
         nVv0Am6/aatjmU2j65SBHu7W9Y2i+v0hBmaEsfYVMzKgbLLSdVASF2zAo70bDePoy4r0
         JR/e9iT7mWBbkBzOKwdEKtetZyhaXeUwROOKXJQggbUU+OE+VoY5yp4Uvdp/trllAa2V
         P1ag==
X-Forwarded-Encrypted: i=1; AJvYcCVCfgv76C3N/gEpWGJp+mBNgc0UNh14Ksp4YgpeBHLu2ZeOC3Go4omji8pZITXJEGAypjxUJfUzgeOjdQyS8vKByj4+
X-Gm-Message-State: AOJu0YwQkVXBX90/t8lK66FRbaUr0r4Nkg24NCLre+V7dkXBs8+hhfSG
	RAXnJRmyH4HH+qqjEZnQRhEE5eZ2O48kncApxgBGNDzBXIdbFEEh5p6tKgYfV29NBBwjTlTs+eZ
	KC/sOeonChHCUKN4cuhuPtwPb86c=
X-Google-Smtp-Source: AGHT+IHh01uET1sxaYXdoyhGt2cxkK3kzff5abkeYg9uiVBFUbYWeMxGxzK/urq1orFcLzy474f6vCgTbt04lmw/BHo=
X-Received: by 2002:a17:90a:7c4a:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2d1e7fe20e1mr2631274a91.19.1723231692344; Fri, 09 Aug 2024
 12:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808232230.2848712-1-andrii@kernel.org> <20240808232230.2848712-3-andrii@kernel.org>
 <2689ece2c10e234a2326ad4406439ad7c8d35a03.camel@gmail.com>
In-Reply-To: <2689ece2c10e234a2326ad4406439ad7c8d35a03.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Aug 2024 12:28:00 -0700
Message-ID: <CAEf4BzZ+PKpcx+OXhr60MizW3x1dEGp5=FbC5ZUkfpg-b04hzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: allow passing struct bpf_iter_<type> as
 kfunc arguments
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:14=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-08 at 16:22 -0700, Andrii Nakryiko wrote:
> > There are potentially useful cases where a specific iterator type might
> > need to be passed into some kfunc. So, in addition to existing
> > bpf_iter_<type>_{new,next,destroy}() kfuncs, allow to pass iterator
> > pointer to any kfunc.
> >
> > We employ "__iter" naming suffix for arguments that are meant to accept
> > iterators. We also enforce that they accept PTR -> STRUCT btf_iter_<typ=
e>
> > type chain and point to a valid initialized on-the-stack iterator state=
.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> In current form this allows the following usage:
>
>     SEC("?socket")
>     __success
>     int testmod_seq_getter_good(const void *ctx)
>     {
>         struct bpf_iter_testmod_seq it;
>         s64 sum =3D 0;
>
>         bpf_iter_testmod_seq_new(&it, 100, 100);
>         sum *=3D bpf_iter_testmod_seq_value(0, &it);
>         bpf_iter_testmod_seq_destroy(&it);
>
>         return sum;
>     }
>
> Do we want to ensure that iterator is not drained before the call to
> bpf_iter_testmod_seq_value()?
>

I'm not sure I follow your question. Drained or not it's still a valid
iterator state. I don't want to put any restrictions, the user is free
to pass it at any point between new and destroy.


> Otherwise this patch lgtm.
>
> [...]
>

