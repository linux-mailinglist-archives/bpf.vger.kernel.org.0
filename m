Return-Path: <bpf+bounces-52442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE3A42FC9
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E7517A2B7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51511FBEBF;
	Mon, 24 Feb 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyNOwPKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6521DE3AD;
	Mon, 24 Feb 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434902; cv=none; b=Dw3Ji3sO0OxsLS5IMOO3EMZFUWGLCvhsNZZPMoUlXWAAnkTYhonv6A/kRXzILL69QjnorzCKjOLMo7UyAwCocHg2461tbkQhJ4ftFDuDfESucCIkK++eGavl14bT61DT9gETDGoNFtCszzoHXlfAecWEarhzoURWNUKXE1/q2Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434902; c=relaxed/simple;
	bh=BiUGPgW/xQuplz2NzaQAzErLtEmTxPAlsm7wIiONLQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltv0KHHdk8w9PPAl9sf2DCzG/DRscxNhpPooxUKsm+YnhCgZpPfmKXDvqjlKZSjfbxQD3lwchq0bvhtvXX2wQtgff2F/va1EpBegk8GTHySb9a9w+L3uOLzfQi4qwcnwTh9GsMohFI7mb2PinOVHPNQZBMAOlM1PGnSrlha4fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyNOwPKj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a317e4c27so42488281fa.2;
        Mon, 24 Feb 2025 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740434898; x=1741039698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oaFYm3uznORB4542Rq36b3rymmLdKUYeu8YPMsf53M=;
        b=HyNOwPKjondew7yb1bHN43m8MGuOSI8Ghf+xP+dBnwxFz0+zDzPSJC5fDp/jPeNtk6
         IVzunnA9M0EpyNE2laj6zOI790wSPUMEnZCBFW/lf1kXMd3ETKGixWXDE+86qR8W3m6u
         woePfrPkJKvVuw7dJAPPE1tuNPigDr537F19WqV5ZXMcymcWbRv5LKK1d0pcW86djhk0
         oA6USIYsZXU1CUtIZNOMCvZuHpJqmafGlQQUs5AiQ5E+2E9ejtvvP8liQKykBs8nAzxI
         f5EVzzhLwJ31Q6Hd4X881uszj4n6WQQ7MpRjrVwKjEO9zxMaiGL+oxL0u1YsnuAbIJ4M
         MS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434898; x=1741039698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oaFYm3uznORB4542Rq36b3rymmLdKUYeu8YPMsf53M=;
        b=W0SeLVJrjNCH5m5WAw48o6q53gamXiHfY4k7n0y3g9YDu4tetRIqBMH65iGhKOdGMc
         GXOXMD9ewiOSA2grSJtPwQYuB3gY0JESZshkEnPJghVGSaph+55Ja8sRUtstlU2hJjka
         kTKvPwTv/ZyQrhv5ghk0V4WZtYlzt1lZ1/sQR4SIo9dxO9eO3CXOYz2fh4TMu6/r7TYi
         fOSPA/FO2tS0PH8/wzW6UorKPf04sQVdOF2YnHad9q/ZWrHEgpidu6+OoTqau4RIMW5O
         e3wd7TF2PstOabKYWv+yIvbMQx2KbXyQtJ1YWjPFs0N7aHk1IgiyeYuoyvNNDB9N8qxV
         xPxw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDZT1OM0jz4w3bTUXhegyrD5SBJuVbYMIxdHt651vJxVxNaQ1T7r6X9KgXd6wXA/T0u0=@vger.kernel.org, AJvYcCUb9xE4fj4k8C9XeX6XqL4gGNs6EI5kO4Z5MAxO38fPx7VzjbrBKnNU78nolxm4b03bA2dWdSFgbVVuJIg=@vger.kernel.org, AJvYcCUuncLO8qzaKriuBy1l/S0XLmyKGWPWJ9g1Hsqvx5O7q7zeFQ1oXcexhVEJ8eYmpGN8c32ZGEhWLB+TwxDy@vger.kernel.org, AJvYcCVDAYLrClcJJuyMXoTjWSwYTo3i3Bky0lcE7lP9Y5/p4incvn7amGIVR1OzIzShyn9XLYY95RJE3cEvbjCU@vger.kernel.org, AJvYcCX58taI/5cDPvgZupGCLoX8dzOkTALjd0d8wqKBzFWeY2FTDSqcM9S1pjpx9+OoTW/tVaO8AMxv@vger.kernel.org, AJvYcCXBpcKvGoTaAhxU0uN9zxE4wLU5IelmcPCFkRZmO0oBxheujqIcxiDe7EUu9d9Z+l48OuKBmozVGtfpGH3f80s=@vger.kernel.org, AJvYcCXFmMri7qdpl8Bu1sbtR/qFg+quJl4Q/e6aSO5eeWlPEXeXJ9pdkpFWrUYSVlvYt7Wwaod14x5K9BkbmNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzul/j4uceZYbriBnG7SlVH2UoPOuLaKehlHrrbX+9ce92KnyPH
	HkZo5fFzgdv15inH5n5CY3Q1FEkJHy0dp6FRYDrwixFIoxB/J64Z91AcpUD/B7/5X6XHNm4X9yN
	aBSWBQ4mY9cRLg8eGesJghLW2PKA=
