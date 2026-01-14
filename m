Return-Path: <bpf+bounces-78819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33431D1C24E
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BD43027A4A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9929D2FFF9D;
	Wed, 14 Jan 2026 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWbonpIj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FA2F6179
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358002; cv=none; b=QPZ2jNTzptvzG7tD/2YVTrGZadRldBGP+L0Me2g7n7gBG1oqqHS1xevmoGncuascoKDx5uiK/T3EgLgY1190wFLB75Wb3Gb8LKpHt4gy21qyUVopLrK8JjkN0dyaHy7z/8UVFLJdG7vgYzh80axXKTHVFEz25YJjYYq/BwUbyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358002; c=relaxed/simple;
	bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9ycDj+CSP60dvXhBzLU5LDHfYvGbUv9fqN4+EfJcXkMaxEB7kam7OyAIJu+hfdCYrWq2Iqd754z7sG0Ssmq6t3298C5f2kO5qiyVIxsgJtYupytxjIjPwNtbZ2aqU0l05gtzTiGE4D4nIIIMQnW0L9spTMysd/25nn72pdnTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWbonpIj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so1455445e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 18:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357999; x=1768962799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
        b=VWbonpIjDLDbRExTVQdvxGKLYEsrXx1rUlLKKO1JdnsJsFKxkua84EqOLS8Nv/n/6k
         QPd/xmXB+vHoL/350PPDEDuUSQj+JcNQQ9WIWBQhw0TaVY3sKXAkRtGhFBwECZrloEtx
         7GUajCNA27hEbb6PLwOCknxVrwG6lZ614Q3dHikepzBFVJJhw+JRHTKlie2zzRMgGaLw
         L3kt9rU1yPKndnMfXxOUDFUo/Uvb0oHDlW/6jEyTuO1CjQn9ug9Ke4/NAapw0xYmkXve
         p14XRMK1fC/guxLRtlcxbNInr72Boof2nDLENahbQxf9gO02uypJTvVvw6OQ9MsAMijS
         gFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357999; x=1768962799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRggPcqlK8vr6TJMrmO1uo72WruGYkSCXYL3BH+siBA=;
        b=JQf9GAefVDEZfHUBTBgtFUwMM2lTGioLF814Fnc8n+SF1OgE7ewakR4l0csT+SPFak
         P2PI3Z6W/p9x5FpqgtoLGrCPhHhcfC8oor0b4JtqqjUaRObdl8i3Yv9PU9nIPhQI3xDp
         4p5toiNuCoj8Nf6ucEQJPBh7Jx/trAX7gBC2T/0bUD3VKnlw0flkNkH26cnyCPG46s5a
         MapSUAzxJp+bYzEwxmDFtexsraN4lriShZ8OOIYkJ5HpJgiBg1/VnO2Z0aHIh0lO0aaL
         Om2qcvzUpl9aj681SnspKKz8fDB6g+aZxK76O/iPAzaOQ9KGB5lCnnSD32ATZ4HdyPfq
         nybQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx4xpezzFxzalg0YZl7gaiprS5xGv5+RIhK+dElFUXm6sG3NOttUkQBBBDhcMMPvuBAGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyNE0+1tKAURQXal718J4QoSUnftqszzna32yaHk19ciCjc+Y
	J9vSNPNGz6M1YzNC3IPsvNEOmv1VI+xvOi6EUAAJDQfjpbp7kve0lteDVePwu5SVvu/S0yJBn/B
	g7ICeD+juOP61NTvm2beCwhC87bwn2Vs=
X-Gm-Gg: AY/fxX7BM8IX16IH6vyLHDLPFGy8QamTWnRfynOok7wPD1i9WuLT87WtC2hoN+kRy/O
	FWqMUC9oSKy4BLUzUdo+8qWSwudGmvH3C//b2rlmb1CQ+2304QEpCUNlHvBh0a7MYxLxlmjkKqm
	yN2br16B++fyNXiAzhEgXCQDjoV96Uj+6ewwBvK5RQplJ48gKC+5/E9FEd1ydemdmtDx3Bl0Mhk
	/knTRr4oAi+KRu+7ViRa2ZrwKxSfHB5AC4/w33wXcGcvMGGKw1lbECehaCDqzL4nVZM2RBZEImK
	lWWDo9RAdTkFJ41KxOpfpDEAamke
X-Received: by 2002:a05:6000:2f84:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-4342d3912bcmr464347f8f.24.1768357998953; Tue, 13 Jan 2026
 18:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-6-dongml2@chinatelecom.cn> <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
In-Reply-To: <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 18:33:07 -0800
X-Gm-Features: AZwV_Qh9R49RHNFvHfXuQEMWgnFHcwmfCd43CnUckrigAg8jcAMO53P-h0Re3Q4
Message-ID: <CAADnVQJzkXysOO9jqdvJUYbe2t+urReRV2xWQ0L2z0qcjgxdcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Implement session cookie for fsession. In order to limit the stack usag=
e,
> > we make 4 as the maximum of the cookie count.
>
> This 4 is so random, tbh. Do we need to artificially limit it? Even if
> all BPF_MAX_TRAMP_LINKS =3D 38 where using session cookies, it would be
> 304 bytes. Not insignificant, but also not world-ending and IMO so
> unlikely that I wouldn't add extra limits at all.

I forgot that we already have BPF_MAX_TRAMP_LINKS limit for the total
number of progs. I guess extra 8 bytes per fsession prog isn't that bad.

