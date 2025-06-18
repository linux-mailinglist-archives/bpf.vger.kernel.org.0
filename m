Return-Path: <bpf+bounces-60935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C26ADEEAA
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C911BC276A
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5012EA73F;
	Wed, 18 Jun 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejdLIVvk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7F2EA73A
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255181; cv=none; b=mNl/FNJDhErWZRhss2bvSCUE1sh8lts38YmOeqcE+uyMZAuA21a82TLFp0iiUCft2wJjbl2ZFPxASCdSlR7P9kwYayZiI1Mh9Nc+mEwIORQNTJbul/R6iAQSKaOOMQH+/ofC9AP1I5yd5aIYLu2bd/pJB3v53S6IToEY2pcUasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255181; c=relaxed/simple;
	bh=0jhX121PJ0dBTvbWL21hH6KHQPIUoJZmTDj6NS0hdSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtamXzSvJsiWMDVgMj6cafQwocrCDYGoPHTokc1cGap83lZw++JvecJ4v+AyXEidy6W1zh513xu8CKk2ha0akvOiOZohc4yCNIFvpHy0Q6LgKDz06y1Uc5Dt+BYQXA5kBgVdV5kO6oJLftvoM/6zBIkd68V3PzCK79XNO6UJifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejdLIVvk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so47137895e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750255178; x=1750859978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXhsPKZVkw0GGM+DC/QK8U6SwphTNx+ZbEe+kETdl7g=;
        b=ejdLIVvkPZEvilr4K+xMfKpAFmAaEU0dUqjmcZ7QoGXdyjcMZDpwvYxzNK8mmRKdR3
         O/UGrQ7ibgLVy2Xmo8NiTn/4V+mqPEmcYor1aflvEAhSW3en9W2bRUEakkCVO+Rs4Bmp
         Eoihea95Hh+Id1Mt6uX4P/wkHxoHfen1ZRfCkv0uDGpHtaoTjDLfDFO86RwqDRUH88IT
         o9RjWbGp07XFWpyp/mFVV3bIs8BVcBck0NRAOVVFDBdf+Nr+v+UyzeHcxAalt0h8DDFc
         HCDsaNNlYCuKR8JVvGDXiA6Vd7L+woTtmCd8AerXH6nlD5/J/AYiniUa4RuZ/pIzzQod
         n52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255178; x=1750859978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXhsPKZVkw0GGM+DC/QK8U6SwphTNx+ZbEe+kETdl7g=;
        b=xUfvYSGBzjM8FONMIGPpUUJNLe6WdFii7RkZAGB70TL8Jcrf0/d7JuCLDa3mkW9X12
         +EfnS7hDyhEbbZH9Huvm39klrw4CUTgUUVIpihFNSDWhlAKiANqW+YllZm+dLVp5kF9R
         tJFo8X949o32uNC3LrH3cFU9mBE75VO1mUh5jQMfUYyVKITZuaGwt3Y6uGx09G6dygat
         882hShh4/LVvTi1sD4QmTycmkH6wYakJ8VSwhE4GDEWi3MqohWCV9cEtSnyuUz+5BzW4
         6xoXqb235GwQGFiiCe8jU0Umjsw2VM7mIVEECq8n+fzkgqc1U9nAuuIzu1U+YqJ+ZQ3U
         NyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYEK4vaEAgwZaOXFCnKKkka47Kg8YHxBIcS0ddvjFvHmwj9IyIODzI+YQXV/wGN/oKuq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+2ujW9lK1o6CwNyTP4xOU7zDbFv5Jm4nPg6qu3NpRHfnoG9pY
	oziyuYaJnCOYephjRRSW4Ts+vY2h2uDGbHleY3/n1pWA1O7s97/Y6vnERpJmiHG5xmmccw+cpe8
	ou/khRb/KA9RvYTVnLgGpxriQfvi3Hso=
X-Gm-Gg: ASbGncvt2zUf27N0J6rwvEghKhrtzhZF4SESxw0GOi07lP1jFTQF7D7eje6TCIb2VCz
	u+3MB6xnKj7BtZlNdtujpXuJ9yv6JKE/9Nli9i5agZ2K6OTSoD52Be5Xz/vW31/td4NjWfWiKQL
	vnVN1pKIg+OZTiG8y2cwQLVKOwbgZsONFKuX5b2zP10IYTOt0LnNgf0JhvZMOAwqf7tx5V4gFs
