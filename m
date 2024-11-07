Return-Path: <bpf+bounces-44221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D2E9C01EB
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 11:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5537B1F220C4
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E451E907E;
	Thu,  7 Nov 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LHevrShu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0A1E7C21
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974158; cv=none; b=VKV8BdERg6V0mBXw3lc/sJSOET3pMx4DKQOrE2dDQGe/ZByfXoYEKkNkriOjf38ehBur1VNWLWZvncw0q6RR7GCpoEUFzTzzu7iAZSfw0g7I6rB7uRShsQ52EXIlHWh/qAPSsB+3CZBksA9yVchRgnxt4Rkdaxb9ogPKYHDUZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974158; c=relaxed/simple;
	bh=TP+F9gIeVCvmoR+H+MTVsZugSnked7G2p8S7gJTNe+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPWAXRR9dRp58FdBsv3x2WXspV5MR70g5/SDfFo/v/zimHy7ON4jeoiLPFtSny0d/fnxZsYn1NZIrLigMGxr+wuqtUbN3n84TDWkqM91leL07KCBh+N8I5yxFkpfJGfJduBLxGqOM3xN/8AVq+rp7V6K0y1LCrOO6Q2uo1ss0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LHevrShu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so1031271a12.3
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730974154; x=1731578954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpDrSskUv1o1NTarlsHfGOMJt+ymu1r/HgLDqyVtDWA=;
        b=LHevrShuQwkpsacwC6pm6IQGGzxoee6JXcp2Yp+s64g1IkofKeMde28sAdA3sI18zc
         TVQHepuiVknRlu7LIZcRq/tdSNuZtvEghRIsx2HF3bcYCZtmZ8xRN891QqWZzPhWvA6i
         bNaZ4TBxsd12iSXb/5L4Qyigvta/peb40FFQpyKcKcZ6J+p6q/k8+wUIUz6dTfNXfI+P
         3pNrSfUIcnh1DiVBUAsk81AN/AKCSMo9EFIskgmLZ7VnVK6saH2T6Z486tYrH24VpC6u
         L5BOfAjKka9C9vd275E1JtKI7ghshelDDlEHrCeGVZAiXK0wy992LMB0AcZA9VrSKS5S
         vYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974154; x=1731578954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpDrSskUv1o1NTarlsHfGOMJt+ymu1r/HgLDqyVtDWA=;
        b=h2osGtZXX8p8dyd9pTYx2NuPMul1rx2i+Bu7e6/Nim53bVBt2bTBE251MykOUz8RYx
         x/t9RN7HLC9jZ91qR60IwbjOl7T8sVei6KaWQMUO5ivUiftnvKmY1NxhzFRzTuEJsrV2
         hQMSL9ygNNonn5S2MMF9rGAVyynsRADsGD92IEvS+O9XsSvtFhH36KweAoDc5d4CHzdo
         HXKtKc1vkSaM1QBe2jbZKm+uhG5JslYtsty/Bo79cvQzVgBqcce/ML4etIO/SG+8UNcM
         jYJcmCBXkjxi/elC0TBC2oFiqcsTWvInZhkwrl0R2HvOrcTlc7btZMmORXA7Gf693bL9
         OvnA==
X-Forwarded-Encrypted: i=1; AJvYcCXdYg1X5C7LJQNqfo3ySIYqzRiEJsV43qPu5bhUenoMTB0W9nOYK2WpnIWFY0HAWAI8wt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznv5IRVRp8wfsLjyvNX6xq4quh+YT4xQuSWVDgX2SBWQ4pnn/D
	Xc6tuZgxwF4DIE0u6kU6gRO6X88mY7JaU2Emr5Mw/SDd7P7b5jQ/oh26mdofZf1xKu/TfibomDR
	6J7QXb69SjBMjqdv5IeEq8OpjlCX5iZ8yizOjlA==
X-Google-Smtp-Source: AGHT+IERZV6Psk5Yyx4TfQfVXmINj5F1hDhQ/XqQ1JTLYObIeW3O+9WxU1vcOqYi3njcPAbsIOTANJXFovMSGP962Q4=
X-Received: by 2002:a05:6402:50cf:b0:5cf:529:1e73 with SMTP id
 4fb4d7f45d1cf-5cf05291f47mr741826a12.13.1730974154217; Thu, 07 Nov 2024
 02:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106193208.290067-1-bjorn@kernel.org> <20241107091307.GA2016393@myrica>
In-Reply-To: <20241107091307.GA2016393@myrica>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 7 Nov 2024 11:09:03 +0100
Message-ID: <CAHVXubh4A9JY2hVzYW0ES1QxfLL2iYczXBCcr5OXsrYoZcWJKw@mail.gmail.com>
Subject: Re: [PATCH] tools: Override makefile ARCH variable if defined, but empty
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Thu, Nov 7, 2024 at 10:12=E2=80=AFAM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Wed, Nov 06, 2024 at 08:32:06PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > There are a number of tools (bpftool, selftests), that require a
> > "bootstrap" build. Here, a bootstrap build is a build host variant of
> > a target. E.g., assume that you're performing a bpftool cross-build on
> > x86 to riscv, a bootstrap build would then be an x86 variant of
> > bpftool. The typical way to perform the host build variant, is to pass
> > "ARCH=3D" in a sub-make. However, if a variable has been set with a
> > command argument, then ordinary assignments in the makefile are
> > ignored.
> >
> > This side-effect results in that ARCH, and variables depending on ARCH
> > are not set.
> >
> > Workaround by overriding ARCH to the host arch, if ARCH is empty.
> >
> > Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> > ---
> >  tools/scripts/Makefile.arch | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> > index f6a50f06dfc4..eabfe9f411d9 100644
> > --- a/tools/scripts/Makefile.arch
> > +++ b/tools/scripts/Makefile.arch
> > @@ -7,8 +7,8 @@ HOSTARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e =
s/x86_64/x86/ \
> >                                    -e s/sh[234].*/sh/ -e s/aarch64.*/ar=
m64/ \
> >                                    -e s/riscv.*/riscv/ -e s/loongarch.*=
/loongarch/)
> >
> > -ifndef ARCH
> > -ARCH :=3D $(HOSTARCH)
> > +ifeq ($(strip $(ARCH)),)
> > +override ARCH :=3D $(HOSTARCH)
> >  endif
> >
> >  SRCARCH :=3D $(ARCH)
> >
> > base-commit: 7758b206117dab9894f0bcb8333f8e4731c5065a
> > --
> > 2.45.2
> >

You can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

