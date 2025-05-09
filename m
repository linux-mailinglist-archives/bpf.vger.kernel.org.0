Return-Path: <bpf+bounces-57839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456CAB0A62
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 08:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092793A898A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 06:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA526A1AF;
	Fri,  9 May 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlg6bZ/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B822D9E3
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771369; cv=none; b=pPM2h6vRWAgaTZnw7H6NArrPhx+75ubb/7PODhAfwXbm+OoTwGnPMJEQU9FPWcyXHqcNbRUYsfww/vE7Rr35Km6iybrNHQJyNYqtZ1hCjuq13IZxU2hM6u88qKGfZTL3xW2vhxJMWI9qDB59wrYRzQ8dIuUOh0YtGfaCc0Rq4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771369; c=relaxed/simple;
	bh=pfgZwX0aDLhg6MGImReuPHMvnnTq34AuZwqahUBvMGI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcClPZuFVVZojlGwgTmFxhMFzySugMutqP3I0OYbwhBtKTbjO/Szoa+/qPTtxkTCEwtlKRXVevl0ynQK7UgkB1gZ/Kb7yW+qSWdCi5yONHrj+qCfQ0Kn8tzK34AukkC2JEEQ/o4gqHzmEvPIbDIePFqRnQkSP89dlxrMjtTlBoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlg6bZ/a; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1356470a12.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 23:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746771367; x=1747376167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITXIoTgfoq99WMccxezLbMzcJALvci4tIWZBDJrEkEQ=;
        b=nlg6bZ/a+kJ4qJ8PsLFgdFxDg8DURsrgl86IUqTO126qr1NUiRyzDbEMix4j6KewvZ
         Hg2ltLPwIpUH/8XPuF5wis0Iqr73y55Pawh9HkCoLo2tHbz92AWe4fGArdmVdeTcW6X/
         Ffg3n1R2QKa8mveH0g7BaW3xmX99zfejoGi3rVL7UxVwsYZfhY/c+Pw72WXIIXk2uhT1
         rQT40b1VvN14uoLNJf1ydEdSTfsqzrgO6usmJvKMgNWxmvFKuXYMimvtvDEbYupnNvxb
         kczvwRU2S1xFSUZpar/1LN18iMQC8vYdaoxsTM92e04jTYBgW7/D7LLnZB4nFdEaJAGA
         Qxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746771367; x=1747376167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITXIoTgfoq99WMccxezLbMzcJALvci4tIWZBDJrEkEQ=;
        b=Rc9xTii0dRnTfyw3hE0YjRx/fvyXOEgxoSoU3als4gF2BqVlsFzpU7qvzFPXpETzZ/
         B9jmH6hEytdSrBX6wtA4kiksSTxRjGyai49yYQtx7xwqX16LWHmiR1Lf6ZnzEuRQipsc
         stGHnrttY7dcEmnP+nieKt07hhXUQWMENKvIoX8j41Y8SW+J6BaIyH0agddxX2k3kK+N
         STwaImbONpUr27n81eTImxB2o6BZuafqvUVhBV3mxmBeL/ddlNOl7S+AyKUSJBsJ4Qa6
         WY08ONcBSeP8+x6DgwhseFuhrnMOXj1zBqIOaYc4ceVPp2mvhp33hEC0VVeX91+HTwPq
         WsMA==
X-Gm-Message-State: AOJu0Yxh8IqWNDvArHatfGgGhEWJiaHkJ2TXI0aQpT5GDRqYrrggaoBr
	m/SB0YSjQcovib3jWCAvUUCaQ3Uy4pqsuvVQHPqwVsq8AJHOLI0q
X-Gm-Gg: ASbGncs6j6thLpbCMg12llGcD9UbBYcS8PIGUIA4+5wIDeDKlxojlHAeq2XMz7sXfGC
	Y73lH/VH/vkHUWRTzF+Pr9NGTosY9MYrjbPTZl9IirqvYEuWRgBq8WRK7obg46nDrhHoOOJ/KGt
	R4yE5QR1x1sv3/yZVAgompRpYquUCk7Ry+HoETuia4EeoiGarOyiSk3oGhYwCsJjEmZ4+w6dtIG
	YAVMYF1dR8C1T1mTlkipCTfQybspx1LmDMYgQ1RKH+kOO3dxLW8CyqyFreaj3drlUlPcf6BW1Bs
	qowP0pgSHHPbOQC7eC0R5vqcfExpAVtQRmZC
X-Google-Smtp-Source: AGHT+IFD+H6Y3A/E++iO14lz1rIr2Cxl8d103yOTkjF4VMni/+n0WaV4GyhRr+N0N/uJjC3heKfCfA==
X-Received: by 2002:a17:902:e94d:b0:22c:3609:97ed with SMTP id d9443c01a7336-22fc8c92601mr31153775ad.30.1746771366809;
        Thu, 08 May 2025 23:16:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829eb27sm9650665ad.208.2025.05.08.23.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:16:06 -0700 (PDT)
Message-ID: <a36c2910e77477af62b5ff03aa7f6e665babe506.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt Bobrowski
 <mattbobrowski@google.com>, kkd@meta.com, 	kernel-team@meta.com
Date: Thu, 08 May 2025 23:16:02 -0700
In-Reply-To: <CAP01T74ND3d=deo=YVpETG7HVfUf4rD21TEkJJmsByVS+BTy-g@mail.gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-10-memxor@gmail.com>
	 <82fa97637f995a1a004221b8d4e869e775a5f008.camel@gmail.com>
	 <CAP01T74ND3d=deo=YVpETG7HVfUf4rD21TEkJJmsByVS+BTy-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > > -#define ___bpf_pick_printk(...) \
> > > -     ___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __bp=
f_vprintk,       \
> > > -                __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf_v=
printk,          \
> > > -                __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, __=
bpf_printk /*2*/,\
> > > -                __bpf_printk /*1*/, __bpf_printk /*0*/)
> > > +#define ___bpf_pick_printk(choice, choice_3, ...)                   =
 \
> > > +     ___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,           =
 \
> > > +                choice, choice, choice, choice,                     =
 \
> > > +                choice, choice, choice_3 /*3*/, choice_3 /*2*/,     =
 \
> > > +                choice_3 /*1*/, choice_3 /*0*/)
> > >=20
> > >  /* Helper macro to print out debug messages */
> > > -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##arg=
s)
> > > +#define __bpf_trace_printk(fmt, args...) \
> > > +     ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##ar=
gs)
> > > +#define __bpf_stream_printk(stream, fmt, args...) \
> > > +     ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, =
args)(stream, fmt, ##args)
> >                            ^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
> >                            These two parameters are identical,
> >                            why is ___bpf_pick_printk is necessary in su=
ch case?
>=20
> In our case choice and choice_3 are the same, but for bpf_printk
> they're different, I was mostly trying to reuse the pick_printk
> machinery for both (which dispatches correctly to the actual macro).
>

But ___bpf_pick_printk is a noop if two identical choices are supplied,
so there is nothing to reuse. E.g. nothing breaks after the following chang=
e:

   #define __bpf_trace_printk(fmt, args...) \
          ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##args=
)
  -#define __bpf_stream_printk(stream, fmt, args...) \
  -       ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, ar=
gs)(stream, fmt, ##args)
  =20
  -#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(stre=
am, fmt, ##args)
  +#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_vprintk(str=
eam, fmt, ##args)
  =20
   #define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)

Which allows to shorten this patch.
Or do I miss something?

[...]