X-Google-Smtp-Source: AGHT+IGsj6QjonoizBbZmawzOGIEPtMcPFpNqwk/9LEVErbt1mziR8i4Mk9eNoWePe7JwI5h4t2sJdvbPNZa1nykj0M=
X-Received: by 2002:a05:600c:8509:b0:450:cf46:5510 with SMTP id
 5b1f17b1804b1-4533cb53b27mr161361355e9.29.1750255177751; Wed, 18 Jun 2025
 06:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-7-a.s.protopopov@gmail.com> <5be2b20d4190e6c2aed7386a350bccc3eaa79535.camel@gmail.com>
In-Reply-To: <5be2b20d4190e6c2aed7386a350bccc3eaa79535.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 06:59:25 -0700
X-Gm-Features: Ac12FXz77frofR1234IEqqeuBLk-sLPGtJfnafuEdavuT69Vmw_uoqaz1nL1i2Y
Message-ID: <CAADnVQK-aW9kt7BdZdB=ryPwo=_D_dQaAYL+GVcUPAVGAcBoaA@mail.gmail.com>
Subject: Re: [RFC bpf-next 6/9] bpf: workaround llvm behaviour with indirect jumps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 4:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> > When indirect jumps are enabled in LLVM, it might generate
> > unreachable instructions. For example, the following code
> >
> >     SEC("syscall") int foo(struct simple_ctx *ctx)
> >     {
> >             switch (ctx->x) {
> >             case 0:
> >                     ret_user =3D 2;
> >                     break;
> >             case 11:
> >                     ret_user =3D 3;
> >                     break;
> >             case 27:
> >                     ret_user =3D 4;
> >                     break;
> >             case 31:
> >                     ret_user =3D 5;
> >                     break;
> >             default:
> >                     ret_user =3D 19;
> >                     break;
> >             }
> >
> >             return 0;
> >     }
> >
> > compiles into
> >
> >     <foo>:
> >     ;       switch (ctx->x) {
> >          224:       79 11 00 00 00 00 00 00 r1 =3D *(u64 *)(r1 + 0x0)
> >          225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo=
+0x88>
> >          226:       67 01 00 00 03 00 00 00 r1 <<=3D 0x3
> >          227:       18 02 00 00 a8 00 00 00 00 00 00 00 00 00 00 00 r2 =
=3D 0xa8 ll
> >                     0000000000000718:  R_BPF_64_64  .rodata
> >          229:       0f 12 00 00 00 00 00 00 r2 +=3D r1
> >          230:       79 21 00 00 00 00 00 00 r1 =3D *(u64 *)(r2 + 0x0)
> >          231:       0d 01 00 00 00 00 00 00 gotox r1
> >          232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
> >          233:       b7 01 00 00 02 00 00 00 r1 =3D 0x2
> >     ;       switch (ctx->x) {
> >          234:       05 00 07 00 00 00 00 00 goto +0x7 <foo+0x90>
> >          235:       b7 01 00 00 04 00 00 00 r1 =3D 0x4
> >     ;               break;
> >          236:       05 00 05 00 00 00 00 00 goto +0x5 <foo+0x90>
> >          237:       b7 01 00 00 03 00 00 00 r1 =3D 0x3
> >     ;               break;
> >          238:       05 00 03 00 00 00 00 00 goto +0x3 <foo+0x90>
> >          239:       b7 01 00 00 05 00 00 00 r1 =3D 0x5
> >     ;               break;
> >          240:       05 00 01 00 00 00 00 00 goto +0x1 <foo+0x90>
> >          241:       b7 01 00 00 13 00 00 00 r1 =3D 0x13
> >          242:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =
=3D 0x0 ll
> >                     0000000000000790:  R_BPF_64_64  ret_user
> >          244:       7b 12 00 00 00 00 00 00 *(u64 *)(r2 + 0x0) =3D r1
> >     ;       return 0;
> >          245:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
> >          246:       95 00 00 00 00 00 00 00 exit
> >
> > The jump table is
> >
> >     242, 241, 241, 241, 241, 241, 241, 241,
> >     241, 241, 241, 237, 241, 241, 241, 241,
> >     241, 241, 241, 241, 241, 241, 241, 241,
> >     241, 241, 241, 235, 241, 241, 241, 239
> >
> > The check
> >
> >     225:       25 01 0f 00 1f 00 00 00 if r1 > 0x1f goto +0xf <foo+0x88=
>
> >
> > makes sure that the r1 register is always loaded from the jump table.
> > This makes the instruction
> >
> >     232:       05 00 08 00 00 00 00 00 goto +0x8 <foo+0x88>
> >
> > unreachable.
> >
> > Patch verifier to ignore such unreachable JA instructions.
> >
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
>
> This should be possible to handle on LLVM side, no need to deal with
> it in the kernel.

I think Yonghong already looked at it and it wasn't trivial.
I feel I saw this pattern with x86 code too, so it may be deep.
The kernel side workaround looks trivial enough,
but if llvm can actually be fixed then it's certainly better.