X-Gm-Gg: ASbGnct2Ek9S+nOp7XpvmZOQMp3FBLYI49/U4OWKX3S1of8I4QIsQfyX2VsTNluv86Y
	mhIai0O8Q+BXc1tPSab9W/Uf5IrfrsiOvV287LU6r9AQOGcp+DQQXXNDoyj16n3hgM0hJPQXFVG
	oWE44dwTY=
X-Google-Smtp-Source: AGHT+IHVkIuUFpCDrTU0uvA7Fgx58+MbAWd4iAmh/s9u5Z4OX/tBnfLt5fF/OB0IUp1t1TAS/xkQrlAynJ4vLhos6iA=
X-Received: by 2002:a2e:8713:0:b0:300:1ea5:1655 with SMTP id
 38308e7fff4ca-30a80c2525dmr3121091fa.15.1740434897401; Mon, 24 Feb 2025
 14:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-4-visitorckw@gmail.com> <d080a2d6-9ec7-1c86-4cf4-536400221f68@gmail.com>
 <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
In-Reply-To: <e0b1c299-7f19-4453-a1ce-676068601213@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Feb 2025 23:08:05 +0100
X-Gm-Features: AWEUYZk0kdMcSa1NJ7f-FEs-56xLQUiW9T9ljXTGABrJPIypOLr5b30gUzs5pw0
Message-ID: <CAFULd4a_AnP4iqgQs7a6xAsnUFL8oZXxFcAWLmZFMm6MPF_zDQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] x86: Replace open-coded parity calculation with parity8()
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de, 
	Ingo Molnar <mingo@redhat.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dmitry.torokhov@gmail.com, 
	mchehab@kernel.org, awalls@md.metrocast.net, hverkuil@xs4all.nl, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, parthiban.veerasooran@microchip.com, 
	arend.vanspriel@broadcom.com, johannes@sipsolutions.net, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com, 
	akpm@linux-foundation.org, mingo@kernel.org, alistair@popple.id.au, 
	linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mtd@lists.infradead.org, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw, 
	Yu-Chun Lin <eleanor15x@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:56=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On 2/24/25 07:24, Uros Bizjak wrote:
> >
> >
> > On 23. 02. 25 17:42, Kuan-Wei Chiu wrote:
> >> Refactor parity calculations to use the standard parity8() helper. Thi=
s
> >> change eliminates redundant implementations and improves code
> >> efficiency.
> >
> > The patch improves parity assembly code in bootflag.o from:
> >
> >    58:    89 de                    mov    %ebx,%esi
> >    5a:    b9 08 00 00 00           mov    $0x8,%ecx
> >    5f:    31 d2                    xor    %edx,%edx
> >    61:    89 f0                    mov    %esi,%eax
> >    63:    89 d7                    mov    %edx,%edi
> >    65:    40 d0 ee                 shr    %sil
> >    68:    83 e0 01                 and    $0x1,%eax
> >    6b:    31 c2                    xor    %eax,%edx
> >    6d:    83 e9 01                 sub    $0x1,%ecx
> >    70:    75 ef                    jne    61 <sbf_init+0x51>
> >    72:    39 c7                    cmp    %eax,%edi
> >    74:    74 7f                    je     f5 <sbf_init+0xe5>
> >    76:
> >
> > to:
> >
> >    54:    89 d8                    mov    %ebx,%eax
> >    56:    ba 96 69 00 00           mov    $0x6996,%edx
> >    5b:    c0 e8 04                 shr    $0x4,%al
> >    5e:    31 d8                    xor    %ebx,%eax
> >    60:    83 e0 0f                 and    $0xf,%eax
> >    63:    0f a3 c2                 bt     %eax,%edx
> >    66:    73 64                    jae    cc <sbf_init+0xbc>
> >    68:
> >
> > which is faster and smaller (-10 bytes) code.
> >
>
> Of course, on x86, parity8() and parity16() can be implemented very simpl=
y:
>
> (Also, the parity functions really ought to return bool, and be flagged
> __attribute_const__.)
>
> static inline __attribute_const__ bool _arch_parity8(u8 val)
> {
>         bool parity;
>         asm("and %0,%0" : "=3D@ccnp" (parity) : "q" (val));

asm("test %0,%0" : "=3D@ccnp" (parity) : "q" (val));

because we are interested only in flags.

Uros.

