Return-Path: <bpf+bounces-38107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E995FC69
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B67B1C22807
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BA19CD0F;
	Mon, 26 Aug 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5BBMBIE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CD129E93;
	Mon, 26 Aug 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710049; cv=none; b=UqWlkRpb88N8ul6OFeR8T0QEpR35NqZULa9EEqM9hLrnN0+uAFTtYxl0633stk6xAZXXKgW9aPSZ6rUUvaa0HcVyNsk6eoRsGveoLoKhyEcMaFcJIymn7v+rsd8+VCZHLbnEusrtq7NJ4fMMRdUAijofSquuLFsnFRbM6w93pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710049; c=relaxed/simple;
	bh=Q9zqWUSu8fGZ8hrDi4+mX345YfY20cBYd1UNmIScO7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsAM8O4lh3JJFNIq95JR+8mu3fJd3Bzp63Dzx3zcKLxmbHp71DCGOWAocVJvD51PkVG4gOcd8YrewiNFhfOoRfWNhzF1vmbcfQZd6PJPXDN+Fz4Sy7CM/wQf9ksytLclBordVxsdO9FAK4OgJgbHP9fetkW5dqfGeFTDir+U/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5BBMBIE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3bd8784d3so3779823a91.3;
        Mon, 26 Aug 2024 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724710046; x=1725314846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6wBuMGBO6IYcxN3bymUocORY6Sf95mnXr/c1cVLnvE=;
        b=h5BBMBIEfdNBTUy4pTRCCHL8GEt8EE0zTYh0dl3BI0cM8LXm3scRNSlP3fgXy1hNld
         iYJ7oxQKK84h/O54X3bsCQQxhamwLudB9+kdmYw1jfgw9Dpe3X1LadZIvG362NrDFrkO
         gA4TZ1pzZK0JRah4ySOAHs5Fcv4ah9TUdDTf+ULYFAkKtxRz90DiFsAHqi9TZVr6fTGk
         mknWCDDHWl6tju3T9ZBfOSjW4LNg8/HHN0y1v3iHOj2hkU3GBzvu3ND0waZEa3xffmYI
         IaVYg/Ba2Q3j3fTfiJmqoOPk/o+q0JT6xfaHYoRu+TuWK7P8Me6EUJ0tSWwy4cbtzGHa
         Nzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724710046; x=1725314846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6wBuMGBO6IYcxN3bymUocORY6Sf95mnXr/c1cVLnvE=;
        b=NWpm6LShfNDUKlPbSaSAHbyNMfk0PknKMQZGCTx2XtEMFmlXC4R6ThncbvEM//FoEb
         LJy9076DEnjksaWZka9JVaivxm3/4etNIFkku+Yf5BdiE79sg/FcS0Fa6gRGiJQpDD4+
         PQa3ntpVcZzN3jUv3d1pyscFJmT8DT4DgzBHzmzvg8eLLrZKPXHrc4/tJI0NrWf+nQvc
         AnfESl6GYTNr9WVUFXhVxpp4pPtas1h1uqFxCu7DpccCNaRSdqwRh8sutr8ZDtj9f13T
         CQWPGg5Pw72u4i87/lbn3DeR2gP4sGJMw/c+ZG/zQ4dMsZbZbvmmyOVakLnd0GyZjRyi
         20SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUssi/PegJb4h4CFpcuo143CZiJ1ADNAmOfL1IXyvdTo+BKxlt+1JBxJxdVNpdMG4zTXzQYfOEnrQ==@vger.kernel.org, AJvYcCUxPFbcJca6LQ2WMIospkUVnuuKGX/WjJmFCw0H4GOT9I/NiX/jCumpYwWWx21jbPrzCoYM4lDtUhBuiLSX@vger.kernel.org, AJvYcCVOtheuXI8bWOkn30hy7qYK+MmcnljCYvU1RZQCJC2cdrIAQNQwQ770A8soGUrtxqITaclKTcI/xPuUG5Mx@vger.kernel.org, AJvYcCWvALwIQCZlTYzOqnCZC65PaGdI1yQigoWuXhIBxKPGS22XqVkBCRIdPsIxCBwqiIjm6iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPFs+aCJBt7etkmKVNKo5gv2thN+eFQaG+mSo8xb9JqscY9lb
	S9OZUH1AvP949P+SAKzoZC58P9oqBDVmHsC6dCK5FDUFLrm45SnAyYjQoXa8D7BEiVMwPTuLx37
	bkiuyfQEti0s2OCARAcN4HxxDuDI=
