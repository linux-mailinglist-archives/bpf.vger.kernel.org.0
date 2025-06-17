Return-Path: <bpf+bounces-60782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4BADBDE9
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E907A7D63
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE04749C;
	Tue, 17 Jun 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO258oFN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F91862
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118707; cv=none; b=itzsJsazBWxmbwiMba2j1fGdNlVVZ/oEGWPISZmr4a06noA90jYsJXcrAoPKPMVGNXUBvo8gROd5fajuGGQidZ/K13FVnftv2sSMUDNitGJiF1qSgHfNyoLgqsQTZRcR6x+0zLnGMzl8fTU86uXAprF6oQaUzWPr1mz2CH+Ng7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118707; c=relaxed/simple;
	bh=mXeRxE4mNKkb2mbB2IETi4Z4PPYEcmCGyzcdrGEoiWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXJcwrCU+19/NCD9D2TYBIs5e+bHOKG+OvO+rJmhuodOA4cXIXsxNuNdx/dgvPrkMd19cq+gOqL4kdqGmE+FVSGZbGTLs8DXPCuEtuB1sNvdsZbnFe+tdGwcqmgUcdJ8OQX5JD8gQ0JXiFMGaHReXodY+JPXp0dQUVoo6mN1qPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO258oFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3340AC4CEEA
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 00:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750118707;
	bh=mXeRxE4mNKkb2mbB2IETi4Z4PPYEcmCGyzcdrGEoiWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fO258oFNW3Qt9qmfdL29Ax/p//NPM4I8z7tNya0TlDATgaf0CX6GJ3hRycckc43bH
	 kdASmcwbO/WInflp9qiL3JB/CjZMzSbDWxRsWJ8L5LxC1v3qQzT0g4EiVqgToegJb8
	 7FUaqnzQxS6CMZZ98yGLQSFynamfv9MiUQQOE5MsiaVd2VdXfxpU1SEwAcUsoEn5R7
	 QW81iG4XvUNgkKdZFf1vf01P/m4HthdFx3eYYHbE6m0nTn7j19uu71MstfivjrLYgq
	 +gJzju0l7Wr+Y4I7MSuLf6yAQNCKyc/mkzmlitXsbCGvti4pmn+74+a5SAreJRl0sE
	 CE1aNephdeW2w==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so10816266a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 17:05:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/bZ6c05O+mWFHrAsZJ6IKRlZSDhpLDhRId63TymrzbNw8xihz
	M3Cq4dTXkG8krZOG6PrsoHy2+1Sfpp6VUo4JFUXVZkmsMMslcCeJfHA1Z2Rm83k22/F31Yd4gYd
	ONrJJTCBigQPIC1G95s6QV6RgrvWP2dOZwYTzKkG5
X-Google-Smtp-Source: AGHT+IFwyMlRsWMMOKi2pk5SCfeoUUEP8ljPneEYIp/jKlMgC3WGTP+bhK1z4QTezR16kNA45NimK4eHZvFHlePinnY=
X-Received: by 2002:a05:6402:3510:b0:606:b4de:f72c with SMTP id
 4fb4d7f45d1cf-608d00a2284mr10376391a12.0.1750118705755; Mon, 16 Jun 2025
 17:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-2-kpsingh@kernel.org>
 <20250612190739.GC1283@sol> <CACYkzJ5NbpTjwtWKx6ehqy7wyENovcFQVQqjO0-m9XoAJP=-nw@mail.gmail.com>
 <20250616234857.GC23807@google.com>
In-Reply-To: <20250616234857.GC23807@google.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 17 Jun 2025 02:04:55 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6iHaZBuFiio=D2UZ1k=V2WwpyTVENKyPWKHXa5TwJ-Tg@mail.gmail.com>
X-Gm-Features: AX0GCFuOabgyDuZYIq3akoSA2CTYDCw1HjWxiwIBR9v3x0Md5VapURLDMhJejmE
Message-ID: <CACYkzJ6iHaZBuFiio=D2UZ1k=V2WwpyTVENKyPWKHXa5TwJ-Tg@mail.gmail.com>
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256 hashing
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:49=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 17, 2025 at 01:40:22AM +0200, KP Singh wrote:
> > On Thu, Jun 12, 2025 at 9:08=E2=80=AFPM Eric Biggers <ebiggers@kernel.o=
rg> wrote:
> > >
> > [...]
> > >
> > > You're looking for sha256() from <crypto/sha2.h>.  Just use that inst=
ead.
> >
> > I did look at it but my understanding is that it will always use the
> > non-accelerated version and in theory the program can be megabytes in
> > size, so might be worth using the accelerated crypto API. What do you
> > think?
> >
>
> I fixed that in 6.16.  sha256() gives you the accelerated version now.

This is awesome, I will drop this patch.

- KP

>
> - Eric

