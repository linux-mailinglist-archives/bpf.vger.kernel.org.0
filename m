Return-Path: <bpf+bounces-16895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624D8075E3
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE4CEB20DF9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA1549F66;
	Wed,  6 Dec 2023 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz7QGVW5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14262D3
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:58:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1db6816177so117624566b.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881883; x=1702486683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iug8OAyp6AnJdk1tQx4x6SKVbjsdPpytUOUiLd4YsvI=;
        b=Fz7QGVW5PYd2DUyiCY4alaF3Cj00fgjBg7Z7hDZ38HqqnUEKAMS8BqLlVXLw5rB/Pz
         IgzPWETirdLwzYBaIkqmbg1M9BgOsEZrgmBnfMHF06eu2gCqSp51VF30ZxVHo9UF+BjN
         objL+Qxr9tArJ4B/uTTEnxFRTqtDpUJSG41ZhkSiNQ6Ln09BaNacgqf+d/kjSX+fW0w8
         exMW9TsuFTW98x+KolkGDGVkEjqQBBY61CPK3OWQfTB+9ivgJIQcA44LgL5WEhpGiNk1
         3yiOPxBDemE2Zi1eRISExOyZp0koR96gaynmhtKtycaM7sjfhBPbwjJZr79u4EbXRdGo
         bMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881883; x=1702486683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iug8OAyp6AnJdk1tQx4x6SKVbjsdPpytUOUiLd4YsvI=;
        b=Qdyl2j//NnLaqs/0hbEls25s26dFrCHVNXvDWdYJe4ej+QEdPLaR/nySUb20Tt8BAM
         2oiFUZPnxnBEhGKOfaT2EuXhIuTpVWGJy0coPDf3hvg4i9xkHrWJKoOT3Rkf1ZqLSfq3
         Lw8ofIFtFdjBe+Qdpqy1OwJ2rE15shHBBnkdUVbDMyi7qmnrmPG/sp6+0h0s3qTEyiF0
         y02oQPitWFExZgzeO3jhecVuYkk4U6wzTeYOm6luUFwsTa0+lzCensVzBmxC0238Xj6B
         5w5Np4F/KXPwv5PX1bF7gY0HOY9wBvObtEEmIWBvrliObCWFZiHu9fVpZutOowhXKwEX
         KLNw==
X-Gm-Message-State: AOJu0YwKsFEwjLjLrdM7Dz/0nV5vNrY44eCjpC8eXTu7jEIILlbY8iSJ
	ccdqunxeAZT++EVuD5DJkppcSxyoLAVli9P9yYPvTlgXe7Ojsg==
X-Google-Smtp-Source: AGHT+IENdwgOIVAaIvRPWaCK/jMTMlF0L8CL40bOMDLQotdMma/9qYEGPptfyedj/cSooksdG45zPMrq8EIb/htWcKs=
X-Received: by 2002:a17:906:aec6:b0:a19:12b6:74a1 with SMTP id
 me6-20020a170906aec600b00a1912b674a1mr506067ejb.24.1701881882981; Wed, 06 Dec
 2023 08:58:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205193250.260862-1-andreimatei1@gmail.com> <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
In-Reply-To: <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Wed, 6 Dec 2023 11:57:51 -0500
Message-ID: <CABWLsevo3JDGti3c8guAm8vphUT+13aoMCibiN8EDYpcKmafAA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: fix verification of indirect var-off
 stack access
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 6:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2023-12-05 at 14:32 -0500, Andrei Matei wrote:
> > V2 to V3:
> >   - simplify checks for max_off (don't call
> >     check_stack_slot_within_bounds for it)
> >   - append a commit to protect against overflow in the addition of the
> >     register and the offset
> >
> > V1 to V2:
> >   - fix max_off calculation for access size =3D 0
> >
> > Andrei Matei (2):
> >   bpf: fix verification of indirect var-off stack access
> >   bpf: guard stack limits against 32bit overflow
> >
> >  kernel/bpf/verifier.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
>
> I think we also need a selftest, at-least for patch #1.

Yeah... I was wondering in a message on v1 [1] if a test like what I had
prototyped there was warranted. I personally still think it's not because o=
f
how many other variations of variable-offset stack access tests we already
have, and how random the zero-sized read case is (even though we had a bug =
in
there) - so protecting against this particular regression didn't seem worth=
 it
to me. I'm now including the test in v4 but if you change your mind about i=
t
when you see it in context, let me know and I'll take it out.

[1] https://lore.kernel.org/bpf/CABWLsevk47Xa1a+h0UK--94zEuxScrmyt0-D8YShq1=
UgvVvf5g@mail.gmail.com/

