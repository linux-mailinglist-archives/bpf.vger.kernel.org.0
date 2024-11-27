Return-Path: <bpf+bounces-45737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCEA9DACBA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979EC2820D4
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11617201032;
	Wed, 27 Nov 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajp9kIfp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7C1F9EDC;
	Wed, 27 Nov 2024 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730006; cv=none; b=LUndqMRSeKqO8ekc9xQ/MGd+q/SI7HiijeZ/D6JlRYYLOndbCAO8AudjNSfdjb3bUss0KqJj+eevjOpmb4GmG70WPvhna4XFyScQeGS6OMuRdbwHDEieRE1pSNj4gIoMd9N8nXion0nEI8LBAtHQDITJNdcyhqRE1es5wboCEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730006; c=relaxed/simple;
	bh=XkJKEQScM1sUdH9+73haYCE8kwytnHB9fNAKE0pQerg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjde3XQsoJjxDRjmTuEZCf9V5l/Q67HV4qVVJtb+2JJR7kf0AWuLoCFREFOHYr6v46vkR4qgsuVLPQamFDH5Ho0k/Fa2jRUGPMYZ8X3/6hrPk/V2H7HhWa6PtGvG7p0kV3Zkfx2TR5AGV5z9dZHzO1uaPkVicasCOpdPa55ZU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajp9kIfp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so5237228a12.1;
        Wed, 27 Nov 2024 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732730004; x=1733334804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pBUdGR4bmi6T+Je5/dBA8Nk/49nUCDZWYrCItXq7p6I=;
        b=Ajp9kIfpXYsvvy4xhvuUQtK3Yw+pvTrlM7HNp0j64PGFQIWleqXKIR/k2RzCJriyFV
         5ieSH2oKY5hIvZGBl18Hb7TuFkot4JmcQvY9PhObteYY0Vw8bQYOpJjyeQNcfu299n4k
         Sg+31xgzKtMadR38tXuUSQybaP5wFOqKk0XYmZLypdXWRSG09oVVVYS9pmrCR57Tau2L
         f6pLzoEyzNiinnDbKkLtdskcYZFiwhIEC5mZ9VVayBf+ZyixiUdGGVKAEBFVtsscsAEg
         NogpvWvh2TYppgav1urj7rLDP93z34JPLrlf//hL3k7wMw4us66PM85Ans8uk2dCod8c
         sMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732730004; x=1733334804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBUdGR4bmi6T+Je5/dBA8Nk/49nUCDZWYrCItXq7p6I=;
        b=gk59SV2V7b+9Ka9VeBaQ7xTTS/88KYuImaI8qUwj0q0xXEMf5ZZuORIWn/ThJJ+11W
         r9Q0/4FGfeE5aEzTbX+VKxg2Vwdc0DrJH06ogMuwqAUhcfOOv178GzkSdLnXM/3eX8yz
         skh2dxwp1Z2OYPrHdbHLXKkdyQ4Hjqy3STSRSU9r5raMluSMa7fAiruAVfvnbI5y1UlN
         JgwYJePAFmKrh5FzDCTZ9kw6g9Q6ylVslgbqE3meMRDciwSg59ccQpyMzeH9djU1XhmL
         Xmz+PgX84ADvEBjeXOR11oHGsZJgPa6fkRDe6xdycqAZpSJu+LEC31HPHRJQZToT/xI2
         CcRA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5YHomeHR61qimPdUkn933fxE4BwZiZT6Kx7e2Fs8C2ESaIIHLNPdc1DSC85/6LkgFQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFqCID9Hiz+I8vfm8FfVx1VBhVLmTY4GpC15Qt20EnNxXcT9u
	i1ilyt9PH/IDOqZwCrL/lLqPPq8KAMIugZnDfsHgbUQ9cBMGMJt0
X-Gm-Gg: ASbGncskgvhBq30SJlvSXVaW/JPPnj94c8m4QT/N+F0E8MJ032+w1edSMUTELORlhwe
	k0+aBs+VfNCxct9eoFGWCEC0a6wzLU/cPF72lej647LqjeBBysd5/heX5HiK5Uyp++Gsp10DD3w
	3vhxUPsMmY40JVZGfB2+UnbWvzAlcsOPr/trquazSGgpw7zAHb3lObm4IyAU0TBDr9fFsR3WtpM
	X65Qzv+PCWpVwH4977geX9bP/LvumqF1OfyqHRRFaNEn7U=
X-Google-Smtp-Source: AGHT+IGVpMYf42rxDToo+RhGVI2wjIYMmSYIwIYkYRHbgawZpwcFFi1sexXLGL7A0g0CSPiHtpDhhA==
X-Received: by 2002:a05:6a20:244c:b0:1db:ebbf:4b8a with SMTP id adf61e73a8af0-1e0e0aa902bmr5687874637.7.1732730004384;
        Wed, 27 Nov 2024 09:53:24 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724eaa8c1easm9845787b3a.141.2024.11.27.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:53:23 -0800 (PST)
Message-ID: <66720931d0e98065804320142139e963c6de6c37.camel@gmail.com>
Subject: Re: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section
 endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Olsa
 <olsajiri@gmail.com>
Cc: dwarves@vger.kernel.org, arnaldo.melo@gmail.com, bpf@vger.kernel.org, 
	kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	yonghong.song@linux.dev, Alan Maguire
 <alan.maguire@oracle.com>, Daniel Xu	 <dxu@dxuuu.xyz>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Date: Wed, 27 Nov 2024 09:53:18 -0800
In-Reply-To: <6187706f-5c7f-4c22-9854-b3225b841385@linux.dev>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
	 <20241127015006.2013050-2-eddyz87@gmail.com> <Z0b7zLfaoodeWF6J@krava>
	 <6187706f-5c7f-4c22-9854-b3225b841385@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 12:03 +0000, Vadim Fedorenko wrote:

[...]

> > looks good, I'm just curious about one thing..
> >=20
> > so ELF_T_WORD enum has this comment: /* Elf32_Word, Elf64_Word, ... */
> >=20
> > I did just quick check, ***so I might be easily wrong***, but I wonder =
the
> > code in __elf_xfctstom (which I assume is the one called for conversion=
)
> > chooses to swap 32/64 bits values based on elf->class .. so for 64bit E=
LF
> > class we swap 64bit values? ... while .BTF_ids has always 32 bit values
>=20
> Well according to the doc:
>=20
>         ELF_T_WORD     Unsigned 32-bit words.
>         ELF_T_XWORD    Unsigned 64-bit words.
>=20
> It shouldn't use 64 bits swap:
>=20
> const xfct_t __elf_xfctstom[EV_NUM - 1][EV_NUM - 1][ELFCLASSNUM -=20
> 1][ELF_T_NUM] =3D
> ....
> 	[ELF_T_WORD]	=3D ElfW2(Bits, cvt_Word),		=09
> 	[ELF_T_XWORD]	=3D ElfW2(Bits, cvt_Xword),		=09
> ...
>=20
> Are you looking somewhere else?

Right, thank you, Vadim.

[...]


