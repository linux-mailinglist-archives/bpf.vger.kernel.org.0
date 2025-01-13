Return-Path: <bpf+bounces-48708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F62A0BF5A
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 18:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32618163A6D
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315271C3BE1;
	Mon, 13 Jan 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+MgmMYJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D1E1C07ED
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790867; cv=none; b=pA0XSqab/Z+X/8/obrv+q7i5Hl2/fAQguH+RLvK0p43nm/Rdibvqcz8FmfDkpQ2K9gKO3hw25jVBoYlfbrMruDGCQfDqq+Jv+tLvy0KZEfUktwQcSjkAwO3XMmT8oOIiyzm/J27bHkeT8u88HrLyRkaVxOpfGxIbhH7IJAUvmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790867; c=relaxed/simple;
	bh=ZR1H3FVvLylxKFUPMqD5IFqZ24kqWlC9szB1isKyrdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxs24SVdTUMQRROXNfxpx1H8d+U7y0rvjpTQRVeIlEb+avFsGsF9OxUi7iONbpFmnOs7kc97IV94x1KUgszwHNgwUxmG5gU4ML5H6UOcetGBzpYEpIljKuIKXkzG8FGfN/weWns+1jmY1iGbXEQVtmn/JDbW9Z/i2DeE70HPGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+MgmMYJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-386329da1d9so2420141f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736790864; x=1737395664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR1H3FVvLylxKFUPMqD5IFqZ24kqWlC9szB1isKyrdo=;
        b=Z+MgmMYJG391Bl/NaAqMUVKW6wpkxJLJ60px8pcSyvwZuAo7hxC8qd1tbll0nR8Vtd
         dPGVfxbQm8FxyvOO3FET+BkAG7r+F7JV2h2V3cY6knWPlDY8I2iRKdVdSMuAG9PWPObd
         8WgN3zwbFfq3OkJwFIy0pCEmdPuUD3GPQ/P3STbnB12c5DTjAnSYqt5fIbCp65qRcXEY
         EQpteahAnnCsxODUCx0HALpiBiHwhwt4a/Fv4VKbx8Q/FVFHdrP9C3CkYir3EDoaVtig
         bhQUky3AlkNpW6HxMpD4QGbLzOMLLFXYlE7Cw1IeGwzOgLZP7DFK/8b72ceKTgVQbGj/
         2pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736790864; x=1737395664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZR1H3FVvLylxKFUPMqD5IFqZ24kqWlC9szB1isKyrdo=;
        b=edk/mG6FWYHIScUFesAmuzAyRC2BlWyb4wqZj0Phv04uhIRgJuF3cfdFupzJzHo8t6
         Lt7DUCXEzU9YY4MC2K4bux3FCuokud6yAHfGfDjBNpWDcRcuZDKyYo0G4ae+OUM8ZIsU
         trdyON/5onnNiTvY4ynS3F0qP8omMygk5rXO2r7BSa5PlwS7JbpPVRT2ieHbxSOauP2w
         nWLgf1ONvJx7u1MoCEQYwkHmes1IkktPtJmzJ6iAlbOVxXXCZayb5fKGar2sHLvG+AdR
         V1xLU1GIT3z83edqEOLaQxgXKhTgbwvawG8TVbEwLpHtt/LXbjHzs0e3OO61yOIN7F02
         3NoQ==
X-Gm-Message-State: AOJu0YxaRQLijIRKPg0TdoqoQFBu7eX83B+fAWRxcK2QuzGZGWDF38GM
	LseXw5Mkk/1KZ6OzoRnp5FLnpnEaSdp2uDWbYaAODQXqkmRk/00VBzhC/8VGHOg7FdrQw6T1nVi
	LnScdhf8U1q0pCIQK6wKekPvWz1w=
