Return-Path: <bpf+bounces-22942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A886BACC
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F671C223E9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97672916;
	Wed, 28 Feb 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW2ko/Nn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A224C9
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159952; cv=none; b=ZmdObS35w5vwJw1IQ5TjEZm0tHTrLk0Xufml41JdDAJc04DE1FoVdCvTzedW5Omx9dhgrv50E1QHJbofSJ+qoEJ8yrpcdP5muOuzaNclhdaQAwbRakm78H3WXJDwJrdVJpcQRpKwaLyNtRSiVXHSgmpsnZ0bDXdxM7udAS4b7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159952; c=relaxed/simple;
	bh=6BUjiRtOQpvfVfw0wVmiZHlRdR/veVHBdB2QNYW/PPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKb0qE3c9jaOhUMw8JZVcR+yfIHc+SxxifX+Eg8oqnDFEBfMmjMrT23YoJN6dgrlOTwcZoL1paBMo6jZ+fidxxgyJ7I7iWrBEZSmZCljXajditIIo6Wr9L9j7ofVqQqC4I1G84p1ChrRBHBfibcbXA4Nv5z5u3gFPWlRJ8uQrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW2ko/Nn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so234796e87.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709159949; x=1709764749; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IjMnaI9tmt0hTLPFVcNUcQwHhGFWz3DPhSGaX3XIRuU=;
        b=bW2ko/NnNJCRwMa/3XLr9KL2j0PiQTDLL4lYldE3s9Yw/iIbh2M+RsK7HBRew1STn2
         ali+Ov9kZ3oeMXzyQswJmtOVNpxJ5DgyoQQR3diFtgFHQu/xdP8jrwxrpegaoJyux6hU
         VNm+t9OMfq4IAkv9Nj9pRYIlIwICmWetqAY0pZqc8nuvVkjg3zU2Nkp8mvieHC3UwSdo
         ctmhZo3YeIDROXninXhdVdex6XA+eyLMJaC1k0QRkkPgTPbdGMjw/TZEAYihOsKoNDL2
         9lOkiJUl8UFddNId8yh4RDfDbrVvNCzNaciLCCKzq7EyoyE1SqVJI11bGijbQjVrzP9D
         dO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159949; x=1709764749;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjMnaI9tmt0hTLPFVcNUcQwHhGFWz3DPhSGaX3XIRuU=;
        b=mx4Nqt9yAvX8xT7qKGE+cl25rX/Ut2VvCZYIi9OwrCz0m3It960d53zcPgiN6nzFk7
         KOmYIpzvFV0liwJyvaFYheg9KCItlpYxv5nSmZIxX/HpZG4sV+xBBrfa9m7lKvnN19zQ
         uTRnM1OhfgBlG7girfkxYqo//KXCK0Kbsr3svMljpszZUl/36wxsOPfrzM38TZ7AHBco
         GGKWXnnOM1fDmBAvrooMMOjLv/O2HoMdJ32/vyh/cc2BpzpJwha1T2LmDIa+5Pe3Sm8Z
         RjM6+fDfrOxPapxfi1LAQEm4MDrLVm0RNW4iEILMpRBnDh3RTSW6U+vvCeNn6HqsuzJT
         PXCg==
X-Gm-Message-State: AOJu0YyZDSoh2XUAwGAsrMnBpVGjT4PQViCAaq6I3qRuPw+JTeR241+v
	LDMrYDrYUncATdg/MrDmthervCsSDqeA6GwQsPIxBoXYmdc7fzTu
X-Google-Smtp-Source: AGHT+IEIuOS3uOkSf6njPRAbN6HjHWm7wfeHXiyM30TvGIYlgaxZGi5+0u7SfxhpRkjzGoovXT4gYQ==
X-Received: by 2002:a05:6512:704:b0:512:d5e4:1aa4 with SMTP id b4-20020a056512070400b00512d5e41aa4mr146416lfs.60.1709159948571;
        Wed, 28 Feb 2024 14:39:08 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512238a00b00513255d7d6esm4054lfv.268.2024.02.28.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:39:08 -0800 (PST)
Message-ID: <a7fc023a8c19d96448d7143292f5366b15e7a10a.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Thu, 29 Feb 2024 00:39:06 +0200
In-Reply-To: <CAEf4BzbRQRSDhb_qOdKBBx8r-qa25cTu29KWVdxBq7V6zEGfrQ@mail.gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
	 <20240222005005.31784-3-eddyz87@gmail.com>
	 <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com>
	 <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
	 <CAEf4BzbRQRSDhb_qOdKBBx8r-qa25cTu29KWVdxBq7V6zEGfrQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 13:36 -0800, Andrii Nakryiko wrote:
[...]

> I'd say it's not about a number of lines, it's about ease of
> understanding, reasoning, and using these helpers.
>=20
> I do prefer the code you wrote below, but I'm not going to die on this
> hill if you insist. I'll go think about the rest of the logic.

Ok, code is meant to be read, so I'll switch to below in v2.

[...]

> > static u64 linked_reg_set_pack(struct linked_reg_set *s)
> > {
> >         u64 val =3D 0;
> >         int i;
> >=20
> >         for (i =3D 0; i < s->cnt; ++i) {
> >                 struct reg_or_spill *r =3D &s->reg_set[i];
> >                 u64 tmp =3D 0;
> >=20
> >                 tmp |=3D r->frameno & ES_FRAMENO_MASK;
> >                 tmp |=3D (r->spi & ES_SPI_MASK) << ES_SPI_OFF;
>=20
> nit: we shouldn't mask anything here, it just makes an impression that
> r->frameno can be bigger than we have bits for it in a bitmask

Ok, I'll add bitmasks to field definitions and remove masks here.

[...]