X-Google-Smtp-Source: AGHT+IFRGb2W+WsX2UKq4Wk1GLY6uzmcfAn//NcsablcDQq4KUNIB4ejPvdqknItx6x3QLaJ8Xhm9Yg8LYPhTLP2AGY=
X-Received: by 2002:a17:90b:3785:b0:2d3:ce96:eb62 with SMTP id
 98e67ed59e1d1-2d646d6fb73mr13331785a91.38.1724710045979; Mon, 26 Aug 2024
 15:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZsSpU5DqT3sRDzZy@krava> <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org> <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1> <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
 <Zsy1blxRL9VV9DRg@x1> <CA+icZUWMxzAFtr8vsUUQ9OCR68K=F6d6MANx8HMTQntq494roA@mail.gmail.com>
 <20240826184818.GC117125@pauld.westford.csb> <Zszf0_5DKuscmDWi@x1>
In-Reply-To: <Zszf0_5DKuscmDWi@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 15:07:14 -0700
Message-ID: <CAEf4Bza2oR1VLyGLyWRBbMbB00DQDFTCHNU_WT+0ktoWPk1Edw@mail.gmail.com>
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, Sedat Dilek <sedat.dilek@gmail.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org, 
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com, 
	usamaarif642@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:04=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 26, 2024 at 02:48:18PM -0400, Phil Auld wrote:
> > On Mon, Aug 26, 2024 at 08:42:10PM +0200 Sedat Dilek wrote:
> > > On Mon, Aug 26, 2024 at 7:03=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> > > > > On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > > > > > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > > > > > I stumbled on this limitation as well when trying to build the =
kernel on
> > > > > > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I=
 just
> > > > > > created a swapfile and it managed to proceed, a bit slowly, but=
 worked
> > > > > > as well.
> > > > >
> > > > > Here, it hits the VM space limit (3 G).
> > > >
> > > > right, in my case it was on a 64-bit system, so just not enough mem=
ory,
> > > > not address space.
> > > >
> > > > > > Please let me know if what is in the 'next' branch of:
> > > >
> > > > > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > > >
> > > > > > Works for you, that will be extra motivation to move it to the =
master
> > > > > > branch and cut 1.28.
> > > >
> > > > > on 64bit (-j1):
> > > > > * master: 3.706 GB
> > > > > (* master + my changes: 3.559 GB)
> > > > > * next: 3.157 GB
> > > >
> > > > > on 32bit:
> > > > >  * master-j1: 2.445 GB
> > > > >  * master-j16: 2.608 GB
> > > > >  * master-j32: 2.811 GB
> > > > >  * next-j1: 2.256 GB
> > > > >  * next-j16: 2.401 GB
> > > > >  * next-j32: 2.613 GB
> > > > >
> > > > > It's definitely better. So I think it could work now, if the thre=
ad count
> > > > > was limited to 1 on 32bit. As building with -j10, -j20 randomly f=
ails on
> > > > > random machines (32bit processes only of course). Unlike -j1.
> > > >
> > > > Cool, I just merged a patch from Alan Maguire that should help with=
 the
> > > > parallel case, would be able to test it? It is in the 'next' branch=
:
> > > >
> > > > =E2=AC=A2[acme@toolbox pahole]$ git log --oneline -5
> > > > f37212d1611673a2 (HEAD -> master) pahole: Teduce memory usage by sm=
arter deleting of CUs
> > > >
> > >
> > > *R*edzce? memory usage ...
> > >
> >
> > If you meant that further typo it's golden, and if not the irony is ric=
h :)
> >
> > Either way this is my favorite email of the day!
>
> Hahaha, I went to uppercase what comes after the colon and introduced
> that typo ;-)
>
> Faxing it....

typo-fest continues ;)

but it's great to see that a new pahole release is coming (cc'ing
Usama), we are eagerly waiting for one of the bug fixes that will go
into 1.28 (one of the first commits after 1.27 was cut). Note, libbpf
CI's for pahole-staging is failing, but that seems a one-off test and
has nothing to do with pahole being broken.

>
> - Arnaldo
>