X-Gm-Gg: ASbGncuAKC/d4GwTIarL7y6uZ992SYRs67CqDeksEH8reGW0q1fy+EjaqSIO/rFAxto
	5AKcwn/q2jqglecog04GURZ1MVlaQrozpF1/R77MGmgA4hPXqsU4cbg==
X-Google-Smtp-Source: AGHT+IHbmAjj/hL+O10Bi62kDdj3bXN60tGSwzX4ZjBTYtSykt1864nSJjYCHbM5HInekGu4u6NfqI4e0b/fFHo4UaM=
X-Received: by 2002:a05:6000:2ce:b0:38a:6807:f86 with SMTP id
 ffacd0b85a97d-38a872da793mr18159978f8f.17.1736790863997; Mon, 13 Jan 2025
 09:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com> <87ikqm45da.fsf@microsoft.com>
In-Reply-To: <87ikqm45da.fsf@microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Jan 2025 09:54:13 -0800
X-Gm-Features: AbW1kvY2N2lDBotCjjAeL_uOwWyCkEtsday_o0mo8SZiBmsxlnE5_szClbxOczI
Message-ID: <CAADnVQLYeV8-nJ-=_4p8U=xax99-i5QavJrQ=hnKS0EK1ZjecA@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore <paul@paul-moore.com>, code@tyhicks.com, 
	Francis Laniel <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:27=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Thu, Jan 9, 2025 at 1:47=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >>
> >> This is a proof-of-concept, based off of bpf-next-6.13. The
> >> implementation will need additional work. The goal of this prototype w=
as
> >> to be able load raw elf object files directly into the kernel and have
> >> the kernel perform all the necessary instruction rewriting and
> >> relocation calculations. Having a file descriptor tied to a bpf progra=
m
> >> allowed us to have tighter integration with the existing LSM
> >> infrastructure. Additionally, it opens the door for signature and prov=
enance
> >> checking, along with loading programs without a functioning userspace.
> >>
> >> The main goal of this RFC is to get some feedback on the overall
> >> approach and feasibility of this design.
> >
> > It's not feasible.
> >
> > libbpf.a is mainly a loader of bpf ELF files.
> > There is a specific format of ELF files, a convention on section names,
> > a protocol between LLVM and libbpf, etc.
> > These things are stable api from libbpf 1.x pov.
> > There is a chance that they will change in libbpf 2.x.
> > There are no plans to do so now, but because it's all user space
> > there is room for changes.
> > The kernel doesn't have such luxury.
> > Hence we cannot copy paste libbpf into the kernel and make
> > it parse the same ELF data, since it will force us to support
> > this exact format forever.
> > Hence the design is not feasible.
> >
>
> Noted.
>
> > This was discussed multiple times on the list and at LSFMMBPF, LPC
> > conferences over the years.
> >
> > But if the real goal of these patches to:
> >
> >> open the door for signature and provenance
> >> checking, along with loading programs without a functioning userspace.
> >
> > then please take a look at the light skeleton.
> > There is an existing mechanism to load bpf ELF files without libbpf
> > and without user space.
> > Search for 'bpftool gen skeleton -L'.
>
> Our goal is to have verifiable ebpf programs that are portable across
> multiple kernels. I looked into light skels, it appears that all the
> instruction relocations are calculated during skeleton generation and a
> static instruction buffer containing those fixed relocation results is
> passed into the kernel? For some relocs, those values would be
> deterministic, making that a non-issue. For others that rely on btf data
> or kernel symbols those might not be portable anymore.

Specifically?
lskel preservers CORE. BTF based relocations are done by the kernel.

> Would it be amenable to possibly alter the light skeleton generation
> code to pass btf and some other metadata into the kernel along with
> instructions or are you trying to avoid any sort of fixed dependencies
> on anything in the kernel other than the bpf instrucion set itself?

BTF is passed in the lskel.
There are few relocation-like things that lskel doesn't support.
One example is __kconfig, but so far there was no request to support that.
This can be added when needs arise.

