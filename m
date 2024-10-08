Return-Path: <bpf+bounces-41181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49567993D96
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 05:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089F4283CD5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D1454907;
	Tue,  8 Oct 2024 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAKaXEKA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64020481D5
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358789; cv=none; b=t/dRWmU/bVChyiuQdOSxC6kAwWZ7ARxcXyFqR6CG3cqJGzpGp8Rj/xcYN1Kw4WW6qr95OuZN9HCYgQwnqiWhSWarf/eC7J3DnYC3mobOo0tudNKAaiJREx2DlZzWhWF9NLw2g4C+oikDh1znXdMOBVWkqTBJC4dDlT75RKR3t1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358789; c=relaxed/simple;
	bh=hdeoJPIG+tl/jPMPdpcl9JHJ20st1n6S1ASmhGS8l4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fopW+e1DEcNJ+XE6jxy2H0THsDh7OQ6EFlly4z9+af6JahDY7TAj6r1slhnET7CBI2GjSx5tVp4QLZEP83bTMAdMq8aR98/TxkzcQO1YQ204Ew9MiLMGqQN8IpSfj8J1k9nAQMx/Z9OVwQ1tmevhflVKLNVmaWL1hbpVoQLDVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAKaXEKA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b64584fd4so48952605ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2024 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358788; x=1728963588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdeoJPIG+tl/jPMPdpcl9JHJ20st1n6S1ASmhGS8l4Y=;
        b=DAKaXEKAxoULesj1a0VokTjk9PdfNVUBO0KiIGgp3FLK/zRH3+FjGEXrbBdn1Lp/cY
         0wnMTa2vpr0BhLsKD/g9xRaufP/9bwy/Fy1H3Wfl/7ojBZf/GrcART+k2X1mfy46+eD/
         kcOLYInUGrAB+xDreC3DsoOjACmLln4B1uNJyeHGhrvXjLZ67wj3cLehM0v1ZXrA90Pc
         6qu1Gp2QQeQyItU0ArnXgTZtB0x59zcRjIIHwYrgUkGTWLKonr/5SERkU3OpzHJTVXnP
         X0kEi/0HaHqT7pQqdcJ6SJeQ58EdO83VurIrrYKFGNPGdkKrsYcxjBPsh6k1B/iFlq+p
         gVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358788; x=1728963588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdeoJPIG+tl/jPMPdpcl9JHJ20st1n6S1ASmhGS8l4Y=;
        b=CsxsXFwa9tQNJkkocX0i5YQX6QRxhLiHkCS/xVVstL5lCLRPU1hJ+TtiXaYYKG6J8I
         o/f/wCYvbYXTT73wE1vJbeKn9ZGT1RLWQvUodLNNgQe69ux5QfpJpu8Drvla5Z3bcovc
         yEAQgHvFsWg4dBWGrXrBDDrf4UNYlzo5PzjA0yG3nbRN+X2KBq3sdVsouwJjecnk5hBQ
         /TVeH1Nu3hW0lHRGlGlOIzj/Psj4+N9zuXGVSyASrKs16Zw7Dj/Ss+bdS5GIgW6yT3hx
         YHDC2b3ftqTHwgn7qasjGoDy2Dtt8dCIKXDNvfPUQq1r3kitbMbetFq3NE6ab7X+AWtK
         ME7g==
X-Forwarded-Encrypted: i=1; AJvYcCWL9Q+FzN5Q+kFPypUmVwGMrSCBl6tyNCbCgBWoz8Mk9eGIA6TgQiUMaLaqNEwzgoM736g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2JMVQaMBeSn3TqI9SXOVbVgh3LMAzbaao2do9yZ7UfQkxFTl
	jQsCAiagfEulLorTl3kUzZ4u1I0Ja7m8qJ/q2EMuPWZ4JMzEAGUwhLoOK5jKZ0Eci1tL99mHDSL
	81aBOieHRvXLSpDalc8qBULweRm0=
X-Google-Smtp-Source: AGHT+IFDPfKvUiSf4oqpK2fKreZtnGNC6yFPaRDyFIhiKi3E3nx1pYEwJ6nhF4kmpn07yJT7N+VyHyR8C/zSgrVdjOo=
X-Received: by 2002:a17:90b:3145:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2e1e620f0ffmr17620925a91.3.1728358787669; Mon, 07 Oct 2024
 20:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003210307.3847907-1-eddyz87@gmail.com> <e5ef86e9bed0f3e1f4a7ad81301e0fe0a0063bb2.camel@gmail.com>
 <ZwJGfZvfH/8rKAsK@kodidev-ubuntu>
In-Reply-To: <ZwJGfZvfH/8rKAsK@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 7 Oct 2024 20:39:35 -0700
Message-ID: <CAEf4Bzb79W-_XKjR0DibhvfLrHCVZHA_ofH0sVYZoTVYdxdNBg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix backtrace printing for selftests crashes
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:12=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.c=
om> wrote:
>
> On Thu, Oct 03, 2024 at 02:07:23PM -0700, Eduard Zingerman wrote:
> > On Thu, 2024-10-03 at 14:03 -0700, Eduard Zingerman wrote:
> >
> > [...]
> >
> > > Resolve this by hiding stub definitions behind __GLIBC__ macro check
> > > instead of using "weak" attribute.
> > >
> > > Fixes: c9a83e76b5a9 ("selftests/bpf: Fix compile if backtrace support=
 missing in libc")
> >
> > Hi Tony,
> >
> > could you please double-check if your musl setup behaves as expected
> > after these changes?
> >
>
> Hi Eduard,
>
> I discovered building for musl has broken over the last month or so, and
> it took some time to find fixes and workarounds before I could retest.
>
> Since glibc execinfo.h also defines its functions as weak, and given the
> linking issues that can cause, I think changing the #ifdef as you did is
> the right approach. But could you leave the fallback stub functions as
> "__weak" like before to simplify overriding in the non-GLIBC case?
>

I added __weak back while applying.

> Otherwise:
>
> Reviewed-by: Tony Ambardar <tony.ambardar@gmail.com>
> Tested-by: Tony Ambardar <tony.ambardar@gmail.com>
>
> Thanks,
> Tony
>
> > Thanks,
> > Eduard
> >

