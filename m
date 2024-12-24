Return-Path: <bpf+bounces-47577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF239FB982
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 06:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683507A1C9A
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 05:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4D13C9B8;
	Tue, 24 Dec 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIN4VmuO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896D442C;
	Tue, 24 Dec 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735018515; cv=none; b=TJsfLeqkwTan0JQJrMNFUIsHqOaOpWIl0wrag3o5oCBY5Ip530JaiYk/n3TZHgFqSjL217kwtPeUuK49qB8NXRSRVVpw7qCbhEdd9OyePn3LY0TowNt9CdqFkmwO5hApigKmRgn0CkAbevBI0cSB6mrFu+W07T3mvwTJV3+6Neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735018515; c=relaxed/simple;
	bh=tebLfu/Dgr/fzLguBH6XDKYoyngQbPNPZqwRMdIXIvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSx6l70NqE32vP0WS0mKllYOR0teZlo7d1LGitIteNDI/ClusljOn2eGcRbf07ZZ1p91L/nUOd2cwVX0aPp5B91pE5ys+hP/eirndv9Wp5+COT83kV4+lDorAPemkAkYfVjctgLMfhc3OgIqZ9/a19+n3jrwpOlzKWsCs871CJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIN4VmuO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f664af5so54591195e9.1;
        Mon, 23 Dec 2024 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735018512; x=1735623312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQlBXCEUmzv8lWxyvVDxWH9zT4I4ComuM9TDDd/Ti3M=;
        b=TIN4VmuOwfb6yCsPKOOaJfxUCWtuc4slLPNIHWcJpRzY4r8p4nO2gNquC1Grs4PF+N
         0W8khs0ZEwV98ZH3dQAmAlTeVhzQtilLDJD1hDyXIUA8OsZNpQYn1TSgJigbaB8rT2QZ
         yT/UGqyU/iV+O+d6MRZSihGSMcuej5LAhvJfx/z4tPw1DW61Dbu8yT5x76NGPaZ34nP9
         c+TKh0TJQGdDa/sUh15d0E6XTOTvFEqFbazVo6XRMOvlwHM1yz1QgOXY7R2juR1MSsaM
         k6stLNJMSVnpVPI8q0ZYE2QcAkFcp//8wM3mCIamyLhlsuUrZnHx/+oGjw7z2XdHzHyx
         ozMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735018512; x=1735623312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQlBXCEUmzv8lWxyvVDxWH9zT4I4ComuM9TDDd/Ti3M=;
        b=dEhTOTZGvRbEFNBabgTGrW6vhNNaGRp652UxXAiIwfIkGcbbaiYO4zZJnQax1CAfvH
         mKpU6v+korcq3q8G2zbYoKu5bPP32XFojichtFMuGPBLVno9LBmEB81RBEdFmHM5LImG
         vwnHCir0mBW5bCw7NmiGh7Onvk1EHlmRJ7ZqGa045p3ZFGEHaGI8vqXGXmz2t7JHQ+Np
         Mfh54RJS0lCsHoxGceeuPDBSoyHt0NTzoIQJVqOcBElF84ECKO9HbFRaMWeXo3P5kF3c
         GEjSVysQmxdNzBdvYs/EaALzlQYR13Yr1sW1ahEZ5ksDfmNQkLOV+Ztm1uNG3Q5zefLT
         Ogdg==
X-Forwarded-Encrypted: i=1; AJvYcCVDGbbZb+ddkQeooOs6pjtq3QESJ8ZJGMPYYjbrRJoLQeTTU8HwfZ7kOHqjEltC0xF1BCnPaO070LxexC5w@vger.kernel.org, AJvYcCWzZK+TQMjpMtcsIpESPEbMqyNC30fOLr2qgFkAu6joDCPjRu9gVSGNk6CW2SKaXspBKLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8E7WHvarw8l5EZJLHL/VDWsZcD1OKi5hZ6zJoy3qDlCVzZ+k/
	Aq8yV/PqxTVnx2AuV4x88L+axQAcGciJ7pvguM3664EJxCsfiRQHI/ItfrBi7sQxGWBtG/OAn4o
	hVxHv3apnl8OSQiZKx8XynGDsL7A=
X-Gm-Gg: ASbGncurRvJsk8sP3MkUGI6yFf6Qk1yK4f3TNV/oCCSTxfWqApgBmR3O1YD+rHoQc0o
	UCZqQzK2xdEaveoSjak6VCtvVag1CqypIzN9ucA==
X-Google-Smtp-Source: AGHT+IFsTJQW4ncOun/0WCEJtW22gwwamwFXwI4nx4kprLWqf4hESSPMXrHfFMbR+XujGXfH4cKK/70atRv3SaCWWEs=
X-Received: by 2002:a5d:47a7:0:b0:386:4034:f9a6 with SMTP id
 ffacd0b85a97d-38a223fd8d3mr12790887f8f.57.1735018511452; Mon, 23 Dec 2024
 21:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221210926.24848-1-pvkumar5749404@gmail.com>
 <CAADnVQLC0hNpg_M_54netES5Q2ugSSULcSMzFPGcPG2aLCH8=g@mail.gmail.com> <CAH8oh8W_j3-yc9oyOa4mck_6kfFb6i_-ZHpYnkweajreyH2G4A@mail.gmail.com>
In-Reply-To: <CAH8oh8W_j3-yc9oyOa4mck_6kfFb6i_-ZHpYnkweajreyH2G4A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Dec 2024 19:35:00 -1000
Message-ID: <CAADnVQJGePgEdvFFMc8XrVqHywWJ442teMnko5m2dPqvsPRZ5g@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next] BPF-Helpers : Correct spelling mistake
To: prabhav kumar <pvkumar5749404@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 2:07=E2=80=AFPM prabhav kumar <pvkumar5749404@gmail=
.com> wrote:
>
> On Sun, Dec 22, 2024 at 5:17=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Dec 21, 2024 at 11:09=E2=80=AFAM Prabhav Kumar Vaish
> > <pvkumar5749404@gmail.com> wrote:
> > >
> > > Changes :
> > >         - "unsinged" is spelled correctly to "unsigned"
> > >
> > > Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> >
> > Are you trying to land a trivial patch to get on the record?
> > Please focus your efforts on something better than typo fixes.
> >
> Sure Alexei.
> I wanted to send in my first patch to know how to work with open communit=
y.

First patch?!
Your commit fb0f02308126 ("selftests: net: Correct couple of spelling mista=
kes")
landed in Feb 2024,
so you clearly know the process already.
Stop abusing it.

